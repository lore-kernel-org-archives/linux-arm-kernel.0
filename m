From: ben-linux@fluff.org (Ben Dooks)
Date: Fri,  8 Jan 2010 02:30:21 +0000
Subject: [S3C-CLK] ARM: SAMSUNG: Add call to register array of clocks
In-Reply-To: <1262917822-26004-1-git-send-email-ben-linux@fluff.org>
References: <1262917822-26004-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1262917822-26004-14-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add s3c_register_clocks() to register an array of clocks, printing
an error message if there is a problem. Replace all points in the code
where this could be used.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c2443/clock.c              |    9 +--------
 arch/arm/plat-s3c/pwm-clock.c              |   18 ++++--------------
 arch/arm/plat-s3c64xx/clock.c              |   10 +---------
 arch/arm/plat-s5pc1xx/clock.c              |   12 ++----------
 arch/arm/plat-samsung/clock.c              |   22 ++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/clock.h |    2 ++
 6 files changed, 32 insertions(+), 41 deletions(-)

diff --git a/arch/arm/mach-s3c2443/clock.c b/arch/arm/mach-s3c2443/clock.c
index 91db4f5..3eb8b93 100644
--- a/arch/arm/mach-s3c2443/clock.c
+++ b/arch/arm/mach-s3c2443/clock.c
@@ -1104,14 +1104,7 @@ void __init s3c2443_init_clocks(int xtal)
 
 	/* register clocks from clock array */
 
-	clkp = init_clocks;
-	for (ptr = 0; ptr < ARRAY_SIZE(init_clocks); ptr++, clkp++) {
-		ret = s3c24xx_register_clock(clkp);
-		if (ret < 0) {
-			printk(KERN_ERR "Failed to register clock %s (%d)\n",
-			       clkp->name, ret);
-		}
-	}
+	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
 
 	/* We must be careful disabling the clocks we are not intending to
 	 * be using at boot time, as subsystems such as the LCD which do
diff --git a/arch/arm/plat-s3c/pwm-clock.c b/arch/arm/plat-s3c/pwm-clock.c
index 1808fa8..46c9381 100644
--- a/arch/arm/plat-s3c/pwm-clock.c
+++ b/arch/arm/plat-s3c/pwm-clock.c
@@ -430,25 +430,15 @@ __init void s3c_pwmclk_init(void)
 		return;
 	}
 
-	for (clk = 0; clk < ARRAY_SIZE(clk_timer_scaler); clk++) {
+	for (clk = 0; clk < ARRAY_SIZE(clk_timer_scaler); clk++)
 		clk_timer_scaler[clk].parent = clk_timers;
-		ret = s3c24xx_register_clock(&clk_timer_scaler[clk]);
-		if (ret < 0) {
-			printk(KERN_ERR "error adding pwm scaler%d clock\n", clk);
-			return;
-		}
-	}
 
-	for (clk = 0; clk < ARRAY_SIZE(clk_timer_tclk); clk++) {
-		ret = s3c24xx_register_clock(&clk_timer_tclk[clk]);
-		if (ret < 0) {
-			printk(KERN_ERR "error adding pww tclk%d\n", clk);
-			return;
-		}
-	}
+	s3c_register_clocks(clk_timer_scaler, ARRAY_SIZE(clk_timer_scaler));
+	s3c_register_clocks(clk_timer_tclk, ARRAY_SIZE(clk_timer_tclk));
 
 	for (clk = 0; clk < ARRAY_SIZE(clk_timer_tdiv); clk++) {
 		ret = clk_pwm_tdiv_register(clk);
+
 		if (ret < 0) {
 			printk(KERN_ERR "error adding pwm%d tdiv clock\n", clk);
 			return;
diff --git a/arch/arm/plat-s3c64xx/clock.c b/arch/arm/plat-s3c64xx/clock.c
index 7a36e89..ae5883c 100644
--- a/arch/arm/plat-s3c64xx/clock.c
+++ b/arch/arm/plat-s3c64xx/clock.c
@@ -274,15 +274,7 @@ void __init s3c64xx_register_clocks(void)
 	int ptr;
 
 	s3c24xx_register_clocks(clks, ARRAY_SIZE(clks));
-
-	clkp = init_clocks;
-	for (ptr = 0; ptr < ARRAY_SIZE(init_clocks); ptr++, clkp++) {
-		ret = s3c24xx_register_clock(clkp);
-		if (ret < 0) {
-			printk(KERN_ERR "Failed to register clock %s (%d)\n",
-			       clkp->name, ret);
-		}
-	}
+	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
 
 	clkp = init_clocks_disable;
 	for (ptr = 0; ptr < ARRAY_SIZE(init_clocks_disable); ptr++, clkp++) {
diff --git a/arch/arm/plat-s5pc1xx/clock.c b/arch/arm/plat-s5pc1xx/clock.c
index 2f4d8d4..cc21a8b 100644
--- a/arch/arm/plat-s5pc1xx/clock.c
+++ b/arch/arm/plat-s5pc1xx/clock.c
@@ -704,16 +704,8 @@ void __init s5pc1xx_register_clocks(void)
 
 	s3c24xx_register_clocks(clks, ARRAY_SIZE(clks));
 
-	clkp = s5pc100_init_clocks;
-	size = ARRAY_SIZE(s5pc100_init_clocks);
-
-	for (ptr = 0; ptr < size; ptr++, clkp++) {
-		ret = s3c24xx_register_clock(clkp);
-		if (ret < 0) {
-			printk(KERN_ERR "Failed to register clock %s (%d)\n",
-			       clkp->name, ret);
-		}
-	}
+	s3c_register_clocks(s5pc100_init_clocks,
+			    ARRAY_SIZE(s5pc100_init_clocks);
 
 	clkp = s5pc100_init_clocks_disable;
 	size = ARRAY_SIZE(s5pc100_init_clocks_disable);
diff --git a/arch/arm/plat-samsung/clock.c b/arch/arm/plat-samsung/clock.c
index fa91125..9194af9 100644
--- a/arch/arm/plat-samsung/clock.c
+++ b/arch/arm/plat-samsung/clock.c
@@ -336,6 +336,28 @@ int s3c24xx_register_clocks(struct clk **clks, int nr_clks)
 	return fails;
 }
 
+/**
+ * s3c_register_clocks() - register an array of clocks
+ * @clkp: Pointer to the first clock in the array.
+ * @nr_clks: Number of clocks to register.
+ *
+ * Call s3c24xx_register_clock() on the @clkp array given, printing an
+ * error if it fails to register the clock (unlikely).
+ */
+void __initdata s3c_register_clocks(struct clk *clkp, int nr_clks)
+{
+	int ret;
+
+	for (; nr_clks > 0; nr_clks--, clkp++) {
+		ret = s3c24xx_register_clock(clkp);
+
+		if (ret < 0) {
+			printk(KERN_ERR "Failed to register clock %s (%d)\n",
+			       clkp->name, ret);
+		}
+	}
+}
+
 /* initalise all the clocks */
 
 int __init s3c24xx_register_baseclocks(unsigned long xtal)
diff --git a/arch/arm/plat-samsung/include/plat/clock.h b/arch/arm/plat-samsung/include/plat/clock.h
index 43324af..bd41f82 100644
--- a/arch/arm/plat-samsung/include/plat/clock.h
+++ b/arch/arm/plat-samsung/include/plat/clock.h
@@ -87,6 +87,8 @@ extern int s3c2410_clkcon_enable(struct clk *clk, int enable);
 extern int s3c24xx_register_clock(struct clk *clk);
 extern int s3c24xx_register_clocks(struct clk **clk, int nr_clks);
 
+extern void s3c_register_clocks(struct clk *clk, int nr_clks);
+
 extern int s3c24xx_register_baseclocks(unsigned long xtal);
 
 extern void s3c64xx_register_clocks(void);
-- 
1.6.0.4
