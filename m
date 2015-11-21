From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 21 Nov 2015 19:04:49 +0100
Subject: [PATCH 2/6] pinctrl: pxa: pxa2xx: add pin control skeleton
In-Reply-To: <1448129093-20722-1-git-send-email-robert.jarzmik@free.fr>
References: <1448129093-20722-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1448129093-20722-3-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a pincontrol driver for pxa2xx architecture, encompassing all pxa25x
and pxa27x variants. This is only the pin muxing part of the driver.

One specific consideration is also the memory space (MMIO), which is
intertwined with the GPIO registers. To make things worse, the GPIO
direction register also affect pin muxing, as it chooses the "kind" of
pin, ie. the 4 output functions or 4 input functions.

The mapping between pinctrl notions and PXA Technical Reference Manual
is as follows :
 - a pin is obviously a pin
 - a group is also a pin, ie. group P101 is the pin 101
 - a mux function is an alternate function
   (ie. gpio-in, gpio-out, MMCLK, BTRTS, etc ...)

The individual architecture (pxa27x, pxa25x) instantiate a pin control
by providing a table of pins, each pin being provided a list of
PXA_FUNCTION (alternate functions).

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/pinctrl/pxa/Kconfig          |   9 ++
 drivers/pinctrl/pxa/pinctrl-pxa2xx.c | 252 +++++++++++++++++++++++++++++++++++
 drivers/pinctrl/pxa/pinctrl-pxa2xx.h |  92 +++++++++++++
 3 files changed, 353 insertions(+)
 create mode 100644 drivers/pinctrl/pxa/Kconfig
 create mode 100644 drivers/pinctrl/pxa/pinctrl-pxa2xx.c
 create mode 100644 drivers/pinctrl/pxa/pinctrl-pxa2xx.h

diff --git a/drivers/pinctrl/pxa/Kconfig b/drivers/pinctrl/pxa/Kconfig
new file mode 100644
index 000000000000..13e24d7c45c7
--- /dev/null
+++ b/drivers/pinctrl/pxa/Kconfig
@@ -0,0 +1,9 @@
+if (ARCH_PXA || COMPILE_TEST)
+
+config PINCTRL_PXA
+	bool
+	select PINMUX
+	select PINCONF
+	select GENERIC_PINCONF
+
+endif
diff --git a/drivers/pinctrl/pxa/pinctrl-pxa2xx.c b/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
new file mode 100644
index 000000000000..baded1a8745b
--- /dev/null
+++ b/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
@@ -0,0 +1,252 @@
+/*
+ * Marvell PXA2xx family pin control
+ *
+ * Copyright (C) 2015 Robert Jarzmik
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ */
+
+#include <linux/bitops.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/module.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "../pinctrl-utils.h"
+#include "pinctrl-pxa2xx.h"
+
+static int pxa2xx_pctrl_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	struct pxa_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	return pctl->ngroups;
+}
+
+static const char *pxa2xx_pctrl_get_group_name(struct pinctrl_dev *pctldev,
+					       unsigned tgroup)
+{
+	struct pxa_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	struct pxa_pinctrl_group *group = pctl->groups + tgroup;
+
+	return group->name;
+}
+
+static int pxa2xx_pctrl_get_group_pins(struct pinctrl_dev *pctldev,
+				       unsigned tgroup,
+				       const unsigned **pins,
+				       unsigned *num_pins)
+{
+	struct pxa_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	struct pxa_pinctrl_group *group = pctl->groups + tgroup;
+
+	*pins = (unsigned *)&group->pin;
+	*num_pins = 1;
+
+	return 0;
+}
+
+static const struct pinctrl_ops pxa2xx_pctl_ops = {
+#ifdef CONFIG_OF
+	.dt_node_to_map		= pinconf_generic_dt_node_to_map_all,
+	.dt_free_map		= pinctrl_utils_dt_free_map,
+#endif
+	.get_groups_count	= pxa2xx_pctrl_get_groups_count,
+	.get_group_name		= pxa2xx_pctrl_get_group_name,
+	.get_group_pins		= pxa2xx_pctrl_get_group_pins,
+};
+
+static struct pinctrl_desc pxa2xx_pinctrl_desc = {
+	.pctlops	= &pxa2xx_pctl_ops,
+};
+
+static const struct pxa_pinctrl_function *
+pxa2xx_find_function(struct pxa_pinctrl *pctl, const char *fname,
+		     const struct pxa_pinctrl_function *functions)
+{
+	const struct pxa_pinctrl_function *func;
+
+	for (func = functions; func->name; func++)
+		if (!strcmp(fname, func->name))
+			return func;
+
+	return NULL;
+}
+
+static int pxa2xx_build_functions(struct pxa_pinctrl *pctl)
+{
+	int i;
+	struct pxa_pinctrl_function *functions;
+	struct pxa_desc_function *df;
+
+	/*
+	 * Each pin can have at most 6 alternate functions, and 2 gpio functions
+	 * which are common to each pin. As there are more than 2 pins without
+	 * alternate function, 6 * npins is an absolute high limit of the number
+	 * of functions.
+	 */
+	functions = devm_kcalloc(pctl->dev, pctl->npins * 6,
+				 sizeof(*functions), GFP_KERNEL);
+	if (!functions)
+		return -ENOMEM;
+
+	for (i = 0; i < pctl->npins; i++)
+		for (df = pctl->ppins[i].functions; df->name; df++)
+			if (!pxa2xx_find_function(pctl, df->name, functions))
+				(functions + pctl->nfuncs++)->name = df->name;
+	pctl->functions = devm_kmemdup(pctl->dev, functions,
+				       pctl->nfuncs * sizeof(*functions),
+				       GFP_KERNEL);
+	if (!pctl->functions)
+		return -ENOMEM;
+
+	kfree(functions);
+	return 0;
+}
+
+static int pxa2xx_build_groups(struct pxa_pinctrl *pctl)
+{
+	int i, j, ngroups;
+	struct pxa_pinctrl_function *func;
+	struct pxa_desc_function *df;
+	char **gtmp;
+
+	gtmp = devm_kmalloc_array(pctl->dev, pctl->npins, sizeof(*gtmp),
+				  GFP_KERNEL);
+	if (!gtmp)
+		return -ENOMEM;
+
+	for (i = 0; i < pctl->nfuncs; i++) {
+		ngroups = 0;
+		for (j = 0; j < pctl->npins; j++)
+			for (df = pctl->ppins[j].functions; df->name;
+			     df++)
+				if (!strcmp(pctl->functions[i].name,
+					    df->name))
+					gtmp[ngroups++] = (char *)
+						pctl->ppins[j].pin.name;
+		func = pctl->functions + i;
+		func->ngroups = ngroups;
+		func->groups =
+			devm_kmalloc_array(pctl->dev, ngroups,
+					   sizeof(char *), GFP_KERNEL);
+		if (!func->groups)
+			return -ENOMEM;
+
+		memcpy(func->groups, gtmp, ngroups * sizeof(*gtmp));
+	}
+
+	kfree(gtmp);
+	return 0;
+}
+
+static int pxa2xx_build_state(struct pxa_pinctrl *pctl,
+			      const struct pxa_desc_pin *ppins, int npins)
+{
+	struct pxa_pinctrl_group *group;
+	struct pinctrl_pin_desc *pins;
+	int ret, i;
+
+	pctl->npins = npins;
+	pctl->ppins = ppins;
+	pctl->ngroups = npins;
+
+	pctl->desc.npins = npins;
+	pins = devm_kcalloc(pctl->dev, npins, sizeof(*pins), GFP_KERNEL);
+	if (!pins)
+		return -ENOMEM;
+
+	pctl->desc.pins = pins;
+	for (i = 0; i < npins; i++)
+		pins[i] = ppins[i].pin;
+
+	pctl->groups = devm_kmalloc_array(pctl->dev, pctl->ngroups,
+					  sizeof(*pctl->groups), GFP_KERNEL);
+	if (!pctl->groups)
+		return -ENOMEM;
+
+	for (i = 0; i < npins; i++) {
+		group = pctl->groups + i;
+		group->name = ppins[i].pin.name;
+		group->pin = ppins[i].pin.number;
+	}
+
+	ret = pxa2xx_build_functions(pctl);
+	if (ret)
+		return ret;
+
+	ret = pxa2xx_build_groups(pctl);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+int pxa2xx_pinctrl_init(struct platform_device *pdev,
+			const struct pxa_desc_pin *ppins, int npins,
+			void __iomem *base_gafr[], void __iomem *base_gpdr[],
+			void __iomem *base_pgsr[])
+{
+	struct pxa_pinctrl *pctl;
+	int ret, i, maxpin = 0;
+
+	for (i = 0; i < npins; i++)
+		maxpin = max_t(int, ppins[i].pin.number, maxpin);
+
+	pctl = devm_kzalloc(&pdev->dev, sizeof(*pctl), GFP_KERNEL);
+	if (!pctl)
+		return -ENOMEM;
+	pctl->base_gafr = devm_kcalloc(&pdev->dev, roundup(maxpin, 16),
+				       sizeof(*pctl->base_gafr), GFP_KERNEL);
+	pctl->base_gpdr = devm_kcalloc(&pdev->dev, roundup(maxpin, 32),
+				       sizeof(*pctl->base_gpdr), GFP_KERNEL);
+	pctl->base_pgsr = devm_kcalloc(&pdev->dev, roundup(maxpin, 32),
+				       sizeof(*pctl->base_pgsr), GFP_KERNEL);
+	if (!pctl->base_gafr || !pctl->base_gpdr || !pctl->base_pgsr)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, pctl);
+	spin_lock_init(&pctl->lock);
+
+	pctl->dev = &pdev->dev;
+	pctl->desc = pxa2xx_pinctrl_desc;
+	pctl->desc.name = dev_name(&pdev->dev);
+	pctl->desc.owner = THIS_MODULE;
+
+	for (i = 0; i < roundup(maxpin, 16); i += 16)
+		pctl->base_gafr[i / 16] = base_gafr[i / 16];
+	for (i = 0; i < roundup(maxpin, 32); i += 32) {
+		pctl->base_gpdr[i / 32] = base_gpdr[i / 32];
+		pctl->base_pgsr[i / 32] = base_pgsr[i / 32];
+	}
+
+	ret = pxa2xx_build_state(pctl, ppins, npins);
+	if (ret)
+		return ret;
+
+	pctl->pctl_dev = pinctrl_register(&pctl->desc, &pdev->dev, pctl);
+	if (IS_ERR(pctl->pctl_dev)) {
+		dev_err(&pdev->dev, "couldn't register pinctrl driver\n");
+		return PTR_ERR(pctl->pctl_dev);
+	}
+
+	dev_info(&pdev->dev, "initialized pxa2xx pinctrl driver\n");
+
+	return 0;
+}
+
+int pxa2xx_pinctrl_exit(struct platform_device *pdev)
+{
+	struct pxa_pinctrl *pctl = platform_get_drvdata(pdev);
+
+	pinctrl_unregister(pctl->pctl_dev);
+	return 0;
+}
diff --git a/drivers/pinctrl/pxa/pinctrl-pxa2xx.h b/drivers/pinctrl/pxa/pinctrl-pxa2xx.h
new file mode 100644
index 000000000000..8be1e0b79751
--- /dev/null
+++ b/drivers/pinctrl/pxa/pinctrl-pxa2xx.h
@@ -0,0 +1,92 @@
+/*
+ * Marvell PXA2xx family pin control
+ *
+ * Copyright (C) 2015 Robert Jarzmik
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ */
+
+#ifndef __PINCTRL_PXA_H
+#define __PINCTRL_PXA_H
+
+#define PXA_FUNCTION(_dir, _af, _name)				\
+	{							\
+		.name = _name,					\
+		.muxval = (_dir | (_af << 1)),			\
+	}
+
+#define PXA_PIN(_pin, funcs...)					\
+	{							\
+		.pin = _pin,					\
+		.functions = (struct pxa_desc_function[]){	\
+			funcs, { } },				\
+	}
+
+#define PXA_GPIO_PIN(_pin, funcs...)				\
+	{							\
+		.pin = _pin,					\
+		.functions = (struct pxa_desc_function[]){	\
+			PXA_FUNCTION(0, 0, "gpio_in"),		\
+			PXA_FUNCTION(1, 0, "gpio_out"),		\
+			funcs, { } },				\
+	}
+
+#define PXA_GPIO_ONLY_PIN(_pin)					\
+	{							\
+		.pin = _pin,					\
+		.functions = (struct pxa_desc_function[]){	\
+			PXA_FUNCTION(0, 0, "gpio_in"),		\
+			PXA_FUNCTION(1, 0, "gpio_out"),		\
+			{ } },					\
+	}
+
+#define PXA_PINCTRL_PIN(pin)		\
+	PINCTRL_PIN(pin, "P" #pin)
+
+struct pxa_desc_function {
+	const char	*name;
+	u8		muxval;
+};
+
+struct pxa_desc_pin {
+	struct pinctrl_pin_desc		pin;
+	struct pxa_desc_function	*functions;
+};
+
+struct pxa_pinctrl_group {
+	const char	*name;
+	unsigned	pin;
+};
+
+struct pxa_pinctrl_function {
+	const char	*name;
+	const char	**groups;
+	unsigned	ngroups;
+};
+
+struct pxa_pinctrl {
+	spinlock_t			lock;
+	void __iomem			**base_gafr;
+	void __iomem			**base_gpdr;
+	void __iomem			**base_pgsr;
+	struct device			*dev;
+	struct pinctrl_desc		desc;
+	struct pinctrl_dev		*pctl_dev;
+	unsigned			npins;
+	const struct pxa_desc_pin	*ppins;
+	unsigned			ngroups;
+	struct pxa_pinctrl_group	*groups;
+	unsigned			nfuncs;
+	struct pxa_pinctrl_function	*functions;
+	char				*name;
+};
+
+int pxa2xx_pinctrl_init(struct platform_device *pdev,
+			const struct pxa_desc_pin *ppins, int npins,
+			void __iomem *base_gafr[], void __iomem *base_gpdr[],
+			void __iomem *base_gpsr[]);
+
+#endif /* __PINCTRL_PXA_H */
-- 
2.1.4
