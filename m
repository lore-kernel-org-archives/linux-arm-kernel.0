From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat,  7 Jun 2014 20:18:24 +0200
Subject: [RFC PATCH 1/3] clk: add pxa27x clock drivers
In-Reply-To: <1402165106-16534-1-git-send-email-robert.jarzmik@free.fr>
References: <1402165106-16534-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1402165106-16534-2-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move pxa27x clock drivers from arch/arm/mach-pxa to driver/clk.
In the move :
 - convert to new clock framework legacy clocks
 - provide clocks as before for platform data based boards
 - provide clocks through devicetree with clk-pxa-dt

This is the preliminary step in the conversion. The remaining steps are
:
 - migrate pxa25x and pxa3xx
 - once PXA is fully converted to device tree, if that happens,
 clk-pxa2* and clk-pxa3* should be deleted, and only clk-pxa-dt.c should
 survive in the long term.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/boot/dts/pxa27x.dtsi            | 112 +++++++++++++++-
 drivers/clk/Makefile                     |   1 +
 drivers/clk/pxa/Makefile                 |   4 +
 drivers/clk/pxa/clk-pxa-dt.c             |  56 ++++++++
 drivers/clk/pxa/clk-pxa27x.c             | 211 +++++++++++++++++++++++++++++++
 drivers/clk/pxa/clk-pxa2xx.c             |  75 +++++++++++
 drivers/clk/pxa/clk-pxa2xx.h             |  47 +++++++
 include/dt-bindings/clock/pxa2xx-clock.h |  45 +++++++
 8 files changed, 550 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/pxa/Makefile
 create mode 100644 drivers/clk/pxa/clk-pxa-dt.c
 create mode 100644 drivers/clk/pxa/clk-pxa27x.c
 create mode 100644 drivers/clk/pxa/clk-pxa2xx.c
 create mode 100644 drivers/clk/pxa/clk-pxa2xx.h
 create mode 100644 include/dt-bindings/clock/pxa2xx-clock.h

diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index a705469..7b151c0 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -1,5 +1,6 @@
 /* The pxa3xx skeleton simply augments the 2xx version */
-/include/ "pxa2xx.dtsi"
+#include "pxa2xx.dtsi"
+#include "dt-bindings/clock/pxa2xx-clock.h"
 
 / {
 	model = "Marvell PXA27x familiy SoC";
@@ -35,4 +36,113 @@
 			#pwm-cells = <1>;
 		};
 	};
+
+	clocks {
+	       /*
+		* The muxing of external clocks/internal dividers for osc* clock
+		* sources has been hidden under the carpet by now.
+		*/
+		osc13mhz:osc13mhz {
+			compatible = "fixed-clock";
+			 #clock-cells = <0>;
+			clock-frequency = <13000000>;
+		};
+
+		osc32_768khz:osc32_768khz {
+			compatible = "fixed-clock";
+			 #clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+
+		pll_312mhz:pll_312mhz {
+			compatible = "fixed-factor-clock";
+			clocks = <&osc13mhz>;
+			clock-div = <1>;
+			clock-mult = <24>;
+		};
+
+		clk_48mhz:clk_48mhz {
+			compatible = "fixed-factor-clock";
+			clocks = <&pll_312mhz>;
+			clock-div = <13>;
+			clock-mult = <2>;
+		};
+
+		clk_32_842mhz:clk_32_842mhz {
+			compatible = "fixed-factor-clock";
+			clocks = <&pll_312mhz>;
+			clock-div = <19>;
+			clock-mult = <2>;
+		};
+
+		clk_19_5mhz:clk_19_5mhz {
+			compatible = "fixed-factor-clock";
+			clocks = <&pll_312mhz>;
+			clock-div = <32>;
+			clock-mult = <2>;
+		};
+
+		clk_14_857mhz:clk_14_857mhz {
+			compatible = "fixed-factor-clock";
+			clocks = <&pll_312mhz>;
+			clock-div = <42>;
+			clock-mult = <2>;
+		};
+
+		clk_14_682mhz:clk_14_682mhz {
+			compatible = "fixed-factor-clock";
+			clocks = <&pll_312mhz>;
+			clock-div = <51>;
+			clock-mult = <2>;
+		};
+
+		clk_13mhz:clk_13mhz {
+			compatible = "fixed-factor-clock";
+			clocks = <&pll_312mhz>;
+			clock-div = <19>;
+			clock-mult = <2>;
+		};
+
+		clk_dummy:clk_dummy {
+			compatible = "fixed-clock";
+			 #clock-cells = <0>;
+			clock-frequency = <0>;
+		};
+
+		pxa2xx_clks: pxa2xx_clks at 41300004 {
+			compatible = "mrvl,pxa2xx-clocks";
+			clocks = <&clk_14_857mhz>, <&clk_14_857mhz>, <&clk_14_857mhz>,
+			       <&clk_14_682mhz>, <&clk_32_842mhz>, <&clk_48mhz>,
+			       <&clk_19_5mhz>, <&clk_48mhz>, <&clk_48mhz>,
+			       <&clk_13mhz>, <&osc32_768khz>, <&clk_13mhz>,
+			       <&clk_13mhz>, <&clk_13mhz>, <&clk_13mhz>,
+			       <&clk_13mhz>, <&clk_dummy>, <&clk_dummy>,
+			       <&clk_48mhz>, <&clk_48mhz>, <&clk_19_5mhz>,
+			       <&clk_dummy>, <&clk_dummy>,
+			       <&clk_dummy>, <&clk_dummy>;
+			#clock-cells = <1>;
+			clock-output-names =
+			         "pxa27x-ffuart", "pxa27x-btuart", "pxa27x-stuart",
+				 "pxa27x-i2s", "pxa27x-i2c.0", "pxa27x-udc",
+				 "pxa2xx-mci", "pxa2xx-ir", "pxa27x-ohci",
+				 "pxa2xx-i2c.1", "pxa27x-keypad", "pxa27x-ssp.0",
+				 "pxa27x-ssp.1", "pxa27x-ssp.2", "pxa27x-pwm.0",
+				 "pxa27x-pwm.1", "AC97CLK", "AC97CONFCLK",
+				 "MSLCLK", "USIMCLK", "MSTKCLK",
+				 "IMCLK", "MEMCLK",
+				 "pxa27x-gpio", "sa1100-rtc";
+			clock-indices = <
+				 CKEN_FFUART CKEN_BTUART CKEN_STUART
+				 CKEN_I2S CKEN_I2C CKEN_USB
+				 CKEN_MMC CKEN_FICP CKEN_USBHOST
+				 CKEN_PWRI2C CKEN_KEYPAD CKEN_SSP1
+				 CKEN_SSP2 CKEN_SSP3 CKEN_PWM0
+				 CKEN_PWM1 CKEN_AC97 CKEN_AC97CONF
+				 CKEN_MSL CKEN_USIM CKEN_MEMSTK
+				 CKEN_IM CKEN_MEMC
+				 0 0
+			>;
+		};
+	};
+
 };
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 5f8a287..2957154 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_ARCH_MMP)			+= mmp/
 endif
 obj-$(CONFIG_PLAT_ORION)		+= mvebu/
 obj-$(CONFIG_ARCH_MXS)			+= mxs/
+obj-$(CONFIG_ARCH_PXA)			+= pxa/
 obj-$(CONFIG_COMMON_CLK_QCOM)		+= qcom/
 obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
 obj-$(CONFIG_PLAT_SAMSUNG)		+= samsung/
diff --git a/drivers/clk/pxa/Makefile b/drivers/clk/pxa/Makefile
new file mode 100644
index 0000000..65ff461
--- /dev/null
+++ b/drivers/clk/pxa/Makefile
@@ -0,0 +1,4 @@
+obj-y				+= clk-pxa-dt.o
+obj-$(CONFIG_PXA25x)		+= clk-pxa2xx.o clk-pxa25x.o
+obj-$(CONFIG_PXA27x)		+= clk-pxa2xx.o clk-pxa27x.o
+obj-$(CONFIG_PXA3xx)		+= clk-pxa3xx.o
diff --git a/drivers/clk/pxa/clk-pxa-dt.c b/drivers/clk/pxa/clk-pxa-dt.c
new file mode 100644
index 0000000..a80ab56
--- /dev/null
+++ b/drivers/clk/pxa/clk-pxa-dt.c
@@ -0,0 +1,56 @@
+/*
+ * Marvell PXA2xx family clocks
+ *
+ * Copyright (C) 2014 Robert Jarzmik
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <mach/pxa2xx-regs.h>
+
+#define PXA2XX_MAX_CLOCKS		32
+
+static DEFINE_SPINLOCK(cken_lock);
+
+static void __init pxa2xx_clocks_init(struct device_node *np)
+{
+	struct clk *clk;
+	const char *name;
+	const char *parent_name;
+	int i, ret;
+	u32 clkidx;
+	void __iomem *reg;
+
+	reg = of_iomap(np, 0);
+	if (!reg)
+		return;
+
+	for (i = 0; i < PXA2XX_MAX_CLOCKS; i++) {
+		ret = of_property_read_string_index(np, "clock-output-names",
+						    i, &name);
+		if (ret < 0 || strlen(name) == 0)
+			continue;
+
+		parent_name = of_clk_get_parent_name(np, i);
+		ret = of_property_read_u32_index(np, "clock-indices", i,
+						 &clkidx);
+		if (parent_name == NULL || ret < 0)
+			break;
+		if (clkidx >= PXA2XX_MAX_CLOCKS) {
+			pr_err("%s: invalid clock %s %s index %u)\n",
+			       __func__, np->name, name, clkidx);
+			continue;
+		}
+
+		clk = clk_register_gate(NULL, name, parent_name, 0,
+					reg, clkidx, 0, &cken_lock);
+	}
+}
+CLK_OF_DECLARE(pxa2xx_clks, "mrvl,pxa-clocks", pxa2xx_clocks_init);
diff --git a/drivers/clk/pxa/clk-pxa27x.c b/drivers/clk/pxa/clk-pxa27x.c
new file mode 100644
index 0000000..28a461c
--- /dev/null
+++ b/drivers/clk/pxa/clk-pxa27x.c
@@ -0,0 +1,211 @@
+/*
+ * Marvell PXA27x family clocks
+ *
+ * Copyright (C) 2014 Robert Jarzmik
+ *
+ * Heavily inspired from former arch/arm/mach-pxa/clock.c.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * For non-devicetree platforms. Once pxa is fully converted to devicetree, this
+ * should go away.
+ */
+#include <linux/clk-provider.h>
+#include <mach/pxa2xx-regs.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/of.h>
+
+#include "clk-pxa2xx.h"
+
+static DEFINE_SPINLOCK(cken_lock);
+
+/* Crystal clock: 13MHz */
+#define BASE_CLK	13000000
+
+/*
+ * Get the clock frequency as reflected by CCSR and the turbo flag.
+ * We assume these values have been applied via a fcs.
+ * If info is not 0 we also display the current settings.
+ */
+unsigned int pxa27x_get_clk_frequency_khz(int info)
+{
+	unsigned long ccsr, clkcfg;
+	unsigned int l, L, m, M, n2, N, S;
+       	int cccr_a, t, ht, b;
+
+	ccsr = CCSR;
+	cccr_a = CCCR & (1 << 25);
+
+	/* Read clkcfg register: it has turbo, b, half-turbo (and f) */
+	asm( "mrc\tp14, 0, %0, c6, c0, 0" : "=r" (clkcfg) );
+	t  = clkcfg & (1 << 0);
+	ht = clkcfg & (1 << 2);
+	b  = clkcfg & (1 << 3);
+
+	l  = ccsr & 0x1f;
+	n2 = (ccsr>>7) & 0xf;
+	m  = (l <= 10) ? 1 : (l <= 20) ? 2 : 4;
+
+	L  = l * BASE_CLK;
+	N  = (L * n2) / 2;
+	M  = (!cccr_a) ? (L/m) : ((b) ? L : (L/2));
+	S  = (b) ? L : (L/2);
+
+	if (info) {
+		printk( KERN_INFO "Run Mode clock: %d.%02dMHz (*%d)\n",
+			L / 1000000, (L % 1000000) / 10000, l );
+		printk( KERN_INFO "Turbo Mode clock: %d.%02dMHz (*%d.%d, %sactive)\n",
+			N / 1000000, (N % 1000000)/10000, n2 / 2, (n2 % 2)*5,
+			(t) ? "" : "in" );
+		printk( KERN_INFO "Memory clock: %d.%02dMHz (/%d)\n",
+			M / 1000000, (M % 1000000) / 10000, m );
+		printk( KERN_INFO "System bus clock: %d.%02dMHz \n",
+			S / 1000000, (S % 1000000) / 10000 );
+	}
+
+	return (t) ? (N/1000) : (L/1000);
+}
+
+/*
+ * Return the current mem clock frequency as reflected by CCCR[A], B, and L
+ */
+static unsigned long clk_pxa27x_mem_getrate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	unsigned long ccsr, clkcfg;
+	unsigned int l, L, m, M;
+       	int cccr_a, b;
+
+	ccsr = CCSR;
+	cccr_a = CCCR & (1 << 25);
+
+	/* Read clkcfg register: it has turbo, b, half-turbo (and f) */
+	asm( "mrc\tp14, 0, %0, c6, c0, 0" : "=r" (clkcfg) );
+	b = clkcfg & (1 << 3);
+
+	l = ccsr & 0x1f;
+	m = (l <= 10) ? 1 : (l <= 20) ? 2 : 4;
+
+	L = l * BASE_CLK;
+	M = (!cccr_a) ? (L/m) : ((b) ? L : (L/2));
+
+	return M;
+}
+
+static const struct clk_ops clk_pxa27x_mem_ops = {
+	.recalc_rate = clk_pxa27x_mem_getrate,
+};
+
+/*
+ * Return the current LCD clock frequency in units of 10kHz as
+ */
+static unsigned int pxa27x_get_lcdclk_frequency_10khz(void)
+{
+	unsigned long ccsr;
+	unsigned int l, L, k, K;
+
+	ccsr = CCSR;
+
+	l = ccsr & 0x1f;
+	k = (l <= 7) ? 1 : (l <= 16) ? 2 : 4;
+
+	L = l * BASE_CLK;
+	K = L / k;
+
+	return (K / 10000);
+}
+
+static unsigned long clk_pxa27x_lcd_getrate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	return pxa27x_get_lcdclk_frequency_10khz() * 10000;
+}
+
+static const struct clk_ops clk_pxa27x_lcd_ops = {
+	.recalc_rate	= clk_pxa27x_lcd_getrate,
+};
+
+static struct __initdata pxa27x_clocks_fixed_cken pxa27x_without_dt_clocks[] = {
+	PXA2_FIXED_RATE("pxa2xx-uart.0", NULL, FFUART, 14857000, 1),
+	PXA2_FIXED_RATE("pxa2xx-uart.1", NULL, BTUART, 14857000, 1),
+	PXA2_FIXED_RATE("pxa2xx-uart.2", NULL, STUART, 14857000, 1),
+	PXA2_FIXED_RATE("pxa2xx-uart.2", "UARTCLK", STUART, 14857000, 1),
+	PXA2_FIXED_RATE("pxa2xx-i2s", NULL, I2S, 14682000, 0),
+	PXA2_FIXED_RATE("pxa2xx-i2c.0", NULL, I2C, 32842000, 0),
+	PXA2_FIXED_RATE("pxa27x-udc", NULL, USB, 48000000, 5),
+	PXA2_FIXED_RATE("pxa2xx-mci.0", NULL, MMC, 19500000, 0),
+	PXA2_FIXED_RATE("pxa2xx-ir", "FICPCLK", FICP, 48000000, 0),
+	PXA2_FIXED_RATE("pxa27x-ohci", NULL, USBHOST, 48000000, 0),
+	PXA2_FIXED_RATE("pxa2xx-i2c.1", NULL, PWRI2C, 13000000, 0),
+	PXA2_FIXED_RATE("pxa27x-keypad", NULL, KEYPAD, 32768, 0),
+	PXA2_FIXED_RATE("pxa27x-ssp.0", NULL, SSP1, 13000000, 0),
+	PXA2_FIXED_RATE("pxa27x-ssp.1", NULL, SSP2, 13000000, 0),
+	PXA2_FIXED_RATE("pxa27x-ssp.2", NULL, SSP3, 13000000, 0),
+	PXA2_FIXED_RATE("pxa27x-pwm.0", NULL, PWM0, 13000000, 0),
+	PXA2_FIXED_RATE("pxa27x-pwm.1", NULL, PWM1, 13000000, 0),
+	PXA2_FIXED_RATE("pxa2xx-ac97", "AC97CLK", AC97, 24576000, 0),
+	PXA2_FIXED_RATE("pxa2xx-ac97", "AC97CONFCLK", AC97CONF, 24576000, 0),
+	PXA2_FIXED_RATE("pxa27x-msl", "MSLCLK", MSL, 48000000, 0),
+	PXA2_FIXED_RATE("pxa27x-usim", "USIMCLK", USIM, 48000000, 0),
+	PXA2_FIXED_RATE("pxa27x-memstk", "MSTKCLK", MEMSTK, 19500000, 0),
+	PXA2_FIXED_RATE("pxa27x-im", "IMCLK", IM, 0, 0),
+	PXA2_FIXED_RATE_AO("pxa27x-memc", "MEMCLK", MEMC, 0, 0),
+	{ .name = NULL, },
+};
+
+static struct __initdata pxa27x_clocks_var_rate pxa27x_var_rate_clocks[] = {
+	PXA2_VAR_RATE("pxa2xx-fb", true, LCD, &clk_pxa27x_lcd_ops),
+	PXA2_VAR_RATE("pxa27x-camera.0", true, CAMERA, &clk_pxa27x_lcd_ops),
+	PXA2_VAR_RATE("pxa2xx-pcmcia", false, MEMC, &clk_pxa27x_mem_ops),
+	{ .name = NULL, },
+};
+
+static int __init pxa27x_clocks_init(void)
+{
+	unsigned long rate, flags;
+	struct clk *clk_parent, *clk;
+	struct pxa27x_clocks_fixed_cken *fclock;
+	struct pxa27x_clocks_var_rate *vclock;
+
+	char parent_name[80];
+
+	for (fclock = pxa27x_without_dt_clocks;
+	     !of_have_populated_dt() && fclock->name; fclock++) {
+		clk_parent = NULL;
+		rate = fclock->rate;
+		snprintf(parent_name, sizeof(parent_name), "clk-%lu", rate);
+		flags = CLK_GET_RATE_NOCACHE | CLK_IS_ROOT;
+		clk_parent = clk_register_fixed_rate(NULL, parent_name, NULL,
+						     flags, rate);
+		flags = fclock->always_on ? CLK_IGNORE_UNUSED : 0;
+		clk = clk_register_gate(NULL, fclock->name, parent_name, 0,
+					(void *)&CKEN, fclock->cken, flags,
+					&cken_lock);
+		if (!IS_ERR(clk))
+			clk_register_clkdev(clk, fclock->con_id, fclock->name);
+	}
+
+	for (vclock = pxa27x_var_rate_clocks; vclock->name; vclock++) {
+		flags = CLK_GET_RATE_NOCACHE;
+		if (vclock->has_cken) {
+			snprintf(parent_name, sizeof(parent_name), "clk-%s",
+				 vclock->name);
+			clk_parent = clk_pxa2xx_register_dummy(parent_name,
+							       vclock->clk_ops);
+			clk = clk_register_gate(NULL, vclock->name, parent_name,
+						flags, (void *)&CKEN, vclock->cken,
+						0, &cken_lock);
+		} else {
+			clk = clk_pxa2xx_register_dummy(vclock->name, vclock->clk_ops);
+		}
+		if (!IS_ERR(clk))
+			clk_register_clkdev(clk, NULL, vclock->name);
+	}
+	return 0;
+}
+
+postcore_initcall(pxa27x_clocks_init);
diff --git a/drivers/clk/pxa/clk-pxa2xx.c b/drivers/clk/pxa/clk-pxa2xx.c
new file mode 100644
index 0000000..00929c9
--- /dev/null
+++ b/drivers/clk/pxa/clk-pxa2xx.c
@@ -0,0 +1,75 @@
+/*
+ * Marvell PXA2xx family clocks
+ *
+ * Copyright (C) 2014 Robert Jarzmik
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+//#include <linux/of.h>
+#include <linux/syscore_ops.h>
+#include <mach/pxa2xx-regs.h>
+
+struct dummy_clk {
+	struct clk_hw		hw;
+};
+
+struct clk * __init clk_pxa2xx_register_dummy(const char *name,
+					      const struct clk_ops *ops)
+{
+	struct clk_init_data init;
+	struct dummy_clk *clock;
+	struct clk *clk;
+
+	clock = kzalloc(sizeof(*clock), GFP_KERNEL);
+	if (!clock) {
+		pr_err("%s: failed to allocate PXA2xx clock.\n", __func__);
+		return ERR_PTR(-ENOMEM);
+	}
+	init.name = name;
+	init.ops = ops;
+	init.parent_names = NULL;
+	init.num_parents = 0;
+	init.flags = CLK_IS_BASIC | CLK_GET_RATE_NOCACHE;
+	clock->hw.init = &init;
+	clk = clk_register(NULL, &clock->hw);
+	if (IS_ERR(clk))
+		kfree(clock);
+	return clk;
+}
+
+
+#ifdef CONFIG_PM
+static uint32_t saved_cken;
+
+static int pxa2xx_clock_suspend(void)
+{
+	saved_cken = CKEN;
+	return 0;
+}
+
+static void pxa2xx_clock_resume(void)
+{
+	CKEN = saved_cken;
+}
+#else
+#define pxa2xx_clock_suspend	NULL
+#define pxa2xx_clock_resume	NULL
+#endif
+
+static struct syscore_ops pxa2xx_clock_syscore_ops = {
+	.suspend	= pxa2xx_clock_suspend,
+	.resume		= pxa2xx_clock_resume,
+};
+
+static int __init pxa2xx_clocks_init(void)
+{
+	register_syscore_ops(&pxa2xx_clock_syscore_ops);
+	return 0;
+}
+
+postcore_initcall(pxa2xx_clocks_init);
diff --git a/drivers/clk/pxa/clk-pxa2xx.h b/drivers/clk/pxa/clk-pxa2xx.h
new file mode 100644
index 0000000..79f62af
--- /dev/null
+++ b/drivers/clk/pxa/clk-pxa2xx.h
@@ -0,0 +1,47 @@
+/*
+ * Marvell PXA27x family clocks
+ *
+ * Copyright (C) 2014 Robert Jarzmik
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * For non-devicetree platforms. Once pxa is fully converted to devicetree, this
+ * should go away.
+ */
+
+#ifndef _CLK_PXA2XX_H_
+#define _CLK_PXA2XX_H_
+
+#define	PXA2_VAR_RATE(_name, _has_cken, _cken, _clk_ops)	\
+	{ .name = _name, .has_cken = _has_cken, .cken = CKEN_ ## _cken,	\
+	  .clk_ops = _clk_ops }
+
+struct pxa27x_clocks_var_rate {
+	char *name;
+	bool has_cken;
+	unsigned int cken;
+	const struct clk_ops *clk_ops;
+};
+
+#define PXA2_FIXED_RATE(_name, _con_id, _cken, _rate, _delay) \
+	{ .name = _name, .con_id = _con_id, .cken = CKEN_ ## _cken,	\
+	  .rate = _rate, .delay = _delay, .always_on = false, }
+#define PXA2_FIXED_RATE_AO(_name, _con_id, _cken, _rate, _delay) \
+	{ .name = _name, .con_id = _con_id, .cken = CKEN_ ## _cken,	\
+	  .rate = _rate, .delay = _delay, .always_on = true, }
+
+struct pxa27x_clocks_fixed_cken {
+	char *name;
+	char *con_id;
+	unsigned int cken;
+	unsigned long rate;
+	int delay;
+	bool always_on;
+};
+
+extern struct clk * __init clk_pxa2xx_register_dummy(const char *name,
+						     const struct clk_ops *ops);
+
+#endif
diff --git a/include/dt-bindings/clock/pxa2xx-clock.h b/include/dt-bindings/clock/pxa2xx-clock.h
new file mode 100644
index 0000000..5ffba58
--- /dev/null
+++ b/include/dt-bindings/clock/pxa2xx-clock.h
@@ -0,0 +1,45 @@
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
+#define CKEN_AC97CONF   (31)    /* AC97 Controller Configuration */
+#define CKEN_CAMERA	(24)	/* Camera Interface Clock Enable */
+#define CKEN_SSP1	(23)	/* SSP1 Unit Clock Enable */
+#define CKEN_MEMC	(22)	/* Memory Controller Clock Enable */
+#define CKEN_MEMSTK	(21)	/* Memory Stick Host Controller */
+#define CKEN_IM		(20)	/* Internal Memory Clock Enable */
+#define CKEN_KEYPAD	(19)	/* Keypad Interface Clock Enable */
+#define CKEN_USIM	(18)	/* USIM Unit Clock Enable */
+#define CKEN_MSL	(17)	/* MSL Unit Clock Enable */
+#define CKEN_LCD	(16)	/* LCD Unit Clock Enable */
+#define CKEN_PWRI2C	(15)	/* PWR I2C Unit Clock Enable */
+#define CKEN_I2C	(14)	/* I2C Unit Clock Enable */
+#define CKEN_FICP	(13)	/* FICP Unit Clock Enable */
+#define CKEN_MMC	(12)	/* MMC Unit Clock Enable */
+#define CKEN_USB	(11)	/* USB Unit Clock Enable */
+#define CKEN_ASSP	(10)	/* ASSP (SSP3) Clock Enable */
+#define CKEN_USBHOST	(10)	/* USB Host Unit Clock Enable */
+#define CKEN_OSTIMER	(9)	/* OS Timer Unit Clock Enable */
+#define CKEN_NSSP	(9)	/* NSSP (SSP2) Clock Enable */
+#define CKEN_I2S	(8)	/* I2S Unit Clock Enable */
+#define CKEN_BTUART	(7)	/* BTUART Unit Clock Enable */
+#define CKEN_FFUART	(6)	/* FFUART Unit Clock Enable */
+#define CKEN_STUART	(5)	/* STUART Unit Clock Enable */
+#define CKEN_HWUART	(4)	/* HWUART Unit Clock Enable */
+#define CKEN_SSP3	(4)	/* SSP3 Unit Clock Enable */
+#define CKEN_SSP	(3)	/* SSP Unit Clock Enable */
+#define CKEN_SSP2	(3)	/* SSP2 Unit Clock Enable */
+#define CKEN_AC97	(2)	/* AC97 Unit Clock Enable */
+#define CKEN_PWM1	(1)	/* PWM1 Clock Enable */
+#define CKEN_PWM0	(0)	/* PWM0 Clock Enable */
+
+#endif
-- 
2.0.0.rc2
