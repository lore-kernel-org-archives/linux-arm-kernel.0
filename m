From: sw.youn@samsung.com (Seungwhan Youn)
Date: Wed, 13 Oct 2010 18:48:11 +0900
Subject: [PATCH v3 1/6] ARM: S5P: Reduce duplicated EPLL control codes
Message-ID: <1286963291-9194-1-git-send-email-sw.youn@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S5P Samsung SoCs has a EPLL to support various PLL clock sources for other
H/W blocks. Until now, to control EPLL, each of SoCs make their own functions
in 'mach-s5pxxx/clock.c'. But some of functions, 'xxx_epll_get_rate()' and
'xxx_epll_enable()', are exactly same in all S5P SoCs, so this patch move
these duplicated codes to common EPLL functions that use platform wide.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
---
This patch is re-worked followings, requested by Kukjin Kim, from v2 :-
 o Set re-define S5P_EPLL_CON with specific EPLL definations on S5P platform.
 o and, keep original EPLL definations.

And also, this patch depends on v1 patch-set which was submitted.
 o [PATCH 1/10] ARM: S5PC100: Add S/PDIF platform device
 o [PATCH 2/10] ARM: S5PC100: Modify SCLK_AUDIO{0,1,2} clock as sysclks
 o [PATCH 3/10] ARM: S5PC100: Add SCLK_SPDIF clock
 o [PATCH 4/10] ARM: S5PV210: Add S/PDIF platform device
 o [PATCH 5/10] ARM: S5PV210: Add SCLK_SPDIF clock
 o [PATCH 6/10] ARM: S5PV210: Add audio clocks as sysclk
--
 arch/arm/mach-s5p64x0/clock-s5p6440.c           |    4 ++--
 arch/arm/mach-s5p64x0/clock-s5p6450.c           |    4 ++--
 arch/arm/mach-s5p64x0/clock.c                   |   18 ------------------
 arch/arm/mach-s5p64x0/include/mach/regs-clock.h |    2 ++
 arch/arm/mach-s5pc100/clock.c                   |   22 ++--------------------
 arch/arm/mach-s5pv310/include/mach/regs-clock.h |    4 ++++
 arch/arm/plat-s5p/clock.c                       |   20 ++++++++++++++++++++
 arch/arm/plat-s5p/include/plat/s5p-clock.h      |    4 ++++
 8 files changed, 36 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/clock-s5p6440.c b/arch/arm/mach-s5p64x0/clock-s5p6440.c
index f93dcd8..cfccdff 100644
--- a/arch/arm/mach-s5p64x0/clock-s5p6440.c
+++ b/arch/arm/mach-s5p64x0/clock-s5p6440.c
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
diff --git a/arch/arm/mach-s5p64x0/clock-s5p6450.c b/arch/arm/mach-s5p64x0/clock-s5p6450.c
index f9afb05..f1498d3 100644
--- a/arch/arm/mach-s5p64x0/clock-s5p6450.c
+++ b/arch/arm/mach-s5p64x0/clock-s5p6450.c
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
index 58e1bc8..a133f22 100644
--- a/arch/arm/mach-s5p64x0/include/mach/regs-clock.h
+++ b/arch/arm/mach-s5p64x0/include/mach/regs-clock.h
@@ -60,4 +60,6 @@
 #define ARM_DIV_RATIO_SHIFT		0
 #define ARM_DIV_MASK			(0xF << ARM_DIV_RATIO_SHIFT)
 
+#define S5P_EPLL_CON			S5P64X0_EPLL_CON
+
 #endif /* __ASM_ARCH_REGS_CLOCK_H */
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
diff --git a/arch/arm/mach-s5pv310/include/mach/regs-clock.h b/arch/arm/mach-s5pv310/include/mach/regs-clock.h
index 5d0bb40..9e9e44c 100644
--- a/arch/arm/mach-s5pv310/include/mach/regs-clock.h
+++ b/arch/arm/mach-s5pv310/include/mach/regs-clock.h
@@ -157,4 +157,8 @@
 #define S5P_CLKDIV_BUS_GPLR_SHIFT	(4)
 #define S5P_CLKDIV_BUS_GPLR_MASK	(0x7 << S5P_CLKDIV_BUS_GPLR_SHIFT)
 
+/* Compatibility defines */
+
+#define S5P_EPLL_CON			S5P_EPLL_CON0
+
 #endif /* __ASM_ARCH_REGS_CLOCK_H */
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
