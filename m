From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue,  2 Feb 2010 19:20:49 +0900
Subject: [PATCH v3 2/7] ARM: S5P6442: Add clock support for S5P6442
Message-ID: <1265106049-660-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds clock support for S5P6442. This patch adds the clock
register definitions and the various system clocks in S5P6442.

Signed-off-by: Adityapratap Sharma <aditya.ps@samsung.com>
Signed-off-by: Atul Dahiya <atul.dahiya@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p6442/Makefile                  |    2 +-
 arch/arm/mach-s5p6442/clock.c                   |  444 +++++++++++++++++++++++
 arch/arm/mach-s5p6442/include/mach/pwm-clock.h  |   69 ++++
 arch/arm/mach-s5p6442/include/mach/regs-clock.h |  103 ++++++
 arch/arm/mach-s5p6442/include/mach/tick.h       |   26 ++
 5 files changed, 643 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-s5p6442/Makefile
 create mode 100644 arch/arm/mach-s5p6442/clock.c
 create mode 100644 arch/arm/mach-s5p6442/include/mach/pwm-clock.h
 create mode 100644 arch/arm/mach-s5p6442/include/mach/regs-clock.h
 create mode 100644 arch/arm/mach-s5p6442/include/mach/tick.h

diff --git a/arch/arm/mach-s5p6442/Makefile b/arch/arm/mach-s5p6442/Makefile
index 0a45d01..f1b3e75 100644
--- a/arch/arm/mach-s5p6442/Makefile
+++ b/arch/arm/mach-s5p6442/Makefile
@@ -12,7 +12,7 @@ obj-				:=
 
 # Core support for S5P6442 system
 
-obj-$(CONFIG_CPU_S5P6442)	+= cpu.o init.o
+obj-$(CONFIG_CPU_S5P6442)	+= cpu.o init.o clock.o
 
 # machine support
 
diff --git a/arch/arm/mach-s5p6442/clock.c b/arch/arm/mach-s5p6442/clock.c
new file mode 100644
index 0000000..3ea9092
--- /dev/null
+++ b/arch/arm/mach-s5p6442/clock.c
@@ -0,0 +1,444 @@
+/* linux/arch/arm/mach-s5p6442/clock.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P6442 - Clock support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/sysdev.h>
+#include <linux/io.h>
+
+#include <mach/map.h>
+
+#include <plat/cpu-freq.h>
+#include <mach/regs-clock.h>
+#include <plat/clock.h>
+#include <plat/cpu.h>
+#include <plat/pll.h>
+#include <plat/s5p-clock.h>
+#include <plat/clock-clksrc.h>
+#include <plat/s5p6442.h>
+
+static struct clksrc_clk clk_mout_apll = {
+	.clk	= {
+		.name		= "mout_apll",
+		.id		= -1,
+	},
+	.sources	= &clk_src_apll,
+	.reg_src	= { .reg = S5P_CLK_SRC0, .shift = 0, .size = 1 },
+};
+
+static struct clksrc_clk clk_mout_mpll = {
+	.clk = {
+		.name		= "mout_mpll",
+		.id		= -1,
+	},
+	.sources	= &clk_src_mpll,
+	.reg_src	= { .reg = S5P_CLK_SRC0, .shift = 4, .size = 1 },
+};
+
+static struct clksrc_clk clk_mout_epll = {
+	.clk	= {
+		.name		= "mout_epll",
+		.id		= -1,
+	},
+	.sources	= &clk_src_epll,
+	.reg_src	= { .reg = S5P_CLK_SRC0, .shift = 8, .size = 1 },
+};
+
+/* Possible clock sources for ARM Mux */
+static struct clk *clk_src_arm_list[] = {
+	[1] = &clk_mout_apll.clk,
+	[2] = &clk_mout_mpll.clk,
+};
+
+static struct clksrc_sources clk_src_arm = {
+	.sources	= clk_src_arm_list,
+	.nr_sources	= ARRAY_SIZE(clk_src_arm_list),
+};
+
+static struct clksrc_clk clk_mout_arm = {
+	.clk	= {
+		.name		= "mout_arm",
+		.id		= -1,
+	},
+	.sources	= &clk_src_arm,
+	.reg_src	= { .reg = S5P_CLK_MUX_STAT0, .shift = 16, .size = 3 },
+};
+
+static unsigned long s5p6442_clk_dout_a2m_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned int ratio;
+
+	ratio = __raw_readl(S5P_CLK_DIV0) & S5P_CLKDIV0_A2M_MASK;
+	ratio >>= S5P_CLKDIV0_A2M_SHIFT;
+
+	return rate / (ratio + 1);
+}
+
+static struct clk clk_dout_a2m = {
+	.name		= "dout_a2m",
+	.id		= -1,
+	.parent		= &clk_mout_apll.clk,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s5p6442_clk_dout_a2m_get_rate,
+	},
+};
+
+/* Possible clock sources for D0 Mux */
+static struct clk *clk_src_d0_list[] = {
+	[1] = &clk_mout_mpll.clk,
+	[2] = &clk_dout_a2m,
+};
+
+static struct clksrc_sources clk_src_d0 = {
+	.sources	= clk_src_d0_list,
+	.nr_sources	= ARRAY_SIZE(clk_src_d0_list),
+};
+
+static struct clksrc_clk clk_mout_d0 = {
+	.clk = {
+		.name		= "mout_d0",
+		.id		= -1,
+	},
+	.sources	= &clk_src_d0,
+	.reg_src	= { .reg = S5P_CLK_MUX_STAT0, .shift = 20, .size = 3 },
+};
+
+static unsigned long s5p6442_clk_dout_apll_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned int ratio;
+
+	ratio = __raw_readl(S5P_CLK_DIV0) & S5P_CLKDIV0_APLL_MASK;
+	ratio >>= S5P_CLKDIV0_APLL_SHIFT;
+
+	return rate / (ratio + 1);
+}
+
+static struct clk clk_dout_apll = {
+	.name		= "dout_apll",
+	.id		= -1,
+	.parent		= &clk_mout_arm.clk,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s5p6442_clk_dout_apll_get_rate,
+	},
+};
+
+/* Possible clock sources for D0SYNC Mux */
+static struct clk *clk_src_d0sync_list[] = {
+	[1] = &clk_mout_d0.clk,
+	[2] = &clk_dout_apll,
+};
+
+static struct clksrc_sources clk_src_d0sync = {
+	.sources	= clk_src_d0sync_list,
+	.nr_sources	= ARRAY_SIZE(clk_src_d0sync_list),
+};
+
+static struct clksrc_clk clk_mout_d0sync = {
+	.clk	= {
+		.name		= "mout_d0sync",
+		.id		= -1,
+	},
+	.sources	= &clk_src_d0sync,
+	.reg_src	= { .reg = S5P_CLK_MUX_STAT1, .shift = 28, .size = 3 },
+};
+
+/* Possible clock sources for D1 Mux */
+static struct clk *clk_src_d1_list[] = {
+	[1] = &clk_mout_mpll.clk,
+	[2] = &clk_dout_a2m,
+};
+
+static struct clksrc_sources clk_src_d1 = {
+	.sources	= clk_src_d1_list,
+	.nr_sources	= ARRAY_SIZE(clk_src_d1_list),
+};
+
+static struct clksrc_clk clk_mout_d1 = {
+	.clk	= {
+		.name		= "mout_d1",
+		.id		= -1,
+	},
+	.sources	= &clk_src_d1,
+	.reg_src	= { .reg = S5P_CLK_MUX_STAT0, .shift = 24, .size = 3 },
+};
+
+/* Possible clock sources for D1SYNC Mux */
+static struct clk *clk_src_d1sync_list[] = {
+	[1] = &clk_mout_d1.clk,
+	[2] = &clk_dout_apll,
+};
+
+static struct clksrc_sources clk_src_d1sync = {
+	.sources	= clk_src_d1sync_list,
+	.nr_sources	= ARRAY_SIZE(clk_src_d1sync_list),
+};
+
+static struct clksrc_clk clk_mout_d1sync = {
+	.clk	= {
+		.name		= "mout_d1sync",
+		.id		= -1,
+	},
+	.sources	= &clk_src_d1sync,
+	.reg_src	= { .reg = S5P_CLK_MUX_STAT1, .shift = 24, .size = 3 },
+};
+
+static unsigned long s5p6442_clk_dout_d1clk_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned int ratio;
+
+	ratio = __raw_readl(S5P_CLK_DIV0) & S5P_CLKDIV0_D1CLK_MASK;
+	ratio >>= S5P_CLKDIV0_D1CLK_SHIFT;
+
+	return rate / (ratio + 1);
+}
+
+static struct clk clk_dout_d1clk = {
+	.name		= "dout_d1clk",
+	.id		= -1,
+	.parent		= &clk_mout_d1sync.clk,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s5p6442_clk_dout_d1clk_get_rate,
+	},
+};
+
+static unsigned long s5p6442_clk_dout_d0clk_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned int ratio;
+
+	ratio = __raw_readl(S5P_CLK_DIV0) & S5P_CLKDIV0_D0CLK_MASK;
+	ratio >>= S5P_CLKDIV0_D0CLK_SHIFT;
+
+	return rate / (ratio + 1);
+}
+
+static struct clk clk_dout_d0clk = {
+	.name		= "dout_d0clk",
+	.id		= -1,
+	.parent		= &clk_mout_d0sync.clk,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s5p6442_clk_dout_d0clk_get_rate,
+	},
+};
+
+static unsigned long s5p6442_clk_dout_p0clk_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned int ratio;
+
+	ratio = __raw_readl(S5P_CLK_DIV0) & S5P_CLKDIV0_P0CLK_MASK;
+	ratio >>= S5P_CLKDIV0_P0CLK_SHIFT;
+
+	return rate / (ratio + 1);
+}
+
+static struct clk clk_dout_p0clk = {
+	.name		= "dout_p0clk",
+	.id		= -1,
+	.parent		= &clk_dout_d0clk,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s5p6442_clk_dout_p0clk_get_rate,
+	},
+};
+
+static unsigned long s5p6442_clk_dout_p1clk_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned int ratio;
+
+	ratio = __raw_readl(S5P_CLK_DIV0) & S5P_CLKDIV0_P1CLK_MASK;
+	ratio >>= S5P_CLKDIV0_P1CLK_SHIFT;
+
+	return rate / (ratio + 1);
+}
+
+static struct clk clk_dout_p1clk = {
+	.name		= "dout_p1clk",
+	.id		= -1,
+	.parent		= &clk_dout_d1clk,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s5p6442_clk_dout_p1clk_get_rate,
+	},
+};
+
+int s5p6442_clk_ip3_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P_CLKGATE_IP3, clk, enable);
+}
+
+/* Clock initialisation code */
+static struct clksrc_clk *init_parents[] = {
+	&clk_mout_apll,
+	&clk_mout_mpll,
+	&clk_mout_epll,
+	&clk_mout_arm,
+	&clk_mout_d0,
+	&clk_mout_d0sync,
+	&clk_mout_d1,
+	&clk_mout_d1sync,
+};
+
+void __init_or_cpufreq s5p6442_setup_clocks(void)
+{
+	struct clk *xtal_clk;
+	struct clk *arm_clk;
+	struct clk *hclkd0_clk;
+	struct clk *hclkd1_clk;
+	struct clk *pclkd0_clk;
+	struct clk *pclkd1_clk;
+
+	unsigned long xtal;
+	unsigned long arm;
+	unsigned long hclkd0 = 0;
+	unsigned long hclkd1 = 0;
+	unsigned long pclkd0 = 0;
+	unsigned long pclkd1 = 0;
+
+	unsigned long apll;
+	unsigned long mpll;
+	unsigned long epll;
+	unsigned int ptr;
+
+	printk(KERN_DEBUG "%s: registering clocks\n", __func__);
+
+	xtal_clk = clk_get(NULL, "xtal");
+	BUG_ON(IS_ERR(xtal_clk));
+
+	xtal = clk_get_rate(xtal_clk);
+	clk_put(xtal_clk);
+
+	printk(KERN_DEBUG "%s: xtal is %ld\n", __func__, xtal);
+
+	apll = s5p_get_pll45xx(xtal, __raw_readl(S5P_APLL_CON), pll_4508);
+	mpll = s5p_get_pll45xx(xtal, __raw_readl(S5P_MPLL_CON), pll_4502);
+	epll = s5p_get_pll45xx(xtal, __raw_readl(S5P_EPLL_CON), pll_4500);
+
+	printk(KERN_INFO "S5P6440: PLL settings, A=%ld, M=%ld, E=%ld",
+			apll, mpll, epll);
+
+	clk_fout_apll.rate = apll;
+	clk_fout_mpll.rate = mpll;
+	clk_fout_epll.rate = epll;
+
+	for (ptr = 0; ptr < ARRAY_SIZE(init_parents); ptr++)
+		s3c_set_clksrc(init_parents[ptr], true);
+
+	arm_clk = clk_get(NULL, "dout_apll");
+	BUG_ON(IS_ERR(arm_clk));
+
+	arm = clk_get_rate(arm_clk);
+	clk_put(arm_clk);
+
+	hclkd0_clk = clk_get(NULL, "dout_d0clk");
+	BUG_ON(IS_ERR(hclkd0_clk));
+
+	hclkd0 = clk_get_rate(hclkd0_clk);
+	clk_put(hclkd0_clk);
+
+	pclkd0_clk = clk_get(NULL, "dout_p0clk");
+	BUG_ON(IS_ERR(pclkd0_clk));
+
+	pclkd0 = clk_get_rate(pclkd0_clk);
+	clk_put(pclkd0_clk);
+
+	hclkd1_clk = clk_get(NULL, "dout_d1clk");
+	BUG_ON(IS_ERR(hclkd1_clk));
+
+	hclkd1 = clk_get_rate(hclkd1_clk);
+	clk_put(hclkd1_clk);
+
+	pclkd1_clk = clk_get(NULL, "dout_p1clk");
+	BUG_ON(IS_ERR(pclkd1_clk));
+
+	pclkd1 = clk_get_rate(pclkd1_clk);
+	clk_put(pclkd1_clk);
+
+	printk(KERN_INFO "S5P6442: HCLKD0=%ld, HCLKD1=%ld, PCLKD0=%ld, PCLKD1=%ld\n",
+			hclkd0, hclkd1, pclkd0, pclkd1);
+
+	/* For backward compatibility */
+	clk_f.rate = arm;
+	clk_h.rate = hclkd1;
+	clk_p.rate = pclkd1;
+
+	clk_dout_p1clk.rate = clk_p.rate;
+}
+
+static struct clk init_clocks[] = {
+	{
+		.name		= "systimer",
+		.id		= -1,
+		.parent		= &clk_dout_p1clk,
+		.enable		= s5p6442_clk_ip3_ctrl,
+		.ctrlbit	= (1<<16),
+	}, {
+		.name		= "uart",
+		.id		= 0,
+		.parent		= &clk_dout_p1clk,
+		.enable		= s5p6442_clk_ip3_ctrl,
+		.ctrlbit	= (1<<17),
+	}, {
+		.name		= "uart",
+		.id		= 1,
+		.parent		= &clk_dout_p1clk,
+		.enable		= s5p6442_clk_ip3_ctrl,
+		.ctrlbit	= (1<<18),
+	}, {
+		.name		= "uart",
+		.id		= 2,
+		.parent		= &clk_dout_p1clk,
+		.enable		= s5p6442_clk_ip3_ctrl,
+		.ctrlbit	= (1<<19),
+	}, {
+		.name		= "timers",
+		.id		= -1,
+		.parent		= &clk_dout_p1clk,
+		.enable		= s5p6442_clk_ip3_ctrl,
+		.ctrlbit	= (1<<23),
+	},
+};
+
+static struct clk *clks[] __initdata = {
+	&clk_ext,
+	&clk_epll,
+	&clk_mout_apll.clk,
+	&clk_mout_mpll.clk,
+	&clk_mout_epll.clk,
+	&clk_mout_arm.clk,
+	&clk_mout_d0.clk,
+	&clk_mout_d0sync.clk,
+	&clk_mout_d1.clk,
+	&clk_mout_d1sync.clk,
+	&clk_dout_apll,
+	&clk_dout_a2m,
+	&clk_dout_d0clk,
+	&clk_dout_p0clk,
+	&clk_dout_d1clk,
+	&clk_dout_p1clk,
+};
+
+void __init s5p6442_register_clocks(void)
+{
+	s3c24xx_register_clocks(clks, ARRAY_SIZE(clks));
+
+	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
+
+	s3c_pwmclk_init();
+}
diff --git a/arch/arm/mach-s5p6442/include/mach/pwm-clock.h b/arch/arm/mach-s5p6442/include/mach/pwm-clock.h
new file mode 100644
index 0000000..15e8525
--- /dev/null
+++ b/arch/arm/mach-s5p6442/include/mach/pwm-clock.h
@@ -0,0 +1,69 @@
+/* linux/arch/arm/mach-s5p6442/include/mach/pwm-clock.h
+ *
+ * Copyright 2008 Simtec Electronics
+ *      Ben Dooks <ben@simtec.co.uk>
+ *      http://armlinux.simtec.co.uk/
+ *
+ * Copyright 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * Based on arch/arm/plat-s3c24xx/include/mach/pwm-clock.h
+ *
+ * S5P6442 - pwm clock and timer support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_PWMCLK_H
+#define __ASM_ARCH_PWMCLK_H __FILE__
+
+/**
+ * pwm_cfg_src_is_tclk() - return whether the given mux config is a tclk
+ * @cfg: The timer TCFG1 register bits shifted down to 0.
+ *
+ * Return true if the given configuration from TCFG1 is a TCLK instead
+ * any of the TDIV clocks.
+ */
+static inline int pwm_cfg_src_is_tclk(unsigned long tcfg)
+{
+	return tcfg == S3C2410_TCFG1_MUX_TCLK;
+}
+
+/**
+ * tcfg_to_divisor() - convert tcfg1 setting to a divisor
+ * @tcfg1: The tcfg1 setting, shifted down.
+ *
+ * Get the divisor value for the given tcfg1 setting. We assume the
+ * caller has already checked to see if this is not a TCLK source.
+ */
+static inline unsigned long tcfg_to_divisor(unsigned long tcfg1)
+{
+	return 1 << (1 + tcfg1);
+}
+
+/**
+ * pwm_tdiv_has_div1() - does the tdiv setting have a /1
+ *
+ * Return true if we have a /1 in the tdiv setting.
+ */
+static inline unsigned int pwm_tdiv_has_div1(void)
+{
+	return 0;
+}
+
+/**
+ * pwm_tdiv_div_bits() - calculate TCFG1 divisor value.
+ * @div: The divisor to calculate the bit information for.
+ *
+ * Turn a divisor into the necessary bit field for TCFG1.
+ */
+static inline unsigned long pwm_tdiv_div_bits(unsigned int div)
+{
+	return ilog2(div) - 1;
+}
+
+#define S3C_TCFG1_MUX_TCLK S3C2410_TCFG1_MUX_TCLK
+
+#endif /* __ASM_ARCH_PWMCLK_H */
diff --git a/arch/arm/mach-s5p6442/include/mach/regs-clock.h b/arch/arm/mach-s5p6442/include/mach/regs-clock.h
new file mode 100644
index 0000000..d8360b5
--- /dev/null
+++ b/arch/arm/mach-s5p6442/include/mach/regs-clock.h
@@ -0,0 +1,103 @@
+/* linux/arch/arm/mach-s5p6442/include/mach/regs-clock.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P6442 - Clock register definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_REGS_CLOCK_H
+#define __ASM_ARCH_REGS_CLOCK_H __FILE__
+
+#include <mach/map.h>
+
+#define S5P_CLKREG(x)		(S3C_VA_SYS + (x))
+
+#define S5P_APLL_LOCK		S5P_CLKREG(0x00)
+#define S5P_MPLL_LOCK		S5P_CLKREG(0x08)
+#define S5P_EPLL_LOCK		S5P_CLKREG(0x10)
+#define S5P_VPLL_LOCK		S5P_CLKREG(0x20)
+
+#define S5P_APLL_CON		S5P_CLKREG(0x100)
+#define S5P_MPLL_CON		S5P_CLKREG(0x108)
+#define S5P_EPLL_CON		S5P_CLKREG(0x110)
+#define S5P_VPLL_CON		S5P_CLKREG(0x120)
+
+#define S5P_CLK_SRC0		S5P_CLKREG(0x200)
+#define S5P_CLK_SRC1		S5P_CLKREG(0x204)
+#define S5P_CLK_SRC2		S5P_CLKREG(0x208)
+#define S5P_CLK_SRC3		S5P_CLKREG(0x20C)
+#define S5P_CLK_SRC4		S5P_CLKREG(0x210)
+#define S5P_CLK_SRC5		S5P_CLKREG(0x214)
+#define S5P_CLK_SRC6		S5P_CLKREG(0x218)
+
+#define S5P_CLK_SRC_MASK0	S5P_CLKREG(0x280)
+#define S5P_CLK_SRC_MASK1	S5P_CLKREG(0x284)
+
+#define S5P_CLK_DIV0		S5P_CLKREG(0x300)
+#define S5P_CLK_DIV1		S5P_CLKREG(0x304)
+#define S5P_CLK_DIV2		S5P_CLKREG(0x308)
+#define S5P_CLK_DIV3		S5P_CLKREG(0x30C)
+#define S5P_CLK_DIV4		S5P_CLKREG(0x310)
+#define S5P_CLK_DIV5		S5P_CLKREG(0x314)
+#define S5P_CLK_DIV6		S5P_CLKREG(0x318)
+
+#define S5P_CLKGATE_IP3		S5P_CLKREG(0x46C)
+
+/* CLK_OUT */
+#define S5P_CLK_OUT_SHIFT	(12)
+#define S5P_CLK_OUT_MASK	(0x1F << S5P_CLK_OUT_SHIFT)
+#define S5P_CLK_OUT		S5P_CLKREG(0x500)
+
+#define S5P_CLK_DIV_STAT0	S5P_CLKREG(0x1000)
+#define S5P_CLK_DIV_STAT1	S5P_CLKREG(0x1004)
+
+#define S5P_CLK_MUX_STAT0	S5P_CLKREG(0x1100)
+#define S5P_CLK_MUX_STAT1	S5P_CLKREG(0x1104)
+
+#define S5P_MDNIE_SEL		S5P_CLKREG(0x7008)
+
+/* Register Bit definition */
+#define S5P_EPLL_EN     		(1<<31)
+#define S5P_EPLL_MASK   		0xffffffff
+#define S5P_EPLLVAL(_m, _p, _s)   	((_m) << 16 | ((_p) << 8) | ((_s)))
+
+/* CLKDIV0 */
+#define S5P_CLKDIV0_APLL_SHIFT		(0)
+#define S5P_CLKDIV0_APLL_MASK		(0x7 << S5P_CLKDIV0_APLL_SHIFT)
+#define S5P_CLKDIV0_A2M_SHIFT		(4)
+#define S5P_CLKDIV0_A2M_MASK		(0x7 << S5P_CLKDIV0_A2M_SHIFT)
+#define S5P_CLKDIV0_D0CLK_SHIFT		(16)
+#define S5P_CLKDIV0_D0CLK_MASK		(0xF << S5P_CLKDIV0_D0CLK_SHIFT)
+#define S5P_CLKDIV0_P0CLK_SHIFT		(20)
+#define S5P_CLKDIV0_P0CLK_MASK		(0x7 << S5P_CLKDIV0_P0CLK_SHIFT)
+#define S5P_CLKDIV0_D1CLK_SHIFT		(24)
+#define S5P_CLKDIV0_D1CLK_MASK		(0xF << S5P_CLKDIV0_D1CLK_SHIFT)
+#define S5P_CLKDIV0_P1CLK_SHIFT		(28)
+#define S5P_CLKDIV0_P1CLK_MASK		(0x7 << S5P_CLKDIV0_P1CLK_SHIFT)
+
+/* Clock MUX status Registers */
+#define S5P_CLK_MUX_STAT0_APLL_SHIFT	(0)
+#define S5P_CLK_MUX_STAT0_APLL_MASK	(0x7 << S5P_CLK_MUX_STAT0_APLL_SHIFT)
+#define S5P_CLK_MUX_STAT0_MPLL_SHIFT	(4)
+#define S5P_CLK_MUX_STAT0_MPLL_MASK	(0x7 << S5P_CLK_MUX_STAT0_MPLL_SHIFT)
+#define S5P_CLK_MUX_STAT0_EPLL_SHIFT	(8)
+#define S5P_CLK_MUX_STAT0_EPLL_MASK	(0x7 << S5P_CLK_MUX_STAT0_EPLL_SHIFT)
+#define S5P_CLK_MUX_STAT0_VPLL_SHIFT	(12)
+#define S5P_CLK_MUX_STAT0_VPLL_MASK	(0x7 << S5P_CLK_MUX_STAT0_VPLL_SHIFT)
+#define S5P_CLK_MUX_STAT0_MUXARM_SHIFT	(16)
+#define S5P_CLK_MUX_STAT0_MUXARM_MASK	(0x7 << S5P_CLK_MUX_STAT0_MUXARM_SHIFT)
+#define S5P_CLK_MUX_STAT0_MUXD0_SHIFT	(20)
+#define S5P_CLK_MUX_STAT0_MUXD0_MASK	(0x7 << S5P_CLK_MUX_STAT0_MUXD0_SHIFT)
+#define S5P_CLK_MUX_STAT0_MUXD1_SHIFT	(24)
+#define S5P_CLK_MUX_STAT0_MUXD1_MASK	(0x7 << S5P_CLK_MUX_STAT0_MUXD1_SHIFT)
+#define S5P_CLK_MUX_STAT1_D1SYNC_SHIFT	(24)
+#define S5P_CLK_MUX_STAT1_D1SYNC_MASK	(0x7 << S5P_CLK_MUX_STAT1_D1SYNC_SHIFT)
+#define S5P_CLK_MUX_STAT1_D0SYNC_SHIFT	(28)
+#define S5P_CLK_MUX_STAT1_D0SYNC_MASK	(0x7 << S5P_CLK_MUX_STAT1_D0SYNC_SHIFT)
+
+#endif /* __ASM_ARCH_REGS_CLOCK_H */
diff --git a/arch/arm/mach-s5p6442/include/mach/tick.h b/arch/arm/mach-s5p6442/include/mach/tick.h
new file mode 100644
index 0000000..e1d4cab
--- /dev/null
+++ b/arch/arm/mach-s5p6442/include/mach/tick.h
@@ -0,0 +1,26 @@
+/* linux/arch/arm/mach-s5p6442/include/mach/tick.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * Based on arch/arm/mach-s3c6400/include/mach/tick.h
+ *
+ * S5P6442 - Timer tick support definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_TICK_H
+#define __ASM_ARCH_TICK_H __FILE__
+
+static inline u32 s3c24xx_ostimer_pending(void)
+{
+	u32 pend = __raw_readl(VA_VIC0 + VIC_RAW_STATUS);
+	return pend & (1 << (IRQ_TIMER4_VIC - S5P_IRQ_VIC0(0)));
+}
+
+#define TICK_MAX	(0xffffffff)
+
+#endif /* __ASM_ARCH_TICK_H */
-- 
1.6.2.5
