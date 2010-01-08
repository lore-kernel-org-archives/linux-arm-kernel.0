From: ben-linux@fluff.org (Ben Dooks)
Date: Fri,  8 Jan 2010 02:30:18 +0000
Subject: [S3C-CLK] ARM: S3C64XX: Avoid announcing clksrc clocks twice
In-Reply-To: <1262917822-26004-1-git-send-email-ben-linux@fluff.org>
References: <1262917822-26004-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1262917822-26004-11-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new code calls the clock setup code on registration which
can be before the clock system has been fully initialised. The
following code re-does this setup at the end of the clock
registration and thus we get two printings.

Update the calls to only print on the last pass or when doing
the necessary resume work.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-s3c64xx/s3c6400-clock.c             |    4 ++--
 arch/arm/plat-samsung/clock-clksrc.c              |   16 +++++++++++-----
 arch/arm/plat-samsung/include/plat/clock-clksrc.h |   10 +++++++++-
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/s3c6400-clock.c b/arch/arm/plat-s3c64xx/s3c6400-clock.c
index 555d1aa..cb2bf4b 100644
--- a/arch/arm/plat-s3c64xx/s3c6400-clock.c
+++ b/arch/arm/plat-s3c64xx/s3c6400-clock.c
@@ -486,10 +486,10 @@ void __init_or_cpufreq s3c6400_setup_clocks(void)
 	clk_f.rate = fclk;
 
 	for (ptr = 0; ptr < ARRAY_SIZE(init_parents); ptr++)
-		s3c_set_clksrc(init_parents[ptr]);
+		s3c_set_clksrc(init_parents[ptr], true);
 
 	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
-		s3c_set_clksrc(&clksrcs[ptr]);
+		s3c_set_clksrc(&clksrcs[ptr], true);
 }
 
 static struct clk *clks[] __initdata = {
diff --git a/arch/arm/plat-samsung/clock-clksrc.c b/arch/arm/plat-samsung/clock-clksrc.c
index ad4e872..12129f8 100644
--- a/arch/arm/plat-samsung/clock-clksrc.c
+++ b/arch/arm/plat-samsung/clock-clksrc.c
@@ -125,7 +125,7 @@ static unsigned long s3c_roundrate_clksrc(struct clk *clk,
 
 /* Clock initialisation code */
 
-void __init_or_cpufreq s3c_set_clksrc(struct clksrc_clk *clk)
+void __init_or_cpufreq s3c_set_clksrc(struct clksrc_clk *clk, bool announce)
 {
 	struct clksrc_sources *srcs = clk->sources;
 	u32 mask = bit_mask(clk->reg_src.shift, clk->reg_src.size);
@@ -145,9 +145,10 @@ void __init_or_cpufreq s3c_set_clksrc(struct clksrc_clk *clk)
 
 	clk->clk.parent = srcs->sources[clksrc];
 
-	printk(KERN_INFO "%s: source is %s (%d), rate is %ld\n",
-	       clk->clk.name, clk->clk.parent->name, clksrc,
-	       clk_get_rate(&clk->clk));
+	if (announce)
+		printk(KERN_INFO "%s: source is %s (%d), rate is %ld\n",
+		       clk->clk.name, clk->clk.parent->name, clksrc,
+		       clk_get_rate(&clk->clk));
 }
 
 static struct clk_ops clksrc_ops = {
@@ -166,7 +167,12 @@ void __init s3c_register_clksrc(struct clksrc_clk *clksrc, int size)
 		if (!clksrc->clk.ops)
 			clksrc->clk.ops = &clksrc_ops;
 
-		s3c_set_clksrc(clksrc);
+		/* setup the clocksource, but do not announce it
+		 * as it may be re-set by the setup routines
+		 * called after the rest of the clocks have been
+		 * registered
+		 */
+		s3c_set_clksrc(clksrc, false);
 
 		ret = s3c24xx_register_clock(&clksrc->clk);
 
diff --git a/arch/arm/plat-samsung/include/plat/clock-clksrc.h b/arch/arm/plat-samsung/include/plat/clock-clksrc.h
index 283dfa0..50a8ca7 100644
--- a/arch/arm/plat-samsung/include/plat/clock-clksrc.h
+++ b/arch/arm/plat-samsung/include/plat/clock-clksrc.h
@@ -63,7 +63,15 @@ struct clksrc_clk {
 	struct clksrc_reg	reg_div;
 };
 
-extern void s3c_set_clksrc(struct clksrc_clk *clk);
+/**
+ * s3c_set_clksrc() - setup the clock from the register settings
+ * @clk: The clock to setup.
+ * @announce: true to announce the setting to printk().
+ *
+ * Setup the clock from the current register settings, for when the
+ * kernel boots or if it is resuming from a possibly unknown state.
+ */
+extern void s3c_set_clksrc(struct clksrc_clk *clk, bool announce);
 
 /**
  * s3c_register_clksrc() register clocks from an array of clksrc clocks
-- 
1.6.0.4
