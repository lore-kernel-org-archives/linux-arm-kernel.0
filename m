From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sun, 28 Aug 2011 20:08:44 +0200
Subject: [PATCH v2 1/4] S3C2443: Move i2s clock definitions to common code
In-Reply-To: <201108282006.31667.heiko@sntech.de>
References: <201108282006.31667.heiko@sntech.de>
Message-ID: <201108282008.44684.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S3C2416/S3C2450 use the same clocks for their i2s blocks and can therefore
reuse the existing ones.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Changes since v1: added missing static
 arch/arm/mach-s3c2443/clock.c         |   53 ---------------------------------
 arch/arm/plat-s3c24xx/s3c2443-clock.c |   53 +++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/arch/arm/mach-s3c2443/clock.c b/arch/arm/mach-s3c2443/clock.c
index a1a7176..966bde5 100644
--- a/arch/arm/mach-s3c2443/clock.c
+++ b/arch/arm/mach-s3c2443/clock.c
@@ -57,10 +57,6 @@
 
 /* clock selections */
 
-static struct clk clk_i2s_ext = {
-	.name		= "i2s-ext",
-};
-
 /* armdiv
  *
  * this clock is sourced from msysclk and can have a number of
@@ -235,48 +231,6 @@ static struct clk clk_hsmmc = {
 	},
 };
 
-/* i2s_eplldiv
- *
- * This clock is the output from the I2S divisor of ESYSCLK, and is separate
- * from the mux that comes after it (cannot merge into one single clock)
-*/
-
-static struct clksrc_clk clk_i2s_eplldiv = {
-	.clk	= {
-		.name		= "i2s-eplldiv",
-		.parent		= &clk_esysclk.clk,
-	},
-	.reg_div = { .reg = S3C2443_CLKDIV1, .size = 4, .shift = 12, },
-};
-
-/* i2s-ref
- *
- * i2s bus reference clock, selectable from external, esysclk or epllref
- *
- * Note, this used to be two clocks, but was compressed into one.
-*/
-
-struct clk *clk_i2s_srclist[] = {
-	[0] = &clk_i2s_eplldiv.clk,
-	[1] = &clk_i2s_ext,
-	[2] = &clk_epllref.clk,
-	[3] = &clk_epllref.clk,
-};
-
-static struct clksrc_clk clk_i2s = {
-	.clk	= {
-		.name		= "i2s-if",
-		.ctrlbit	= S3C2443_SCLKCON_I2SCLK,
-		.enable		= s3c2443_clkcon_enable_s,
-
-	},
-	.sources = &(struct clksrc_sources) {
-		.sources = clk_i2s_srclist,
-		.nr_sources = ARRAY_SIZE(clk_i2s_srclist),
-	},
-	.reg_src = { .reg = S3C2443_CLKSRC, .size = 2, .shift = 14 },
-};
-
 /* standard clock definitions */
 
 static struct clk init_clocks_off[] = {
@@ -286,11 +240,6 @@ static struct clk init_clocks_off[] = {
 		.enable		= s3c2443_clkcon_enable_p,
 		.ctrlbit	= S3C2443_PCLKCON_SDI,
 	}, {
-		.name		= "iis",
-		.parent		= &clk_p,
-		.enable		= s3c2443_clkcon_enable_p,
-		.ctrlbit	= S3C2443_PCLKCON_IIS,
-	}, {
 		.name		= "spi",
 		.devname	= "s3c2410-spi.0",
 		.parent		= &clk_p,
@@ -312,8 +261,6 @@ static struct clk init_clocks[] = {
 
 static struct clksrc_clk *clksrcs[] __initdata = {
 	&clk_arm,
-	&clk_i2s_eplldiv,
-	&clk_i2s,
 	&clk_hsspi,
 	&clk_hsmmc_div,
 };
diff --git a/arch/arm/plat-s3c24xx/s3c2443-clock.c b/arch/arm/plat-s3c24xx/s3c2443-clock.c
index 59552c0..8132939 100644
--- a/arch/arm/plat-s3c24xx/s3c2443-clock.c
+++ b/arch/arm/plat-s3c24xx/s3c2443-clock.c
@@ -205,9 +205,60 @@ static struct clksrc_clk clksrc_clks[] = {
 	},
 };
 
+static struct clk clk_i2s_ext = {
+	.name		= "i2s-ext",
+};
+
+/* i2s_eplldiv
+ *
+ * This clock is the output from the I2S divisor of ESYSCLK, and is separate
+ * from the mux that comes after it (cannot merge into one single clock)
+*/
+
+static struct clksrc_clk clk_i2s_eplldiv = {
+	.clk	= {
+		.name		= "i2s-eplldiv",
+		.parent		= &clk_esysclk.clk,
+	},
+	.reg_div = { .reg = S3C2443_CLKDIV1, .size = 4, .shift = 12, },
+};
+
+/* i2s-ref
+ *
+ * i2s bus reference clock, selectable from external, esysclk or epllref
+ *
+ * Note, this used to be two clocks, but was compressed into one.
+*/
+
+static struct clk *clk_i2s_srclist[] = {
+	[0] = &clk_i2s_eplldiv.clk,
+	[1] = &clk_i2s_ext,
+	[2] = &clk_epllref.clk,
+	[3] = &clk_epllref.clk,
+};
+
+
+static struct clksrc_clk clk_i2s = {
+	.clk	= {
+		.name		= "i2s-if",
+		.ctrlbit	= S3C2443_SCLKCON_I2SCLK,
+		.enable		= s3c2443_clkcon_enable_s,
+
+	},
+	.sources = &(struct clksrc_sources) {
+		.sources = clk_i2s_srclist,
+		.nr_sources = ARRAY_SIZE(clk_i2s_srclist),
+	},
+	.reg_src = { .reg = S3C2443_CLKSRC, .size = 2, .shift = 14 },
+};
 
 static struct clk init_clocks_off[] = {
 	{
+		.name		= "iis",
+		.parent		= &clk_p,
+		.enable		= s3c2443_clkcon_enable_p,
+		.ctrlbit	= S3C2443_PCLKCON_IIS,
+	}, {
 		.name		= "adc",
 		.parent		= &clk_p,
 		.enable		= s3c2443_clkcon_enable_p,
@@ -406,6 +457,8 @@ static struct clk *clks[] __initdata = {
 };
 
 static struct clksrc_clk *clksrcs[] __initdata = {
+	&clk_i2s_eplldiv,
+	&clk_i2s,
 	&clk_usb_bus_host,
 	&clk_epllref,
 	&clk_esysclk,
-- 
1.7.2.3
