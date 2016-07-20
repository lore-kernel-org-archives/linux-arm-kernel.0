From: andrew@aj.id.au (Andrew Jeffery)
Date: Wed, 20 Jul 2016 15:28:23 +0930
Subject: [PATCH 02/12] pinctrl: Add core pinctrl support for Aspeed SoCs
In-Reply-To: <1468994313-13538-1-git-send-email-andrew@aj.id.au>
References: <1468994313-13538-1-git-send-email-andrew@aj.id.au>
Message-ID: <1468994313-13538-3-git-send-email-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Aspeed SoCs provide typically more than 200 pins for GPIO and other
functions. The signal enabled on a pin is determined on a priority
basis, where a given pin can provide a number of different signal types.

In addition to the priority levels, the Aspeed pin controllers describe
the signal active on a pin by compound logical expressions involving
multiple operators, registers and bits. Some difficulty arises as a
pin's function bit masks for each priority level are frequently not the
same (i.e. we cannot just flip a bit to change from a high to low
priority signal), or even in the same register(s). Some configuration
bits affect multiple pins, while in other cases the signals for a bus
must each be enabled individually.

Together, these features give rise to some complexity in the
implementation. A more complete description of the complexities is
provided in the associated header file in an attempt to justify the
approach.

Note that the patch doesn't implement pinctrl/pinmux/pinconf for any
particular SoC, just adds the framework for defining mux configurations
for any available functions.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 MAINTAINERS                             |   1 +
 arch/arm/mach-aspeed/Kconfig            |   1 +
 drivers/pinctrl/Kconfig                 |   1 +
 drivers/pinctrl/Makefile                |   1 +
 drivers/pinctrl/aspeed/Kconfig          |   8 +
 drivers/pinctrl/aspeed/Makefile         |   3 +
 drivers/pinctrl/aspeed/pinctrl-aspeed.c | 373 +++++++++++++++++++++
 drivers/pinctrl/aspeed/pinctrl-aspeed.h | 562 ++++++++++++++++++++++++++++++++
 8 files changed, 950 insertions(+)
 create mode 100644 drivers/pinctrl/aspeed/Kconfig
 create mode 100644 drivers/pinctrl/aspeed/Makefile
 create mode 100644 drivers/pinctrl/aspeed/pinctrl-aspeed.c
 create mode 100644 drivers/pinctrl/aspeed/pinctrl-aspeed.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b5f2d3576d3a..f6987de35435 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1004,6 +1004,7 @@ F:	arch/arm/mach-aspeed/
 F:	arch/arm/boot/dts/aspeed-*
 F:	drivers/*/*aspeed*
 F:	Documentation/devicetree/bindings/*/*aspeed*
+F:	drivers/pinctrl/aspeed/
 
 ARM/ATMEL AT91RM9200, AT91SAM9 AND SAMA5 SOC SUPPORT
 M:	Nicolas Ferre <nicolas.ferre@atmel.com>
diff --git a/arch/arm/mach-aspeed/Kconfig b/arch/arm/mach-aspeed/Kconfig
index 5225fbcb250d..632899c58098 100644
--- a/arch/arm/mach-aspeed/Kconfig
+++ b/arch/arm/mach-aspeed/Kconfig
@@ -5,6 +5,7 @@ menuconfig ARCH_ASPEED
 	select WATCHDOG
 	select ASPEED_WATCHDOG
 	select MOXART_TIMER
+	select PINCTRL
 	help
 	  Say Y here if you want to run your kernel on an ASpeed BMC SoC.
 
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index fb8200b8e8ec..299e4531f677 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -232,6 +232,7 @@ config PINCTRL_ZYNQ
 	help
 	  This selects the pinctrl driver for Xilinx Zynq.
 
+source "drivers/pinctrl/aspeed/Kconfig"
 source "drivers/pinctrl/bcm/Kconfig"
 source "drivers/pinctrl/berlin/Kconfig"
 source "drivers/pinctrl/freescale/Kconfig"
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 42a5c1dddfef..161eb5d1d878 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_PINCTRL_LPC18XX)	+= pinctrl-lpc18xx.o
 obj-$(CONFIG_PINCTRL_TB10X)	+= pinctrl-tb10x.o
 obj-$(CONFIG_PINCTRL_ST) 	+= pinctrl-st.o
 obj-$(CONFIG_PINCTRL_ZYNQ)	+= pinctrl-zynq.o
+obj-$(CONFIG_ARCH_ASPEED)	+= aspeed/
 
 obj-$(CONFIG_ARCH_BCM)		+= bcm/
 obj-$(CONFIG_PINCTRL_BERLIN)	+= berlin/
diff --git a/drivers/pinctrl/aspeed/Kconfig b/drivers/pinctrl/aspeed/Kconfig
new file mode 100644
index 000000000000..34d9050f2761
--- /dev/null
+++ b/drivers/pinctrl/aspeed/Kconfig
@@ -0,0 +1,8 @@
+config PINCTRL_ASPEED
+	bool
+	depends on (ARCH_ASPEED || COMPILE_TEST) && OF
+	select PINMUX
+	select PINCONF
+	select GENERIC_PINCONF
+	select MFD_SYSCON
+	select REGMAP_MMIO
diff --git a/drivers/pinctrl/aspeed/Makefile b/drivers/pinctrl/aspeed/Makefile
new file mode 100644
index 000000000000..6bc001c001ee
--- /dev/null
+++ b/drivers/pinctrl/aspeed/Makefile
@@ -0,0 +1,3 @@
+# Aspeed pinctrl support
+
+obj-$(CONFIG_PINCTRL_ASPEED)	+= pinctrl-aspeed.o
diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed.c b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
new file mode 100644
index 000000000000..07d09e04a6ed
--- /dev/null
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
@@ -0,0 +1,373 @@
+/*
+ * Copyright (C) 2016 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/platform_device.h>
+#include <linux/string.h>
+#include "../core.h"
+#include "pinctrl-aspeed.h"
+
+int aspeed_pinctrl_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	struct aspeed_pinctrl_data *pdata = pinctrl_dev_get_drvdata(pctldev);
+
+	return pdata->ngroups;
+}
+
+const char *aspeed_pinctrl_get_group_name(struct pinctrl_dev *pctldev,
+		unsigned int group)
+{
+	struct aspeed_pinctrl_data *pdata = pinctrl_dev_get_drvdata(pctldev);
+
+	return pdata->groups[group].name;
+}
+
+int aspeed_pinctrl_get_group_pins(struct pinctrl_dev *pctldev,
+		unsigned int group, const unsigned int **pins,
+		unsigned int *npins)
+{
+	struct aspeed_pinctrl_data *pdata = pinctrl_dev_get_drvdata(pctldev);
+
+	*pins = &pdata->groups[group].pins[0];
+	*npins = pdata->groups[group].npins;
+
+	return 0;
+}
+
+void aspeed_pinctrl_pin_dbg_show(struct pinctrl_dev *pctldev,
+		struct seq_file *s, unsigned int offset)
+{
+	seq_printf(s, " %s", dev_name(pctldev->dev));
+}
+
+int aspeed_pinmux_get_fn_count(struct pinctrl_dev *pctldev)
+{
+	struct aspeed_pinctrl_data *pdata = pinctrl_dev_get_drvdata(pctldev);
+
+	return pdata->nfunctions;
+}
+
+const char *aspeed_pinmux_get_fn_name(struct pinctrl_dev *pctldev,
+						unsigned int function)
+{
+	struct aspeed_pinctrl_data *pdata = pinctrl_dev_get_drvdata(pctldev);
+
+	return pdata->functions[function].name;
+}
+
+int aspeed_pinmux_get_fn_groups(struct pinctrl_dev *pctldev,
+		unsigned int function, const char * const **groups,
+		unsigned int * const num_groups)
+{
+	struct aspeed_pinctrl_data *pdata = pinctrl_dev_get_drvdata(pctldev);
+
+	*groups = pdata->functions[function].groups;
+	*num_groups = pdata->functions[function].ngroups;
+
+	return 0;
+}
+
+static inline void aspeed_sig_desc_print_val(
+		const struct aspeed_sig_desc *desc, bool enable, u32 rv)
+{
+#if defined(CONFIG_DEBUG_PINCTRL)
+	pr_debug("SCU%x[0x%08x]=0x%x, got 0x%x from 0x%08x\n", desc->reg,
+			desc->mask, enable ? desc->enable : desc->disable,
+			(rv & desc->mask) >> __ffs(desc->mask), rv);
+#endif
+}
+
+static bool aspeed_sig_desc_eval(const struct aspeed_sig_desc *desc,
+		bool enabled, struct regmap *map)
+{
+	unsigned int raw;
+	u32 want;
+
+	if (regmap_read(map, desc->reg, &raw) < 0)
+		return false;
+
+	aspeed_sig_desc_print_val(desc, enabled, raw);
+	want = enabled ? desc->enable : desc->disable;
+
+	return ((raw & desc->mask) >> __ffs(desc->mask)) == want;
+}
+
+static bool aspeed_sig_expr_eval(const struct aspeed_sig_expr *expr,
+		bool enabled, struct regmap *map)
+{
+	int i;
+
+	for (i = 0; i < expr->ndescs; i++) {
+		const struct aspeed_sig_desc *desc = &expr->descs[i];
+
+		if (!aspeed_sig_desc_eval(desc, enabled, map))
+			return false;
+	}
+
+	return true;
+}
+
+/**
+ * Configure a signal state by applying descriptor state for all descriptors in
+ * a signal expression.
+ *
+ * @expr: The expression associated with the function whose signal is to be
+ *        configured
+ * @enable: true to enable an function's signal through a pin's signal
+ *          expression, false to disable the function's signal
+ * @map: The SCU's regmap instance for pinmux register access.
+ *
+ * @return true if the expression is configured as requested, false otherwise
+ */
+static bool aspeed_sig_expr_set(const struct aspeed_sig_expr *expr,
+		bool enable, struct regmap *map)
+{
+	int i;
+	bool ret;
+
+	ret = aspeed_sig_expr_eval(expr, enable, map);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < expr->ndescs; i++) {
+		const struct aspeed_sig_desc *desc = &expr->descs[i];
+		u32 pattern = enable ? desc->enable : desc->disable;
+		unsigned int val;
+
+		/*
+		 * Strap registers are configured in hardware or by early-boot
+		 * firmware. Treat them as read-only despite that we can write
+		 * them. This may mean that certain functions cannot be
+		 * deconfigured and is the reason we re-evaluate after writing
+		 * all descriptor bits.
+		 */
+		if (desc->reg == HW_STRAP1 || desc->reg == HW_STRAP2)
+			continue;
+
+		if (regmap_read(map, desc->reg, &val) < 0)
+			return false;
+
+		val &= ~desc->mask;
+		val |= pattern << __ffs(desc->mask);
+
+		if (regmap_write(map, desc->reg, val) < 0)
+			return false;
+	}
+
+	return aspeed_sig_expr_eval(expr, enable, map);
+}
+
+static bool aspeed_sig_expr_enable(const struct aspeed_sig_expr *expr,
+		struct regmap *map)
+{
+	return aspeed_sig_expr_set(expr, true, map);
+}
+
+static bool aspeed_sig_expr_disable(const struct aspeed_sig_expr *expr,
+		struct regmap *map)
+{
+	return aspeed_sig_expr_set(expr, false, map);
+}
+
+/**
+ * Disable a signal on a pin by disabling all provided signal expressions.
+ *
+ * @exprs: The list of signal expressions (from a priority level on a pin)
+ * @map: The SCU's regmap instance for pinmux register access.
+ *
+ * @return true if all expressions in the list are successfully disabled, false
+ * otherwise
+ */
+static bool aspeed_disable_sig(const struct aspeed_sig_expr **exprs,
+		struct regmap *map)
+{
+	bool disabled = true;
+
+	if (!exprs)
+		return true;
+
+	while (*exprs) {
+		bool ret;
+
+		ret = aspeed_sig_expr_disable(*exprs, map);
+		disabled = disabled && ret;
+
+		exprs++;
+	}
+
+	return disabled;
+}
+
+/**
+ * Search for the signal expression needed to enable the pin's signal for the
+ * requested function.
+ *
+ * @exprs: List of signal expressions (haystack)
+ * @name: The name of the requested function (needle)
+ *
+ * @return A pointer to the signal expression whose function tag matches the
+ *         provided name, otherwise NULL.
+ *
+ */
+static const struct aspeed_sig_expr *aspeed_find_expr_by_name(
+		const struct aspeed_sig_expr **exprs, const char *name)
+{
+	while (*exprs) {
+		if (strcmp((*exprs)->function, name) == 0)
+			return *exprs;
+		exprs++;
+	}
+
+	return NULL;
+}
+
+int aspeed_pinmux_set_mux(struct pinctrl_dev *pctldev, unsigned int function,
+		unsigned int group)
+{
+	int i;
+	const struct aspeed_pinctrl_data *pdata =
+		pinctrl_dev_get_drvdata(pctldev);
+	const struct aspeed_pin_group *pgroup = &pdata->groups[group];
+	const struct aspeed_pin_function *pfunc =
+		&pdata->functions[function];
+
+	for (i = 0; i < pgroup->npins; i++) {
+		int pin = pgroup->pins[i];
+		const struct aspeed_pin_desc *pdesc = pdata->pins[pin].drv_data;
+		const struct aspeed_sig_expr *expr = NULL;
+		const struct aspeed_sig_expr **funcs;
+		const struct aspeed_sig_expr ***prios;
+
+		if (!pdesc)
+			return -EINVAL;
+
+		prios = pdesc->prios;
+
+		if (!prios)
+			continue;
+
+		/* Disable functions at a higher priority than that requested */
+		while ((funcs = *prios)) {
+			expr = aspeed_find_expr_by_name(funcs, pfunc->name);
+
+			if (expr)
+				break;
+
+			if (!aspeed_disable_sig(funcs, pdata->map))
+				return -EPERM;
+
+			prios++;
+		}
+
+		if (!expr)
+			return -EINVAL;
+
+		if (!aspeed_sig_expr_enable(expr, pdata->map))
+			return -EPERM;
+	}
+
+	return 0;
+}
+
+static bool aspeed_gpio_in_exprs(const struct aspeed_sig_expr **exprs)
+{
+	if (!exprs)
+		return false;
+
+	while (*exprs) {
+		if (strncmp((*exprs)->signal, "GPIO", 4) == 0)
+			return true;
+		exprs++;
+	}
+
+	return false;
+}
+
+int aspeed_gpio_request_enable(struct pinctrl_dev *pctldev,
+		struct pinctrl_gpio_range *range,
+		unsigned int offset)
+{
+	const struct aspeed_pinctrl_data *pdata =
+		pinctrl_dev_get_drvdata(pctldev);
+	const struct aspeed_pin_desc *pdesc = pdata->pins[offset].drv_data;
+	const struct aspeed_sig_expr ***prios, **funcs, *expr;
+
+	if (!pdesc)
+		return -EINVAL;
+
+	prios = pdesc->prios;
+
+	if (!prios)
+		return -ENXIO;
+
+	/* Disable any functions of higher priority than GPIO */
+	while ((funcs = *prios)) {
+		if (aspeed_gpio_in_exprs(funcs))
+			break;
+
+		if (!aspeed_disable_sig(funcs, pdata->map))
+			return -EPERM;
+
+		prios++;
+	}
+
+	/* No GPIO option? */
+	if (!funcs)
+		return -ENXIO;
+
+	expr = *funcs;
+
+	/*
+	 * If GPIO is the "Other" case, then disabling all signal expressions
+	 * is all that's required. As such it has no associated expression.
+	 */
+	if (!expr)
+		return 0;
+
+	/*
+	 * Otherwise, assume there is only one expression defined to enable
+	 * the GPIO function
+	 */
+	if (!aspeed_sig_expr_enable(expr, pdata->map))
+		return -EPERM;
+
+	return 0;
+}
+
+int aspeed_pinctrl_probe(struct platform_device *pdev,
+		struct pinctrl_desc *pdesc,
+		struct aspeed_pinctrl_data *pdata)
+{
+	struct device *parent;
+	struct pinctrl_dev *pctl;
+
+	parent = pdev->dev.parent;
+	if (!parent) {
+		dev_err(&pdev->dev, "No parent for syscon pincontroller\n");
+		return -ENODEV;
+	}
+
+	pdata->map = syscon_node_to_regmap(parent->of_node);
+	if (IS_ERR(pdata->map)) {
+		dev_err(&pdev->dev, "No regmap for syscon pincontroller parent\n");
+		return PTR_ERR(pdata->map);
+	}
+
+	pctl = pinctrl_register(pdesc, &pdev->dev, pdata);
+
+	if (IS_ERR(pctl)) {
+		dev_err(&pdev->dev, "Failed to register pinctrl\n");
+		return PTR_ERR(pctl);
+	}
+
+	platform_set_drvdata(pdev, pdata);
+
+	return 0;
+}
diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed.h b/drivers/pinctrl/aspeed/pinctrl-aspeed.h
new file mode 100644
index 000000000000..1adb068a58ce
--- /dev/null
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed.h
@@ -0,0 +1,562 @@
+/*
+ * Copyright (C) 2016 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef PINCTRL_ASPEED
+#define PINCTRL_ASPEED
+
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/regmap.h>
+
+/*
+ * The ASPEED AST SoCs provide typically more than 200 pins for GPIO and other
+ * functions. The SoC function enabled on a pin is determined on a priority
+ * basis where a given pin can provide a number of different signal types.
+ *
+ * The signal active on a pin is described by both a priority level and
+ * compound logical expressions involving multiple operators, registers and
+ * bits. Some difficulty arises as the pin's function bit masks for each
+ * priority level are frequently not the same (i.e. cannot just flip a bit to
+ * change from a high to low priority signal), or even in the same register.
+ * Further, not all signals can be unmuxed, as some expressions depend on
+ * values in the hardware strapping register (which is treated as read-only).
+ *
+ * SoC Multi-function Pin Expression Examples
+ * ------------------------------------------
+ *
+ * Here are some sample mux configurations from the AST2400 and AST2500
+ * datasheets to illustrate the corner cases, roughly in order of least to most
+ * corner. The signal priorities are in decending order from P0 (highest).
+ *
+ * D6 is a pin with a single function (beside GPIO); a high priority signal
+ * that participates in one function:
+ *
+ * Ball | Default | P0 Signal | P0 Expression               | P1 Signal | P1 Expression | Other
+ * -----+---------+-----------+-----------------------------+-----------+---------------+----------
+ *  D6    GPIOA0    MAC1LINK    SCU80[0]=1                                                GPIOA0
+ * -----+---------+-----------+-----------------------------+-----------+---------------+----------
+ *
+ * C5 is a multi-signal pin (high and low priority signals). Here we touch
+ * different registers for the different functions that enable each signal:
+ *
+ * -----+---------+-----------+-----------------------------+-----------+---------------+----------
+ *  C5    GPIOA4    SCL9        SCU90[22]=1                   TIMER5      SCU80[4]=1      GPIOA4
+ * -----+---------+-----------+-----------------------------+-----------+---------------+----------
+ *
+ * E19 is a single-signal pin with two functions that influence the active
+ * signal. In this case both bits have the same meaning - enable a dedicated
+ * LPC reset pin. However it's not always the case that the bits in the
+ * OR-relationship have the same meaning.
+ *
+ * -----+---------+-----------+-----------------------------+-----------+---------------+----------
+ *  E19   GPIOB4    LPCRST#     SCU80[12]=1 | Strap[14]=1                                 GPIOB4
+ * -----+---------+-----------+-----------------------------+-----------+---------------+----------
+ *
+ * For example, pin B19 has a low-priority signal that's enabled by two
+ * distinct SoC functions: A specific SIOPBI bit in register SCUA4, and an ACPI
+ * bit in the STRAP register. The ACPI bit configures signals on pins in
+ * addition to B19. Both of the low priority functions as well as the high
+ * priority function must be disabled for GPIOF1 to be used.
+ *
+ * Ball | Default | P0 Signal | P0 Expression                           | P1 Signal | P1 Expression                          | Other
+ * -----+---------+-----------+-----------------------------------------+-----------+----------------------------------------+----------
+ *  B19   GPIOF1    NDCD4       SCU80[25]=1                               SIOPBI#     SCUA4[12]=1 | Strap[19]=0                GPIOF1
+ * -----+---------+-----------+-----------------------------------------+-----------+----------------------------------------+----------
+ *
+ * For pin E18, the SoC ANDs the expected state of three bits to determine the
+ * pin's active signal:
+ *
+ * * SCU3C[3]: Enable external SOC reset function
+ * * SCU80[15]: Enable SPICS1# or EXTRST# function pin
+ * * SCU90[31]: Select SPI interface CS# output
+ *
+ * -----+---------+-----------+-----------------------------------------+-----------+----------------------------------------+----------
+ *  E18   GPIOB7    EXTRST#     SCU3C[3]=1 & SCU80[15]=1 & SCU90[31]=0    SPICS1#     SCU3C[3]=1 & SCU80[15]=1 & SCU90[31]=1   GPIOB7
+ * -----+---------+-----------+-----------------------------------------+-----------+----------------------------------------+----------
+ *
+ * (Bits SCU3C[3] and SCU80[15] appear to only be used in the expressions for
+ * selecting the signals on pin E18)
+ *
+ * Pin T5 is a multi-signal pin with a more complex configuration:
+ *
+ * Ball | Default | P0 Signal | P0 Expression                | P1 Signal | P1 Expression | Other
+ * -----+---------+-----------+------------------------------+-----------+---------------+----------
+ *  T5    GPIOL1    VPIDE       SCU90[5:4]!=0 & SCU84[17]=1    NDCD1       SCU84[17]=1     GPIOL1
+ * -----+---------+-----------+------------------------------+-----------+---------------+----------
+ *
+ * The high priority signal configuration is best thought of in terms of its
+ * exploded form, with reference to the SCU90[5:4] bits:
+ *
+ * * SCU90[5:4]=00: disable
+ * * SCU90[5:4]=01: 18 bits (R6/G6/B6) video mode.
+ * * SCU90[5:4]=10: 24 bits (R8/G8/B8) video mode.
+ * * SCU90[5:4]=11: 30 bits (R10/G10/B10) video mode.
+ *
+ * Re-writing:
+ *
+ * -----+---------+-----------+------------------------------+-----------+---------------+----------
+ *  T5    GPIOL1    VPIDE      (SCU90[5:4]=1 & SCU84[17]=1)    NDCD1       SCU84[17]=1     GPIOL1
+ *                             | (SCU90[5:4]=2 & SCU84[17]=1)
+ *                             | (SCU90[5:4]=3 & SCU84[17]=1)
+ * -----+---------+-----------+------------------------------+-----------+---------------+----------
+ *
+ * For reference the SCU84[17] bit configure the "UART1 NDCD1 or Video VPIDE
+ * function pin", where the signal itself is determined by whether SCU94[5:4]
+ * is disabled or in one of the 18, 24 or 30bit video modes.
+ *
+ * Other video-input-related pins require an explicit state in SCU90[5:4], e.g.
+ * W1 and U5:
+ *
+ * -----+---------+-----------+------------------------------+-----------+---------------+----------
+ *  W1    GPIOL6    VPIB0       SCU90[5:4]=3 & SCU84[22]=1     TXD1        SCU84[22]=1     GPIOL6
+ *  U5    GPIOL7    VPIB1       SCU90[5:4]=3 & SCU84[23]=1     RXD1        SCU84[23]=1     GPIOL7
+ * -----+---------+-----------+------------------------------+-----------+---------------+----------
+ *
+ * The examples of T5 and W1 are particularly fertile, as they also demonstrate
+ * that despite operating as part of the video input bus each signal needs to
+ * be enabled individually via it's own SCU84 (in the cases of T5 and W1)
+ * register bit. This is a little crazy if the bus doesn't have optional
+ * signals, but is used to decent effect with some of the UARTs where not all
+ * signals are required. However, this isn't done consistently - UART1 is
+ * enabled on a per-pin basis, and by contrast, all signals for UART6 are
+ * enabled by a single bit.
+ *
+ * Further, the high and low priority signals listed in the table above share
+ * a configuration bit. The VPI signals should operate in concert in a single
+ * function, but the UART signals should retain the ability to be configured
+ * independently. This pushes the implementation down the path of tagging a
+ * signal's expressions with the function they participate in, rather than
+ * defining masks affecting multiple signals per function. The latter approach
+ * fails in this instance where applying the configuration for the UART pin of
+ * interest will stomp on the state of other UART signals when disabling the
+ * VPI functions on the current pin.
+ *
+ * Ball |  Default   | P0 Signal | P0 Expression             | P1 Signal | P1 Expression | Other
+ * -----+------------+-----------+---------------------------+-----------+---------------+------------
+ *  A12   RGMII1TXCK   GPIOT0      SCUA0[0]=1                  RMII1TXEN   Strap[6]=0      RGMII1TXCK
+ *  B12   RGMII1TXCTL  GPIOT1      SCUA0[1]=1                  ?           Strap[6]=0      RGMII1TXCTL
+ * -----+------------+-----------+---------------------------+-----------+---------------+------------
+ *
+ * A12 demonstrates that the "Other" signal isn't always GPIO - in this case
+ * GPIOT0 is a high-priority signal and RGMII1TXCK is Other. Thus, GPIO
+ * should be treated like any other signal type with full function expression
+ * requirements, and not assumed to be the default case. Separately, GPIOT0 and
+ * GPIOT1's signal descriptor bits are distinct, therefore we must iterate all
+ * pins in the function's group to disable the higher-priority signals such
+ * that the signal for the function of interest is correctly enabled.
+ *
+ * Finally, three priority levels aren't always enough; the AST2500 brings with
+ * it 18 pins of five priority levels, however the 18 pins only use three of
+ * the five priority levels.
+ *
+ * Ultimately the requirement to control pins in the examples above drive the
+ * design:
+ *
+ * * Pins provide signals according to functions activated in the mux
+ *   configuration
+ *
+ * * Pins provide up to five signal types in a priority order
+ *
+ * * For priorities levels defined on a pin, each priority provides one signal
+ *
+ * * Enabling lower priority signals requires higher priority signals be
+ *   disabled
+ *
+ * * A function represents a set of signals; functions are distinct if their
+ *   sets of signals are not equal
+ *
+ * * Signals participate in one or more functions
+ *
+ * * A function is described by an expression of one or more signal
+ *   descriptors, which compare bit values in a register
+ *
+ * * A signal expression is the smallest set of signal descriptors whose
+ *   comparisons must evaluate 'true' for a signal to be enabled on a pin.
+ *
+ * * A function's signal is active on a pin if evaluating all signal
+ *   descriptors in the pin's signal expression for the function yields a 'true'
+ *   result
+ *
+ * * A signal at a given priority on a given pin is active if any of the
+ *   functions in which the signal participates are active, and no higher
+ *   priority signal on the pin is active
+ *
+ * * GPIO is configured per-pin
+ *
+ * And so:
+ *
+ * * To disable a signal, any function(s) activating the signal must be
+ *   disabled
+ *
+ * * Each pin must know the signal expressions of functions in which it
+ *   participates, for the purpose of enabling the Other function. This is done
+ *   by deactivating all functions that activate higher priority signals on the
+ *   pin.
+ *
+ * As a concrete example:
+ *
+ * * T5 provides three signals types: VPIDE, NDCD1 and GPIO
+ *
+ * * The VPIDE signal participates in 3 functions: VPI18, VPI24 and VPI30
+ *
+ * * The NDCD1 signal participates in just its own NDCD1 function
+ *
+ * * VPIDE is high priority, NDCD1 is low priority, and GPIOL1 is the least
+ *   prioritised
+ *
+ * * The prerequisit for activating the NDCD1 signal is that the VPI18, VPI24
+ *   and VPI30 functions all be disabled
+ *
+ * * Similarly, all of VPI18, VPI24, VPI30 and NDCD1 functions must be disabled
+ *   to provide GPIOL6
+ *
+ * Considerations
+ * --------------
+ *
+ * If pinctrl allows us to allocate a pin we can configure a function without
+ * concern for the function of already allocated pins, if pin groups are
+ * created with respect to the SoC functions in which they participate. This is
+ * intuitive, but it did not feel obvious from the bit/pin relationships.
+ *
+ * Conversely, failing to allocate all pins in a group indicates some bits (as
+ * well as pins) required for the group's configuration will already be in use,
+ * likely in a way that's inconsistent with the requirements of the failed
+ * group.
+ */
+
+/*
+ * The "Multi-function Pins Mapping and Control" table in the SoC datasheet
+ * references registers by the device/offset mnemonic. The register macros
+ * below are named the same way to ease transcription and verification (as
+ * opposed to naming them e.g. PINMUX_CTRL_[0-9]). Further, signal expressions
+ * reference registers beyond those dedicated to pinmux, such as the system
+ * reset control and MAC clock configuration registers. The AST2500 goes a step
+ * further and references registers in the graphics IP block, but that isn't
+ * handled yet.
+ */
+#define SCU3C           0x3C /* System Reset Control/Status Register */
+#define SCU48           0x48 /* MAC Interface Clock Delay Setting */
+#define HW_STRAP1       0x70 /* AST2400 strapping is 33 bits, is split */
+#define SCU80           0x80 /* Multi-function Pin Control #1 */
+#define SCU84           0x84 /* Multi-function Pin Control #2 */
+#define SCU88           0x88 /* Multi-function Pin Control #3 */
+#define SCU8C           0x8C /* Multi-function Pin Control #4 */
+#define SCU90           0x90 /* Multi-function Pin Control #5 */
+#define SCU94           0x94 /* Multi-function Pin Control #6 */
+#define SCUA0           0xA0 /* Multi-function Pin Control #7 */
+#define SCUA4           0xA4 /* Multi-function Pin Control #8 */
+#define SCUA8           0xA8 /* Multi-function Pin Control #9 */
+#define HW_STRAP2       0xD0 /* Strapping */
+
+ /**
+  * A signal descriptor, which describes the register, bits and the
+  * enable/disable values that should be compared or written.
+  *
+  * @reg: The register offset from base in bytes
+  * @mask: The mask to apply to the register. The lowest set bit of the mask is
+  *        used to derive the shift value.
+  * @enable: The value that enables the function. Value should be in the LSBs,
+  *          not at the position of the mask.
+  * @disable: The value that disables the function. Value should be in the
+  *           LSBs, not at the position of the mask.
+  */
+struct aspeed_sig_desc {
+	unsigned int reg;
+	u32 mask;
+	u32 enable;
+	u32 disable;
+};
+
+/**
+ * Describes a signal expression. The expression is evaluated by ANDing the
+ * evaluation of the descriptors.
+ *
+ * @signal: The signal name for the priority level on the pin
+ * @function: The name of the function the signal participates in for the
+ *            associated expression
+ * @ndescs: The number of signal descriptors in the expression
+ * @descs: Pointer to an array of signal descriptors that comprise the
+ *         function expression
+ */
+struct aspeed_sig_expr {
+	const char *signal;
+	const char *function;
+	int ndescs;
+	const struct aspeed_sig_desc *descs;
+};
+
+/**
+ * A struct capturing the list of expressions enabling signals at each priority
+ * for a given pin. The signal configuration for a priority level is evaluated
+ * by ORing the evaluation of the signal expressions in the respective
+ * priority's list.
+ *
+ * @name: A name for the pin
+ * @prios: A pointer to an array of expression list pointers
+ *
+ */
+struct aspeed_pin_desc {
+	const char *name;
+	const struct aspeed_sig_expr ***prios;
+};
+
+/* Macro hell */
+
+/**
+ * Short-hand macro for describing a configuration enabled by the state of one
+ * bit. The disable value is derived.
+ *
+ * @reg: The signal's associated register, offset from base
+ * @idx: The signal's bit index in the register
+ * @val: The value (0 or 1) that enables the function
+ */
+#define SIG_DESC_BIT(reg, idx, val) \
+	{ reg, BIT_MASK(idx), val, (((val) + 1) & 1) }
+
+/**
+ * A further short-hand macro describing a configuration enabled with a set bit.
+ *
+ * @reg: The configuration's associated register, offset from base
+ * @idx: The configuration's bit index in the register
+ */
+#define SIG_DESC_SET(reg, idx) SIG_DESC_BIT(reg, idx, 1)
+
+#define SIG_DESC_LIST_SYM(sig, func) sig_descs_ ## sig ## _ ## func
+#define SIG_DESC_LIST_DECL(sig, func, ...) \
+	static const struct aspeed_sig_desc SIG_DESC_LIST_SYM(sig, func)[] = \
+		{ __VA_ARGS__ }
+
+#define SIG_EXPR_SYM(sig, func) sig_expr_ ## sig ## _ ## func
+#define SIG_EXPR_DECL_(sig, func) \
+	static const struct aspeed_sig_expr SIG_EXPR_SYM(sig, func) = \
+	{ \
+		.signal = #sig, \
+		.function = #func, \
+		.ndescs = ARRAY_SIZE(SIG_DESC_LIST_SYM(sig, func)), \
+		.descs = &(SIG_DESC_LIST_SYM(sig, func))[0], \
+	}
+
+/**
+ * Declare a signal expression.
+ *
+ * @sig: A macro symbol name for the signal (is subjected to stringification
+ *        and token pasting)
+ * @func: The function in which the signal is participating
+ * @...: Signal descriptors that define the signal expression
+ *
+ * For example, the following declares the ROMD8 signal for the ROM16 function:
+ *
+ *     SIG_EXPR_DECL(ROMD8, ROM16, SIG_DESC_SET(SCU90, 6));
+ *
+ * And with multiple signal descriptors:
+ *
+ *     SIG_EXPR_DECL(ROMD8, ROM16S, SIG_DESC_SET(HW_STRAP1, 4),
+ *              { HW_STRAP1, GENMASK(1, 0), 0, 0 });
+ */
+#define SIG_EXPR_DECL(sig, func, ...) \
+	SIG_DESC_LIST_DECL(sig, func, __VA_ARGS__); \
+	SIG_EXPR_DECL_(sig, func)
+
+/**
+ * Declare a pointer to a signal expression
+ *
+ * @sig: The macro symbol name for the signal (subjected to token pasting)
+ * @func: The macro symbol name for the function (subjected to token pasting)
+ */
+#define SIG_EXPR_PTR(sig, func) (&SIG_EXPR_SYM(sig, func))
+
+#define SIG_EXPR_LIST_SYM(sig) sig_exprs_ ## sig
+
+/**
+ * Declare a signal expression list for reference in a struct aspeed_pin_prio.
+ *
+ * @sig: A macro symbol name for the signal (is subjected to token pasting)
+ * @...: Signal expression structure pointers (use SIG_EXPR_PTR())
+ *
+ * For example, the 16-bit ROM bus can be enabled by one of two possible signal
+ * expressions:
+ *
+ *     SIG_EXPR_DECL(ROMD8, ROM16, SIG_DESC_SET(SCU90, 6));
+ *     SIG_EXPR_DECL(ROMD8, ROM16S, SIG_DESC_SET(HW_STRAP1, 4),
+ *              { HW_STRAP1, GENMASK(1, 0), 0, 0 });
+ *     SIG_EXPR_LIST_DECL(ROMD8, SIG_EXPR_PTR(ROMD8, ROM16),
+ *              SIG_EXPR_PTR(ROMD8, ROM16S));
+ */
+#define SIG_EXPR_LIST_DECL(sig, ...) \
+	static const struct aspeed_sig_expr *SIG_EXPR_LIST_SYM(sig)[] = \
+		{ __VA_ARGS__, NULL }
+
+/**
+ * A short-hand macro for declaring a function expression and an expression
+ * list with a single function.
+ *
+ * @func: A macro symbol name for the function (is subjected to token pasting)
+ * @...: Function descriptors that define the function expression
+ *
+ * For example, signal NCTS6 participates in its own function with one group:
+ *
+ *     SIG_EXPR_LIST_DECL_SINGLE(NCTS6, NCTS6, SIG_DESC_SET(SCU90, 7));
+ */
+#define SIG_EXPR_LIST_DECL_SINGLE(sig, func, ...) \
+	SIG_DESC_LIST_DECL(sig, func, __VA_ARGS__); \
+	SIG_EXPR_DECL_(sig, func); \
+	SIG_EXPR_LIST_DECL(sig, SIG_EXPR_PTR(sig, func))
+
+#define SIG_EXPR_LIST_DECL_DUAL(sig, f0, f1) \
+	SIG_EXPR_LIST_DECL(sig, SIG_EXPR_PTR(sig, f0), SIG_EXPR_PTR(sig, f1))
+
+#define SIG_EXPR_LIST_PTR(sig) (&SIG_EXPR_LIST_SYM(sig)[0])
+
+#define PIN_EXPRS_SYM(pin) pin_exprs_ ## pin
+#define PIN_EXPRS_PTR(pin) (&PIN_EXPRS_SYM(pin)[0])
+#define PIN_SYM(pin) pin_ ## pin
+
+#define MS_PIN_DECL_(pin, ...) \
+	static const struct aspeed_sig_expr **PIN_EXPRS_SYM(pin)[] = \
+		{ __VA_ARGS__, NULL }; \
+	static const struct aspeed_pin_desc PIN_SYM(pin) = \
+		{ #pin, PIN_EXPRS_PTR(pin) }
+
+/**
+ * Declare a multi-signal pin
+ *
+ * @pin: The pin number
+ * @other: Macro name for "other" functionality (subjected to stringification)
+ * @high: Macro name for the highest priority signal functions
+ * @low: Macro name for the low signal functions
+ *
+ * For example:
+ *
+ *     #define A8 56
+ *     SIG_EXPR_DECL(ROMD8, ROM16, SIG_DESC_SET(SCU90, 6));
+ *     SIG_EXPR_DECL(ROMD8, ROM16S, SIG_DESC_SET(HW_STRAP1, 4),
+ *              { HW_STRAP1, GENMASK(1, 0), 0, 0 });
+ *     SIG_EXPR_LIST_DECL(ROMD8, SIG_EXPR_PTR(ROMD8, ROM16),
+ *              SIG_EXPR_PTR(ROMD8, ROM16S));
+ *     SIG_EXPR_LIST_DECL_SINGLE(NCTS6, NCTS6, SIG_DESC_SET(SCU90, 7));
+ *     MS_PIN_DECL(A8, GPIOH0, ROMD8, NCTS6);
+ */
+#define MS_PIN_DECL(pin, other, high, low) \
+	SIG_EXPR_LIST_DECL_SINGLE(other, other); \
+	MS_PIN_DECL_(pin, \
+			SIG_EXPR_LIST_PTR(high), \
+			SIG_EXPR_LIST_PTR(low), \
+			SIG_EXPR_LIST_PTR(other))
+
+#define PIN_GROUP_SYM(func) pins_ ## func
+#define FUNC_GROUP_SYM(func) groups_ ## func
+#define FUNC_GROUP_DECL(func, ...) \
+	static const int PIN_GROUP_SYM(func)[] = { __VA_ARGS__ }; \
+	static const char *const FUNC_GROUP_SYM(func)[] = { #func }
+
+/**
+ * Declare a single signal pin
+ *
+ * @pin: The pin number
+ * @other: Macro name for "other" functionality (subjected to stringification)
+ * @sig: Macro name for the signal (subjected to stringification)
+ *
+ * For example:
+ *
+ *     #define E3 80
+ *     SIG_EXPR_LIST_DECL_SINGLE(SCL5, I2C5, I2C5_DESC);
+ *     SS_PIN_DECL(E3, GPIOK0, SCL5);
+ */
+#define SS_PIN_DECL(pin, other, sig) \
+	SIG_EXPR_LIST_DECL_SINGLE(other, other); \
+	MS_PIN_DECL_(pin, SIG_EXPR_LIST_PTR(sig), SIG_EXPR_LIST_PTR(other))
+
+/**
+ * Single signal, single function pin declaration
+ *
+ * @pin: The pin number
+ * @other: Macro name for "other" functionality (subjected to stringification)
+ * @sig: Macro name for the signal (subjected to stringification)
+ * @...: Signal descriptors that define the function expression
+ *
+ * For example:
+ *
+ *    SSSF_PIN_DECL(A4, GPIOA2, TIMER3, SIG_DESC_SET(SCU80, 2));
+ */
+#define SSSF_PIN_DECL(pin, other, sig, ...) \
+	SIG_EXPR_LIST_DECL_SINGLE(sig, sig, __VA_ARGS__); \
+	SIG_EXPR_LIST_DECL_SINGLE(other, other); \
+	MS_PIN_DECL_(pin, SIG_EXPR_LIST_PTR(sig), SIG_EXPR_LIST_PTR(other)); \
+	FUNC_GROUP_DECL(sig, pin)
+
+struct aspeed_pinctrl_data {
+	struct regmap *map;
+
+	const struct pinctrl_pin_desc *pins;
+	const unsigned int npins;
+
+	const struct aspeed_pin_group *groups;
+	const unsigned int ngroups;
+
+	const struct aspeed_pin_function *functions;
+	const unsigned int nfunctions;
+};
+
+#define ASPEED_PINCTRL_PIN(name_) \
+	[name_] = { \
+		.number = name_, \
+		.name = #name_, \
+		.drv_data = (void *) &(PIN_SYM(name_)) \
+	}
+
+struct aspeed_pin_group {
+	const char *name;
+	const unsigned int *pins;
+	const unsigned int npins;
+};
+
+#define ASPEED_PINCTRL_GROUP(name_) { \
+	.name = #name_, \
+	.pins = &(PIN_GROUP_SYM(name_))[0], \
+	.npins = ARRAY_SIZE(PIN_GROUP_SYM(name_)), \
+}
+
+struct aspeed_pin_function {
+	const char *name;
+	const char *const *groups;
+	unsigned int ngroups;
+};
+
+#define ASPEED_PINCTRL_FUNC(name_, ...) { \
+	.name = #name_, \
+	.groups = &FUNC_GROUP_SYM(name_)[0], \
+	.ngroups = ARRAY_SIZE(FUNC_GROUP_SYM(name_)), \
+}
+
+int aspeed_pinctrl_get_groups_count(struct pinctrl_dev *pctldev);
+const char *aspeed_pinctrl_get_group_name(struct pinctrl_dev *pctldev,
+		unsigned int group);
+int aspeed_pinctrl_get_group_pins(struct pinctrl_dev *pctldev,
+		unsigned int group, const unsigned int **pins,
+		unsigned int *npins);
+void aspeed_pinctrl_pin_dbg_show(struct pinctrl_dev *pctldev,
+		struct seq_file *s, unsigned int offset);
+int aspeed_pinmux_get_fn_count(struct pinctrl_dev *pctldev);
+const char *aspeed_pinmux_get_fn_name(struct pinctrl_dev *pctldev,
+		unsigned int function);
+int aspeed_pinmux_get_fn_groups(struct pinctrl_dev *pctldev,
+		unsigned int function, const char * const **groups,
+		unsigned int * const num_groups);
+int aspeed_pinmux_set_mux(struct pinctrl_dev *pctldev, unsigned int function,
+		unsigned int group);
+int aspeed_gpio_request_enable(struct pinctrl_dev *pctldev,
+		struct pinctrl_gpio_range *range,
+		unsigned int offset);
+int aspeed_pinctrl_probe(struct platform_device *pdev,
+		struct pinctrl_desc *pdesc,
+		struct aspeed_pinctrl_data *pdata);
+
+#endif /* PINCTRL_ASPEED */
-- 
2.7.4
