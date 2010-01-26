From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 26 Jan 2010 07:03:04 +0000
Subject: [PATCH] ARM: S3C64XX: Combine the clock init code
In-Reply-To: <1264489385-13345-1-git-send-email-ben-linux@fluff.org>
References: <1264489385-13345-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1264489385-13345-14-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Turn the init sequence of
	s3c24xx_register_baseclocks(xtal);
	s3c64xx_register_clocks();
	s3c6400_register_clocks(S3C6410_CLKDIV0_ARM_MASK);

into a single call as this is now contained within one file.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c64xx/clock.c                |   50 ++++++++++----------------
 arch/arm/mach-s3c64xx/include/mach/s3c6400.h |    3 +-
 arch/arm/mach-s3c64xx/s3c6400.c              |    5 +--
 arch/arm/mach-s3c64xx/s3c6410.c              |    4 +--
 arch/arm/plat-samsung/include/plat/clock.h   |    1 -
 5 files changed, 23 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index 9b587e2..7f5e1aa 100644
--- a/arch/arm/mach-s3c64xx/clock.c
+++ b/arch/arm/mach-s3c64xx/clock.c
@@ -748,19 +748,29 @@ static struct clk *clks1[] __initdata = {
 	&clk_arm,
 };
 
+static struct clk *clks[] __initdata = {
+	&clk_ext,
+	&clk_epll,
+	&clk_27m,
+	&clk_48m,
+	&clk_h2,
+};
+
 /**
- * s3c6400_register_clocks - register clocks for s3c6400 and above
- * @armclk_divlimit: Divisor mask for ARMCLK
+ * s3c64xx_register_clocks - register clocks for s3c6400 and s3c6410
+ * @xtal: The rate for the clock crystal feeding the PLLs.
+ * @armclk_divlimit: Divisor mask for ARMCLK.
  *
- * Register the clocks for the S3C6400 and above SoC range, such
- * as ARMCLK and the clocks which have divider chains attached.
+ * Register the clocks for the S3C6400 and S3C6410 SoC range, such
+ * as ARMCLK as well as the necessary parent clocks.
  *
  * This call does not setup the clocks, which is left to the
  * s3c6400_setup_clocks() call which may be needed by the cpufreq
  * or resume code to re-set the clocks if the bootloader has changed
  * them.
  */
-void __init s3c6400_register_clocks(unsigned armclk_divlimit)
+void __init s3c64xx_register_clocks(unsigned long xtal, 
+				    unsigned armclk_divlimit)
 {
 	struct clk *clkp;
 	int ret;
@@ -768,33 +778,9 @@ void __init s3c6400_register_clocks(unsigned armclk_divlimit)
 
 	armclk_mask = armclk_divlimit;
 
-	for (ptr = 0; ptr < ARRAY_SIZE(clks1); ptr++) {
-		clkp = clks1[ptr];
-		ret = s3c24xx_register_clock(clkp);
-		if (ret < 0) {
-			printk(KERN_ERR "Failed to register clock %s (%d)\n",
-			       clkp->name, ret);
-		}
-	}
-
-	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
-}
-
-static struct clk *clks[] __initdata = {
-	&clk_ext,
-	&clk_epll,
-	&clk_27m,
-	&clk_48m,
-	&clk_h2,
-};
-
-void __init s3c64xx_register_clocks(void)
-{
-	struct clk *clkp;
-	int ret;
-	int ptr;
-
+	s3c24xx_register_baseclocks(xtal);
 	s3c24xx_register_clocks(clks, ARRAY_SIZE(clks));
+
 	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
 
 	clkp = init_clocks_disable;
@@ -809,5 +795,7 @@ void __init s3c64xx_register_clocks(void)
 		(clkp->enable)(clkp, 0);
 	}
 
+	s3c24xx_register_clocks(clks1, ARRAY_SIZE(clks1));
+	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
 	s3c_pwmclk_init();
 }
diff --git a/arch/arm/mach-s3c64xx/include/mach/s3c6400.h b/arch/arm/mach-s3c64xx/include/mach/s3c6400.h
index 2bc7c07..f86958d 100644
--- a/arch/arm/mach-s3c64xx/include/mach/s3c6400.h
+++ b/arch/arm/mach-s3c64xx/include/mach/s3c6400.h
@@ -15,9 +15,10 @@
 /* Common init code for S3C6400 related SoCs */
 
 extern void s3c6400_common_init_uarts(struct s3c2410_uartcfg *cfg, int no);
-extern void s3c6400_register_clocks(unsigned armclk_divlimit);
 extern void s3c6400_setup_clocks(void);
 
+extern void s3c64xx_register_clocks(unsigned long xtal, unsigned armclk_limit);
+
 #ifdef CONFIG_CPU_S3C6400
 
 extern  int s3c6400_init(void);
diff --git a/arch/arm/mach-s3c64xx/s3c6400.c b/arch/arm/mach-s3c64xx/s3c6400.c
index 720d0d1..707e34e 100644
--- a/arch/arm/mach-s3c64xx/s3c6400.c
+++ b/arch/arm/mach-s3c64xx/s3c6400.c
@@ -55,10 +55,7 @@ void __init s3c6400_map_io(void)
 
 void __init s3c6400_init_clocks(int xtal)
 {
-	printk(KERN_DEBUG "%s: initialising clocks\n", __func__);
-	s3c24xx_register_baseclocks(xtal);
-	s3c64xx_register_clocks();
-	s3c6400_register_clocks(S3C6400_CLKDIV0_ARM_MASK);
+	s3c64xx_register_clocks(xtal, S3C6400_CLKDIV0_ARM_MASK);
 	s3c6400_setup_clocks();
 }
 
diff --git a/arch/arm/mach-s3c64xx/s3c6410.c b/arch/arm/mach-s3c64xx/s3c6410.c
index fd457cc..59635d1 100644
--- a/arch/arm/mach-s3c64xx/s3c6410.c
+++ b/arch/arm/mach-s3c64xx/s3c6410.c
@@ -58,9 +58,7 @@ void __init s3c6410_map_io(void)
 void __init s3c6410_init_clocks(int xtal)
 {
 	printk(KERN_DEBUG "%s: initialising clocks\n", __func__);
-	s3c24xx_register_baseclocks(xtal);
-	s3c64xx_register_clocks();
-	s3c6400_register_clocks(S3C6410_CLKDIV0_ARM_MASK);
+	s3c64xx_register_clocks(xtal, S3C6410_CLKDIV0_ARM_MASK);
 	s3c6400_setup_clocks();
 }
 
diff --git a/arch/arm/plat-samsung/include/plat/clock.h b/arch/arm/plat-samsung/include/plat/clock.h
index ba9a1cd..60b6269 100644
--- a/arch/arm/plat-samsung/include/plat/clock.h
+++ b/arch/arm/plat-samsung/include/plat/clock.h
@@ -94,7 +94,6 @@ extern void s3c_register_clocks(struct clk *clk, int nr_clks);
 
 extern int s3c24xx_register_baseclocks(unsigned long xtal);
 
-extern void s3c64xx_register_clocks(void);
 extern void s5p_register_clocks(unsigned long xtal_freq);
 
 extern void s3c24xx_setup_clocks(unsigned long fclk,
-- 
1.6.0.4
