From: sw.youn@samsung.com (Seungwhan Youn)
Date: Tue, 12 Oct 2010 20:34:41 +0900
Subject: [PATCH v2 1/6] ARM: S5P: Reduce duplicated EPLL control codes
In-Reply-To: <1286882399-27595-1-git-send-email-sw.youn@samsung.com>
References: <1286882399-27595-1-git-send-email-sw.youn@samsung.com>
Message-ID: <1286883281-27656-1-git-send-email-sw.youn@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S5P Samsung SoCs has a EPLL to support various PLL clock sources for other
H/W blocks. Until now, to control EPLL, each of SoCs make their own functions
in 'mach-s5pxxx/clock.c'. But some of functions, 'xxx_epll_get_rate()' and
'xxx_epll_enable()', are exactly same in all S5P SoCs, so this patch move
these duplicated codes to common EPLL functions that use platform wide.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
---
 arch/arm/mach-s5p64x0/clock-s5p6440.c           |   16 ++++++++--------
 arch/arm/mach-s5p64x0/clock-s5p6450.c           |   16 ++++++++--------
 arch/arm/mach-s5p64x0/clock.c                   |   18 ------------------
 arch/arm/mach-s5p64x0/include/mach/regs-clock.h |    4 ++--
 arch/arm/mach-s5pc100/clock.c                   |   22 ++--------------------
 arch/arm/plat-s5p/clock.c                       |   20 ++++++++++++++++++++
 arch/arm/plat-s5p/include/plat/s5p-clock.h      |    4 ++++
 7 files changed, 44 insertions(+), 56 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/clock-s5p6440.c b/arch/arm/mach-s5p64x0/clock-s5p6440.c
index f93dcd8..1e3f517 100644
--- a/arch/arm/mach-s5p64x0/clock-s5p6440.c
+++ b/arch/arm/mach-s5p64x0/clock-s5p6440.c
@@ -55,8 +55,8 @@ static int s5p6440_epll_set_rate(struct clk *clk, unsigned long rate)
 	if (clk->rate == rate)	/* Return if nothing changed */
 		return 0;
 
-	epll_con = __raw_readl(S5P64X0_EPLL_CON);
-	epll_con_k = __raw_readl(S5P64X0_EPLL_CON_K);
+	epll_con = __raw_readl(S5P_EPLL_CON);
+	epll_con_k = __raw_readl(S5P_EPLL_CON_K);
 
 	epll_con_k &= ~(PLL90XX_KDIV_MASK);
 	epll_con &= ~(PLL90XX_MDIV_MASK | PLL90XX_PDIV_MASK | PLL90XX_SDIV_MASK);
@@ -76,8 +76,8 @@ static int s5p6440_epll_set_rate(struct clk *clk, unsigned long rate)
 		return -EINVAL;
 	}
 
-	__raw_writel(epll_con, S5P64X0_EPLL_CON);
-	__raw_writel(epll_con_k, S5P64X0_EPLL_CON_K);
+	__raw_writel(epll_con, S5P_EPLL_CON);
+	__raw_writel(epll_con_k, S5P_EPLL_CON_K);
 
 	clk->rate = rate;
 
@@ -85,7 +85,7 @@ static int s5p6440_epll_set_rate(struct clk *clk, unsigned long rate)
 }
 
 static struct clk_ops s5p6440_epll_ops = {
-	.get_rate = s5p64x0_epll_get_rate,
+	.get_rate = s5p_epll_get_rate,
 	.set_rate = s5p6440_epll_set_rate,
 };
 
@@ -548,7 +548,7 @@ void __init_or_cpufreq s5p6440_setup_clocks(void)
 
 	/* Set S5P6440 functions for clk_fout_epll */
 
-	clk_fout_epll.enable = s5p64x0_epll_enable;
+	clk_fout_epll.enable = s5p_epll_enable;
 	clk_fout_epll.ops = &s5p6440_epll_ops;
 
 	clk_48m.enable = s5p64x0_clk48m_ctrl;
@@ -561,8 +561,8 @@ void __init_or_cpufreq s5p6440_setup_clocks(void)
 
 	apll = s5p_get_pll45xx(xtal, __raw_readl(S5P64X0_APLL_CON), pll_4502);
 	mpll = s5p_get_pll45xx(xtal, __raw_readl(S5P64X0_MPLL_CON), pll_4502);
-	epll = s5p_get_pll90xx(xtal, __raw_readl(S5P64X0_EPLL_CON),
-				__raw_readl(S5P64X0_EPLL_CON_K));
+	epll = s5p_get_pll90xx(xtal, __raw_readl(S5P_EPLL_CON),
+				__raw_readl(S5P_EPLL_CON_K));
 
 	clk_fout_apll.rate = apll;
 	clk_fout_mpll.rate = mpll;
diff --git a/arch/arm/mach-s5p64x0/clock-s5p6450.c b/arch/arm/mach-s5p64x0/clock-s5p6450.c
index f9afb05..ee03ec3 100644
--- a/arch/arm/mach-s5p64x0/clock-s5p6450.c
+++ b/arch/arm/mach-s5p64x0/clock-s5p6450.c
@@ -56,8 +56,8 @@ static int s5p6450_epll_set_rate(struct clk *clk, unsigned long rate)
 	if (clk->rate == rate)	/* Return if nothing changed */
 		return 0;
 
-	epll_con = __raw_readl(S5P64X0_EPLL_CON);
-	epll_con_k = __raw_readl(S5P64X0_EPLL_CON_K);
+	epll_con = __raw_readl(S5P_EPLL_CON);
+	epll_con_k = __raw_readl(S5P_EPLL_CON_K);
 
 	epll_con_k &= ~(PLL90XX_KDIV_MASK);
 	epll_con &= ~(PLL90XX_MDIV_MASK | PLL90XX_PDIV_MASK | PLL90XX_SDIV_MASK);
@@ -77,8 +77,8 @@ static int s5p6450_epll_set_rate(struct clk *clk, unsigned long rate)
 		return -EINVAL;
 	}
 
-	__raw_writel(epll_con, S5P64X0_EPLL_CON);
-	__raw_writel(epll_con_k, S5P64X0_EPLL_CON_K);
+	__raw_writel(epll_con, S5P_EPLL_CON);
+	__raw_writel(epll_con_k, S5P_EPLL_CON_K);
 
 	clk->rate = rate;
 
@@ -86,7 +86,7 @@ static int s5p6450_epll_set_rate(struct clk *clk, unsigned long rate)
 }
 
 static struct clk_ops s5p6450_epll_ops = {
-	.get_rate = s5p64x0_epll_get_rate,
+	.get_rate = s5p_epll_get_rate,
 	.set_rate = s5p6450_epll_set_rate,
 };
 
@@ -581,7 +581,7 @@ void __init_or_cpufreq s5p6450_setup_clocks(void)
 
 	/* Set S5P6450 functions for clk_fout_epll */
 
-	clk_fout_epll.enable = s5p64x0_epll_enable;
+	clk_fout_epll.enable = s5p_epll_enable;
 	clk_fout_epll.ops = &s5p6450_epll_ops;
 
 	clk_48m.enable = s5p64x0_clk48m_ctrl;
@@ -594,8 +594,8 @@ void __init_or_cpufreq s5p6450_setup_clocks(void)
 
 	apll = s5p_get_pll45xx(xtal, __raw_readl(S5P64X0_APLL_CON), pll_4502);
 	mpll = s5p_get_pll45xx(xtal, __raw_readl(S5P64X0_MPLL_CON), pll_4502);
-	epll = s5p_get_pll90xx(xtal, __raw_readl(S5P64X0_EPLL_CON),
-				__raw_readl(S5P64X0_EPLL_CON_K));
+	epll = s5p_get_pll90xx(xtal, __raw_readl(S5P_EPLL_CON),
+				__raw_readl(S5P_EPLL_CON_K));
 	dpll = s5p_get_pll46xx(xtal, __raw_readl(S5P6450_DPLL_CON),
 				__raw_readl(S5P6450_DPLL_CON_K), pll_4650c);
 
diff --git a/arch/arm/mach-s5p64x0/clock.c b/arch/arm/mach-s5p64x0/clock.c
index 523ba80..b52c6e2 100644
--- a/arch/arm/mach-s5p64x0/clock.c
+++ b/arch/arm/mach-s5p64x0/clock.c
@@ -73,24 +73,6 @@ static const u32 clock_table[][3] = {
 	{L2 * 1000, (3 << ARM_DIV_RATIO_SHIFT), (0 << S5P64X0_CLKDIV0_HCLK_SHIFT)},
 };
 
-int s5p64x0_epll_enable(struct clk *clk, int enable)
-{
-	unsigned int ctrlbit = clk->ctrlbit;
-	unsigned int epll_con = __raw_readl(S5P64X0_EPLL_CON) & ~ctrlbit;
-
-	if (enable)
-		__raw_writel(epll_con | ctrlbit, S5P64X0_EPLL_CON);
-	else
-		__raw_writel(epll_con, S5P64X0_EPLL_CON);
-
-	return 0;
-}
-
-unsigned long s5p64x0_epll_get_rate(struct clk *clk)
-{
-	return clk->rate;
-}
-
 unsigned long s5p64x0_armclk_get_rate(struct clk *clk)
 {
 	unsigned long rate = clk_get_rate(clk->parent);
diff --git a/arch/arm/mach-s5p64x0/include/mach/regs-clock.h b/arch/arm/mach-s5p64x0/include/mach/regs-clock.h
index 58e1bc8..ac30123 100644
--- a/arch/arm/mach-s5p64x0/include/mach/regs-clock.h
+++ b/arch/arm/mach-s5p64x0/include/mach/regs-clock.h
@@ -19,8 +19,8 @@
 
 #define S5P64X0_APLL_CON		S5P_CLKREG(0x0C)
 #define S5P64X0_MPLL_CON		S5P_CLKREG(0x10)
-#define S5P64X0_EPLL_CON		S5P_CLKREG(0x14)
-#define S5P64X0_EPLL_CON_K		S5P_CLKREG(0x18)
+#define S5P_EPLL_CON			S5P_CLKREG(0x14)
+#define S5P_EPLL_CON_K			S5P_CLKREG(0x18)
 
 #define S5P64X0_CLK_SRC0		S5P_CLKREG(0x1C)
 
diff --git a/arch/arm/mach-s5pc100/clock.c b/arch/arm/mach-s5pc100/clock.c
index 306ae74..42c2636 100644
--- a/arch/arm/mach-s5pc100/clock.c
+++ b/arch/arm/mach-s5pc100/clock.c
@@ -273,24 +273,6 @@ static struct clksrc_clk clk_div_hdmi = {
 	.reg_div = { .reg = S5P_CLK_DIV3, .shift = 28, .size = 4 },
 };
 
-static int s5pc100_epll_enable(struct clk *clk, int enable)
-{
-	unsigned int ctrlbit = clk->ctrlbit;
-	unsigned int epll_con = __raw_readl(S5P_EPLL_CON) & ~ctrlbit;
-
-	if (enable)
-		__raw_writel(epll_con | ctrlbit, S5P_EPLL_CON);
-	else
-		__raw_writel(epll_con, S5P_EPLL_CON);
-
-	return 0;
-}
-
-static unsigned long s5pc100_epll_get_rate(struct clk *clk)
-{
-	return clk->rate;
-}
-
 static u32 epll_div[][4] = {
 	{ 32750000,	131, 3, 4 },
 	{ 32768000,	131, 3, 4 },
@@ -347,7 +329,7 @@ static int s5pc100_epll_set_rate(struct clk *clk, unsigned long rate)
 }
 
 static struct clk_ops s5pc100_epll_ops = {
-	.get_rate = s5pc100_epll_get_rate,
+	.get_rate = s5p_epll_get_rate,
 	.set_rate = s5pc100_epll_set_rate,
 };
 
@@ -1261,7 +1243,7 @@ void __init_or_cpufreq s5pc100_setup_clocks(void)
 	unsigned int ptr;
 
 	/* Set S5PC100 functions for clk_fout_epll */
-	clk_fout_epll.enable = s5pc100_epll_enable;
+	clk_fout_epll.enable = s5p_epll_enable;
 	clk_fout_epll.ops = &s5pc100_epll_ops;
 
 	printk(KERN_DEBUG "%s: registering clocks\n", __func__);
diff --git a/arch/arm/plat-s5p/clock.c b/arch/arm/plat-s5p/clock.c
index 8188009..8d081d9 100644
--- a/arch/arm/plat-s5p/clock.c
+++ b/arch/arm/plat-s5p/clock.c
@@ -21,6 +21,8 @@
 #include <linux/io.h>
 #include <asm/div64.h>
 
+#include <mach/regs-clock.h>
+
 #include <plat/clock.h>
 #include <plat/clock-clksrc.h>
 #include <plat/s5p-clock.h>
@@ -148,6 +150,24 @@ int s5p_gatectrl(void __iomem *reg, struct clk *clk, int enable)
 	return 0;
 }
 
+int s5p_epll_enable(struct clk *clk, int enable)
+{
+	unsigned int ctrlbit = clk->ctrlbit;
+	unsigned int epll_con = __raw_readl(S5P_EPLL_CON) & ~ctrlbit;
+
+	if (enable)
+		__raw_writel(epll_con | ctrlbit, S5P_EPLL_CON);
+	else
+		__raw_writel(epll_con, S5P_EPLL_CON);
+
+	return 0;
+}
+
+unsigned long s5p_epll_get_rate(struct clk *clk)
+{
+	return clk->rate;
+}
+
 static struct clk *s5p_clks[] __initdata = {
 	&clk_ext_xtal_mux,
 	&clk_48m,
diff --git a/arch/arm/plat-s5p/include/plat/s5p-clock.h b/arch/arm/plat-s5p/include/plat/s5p-clock.h
index 17036c8..2b6dcff 100644
--- a/arch/arm/plat-s5p/include/plat/s5p-clock.h
+++ b/arch/arm/plat-s5p/include/plat/s5p-clock.h
@@ -43,4 +43,8 @@ extern struct clksrc_sources clk_src_dpll;
 
 extern int s5p_gatectrl(void __iomem *reg, struct clk *clk, int enable);
 
+/* Common EPLL operations for S5P platform */
+extern int s5p_epll_enable(struct clk *clk, int enable);
+extern unsigned long s5p_epll_get_rate(struct clk *clk);
+
 #endif /* __ASM_PLAT_S5P_CLOCK_H */
-- 
1.6.2.5
