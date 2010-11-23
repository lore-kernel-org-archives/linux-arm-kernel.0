From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 23 Nov 2010 10:06:05 +0000
Subject: [RFC PATCH 04/13] picoxcell: add a pin muxing infrastructure
In-Reply-To: <1290506774-17895-1-git-send-email-jamie@jamieiles.com>
References: <1290506774-17895-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1290506774-17895-5-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

picoXcell devices have two types of GPIO pins - ARM and SDGPIO (the
latter are in the picoArray domain) and some of these pins are also
shared with peripherals. Provide an API for configuring the multiplexing
of each pin and a userspace sysfs interface so they can be reprogrammed
at runtime. Some of the peripherals that use the pins are driven by the
DSP array and so the kernel won't know how to configure these pins so
this is left to the userspace application.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-picoxcell/Makefile         |    3 +-
 arch/arm/mach-picoxcell/mux.c            |  302 ++++++++++++++++++++++++++++++
 arch/arm/mach-picoxcell/mux.h            |   97 ++++++++++
 arch/arm/mach-picoxcell/picoxcell_core.c |    3 +
 4 files changed, 404 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-picoxcell/Makefile b/arch/arm/mach-picoxcell/Makefile
index 726c61f..5e9a7cd 100644
--- a/arch/arm/mach-picoxcell/Makefile
+++ b/arch/arm/mach-picoxcell/Makefile
@@ -1,2 +1,3 @@
 obj-y				:= picoxcell_core.o axi2cfg.o \
-				   time.o
\ No newline at end of file
+				   time.o \
+				   mux.o
diff --git a/arch/arm/mach-picoxcell/mux.c b/arch/arm/mach-picoxcell/mux.c
new file mode 100644
index 0000000..a0b1890
--- /dev/null
+++ b/arch/arm/mach-picoxcell/mux.c
@@ -0,0 +1,302 @@
+/*
+ * Copyright (c) 2010 Picochip Ltd., Jamie Iles
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * All enquiries to support at picochip.com
+ */
+#define pr_fmt(fmt) "picoxcell_mux: " fmt
+
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <linux/sysdev.h>
+
+#include "mux.h"
+
+static inline struct muxed_pin *
+to_multiplexed_pin(struct sysdev_attribute *attr)
+{
+	return container_of(attr, struct muxed_pin, attr);
+}
+
+static struct {
+	unsigned	    num_groups;
+	struct pin_group    **groups;
+	int		    (*sdgpio_number)(int pin);
+	int		    (*armgpio_number)(int pin);
+} mux_info;
+
+void picoxcell_mux_register(struct pin_group **groups, int nr_groups,
+			    int (*armgpio_number)(int pin),
+			    int (*sdgpio_number)(int pin))
+{
+	BUG_ON(!groups || !armgpio_number || !sdgpio_number);
+	mux_info.num_groups	= nr_groups;
+	mux_info.groups		= groups;
+	mux_info.armgpio_number = armgpio_number;
+	mux_info.sdgpio_number	= sdgpio_number;
+}
+
+int picoxcell_pin_set_mux(int pin_nr, enum mux_setting setting)
+{
+	unsigned i, j;
+	int ret = 0;
+
+	/*
+	 * Don't let users try and trick us - they can't change the hardware
+	 * that much!
+	 */
+	if (MUX_UNMUXED == setting)
+		return -EINVAL;
+
+	for (i = 0; i < mux_info.num_groups; ++i) {
+		struct pin_group *group = mux_info.groups[i];
+		for (j = 0; j < group->nr_pins; ++j) {
+			struct muxed_pin *pin = &group->pins[j];
+			/*
+			 * Dedicated GPIO pins aren't shared with a
+			 * peripheral. This is illegal!
+			 */
+			if (pin->is_dedicated_gpio && MUX_PERIPHERAL == setting)
+				return -EINVAL;
+			if (pin_nr == pin->arm_pin || pin_nr == pin->sd_pin) {
+				ret = pin->set_mux(pin, setting);
+				if (!ret)
+					goto out;
+				/*
+				 * If we failed to set the muxing of this pin,
+				 * carry on looping as we have some
+				 * many-to-many pins so we might pick it up
+				 * again on another output.
+				 */
+			}
+		}
+	}
+
+	/*
+	 * If we don't have a multiplexed pin entry for the requested pin then
+	 * we assume that the pin isn't multiplexed so we don't need to do
+	 * anything.
+	 */
+out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(picoxcell_pin_set_mux);
+
+int picoxcell_group_set_mux(const char *group_name, enum mux_setting setting)
+{
+	unsigned i, j;
+	int err = -ENXIO;
+
+	/*
+	 * Don't let users try and trick us - they can't change the hardware
+	 * that much!
+	 */
+	if (MUX_UNMUXED == setting)
+		return -EINVAL;
+
+	for (i = 0; i < mux_info.num_groups; ++i) {
+		struct pin_group *group = mux_info.groups[i];
+		if (strcmp(group->name, group_name))
+			continue;
+
+		for (j = 0; j < group->nr_pins; ++j) {
+			struct muxed_pin *pin = &group->pins[j];
+			/*
+			 * Dedicated GPIO pins aren't shared with a
+			 * peripheral. This is illegal!
+			 */
+			if (pin->is_dedicated_gpio && MUX_PERIPHERAL == setting)
+				return -EINVAL;
+			err = pin->set_mux(pin, setting);
+			if (err)
+				goto out;
+		}
+
+		break;
+	}
+
+out:
+	return err;
+}
+EXPORT_SYMBOL_GPL(picoxcell_group_set_mux);
+
+int picoxcell_get_pin_mux(int pin_nr)
+{
+	unsigned i, j;
+	int ret = 0;
+
+	for (i = 0; i < mux_info.num_groups; ++i) {
+		struct pin_group *group = mux_info.groups[i];
+		for (j = 0; j < group->nr_pins; ++j) {
+			struct muxed_pin *pin = &group->pins[j];
+			if (pin_nr == pin->arm_pin || pin_nr == pin->sd_pin) {
+				int tmp = pin->get_mux(pin);
+				if (tmp < 0)
+					return tmp;
+				ret |= tmp;
+			}
+		}
+	}
+
+	/*
+	 * If we don't have a multiplexed pin entry for the requested pin then
+	 * we assume that the pin isn't multiplexed.
+	 */
+	return ret ? ret : MUX_UNMUXED;
+}
+EXPORT_SYMBOL_GPL(picoxcell_get_pin_mux);
+
+static const char *group_name(struct muxed_pin *pin)
+{
+	int i, j;
+
+	for (i = 0; i < mux_info.num_groups; ++i) {
+		struct pin_group *group = mux_info.groups[i];
+		for (j = 0; j < group->nr_pins; ++j)
+			if (pin == &group->pins[j])
+				return group->name;
+	}
+
+	return "<unknown>";
+}
+
+static const char *pin_setting_name(struct muxed_pin *pin)
+{
+	const char *ret;
+
+	if (MUX_SD == pin->get_mux(pin))
+		ret = "sdgpio";
+	else if (MUX_ARM == pin->get_mux(pin))
+		ret = "armgpio";
+	else if (MUX_PERIPHERAL == pin->get_mux(pin))
+		ret = "peripheral";
+	else
+		ret = "<invalid>";
+
+	return ret;
+}
+
+ssize_t pin_show(struct sys_device *dev, struct sysdev_attribute *attr,
+		 char *buf)
+{
+	struct muxed_pin *pin = to_multiplexed_pin(attr);
+	const char *setting = pin_setting_name(pin);
+	ssize_t ret = snprintf(buf, PAGE_SIZE, "%s\n", setting);
+
+	return ret;
+}
+
+ssize_t pin_store(struct sys_device *dev, struct sysdev_attribute *attr,
+		  const char *buf, size_t len)
+{
+	ssize_t ret = -EINVAL;
+	struct muxed_pin *pin = to_multiplexed_pin(attr);
+
+	if (sysfs_streq(buf, "sdgpio"))
+		ret = pin->set_mux(pin, MUX_SD);
+	else if (sysfs_streq(buf, "armgpio"))
+		ret = pin->set_mux(pin, MUX_ARM);
+	else if (sysfs_streq(buf, "peripheral") ||
+		 sysfs_streq(buf, group_name(pin)))
+		ret = pin->set_mux(pin, MUX_PERIPHERAL);
+
+	return ret ?: len;
+}
+
+static struct sysdev_class muxing_class = {
+	.name		= "io_muxing",
+};
+
+static struct sys_device muxing_device = {
+	.id		= 0,
+	.cls		= &muxing_class,
+};
+
+static void __init muxing_sysfs_init(void)
+{
+	int i, j, err = sysdev_class_register(&muxing_class);
+
+	if (err) {
+		pr_err("unable to register sysdev class (%d)\n", err);
+		return;
+	}
+
+	err = sysdev_register(&muxing_device);
+	if (err) {
+		pr_err("unable to register sysdev device (%d)\n", err);
+		return;
+	}
+
+	for (i = 0; i < mux_info.num_groups; ++i) {
+		struct pin_group *group = mux_info.groups[i];
+		for (j = 0; j < group->nr_pins; ++j) {
+			struct muxed_pin *pin = &group->pins[j];
+			err = sysdev_create_file(&muxing_device, &pin->attr);
+			if (err) {
+				pr_err("unable to create attr for %s\n",
+				       pin->name);
+				return;
+			}
+		}
+	}
+}
+
+static ssize_t io_muxing_show(struct seq_file *s, void *priv)
+{
+	unsigned i, j;
+	ssize_t ret = 0;
+
+	ret += seq_printf(s, "%16s%16s%16s%10s%10s\n\n", "group_name",
+			  "pin_name", "setting", "arm pin", "sd pin");
+	for (i = 0; i < mux_info.num_groups; ++i) {
+		struct pin_group *group = mux_info.groups[i];
+		for (j = 0; j < group->nr_pins; ++j) {
+			struct muxed_pin *pin = &group->pins[j];
+			ret += seq_printf(s, "%16s%16s%16s%10d%10d\n",
+					  group->name, pin->name,
+					  pin_setting_name(pin),
+					  mux_info.armgpio_number(pin->arm_pin),
+					  mux_info.sdgpio_number(pin->sd_pin));
+		}
+	}
+
+	return ret;
+}
+
+static int io_muxing_debugfs_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, io_muxing_show, inode->i_private);
+}
+
+static const struct file_operations io_muxing_debugfs_fops = {
+	.owner		= THIS_MODULE,
+	.open		= io_muxing_debugfs_open,
+	.llseek		= seq_lseek,
+	.read		= seq_read,
+	.release	= single_release,
+};
+
+static void __init picoxcell_muxing_debugfs_init(void)
+{
+	/* We only get called if debugfs is enabled and configured. */
+	struct dentry *mux_debugfs_file =
+		debugfs_create_file("io_muxing", 0444, arch_debugfs_dir, NULL,
+				    &io_muxing_debugfs_fops);
+	if (IS_ERR(mux_debugfs_file)) {
+		pr_err("failed to create io_muxing debugfs entry (%ld)\n",
+		       PTR_ERR(mux_debugfs_file));
+	}
+}
+
+void __init picoxcell_muxing_init(struct picoxcell_soc *soc)
+{
+	if (soc->init_muxing)
+		soc->init_muxing();
+
+	muxing_sysfs_init();
+
+	picoxcell_muxing_debugfs_init();
+}
diff --git a/arch/arm/mach-picoxcell/mux.h b/arch/arm/mach-picoxcell/mux.h
new file mode 100644
index 0000000..54933e6
--- /dev/null
+++ b/arch/arm/mach-picoxcell/mux.h
@@ -0,0 +1,97 @@
+/*
+ * linux/arch/arm/mach-picoxcell/mux.h
+ *
+ * Copyright (c) 2010 Picochip Ltd., Jamie Iles
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * All enquiries to support at picochip.com
+ */
+#ifndef __MUX_H__
+#define __MUX_H__
+
+#include <linux/sysdev.h>
+
+#include "soc.h"
+
+/*
+ * Pins can typically be:
+ *	- a system function such as EBI, SSI etc,
+ *	- ARM controlled GPIO.
+ *	- picoArray controlled GPIO.
+ *	- not multiplexed at all (MUX_UNMUXED).
+ */
+enum mux_setting {
+	MUX_PERIPHERAL	= (1 << 0),
+	MUX_ARM		= (1 << 1),
+	MUX_SD		= (1 << 2),
+	MUX_UNMUXED	= (1 << 3),
+};
+
+/*
+ * A multiplexed pin. This defines the SD and ARM pins that are on the pad. If
+ * the pin does not have an SD or ARM pin then set the appropriate field to
+ * -1.
+ */
+struct muxed_pin {
+	const char		*name;
+	int			is_dedicated_gpio;
+	int			sd_pin;
+	int			arm_pin;
+	int			(*set_mux)(struct muxed_pin *pin,
+					   enum mux_setting setting);
+	int			(*get_mux)(struct muxed_pin *pin);
+	struct sysdev_attribute	attr;
+};
+
+/*
+ * A logical group of multiplexed pins. Typically this is grouped by what the
+ * pins are multiplexed with e.g. system peripheral.
+ */
+struct pin_group {
+	int		    nr_pins;
+	const char	    *name;
+	struct muxed_pin    *pins;
+};
+
+extern int picoxcell_pin_set_mux(int pin_nr, enum mux_setting setting);
+extern int picoxcell_group_set_mux(const char *group_name,
+				   enum mux_setting setting);
+extern int picoxcell_get_pin_mux(int pin_nr);
+extern void picoxcell_mux_register(struct pin_group **groups, int nr_groups,
+				   int (*arm_number)(int pin),
+				   int (*sdgpio_number)(int pin));
+extern void __init picoxcell_muxing_init(struct picoxcell_soc *soc);
+
+extern ssize_t pin_show(struct sys_device *dev, struct sysdev_attribute *attr,
+			char *buf);
+extern ssize_t pin_store(struct sys_device *dev, struct sysdev_attribute *attr,
+			 const char *buf, size_t len);
+
+
+#define __PIN(_name, _sd, _arm, _set, _get, _dedicated) {		      \
+	.name		    = __stringify(_name),			      \
+	.is_dedicated_gpio  = _dedicated,				      \
+	.sd_pin		    = (_sd),					      \
+	.arm_pin	    = (_arm),					      \
+	.set_mux	    = _set,					      \
+	.get_mux	    = _get,					      \
+	.attr		    = _SYSDEV_ATTR(_name, 0644, pin_show, pin_store), \
+}
+
+/*
+ * Declare a function pin that is also multiplexed with GPIO pins.
+ */
+#define PIN(_name, _sd, _arm, _set, _get) \
+	__PIN(_name, _sd, _arm, _set, _get, 0)
+
+/*
+ * Declare a pure GPIO pin.
+ */
+#define GPIO(_name, _sd, _arm, _set, _get) \
+	__PIN(_name, _sd, _arm, _set, _get, 1)
+
+
+#endif /* __MUX_H__ */
diff --git a/arch/arm/mach-picoxcell/picoxcell_core.c b/arch/arm/mach-picoxcell/picoxcell_core.c
index 07eaa9b..8f2cc46 100644
--- a/arch/arm/mach-picoxcell/picoxcell_core.c
+++ b/arch/arm/mach-picoxcell/picoxcell_core.c
@@ -283,6 +283,9 @@ void __init picoxcell_core_init(void)
 	/* Add the arch debugfs entry. */
 	picoxcell_debugfs_init();
 
+	/* Initialise the pin muxing and gpio infrastructure. */
+	picoxcell_muxing_init(soc);
+
 	/* Add handlers for the AXI bus snooping. */
 	picoxcell_axi_bus_error_init();
 }
-- 
1.7.2.3
