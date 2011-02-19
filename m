From: ccross@android.com (Colin Cross)
Date: Sat, 19 Feb 2011 14:26:09 -0800
Subject: [PATCH v2 20/21] ARM: tegra: clock: Fix clock issues in suspend
In-Reply-To: <1298154371-5641-1-git-send-email-ccross@android.com>
References: <1298154371-5641-1-git-send-email-ccross@android.com>
Message-ID: <1298154371-5641-22-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PLLP registers are now being restored by the low-level resume code,
and the CPU may be running off PLLP, so don't touch them during clock
resume.

Save plld, plls, pllu, and audio clock during suspend (originally
fixed by Mayuresh Kulkarni <mkulkarni@nvidia.com>)

The lock time for plld is 1000 us, so increase the delay after
setting the PLLs.

Add a BUG_ON to ensure the size of the suspend context area is
correct.

Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/mach-tegra/tegra2_clocks.c |   30 ++++++++++++++++++++----------
 1 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra2_clocks.c b/arch/arm/mach-tegra/tegra2_clocks.c
index cc2616c..d5fbc42 100644
--- a/arch/arm/mach-tegra/tegra2_clocks.c
+++ b/arch/arm/mach-tegra/tegra2_clocks.c
@@ -2251,7 +2251,7 @@ void __init tegra2_init_clocks(void)
 
 #ifdef CONFIG_PM
 static u32 clk_rst_suspend[RST_DEVICES_NUM + CLK_OUT_ENB_NUM +
-			   PERIPH_CLK_SOURCE_NUM + 19];
+			   PERIPH_CLK_SOURCE_NUM + 22];
 
 void tegra_clk_suspend(void)
 {
@@ -2259,16 +2259,18 @@ void tegra_clk_suspend(void)
 	u32 *ctx = clk_rst_suspend;
 
 	*ctx++ = clk_readl(OSC_CTRL) & OSC_CTRL_MASK;
-	*ctx++ = clk_readl(tegra_pll_p.reg + PLL_BASE);
-	*ctx++ = clk_readl(tegra_pll_p.reg + PLL_MISC(&tegra_pll_p));
 	*ctx++ = clk_readl(tegra_pll_c.reg + PLL_BASE);
 	*ctx++ = clk_readl(tegra_pll_c.reg + PLL_MISC(&tegra_pll_c));
 	*ctx++ = clk_readl(tegra_pll_a.reg + PLL_BASE);
 	*ctx++ = clk_readl(tegra_pll_a.reg + PLL_MISC(&tegra_pll_a));
+	*ctx++ = clk_readl(tegra_pll_s.reg + PLL_BASE);
+	*ctx++ = clk_readl(tegra_pll_s.reg + PLL_MISC(&tegra_pll_s));
+	*ctx++ = clk_readl(tegra_pll_d.reg + PLL_BASE);
+	*ctx++ = clk_readl(tegra_pll_d.reg + PLL_MISC(&tegra_pll_d));
+	*ctx++ = clk_readl(tegra_pll_u.reg + PLL_BASE);
+	*ctx++ = clk_readl(tegra_pll_u.reg + PLL_MISC(&tegra_pll_u));
 
 	*ctx++ = clk_readl(tegra_pll_m_out1.reg);
-	*ctx++ = clk_readl(tegra_pll_p_out1.reg);
-	*ctx++ = clk_readl(tegra_pll_p_out3.reg);
 	*ctx++ = clk_readl(tegra_pll_a_out0.reg);
 	*ctx++ = clk_readl(tegra_pll_c_out1.reg);
 
@@ -2279,6 +2281,8 @@ void tegra_clk_suspend(void)
 	*ctx++ = clk_readl(tegra_clk_sclk.reg + SUPER_CLK_DIVIDER);
 	*ctx++ = clk_readl(tegra_clk_pclk.reg);
 
+	*ctx++ = clk_readl(tegra_clk_audio.reg);
+
 	for (off = PERIPH_CLK_SOURCE_I2S1; off <= PERIPH_CLK_SOURCE_OSC;
 			off += 4) {
 		if (off == PERIPH_CLK_SOURCE_EMC)
@@ -2296,6 +2300,8 @@ void tegra_clk_suspend(void)
 
 	*ctx++ = clk_readl(MISC_CLK_ENB);
 	*ctx++ = clk_readl(CLK_MASK_ARM);
+
+	BUG_ON(ctx - clk_rst_suspend != ARRAY_SIZE(clk_rst_suspend));
 }
 
 void tegra_clk_resume(void)
@@ -2308,17 +2314,19 @@ void tegra_clk_resume(void)
 	val |= *ctx++;
 	clk_writel(val, OSC_CTRL);
 
-	clk_writel(*ctx++, tegra_pll_p.reg + PLL_BASE);
-	clk_writel(*ctx++, tegra_pll_p.reg + PLL_MISC(&tegra_pll_p));
 	clk_writel(*ctx++, tegra_pll_c.reg + PLL_BASE);
 	clk_writel(*ctx++, tegra_pll_c.reg + PLL_MISC(&tegra_pll_c));
 	clk_writel(*ctx++, tegra_pll_a.reg + PLL_BASE);
 	clk_writel(*ctx++, tegra_pll_a.reg + PLL_MISC(&tegra_pll_a));
-	udelay(300);
+	clk_writel(*ctx++, tegra_pll_s.reg + PLL_BASE);
+	clk_writel(*ctx++, tegra_pll_s.reg + PLL_MISC(&tegra_pll_s));
+	clk_writel(*ctx++, tegra_pll_d.reg + PLL_BASE);
+	clk_writel(*ctx++, tegra_pll_d.reg + PLL_MISC(&tegra_pll_d));
+	clk_writel(*ctx++, tegra_pll_u.reg + PLL_BASE);
+	clk_writel(*ctx++, tegra_pll_u.reg + PLL_MISC(&tegra_pll_u));
+	udelay(1000);
 
 	clk_writel(*ctx++, tegra_pll_m_out1.reg);
-	clk_writel(*ctx++, tegra_pll_p_out1.reg);
-	clk_writel(*ctx++, tegra_pll_p_out3.reg);
 	clk_writel(*ctx++, tegra_pll_a_out0.reg);
 	clk_writel(*ctx++, tegra_pll_c_out1.reg);
 
@@ -2329,6 +2337,8 @@ void tegra_clk_resume(void)
 	clk_writel(*ctx++, tegra_clk_sclk.reg + SUPER_CLK_DIVIDER);
 	clk_writel(*ctx++, tegra_clk_pclk.reg);
 
+	clk_writel(*ctx++, tegra_clk_audio.reg);
+
 	/* enable all clocks before configuring clock sources */
 	clk_writel(0xbffffff9ul, CLK_OUT_ENB);
 	clk_writel(0xfefffff7ul, CLK_OUT_ENB + 4);
-- 
1.7.3.1
