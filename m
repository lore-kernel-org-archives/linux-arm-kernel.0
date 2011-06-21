From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Tue, 21 Jun 2011 16:54:23 +0530
Subject: [PATCH v2 3/3] ARM: EXYNOS4: Add EPLL clock operations
In-Reply-To: <1308655463-8787-1-git-send-email-ch.naveen@samsung.com>
References: <1308655463-8787-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1308655463-8787-4-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S5PV210 and EXYNOS4 uses similar PLL(PLL46XX) for EPLL.
So, The EPLL set rate function is duplicated.

Note: Moved common code to plat-s5p, as commented by Kukjin Kim.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
---
 arch/arm/mach-exynos4/clock.c        |    1 +
 arch/arm/mach-s5pv210/clock.c        |   78 +---------------------------------
 arch/arm/plat-s5p/clock.c            |   77 +++++++++++++++++++++++++++++++++
 arch/arm/plat-s5p/include/plat/pll.h |    3 +
 4 files changed, 82 insertions(+), 77 deletions(-)

diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos4/clock.c
index feeb27e..7687087 100644
--- a/arch/arm/mach-exynos4/clock.c
+++ b/arch/arm/mach-exynos4/clock.c
@@ -1294,6 +1294,7 @@ void __init_or_cpufreq exynos4_setup_clocks(void)
 				__raw_readl(S5P_VPLL_CON1), pll_4650);
 
 	clk_fout_apll.ops = &exynos4_fout_apll_ops;
+	clk_fout_epll.ops = &pll46xx_epll_ops;
 	clk_fout_mpll.rate = mpll;
 	clk_fout_epll.rate = epll;
 	clk_fout_vpll.rate = vpll;
diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index ae72f87..dd77c2c 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -979,82 +979,6 @@ static struct clksrc_clk *sysclks[] = {
 	&clk_sclk_spdif,
 };
 
-static u32 epll_div[][6] = {
-	{  48000000, 0, 48, 3, 3, 0 },
-	{  96000000, 0, 48, 3, 2, 0 },
-	{ 144000000, 1, 72, 3, 2, 0 },
-	{ 192000000, 0, 48, 3, 1, 0 },
-	{ 288000000, 1, 72, 3, 1, 0 },
-	{  32750000, 1, 65, 3, 4, 35127 },
-	{  32768000, 1, 65, 3, 4, 35127 },
-	{  45158400, 0, 45, 3, 3, 10355 },
-	{  45000000, 0, 45, 3, 3, 10355 },
-	{  45158000, 0, 45, 3, 3, 10355 },
-	{  49125000, 0, 49, 3, 3, 9961 },
-	{  49152000, 0, 49, 3, 3, 9961 },
-	{  67737600, 1, 67, 3, 3, 48366 },
-	{  67738000, 1, 67, 3, 3, 48366 },
-	{  73800000, 1, 73, 3, 3, 47710 },
-	{  73728000, 1, 73, 3, 3, 47710 },
-	{  36000000, 1, 32, 3, 4, 0 },
-	{  60000000, 1, 60, 3, 3, 0 },
-	{  72000000, 1, 72, 3, 3, 0 },
-	{  80000000, 1, 80, 3, 3, 0 },
-	{  84000000, 0, 42, 3, 2, 0 },
-	{  50000000, 0, 50, 3, 3, 0 },
-};
-
-static int s5pv210_epll_set_rate(struct clk *clk, unsigned long rate)
-{
-	unsigned int epll_con, epll_con_k;
-	unsigned int i;
-
-	/* Return if nothing changed */
-	if (clk->rate == rate)
-		return 0;
-
-	epll_con = __raw_readl(S5P_EPLL_CON);
-	epll_con_k = __raw_readl(S5P_EPLL_CON1);
-
-	epll_con_k &= ~PLL46XX_KDIV_MASK;
-	epll_con &= ~(1 << 27 |
-			PLL46XX_MDIV_MASK << PLL46XX_MDIV_SHIFT |
-			PLL46XX_PDIV_MASK << PLL46XX_PDIV_SHIFT |
-			PLL46XX_SDIV_MASK << PLL46XX_SDIV_SHIFT);
-
-	for (i = 0; i < ARRAY_SIZE(epll_div); i++) {
-		if (epll_div[i][0] == rate) {
-			epll_con_k |= epll_div[i][5] << 0;
-			epll_con |= (epll_div[i][1] << 27 |
-					epll_div[i][2] << PLL46XX_MDIV_SHIFT |
-					epll_div[i][3] << PLL46XX_PDIV_SHIFT |
-					epll_div[i][4] << PLL46XX_SDIV_SHIFT);
-			break;
-		}
-	}
-
-	if (i == ARRAY_SIZE(epll_div)) {
-		printk(KERN_ERR "%s: Invalid Clock EPLL Frequency\n",
-				__func__);
-		return -EINVAL;
-	}
-
-	__raw_writel(epll_con, S5P_EPLL_CON);
-	__raw_writel(epll_con_k, S5P_EPLL_CON1);
-
-	printk(KERN_WARNING "EPLL Rate changes from %lu to %lu\n",
-			clk->rate, rate);
-
-	clk->rate = rate;
-
-	return 0;
-}
-
-static struct clk_ops s5pv210_epll_ops = {
-	.set_rate = s5pv210_epll_set_rate,
-	.get_rate = s5p_epll_get_rate,
-};
-
 void __init_or_cpufreq s5pv210_setup_clocks(void)
 {
 	struct clk *xtal_clk;
@@ -1075,7 +999,7 @@ void __init_or_cpufreq s5pv210_setup_clocks(void)
 
 	/* Set functions for clk_fout_epll */
 	clk_fout_epll.enable = s5p_epll_enable;
-	clk_fout_epll.ops = &s5pv210_epll_ops;
+	clk_fout_epll.ops = &pll46xx_epll_ops;
 
 	printk(KERN_DEBUG "%s: registering clocks\n", __func__);
 
diff --git a/arch/arm/plat-s5p/clock.c b/arch/arm/plat-s5p/clock.c
index 02af235..2a4678d 100644
--- a/arch/arm/plat-s5p/clock.c
+++ b/arch/arm/plat-s5p/clock.c
@@ -24,6 +24,7 @@
 #include <mach/regs-clock.h>
 
 #include <plat/clock.h>
+#include <plat/pll.h>
 #include <plat/clock-clksrc.h>
 #include <plat/s5p-clock.h>
 
@@ -203,6 +204,82 @@ struct clk_ops s5p_sclk_spdif_ops = {
 	.get_rate	= s5p_spdif_get_rate,
 };
 
+static u32 epll_div[][6] = {
+	{  48000000, 0, 48, 3, 3, 0 },
+	{  96000000, 0, 48, 3, 2, 0 },
+	{ 144000000, 1, 72, 3, 2, 0 },
+	{ 192000000, 0, 48, 3, 1, 0 },
+	{ 288000000, 1, 72, 3, 1, 0 },
+	{  32750000, 1, 65, 3, 4, 35127 },
+	{  32768000, 1, 65, 3, 4, 35127 },
+	{  45158400, 0, 45, 3, 3, 10355 },
+	{  45000000, 0, 45, 3, 3, 10355 },
+	{  45158000, 0, 45, 3, 3, 10355 },
+	{  49125000, 0, 49, 3, 3, 9961 },
+	{  49152000, 0, 49, 3, 3, 9961 },
+	{  67737600, 1, 67, 3, 3, 48366 },
+	{  67738000, 1, 67, 3, 3, 48366 },
+	{  73800000, 1, 73, 3, 3, 47710 },
+	{  73728000, 1, 73, 3, 3, 47710 },
+	{  36000000, 1, 32, 3, 4, 0 },
+	{  60000000, 1, 60, 3, 3, 0 },
+	{  72000000, 1, 72, 3, 3, 0 },
+	{  80000000, 1, 80, 3, 3, 0 },
+	{  84000000, 0, 42, 3, 2, 0 },
+	{  50000000, 0, 50, 3, 3, 0 },
+};
+
+int pll46xx_epll_set_rate(struct clk *clk, unsigned long rate)
+{
+	unsigned int epll_con, epll_con_k;
+	unsigned int i;
+
+	/* Return if nothing changed */
+	if (clk->rate == rate)
+		return 0;
+
+	epll_con = __raw_readl(S5P_EPLL_CON);
+	epll_con_k = __raw_readl(S5P_EPLL_CON1);
+
+	epll_con_k &= ~PLL46XX_KDIV_MASK;
+	epll_con &= ~(1 << 27 |
+			PLL46XX_MDIV_MASK << PLL46XX_MDIV_SHIFT |
+			PLL46XX_PDIV_MASK << PLL46XX_PDIV_SHIFT |
+			PLL46XX_SDIV_MASK << PLL46XX_SDIV_SHIFT);
+
+	for (i = 0; i < ARRAY_SIZE(epll_div); i++) {
+		if (epll_div[i][0] == rate) {
+			epll_con_k |= epll_div[i][5] << 0;
+			epll_con |= (epll_div[i][1] << 27 |
+					epll_div[i][2] << PLL46XX_MDIV_SHIFT |
+					epll_div[i][3] << PLL46XX_PDIV_SHIFT |
+					epll_div[i][4] << PLL46XX_SDIV_SHIFT);
+			break;
+		}
+	}
+
+	if (i == ARRAY_SIZE(epll_div)) {
+		printk(KERN_ERR "%s: Invalid Clock EPLL Frequency\n",
+				__func__);
+		return -EINVAL;
+	}
+
+	__raw_writel(epll_con, S5P_EPLL_CON);
+	__raw_writel(epll_con_k, S5P_EPLL_CON1);
+
+	printk(KERN_WARNING "EPLL Rate changes from %lu to %lu\n",
+			clk->rate, rate);
+
+	clk->rate = rate;
+
+	return 0;
+}
+
+struct clk_ops pll46xx_epll_ops = {
+	.set_rate = pll46xx_epll_set_rate,
+	.get_rate = s5p_epll_get_rate,
+};
+
 static struct clk *s5p_clks[] __initdata = {
 	&clk_ext_xtal_mux,
 	&clk_48m,
diff --git a/arch/arm/plat-s5p/include/plat/pll.h b/arch/arm/plat-s5p/include/plat/pll.h
index bf28fad..911a20e 100644
--- a/arch/arm/plat-s5p/include/plat/pll.h
+++ b/arch/arm/plat-s5p/include/plat/pll.h
@@ -94,6 +94,9 @@ static inline unsigned long s5p_get_pll46xx(unsigned long baseclk,
 	return result;
 }
 
+extern int pll46xx_epll_set_rate(struct clk *clk, unsigned long rate);
+extern struct clk_ops pll46xx_epll_ops;
+
 #define PLL90XX_MDIV_MASK	(0xFF)
 #define PLL90XX_PDIV_MASK	(0x3F)
 #define PLL90XX_SDIV_MASK	(0x7)
-- 
1.7.2.3
