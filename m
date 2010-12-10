From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 10 Dec 2010 16:28:15 +0000
Subject: [PATCH v3 04/14] picoxcell: add a pin muxing infrastructure
In-Reply-To: <1291998505-25891-1-git-send-email-jamie@jamieiles.com>
References: <1291998505-25891-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1291998505-25891-5-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

picoXcell devices have two types of GPIO pins - ARM and SDGPIO (the
latter are in the picoArray domain) and some of these pins are also
shared with peripherals. Provide an API for configuring the multiplexing
of each pin and a userspace sysfs interface so they can be reprogrammed
at runtime. Some of the peripherals that use the pins are driven by the
DSP array and so the kernel won't know how to configure these pins so
this is left to the userspace application.

v2:
	- Allow pins to have muxing set by name (to cope with multi
	  output GPIO's) and allow the peripheral to be specified.
	- Convert the debugfs entry to a seq_file to cope with larger
	  numbers of pins.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-picoxcell/Makefile         |    3 +-
 arch/arm/mach-picoxcell/mux.c            |  402 ++++++++++++++++++++++++++++++
 arch/arm/mach-picoxcell/mux.h            |  110 ++++++++
 arch/arm/mach-picoxcell/picoxcell_core.c |    3 +
 4 files changed, 517 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-picoxcell/mux.c
 create mode 100644 arch/arm/mach-picoxcell/mux.h

diff --git a/arch/arm/mach-picoxcell/Makefile b/arch/arm/mach-picoxcell/Makefile
index 493ec0e..77801b2 100644
--- a/arch/arm/mach-picoxcell/Makefile
+++ b/arch/arm/mach-picoxcell/Makefile
@@ -1,2 +1,3 @@
 obj-y				:= picoxcell_core.o io.o axi2cfg.o \
-				   time.o
+				   time.o \
+				   mux.o
diff --git a/arch/arm/mach-picoxcell/mux.c b/arch/arm/mach-picoxcell/mux.c
new file mode 100644
index 0000000..58e5ffb
--- /dev/null
+++ b/arch/arm/mach-picoxcell/mux.c
@@ -0,0 +1,402 @@
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
+#include <linux/string.h>
+
+#include "mux.h"
+
+static const char *mux_peripheral_names[NR_MUX_SETTINGS] = {
+	[MUX_ARM]		= "armgpio",
+	[MUX_SD]		= "sdgpio",
+	[MUX_UNMUXED]		= "unmuxed",
+	[MUX_PERIPHERAL_FRACN]	= "fracn",
+	[MUX_PERIPHERAL_EBI]	= "ebi",
+	[MUX_PERIPHERAL_PAI]	= "pai",
+	[MUX_PERIPHERAL_DECODE]	= "decode",
+	[MUX_PERIPHERAL_SSI]	= "ssi",
+	[MUX_PERIPHERAL_MII]	= "mii",
+	[MUX_PERIPHERAL_MAXIM]	= "maxim",
+};
+
+int mux_periph_name_to_id(const char *name)
+{
+	int i;
+
+	for (i = 0; i < NR_MUX_SETTINGS; ++i)
+		if (sysfs_streq(mux_peripheral_names[i], name))
+			return i;
+
+	return -EINVAL;
+}
+
+const char *mux_periph_id_to_name(enum mux_setting setting)
+{
+	if (setting < 0 || setting >= NR_MUX_SETTINGS)
+		return "<invalid>";
+
+	return mux_peripheral_names[setting];
+}
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
+
+	mux_info.num_groups	= nr_groups;
+	mux_info.groups		= groups;
+	mux_info.armgpio_number = armgpio_number;
+	mux_info.sdgpio_number	= sdgpio_number;
+}
+
+int picoxcell_pin_set_mux_bygpio(int pin_nr, enum mux_setting setting)
+{
+	int i, j, ret = 0;
+
+	/*
+	 * If we are setting the muxing by GPIO pin number then this should
+	 * only be either ARM or SD GPIO. If the user wants to target a
+	 * specific pad, use the _byname variants.
+	 */
+	if (!(setting == MUX_ARM || setting == MUX_SD))
+		return -EPERM;
+
+	for (i = 0; i < mux_info.num_groups; ++i) {
+		struct pin_group *group = mux_info.groups[i];
+
+		for (j = 0; j < group->nr_pins; ++j) {
+			struct muxed_pin *pin = &group->pins[j];
+
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
+EXPORT_SYMBOL_GPL(picoxcell_pin_set_mux_bygpio);
+
+/*
+ * Get the muxing value for a GPIO pin number. As we have some many-to-many
+ * GPIO to pad configurations (maximum of 2-to-to) we look for the first pin
+ * that is either SD or ARM GPIO.
+ *
+ * This is only really used by the gpio layer to make sure that the GPIO
+ * really does go somewhere. When the board is configuring and checking
+ * multiplexing, it should really use the _byname() variants to make sure that
+ * we are driving the correct pad.
+ */
+int picoxcell_pin_get_mux_bygpio(int pin_nr)
+{
+	unsigned i, j;
+	int ret = MUX_UNMUXED;
+
+	for (i = 0; i < mux_info.num_groups; ++i) {
+		struct pin_group *group = mux_info.groups[i];
+
+		for (j = 0; j < group->nr_pins; ++j) {
+			struct muxed_pin *pin = &group->pins[j];
+			enum mux_setting setting = pin->get_mux(pin);
+
+			if (!(pin_nr == pin->arm_pin && pin_nr == pin->sd_pin))
+				continue;
+
+			ret = setting;
+			if (setting == MUX_SD || setting == MUX_ARM)
+				break;
+		}
+	}
+
+	/*
+	 * If we don't have a multiplexed pin entry for the requested pin then
+	 * we assume that the pin isn't multiplexed.
+	 */
+	return ret;
+}
+EXPORT_SYMBOL_GPL(picoxcell_pin_get_mux_bygpio);
+
+static struct pin_group *mux_find_group(const char *name)
+{
+	int i;
+
+	for (i = 0; i < mux_info.num_groups; ++i) {
+		struct pin_group *group = mux_info.groups[i];
+
+		if (!strcmp(group->name, name))
+			return group;
+	}
+
+	return NULL;
+}
+
+int picoxcell_group_set_mux(const char *group_name, enum mux_setting setting)
+{
+	unsigned i;
+	int err = -ENXIO;
+	struct pin_group *group;
+
+	/*
+	 * Don't let users try and trick us - they can't change the hardware
+	 * that much!
+	 */
+	if (MUX_UNMUXED == setting)
+		return -EINVAL;
+
+	group = mux_find_group(group_name);
+	if (!group)
+		return -EINVAL;
+
+	for (i = 0; i < group->nr_pins; ++i) {
+		struct muxed_pin *pin = &group->pins[i];
+
+		err = pin->set_mux(pin, setting);
+		if (err)
+			break;
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(picoxcell_group_set_mux);
+
+int picoxcell_pin_set_mux_byname(const char *pin_name,
+				 enum mux_setting setting)
+{
+	unsigned i, j;
+
+	for (i = 0; i < mux_info.num_groups; ++i) {
+		struct pin_group *group = mux_info.groups[i];
+
+		for (j = 0; j < group->nr_pins; ++j) {
+			struct muxed_pin *pin = &group->pins[j];
+
+			/*
+			 * Dedicated GPIO pins aren't shared with a
+			 * peripheral. This is illegal!
+			 */
+			if (pin->is_dedicated_gpio && !(setting == MUX_ARM ||
+							setting == MUX_SD))
+				return -EINVAL;
+
+			if (!strcmp(pin_name, pin->name))
+				return pin->set_mux(pin, setting);
+		}
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(picoxcell_pin_set_mux_byname);
+
+int picoxcell_get_pin_mux_byname(const char *pin_name)
+{
+	unsigned i, j;
+
+	for (i = 0; i < mux_info.num_groups; ++i) {
+		struct pin_group *group = mux_info.groups[i];
+
+		for (j = 0; j < group->nr_pins; ++j) {
+			struct muxed_pin *pin = &group->pins[j];
+
+			if (!strcmp(pin_name, pin->name))
+				return pin->get_mux(pin);
+		}
+	}
+
+	/*
+	 * If we don't have a multiplexed pin entry for the requested pin then
+	 * we assume that the pin isn't multiplexed.
+	 */
+	return MUX_UNMUXED;
+}
+EXPORT_SYMBOL_GPL(picoxcell_get_pin_mux_byname);
+
+static const char *pin_setting_name(struct muxed_pin *pin)
+{
+	return mux_periph_id_to_name(pin->get_mux(pin));
+}
+
+ssize_t pin_show(struct sys_device *dev, struct sysdev_attribute *attr,
+		 char *buf)
+{
+	struct muxed_pin *pin = to_multiplexed_pin(attr);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", pin_setting_name(pin));
+}
+
+ssize_t pin_store(struct sys_device *dev, struct sysdev_attribute *attr,
+		  const char *buf, size_t len)
+{
+	ssize_t ret = -EINVAL;
+	struct muxed_pin *pin = to_multiplexed_pin(attr);
+	enum mux_setting setting;
+
+	if (sysfs_streq(buf, "sdgpio"))
+		ret = pin->set_mux(pin, MUX_SD);
+	else if (sysfs_streq(buf, "armgpio"))
+		ret = pin->set_mux(pin, MUX_ARM);
+	else {
+		setting = mux_periph_name_to_id(buf);
+		ret = pin->set_mux(pin, setting);
+	}
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
+
+		for (j = 0; j < group->nr_pins; ++j) {
+			struct muxed_pin *pin = &group->pins[j];
+
+			err = sysdev_create_file(&muxing_device, &pin->attr);
+			if (err)
+				WARN("unable to create attr for %s\n",
+				     pin->name);
+		}
+	}
+}
+
+static ssize_t io_muxing_seq_show(struct seq_file *s, void *v)
+{
+	int i = (int)*(loff_t *)v, j;
+	ssize_t ret = 0;
+	struct pin_group *group = mux_info.groups[i];
+
+	for (j = 0; j < group->nr_pins; ++j) {
+		struct muxed_pin *pin = &group->pins[j];
+
+		ret += seq_printf(s, "%16s%16s%16s%10d%10d\n",
+				  group->name, pin->name,
+				  pin_setting_name(pin),
+				  mux_info.armgpio_number(pin->arm_pin),
+				  mux_info.sdgpio_number(pin->sd_pin));
+	}
+
+	return ret;
+}
+
+static void *io_muxing_seq_start(struct seq_file *s, loff_t *pos)
+{
+	if (*pos >= mux_info.num_groups)
+		return NULL;
+
+	if (pos == SEQ_START_TOKEN)
+		seq_printf(s, "%16s%16s%16s%10s%10s\n\n", "group_name",
+			   "pin_name", "setting", "arm pin", "sd pin");
+
+	return pos;
+}
+
+static void *io_muxing_seq_next(struct seq_file *s, void *v, loff_t *pos)
+{
+	(*pos)++;
+
+	return (*pos < mux_info.num_groups) ? pos : NULL;
+}
+
+static void io_muxing_seq_stop(struct seq_file *s, void *v)
+{
+}
+
+static const struct seq_operations io_muxing_seq_ops = {
+	.start		= io_muxing_seq_start,
+	.next		= io_muxing_seq_next,
+	.stop		= io_muxing_seq_stop,
+	.show		= io_muxing_seq_show,
+};
+
+static int io_muxing_debugfs_open(struct inode *inode, struct file *filp)
+{
+	return seq_open(filp, &io_muxing_seq_ops);
+}
+
+static const struct file_operations io_muxing_debugfs_fops = {
+	.owner		= THIS_MODULE,
+	.open		= io_muxing_debugfs_open,
+	.llseek		= seq_lseek,
+	.read		= seq_read,
+	.release	= seq_release,
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
index 0000000..aa730a3
--- /dev/null
+++ b/arch/arm/mach-picoxcell/mux.h
@@ -0,0 +1,110 @@
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
+	MUX_UNMUXED,
+	MUX_ARM,
+	MUX_SD,
+	MUX_PERIPHERAL_FRACN,
+	MUX_PERIPHERAL_EBI,
+	MUX_PERIPHERAL_PAI,
+	MUX_PERIPHERAL_DECODE,
+	MUX_PERIPHERAL_SSI,
+	MUX_PERIPHERAL_MII,
+	MUX_PERIPHERAL_MAXIM,
+	NR_MUX_SETTINGS,
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
+extern int picoxcell_pin_set_mux_bygpio(int pin_nr, enum mux_setting setting);
+extern int picoxcell_pin_get_mux_bygpio(int pin_nr);
+extern int picoxcell_pin_set_mux_byname(const char *pin_name,
+					enum mux_setting setting);
+extern int picoxcell_pin_get_mux_byname(const char *pin_name);
+
+extern int picoxcell_group_set_mux(const char *group_name,
+				   enum mux_setting setting);
+extern void picoxcell_mux_register(struct pin_group **groups, int nr_groups,
+				   int (*arm_number)(int pin),
+				   int (*sdgpio_number)(int pin));
+extern void __init picoxcell_muxing_init(struct picoxcell_soc *soc);
+
+extern ssize_t pin_show(struct sys_device *dev, struct sysdev_attribute *attr,
+			char *buf);
+extern ssize_t pin_store(struct sys_device *dev, struct sysdev_attribute *attr,
+			 const char *buf, size_t len);
+extern int mux_periph_name_to_id(const char *name);
+extern const char *mux_periph_id_to_name(enum mux_setting id);
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
index 9ce3ebd..12107d5 100644
--- a/arch/arm/mach-picoxcell/picoxcell_core.c
+++ b/arch/arm/mach-picoxcell/picoxcell_core.c
@@ -257,6 +257,9 @@ void __init picoxcell_core_init(void)
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
