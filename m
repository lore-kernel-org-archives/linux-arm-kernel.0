From: jc.lee@samsung.com (Jaecheol Lee)
Date: Wed, 15 Sep 2010 16:52:39 +0900
Subject: [PATCH 2/5] ARM: S5PV210: Add struct clk_ops for clk_fout_apll
In-Reply-To: <1284537162-3129-1-git-send-email-jc.lee@samsung.com>
References: <1284537162-3129-1-git-send-email-jc.lee@samsung.com>
Message-ID: <1284537162-3129-3-git-send-email-jc.lee@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current fout_apll has fixed rate value which was set in initializing
S5PV210 clock structures. CPUFREQ driver gets incorrect frequency when
finding current cpu frequency, because some operation level need to
change APLL. Newly added get_rate function for fout_apll can give
correct frequency when calling get_rate function by CPUFREQ driver.

Signed-off-by: Jaecheol Lee <jc.lee@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index d562670..e18e098 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -31,6 +31,8 @@
 #include <plat/clock-clksrc.h>
 #include <plat/s5pv210.h>
 
+static unsigned long xtal;
+
 static struct clksrc_clk clk_mout_apll = {
 	.clk	= {
 		.name		= "mout_apll",
@@ -268,6 +270,15 @@ static struct clk_ops clk_hclk_imem_ops = {
 	.get_rate	= s5pv210_clk_imem_get_rate,
 };
 
+static unsigned long s5pv210_clk_fout_apll_get_rate(struct clk *clk)
+{
+	return s5p_get_pll45xx(xtal, __raw_readl(S5P_APLL_CON), pll_4508);
+}
+
+static struct clk_ops clk_fout_apll_ops = {
+	.get_rate	= s5pv210_clk_fout_apll_get_rate,
+};
+
 static struct clk init_clocks_disable[] = {
 	{
 		.name		= "rot",
@@ -958,7 +969,6 @@ static struct clksrc_clk *sysclks[] = {
 void __init_or_cpufreq s5pv210_setup_clocks(void)
 {
 	struct clk *xtal_clk;
-	unsigned long xtal;
 	unsigned long vpllsrc;
 	unsigned long armclk;
 	unsigned long hclk_msys;
@@ -996,7 +1006,7 @@ void __init_or_cpufreq s5pv210_setup_clocks(void)
 	vpllsrc = clk_get_rate(&clk_vpllsrc.clk);
 	vpll = s5p_get_pll45xx(vpllsrc, __raw_readl(S5P_VPLL_CON), pll_4502);
 
-	clk_fout_apll.rate = apll;
+	clk_fout_apll.ops = &clk_fout_apll_ops;
 	clk_fout_mpll.rate = mpll;
 	clk_fout_epll.rate = epll;
 	clk_fout_vpll.rate = vpll;
-- 
1.6.2.5
