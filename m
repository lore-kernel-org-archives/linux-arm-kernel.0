From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 14 Jul 2014 17:54:18 +0200
Subject: [PATCH v2 1/6] clk: add pxa clocks infrastructure
In-Reply-To: <1405353263-13424-1-git-send-email-robert.jarzmik@free.fr>
References: <1405353263-13424-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1405353263-13424-2-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a the common code used by all PXA variants.

This is the first step in the transition from architecture defined
clocks (in arch/arm/mach-pxa) towards clock framework. The goal is to
have the same features (and not all the features) of the existing
clocks, and enable the transition of PXA to device-tree.

All PXA rely on a "CKEN" type clock, which :
 - has a gate (bit in CKEN register)
 - is generated from a PLL, generally divided
 - has an alternate low power clock

Each variant will specialize the CKEN clock :
 - pxa25x have no low power clock
 - pxa27x in low power use always the 13 MHz ring oscillator
 - pxa3xx in low power have specific dividers for each clock

The device-tree provides a list of CLK_* (ex: CLK_USB or CLK_I2C) to get
a handle on the clock. While pxa-clock.h will describe all the clocks of
all the variants, each variant will only use a subset of it.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/clk/Makefile                  |   1 +
 drivers/clk/pxa/Makefile              |   1 +
 drivers/clk/pxa/clk-pxa.c             |  97 ++++++++++++++++++++++++++++++
 drivers/clk/pxa/clk-pxa.h             | 107 ++++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/pxa-clock.h |  77 ++++++++++++++++++++++++
 5 files changed, 283 insertions(+)
 create mode 100644 drivers/clk/pxa/Makefile
 create mode 100644 drivers/clk/pxa/clk-pxa.c
 create mode 100644 drivers/clk/pxa/clk-pxa.h
 create mode 100644 include/dt-bindings/clock/pxa-clock.h

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 567f102..40390ea 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_ARCH_MMP)			+= mmp/
 endif
 obj-$(CONFIG_PLAT_ORION)		+= mvebu/
 obj-$(CONFIG_ARCH_MXS)			+= mxs/
+obj-$(CONFIG_ARCH_PXA)			+= pxa/
 obj-$(CONFIG_COMMON_CLK_QCOM)		+= qcom/
 obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
 obj-$(CONFIG_COMMON_CLK_SAMSUNG)	+= samsung/
diff --git a/drivers/clk/pxa/Makefile b/drivers/clk/pxa/Makefile
new file mode 100644
index 0000000..cb2bd8f
--- /dev/null
+++ b/drivers/clk/pxa/Makefile
@@ -0,0 +1 @@
+obj-y				+= clk-pxa.o
diff --git a/drivers/clk/pxa/clk-pxa.c b/drivers/clk/pxa/clk-pxa.c
new file mode 100644
index 0000000..ef3c053
--- /dev/null
+++ b/drivers/clk/pxa/clk-pxa.c
@@ -0,0 +1,97 @@
+/*
+ * Marvell PXA family clocks
+ *
+ * Copyright (C) 2014 Robert Jarzmik
+ *
+ * Common clock code for PXA clocks ("CKEN" type clocks + DT)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ */
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/of.h>
+
+#include <dt-bindings/clock/pxa-clock.h>
+#include "clk-pxa.h"
+
+DEFINE_SPINLOCK(lock);
+
+static struct clk *pxa_clocks[CLK_MAX];
+static struct clk_onecell_data onecell_data = {
+	.clks = pxa_clocks,
+	.clk_num = CLK_MAX,
+};
+
+#define to_pxa_clk(_hw) container_of(_hw, struct pxa_clk_cken, hw)
+
+static unsigned long cken_recalc_rate(struct clk_hw *hw,
+				      unsigned long parent_rate)
+{
+	struct pxa_clk_cken *pclk = to_pxa_clk(hw);
+	struct clk_fixed_factor *fix;
+
+	if (!pclk->is_in_low_power || pclk->is_in_low_power())
+		fix = &pclk->lp;
+	else
+		fix = &pclk->hp;
+	fix->hw.clk = hw->clk;
+	return clk_fixed_factor_ops.recalc_rate(&fix->hw, parent_rate);
+}
+
+static struct clk_ops cken_rate_ops = {
+	.recalc_rate = cken_recalc_rate,
+};
+
+static u8 cken_get_parent(struct clk_hw *hw)
+{
+	struct pxa_clk_cken *pclk = to_pxa_clk(hw);
+
+	if (!pclk->is_in_low_power)
+		return 0;
+	return pclk->is_in_low_power() ? 0 : 1;
+}
+
+static struct clk_ops cken_mux_ops = {
+	.get_parent = cken_get_parent,
+	.set_parent = dummy_clk_set_parent,
+};
+
+void __init clkdev_pxa_register(int ckid, const char *con_id,
+				const char *dev_id, struct clk *clk)
+{
+	if (!IS_ERR(clk) && (ckid != CLK_NONE))
+		pxa_clocks[ckid] = clk;
+	if (!IS_ERR(clk))
+		clk_register_clkdev(clk, con_id, dev_id);
+}
+
+int __init clk_pxa_cken_init(struct pxa_clk_cken *clks, int nb_clks)
+{
+	int i;
+	struct pxa_clk_cken *pclk;
+	struct clk *clk;
+
+	for (i = 0; i < nb_clks; i++) {
+		pclk = clks + i;
+		pclk->gate.lock = &lock;
+		clk = clk_register_composite(NULL, pclk->name,
+					     pclk->parent_names, 2,
+					     &pclk->hw, &cken_mux_ops,
+					     &pclk->hw, &cken_rate_ops,
+					     &pclk->gate.hw, &clk_gate_ops,
+					     pclk->flags);
+		clkdev_pxa_register(pclk->ckid, pclk->con_id, pclk->dev_id,
+				    clk);
+	}
+	return 0;
+}
+
+static void __init pxa_dt_clocks_init(struct device_node *np)
+{
+	of_clk_add_provider(np, of_clk_src_onecell_get, &onecell_data);
+}
+CLK_OF_DECLARE(pxa_clks, "marvell,pxa-clocks", pxa_dt_clocks_init);
diff --git a/drivers/clk/pxa/clk-pxa.h b/drivers/clk/pxa/clk-pxa.h
new file mode 100644
index 0000000..5fe219d
--- /dev/null
+++ b/drivers/clk/pxa/clk-pxa.h
@@ -0,0 +1,107 @@
+/*
+ * Marvell PXA family clocks
+ *
+ * Copyright (C) 2014 Robert Jarzmik
+ *
+ * Common clock code for PXA clocks ("CKEN" type clocks + DT)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ */
+#ifndef _CLK_PXA_
+#define _CLK_PXA_
+
+#define PARENTS(name) \
+	static const char *name ## _parents[] __initconst
+#define MUX_RO_RATE_RO_OPS(name, clk_name)			\
+	static struct clk_hw name ## _mux_hw;			\
+	static struct clk_hw name ## _rate_hw;			\
+	static struct clk_ops name ## _mux_ops = {		\
+		.get_parent = name ## _get_parent,		\
+		.set_parent = dummy_clk_set_parent,		\
+	};							\
+	static struct clk_ops name ## _rate_ops = {		\
+		.recalc_rate = name ## _get_rate,		\
+	};							\
+	static struct clk *clk_register_ ## name(void)		\
+	{							\
+		return clk_register_composite(NULL, clk_name,	\
+			name ## _parents,			\
+			ARRAY_SIZE(name ## _parents),		\
+			&name ## _mux_hw, &name ## _mux_ops,	\
+			&name ## _rate_hw, &name ## _rate_ops,	\
+			NULL, NULL, CLK_GET_RATE_NOCACHE);	\
+	}
+
+#define RATE_RO_OPS(name, clk_name)			\
+	static struct clk_hw name ## _rate_hw;			\
+	static struct clk_ops name ## _rate_ops = {		\
+		.recalc_rate = name ## _get_rate,		\
+	};							\
+	static struct clk *clk_register_ ## name(void)		\
+	{							\
+		return clk_register_composite(NULL, clk_name,	\
+			name ## _parents,			\
+			ARRAY_SIZE(name ## _parents),		\
+			NULL, NULL,				\
+			&name ## _rate_hw, &name ## _rate_ops,	\
+			NULL, NULL, CLK_GET_RATE_NOCACHE);	\
+	}
+
+/*
+ * CKEN clock type
+ * This clock takes it source from 2 possible parents :
+ *  - a low power parent
+ *  - a normal parent
+ *
+ *  +------------+     +-----------+
+ *  |  Low Power | --- | x mult_lp |
+ *  |    Clock   |     | / div_lp  |\
+ *  +------------+     +-----------+ \+-----+   +-----------+
+ *                                    | Mux |---| CKEN gate |
+ *  +------------+     +-----------+ /+-----+   +-----------+
+ *  | High Power |     | x mult_hp |/
+ *  |    Clock   | --- | / div_hp  |
+ *  +------------+     +-----------+
+ */
+struct pxa_clk_cken {
+	struct clk_hw hw;
+	int ckid;
+	const char *name;
+	const char *dev_id;
+	const char *con_id;
+	const char **parent_names;
+	struct clk_fixed_factor lp;
+	struct clk_fixed_factor hp;
+	struct clk_gate gate;
+	bool (*is_in_low_power)(void);
+	const unsigned long flags;
+};
+
+#define PXA_CKEN(_dev_id, _con_id, _name, parents, _mult_lp, _div_lp,	\
+		 _mult_hp, _div_hp, is_lp, _cken_reg, _cken_bit, flag)	\
+	{ .ckid = CLK_ ## _name, .name = #_name,			\
+	  .dev_id = _dev_id, .con_id = _con_id,	.parent_names = parents,\
+	  .lp = { .mult = _mult_lp, .div = _div_lp },			\
+	  .hp = { .mult = _mult_hp, .div = _div_hp },			\
+	  .is_in_low_power = is_lp,					\
+	  .gate = { .reg = (void __iomem *)_cken_reg, .bit_idx = _cken_bit }, \
+	  .flags = flag,						\
+	}
+#define PXA_CKEN_1RATE(dev_id, con_id, name, parents, cken_reg,		\
+			    cken_bit, flag)				\
+	PXA_CKEN(dev_id, con_id, name, parents, 1, 1, 1, 1,		\
+		 NULL, cken_reg, cken_bit, flag)
+
+static int dummy_clk_set_parent(struct clk_hw *hw, u8 index)
+{
+	return 0;
+}
+
+extern void clkdev_pxa_register(int ckid, const char *con_id,
+				const char *dev_id, struct clk *clk);
+extern int clk_pxa_cken_init(struct pxa_clk_cken *clks, int nb_clks);
+
+#endif
diff --git a/include/dt-bindings/clock/pxa-clock.h b/include/dt-bindings/clock/pxa-clock.h
new file mode 100644
index 0000000..e65803b
--- /dev/null
+++ b/include/dt-bindings/clock/pxa-clock.h
@@ -0,0 +1,77 @@
+/*
+ * Inspired by original work from pxa2xx-regs.h by Nicolas Pitre
+ * Copyright (C) 2014 Robert Jarzmik
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_PXA2XX_H__
+#define __DT_BINDINGS_CLOCK_PXA2XX_H__
+
+#define CLK_NONE 0
+#define CLK_1WIRE 1
+#define CLK_AC97 2
+#define CLK_AC97CONF 3
+#define CLK_ASSP 4
+#define CLK_BOOT 5
+#define CLK_BTUART 6
+#define CLK_CAMERA 7
+#define CLK_CIR 8
+#define CLK_CORE 9
+#define CLK_DMC 10
+#define CLK_FFUART 11
+#define CLK_FICP 12
+#define CLK_GPIO 13
+#define CLK_HSIO2 14
+#define CLK_HWUART 15
+#define CLK_I2C 16
+#define CLK_I2S 17
+#define CLK_IM 18
+#define CLK_INC 19
+#define CLK_ISC 20
+#define CLK_KEYPAD 21
+#define CLK_LCD 22
+#define CLK_MEMC 23
+#define CLK_MEMSTK 24
+#define CLK_MINI_IM 25
+#define CLK_MINI_LCD 26
+#define CLK_MMC 27
+#define CLK_MMC1 28
+#define CLK_MMC2 29
+#define CLK_MMC3 30
+#define CLK_MSL 31
+#define CLK_MSL0 32
+#define CLK_MVED 33
+#define CLK_NAND 34
+#define CLK_NSSP 35
+#define CLK_OSTIMER 36
+#define CLK_PWM0 37
+#define CLK_PWM1 38
+#define CLK_PWM2 39
+#define CLK_PWM3 40
+#define CLK_PWRI2C 41
+#define CLK_PXA300_GCU 42
+#define CLK_PXA320_GCU 43
+#define CLK_SMC 44
+#define CLK_SSP 45
+#define CLK_SSP1 46
+#define CLK_SSP2 47
+#define CLK_SSP3 48
+#define CLK_SSP4 49
+#define CLK_STUART 50
+#define CLK_TOUCH 51
+#define CLK_TPM 52
+#define CLK_UDC 53
+#define CLK_USB 54
+#define CLK_USB2 55
+#define CLK_USBH 56
+#define CLK_USBHOST 57
+#define CLK_USIM 58
+#define CLK_USIM1 59
+#define CLK_USMI0 60
+#define CLK_MAX 61
+
+#endif
-- 
2.0.0.rc2
