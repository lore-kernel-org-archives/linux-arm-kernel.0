From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 13 May 2010 18:22:59 +0100
Subject: [PATCH 2.6.35] ARM: S3C6410: Add missing definitions for the IISv4
	clock
Message-ID: <1273771379-5729-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 301176 ("Declare IISv4 audio-bus clock") requires both the
register S3C6410_CLK_SRC2 and the clkset for the IISv4 audio bus but
neither of those is defined in mainline.  Add definitions, including the
addition of the PCMCDCLK[1] and the CDCLK for the IISv4 block both of
which are first used by this clock.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/clock.c                   |   23 +++++++++++++++++++++++
 arch/arm/mach-s3c64xx/include/mach/regs-clock.h |    1 +
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index 28215d5..50c8db3 100644
--- a/arch/arm/mach-s3c64xx/clock.c
+++ b/arch/arm/mach-s3c64xx/clock.c
@@ -518,11 +518,21 @@ static struct clk clk_iis_cd1 = {
 	.id		= -1,
 };
 
+static struct clk clk_iis_v40_cd = {
+	.name		= "iis_v40_cdclk",
+	.id		= -1,
+};
+
 static struct clk clk_pcm_cd = {
 	.name		= "pcm_cdclk",
 	.id		= -1,
 };
 
+static struct clk clk_pcm_cd1 = {
+	.name		= "pcm_cdclk1",
+	.id		= -1,
+};
+
 static struct clk *clkset_audio0_list[] = {
 	[0] = &clk_mout_epll.clk,
 	[1] = &clk_dout_mpll,
@@ -549,6 +559,19 @@ static struct clksrc_sources clkset_audio1 = {
 	.nr_sources	= ARRAY_SIZE(clkset_audio1_list),
 };
 
+static struct clk *clkset_audio2_list[] = {
+	[0] = &clk_mout_epll.clk,
+	[1] = &clk_dout_mpll,
+	[2] = &clk_fin_epll,
+	[3] = &clk_iis_v40_cd,
+	[4] = &clk_pcm_cd1,
+};
+
+static struct clksrc_sources clkset_audio2 = {
+	.sources	= clkset_audio2_list,
+	.nr_sources	= ARRAY_SIZE(clkset_audio2_list),
+};
+
 static struct clk *clkset_camif_list[] = {
 	&clk_h2,
 };
diff --git a/arch/arm/mach-s3c64xx/include/mach/regs-clock.h b/arch/arm/mach-s3c64xx/include/mach/regs-clock.h
index 3ef6274..0114eb0 100644
--- a/arch/arm/mach-s3c64xx/include/mach/regs-clock.h
+++ b/arch/arm/mach-s3c64xx/include/mach/regs-clock.h
@@ -33,6 +33,7 @@
 #define S3C_PCLK_GATE		S3C_CLKREG(0x34)
 #define S3C_SCLK_GATE		S3C_CLKREG(0x38)
 #define S3C_MEM0_GATE		S3C_CLKREG(0x3C)
+#define S3C6410_CLK_SRC2	S3C_CLKREG(0x10C)
 
 /* CLKDIV0 */
 #define S3C6400_CLKDIV0_PCLK_MASK	(0xf << 12)
-- 
1.7.0.3
