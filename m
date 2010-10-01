From: viresh.kumar@st.com (Viresh KUMAR)
Date: Fri,  1 Oct 2010 17:25:27 +0530
Subject: [PATCH V2 07/69] ST SPEAr13XX: Adding machine specific src files
In-Reply-To: <cover.1285933331.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
Message-ID: <d49504303711db19e4d7582178916c280255b541.1285933331.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shiraz Hashim <shiraz.hashim@st.com>

Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear13xx/Kconfig                    |   21 ++
 arch/arm/mach-spear13xx/Makefile                   |   14 +
 arch/arm/mach-spear13xx/Makefile.boot              |    3 +
 arch/arm/mach-spear13xx/clock.c                    |  353 ++++++++++++++++++++
 arch/arm/mach-spear13xx/headsmp.S                  |   95 ++++++
 arch/arm/mach-spear13xx/include/mach/entry-macro.S |    2 +-
 arch/arm/mach-spear13xx/include/mach/generic.h     |    2 +-
 arch/arm/mach-spear13xx/localtimer.c               |   25 ++
 arch/arm/mach-spear13xx/platsmp.c                  |  200 +++++++++++
 arch/arm/mach-spear13xx/spear1300.c                |   23 ++
 arch/arm/mach-spear13xx/spear1300_evb.c            |   48 +++
 arch/arm/mach-spear13xx/spear13xx.c                |  121 +++++++
 12 files changed, 905 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-spear13xx/Kconfig
 create mode 100644 arch/arm/mach-spear13xx/Makefile
 create mode 100644 arch/arm/mach-spear13xx/Makefile.boot
 create mode 100644 arch/arm/mach-spear13xx/clock.c
 create mode 100644 arch/arm/mach-spear13xx/headsmp.S
 create mode 100644 arch/arm/mach-spear13xx/localtimer.c
 create mode 100644 arch/arm/mach-spear13xx/platsmp.c
 create mode 100644 arch/arm/mach-spear13xx/spear1300.c
 create mode 100644 arch/arm/mach-spear13xx/spear1300_evb.c
 create mode 100644 arch/arm/mach-spear13xx/spear13xx.c

diff --git a/arch/arm/mach-spear13xx/Kconfig b/arch/arm/mach-spear13xx/Kconfig
new file mode 100644
index 0000000..3ea463d
--- /dev/null
+++ b/arch/arm/mach-spear13xx/Kconfig
@@ -0,0 +1,21 @@
+#
+# SPEAr13XX Machine configuration file
+#
+
+if ARCH_SPEAR13XX
+
+menu "SPEAr13xx Implementations"
+config BOARD_SPEAR1300_EVB
+	bool "SPEAr1300 Evaluation Board"
+	select MACH_SPEAR1300
+	help
+	  Supports ST SPEAr1300 Evaluation Board
+
+endmenu
+
+config MACH_SPEAR1300
+	bool "SPEAr1300"
+	help
+	  Supports ST SPEAr1300 Machine
+
+endif #ARCH_SPEAR13XX
diff --git a/arch/arm/mach-spear13xx/Makefile b/arch/arm/mach-spear13xx/Makefile
new file mode 100644
index 0000000..cb5ae9e
--- /dev/null
+++ b/arch/arm/mach-spear13xx/Makefile
@@ -0,0 +1,14 @@
+#
+# Makefile for SPEAr13XX machine series
+#
+
+# common files
+obj-y					+= spear13xx.o clock.o
+obj-$(CONFIG_SMP)			+= platsmp.o headsmp.o
+obj-$(CONFIG_LOCAL_TIMERS)		+= localtimer.o
+
+# spear1300 specific files
+obj-$(CONFIG_MACH_SPEAR1300)		+= spear1300.o
+
+# spear1300 boards files
+obj-$(CONFIG_BOARD_SPEAR1300_EVB)	+= spear1300_evb.o
diff --git a/arch/arm/mach-spear13xx/Makefile.boot b/arch/arm/mach-spear13xx/Makefile.boot
new file mode 100644
index 0000000..7a1f3c0
--- /dev/null
+++ b/arch/arm/mach-spear13xx/Makefile.boot
@@ -0,0 +1,3 @@
+zreladdr-y	:= 0x00008000
+params_phys-y	:= 0x00000100
+initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-spear13xx/clock.c b/arch/arm/mach-spear13xx/clock.c
new file mode 100644
index 0000000..722f634
--- /dev/null
+++ b/arch/arm/mach-spear13xx/clock.c
@@ -0,0 +1,353 @@
+/*
+ * arch/arm/mach-spear13xx/clock.c
+ *
+ * SPEAr13xx machines clock framework source file
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * shiraz hashim<shiraz.hashim@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <asm/mach-types.h>
+#include <plat/clock.h>
+#include <mach/hardware.h>
+#include <mach/misc_regs.h>
+
+/* root clks */
+/* 24 MHz oscillator clock */
+static struct clk osc1_24m_clk = {
+	.flags = ALWAYS_ENABLED,
+	.rate = 24000000,
+};
+
+/* 32 KHz oscillator clock */
+static struct clk osc2_32k_clk = {
+	.flags = ALWAYS_ENABLED,
+	.rate = 32000,
+};
+
+/* 25 MHz MIPHY oscillator clock */
+static struct clk osc3_25m_clk = {
+	.flags = ALWAYS_ENABLED,
+	.rate = 25000000,
+};
+
+/* clock derived from 32 KHz osc clk */
+/* rtc clock */
+static struct clk rtc_clk = {
+	.pclk = &osc2_32k_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = RTC_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* clock derived from osc1 or osc3 */
+/* pll[1-3] parents */
+static struct pclk_info pll_pclk_info[] = {
+	{
+		.pclk = &osc1_24m_clk,
+		.pclk_mask = OSC_24M_MASK,
+	}, {
+		.pclk = &osc3_25m_clk,
+		.pclk_mask = OSC_25M_MASK,
+	},
+};
+
+/* pll[1-3] parent select structure */
+static struct pclk_sel pll_pclk_sel = {
+	.pclk_info = pll_pclk_info,
+	.pclk_count = ARRAY_SIZE(pll_pclk_info),
+	.pclk_sel_reg = PLL_CFG,
+	.pclk_sel_mask = PLL_CLK_MASK,
+};
+
+/* pll masks structure */
+static struct pll_clk_masks pll_masks = {
+	.mode_mask = PLL_MODE_MASK,
+	.mode_shift = PLL_MODE_SHIFT,
+	.norm_fdbk_m_mask = PLL_NORM_FDBK_M_MASK,
+	.norm_fdbk_m_shift = PLL_NORM_FDBK_M_SHIFT,
+	.dith_fdbk_m_mask = PLL_DITH_FDBK_M_MASK,
+	.dith_fdbk_m_shift = PLL_DITH_FDBK_M_SHIFT,
+	.div_p_mask = PLL_DIV_P_MASK,
+	.div_p_shift = PLL_DIV_P_SHIFT,
+	.div_n_mask = PLL_DIV_N_MASK,
+	.div_n_shift = PLL_DIV_N_SHIFT,
+};
+/* pll1 configuration structure */
+static struct pll_clk_config pll1_config = {
+	.mode_reg = PLL1_CTR,
+	.cfg_reg = PLL1_FRQ,
+	.masks = &pll_masks,
+};
+
+/* pll1 clock */
+static struct clk pll1_clk = {
+	.pclk_sel = &pll_pclk_sel,
+	.pclk_sel_shift = PLL1_CLK_SHIFT,
+	.en_reg = PLL1_CTR,
+	.en_reg_bit = PLL_ENABLE,
+	.recalc = &pll_clk_recalc,
+	.private_data = &pll1_config,
+};
+
+/* pll2 configuration structure */
+static struct pll_clk_config pll2_config = {
+	.mode_reg = PLL2_CTR,
+	.cfg_reg = PLL2_FRQ,
+	.masks = &pll_masks,
+};
+
+/* pll2 clock */
+static struct clk pll2_clk = {
+	.pclk_sel = &pll_pclk_sel,
+	.pclk_sel_shift = PLL2_CLK_SHIFT,
+	.en_reg = PLL2_CTR,
+	.en_reg_bit = PLL_ENABLE,
+	.recalc = &pll_clk_recalc,
+	.private_data = &pll2_config,
+};
+
+/* pll3 configuration structure */
+static struct pll_clk_config pll3_config = {
+	.mode_reg = PLL3_CTR,
+	.cfg_reg = PLL3_FRQ,
+	.masks = &pll_masks,
+};
+
+/* pll3 clock */
+static struct clk pll3_clk = {
+	.pclk_sel = &pll_pclk_sel,
+	.pclk_sel_shift = PLL3_CLK_SHIFT,
+	.en_reg = PLL3_CTR,
+	.en_reg_bit = PLL_ENABLE,
+	.recalc = &pll_clk_recalc,
+	.private_data = &pll3_config,
+};
+
+/* pll4 (DDR) configuration structure */
+static struct pll_clk_config pll4_config = {
+	.mode_reg = PLL4_CTR,
+	.cfg_reg = PLL4_FRQ,
+	.masks = &pll_masks,
+};
+
+/* pll4 (DDR) clock */
+static struct clk pll4_clk = {
+	.pclk = &osc1_24m_clk,
+	.en_reg = PLL4_CTR,
+	.en_reg_bit = PLL_ENABLE,
+	.recalc = &pll_clk_recalc,
+	.private_data = &pll4_config,
+};
+
+/* pll5 USB 48 MHz clock */
+static struct clk pll5_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &osc1_24m_clk,
+	.rate = 48000000,
+};
+
+/* pll6 (MIPHY) clock */
+static struct clk pll6_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &osc3_25m_clk,
+	.rate = 25000000,
+};
+
+/* clocks derived from pll1 clk */
+/* cpu clock */
+static struct clk cpu_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &pll1_clk,
+	.div_factor = 2,
+	.recalc = &follow_parent,
+};
+
+/* ahb clock */
+static struct clk ahb_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &pll1_clk,
+	.div_factor = 6,
+	.recalc = &follow_parent,
+};
+
+/* apb clock */
+static struct clk apb_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &pll1_clk,
+	.div_factor = 12,
+	.recalc = &follow_parent,
+};
+
+/* clocks derived from osc1, ahb or apb */
+/* gpt[0-3] parents */
+static struct pclk_info gpt_pclk_info[] = {
+	{
+		.pclk = &osc1_24m_clk,
+		.pclk_mask = GPT_OSC24_MASK,
+	}, {
+		.pclk = &apb_clk,
+		.pclk_mask = GPT_APB_MASK,
+	},
+};
+
+/* gpt[0-3] parent select structure */
+static struct pclk_sel gpt_pclk_sel = {
+	.pclk_info = gpt_pclk_info,
+	.pclk_count = ARRAY_SIZE(gpt_pclk_info),
+	.pclk_sel_reg = PERIP_CLK_CFG,
+	.pclk_sel_mask = GPT_CLK_MASK,
+};
+
+/* gpt0 timer clock */
+static struct clk gpt0_clk = {
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = GPT0_CLK_ENB,
+	.pclk_sel = &gpt_pclk_sel,
+	.pclk_sel_shift = GPT0_CLK_SHIFT,
+	.recalc = &follow_parent,
+};
+
+/* gpt1 timer clock */
+static struct clk gpt1_clk = {
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = GPT1_CLK_ENB,
+	.pclk_sel = &gpt_pclk_sel,
+	.pclk_sel_shift = GPT1_CLK_SHIFT,
+	.recalc = &follow_parent,
+};
+
+/* gpt2 timer clock */
+static struct clk gpt2_clk = {
+	.en_reg = PERIP2_CLK_ENB,
+	.en_reg_bit = GPT2_CLK_ENB,
+	.pclk_sel = &gpt_pclk_sel,
+	.pclk_sel_shift = GPT2_CLK_SHIFT,
+	.recalc = &follow_parent,
+};
+
+/* gpt3 timer clock */
+static struct clk gpt3_clk = {
+	.en_reg = PERIP2_CLK_ENB,
+	.en_reg_bit = GPT3_CLK_ENB,
+	.pclk_sel = &gpt_pclk_sel,
+	.pclk_sel_shift = GPT3_CLK_SHIFT,
+	.recalc = &follow_parent,
+};
+
+/* watch dog timer clock */
+static struct clk wdt_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &apb_clk,
+	.recalc = &follow_parent,
+};
+
+/* smi clock */
+static struct clk smi_clk = {
+	.pclk = &ahb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = SMI_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* auxiliary synthesizers masks */
+static struct aux_clk_masks aux_masks = {
+	.eq_sel_mask = AUX_EQ_SEL_MASK,
+	.eq_sel_shift = AUX_EQ_SEL_SHIFT,
+	.eq1_mask = AUX_EQ1_SEL,
+	.eq2_mask = AUX_EQ2_SEL,
+	.xscale_sel_mask = AUX_XSCALE_MASK,
+	.xscale_sel_shift = AUX_XSCALE_SHIFT,
+	.yscale_sel_mask = AUX_YSCALE_MASK,
+	.yscale_sel_shift = AUX_YSCALE_SHIFT,
+};
+
+/* uart configurations */
+static struct aux_clk_config uart_config = {
+	.synth_reg = UART_CLK_SYNT,
+	.masks = &aux_masks,
+};
+
+/* clocks derived from pll1 or pll5 */
+/* uart parents */
+static struct pclk_info uart_pclk_info[] = {
+	{
+		.pclk = &pll5_clk,
+		.pclk_mask = AUX_CLK_PLL5_MASK,
+	}, {
+		.pclk = &pll1_clk,
+		.pclk_mask = AUX_CLK_PLL1_MASK,
+		.scalable = 1,
+	},
+};
+
+/* uart parent select structure */
+static struct pclk_sel uart_pclk_sel = {
+	.pclk_info = uart_pclk_info,
+	.pclk_count = ARRAY_SIZE(uart_pclk_info),
+	.pclk_sel_reg = PERIP_CLK_CFG,
+	.pclk_sel_mask = UART_CLK_MASK,
+};
+
+/* uart clock */
+static struct clk uart_clk = {
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = UART_CLK_ENB,
+	.pclk_sel = &uart_pclk_sel,
+	.pclk_sel_shift = UART_CLK_SHIFT,
+	.recalc = &aux_clk_recalc,
+	.private_data = &uart_config,
+};
+
+/* array of all spear 13xx clock lookups */
+static struct clk_lookup spear_clk_lookups[] = {
+	/* root clks */
+	{.con_id = "osc1_24m_clk",	.clk = &osc1_24m_clk},
+	{.con_id = "osc2_32k_clk",	.clk = &osc2_32k_clk},
+	{.con_id = "osc3_25m_clk",	.clk = &osc3_25m_clk},
+
+	/* clock derived from 32 KHz osc clk */
+	{.dev_id = "rtc",		.clk = &rtc_clk},
+
+	/* clock derived from 24/25 MHz osc1/osc3 clk */
+	{.con_id = "pll1_clk",		.clk = &pll1_clk},
+	{.con_id = "pll2_clk",		.clk = &pll2_clk},
+	{.con_id = "pll3_clk",		.clk = &pll3_clk},
+	{.con_id = "pll4_clk",		.clk = &pll4_clk},
+	{.con_id = "pll5_clk",		.clk = &pll5_clk},
+	{.con_id = "pll6_clk",		.clk = &pll6_clk},
+
+	/* clock derived from pll1 clk */
+	{.con_id = "cpu_clk",		.clk = &cpu_clk},
+	{.con_id = "ahb_clk",		.clk = &ahb_clk},
+	{ .con_id = "apb_clk",		.clk = &apb_clk},
+
+	/* clocks having multiple parent source from above clocks */
+	{.dev_id = "uart",		.clk = &uart_clk},
+	{.dev_id = "gpt0",		.clk = &gpt0_clk},
+	{.dev_id = "gpt1",		.clk = &gpt1_clk},
+	{.dev_id = "gpt2",		.clk = &gpt2_clk},
+	{.dev_id = "gpt3",		.clk = &gpt3_clk},
+
+	/* clock derived from ahb/apb clk */
+	{ .dev_id = "smi",		.clk = &smi_clk},
+	{ .dev_id = "wdt",		.clk = &wdt_clk},
+};
+
+void __init clk_init(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(spear_clk_lookups); i++)
+		clk_register(&spear_clk_lookups[i]);
+
+	recalc_root_clocks();
+}
diff --git a/arch/arm/mach-spear13xx/headsmp.S b/arch/arm/mach-spear13xx/headsmp.S
new file mode 100644
index 0000000..bbe73f3
--- /dev/null
+++ b/arch/arm/mach-spear13xx/headsmp.S
@@ -0,0 +1,95 @@
+/*
+ * arch/arm/mach-spear13XX/headsmp.S
+ *
+ * Picked from realview
+ * Copyright (c) 2010 ST Microelectronics Limited
+ * Shiraz Hashim <shiraz.hashim@st.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+#include <linux/init.h>
+
+	__INIT
+
+/*
+ * This one is picked from Tegra :-
+ *
+ * The secondary kernel init calls v7_flush_dcache_all before it enables
+ * the L1; however, the L1 comes out of reset in an undefined state, so
+ * the clean + invalidate performed by v7_flush_dcache_all causes a bunch
+ * of cache lines with uninitialized data and uninitialized tags to get
+ * written out to memory, which does really unpleasant things to the ain
+ * processor. We fix this by performing an invalidate, rather than a
+ * clean + invalidate, before jumping into the kernel.
+ */
+ENTRY(v7_invalidate_l1)
+	mov	r0, #0
+	mcr	p15, 2, r0, c0, c0, 0
+	mrc	p15, 1, r0, c0, c0, 0
+
+	ldr	r1, =0x7fff
+	and	r2, r1, r0, lsr #13
+
+	ldr	r1, =0x3ff
+
+	and	r3, r1, r0, lsr #3	@ NumWays - 1
+	add	r2, r2, #1	@ NumSets
+
+	and	r0, r0, #0x7
+	add	r0, r0, #4	@ SetShift
+
+	clz	r1, r3		@ WayShift
+	add	r4, r3, #1	@ NumWays
+1:	sub	r2, r2, #1	@ NumSets--
+	mov	r3, r4		@ Temp = NumWays
+2:	subs	r3, r3, #1	@ Temp--
+	mov	r5, r3, lsl r1
+	mov	r6, r2, lsl r0
+	orr	r5, r5, r6	@ Reg = Temp<<WayShift)|(NumSets<<SetShift)
+	mcr	p15, 0, r5, c7, c6, 2
+	bgt	2b
+	cmp	r2, #0
+	bgt	1b
+	dsb
+	isb
+	mov	pc, lr
+ENDPROC(v7_invalidate_l1)
+
+/*
+ * spear13xx specific entry point for secondary CPUs. This provides
+ * a "holding pen" into which all secondary cores are held until we're
+ * ready for them to initialise.
+ */
+ENTRY(spear13xx_secondary_startup)
+	/* If we don't do this then we have a crash */
+
+	/*
+	 * Since now this is being called from xloader so removing it
+	 * here
+	 */
+#if 0
+	bl v7_invalidate_l1
+#endif
+
+	mrc	p15, 0, r0, c0, c0, 5
+	and	r0, r0, #15
+	adr	r4, 1f
+	ldmia	r4, {r5, r6}
+	sub	r4, r4, r5
+	add	r6, r6, r4
+pen:	ldr	r7, [r6]
+	cmp	r7, r0
+	bne	pen
+
+	/*
+	 * we've been released from the holding pen: secondary_stack
+	 * should now contain the SVC stack for this core
+	 */
+	b	secondary_startup
+
+1:	.long	.
+	.long	pen_release
diff --git a/arch/arm/mach-spear13xx/include/mach/entry-macro.S b/arch/arm/mach-spear13xx/include/mach/entry-macro.S
index 62e1785..6bff502 100644
--- a/arch/arm/mach-spear13xx/include/mach/entry-macro.S
+++ b/arch/arm/mach-spear13xx/include/mach/entry-macro.S
@@ -11,8 +11,8 @@
  * warranty of any kind, whether express or implied.
  */
 
-#include <mach/hardware.h>
 #include <asm/hardware/gic.h>
+#include <mach/hardware.h>
 
 		.macro	disable_fiq
 		.endm
diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index 9ecc6b2..5c0f042 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -29,7 +29,7 @@
 #define SPEAR_GPT0_CHAN1_IRQ	IRQ_GPT0_TMR1
 
 /* Add spear13xx family device structure declarations here */
-extern struct amba_device uart_device;
+extern struct amba_device spear13xx_uart_device;
 extern struct sys_timer spear13xx_timer;
 
 /* Add spear1300 machine device structure declarations here */
diff --git a/arch/arm/mach-spear13xx/localtimer.c b/arch/arm/mach-spear13xx/localtimer.c
new file mode 100644
index 0000000..816b08c
--- /dev/null
+++ b/arch/arm/mach-spear13xx/localtimer.c
@@ -0,0 +1,25 @@
+/*
+ * arch/arm/mach-spear13xx/localtimer.c
+ * Directly picked from realview
+ *
+ * Copyright (C) 2010 ST Microelectronics Ltd.
+ * Shiraz Hashim <shiraz.hashim@st.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/clockchips.h>
+#include <asm/irq.h>
+#include <asm/smp_twd.h>
+#include <asm/localtimer.h>
+
+/* Setup the local clock events for a CPU. */
+void __cpuinit local_timer_setup(struct clock_event_device *evt)
+{
+	evt->irq = IRQ_LOCALTIMER;
+	twd_timer_setup(evt);
+}
diff --git a/arch/arm/mach-spear13xx/platsmp.c b/arch/arm/mach-spear13xx/platsmp.c
new file mode 100644
index 0000000..e134f4b
--- /dev/null
+++ b/arch/arm/mach-spear13xx/platsmp.c
@@ -0,0 +1,200 @@
+/*
+ * arch/arm/mach-spear13xx/platsmp.c
+ *
+ * based upon linux/arch/arm/mach-realview/platsmp.c
+ *
+ * Copyright (C) 2010 ST Microelectronics Ltd.
+ * Shiraz Hashim <shiraz.hashim@st.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/jiffies.h>
+#include <linux/smp.h>
+#include <asm/cacheflush.h>
+#include <asm/hardware/gic.h>
+#include <asm/localtimer.h>
+#include <asm/mach-types.h>
+#include <asm/smp_scu.h>
+#include <asm/system.h>
+#include <asm/unified.h>
+#include <mach/generic.h>
+#include <mach/hardware.h>
+
+/*
+ * control for which core is the next to come out of the secondary
+ * boot "holding pen"
+ */
+volatile int __cpuinitdata pen_release = -1;
+static DEFINE_SPINLOCK(boot_lock);
+
+static void __iomem *scu_base_addr(void)
+{
+	return __io_address(SPEAR13XX_SCU_BASE);
+}
+
+static inline unsigned int get_core_count(void)
+{
+	void __iomem *scu_base = scu_base_addr();
+
+	if (scu_base)
+		return scu_get_core_count(scu_base);
+	return 1;
+}
+
+void __cpuinit platform_secondary_init(unsigned int cpu)
+{
+	trace_hardirqs_off();
+
+	/*
+	 * if any interrupts are already enabled for the primary
+	 * core (e.g. timer irq), then they will not have been enabled
+	 * for us: do so
+	 */
+	gic_cpu_init(0, __io_address(SPEAR13XX_GIC_CPU_BASE));
+
+	/*
+	 * let the primary processor know we're out of the
+	 * pen, then head off into the C entry point
+	 */
+	pen_release = -1;
+	smp_wmb();
+
+	/*
+	 * Synchronise with the boot thread.
+	 */
+	spin_lock(&boot_lock);
+	spin_unlock(&boot_lock);
+}
+
+int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	unsigned long timeout;
+
+	/*
+	 * set synchronisation state between this boot processor
+	 * and the secondary one
+	 */
+	spin_lock(&boot_lock);
+
+	/*
+	 * The secondary processor is waiting to be released from
+	 * the holding pen - release it, then wait for it to flag
+	 * that it has been released by resetting pen_release.
+	 *
+	 * Note that "pen_release" is the hardware CPU ID, whereas
+	 * "cpu" is Linux's internal ID.
+	 */
+	pen_release = cpu;
+	flush_cache_all();
+
+	timeout = jiffies + (1 * HZ);
+	while (time_before(jiffies, timeout)) {
+		smp_rmb();
+		if (pen_release == -1)
+			break;
+
+		udelay(10);
+	}
+
+	/*
+	 * now the secondary core is starting up let it run its
+	 * calibrations, then wait for it to finish
+	 */
+	spin_unlock(&boot_lock);
+
+	return pen_release != -1 ? -ENOSYS : 0;
+}
+
+static void __init wakeup_secondary(void)
+{
+	/* nobody is to be released from the pen yet */
+	pen_release = -1;
+
+	/*
+	 * Write the address of secondary startup into the system-wide
+	 * location (presently it is in SRAM). The BootMonitor waits
+	 * for this register to become non-zero.
+	 * We must also send an sev to wake it up
+	 */
+	__raw_writel(BSYM(virt_to_phys(spear13xx_secondary_startup)),
+			__io_address(SPEAR13XX_SYS_LOCATION));
+
+	mb();
+
+	/*
+	 * Send a 'sev' to wake the secondary core from WFE.
+	 */
+	sev();
+}
+
+/*
+ * Initialise the CPU possible map early - this describes the CPUs
+ * which may be present or become present in the system.
+ */
+void __init smp_init_cpus(void)
+{
+	unsigned int i, ncores = get_core_count();
+
+	for (i = 0; i < ncores; i++)
+		set_cpu_possible(i, true);
+}
+
+void __init smp_prepare_cpus(unsigned int max_cpus)
+{
+	unsigned int ncores = get_core_count();
+	unsigned int cpu = smp_processor_id();
+	int i;
+
+	/* sanity check */
+	if (ncores == 0) {
+		pr_err("Realview: strange CM count of 0? Default to 1\n");
+
+		ncores = 1;
+	}
+
+	if (ncores > num_possible_cpus()) {
+		ncores = num_possible_cpus();
+		pr_err(
+		       "spear13xx: no. of cores (%d) greater than configured "
+		       "maximum of %d - clipping\n",
+		       ncores, ncores);
+	}
+
+	smp_store_cpu_info(cpu);
+
+	/*
+	 * are we trying to boot more cores than exist?
+	 */
+	if (max_cpus > ncores)
+		max_cpus = ncores;
+
+	/*
+	 * Initialise the present map, which describes the set of CPUs
+	 * actually populated at the present time.
+	 */
+	for (i = 0; i < max_cpus; i++)
+		set_cpu_present(i, true);
+
+	/*
+	 * Initialise the SCU if there are more than one CPU and let
+	 * them know where to start.
+	 */
+	if (max_cpus > 1) {
+		/*
+		 * Enable the local timer or broadcast device for the
+		 * boot CPU, but only if we have more than one CPU.
+		 */
+		percpu_timer_setup();
+
+		scu_enable(scu_base_addr());
+		wakeup_secondary();
+	}
+}
diff --git a/arch/arm/mach-spear13xx/spear1300.c b/arch/arm/mach-spear13xx/spear1300.c
new file mode 100644
index 0000000..c1b82f1
--- /dev/null
+++ b/arch/arm/mach-spear13xx/spear1300.c
@@ -0,0 +1,23 @@
+/*
+ * arch/arm/mach-spear13xx/spear1300.c
+ *
+ * SPEAr1300 machine source file
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Shiraz Hashim <shiraz.hashim@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <mach/generic.h>
+#include <mach/spear.h>
+
+/* Add spear1300 specific devices here */
+
+void __init spear1300_init(void)
+{
+	/* call spear13xx family common init function */
+	spear13xx_init();
+}
diff --git a/arch/arm/mach-spear13xx/spear1300_evb.c b/arch/arm/mach-spear13xx/spear1300_evb.c
new file mode 100644
index 0000000..9a83d61
--- /dev/null
+++ b/arch/arm/mach-spear13xx/spear1300_evb.c
@@ -0,0 +1,48 @@
+/*
+ * arch/arm/mach-spear13xx/spear1300_evb.c
+ *
+ * SPEAr1300 evaluation board source file
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Shiraz Hashim <shiraz.hashim@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach-types.h>
+#include <mach/generic.h>
+#include <mach/spear.h>
+
+static struct amba_device *amba_devs[] __initdata = {
+	&spear13xx_uart_device,
+};
+
+static struct platform_device *plat_devs[] __initdata = {
+};
+
+static void __init spear1300_evb_init(void)
+{
+	unsigned int i;
+
+	/* call spear1300 machine init function */
+	spear1300_init();
+
+	/* Add Platform Devices */
+	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
+
+	/* Add Amba Devices */
+	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
+		amba_device_register(amba_devs[i], &iomem_resource);
+}
+
+MACHINE_START(SPEAR1300, "ST-SPEAR1300-EVB")
+	.boot_params	=	0x00000100,
+	.map_io		=	spear13xx_map_io,
+	.init_irq	=	spear13xx_init_irq,
+	.timer		=	&spear13xx_timer,
+	.init_machine	=	spear1300_evb_init,
+MACHINE_END
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
new file mode 100644
index 0000000..8e3cdb7
--- /dev/null
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -0,0 +1,121 @@
+/*
+ * arch/arm/mach-spear13xx/spear13xx.c
+ *
+ * SPEAr13XX machines common source file
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Shiraz Hashim <shiraz.hashim@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/types.h>
+#include <linux/ptrace.h>
+#include <linux/io.h>
+#include <asm/hardware/gic.h>
+#include <asm/irq.h>
+#include <asm/localtimer.h>
+#include <asm/mach/arch.h>
+#include <asm/smp_twd.h>
+#include <mach/irqs.h>
+#include <mach/generic.h>
+#include <mach/hardware.h>
+
+/* Add spear13xx machines common devices here */
+/* uart device registeration */
+struct amba_device spear13xx_uart_device = {
+	.dev = {
+		.init_name = "uart",
+	},
+	.res = {
+		.start = SPEAR13XX_UART_BASE,
+		.end = SPEAR13XX_UART_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {IRQ_UART, NO_IRQ},
+};
+
+/* Do spear13xx familiy common initialization part here */
+void __init spear13xx_init(void)
+{
+	/* nothing to do for now */
+}
+
+/* This will initialize vic */
+void __init spear13xx_init_irq(void)
+{
+	gic_dist_init(0, __io_address(SPEAR13XX_GIC_DIST_BASE), 29);
+	gic_cpu_init(0, __io_address(SPEAR13XX_GIC_CPU_BASE));
+}
+
+/* Following will create static virtual/physical mappings */
+struct map_desc spear13xx_io_desc[] __initdata = {
+	{
+		.virtual	= IO_ADDRESS(SPEAR13XX_UART_BASE),
+		.pfn		= __phys_to_pfn(SPEAR13XX_UART_BASE),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE
+	}, {
+		.virtual	= IO_ADDRESS(SPEAR13XX_A9SM_PERIP_BASE),
+		.pfn		= __phys_to_pfn(SPEAR13XX_A9SM_PERIP_BASE),
+		.length		= SZ_8K,
+		.type		= MT_DEVICE
+	}, {
+		.virtual	= IO_ADDRESS(SPEAR13XX_MISC_BASE),
+		.pfn		= __phys_to_pfn(SPEAR13XX_MISC_BASE),
+		.length		= SZ_8K,
+		.type		= MT_DEVICE
+	}, {
+		.virtual	= IO_ADDRESS(SPEAR13XX_SYSRAM0_BASE),
+		.pfn		= __phys_to_pfn(SPEAR13XX_SYSRAM0_BASE),
+		.length		= SZ_32K,
+		.type		= MT_DEVICE
+	},
+};
+
+/* This will create static memory mapping for selected devices */
+void __init spear13xx_map_io(void)
+{
+	iotable_init(spear13xx_io_desc, ARRAY_SIZE(spear13xx_io_desc));
+
+	/* This will initialize clock framework */
+	clk_init();
+}
+
+static void __init spear13xx_timer_init(void)
+{
+	char pclk_name[] = "osc1_24m_clk";
+	struct clk *gpt_clk, *pclk;
+
+#ifdef CONFIG_LOCAL_TIMERS
+	/* Setup the local timer base */
+	twd_base = __io_address(SPEAR13XX_LOCAL_TMR_BASE);
+#endif
+
+	/* get the system timer clock */
+	gpt_clk = clk_get_sys("gpt0", NULL);
+	if (!gpt_clk) {
+		pr_err("%s:couldn't get clk for gpt\n", __func__);
+		BUG();
+	}
+
+	/* get the suitable parent clock for timer*/
+	pclk = clk_get(NULL, pclk_name);
+	if (!pclk) {
+		pr_err("%s:couldn't get %s as parent for gpt\n",
+				__func__, pclk_name);
+		BUG();
+	}
+
+	clk_set_parent(gpt_clk, pclk);
+	clk_put(gpt_clk);
+	clk_put(pclk);
+
+	spear_setup_timer();
+}
+
+struct sys_timer spear13xx_timer = {
+	.init = spear13xx_timer_init,
+};
-- 
1.7.2.2
