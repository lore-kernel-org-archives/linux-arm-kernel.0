From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 17 May 2010 09:38:12 +0900
Subject: [PATCH 02/18] ARM: S5PV210: Register apll/mpll/epll clksrc_clk clocks
Message-ID: <1274056692-14250-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

This patch modifies the following.

1. Registers the mout_apll clksrc_clk clock.

2. The mout_mpll and mout_epll clocks were registered as 'struct clk'
   types and then their parents were setup using the s3c_set_clksrc
   function. This patch reduces the two steps into one by registering
   the mout_mpll and mout_epll clocks using the s3c_register_clksrc
   function.

3. As per point 2 above, the init_parents array is no longer required.
   So the mout clocks are now put together in a new array named 'sysclks'.
   The sysclks array will list the system level clocks and more
   clocks will be added to it in the subsequent patches.

4. The clks array is left empty because of the movement of mpll and epll
   clocks into the sysclks array. It is not deleted since subsequent
   patches will add clocks into this array.

Signed-off-by: Thomas Abraham <thomas.ab <at> samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim <at> samsung.com>
---
 arch/arm/mach-s5pv210/clock.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index a620cd8..25b73a3 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -324,7 +324,7 @@ static struct clksrc_clk clksrcs[] = {
 };
 
 /* Clock initialisation code */
-static struct clksrc_clk *init_parents[] = {
+static struct clksrc_clk *sysclks[] = {
 	&clk_mout_apll,
 	&clk_mout_epll,
 	&clk_mout_mpll,
@@ -411,16 +411,11 @@ void __init_or_cpufreq s5pv210_setup_clocks(void)
 	clk_h166.rate = hclk166;
 	clk_h200.rate = hclk200;
 
-	for (ptr = 0; ptr < ARRAY_SIZE(init_parents); ptr++)
-		s3c_set_clksrc(init_parents[ptr], true);
-
 	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
 		s3c_set_clksrc(&clksrcs[ptr], true);
 }
 
 static struct clk *clks[] __initdata = {
-	&clk_mout_epll.clk,
-	&clk_mout_mpll.clk,
 };
 
 void __init s5pv210_register_clocks(void)
@@ -433,6 +428,9 @@ void __init s5pv210_register_clocks(void)
 	if (ret > 0)
 		printk(KERN_ERR "Failed to register %u clocks\n", ret);
 
+	for (ptr = 0; ptr < ARRAY_SIZE(sysclks); ptr++)
+		s3c_register_clksrc(sysclks[ptr], 1);
+
 	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
 	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
 
-- 
1.6.2.5
