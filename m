From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 12 May 2010 03:35:56 +0100
Subject: [PATCH 05/15] ARM: SAMSUNG: Add s3c_disable_clocks() and tidy
	init+disable usage
In-Reply-To: <1273631766-15693-1-git-send-email-ben-linux@fluff.org>
References: <1273631766-15693-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1273631766-15693-5-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add s3c_disable_clocks() and change the clock registration code to use
the s3c_register_clocks() followed by s3c_disable_clocks() instead of
the loops it was using.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c2443/clock.c              |   27 ++++-----------------------
 arch/arm/plat-s3c24xx/s3c2410-clock.c      |   15 +++------------
 arch/arm/plat-samsung/clock.c              |   15 +++++++++++++++
 arch/arm/plat-samsung/include/plat/clock.h |    1 +
 4 files changed, 23 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-s3c2443/clock.c b/arch/arm/mach-s3c2443/clock.c
index 62cd4ea..76d8d66 100644
--- a/arch/arm/mach-s3c2443/clock.c
+++ b/arch/arm/mach-s3c2443/clock.c
@@ -492,7 +492,7 @@ static struct clk clk_prediv = {
 
 /* standard clock definitions */
 
-static struct clk init_clocks_disable[] = {
+static struct clk init_clocks_off[] = {
 	{
 		.name		= "nand",
 		.id		= -1,
@@ -761,9 +761,7 @@ void __init_or_cpufreq s3c2443_setup_clocks(void)
 
 void __init s3c2443_init_clocks(int xtal)
 {
-	struct clk *clkp;
 	unsigned long epllcon = __raw_readl(S3C2443_EPLLCON);
-	int ret;
 	int ptr;
 
 	/* s3c2443 parents h and p clocks from prediv */
@@ -774,15 +772,7 @@ void __init s3c2443_init_clocks(int xtal)
 	s3c2443_setup_clocks();
 	s3c2443_clk_initparents();
 
-	for (ptr = 0; ptr < ARRAY_SIZE(clks); ptr++) {
-		clkp = clks[ptr];
-
-		ret = s3c24xx_register_clock(clkp);
-		if (ret < 0) {
-			printk(KERN_ERR "Failed to register clock %s (%d)\n",
-			       clkp->name, ret);
-		}
-	}
+	s3c24xx_register_clocks(clks, ARRAY_SIZE(clks));
 
 	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
 		s3c_register_clksrc(clksrcs[ptr], 1);
@@ -819,17 +809,8 @@ void __init s3c2443_init_clocks(int xtal)
 
 	/* install (and disable) the clocks we do not need immediately */
 
-	clkp = init_clocks_disable;
-	for (ptr = 0; ptr < ARRAY_SIZE(init_clocks_disable); ptr++, clkp++) {
-
-		ret = s3c24xx_register_clock(clkp);
-		if (ret < 0) {
-			printk(KERN_ERR "Failed to register clock %s (%d)\n",
-			       clkp->name, ret);
-		}
-
-		(clkp->enable)(clkp, 0);
-	}
+	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
+	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 
 	s3c_pwmclk_init();
 }
diff --git a/arch/arm/plat-s3c24xx/s3c2410-clock.c b/arch/arm/plat-s3c24xx/s3c2410-clock.c
index b61bdb7..9ecc5d9 100644
--- a/arch/arm/plat-s3c24xx/s3c2410-clock.c
+++ b/arch/arm/plat-s3c24xx/s3c2410-clock.c
@@ -87,7 +87,7 @@ static int s3c2410_upll_enable(struct clk *clk, int enable)
 
 /* standard clock definitions */
 
-static struct clk init_clocks_disable[] = {
+static struct clk init_clocks_off[] = {
 	{
 		.name		= "nand",
 		.id		= -1,
@@ -249,17 +249,8 @@ int __init s3c2410_baseclk_add(void)
 
 	/* install (and disable) the clocks we do not need immediately */
 
-	clkp = init_clocks_disable;
-	for (ptr = 0; ptr < ARRAY_SIZE(init_clocks_disable); ptr++, clkp++) {
-
-		ret = s3c24xx_register_clock(clkp);
-		if (ret < 0) {
-			printk(KERN_ERR "Failed to register clock %s (%d)\n",
-			       clkp->name, ret);
-		}
-
-		s3c2410_clkcon_enable(clkp, 0);
-	}
+	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
+	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 
 	/* show the clock-slow value */
 
diff --git a/arch/arm/plat-samsung/clock.c b/arch/arm/plat-samsung/clock.c
index 1b25c9d..8bf79f3 100644
--- a/arch/arm/plat-samsung/clock.c
+++ b/arch/arm/plat-samsung/clock.c
@@ -376,6 +376,21 @@ void __init s3c_register_clocks(struct clk *clkp, int nr_clks)
 	}
 }
 
+/**
+ * s3c_disable_clocks() - disable an array of clocks
+ * @clkp: Pointer to the first clock in the array.
+ * @nr_clks: Number of clocks to register.
+ *
+ * for internal use only at initialisation time. disable the clocks in the
+ * @clkp array.
+ */
+
+void __init s3c_disable_clocks(struct clk *clkp, int nr_clks)
+{
+	for (; nr_clks > 0; nr_clks--, clkp++)
+		(clkp->enable)(clkp, 0);
+}
+
 /* initalise all the clocks */
 
 int __init s3c24xx_register_baseclocks(unsigned long xtal)
diff --git a/arch/arm/plat-samsung/include/plat/clock.h b/arch/arm/plat-samsung/include/plat/clock.h
index 60b6269..12caf48 100644
--- a/arch/arm/plat-samsung/include/plat/clock.h
+++ b/arch/arm/plat-samsung/include/plat/clock.h
@@ -91,6 +91,7 @@ extern int s3c24xx_register_clock(struct clk *clk);
 extern int s3c24xx_register_clocks(struct clk **clk, int nr_clks);
 
 extern void s3c_register_clocks(struct clk *clk, int nr_clks);
+extern void s3c_disable_clocks(struct clk *clkp, int nr_clks);
 
 extern int s3c24xx_register_baseclocks(unsigned long xtal);
 
-- 
1.6.3.3
