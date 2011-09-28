From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Wed, 28 Sep 2011 12:20:17 +0200
Subject: [PATCH 3/8] S3C2443: Move clk_arm and clk_armdiv to common code
In-Reply-To: <201109281217.33813.heiko@sntech.de>
References: <201109281217.33813.heiko@sntech.de>
Message-ID: <201109281220.17731.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The system-layout of the armdiv and armclk is common to
S3C2443/2416/2450 and only differs in the array of possible
dividers. Therefore it is possible to reuse the clock definitions
for all of these SoCs.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c2443/clock.c         |   85 +-------------------------------
 arch/arm/plat-s3c24xx/s3c2443-clock.c |   87 +++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+), 83 deletions(-)

diff --git a/arch/arm/mach-s3c2443/clock.c b/arch/arm/mach-s3c2443/clock.c
index 88edc55..6fda4bf 100644
--- a/arch/arm/mach-s3c2443/clock.c
+++ b/arch/arm/mach-s3c2443/clock.c
@@ -61,10 +61,10 @@
  *
  * this clock is sourced from msysclk and can have a number of
  * divider values applied to it to then be fed into armclk.
+ * The real clock definition is done in s3c2443-clock.c,
+ * only the armdiv divisor table must be defined here.
 */
 
-/* armdiv divisor table */
-
 static unsigned int armdiv[16] = {
 	[S3C2443_CLKDIV0_ARMDIV_1 >> S3C2443_CLKDIV0_ARMDIV_SHIFT]	= 1,
 	[S3C2443_CLKDIV0_ARMDIV_2 >> S3C2443_CLKDIV0_ARMDIV_SHIFT]	= 2,
@@ -83,85 +83,6 @@ static inline unsigned int s3c2443_fclk_div(unsigned long clkcon0)
 	return armdiv[clkcon0 >> S3C2443_CLKDIV0_ARMDIV_SHIFT];
 }
 
-static unsigned long s3c2443_armclk_roundrate(struct clk *clk,
-					      unsigned long rate)
-{
-	unsigned long parent = clk_get_rate(clk->parent);
-	unsigned long calc;
-	unsigned best = 256; /* bigger than any value */
-	unsigned div;
-	int ptr;
-
-	for (ptr = 0; ptr < ARRAY_SIZE(armdiv); ptr++) {
-		div = armdiv[ptr];
-		calc = parent / div;
-		if (calc <= rate && div < best)
-			best = div;
-	}
-
-	return parent / best;
-}
-
-static int s3c2443_armclk_setrate(struct clk *clk, unsigned long rate)
-{
-	unsigned long parent = clk_get_rate(clk->parent);
-	unsigned long calc;
-	unsigned div;
-	unsigned best = 256; /* bigger than any value */
-	int ptr;
-	int val = -1;
-
-	for (ptr = 0; ptr < ARRAY_SIZE(armdiv); ptr++) {
-		div = armdiv[ptr];
-		calc = parent / div;
-		if (calc <= rate && div < best) {
-			best = div;
-			val = ptr;
-		}
-	}
-
-	if (val >= 0) {
-		unsigned long clkcon0;
-
-		clkcon0 = __raw_readl(S3C2443_CLKDIV0);
-		clkcon0 &= ~S3C2443_CLKDIV0_ARMDIV_MASK;
-		clkcon0 |= val << S3C2443_CLKDIV0_ARMDIV_SHIFT;
-		__raw_writel(clkcon0, S3C2443_CLKDIV0);
-	}
-
-	return (val == -1) ? -EINVAL : 0;
-}
-
-static struct clk clk_armdiv = {
-	.name		= "armdiv",
-	.parent		= &clk_msysclk.clk,
-	.ops		= &(struct clk_ops) {
-		.round_rate = s3c2443_armclk_roundrate,
-		.set_rate = s3c2443_armclk_setrate,
-	},
-};
-
-/* armclk
- *
- * this is the clock fed into the ARM core itself, from armdiv or from hclk.
- */
-
-static struct clk *clk_arm_sources[] = {
-	[0] = &clk_armdiv,
-	[1] = &clk_h,
-};
-
-static struct clksrc_clk clk_arm = {
-	.clk	= {
-		.name		= "armclk",
-	},
-	.sources = &(struct clksrc_sources) {
-		.sources = clk_arm_sources,
-		.nr_sources = ARRAY_SIZE(clk_arm_sources),
-	},
-	.reg_src = { .reg = S3C2443_CLKDIV0, .size = 1, .shift = 13 },
-};
-
 /* hsspi
  *
  * high-speed spi clock, sourced from esysclk
@@ -260,14 +181,12 @@ static struct clk init_clocks[] = {
 /* clocks to add straight away */
 
 static struct clksrc_clk *clksrcs[] __initdata = {
-	&clk_arm,
 	&clk_hsspi,
 	&clk_hsmmc_div,
 };
 
 static struct clk *clks[] __initdata = {
 	&clk_hsmmc,
-	&clk_armdiv,
 };
 
 void __init_or_cpufreq s3c2443_setup_clocks(void)
diff --git a/arch/arm/plat-s3c24xx/s3c2443-clock.c b/arch/arm/plat-s3c24xx/s3c2443-clock.c
index 3f2117b..f9c5b03 100644
--- a/arch/arm/plat-s3c24xx/s3c2443-clock.c
+++ b/arch/arm/plat-s3c24xx/s3c2443-clock.c
@@ -160,10 +160,95 @@ static struct clk clk_prediv = {
 	},
 };
 
+/* armdiv
+ *
+ * this clock is sourced from msysclk and can have a number of
+ * divider values applied to it to then be fed into armclk.
+*/
+
 static unsigned int *armdiv;
 static int nr_armdiv;
 static int armdivmask;
 
+static unsigned long s3c2443_armclk_roundrate(struct clk *clk,
+					      unsigned long rate)
+{
+	unsigned long parent = clk_get_rate(clk->parent);
+	unsigned long calc;
+	unsigned best = 256; /* bigger than any value */
+	unsigned div;
+	int ptr;
+
+	for (ptr = 0; ptr < nr_armdiv; ptr++) {
+		div = armdiv[ptr];
+		calc = parent / div;
+		if (calc <= rate && div < best)
+			best = div;
+	}
+
+	return parent / best;
+}
+
+static int s3c2443_armclk_setrate(struct clk *clk, unsigned long rate)
+{
+	unsigned long parent = clk_get_rate(clk->parent);
+	unsigned long calc;
+	unsigned div;
+	unsigned best = 256; /* bigger than any value */
+	int ptr;
+	int val = -1;
+
+	for (ptr = 0; ptr < nr_armdiv; ptr++) {
+		div = armdiv[ptr];
+		calc = parent / div;
+		if (calc <= rate && div < best) {
+			best = div;
+			val = ptr;
+		}
+	}
+
+	if (val >= 0) {
+		unsigned long clkcon0;
+
+		clkcon0 = __raw_readl(S3C2443_CLKDIV0);
+		clkcon0 &= ~armdivmask;
+		clkcon0 |= val << S3C2443_CLKDIV0_ARMDIV_SHIFT;
+		__raw_writel(clkcon0, S3C2443_CLKDIV0);
+	}
+
+	return (val == -1) ? -EINVAL : 0;
+}
+
+static struct clk clk_armdiv = {
+	.name		= "armdiv",
+	.parent		= &clk_msysclk.clk,
+	.ops		= &(struct clk_ops) {
+		.round_rate = s3c2443_armclk_roundrate,
+		.set_rate = s3c2443_armclk_setrate,
+	},
+};
+
+/* armclk
+ *
+ * this is the clock fed into the ARM core itself, from armdiv or from hclk.
+ */
+
+static struct clk *clk_arm_sources[] = {
+	[0] = &clk_armdiv,
+	[1] = &clk_h,
+};
+
+static struct clksrc_clk clk_arm = {
+	.clk	= {
+		.name		= "armclk",
+	},
+	.sources = &(struct clksrc_sources) {
+		.sources = clk_arm_sources,
+		.nr_sources = ARRAY_SIZE(clk_arm_sources),
+	},
+	.reg_src = { .reg = S3C2443_CLKDIV0, .size = 1, .shift = 13 },
+};
+
 /* usbhost
  *
  * usb host bus-clock, usually 48MHz to provide USB bus clock timing
@@ -462,6 +547,7 @@ static struct clk *clks[] __initdata = {
 	&clk_ext,
 	&clk_epll,
 	&clk_usb_bus,
+	&clk_armdiv,
 };
 
 static struct clksrc_clk *clksrcs[] __initdata = {
@@ -471,6 +557,7 @@ static struct clksrc_clk *clksrcs[] __initdata = {
 	&clk_epllref,
 	&clk_esysclk,
 	&clk_msysclk,
+	&clk_arm,
 };
 
 void __init s3c2443_common_init_clocks(int xtal, pll_fn get_mpll,
-- 
1.7.5.4
