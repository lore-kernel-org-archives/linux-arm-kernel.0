From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 28 Mar 2011 11:23:51 +0530
Subject: [PATCH V6 02/10 resend] SPEAr13xx: Add machine specific src files
In-Reply-To: <cover.1298977719.git.viresh.kumar@st.com>
References: <cover.1298977719.git.viresh.kumar@st.com>
Message-ID: <e06444ce352c3ab8d3b7ed75176be3f0abb80ff7.1298977719.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shiraz Hashim <shiraz.hashim@st.com>

Changes in V6 resend:
 - Updated clock.c according to misc register definition updations

Reviewed-by: Stanley Miao <stanley.miao@windriver.com>
Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear13xx/Kconfig                |   21 +
 arch/arm/mach-spear13xx/Makefile               |   14 +
 arch/arm/mach-spear13xx/Makefile.boot          |    3 +
 arch/arm/mach-spear13xx/clock.c                | 1012 ++++++++++++++++++++++++
 arch/arm/mach-spear13xx/headsmp.S              |   42 +
 arch/arm/mach-spear13xx/include/mach/generic.h |    2 +-
 arch/arm/mach-spear13xx/localtimer.c           |   25 +
 arch/arm/mach-spear13xx/platsmp.c              |  162 ++++
 arch/arm/mach-spear13xx/spear1300.c            |   23 +
 arch/arm/mach-spear13xx/spear1300_evb.c        |   48 ++
 arch/arm/mach-spear13xx/spear13xx.c            |  121 +++
 11 files changed, 1472 insertions(+), 1 deletions(-)
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
index 0000000..1e70cd1
--- /dev/null
+++ b/arch/arm/mach-spear13xx/clock.c
@@ -0,0 +1,1012 @@
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
+		.pclk_val = OSC_24M_VAL,
+	}, {
+		.pclk = &osc3_25m_clk,
+		.pclk_val = OSC_25M_VAL,
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
+/* pll rate configuration table, in ascending order of rates */
+struct pll_rate_tbl pll_rtbl[] = {
+	/* PCLK 24MHz */
+	{.mode = 0, .m = 0x7D, .n = 0x03, .p = 0x2}, /* 500 MHz */
+	{.mode = 0, .m = 0xA6, .n = 0x03, .p = 0x2}, /* 664 MHz */
+	{.mode = 0, .m = 0xC8, .n = 0x03, .p = 0x2}, /* 800 MHz */
+	{.mode = 0, .m = 0xFA, .n = 0x06, .p = 0x1}, /* 1000 MHz */
+};
+
+/* pll1 clock */
+static struct clk pll1_clk = {
+	.flags = ENABLED_ON_INIT,
+	.pclk_sel = &pll_pclk_sel,
+	.pclk_sel_shift = PLL1_CLK_SHIFT,
+	.en_reg = PLL1_CTR,
+	.en_reg_bit = PLL_ENABLE,
+	.calc_rate = &pll_calc_rate,
+	.recalc = &pll_clk_recalc,
+	.set_rate = &pll_clk_set_rate,
+	.rate_config = {pll_rtbl, ARRAY_SIZE(pll_rtbl), 3},
+	.private_data = &pll1_config,
+};
+
+/* pll1div2 clock */
+static struct clk pll1div2_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &pll1_clk,
+	.div_factor = 2,
+	.recalc = &follow_parent,
+};
+
+/* pll1div4 clock */
+static struct clk pll1div4_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &pll1_clk,
+	.div_factor = 4,
+	.recalc = &follow_parent,
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
+	.calc_rate = &pll_calc_rate,
+	.recalc = &pll_clk_recalc,
+	.set_rate = &pll_clk_set_rate,
+	.rate_config = {pll_rtbl, ARRAY_SIZE(pll_rtbl), 3},
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
+	.calc_rate = &pll_calc_rate,
+	.recalc = &pll_clk_recalc,
+	.set_rate = &pll_clk_set_rate,
+	.rate_config = {pll_rtbl, ARRAY_SIZE(pll_rtbl), 3},
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
+/* pll4 rate configuration table, in ascending order of rates */
+struct pll_rate_tbl pll4_rtbl[] = {
+	{.mode = 0, .m = 0x7D, .n = 0x03, .p = 0x2}, /* 500 MHz */
+	{.mode = 0, .m = 0xA6, .n = 0x03, .p = 0x2}, /* 664 MHz */
+	{.mode = 0, .m = 0xC8, .n = 0x03, .p = 0x2}, /* 800 MHz */
+	{.mode = 0, .m = 0xFA, .n = 0x06, .p = 0x1}, /* 1000 MHz */
+};
+
+/* pll4 (DDR) clock */
+static struct clk pll4_clk = {
+	.flags = ENABLED_ON_INIT,
+	.pclk = &osc1_24m_clk,
+	.en_reg = PLL4_CTR,
+	.en_reg_bit = PLL_ENABLE,
+	.calc_rate = &pll_calc_rate,
+	.recalc = &pll_clk_recalc,
+	.set_rate = &pll_clk_set_rate,
+	.rate_config = {pll4_rtbl, ARRAY_SIZE(pll4_rtbl), 3},
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
+		.pclk_val = GPT_OSC24_VAL,
+	}, {
+		.pclk = &apb_clk,
+		.pclk_val = GPT_APB_VAL,
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
+	.pclk = &cpu_clk,
+	.div_factor = 2,
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
+/* clocks derived multiple parents (pll1, pll5, synthesizers or others) */
+/* uart configurations */
+static struct aux_clk_config uart_synth_config = {
+	.synth_reg = UART_CLK_SYNT,
+	.masks = &aux_masks,
+};
+
+/* aux rate configuration table, in ascending order of rates */
+struct aux_rate_tbl aux_rtbl[] = {
+	/* For PLL1div2 = 500 MHz */
+	{.xscale = 2, .yscale = 21, .eq = 1}, /* 48 MHz */
+	{.xscale = 1, .yscale = 6, .eq = 1}, /* 83 MHz */
+	{.xscale = 1, .yscale = 4, .eq = 1}, /* 125 MHz */
+	{.xscale = 1, .yscale = 3, .eq = 1}, /* 166 MHz */
+	{.xscale = 1, .yscale = 2, .eq = 1}, /* 250 MHz */
+};
+
+/* uart synth clock */
+static struct clk uart_synth_clk = {
+	.en_reg = UART_CLK_SYNT,
+	.en_reg_bit = AUX_SYNT_ENB,
+	.pclk = &pll1div2_clk,
+	.calc_rate = &aux_calc_rate,
+	.recalc = &aux_clk_recalc,
+	.set_rate = &aux_clk_set_rate,
+	.rate_config = {aux_rtbl, ARRAY_SIZE(aux_rtbl), 1},
+	.private_data = &uart_synth_config,
+};
+
+/* uart parents */
+static struct pclk_info uart_pclk_info[] = {
+	{
+		.pclk = &pll5_clk,
+		.pclk_val = AUX_CLK_PLL5_VAL,
+	}, {
+		.pclk = &uart_synth_clk,
+		.pclk_val = AUX_CLK_SYNT_VAL,
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
+	.recalc = &follow_parent,
+};
+
+/* sdhci configurations */
+static struct aux_clk_config sdhci_synth_config = {
+	.synth_reg = SDHCI_CLK_SYNT,
+	.masks = &aux_masks,
+};
+
+/* sdhci synth clock */
+static struct clk sdhci_synth_clk = {
+	.en_reg = SDHCI_CLK_SYNT,
+	.en_reg_bit = AUX_SYNT_ENB,
+	.pclk = &pll1div2_clk,
+	.calc_rate = &aux_calc_rate,
+	.recalc = &aux_clk_recalc,
+	.set_rate = &aux_clk_set_rate,
+	.rate_config = {aux_rtbl, ARRAY_SIZE(aux_rtbl), 0},
+	.private_data = &sdhci_synth_config,
+};
+
+/* sdhci clock */
+static struct clk sdhci_clk = {
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = SDHCI_CLK_ENB,
+	.pclk = &sdhci_synth_clk,
+	.recalc = &follow_parent,
+};
+
+/* cfxd configurations */
+static struct aux_clk_config cfxd_synth_config = {
+	.synth_reg = CFXD_CLK_SYNT,
+	.masks = &aux_masks,
+};
+
+/* cfxd synth clock */
+static struct clk cfxd_synth_clk = {
+	.en_reg = CFXD_CLK_SYNT,
+	.en_reg_bit = AUX_SYNT_ENB,
+	.pclk = &pll1div2_clk,
+	.calc_rate = &aux_calc_rate,
+	.recalc = &aux_clk_recalc,
+	.set_rate = &aux_clk_set_rate,
+	.rate_config = {aux_rtbl, ARRAY_SIZE(aux_rtbl), 0},
+	.private_data = &cfxd_synth_config,
+};
+
+/* cfxd clock */
+static struct clk cfxd_clk = {
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = CFXD_CLK_ENB,
+	.pclk = &cfxd_synth_clk,
+	.recalc = &follow_parent,
+};
+
+/* C3 clk configurations */
+static struct aux_clk_config c3_synth_config = {
+	.synth_reg = C3_CLK_SYNT,
+	.masks = &aux_masks,
+};
+
+/* c3 synth clock */
+static struct clk c3_synth_clk = {
+	.en_reg = C3_CLK_SYNT,
+	.en_reg_bit = AUX_SYNT_ENB,
+	.pclk = &pll1div2_clk,
+	.calc_rate = &aux_calc_rate,
+	.recalc = &aux_clk_recalc,
+	.set_rate = &aux_clk_set_rate,
+	.rate_config = {aux_rtbl, ARRAY_SIZE(aux_rtbl), 1},
+	.private_data = &c3_synth_config,
+};
+
+/* c3 parents */
+static struct pclk_info c3_pclk_info[] = {
+	{
+		.pclk = &pll5_clk,
+		.pclk_val = AUX_CLK_PLL5_VAL,
+	}, {
+		.pclk = &c3_synth_clk,
+		.pclk_val = AUX_CLK_SYNT_VAL,
+	},
+};
+
+/* c3 parent select structure */
+static struct pclk_sel c3_pclk_sel = {
+	.pclk_info = c3_pclk_info,
+	.pclk_count = ARRAY_SIZE(c3_pclk_info),
+	.pclk_sel_reg = PERIP_CLK_CFG,
+	.pclk_sel_mask = C3_CLK_MASK,
+};
+
+/* c3 clock */
+static struct clk c3_clk = {
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = C3_CLK_ENB,
+	.pclk_sel = &c3_pclk_sel,
+	.pclk_sel_shift = C3_CLK_SHIFT,
+	.recalc = &follow_parent,
+};
+
+/* gmac phy clk configurations */
+static struct aux_clk_config gmac_phy_synth_config = {
+	.synth_reg = GMAC_CLK_SYNT,
+	.masks = &aux_masks,
+};
+
+/* gmii external pad clock for phy operation */
+static struct clk gmii_txclk125_pad = {
+	.flags = ALWAYS_ENABLED,
+	.rate = 125000000,
+};
+
+/* gmac phy set of input clks*/
+static struct pclk_info gmac_phy_input_pclk_info[] = {
+	{
+		.pclk = &gmii_txclk125_pad,
+		.pclk_val = GMAC_PHY_125M_PAD_VAL,
+	}, {
+		.pclk = &pll2_clk,
+		.pclk_val = GMAC_PHY_PLL2_VAL,
+	}, {
+		.pclk = &osc3_25m_clk,
+		.pclk_val = GMAC_PHY_OSC3_VAL,
+	},
+};
+
+static struct pclk_sel gmac_phy_input_pclk_sel = {
+	.pclk_info = gmac_phy_input_pclk_info,
+	.pclk_count = ARRAY_SIZE(gmac_phy_input_pclk_info),
+	.pclk_sel_reg = GMAC_CLK_CFG,
+	.pclk_sel_mask = GMAC_PHY_INPUT_CLK_MASK,
+};
+
+static struct clk gmac_phy_input_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk_sel = &gmac_phy_input_pclk_sel,
+	.pclk_sel_shift = GMAC_PHY_INPUT_CLK_SHIFT,
+	.recalc = &follow_parent,
+};
+
+/* gmac rate configuration table, in ascending order of rates */
+static struct aux_rate_tbl gmac_rtbl[] = {
+	/* For gmac phy input clk */
+	{.xscale = 1, .yscale = 6, .eq = 1}, /* divided by 6 */
+	{.xscale = 1, .yscale = 4, .eq = 1}, /* divided by 4 */
+	{.xscale = 1, .yscale = 3, .eq = 1}, /* divided by 3 */
+	{.xscale = 1, .yscale = 2, .eq = 1}, /* divided by 2 */
+};
+
+static struct clk gmac_phy_synth_clk = {
+	.en_reg = GMAC_CLK_SYNT,
+	.en_reg_bit = AUX_SYNT_ENB,
+	.pclk = &gmac_phy_input_clk,
+	.calc_rate = &aux_calc_rate,
+	.recalc = &aux_clk_recalc,
+	.set_rate = &aux_clk_set_rate,
+	.rate_config = {gmac_rtbl, ARRAY_SIZE(gmac_rtbl), 0},
+	.private_data = &gmac_phy_synth_config,
+};
+
+/* gmac phy parents */
+static struct pclk_info gmac_phy_pclk_info[] = {
+	{
+		.pclk = &gmac_phy_input_clk,
+		.pclk_val = GMAC_PHY_INPUT_ENB_VAL,
+	}, {
+		.pclk = &gmac_phy_synth_clk,
+		.pclk_val = GMAC_PHY_SYNT_ENB_VAL,
+	}
+};
+
+/* gmac phy parent select structure */
+static struct pclk_sel gmac_phy_pclk_sel = {
+	.pclk_info = gmac_phy_pclk_info,
+	.pclk_count = ARRAY_SIZE(gmac_phy_pclk_info),
+	.pclk_sel_reg = GMAC_CLK_CFG,
+	.pclk_sel_mask = GMAC_PHY_CLK_MASK,
+};
+
+/* gmac phy clock */
+static struct clk gmac_phy0_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk_sel = &gmac_phy_pclk_sel,
+	.pclk_sel_shift = GMAC_PHY_CLK_SHIFT,
+	.recalc = &follow_parent,
+};
+
+/* clcd synthesizers masks */
+static struct clcd_synth_masks clcd_masks = {
+	.div_factor_mask = FRAC_SYNT_DIV_FACTOR_MASK,
+	.div_factor_shift = FRAC_SYNT_DIV_FACTOR_SHIFT,
+};
+
+static struct clcd_clk_config clcd_synth_config = {
+	.synth_reg = CLCD_CLK_SYNT,
+	.masks = &clcd_masks,
+};
+
+/* clcd synth parents */
+static struct pclk_info clcd_synth_pclk_info[] = {
+	{
+		.pclk = &pll1div4_clk,
+		.pclk_val = CLCD_SYNT_PLL1_DIV4_VAL,
+	}, {
+		.pclk = &pll2_clk,
+		.pclk_val = CLCD_SYNT_PLL2_VAL,
+	},
+};
+
+/* clcd synth parent select structure */
+static struct pclk_sel clcd_synth_pclk_sel = {
+	.pclk_info = clcd_synth_pclk_info,
+	.pclk_count = ARRAY_SIZE(clcd_synth_pclk_info),
+	.pclk_sel_reg = PLL_CFG,
+	.pclk_sel_mask = CLCD_SYNT_CLK_MASK,
+};
+
+/* clcd rate configuration table, in ascending order of rates */
+struct clcd_rate_tbl clcd_rtbl[] = {
+	/* For pll1div4 = 250 MHz */
+	{.div = 0x4000}, /* 62.5 MHz */
+	{.div = 0x2000}, /* 125 MHz */
+};
+
+/* clcd synth clock */
+static struct clk clcd_synth_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk_sel = &clcd_synth_pclk_sel,
+	.pclk_sel_shift = CLCD_SYNT_CLK_SHIFT,
+	.calc_rate = &clcd_calc_rate,
+	.recalc = &clcd_clk_recalc,
+	.set_rate = &clcd_clk_set_rate,
+	.rate_config = {clcd_rtbl, ARRAY_SIZE(clcd_rtbl), 1},
+	.private_data = &clcd_synth_config,
+};
+
+/* clcd clock parents */
+static struct pclk_info clcd_pclk_info[] = {
+	{
+		.pclk = &pll5_clk,
+		.pclk_val = AUX_CLK_PLL5_VAL,
+	}, {
+		.pclk = &clcd_synth_clk,
+		.pclk_val = AUX_CLK_SYNT_VAL,
+	},
+};
+
+/* clcd parent select structure */
+static struct pclk_sel clcd_pclk_sel = {
+	.pclk_info = clcd_pclk_info,
+	.pclk_count = ARRAY_SIZE(clcd_pclk_info),
+	.pclk_sel_reg = PERIP_CLK_CFG,
+	.pclk_sel_mask = CLCD_CLK_MASK,
+};
+
+/* clcd clock */
+static struct clk clcd_clk = {
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = CLCD_CLK_ENB,
+	.pclk_sel = &clcd_pclk_sel,
+	.pclk_sel_shift = CLCD_CLK_SHIFT,
+	.recalc = &follow_parent,
+};
+
+/* clock derived from ahb clk */
+
+/* i2c clock */
+static struct clk i2c_clk = {
+	.pclk = &ahb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = I2C_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* dma clock */
+static struct clk dma0_clk = {
+	.pclk = &ahb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = DMA0_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+static struct clk dma1_clk = {
+	.pclk = &ahb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = DMA1_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* jpeg clock */
+static struct clk jpeg_clk = {
+	.pclk = &ahb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = JPEG_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* gmac clock :Fixed Part*/
+static struct clk gmac0_clk = {
+	.pclk = &ahb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = GMAC_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* fsmc clock */
+static struct clk fsmc_clk = {
+	.pclk = &ahb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = FSMC_CLK_ENB,
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
+/* uhc0 clock */
+static struct clk uhci0_clk = {
+	.pclk = &ahb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = UHC0_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* uhc1 clock */
+static struct clk uhci1_clk = {
+	.pclk = &ahb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = UHC1_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* usbd clock */
+static struct clk usbd_clk = {
+	.pclk = &ahb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = USBD_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* pci clocks */
+static struct clk pcie0_clk = {
+	.pclk = &ahb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = PCIE0_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+static struct clk pcie1_clk = {
+	.pclk = &ahb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = PCIE1_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+static struct clk pcie2_clk = {
+	.pclk = &ahb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = PCIE2_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* sysram clocks */
+static struct clk sysram0_clk = {
+	.pclk = &ahb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = SYSRAM0_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+static struct clk sysram1_clk = {
+	.pclk = &ahb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = SYSRAM1_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* clock derived from apb clk */
+/* adc clock */
+static struct clk adc_clk = {
+	.pclk = &apb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = ADC_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* ssp clock */
+static struct clk ssp_clk = {
+	.pclk = &apb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = SSP_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* gpio clock */
+static struct clk gpio0_clk = {
+	.pclk = &apb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = GPIO0_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* gpio clock */
+static struct clk gpio1_clk = {
+	.pclk = &apb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = GPIO1_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* i2s0 clock */
+static struct clk i2s0_clk = {
+	.pclk = &apb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = I2S0_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* i2s1 clock */
+static struct clk i2s1_clk = {
+	.pclk = &apb_clk,
+	.en_reg = PERIP1_CLK_ENB,
+	.en_reg_bit = I2S1_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* keyboard clock */
+static struct clk kbd_clk = {
+	.pclk = &apb_clk,
+	.en_reg = PERIP2_CLK_ENB,
+	.en_reg_bit = KBD_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* RAS CLOCKS */
+/* pll3 generated clock */
+static struct clk ras_pll3_clk = {
+	.pclk = &pll3_clk,
+	.en_reg = RAS_CLK_ENB,
+	.en_reg_bit = PLL3_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* pll2 generated clock */
+static struct clk ras_pll2_clk = {
+	.pclk = &pll2_clk,
+	.en_reg = RAS_CLK_ENB,
+	.en_reg_bit = PLL2_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* 125MHz clock generated on Tx pad */
+static struct clk ras_tx125_clk = {
+	.pclk = &gmii_txclk125_pad,
+	.en_reg = RAS_CLK_ENB,
+	.en_reg_bit = C125M_PAD_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* 30 MHz clock generated by USB PHy Pll */
+static struct clk ras_30Mhz_clk = {
+	.rate = 30000000,
+	.en_reg = RAS_CLK_ENB,
+	.en_reg_bit = C30M_CLK_ENB,
+};
+
+/* 48 MHz clock generated by USB PHy Pll */
+static struct clk ras_48Mhz_clk = {
+	.pclk = &pll5_clk,
+	.en_reg = RAS_CLK_ENB,
+	.en_reg_bit = C48M_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* osc3 generated clock */
+static struct clk ras_osc3_clk = {
+	.pclk = &ahb_clk,
+	.en_reg = RAS_CLK_ENB,
+	.en_reg_bit = OSC3_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* osc2 generated clock */
+static struct clk ras_osc2_clk = {
+	.pclk = &osc2_32k_clk,
+	.en_reg = RAS_CLK_ENB,
+	.en_reg_bit = OSC2_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* osc1 generated clock */
+static struct clk ras_osc1_clk = {
+	.pclk = &osc1_24m_clk,
+	.en_reg = RAS_CLK_ENB,
+	.en_reg_bit = OSC1_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* apb generated clock */
+static struct clk ras_pclk_clk = {
+	.pclk = &apb_clk,
+	.en_reg = RAS_CLK_ENB,
+	.en_reg_bit = PCLK_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* ahb generated clock */
+static struct clk ras_aclk_clk = {
+	.pclk = &ahb_clk,
+	.en_reg = RAS_CLK_ENB,
+	.en_reg_bit = ACLK_CLK_ENB,
+	.recalc = &follow_parent,
+};
+
+/* External pad 50 MHz clock for phy operation */
+static struct clk ras_tx50_clk = {
+	.flags = ALWAYS_ENABLED,
+	.rate = 50000000,
+};
+
+/* spear1300 machine specific clock structures */
+#ifdef CONFIG_MACH_SPEAR1300
+
+#endif
+
+static struct clk dummy_apb_pclk;
+
+/* array of all spear 13xx clock lookups */
+static struct clk_lookup spear_clk_lookups[] = {
+	{ .con_id = "apb_pclk",		.clk = &dummy_apb_pclk},
+	/* root clks */
+	{.con_id = "osc1_24m_clk",	.clk = &osc1_24m_clk},
+	{.con_id = "osc2_32k_clk",	.clk = &osc2_32k_clk},
+	{.con_id = "osc3_25m_clk",	.clk = &osc3_25m_clk},
+
+	/* clock derived from 32 KHz osc clk */
+	{.dev_id = "rtc-spear",		.clk = &rtc_clk},
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
+	{.con_id = "apb_clk",		.clk = &apb_clk},
+
+	/* synthesizers/prescaled clocks */
+	{.con_id = "pll1div2_clk",		.clk = &pll1div2_clk},
+	{.con_id = "pll1div4_clk",		.clk = &pll1div4_clk},
+	{.con_id = "c3_synth_clk",		.clk = &c3_synth_clk},
+	{.con_id = "gmii_125m_pad_clk",		.clk = &gmii_txclk125_pad},
+	{.con_id = "clcd_synth_clk",		.clk = &clcd_synth_clk},
+	{.con_id = "uart_synth_clk",		.clk = &uart_synth_clk},
+	{.con_id = "sdhci_synth_clk",		.clk = &sdhci_synth_clk},
+	{.con_id = "cfxd_synth_clk",		.clk = &cfxd_synth_clk},
+	{.con_id = "gmac_phy_input_clk",	.clk = &gmac_phy_input_clk},
+	{.con_id = "gmac_phy_synth_clk",	.clk = &gmac_phy_synth_clk},
+	{.dev_id = "stmmacphy.0",		.clk = &gmac_phy0_clk},
+
+	/* RAS clocks */
+	{.con_id = "ras_pll3_clk",		.clk = &ras_pll3_clk},
+	{.con_id = "ras_pll2_clk",		.clk = &ras_pll2_clk},
+	{.con_id = "ras_tx125_clk",		.clk = &ras_tx125_clk},
+	{.con_id = "ras_30Mhz_clk",		.clk = &ras_30Mhz_clk},
+	{.con_id = "ras_48Mhz_clk",		.clk = &ras_48Mhz_clk},
+	{.con_id = "ras_osc3_clk",		.clk = &ras_osc3_clk},
+	{.con_id = "ras_osc2_clk",		.clk = &ras_osc2_clk},
+	{.con_id = "ras_osc1_clk",		.clk = &ras_osc1_clk},
+	{.con_id = "ras_pclk_clk",		.clk = &ras_pclk_clk},
+	{.con_id = "ras_aclk_clk",		.clk = &ras_aclk_clk},
+	{.con_id = "ras_tx50_clk",		.clk = &ras_tx50_clk},
+
+	/* clocks having multiple parent source from above clocks */
+	{.dev_id = "clcd",		.clk = &clcd_clk},
+	{.dev_id = "gpt0",		.clk = &gpt0_clk},
+	{.dev_id = "gpt1",		.clk = &gpt1_clk},
+	{.dev_id = "gpt2",		.clk = &gpt2_clk},
+	{.dev_id = "gpt3",		.clk = &gpt3_clk},
+	{.dev_id = "uart",		.clk = &uart_clk},
+
+	/* clock derived from ahb clk */
+	{.dev_id = "smi",		.clk = &smi_clk},
+	{.con_id = "usbh.0_clk",	.clk = &uhci0_clk},
+	{.con_id = "usbh.1_clk",	.clk = &uhci1_clk},
+	{.dev_id = "designware_udc",	.clk = &usbd_clk},
+	{.dev_id = "i2c_designware.0",	.clk = &i2c_clk},
+	{.dev_id = "dma0",		.clk = &dma0_clk},
+	{.dev_id = "dma1",		.clk = &dma1_clk},
+	{.dev_id = "jpeg",		.clk = &jpeg_clk},
+	{.dev_id = "stmmaceth.0",	.clk = &gmac0_clk},
+	{.dev_id = "c3",		.clk = &c3_clk},
+	{.dev_id = "pcie0",		.clk = &pcie0_clk},
+	{.dev_id = "pcie1",		.clk = &pcie1_clk},
+	{.dev_id = "pcie2",		.clk = &pcie2_clk},
+	{.dev_id = "cfxd",		.clk = &cfxd_clk},
+	{.dev_id = "sdhci",		.clk = &sdhci_clk},
+	{.con_id = "fsmc",		.clk = &fsmc_clk},
+	{.dev_id = "sysram0",		.clk = &sysram0_clk},
+	{.dev_id = "sysram1",		.clk = &sysram1_clk},
+
+	/* clock derived from apb clk */
+	{.dev_id = "i2s0",		.clk = &i2s0_clk},
+	{.dev_id = "i2s1",		.clk = &i2s1_clk},
+	{.dev_id = "adc",		.clk = &adc_clk},
+	{.dev_id = "ssp-pl022",		.clk = &ssp_clk},
+	{.dev_id = "gpio0",		.clk = &gpio0_clk},
+	{.dev_id = "gpio1",		.clk = &gpio1_clk},
+	{.dev_id = "keyboard",		.clk = &kbd_clk},
+	{.dev_id = "wdt",		.clk = &wdt_clk},
+};
+
+/* array of all spear 1300 clock lookups */
+#ifdef CONFIG_MACH_SPEAR1300
+static struct clk_lookup spear1300_clk_lookups[] = {
+};
+#endif
+
+void __init spear13xx_clk_init(void)
+{
+	int i, cnt;
+	struct clk_lookup *lookups;
+
+	if (machine_is_spear1300()) {
+		cnt = ARRAY_SIZE(spear1300_clk_lookups);
+		lookups = spear1300_clk_lookups;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(spear_clk_lookups); i++)
+		clk_register(&spear_clk_lookups[i]);
+
+	for (i = 0; i < cnt; i++)
+		clk_register(&lookups[i]);
+
+	clk_init();
+}
diff --git a/arch/arm/mach-spear13xx/headsmp.S b/arch/arm/mach-spear13xx/headsmp.S
new file mode 100644
index 0000000..502c4fe
--- /dev/null
+++ b/arch/arm/mach-spear13xx/headsmp.S
@@ -0,0 +1,42 @@
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
+ * spear13xx specific entry point for secondary CPUs. This provides
+ * a "holding pen" into which all secondary cores are held until we're
+ * ready for them to initialise.
+ */
+ENTRY(spear13xx_secondary_startup)
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
+	.align
+1:	.long	.
+	.long	pen_release
diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index 95011a2..781894e 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -33,7 +33,7 @@ extern struct amba_device spear13xx_uart_device;
 extern struct sys_timer spear13xx_timer;
 
 /* Add spear13xx family function declarations here */
-void __init clk_init(void);
+void __init spear13xx_clk_init(void);
 void __init spear_setup_timer(void);
 void __init spear13xx_map_io(void);
 void __init spear13xx_init_irq(void);
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
index 0000000..6aa4435
--- /dev/null
+++ b/arch/arm/mach-spear13xx/platsmp.c
@@ -0,0 +1,162 @@
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
+/*
+ * Write pen_release in a way that is guaranteed to be visible to all
+ * observers, irrespective of whether they're taking part in coherency
+ * or not. This is necessary for the hotplug code to work reliably.
+ */
+static void write_pen_release(int val)
+{
+	pen_release = val;
+	smp_wmb();
+	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
+	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
+}
+
+static void __iomem *scu_base_addr(void)
+{
+	return __io_address(SPEAR13XX_SCU_BASE);
+}
+
+void __cpuinit platform_secondary_init(unsigned int cpu)
+{
+	/*
+	 * if any interrupts are already enabled for the primary
+	 * core (e.g. timer irq), then they will not have been enabled
+	 * for us: do so
+	 */
+	gic_secondary_init(0);
+
+	/*
+	 * let the primary processor know we're out of the
+	 * pen, then head off into the C entry point
+	 */
+	write_pen_release(-1);
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
+	write_pen_release(cpu);
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
+/*
+ * Initialise the CPU possible map early - this describes the CPUs
+ * which may be present or become present in the system.
+ */
+void __init smp_init_cpus(void)
+{
+	void __iomem *scu_base = scu_base_addr();
+	unsigned int i, ncores;
+
+	ncores = scu_base ? scu_get_core_count(scu_base) : 1;
+
+	for (i = 0; i < ncores; i++)
+		set_cpu_possible(i, true);
+}
+
+static void __init wakeup_secondary(void)
+{
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
+void __init platform_smp_prepare_cpus(unsigned int max_cpus)
+{
+	int i;
+
+	/*
+	 * Initialise the present map, which describes the set of CPUs
+	 * actually populated at the present time.
+	 */
+	for (i = 0; i < max_cpus; i++)
+		set_cpu_present(i, true);
+
+	scu_enable(scu_base_addr());
+	wakeup_secondary();
+}
diff --git a/arch/arm/mach-spear13xx/spear1300.c b/arch/arm/mach-spear13xx/spear1300.c
new file mode 100644
index 0000000..9c38bec
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
+#include <mach/hardware.h>
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
index 0000000..c95c141
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
+#include <mach/hardware.h>
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
index 0000000..06f9abb
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
+#include <mach/generic.h>
+#include <mach/hardware.h>
+#include <mach/irqs.h>
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
+	gic_init(0, 29, __io_address(SPEAR13XX_GIC_DIST_BASE),
+			__io_address(SPEAR13XX_GIC_CPU_BASE));
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
+	spear13xx_clk_init();
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
+	if (IS_ERR(gpt_clk)) {
+		pr_err("%s:couldn't get clk for gpt\n", __func__);
+		BUG();
+	}
+
+	/* get the suitable parent clock for timer*/
+	pclk = clk_get(NULL, pclk_name);
+	if (IS_ERR(pclk)) {
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
