From: jassi.brar@samsung.com (Jassi)
Date: Tue, 15 Sep 2009 19:02:38 +0900
Subject: [PATCH 06/10] S3C I2S: LRCLK polarity option.
Message-ID: <1253008958-10601-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1) Explicitly set LRCLK polarity for I2S Vs LSM/MSB modes.
2) Convert from numerical to bit-field values for BCLK selection.
3) Use proper error checking for return value from clk_get

Signed-Off-by: Jassi <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/s3c-i2s-v2.c |   30 +++++++++++++++++++++++++++++-
 1 files changed, 29 insertions(+), 1 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
index 8865bc7..1870e05 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.c
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.c
@@ -312,12 +312,15 @@ static int s3c2412_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_RIGHT_J:
+		iismod |= S3C2412_IISMOD_LR_RLOW;
 		iismod |= S3C2412_IISMOD_SDF_MSB;
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
+		iismod |= S3C2412_IISMOD_LR_RLOW;
 		iismod |= S3C2412_IISMOD_SDF_LSB;
 		break;
 	case SND_SOC_DAIFMT_I2S:
+		iismod &= ~S3C2412_IISMOD_LR_RLOW;
 		iismod |= S3C2412_IISMOD_SDF_IIS;
 		break;
 	default:
@@ -467,6 +470,31 @@ static int s3c2412_i2s_set_clkdiv(struct snd_soc_dai *cpu_dai,
 
 	switch (div_id) {
 	case S3C_I2SV2_DIV_BCLK:
+		if (div > 3) {
+			/* convert value to bit field */
+
+			switch (div) {
+			case 16:
+				div = S3C2412_IISMOD_BCLK_16FS;
+				break;
+
+			case 32:
+				div = S3C2412_IISMOD_BCLK_32FS;
+				break;
+
+			case 24:
+				div = S3C2412_IISMOD_BCLK_24FS;
+				break;
+
+			case 48:
+				div = S3C2412_IISMOD_BCLK_48FS;
+				break;
+
+			default:
+				return -EINVAL;
+			}
+		}
+
 		reg = readl(i2s->regs + S3C2412_IISMOD);
 		reg &= ~S3C2412_IISMOD_BCLK_MASK;
 		writel(reg | div, i2s->regs + S3C2412_IISMOD);
@@ -626,7 +654,7 @@ int s3c_i2sv2_probe(struct platform_device *pdev,
 	}
 
 	i2s->iis_pclk = clk_get(dev, "iis");
-	if (i2s->iis_pclk == NULL) {
+	if (IS_ERR(i2s->iis_pclk)) {
 		dev_err(dev, "failed to get iis_clock\n");
 		iounmap(i2s->regs);
 		return -ENOENT;
-- 
1.6.2.5
