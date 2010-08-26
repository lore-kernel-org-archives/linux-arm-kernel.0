From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 26 Aug 2010 15:28:36 +0900
Subject: [PATCH V2 02/14] ARM: S5PV310: Removed unused clock
In-Reply-To: <1282804120-17241-1-git-send-email-kgene.kim@samsung.com>
References: <1282804120-17241-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1282804120-17241-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This pach removed unused clock on S5PV310/S5PC210.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
Changes since v1:
- Restored some clocks for CPU_FREQ as per MyungJoo Ham's pointing out

 arch/arm/mach-s5pv310/clock.c |   46 +---------------------------------------
 1 files changed, 2 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-s5pv310/clock.c b/arch/arm/mach-s5pv310/clock.c
index 77f2b4d..447be0b 100644
--- a/arch/arm/mach-s5pv310/clock.c
+++ b/arch/arm/mach-s5pv310/clock.c
@@ -132,24 +132,6 @@ static struct clksrc_clk clk_periphclk = {
 	.reg_div	= { .reg = S5P_CLKDIV_CPU, .shift = 12, .size = 3 },
 };
 
-static struct clksrc_clk clk_atclk = {
-	.clk	= {
-		.name		= "atclk",
-		.id		= -1,
-		.parent		= &clk_moutcore.clk,
-	},
-	.reg_div	= { .reg = S5P_CLKDIV_CPU, .shift = 16, .size = 3 },
-};
-
-static struct clksrc_clk clk_pclk_dbg = {
-	.clk	= {
-		.name		= "pclk_dbg",
-		.id		= -1,
-		.parent		= &clk_atclk.clk,
-	},
-	.reg_div	= { .reg = S5P_CLKDIV_CPU, .shift = 20, .size = 3 },
-};
-
 /* Core list of CMU_CORE side */
 
 static struct clk *clkset_corebus_list[] = {
@@ -420,8 +402,6 @@ static struct clksrc_clk *sysclks[] = {
 	&clk_aclk_cores,
 	&clk_aclk_corem1,
 	&clk_periphclk,
-	&clk_atclk,
-	&clk_pclk_dbg,
 	&clk_mout_corebus,
 	&clk_sclk_dmc,
 	&clk_aclk_cored,
@@ -446,15 +426,7 @@ void __init_or_cpufreq s5pv310_setup_clocks(void)
 	unsigned long vpllsrc;
 	unsigned long xtal;
 	unsigned long armclk;
-	unsigned long aclk_corem0;
-	unsigned long aclk_cores;
-	unsigned long aclk_corem1;
-	unsigned long periphclk;
 	unsigned long sclk_dmc;
-	unsigned long aclk_cored;
-	unsigned long aclk_corep;
-	unsigned long aclk_acp;
-	unsigned long pclk_acp;
 	unsigned int ptr;
 
 	printk(KERN_DEBUG "%s: registering clocks\n", __func__);
@@ -485,26 +457,12 @@ void __init_or_cpufreq s5pv310_setup_clocks(void)
 			apll, mpll, epll, vpll);
 
 	armclk = clk_get_rate(&clk_armclk.clk);
-	aclk_corem0 = clk_get_rate(&clk_aclk_corem0.clk);
-	aclk_cores = clk_get_rate(&clk_aclk_cores.clk);
-	aclk_corem1 = clk_get_rate(&clk_aclk_corem1.clk);
-	periphclk = clk_get_rate(&clk_periphclk.clk);
 	sclk_dmc = clk_get_rate(&clk_sclk_dmc.clk);
-	aclk_cored = clk_get_rate(&clk_aclk_cored.clk);
-	aclk_corep = clk_get_rate(&clk_aclk_corep.clk);
-	aclk_acp = clk_get_rate(&clk_aclk_acp.clk);
-	pclk_acp = clk_get_rate(&clk_pclk_acp.clk);
-
-	printk(KERN_INFO "S5PV310: ARMCLK=%ld, COREM0=%ld, CORES=%ld\n"
-			 "COREM1=%ld, PERI=%ld, DMC=%ld, CORED=%ld\n"
-			 "COREP=%ld, ACLK_ACP=%ld, PCLK_ACP=%ld",
-			armclk, aclk_corem0, aclk_cores, aclk_corem1,
-			periphclk, sclk_dmc, aclk_cored, aclk_corep,
-			aclk_acp, pclk_acp);
+
+	printk(KERN_INFO "S5PV310: ARMCLK=%ld, DMC=%ld\n", armclk, sclk_dmc);
 
 	clk_f.rate = armclk;
 	clk_h.rate = sclk_dmc;
-	clk_p.rate = periphclk;
 
 	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
 		s3c_set_clksrc(&clksrcs[ptr], true);
-- 
1.6.2.5
