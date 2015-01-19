From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 19 Jan 2015 10:54:56 +0100
Subject: [PATCH 2/3] ASoC: sh: fsi: Fix clock inversion
In-Reply-To: <1421661297-19654-1-git-send-email-lars@metafoo.de>
References: <1421661297-19654-1-git-send-email-lars@metafoo.de>
Message-ID: <1421661297-19654-2-git-send-email-lars@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the sh7724 hardware user manual (Rev.2.00 Jan 2013) page 1851
to 1856 the FSI bit-clock is inverted to the bit-clock as specified by the
I2S standard. This means the bit clock inversion bit should be set for a
normal I2S clock and should not be set for an inverted I2S clock.

Similarly when operating in left-justified mode both the frame-clock and the
bit-clock need to be inverted to be standards compliant.

This means also that the extra clock inversion setting in the
armadillo800eva machine driver for CPU component should now be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
I don't have the hardware but I'd like to get rid of the extra
SND_SOC_DAIFMT_IB_NF in simple-card platform data, so we can remove the fmt
field. Kuninori can you check if this works?
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 1 -
 sound/soc/sh/fsi.c                             | 7 +++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 75de26c..36aaeb1 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1015,7 +1015,6 @@ static struct asoc_simple_card_info fsi_wm8978_info = {
 	.platform	= "sh_fsi2",
 	.daifmt		= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM,
 	.cpu_dai = {
-		.fmt	= SND_SOC_DAIFMT_IB_NF,
 		.name	= "fsia-dai",
 	},
 	.codec_dai = {
diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index b87b22e..dfb17f6 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1594,6 +1594,12 @@ static int fsi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 
 static int fsi_set_fmt_dai(struct fsi_priv *fsi, unsigned int fmt)
 {
+	/*
+	 * FSI bit clock is inverted to the I2S specification, so we invert it
+	 * when a non-inverted I2S clock was requested and vice versa.
+	 */
+	 fsi->bit_clk_inv = !fsi->bit_clk_inv;
+
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		fsi->fmt = CR_I2S;
@@ -1602,6 +1608,7 @@ static int fsi_set_fmt_dai(struct fsi_priv *fsi, unsigned int fmt)
 	case SND_SOC_DAIFMT_LEFT_J:
 		fsi->fmt = CR_PCM;
 		fsi->chan_num = 2;
+		fsi->lr_clk_inv = !fsi->lr_clk_inv;
 		break;
 	default:
 		return -EINVAL;
-- 
1.8.0
