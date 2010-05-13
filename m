From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 13 May 2010 09:26:49 +0900
Subject: [PATCH 01/11] ARM: S5P6440: Register apll/mpll/epll mout clocks.
Message-ID: <1273710409-14525-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

This patch modifies the following.

1. Registers the mout_apll clksrc_clk clock.

2. The mout_mpll and mout_epll were registered as 'struct clk'
   types and then their parents were setup using the s3c_set_clksrc
   function. This patch reduces the two steps into one by registering
   the mout_mpll and mout_epll clocks using the s3c_register_clksrc
   function.

3. As per point 2 above, the init_parents array is no longer required.
   So the mout clocks are now put together in a new array named 'sysclks'.
   The sysclks array will list the system level clocks and more
   clocks will be added to it in the subsequent patches.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p6440/clock.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-s5p6440/clock.c b/arch/arm/mach-s5p6440/clock.c
index b2672e1..3ad63f4 100644
--- a/arch/arm/mach-s5p6440/clock.c
+++ b/arch/arm/mach-s5p6440/clock.c
@@ -574,7 +574,7 @@ static struct clksrc_clk clksrcs[] = {
 };
 
 /* Clock initialisation code */
-static struct clksrc_clk *init_parents[] = {
+static struct clksrc_clk *sysclks[] = {
 	&clk_mout_apll,
 	&clk_mout_epll,
 	&clk_mout_mpll,
@@ -652,17 +652,12 @@ void __init_or_cpufreq s5p6440_setup_clocks(void)
 	clk_h_low.rate = hclk_low;
 	clk_p_low.rate = pclk_low;
 
-	for (ptr = 0; ptr < ARRAY_SIZE(init_parents); ptr++)
-		s3c_set_clksrc(init_parents[ptr], true);
-
 	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
 		s3c_set_clksrc(&clksrcs[ptr], true);
 }
 
 static struct clk *clks[] __initdata = {
 	&clk_ext,
-	&clk_mout_epll.clk,
-	&clk_mout_mpll.clk,
 	&clk_dout_mpll,
 	&clk_iis_cd_v40,
 	&clk_pcm_cd,
@@ -680,6 +675,9 @@ void __init s5p6440_register_clocks(void)
 	if (ret > 0)
 		printk(KERN_ERR "Failed to register %u clocks\n", ret);
 
+	for (ptr = 0; ptr < ARRAY_SIZE(sysclks); ptr++)
+		s3c_register_clksrc(sysclks[ptr], 1);
+
 	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
 	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
 
-- 
1.6.2.5
