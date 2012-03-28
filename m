From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 28 Mar 2012 16:33:47 +0200
Subject: [PATCH v5 05/16] pwm: Add device tree support
In-Reply-To: <1332945238-14897-1-git-send-email-thierry.reding@avionic-design.de>
References: <1332945238-14897-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1332945238-14897-6-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds helpers to support device tree bindings for the generic
PWM API. Device tree binding documentation for PWM controllers is also
provided.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Changes in v5:
- use IS_ENABLED(CONFIG_OF) along with the compiler's DCE instead of
  empty implementations of of_pwmchip_add() and of_pwmchip_remove() in
  the !OF case
- remove OF_PWM Kconfig symbol and make OF support code conditional on
  the OF symbol only
- use "pwms" and "pwm-names" fixed property names
- remove redundant check in of_pwm_simple_xlate()
- use pwm_request_from_chip() instead of pwm_request_from_device()
- integrate OF support with pwm_get() from new patch 4

Changes in v4:
- add OF-specific code removed from patch 2
- make of_node_to_pwmchip() and of_pwm_simple_xlate() static
- rename of_get_named_pwm() to of_pwm_request(), return a struct
  pwm_device, get rid of the now unused spec parameter and use the
  device_node.name field as the PWM's name
- return a requested struct pwm_device from pwm_chip.of_xlate and
  drop the now unused spec parameter
- move OF support code into drivers/pwm/core.c
- used deferred probing if a PWM chip is not available yet

Changes in v2:
- add device tree binding documentation
- add of_xlate to parse controller-specific PWM-specifier

 Documentation/devicetree/bindings/pwm/pwm.txt |   53 ++++++++++
 drivers/pwm/core.c                            |  135 ++++++++++++++++++++++++-
 include/linux/of_pwm.h                        |   34 +++++++
 include/linux/pwm.h                           |    6 ++
 4 files changed, 226 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm.txt
 create mode 100644 include/linux/of_pwm.h

diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentation/devicetree/bindings/pwm/pwm.txt
new file mode 100644
index 0000000..bf2addc
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm.txt
@@ -0,0 +1,53 @@
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
+PWM properties should be named "pwms". The exact meaning of each pwms
+property must be documented in the device tree binding for each device.
+An optional property "pwm-names" may contain a list of strings to label
+each of the PWM devices listed in the "pwms" property. If no "pwm-names"
+property is given, the name of the user node will be used as fallback.
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
+		pwm-names = "backlight";
+	};
+
+pwm-specifier typically encodes the chip-relative PWM number and the PWM
+period in nanoseconds. Note that in the example above, specifying the
+"pwm-names" is redundant because the name "backlight" would be used as
+fallback anyway.
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
diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 77961e0..c22dd9a 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -20,6 +20,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/of_pwm.h>
 #include <linux/pwm.h>
 #include <linux/radix-tree.h>
 #include <linux/list.h>
@@ -129,6 +130,45 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
 	return 0;
 }
 
+static struct pwm_device *of_pwm_simple_xlate(struct pwm_chip *pc,
+					      const struct of_phandle_args *args)
+{
+	struct pwm_device *pwm;
+
+	if (pc->of_pwm_n_cells < 2)
+		return ERR_PTR(-EINVAL);
+
+	if (args->args[0] >= pc->npwm)
+		return ERR_PTR(-EINVAL);
+
+	pwm = pwm_request_from_chip(pc, args->args[0], NULL);
+	if (IS_ERR(pwm))
+		return ERR_PTR(-ENODEV);
+
+	pwm_set_period(pwm, args->args[1]);
+
+	return pwm;
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
 /**
  * pwm_set_chip_data() - set private chip data for a PWM
  * @pwm: PWM device
@@ -197,6 +237,9 @@ int pwmchip_add(struct pwm_chip *chip)
 	INIT_LIST_HEAD(&chip->list);
 	list_add(&chip->list, &pwm_chips);
 
+	if (IS_ENABLED(CONFIG_OF))
+		of_pwmchip_add(chip);
+
 out:
 	mutex_unlock(&pwm_lock);
 	return ret;
@@ -227,6 +270,10 @@ int pwmchip_remove(struct pwm_chip *chip)
 	}
 
 	list_del_init(&chip->list);
+
+	if (IS_ENABLED(CONFIG_OF))
+		of_pwmchip_remove(chip);
+
 	free_pwms(chip);
 
 out:
@@ -352,6 +399,85 @@ void pwm_disable(struct pwm_device *pwm)
 }
 EXPORT_SYMBOL_GPL(pwm_disable);
 
+#ifdef CONFIG_OF
+static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
+{
+	struct pwm_chip *chip;
+
+	mutex_lock(&pwm_lock);
+
+	list_for_each_entry(chip, &pwm_chips, list)
+		if (chip->dev && chip->dev->of_node == np) {
+			mutex_unlock(&pwm_lock);
+			return chip;
+		}
+
+	mutex_unlock(&pwm_lock);
+
+	return ERR_PTR(-EPROBE_DEFER);
+}
+
+/**
+ * of_pwm_request() - request a PWM via the PWM framework
+ * @np: device node to get the PWM from
+ * @index: index of the PWM
+ *
+ * Returns the PWM device parsed from the phandle and index specified in the
+ * "pwms" property of a device tree node or a negative error-code on failure.
+ * Values parsed from the device tree are stored in the returned PWM device
+ * object.
+ */
+struct pwm_device *of_pwm_request(struct device_node *np, int index)
+{
+	struct pwm_device *pwm = NULL;
+	struct of_phandle_args args;
+	struct pwm_chip *pc;
+	int err;
+
+	err = of_parse_phandle_with_args(np, "pwms", "#pwm-cells", index,
+					 &args);
+	if (err) {
+		pr_debug("%s(): can't parse \"pwms\" property\n", __func__);
+		return ERR_PTR(err);
+	}
+
+	pc = of_node_to_pwmchip(args.np);
+	if (IS_ERR(pc)) {
+		pr_debug("%s(): PWM chip not found\n", __func__);
+		pwm = ERR_CAST(pc);
+		goto put;
+	}
+
+	if (args.args_count != pc->of_pwm_n_cells) {
+		pr_debug("%s: wrong #pwm-cells for %s\n", np->full_name,
+			 args.np->full_name);
+		pwm = ERR_PTR(-EINVAL);
+		goto put;
+	}
+
+	pwm = pc->of_xlate(pc, &args);
+	if (IS_ERR(pwm))
+		goto put;
+
+	err = of_property_read_string_index(np, "pwm-names", index,
+					    &pwm->label);
+	if (err < 0) {
+		/*
+		 * Fallback to name of user node if the name cannot be parsed
+		 * from the "pwm-names" property (e.g. the property doesn't
+		 * exist or an error occurred).
+		 */
+		pwm->label = np->name;
+	}
+
+put:
+	of_node_put(args.np);
+
+	return pwm;
+}
+EXPORT_SYMBOL(of_pwm_request);
+#endif
+
 /**
  * pwm_add_table() - register PWM device consumers
  * @table: array of consumers to register
@@ -380,8 +506,9 @@ void __init pwm_add_table(struct pwm_lookup *table, size_t num)
  * @provider: name of provider PWM chip
  * @index: per-chip index of PWM to request
  *
- * Look up a PWM chip and a relative index via a table supplied by board setup
- * code (see pwm_add_table()).
+ * Lookup is first attempted using DT. If the device was not instantiated from
+ * a device tree, a PWM chip and a relative index is looked up via a table
+ * supplied by board setup code (see pwm_add_table()).
  *
  * Once a PWM chip has been found the specified PWM device will be requested
  * and is ready to be used.
@@ -394,6 +521,10 @@ struct pwm_device *pwm_get(struct device *dev, const char *consumer)
 	struct pwm_lookup *p;
 	unsigned int index;
 
+	/* look up via DT first */
+	if (dev && dev->of_node)
+		return of_pwm_request(dev->of_node, 0);
+
 	/*
 	 * We look up the provider in the static table typically provided by
 	 * board setup code. We first try to lookup the consumer device by
diff --git a/include/linux/of_pwm.h b/include/linux/of_pwm.h
new file mode 100644
index 0000000..8c4ed9f
--- /dev/null
+++ b/include/linux/of_pwm.h
@@ -0,0 +1,34 @@
+/*
+ * OF helpers for the PWM API
+ *
+ * Copyright (c) 2011-2012 Avionic Design GmbH
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
+#include <linux/err.h>
+#include <linux/pwm.h>
+
+struct device_node;
+
+#ifdef CONFIG_OF
+
+struct pwm_device *of_pwm_request(struct device_node *np, int index);
+
+#else
+
+static inline struct pwm_device *of_pwm_request(struct device_node *np,
+						int index)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
+#endif /* CONFIG_OF */
+
+#endif /* __LINUX_OF_PWM_H */
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index a32d2b7..e19c92a 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -1,6 +1,8 @@
 #ifndef __LINUX_PWM_H
 #define __LINUX_PWM_H
 
+#include <linux/of.h>
+
 struct pwm_device;
 struct seq_file;
 
@@ -105,6 +107,10 @@ struct pwm_chip {
 	unsigned int		npwm;
 
 	struct pwm_device	*pwms;
+
+	struct pwm_device *	(*of_xlate)(struct pwm_chip *pc,
+					    const struct of_phandle_args *args);
+	unsigned int		of_pwm_n_cells;
 };
 
 int pwm_set_chip_data(struct pwm_device *pwm, void *data);
-- 
1.7.9.4
