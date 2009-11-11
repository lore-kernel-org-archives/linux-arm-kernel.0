From: jassi.brar@samsung.com (Jassi Brar)
Date: Wed, 11 Nov 2009 14:47:21 +0900
Subject: [PATCH 2/2] S3C6410 I2S: Added audio-bus for I2S_v4
Message-ID: <1257918441-24289-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added support for 'audio-bus' for I2S_v4 controller.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/plat-s3c64xx/include/plat/regs-clock.h |    2 +
 arch/arm/plat-s3c64xx/s3c6400-clock.c           |   39 +++++++++++++++++++++++
 2 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/include/plat/regs-clock.h b/arch/arm/plat-s3c64xx/include/plat/regs-clock.h
index ff46e7f..5e6be68 100644
--- a/arch/arm/plat-s3c64xx/include/plat/regs-clock.h
+++ b/arch/arm/plat-s3c64xx/include/plat/regs-clock.h
@@ -221,5 +221,7 @@
 #define S3C6400_CLKSRC_UHOST_MASK	(0x3 << 5)
 #define S3C6400_CLKSRC_UHOST_SHIFT	(5)
 
+#define S3C6410_CLKSRC2_AUDIO2_MASK	(0x7 << 0)
+#define S3C6410_CLKSRC2_AUDIO2_SHIFT	(0)
 
 #endif /* _PLAT_REGS_CLOCK_H */
diff --git a/arch/arm/plat-s3c64xx/s3c6400-clock.c b/arch/arm/plat-s3c64xx/s3c6400-clock.c
index 6ffa21e..a1b4784 100644
--- a/arch/arm/plat-s3c64xx/s3c6400-clock.c
+++ b/arch/arm/plat-s3c64xx/s3c6400-clock.c
@@ -496,6 +496,11 @@ static struct clk clk_iis_cd1 = {
 	.id		= -1,
 };
 
+static struct clk clk_iis_cd2 = {
+	.name		= "iis_cdclk_v4",
+	.id		= -1,
+};
+
 static struct clk clk_pcm_cd = {
 	.name		= "pcm_cdclk",
 	.id		= -1,
@@ -563,6 +568,37 @@ static struct clksrc_clk clk_audio1 = {
 	.reg_divider	= S3C_CLK_DIV2,
 };
 
+static struct clk *clkset_audio2_list[] = {
+	[0] = &clk_mout_epll.clk,
+	[1] = &clk_dout_mpll,
+	[2] = &clk_fin_epll,
+	[3] = &clk_iis_cd2,
+	[4] = &clk_pcm_cd,
+};
+
+static struct clk_sources clkset_audio2 = {
+	.sources	= clkset_audio2_list,
+	.nr_sources	= ARRAY_SIZE(clkset_audio2_list),
+};
+
+static struct clksrc_clk clk_audio2 = {
+	.clk	= {
+		.name		= "audio-bus",
+		.id		= 2,
+		.ctrlbit        = S3C6410_CLKCON_SCLK_AUDIO2,
+		.enable		= s3c64xx_sclk_ctrl,
+		.set_parent	= s3c64xx_setparent_clksrc,
+		.get_rate	= s3c64xx_getrate_clksrc,
+		.set_rate	= s3c64xx_setrate_clksrc,
+		.round_rate	= s3c64xx_roundrate_clksrc,
+	},
+	.shift		= S3C6410_CLKSRC2_AUDIO2_SHIFT,
+	.mask		= S3C6410_CLKSRC2_AUDIO2_MASK,
+	.sources	= &clkset_audio2,
+	.divider_shift	= S3C6410_CLKDIV2_AUDIO2_SHIFT,
+	.reg_divider	= S3C_CLK_DIV2,
+};
+
 static struct clksrc_clk clk_irda = {
 	.clk	= {
 		.name		= "irda-bus",
@@ -623,6 +659,7 @@ static struct clksrc_clk *init_parents[] = {
 	&clk_spi1,
 	&clk_audio0,
 	&clk_audio1,
+	&clk_audio2,
 	&clk_irda,
 	&clk_camif,
 };
@@ -713,6 +750,7 @@ static struct clk *clks[] __initdata = {
 	&clk_ext_xtal_mux,
 	&clk_iis_cd0,
 	&clk_iis_cd1,
+	&clk_iis_cd2,
 	&clk_pcm_cd,
 	&clk_mout_epll.clk,
 	&clk_fout_epll,
@@ -727,6 +765,7 @@ static struct clk *clks[] __initdata = {
 	&clk_spi1.clk,
 	&clk_audio0.clk,
 	&clk_audio1.clk,
+	&clk_audio2.clk,
 	&clk_irda.clk,
 	&clk_camif.clk,
 	&clk_arm,
-- 
1.6.2.5
