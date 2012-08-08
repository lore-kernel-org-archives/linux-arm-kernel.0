From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed,  8 Aug 2012 10:43:27 +0530
Subject: [RFC] ARM: SAMSUNG: Remove redundant return code from
 xxx_register_clock
Message-ID: <1344402807-1007-1-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s3c24xx_register_clock(struct clk *clk) always returns 0, so checking
its return value has no meaning.

Making this function to return void would help us save quite a line of
code.

Need comment on whether this is the right approach.

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/plat-samsung/clock.c              |   32 +++++----------------------
 arch/arm/plat-samsung/include/plat/clock.h |    4 +-
 2 files changed, 8 insertions(+), 28 deletions(-)

diff --git a/arch/arm/plat-samsung/clock.c b/arch/arm/plat-samsung/clock.c
index 65c5eca..c0d75d0 100644
--- a/arch/arm/plat-samsung/clock.c
+++ b/arch/arm/plat-samsung/clock.c
@@ -276,7 +276,7 @@ struct clk s3c24xx_uclk = {
  *
  * Add the specified clock to the list of clocks known by the system.
  */
-int s3c24xx_register_clock(struct clk *clk)
+void s3c24xx_register_clock(struct clk *clk)
 {
 	if (clk->enable == NULL)
 		clk->enable = clk_null_enable;
@@ -286,8 +286,6 @@ int s3c24xx_register_clock(struct clk *clk)
 	clk->lookup.con_id = clk->name;
 	clk->lookup.clk = clk;
 	clkdev_add(&clk->lookup);
-
-	return 0;
 }
 
 /**
@@ -298,20 +296,10 @@ int s3c24xx_register_clock(struct clk *clk)
  * Call s3c24xx_register_clock() for all the clock pointers contained
  * in the @clks list. Returns the number of failures.
  */
-int s3c24xx_register_clocks(struct clk **clks, int nr_clks)
+void s3c24xx_register_clocks(struct clk **clks, int nr_clks)
 {
-	int fails = 0;
-
-	for (; nr_clks > 0; nr_clks--, clks++) {
-		if (s3c24xx_register_clock(*clks) < 0) {
-			struct clk *clk = *clks;
-			printk(KERN_ERR "%s: failed to register %p: %s\n",
-			       __func__, clk, clk->name);
-			fails++;
-		}
-	}
-
-	return fails;
+	for (; nr_clks > 0; nr_clks--, clks++)
+		s3c24xx_register_clock(*clks);
 }
 
 /**
@@ -324,16 +312,8 @@ int s3c24xx_register_clocks(struct clk **clks, int nr_clks)
  */
 void __init s3c_register_clocks(struct clk *clkp, int nr_clks)
 {
-	int ret;
-
-	for (; nr_clks > 0; nr_clks--, clkp++) {
-		ret = s3c24xx_register_clock(clkp);
-
-		if (ret < 0) {
-			printk(KERN_ERR "Failed to register clock %s (%d)\n",
-			       clkp->name, ret);
-		}
-	}
+	for (; nr_clks > 0; nr_clks--, clkp++)
+		s3c24xx_register_clock(clkp);
 }
 
 /**
diff --git a/arch/arm/plat-samsung/include/plat/clock.h b/arch/arm/plat-samsung/include/plat/clock.h
index a62753d..d646093 100644
--- a/arch/arm/plat-samsung/include/plat/clock.h
+++ b/arch/arm/plat-samsung/include/plat/clock.h
@@ -101,8 +101,8 @@ extern spinlock_t clocks_lock;
 
 extern int s3c2410_clkcon_enable(struct clk *clk, int enable);
 
-extern int s3c24xx_register_clock(struct clk *clk);
-extern int s3c24xx_register_clocks(struct clk **clk, int nr_clks);
+extern void s3c24xx_register_clock(struct clk *clk);
+extern void s3c24xx_register_clocks(struct clk **clk, int nr_clks);
 
 extern void s3c_register_clocks(struct clk *clk, int nr_clks);
 extern void s3c_disable_clocks(struct clk *clkp, int nr_clks);
-- 
1.7.4.1
