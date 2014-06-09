From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 09 Jun 2014 22:09:14 +0200
Subject: [RFC PATCH 1/3] clk: add pxa27x clock drivers
In-Reply-To: <1402165106-16534-2-git-send-email-robert.jarzmik@free.fr>
 (Robert Jarzmik's message of "Sat, 7 Jun 2014 20:18:24 +0200")
References: <1402165106-16534-1-git-send-email-robert.jarzmik@free.fr>
 <1402165106-16534-2-git-send-email-robert.jarzmik@free.fr>
Message-ID: <877g4pzvyt.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:
...zip a patch ...

Actually, I've tested now the devicetree part, so I'll post for comments the
working patch here, which superseed the previous one, without changing the main
structure.

Cheers.

--
Robert

--<8--
>From 58f479160cbf707ea80f9126f90d7871240cff7c Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Mon, 9 Jun 2014 20:59:41 +0200
Subject: [PATCH 03/16] clk: add pxa27x clock drivers

Move pxa27x clock drivers from arch/arm/mach-pxa to driver/clk.
In the move :
 - convert to new clock framework legacy clocks
 - provide clocks as before for platform data based boards
 - provide clocks through devicetree with clk-pxa-dt

This is the preliminary step in the conversion. The remaining steps are
:
 - migrate pxa25x and pxa3xx
 - once PXA is fully converted to device tree, if that happens,
   clk-pxa2* and clk-pxa3* should only hold the core clocks which cannot
   be described in devicetree.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/clk/Makefile         |   1 +
 drivers/clk/pxa/Makefile     |   4 +
 drivers/clk/pxa/clk-pxa-dt.c |  76 ++++++++++
 drivers/clk/pxa/clk-pxa27x.c | 323 +++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/pxa/clk-pxa2xx.c |  74 ++++++++++
 drivers/clk/pxa/clk-pxa2xx.h |  47 +++++++
 6 files changed, 525 insertions(+)
 create mode 100644 drivers/clk/pxa/Makefile
 create mode 100644 drivers/clk/pxa/clk-pxa-dt.c
 create mode 100644 drivers/clk/pxa/clk-pxa27x.c
 create mode 100644 drivers/clk/pxa/clk-pxa2xx.c
 create mode 100644 drivers/clk/pxa/clk-pxa2xx.h

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
index 0000000..893daec
--- /dev/null
+++ b/drivers/clk/pxa/clk-pxa-dt.c
@@ -0,0 +1,76 @@
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
+	struct clk_onecell_data *onecell_data = NULL;
+	const char *name;
+	const char *parent_name;
+	int i, ret;
+	u32 clkidx;
+	void __iomem *reg;
+
+	ret = -ENOMEM;
+	onecell_data = kmalloc(sizeof(*onecell_data), GFP_KERNEL);
+	if (!onecell_data)
+		goto err_mem;
+	onecell_data->clks = kzalloc(sizeof(struct clk *) * PXA2XX_MAX_CLOCKS,
+				     GFP_KERNEL);
+	if (!onecell_data->clks)
+		goto err_mem;
+	onecell_data->clk_num = PXA2XX_MAX_CLOCKS;
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
+		if (!IS_ERR(clk))
+			onecell_data->clks[i] = clk;
+	}
+
+	of_clk_add_provider(np, of_clk_src_onecell_get, onecell_data);
+	return;
+err_mem:
+	if (onecell_data)
+		kfree(onecell_data->clks);
+	kfree(onecell_data);
+}
+CLK_OF_DECLARE(pxa2xx_clks, "mrvl,pxa-clocks", pxa2xx_clocks_init);
diff --git a/drivers/clk/pxa/clk-pxa27x.c b/drivers/clk/pxa/clk-pxa27x.c
new file mode 100644
index 0000000..48cba67
--- /dev/null
+++ b/drivers/clk/pxa/clk-pxa27x.c
@@ -0,0 +1,323 @@
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
+ * Once pxa is fully converted to devicetree, this should be severly shrunk.
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
+static unsigned long get_run_clock(unsigned long parent_rate)
+{
+	unsigned long ccsr = CCSR;
+	unsigned int l = ccsr & 0x1f;
+
+	return parent_rate * l;
+}
+
+static unsigned long get_turbo_clock(unsigned long parent_rate)
+{
+	unsigned long ccsr = CCSR;
+	unsigned int n2 = (ccsr >> 7) & 0xf;
+
+	return (get_run_clock(parent_rate) * n2) / 2;
+}
+
+static unsigned long get_halfturbo_clock(unsigned long parent_rate)
+{
+	return get_turbo_clock(parent_rate) / 2;
+}
+
+static unsigned long get_cpu_core_clock(unsigned long parent_rate)
+{
+	unsigned long clkcfg;
+	unsigned int t, ht, b;
+
+	asm("mrc\tp14, 0, %0, c6, c0, 0" : "=r" (clkcfg));
+	t  = clkcfg & (1 << 0);
+	ht = clkcfg & (1 << 2);
+	b  = clkcfg & (1 << 3);
+
+	if (ht)
+		return get_halfturbo_clock(parent_rate);
+	if (t)
+		return get_turbo_clock(parent_rate);
+	return get_run_clock(parent_rate);
+}
+
+static unsigned long get_sysbus_clock(unsigned long parent_rate)
+{
+	unsigned long clkcfg;
+	unsigned int t, ht, b;
+
+	asm("mrc\tp14, 0, %0, c6, c0, 0" : "=r" (clkcfg));
+	t  = clkcfg & (1 << 0);
+	ht = clkcfg & (1 << 2);
+	b  = clkcfg & (1 << 3);
+
+	return b ? get_run_clock(parent_rate) : get_run_clock(parent_rate) / 2;
+}
+
+static unsigned long get_memory_clock(unsigned long parent_rate)
+{
+	int cccr_a = CCCR & (1 << 25);
+	unsigned long ccsr = CCSR;
+	unsigned int l  = ccsr & 0x1f;
+
+	cccr_a = CCCR & (1 << 25);
+	if (cccr_a)
+		return get_sysbus_clock(parent_rate);
+	if (l <= 10)
+		return get_run_clock(parent_rate);
+	if (l <= 20)
+		return get_run_clock(parent_rate) / 2;
+	return get_run_clock(parent_rate) / 4;
+};
+
+static unsigned long get_lcd_clock(unsigned long parent_rate)
+{
+	unsigned long ccsr = CCSR;
+	unsigned int l  = ccsr & 0x1f;
+	int k = (l <= 7) ? 1 : (l <= 16) ? 2 : 4;
+
+	return get_run_clock(parent_rate) / k;
+}
+
+
+/*
+ * Get the clock frequency as reflected by CCSR and the turbo flag.
+ * We assume these values have been applied via a fcs.
+ * If info is not 0 we also display the current settings.
+ */
+unsigned int pxa27x_get_clk_frequency_khz(int info)
+{
+	unsigned long core_clk, run_mode, turbo_mode, mem_clk, sys_clk;
+
+	core_clk = get_cpu_core_clock(BASE_CLK);
+	run_mode = get_run_clock(BASE_CLK);
+	turbo_mode = get_turbo_clock(BASE_CLK);
+	mem_clk = get_memory_clock(BASE_CLK);
+	sys_clk = get_sysbus_clock(BASE_CLK);
+
+	if (info) {
+		printk(KERN_INFO "Run Mode clock: %ld.%02ldMHz\n",
+		       run_mode / 1000000, (run_mode % 1000000) / 10000);
+		printk(KERN_INFO "Turbo Mode clock: %ld.%02ldMHz\n",
+		       turbo_mode / 1000000, (turbo_mode % 1000000) / 10000);
+		printk(KERN_INFO "Memory clock: %ld.%02ldMHz\n",
+		       mem_clk / 1000000, (mem_clk % 1000000) / 10000);
+		printk(KERN_INFO "System bus clock: %ld.%02ldMHz \n",
+		       sys_clk / 1000000, (sys_clk % 1000000) / 10000);
+	}
+
+	return core_clk;
+}
+
+/*
+ * Return the current mem clock frequency as reflected by CCCR[A], B, and L
+ */
+static unsigned long clk_pxa27x_mem_getrate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	return get_memory_clock(BASE_CLK);
+}
+
+static const struct clk_ops clk_pxa27x_mem_ops = {
+	.recalc_rate = clk_pxa27x_mem_getrate,
+};
+
+static unsigned long clk_pxa27x_lcd_getrate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	return get_lcd_clock(BASE_CLK);
+}
+
+static const struct clk_ops clk_pxa27x_lcd_ops = {
+	.recalc_rate	= clk_pxa27x_lcd_getrate,
+};
+
+static struct pxa27x_clocks_fixed_cken pxa27x_without_dt_clocks[] __initdata = {
+	PXA2_FIXED_RATE("pxa2xx-uart.0", NULL, FFUART, 14857000, 1),
+	PXA2_FIXED_RATE("pxa2xx-uart.1", NULL, BTUART, 14857000, 1),
+	PXA2_FIXED_RATE("pxa2xx-uart.2", NULL, STUART, 14857000, 1),
+	PXA2_FIXED_RATE(NULL, "UARTCLK", STUART, 14857000, 1),
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
+	PXA2_FIXED_RATE(NULL, "AC97CLK", AC97, 24576000, 0),
+	PXA2_FIXED_RATE(NULL, "AC97CONFCLK", AC97CONF, 24576000, 0),
+	PXA2_FIXED_RATE(NULL, "MSLCLK", MSL, 48000000, 0),
+	PXA2_FIXED_RATE(NULL, "USIMCLK", USIM, 48000000, 0),
+	PXA2_FIXED_RATE(NULL, "MSTKCLK", MEMSTK, 19500000, 0),
+	PXA2_FIXED_RATE(NULL, "IMCLK", IM, 0, 0),
+	PXA2_FIXED_RATE_AO("pxa27x-memc", "MEMCLK", MEMC, 0, 0),
+};
+
+static struct pxa27x_clocks_var_rate pxa27x_var_rate_clocks[] __initdata = {
+	PXA2_VAR_RATE("pxa2xx-fb", true, LCD, &clk_pxa27x_lcd_ops),
+	PXA2_VAR_RATE("pxa27x-camera.0", true, CAMERA, &clk_pxa27x_lcd_ops),
+	PXA2_VAR_RATE("pxa2xx-pcmcia", false, MEMC, &clk_pxa27x_mem_ops),
+};
+
+static int __init pxa27x_clocks_init(void)
+{
+	int i;
+	unsigned long rate, flags;
+	struct clk *clk_parent, *clk;
+	struct pxa27x_clocks_fixed_cken *fclock;
+	struct pxa27x_clocks_var_rate *vclock;
+	char parent_name[80], *name;
+
+	/*
+	 * Once device-tree conversion is complete :
+	 * if (of_have_populated_dt())
+	 * 	return 0;
+	 */
+	for (i = 0; i < ARRAY_SIZE(pxa27x_without_dt_clocks); i++) {
+		fclock = &pxa27x_without_dt_clocks[i];
+		clk_parent = NULL;
+		rate = fclock->rate;
+		snprintf(parent_name, sizeof(parent_name), "clk-%lu", rate);
+		flags = CLK_GET_RATE_NOCACHE | CLK_IS_ROOT;
+		clk_parent = clk_register_fixed_rate(NULL, parent_name, NULL,
+						     flags, rate);
+		name = fclock->name ? fclock->name : fclock->con_id;
+		flags = fclock->always_on ? CLK_IGNORE_UNUSED : 0;
+		clk = clk_register_gate(NULL, name, parent_name, flags,
+					(void *)&CKEN, fclock->cken, 0,
+					&cken_lock);
+		if (!IS_ERR(clk))
+			clk_register_clkdev(clk, fclock->con_id, fclock->name);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(pxa27x_var_rate_clocks); i++) {
+		vclock = &pxa27x_var_rate_clocks[i];
+		flags = CLK_GET_RATE_NOCACHE;
+		if (vclock->has_cken) {
+			snprintf(parent_name, sizeof(parent_name), "clk-%s",
+				 vclock->name);
+			clk_parent = clk_pxa2xx_register_dummy(parent_name,
+							       vclock->clk_ops);
+			clk = clk_register_gate(NULL, vclock->name, parent_name,
+						flags, (void *)&CKEN,
+						vclock->cken, 0, &cken_lock);
+		} else {
+			clk = clk_pxa2xx_register_dummy(vclock->name,
+							vclock->clk_ops);
+		}
+		if (!IS_ERR(clk))
+			clk_register_clkdev(clk, NULL, vclock->name);
+	}
+	return 0;
+}
+
+postcore_initcall(pxa27x_clocks_init);
+
+struct clk_pxa27x_core {
+	struct clk_hw hw;
+	unsigned long (*get_rate)(unsigned long parent_rate);
+};
+
+static unsigned long clk_pxa27x_ops_get_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct clk_pxa27x_core *clk_core =
+		container_of(hw, struct clk_pxa27x_core, hw);
+
+	return clk_core->get_rate(parent_rate);
+}
+
+const struct clk_ops clk_pxa27x_ops = {
+	.recalc_rate = clk_pxa27x_ops_get_rate,
+};
+
+static struct clk __init *clk_register_pxa27x_core(const char *name,
+			   const char *parent_name,
+			   unsigned long (*get_rate)(unsigned long))
+{
+	struct clk_pxa27x_core *clk_core;
+	struct clk_init_data init;
+	struct clk *clk;
+
+	clk_core = kzalloc(sizeof(*clk_core), GFP_KERNEL);
+	if (!clk_core) {
+		pr_err("%s: could not allocate pxa27x_core clock\n", __func__);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	init.name = name;
+	init.ops = &clk_pxa27x_ops;
+	init.flags = CLK_IS_BASIC | CLK_GET_RATE_NOCACHE;
+	init.parent_names = (parent_name ? &parent_name : NULL);
+	init.num_parents = (parent_name ? 1 : 0);
+
+	clk_core->get_rate = get_rate;
+	clk_core->hw.init = &init;
+	clk = clk_register(NULL, &clk_core->hw);
+	return clk;
+}
+
+#define NB_CORE_CLOCKS 7
+static struct clk *core_clks[NB_CORE_CLOCKS];
+static struct clk_onecell_data onecell_data = {
+	.clks = core_clks,
+	.clk_num = NB_CORE_CLOCKS,
+};
+
+static void __init pxa27x_core_clocks_init(struct device_node *np)
+{
+	const char *pname;
+
+	pname = of_clk_get_parent_name(np, 0);
+	onecell_data.clks[0] =
+		clk_register_pxa27x_core("run mode", pname, get_run_clock);
+	onecell_data.clks[1] =
+		clk_register_pxa27x_core("turbo mode", pname, get_turbo_clock);
+	onecell_data.clks[2] =
+		clk_register_pxa27x_core("halt-turbo mode", pname,
+					 get_halfturbo_clock);
+	onecell_data.clks[3] =
+		clk_register_pxa27x_core("cpu core", pname,
+					 get_cpu_core_clock);
+	onecell_data.clks[4] =
+		clk_register_pxa27x_core("system bus", pname,
+					 get_sysbus_clock);
+	onecell_data.clks[5] =
+		clk_register_pxa27x_core("memory", pname,
+					 get_memory_clock);
+	onecell_data.clks[5] =
+		clk_register_pxa27x_core("lcd", pname,
+					 get_lcd_clock);
+
+	of_clk_add_provider(np, of_clk_src_onecell_get, &onecell_data);
+}
+CLK_OF_DECLARE(pxa2xx_clks, "mrvl,pxa27x-core-clocks", pxa27x_core_clocks_init);
diff --git a/drivers/clk/pxa/clk-pxa2xx.c b/drivers/clk/pxa/clk-pxa2xx.c
new file mode 100644
index 0000000..6e6d657
--- /dev/null
+++ b/drivers/clk/pxa/clk-pxa2xx.c
@@ -0,0 +1,74 @@
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
-- 
2.0.0.rc2
