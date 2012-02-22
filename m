From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 22 Feb 2012 16:17:14 +0100
Subject: [PATCH v3 03/10] of: Add PWM support.
In-Reply-To: <1329923841-32017-1-git-send-email-thierry.reding@avionic-design.de>
References: <1329923841-32017-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1329923841-32017-4-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds helpers to support device tree bindings for the generic
PWM API. Device tree binding documentation for PWM controllers is also
provided.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Changes in v3:
  - none

Changes in v2:
  - add device tree binding documentation
  - add of_xlate to parse controller-specific PWM-specifier

 Documentation/devicetree/bindings/pwm/pwm.txt |   48 +++++++++
 drivers/of/Kconfig                            |    6 +
 drivers/of/Makefile                           |    1 +
 drivers/of/pwm.c                              |  130 +++++++++++++++++++++++++
 include/linux/of_pwm.h                        |   51 ++++++++++
 include/linux/pwm.h                           |   17 +++
 6 files changed, 253 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm.txt
 create mode 100644 drivers/of/pwm.c
 create mode 100644 include/linux/of_pwm.h

diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentation/devicetree/bindings/pwm/pwm.txt
new file mode 100644
index 0000000..9421fe7
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm.txt
@@ -0,0 +1,48 @@
+Specifying PWM information for devices
+======================================
+
+1) PWM user nodes
+-----------------
+
+PWM users should specify a list of PWM devices that they want to use
+with a property containing a 'pwm-list':
+
+	pwm-list ::= <single-pwm> [pwm-list]
+	single-pwm ::= <pwm-phandle> <pwm-specifier>
+	pwm-phandle : phandle to PWM controller node
+	pwm-specifier : array of #pwm-cells specifying the given PWM
+			(controller specific)
+
+PWM properties should be named "[<name>-]pwms". Exact meaning of each
+pwms property must be documented in the device tree binding for each
+device.
+
+The following example could be used to describe a PWM-based backlight
+device:
+
+	pwm: pwm {
+		#pwm-cells = <2>;
+	};
+
+	[...]
+
+	bl: backlight {
+		pwms = <&pwm 0 5000000>;
+	};
+
+pwm-specifier typically encodes the chip-relative PWM number and the PWM
+period in nanoseconds.
+
+2) PWM controller nodes
+-----------------------
+
+PWM controller nodes must specify the number of cells used for the
+specifier using the '#pwm-cells' property.
+
+An example PWM controller might look like this:
+
+	pwm: pwm at 7000a000 {
+		compatible = "nvidia,tegra20-pwm";
+		reg = <0x7000a000 0x100>;
+		#pwm-cells = <2>;
+	};
diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 6ea51dc..d47b8ee 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -57,6 +57,12 @@ config OF_GPIO
 	help
 	  OpenFirmware GPIO accessors
 
+config OF_PWM
+	def_bool y
+	depends on PWM
+	help
+	  OpenFirmware PWM accessors
+
 config OF_I2C
 	def_tristate I2C
 	depends on I2C && !SPARC
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index a73f5a5..3dd13e3 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_OF_ADDRESS)  += address.o
 obj-$(CONFIG_OF_IRQ)    += irq.o
 obj-$(CONFIG_OF_DEVICE) += device.o platform.o
 obj-$(CONFIG_OF_GPIO)   += gpio.o
+obj-$(CONFIG_OF_PWM)	+= pwm.o
 obj-$(CONFIG_OF_I2C)	+= of_i2c.o
 obj-$(CONFIG_OF_NET)	+= of_net.o
 obj-$(CONFIG_OF_SPI)	+= of_spi.o
diff --git a/drivers/of/pwm.c b/drivers/of/pwm.c
new file mode 100644
index 0000000..d6f7f33
--- /dev/null
+++ b/drivers/of/pwm.c
@@ -0,0 +1,130 @@
+/*
+ * OF helpers for the PWM API
+ *
+ * Copyright (c) 2011 Avionic Design GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/errno.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pwm.h>
+
+static int of_pwmchip_is_match(struct pwm_chip *chip, void *data)
+{
+	return chip->dev ? chip->dev->of_node == data : 0;
+}
+
+/**
+ * of_node_to_pwmchip() - finds the PWM chip associated with a device node
+ * @np: device node of the PWM chip
+ *
+ * Returns a pointer to the PWM chip associated with the specified device
+ * node or NULL if the device node doesn't represent a PWM chip.
+ */
+struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
+{
+	return pwmchip_find(np, of_pwmchip_is_match);
+}
+
+int of_pwm_simple_xlate(struct pwm_chip *pc, const struct of_phandle_args *args,
+			struct pwm_spec *spec)
+{
+	if (pc->of_pwm_n_cells < 2)
+		return -EINVAL;
+
+	if (args->args_count < pc->of_pwm_n_cells)
+		return -EINVAL;
+
+	if (args->args[0] >= pc->npwm)
+		return -EINVAL;
+
+	if (spec)
+		spec->period = args->args[1];
+
+	return args->args[0];
+}
+
+void of_pwmchip_add(struct pwm_chip *chip)
+{
+	if (!chip->dev || !chip->dev->of_node)
+		return;
+
+	if (!chip->of_xlate) {
+		chip->of_xlate = of_pwm_simple_xlate;
+		chip->of_pwm_n_cells = 2;
+	}
+
+	of_node_get(chip->dev->of_node);
+}
+
+void of_pwmchip_remove(struct pwm_chip *chip)
+{
+	if (chip->dev && chip->dev->of_node)
+		of_node_put(chip->dev->of_node);
+}
+
+/**
+ * of_get_named_pwm() - get a PWM number and period to use with the PWM API
+ * @np: device node to get the PWM from
+ * @propname: property name containing PWM specifier(s)
+ * @index: index of the PWM
+ * @spec: a pointer to a struct pwm_spec to fill in
+ *
+ * Returns PWM number to use with the Linux generic PWM API or a negative
+ * error code on failure. If @spec is not NULL the function fills in the
+ * values parsed from the device tree.
+ */
+int of_get_named_pwm(struct device_node *np, const char *propname,
+		     int index, struct pwm_spec *spec)
+{
+	struct of_phandle_args args;
+	struct pwm_chip *pc;
+	int ret;
+
+	ret = of_parse_phandle_with_args(np, propname, "#pwm-cells", index,
+					  &args);
+	if (ret) {
+		pr_debug("%s(): can't parse pwms property\n", __func__);
+		goto out;
+	}
+
+	pc = of_node_to_pwmchip(args.np);
+	if (!pc) {
+		ret = -ENODEV;
+		goto put;
+	}
+
+	if (args.args_count != pc->of_pwm_n_cells) {
+		pr_debug("%s: wrong #pwm-cells for %s\n", np->full_name,
+			 args.np->full_name);
+		ret = -EINVAL;
+		goto put;
+	}
+
+	/*
+	 * reset the specifier structure since .of_xlate might decide not to
+	 * fill it in
+	 */
+	if (spec)
+		spec->period = 0;
+
+	ret = pc->of_xlate(pc, &args, spec);
+	if (ret < 0)
+		goto put;
+
+	ret += pc->base;
+
+put:
+	of_node_put(args.np);
+out:
+	pr_debug("%s() exited with status %d\n", __func__, ret);
+	return ret;
+}
+EXPORT_SYMBOL(of_get_named_pwm);
diff --git a/include/linux/of_pwm.h b/include/linux/of_pwm.h
new file mode 100644
index 0000000..a6af951
--- /dev/null
+++ b/include/linux/of_pwm.h
@@ -0,0 +1,51 @@
+/*
+ * OF helpers for the PWM API
+ *
+ * Copyright (c) 2011 Avionic Design GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __LINUX_OF_PWM_H
+#define __LINUX_OF_PWM_H
+
+#include <linux/pwm.h>
+
+struct device_node;
+
+#ifdef CONFIG_OF_PWM
+
+struct pwm_chip *of_node_to_pwmchip(struct device_node *np);
+int of_get_named_pwm(struct device_node *np, const char *propname,
+		     int index, struct pwm_spec *spec);
+void of_pwmchip_add(struct pwm_chip *pc);
+void of_pwmchip_remove(struct pwm_chip *pc);
+
+#else
+
+static inline struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
+{
+	return NULL;
+}
+
+static inline int of_get_named_pwm(struct device_node *np,
+				   const char *propname, int index,
+				   unsigned int *period_ns)
+{
+	return -ENOSYS;
+}
+
+static inline void of_pwmchip_add(struct pwm_chip *pc)
+{
+}
+
+static inline void of_pwmchip_remove(struct pwm_chip *pc)
+{
+}
+
+#endif /* CONFIG_OF_PWM */
+
+#endif /* __LINUX_OF_PWM_H */
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index b00a91f..a7cb543 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -1,6 +1,8 @@
 #ifndef __LINUX_PWM_H
 #define __LINUX_PWM_H
 
+#include <linux/of.h>
+
 struct pwm_device;
 
 /*
@@ -75,6 +77,14 @@ struct pwm_ops {
 };
 
 /**
+ * struct pwm_spec - device tree PWM specifier
+ * @period: PWM period (in nanoseconds)
+ */
+struct pwm_spec {
+	unsigned int period;
+};
+
+/**
  * struct pwm_chip - abstract a PWM controller
  * @dev: device providing the PWMs
  * @ops: callbacks for this PWM controller
@@ -89,6 +99,13 @@ struct pwm_chip {
 	unsigned int		npwm;
 
 	struct pwm_device	*pwms;
+
+#ifdef CONFIG_OF_PWM
+	int			(*of_xlate)(struct pwm_chip *pc,
+					    const struct of_phandle_args *args,
+					    struct pwm_spec *spec);
+	unsigned int		of_pwm_n_cells;
+#endif
 };
 
 int pwm_set_chip_data(struct pwm_device *pwm, void *data);
-- 
1.7.9.1
