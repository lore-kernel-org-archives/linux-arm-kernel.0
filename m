From: jason.chen@linaro.org (Jason Chen)
Date: Thu, 22 Dec 2011 20:21:21 +0800
Subject: [PATCH 1/7] arm/imx6q: add clock debugfs support
Message-ID: <1324556481-28106-1-git-send-email-jason.chen@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jason Chen <jason.chen@linaro.org>
---
 arch/arm/mach-imx/clock-imx6q.c |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/clock-imx6q.c b/arch/arm/mach-imx/clock-imx6q.c
index 3225ab2..83bc38d 100644
--- a/arch/arm/mach-imx/clock-imx6q.c
+++ b/arch/arm/mach-imx/clock-imx6q.c
@@ -335,6 +335,12 @@
 #define FREQ_650M	650000000
 #define FREQ_1300M	1300000000
 
+#ifdef CONFIG_CLK_DEBUG
+#define __INIT_CLK_DEBUG(n)	.name = #n,
+#else
+#define __INIT_CLK_DEBUG(n)
+#endif
+
 static struct clk pll1_sys;
 static struct clk pll2_bus;
 static struct clk pll3_usb_otg;
@@ -415,14 +421,17 @@ static unsigned long get_low_reference_clock_rate(struct clk *clk)
 }
 
 static struct clk ckil_clk = {
+	__INIT_CLK_DEBUG(ckil_clk)
 	.get_rate = get_low_reference_clock_rate,
 };
 
 static struct clk ckih_clk = {
+	__INIT_CLK_DEBUG(ckih_clk)
 	.get_rate = get_high_reference_clock_rate,
 };
 
 static struct clk osc_clk = {
+	__INIT_CLK_DEBUG(osc_clk)
 	.get_rate = get_oscillator_reference_clock_rate,
 };
 
@@ -677,6 +686,7 @@ static int pll_set_rate(struct clk *clk, unsigned long rate)
 
 #define DEF_PLL(name)					\
 	static struct clk name = {			\
+		__INIT_CLK_DEBUG(name)			\
 		.enable		= pll_enable,		\
 		.disable	= pll_disable,		\
 		.get_rate	= name##_get_rate,	\
@@ -796,6 +806,7 @@ static void pfd_disable(struct clk *clk)
 
 #define DEF_PFD(name, er, es, p)			\
 	static struct clk name = {			\
+		__INIT_CLK_DEBUG(name)			\
 		.enable_reg	= er,			\
 		.enable_shift	= es,			\
 		.enable		= pfd_enable,		\
@@ -820,6 +831,7 @@ static unsigned long pll2_200m_get_rate(struct clk *clk)
 }
 
 static struct clk pll2_200m = {
+	__INIT_CLK_DEBUG(pll2_200m)
 	.parent = &pll2_pfd_400m,
 	.get_rate = pll2_200m_get_rate,
 };
@@ -830,6 +842,7 @@ static unsigned long pll3_120m_get_rate(struct clk *clk)
 }
 
 static struct clk pll3_120m = {
+	__INIT_CLK_DEBUG(pll3_120m)
 	.parent = &pll3_usb_otg,
 	.get_rate = pll3_120m_get_rate,
 };
@@ -840,6 +853,7 @@ static unsigned long pll3_80m_get_rate(struct clk *clk)
 }
 
 static struct clk pll3_80m = {
+	__INIT_CLK_DEBUG(pll3_80m)
 	.parent = &pll3_usb_otg,
 	.get_rate = pll3_80m_get_rate,
 };
@@ -850,6 +864,7 @@ static unsigned long pll3_60m_get_rate(struct clk *clk)
 }
 
 static struct clk pll3_60m = {
+	__INIT_CLK_DEBUG(pll3_60m)
 	.parent = &pll3_usb_otg,
 	.get_rate = pll3_60m_get_rate,
 };
@@ -877,6 +892,7 @@ static int pll1_sw_clk_set_parent(struct clk *clk, struct clk *parent)
 }
 
 static struct clk pll1_sw_clk = {
+	__INIT_CLK_DEBUG(pll1_sw_clk)
 	.parent = &pll1_sys,
 	.set_parent = pll1_sw_clk_set_parent,
 };
@@ -1696,6 +1712,7 @@ static int _clk_set_parent(struct clk *clk, struct clk *parent)
 
 #define DEF_NG_CLK(name, p)				\
 	static struct clk name = {			\
+		__INIT_CLK_DEBUG(name)			\
 		.get_rate	= _clk_get_rate,	\
 		.set_rate	= _clk_set_rate,	\
 		.round_rate	= _clk_round_rate,	\
@@ -1723,6 +1740,7 @@ DEF_NG_CLK(asrc_serial_clk,	&pll3_usb_otg);
 
 #define DEF_CLK(name, er, es, p, s)			\
 	static struct clk name = {			\
+		__INIT_CLK_DEBUG(name)			\
 		.enable_reg	= er,			\
 		.enable_shift	= es,			\
 		.enable		= _clk_enable,		\
@@ -1826,6 +1844,7 @@ static void pcie_clk_disable(struct clk *clk)
 }
 
 static struct clk pcie_clk = {
+	__INIT_CLK_DEBUG(pcie_clk)
 	.enable_reg = CCGR4,
 	.enable_shift = CG0,
 	.enable = pcie_clk_enable,
@@ -1858,6 +1877,7 @@ static void sata_clk_disable(struct clk *clk)
 }
 
 static struct clk sata_clk = {
+	__INIT_CLK_DEBUG(sata_clk)
 	.enable_reg = CCGR5,
 	.enable_shift = CG2,
 	.enable = sata_clk_enable,
@@ -1989,8 +2009,10 @@ int __init mx6q_clocks_init(void)
 			oscillator_reference = rate;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(lookups); i++)
+	for (i = 0; i < ARRAY_SIZE(lookups); i++) {
 		clkdev_add(&lookups[i]);
+		clk_debug_register(lookups[i].clk);
+	}
 
 	/* only keep necessary clocks on */
 	writel_relaxed(0x3 << CG0  | 0x3 << CG1  | 0x3 << CG2,	CCGR0);
-- 
1.7.4.1
