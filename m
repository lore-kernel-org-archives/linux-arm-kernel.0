From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 27 Nov 2009 16:43:57 +0000
Subject: [PATCH 5/7] S3C6410: Define CLK_AUDIO2 for IISv4 block
In-Reply-To: <20091127164312.GA11913@rakim.wolfsonmicro.main>
References: <20091127164312.GA11913@rakim.wolfsonmicro.main>
Message-ID: <1259340239-12067-5-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Note that due to the way the S3C clock API does matching based on
the ID of the platform device the ID of CLK_AUDIO2 is set to -1.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/plat-s3c64xx/include/plat/regs-clock.h |    4 ++
 arch/arm/plat-s3c64xx/s3c6400-clock.c           |   43 +++++++++++++++++++++++
 2 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/include/plat/regs-clock.h b/arch/arm/plat-s3c64xx/include/plat/regs-clock.h
index ff46e7f..8c429bb 100644
--- a/arch/arm/plat-s3c64xx/include/plat/regs-clock.h
+++ b/arch/arm/plat-s3c64xx/include/plat/regs-clock.h
@@ -25,6 +25,7 @@
 #define S3C_EPLL_CON0		S3C_CLKREG(0x14)
 #define S3C_EPLL_CON1		S3C_CLKREG(0x18)
 #define S3C_CLK_SRC		S3C_CLKREG(0x1C)
+#define S3C_CLK_SRC2		S3C_CLKREG(0x10C)
 #define S3C_CLK_DIV0		S3C_CLKREG(0x20)
 #define S3C_CLK_DIV1		S3C_CLKREG(0x24)
 #define S3C_CLK_DIV2		S3C_CLKREG(0x28)
@@ -221,5 +222,8 @@
 #define S3C6400_CLKSRC_UHOST_MASK	(0x3 << 5)
 #define S3C6400_CLKSRC_UHOST_SHIFT	(5)
 
+/* CLK_SRC2 */
+#define S3C6410_CLKSRC_AUDIO2_MASK	(0x7 << 0)
+#define S3C6410_CLKSRC_AUDIO2_SHIFT	(0)
 
 #endif /* _PLAT_REGS_CLOCK_H */
diff --git a/arch/arm/plat-s3c64xx/s3c6400-clock.c b/arch/arm/plat-s3c64xx/s3c6400-clock.c
index b7e2015..1dee8c5 100644
--- a/arch/arm/plat-s3c64xx/s3c6400-clock.c
+++ b/arch/arm/plat-s3c64xx/s3c6400-clock.c
@@ -507,6 +507,11 @@ static struct clk clk_iis_cd1 = {
 	.id		= -1,
 };
 
+static struct clk clk_iis_v4_cd = {
+	.name		= "iis_v40_cdclk",
+	.id		= -1,
+};
+
 static struct clk clk_pcm_cd = {
 	.name		= "pcm_cdclk",
 	.id		= -1,
@@ -576,6 +581,42 @@ static struct clksrc_clk clk_audio1 = {
 	.reg_src	= S3C_CLK_SRC,
 };
 
+static struct clk *clkset_audio2_list[] = {
+	[0] = &clk_mout_epll.clk,
+	[1] = &clk_dout_mpll,
+	[2] = &clk_fin_epll,
+	[3] = &clk_iis_v4_cd,
+	[4] = &clk_pcm_cd,
+};
+
+static struct clk_sources clkset_audio2 = {
+	.sources	= clkset_audio2_list,
+	.nr_sources	= ARRAY_SIZE(clkset_audio2_list),
+};
+
+/* Note that due to hard coding of clock ID to platform device ID we
+ * declare the ID for this clock as -1 even though it's called AUDIO2
+ * by the datasheet.
+ */
+static struct clksrc_clk clk_audio2 = {
+	.clk	= {
+		.name		= "audio-bus",
+		.id		= -1,
+		.ctrlbit        = S3C6410_CLKCON_SCLK_AUDIO2,
+		.enable		= s3c64xx_sclk_ctrl,
+		.set_parent	= s3c64xx_setparent_clksrc,
+		.get_rate	= s3c64xx_getrate_clksrc,
+		.set_rate	= s3c64xx_setrate_clksrc,
+		.round_rate	= s3c64xx_roundrate_clksrc,
+	},
+	.shift		= S3C6410_CLKSRC_AUDIO2_SHIFT,
+	.mask		= S3C6410_CLKSRC_AUDIO2_MASK,
+	.sources	= &clkset_audio2,
+	.divider_shift	= S3C6410_CLKDIV2_AUDIO2_SHIFT,
+	.reg_divider	= S3C_CLK_DIV2,
+	.reg_src	= S3C_CLK_SRC2,
+};
+
 static struct clksrc_clk clk_irda = {
 	.clk	= {
 		.name		= "irda-bus",
@@ -638,6 +679,7 @@ static struct clksrc_clk *init_parents[] = {
 	&clk_spi1,
 	&clk_audio0,
 	&clk_audio1,
+	&clk_audio2,
 	&clk_irda,
 	&clk_camif,
 };
@@ -742,6 +784,7 @@ static struct clk *clks[] __initdata = {
 	&clk_spi1.clk,
 	&clk_audio0.clk,
 	&clk_audio1.clk,
+	&clk_audio2.clk,
 	&clk_irda.clk,
 	&clk_camif.clk,
 	&clk_arm,
-- 
1.6.5.3
