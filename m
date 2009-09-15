From: jassi.brar@samsung.com (Jassi)
Date: Tue, 15 Sep 2009 19:02:39 +0900
Subject: [PATCH 07/10] S3C64XX I2S: Added third I2S Controller.
Message-ID: <1253008959-10633-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added support for the 3rd(I2S_v4) controller that can be used by
the machine audio driver.

Signed-Off-by: Jassi <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/s3c64xx-i2s.c |   49 ++++++++++++++++++++++++++++++++++++--
 1 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
index 6f8959d..62a7fce 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.c
@@ -30,6 +30,8 @@
 #include <plat/regs-s3c2412-iis.h>
 #include <plat/gpio-bank-d.h>
 #include <plat/gpio-bank-e.h>
+#include <plat/gpio-bank-c.h>
+#include <plat/gpio-bank-h.h>
 #include <plat/gpio-cfg.h>
 #include <plat/audio.h>
 
@@ -47,7 +49,7 @@ static struct s3c2410_dma_client s3c64xx_dma_client_in = {
 	.name		= "I2S PCM Stereo in"
 };
 
-static struct s3c24xx_pcm_dma_params s3c64xx_i2s_pcm_stereo_out[2] = {
+static struct s3c24xx_pcm_dma_params s3c64xx_i2s_pcm_stereo_out[] = {
 	[0] = {
 		.channel	= DMACH_I2S0_OUT,
 		.client		= &s3c64xx_dma_client_out,
@@ -60,9 +62,15 @@ static struct s3c24xx_pcm_dma_params s3c64xx_i2s_pcm_stereo_out[2] = {
 		.dma_addr	= S3C64XX_PA_IIS1 + S3C2412_IISTXD,
 		.dma_size	= 4,
 	},
+	[2] = {
+		.channel	= DMACH_HSI_I2SV40_TX,
+		.client		= &s3c64xx_dma_client_out,
+		.dma_addr	= S3C64XX_PA_IISV4 + S3C2412_IISTXD,
+		.dma_size	= 4,
+	},
 };
 
-static struct s3c24xx_pcm_dma_params s3c64xx_i2s_pcm_stereo_in[2] = {
+static struct s3c24xx_pcm_dma_params s3c64xx_i2s_pcm_stereo_in[] = {
 	[0] = {
 		.channel	= DMACH_I2S0_IN,
 		.client		= &s3c64xx_dma_client_in,
@@ -75,9 +83,15 @@ static struct s3c24xx_pcm_dma_params s3c64xx_i2s_pcm_stereo_in[2] = {
 		.dma_addr	= S3C64XX_PA_IIS1 + S3C2412_IISRXD,
 		.dma_size	= 4,
 	},
+	[2] = {
+		.channel	= DMACH_HSI_I2SV40_RX,
+		.client		= &s3c64xx_dma_client_in,
+		.dma_addr	= S3C64XX_PA_IISV4 + S3C2412_IISRXD,
+		.dma_size	= 4,
+	},
 };
 
-static struct s3c_i2sv2_info s3c64xx_i2s[2];
+static struct s3c_i2sv2_info s3c64xx_i2s[3];
 
 static inline struct s3c_i2sv2_info *to_info(struct snd_soc_dai *cpu_dai)
 {
@@ -142,6 +156,16 @@ static int s3c64xx_i2s_probe(struct platform_device *pdev,
 		s3c_gpio_cfgpin(S3C64XX_GPE(2), S3C64XX_GPE2_I2S1_LRCLK);
 		s3c_gpio_cfgpin(S3C64XX_GPE(3), S3C64XX_GPE3_I2S1_DI);
 		s3c_gpio_cfgpin(S3C64XX_GPE(4), S3C64XX_GPE4_I2S1_D0);
+		break;
+	case 2:
+		s3c_gpio_cfgpin(S3C64XX_GPC(4), S3C64XX_GPC4_I2S_V40_DO0);
+		s3c_gpio_cfgpin(S3C64XX_GPC(5), S3C64XX_GPC5_I2S_V40_DO1);
+		s3c_gpio_cfgpin(S3C64XX_GPC(7), S3C64XX_GPC7_I2S_V40_DO2);
+		s3c_gpio_cfgpin(S3C64XX_GPH(6), S3C64XX_GPH6_I2S_V40_BCLK);
+		s3c_gpio_cfgpin(S3C64XX_GPH(7), S3C64XX_GPH7_I2S_V40_CDCLK);
+		s3c_gpio_cfgpin(S3C64XX_GPH(8), S3C64XX_GPH8_I2S_V40_LRCLK);
+		s3c_gpio_cfgpin(S3C64XX_GPH(9), S3C64XX_GPH9_I2S_V40_DI);
+		break;
 	}
 
 	return 0;
@@ -200,6 +224,25 @@ struct snd_soc_dai s3c64xx_i2s_dai[] = {
 		.ops = &s3c64xx_i2s_dai_ops,
 		.symmetric_rates = 1,
 	},
+	{
+		.name		= "s3c64xx-i2s-v4",
+		.id		= 2,
+		.probe		= s3c64xx_i2s_probe,
+		.playback = {
+			.channels_min	= 2,
+			.channels_max	= 2,
+			.rates		= S3C64XX_I2S_RATES,
+			.formats	= S3C64XX_I2S_FMTS,
+		},
+		.capture = {
+			 .channels_min	= 2,
+			 .channels_max	= 2,
+			 .rates		= S3C64XX_I2S_RATES,
+			 .formats	= S3C64XX_I2S_FMTS,
+		 },
+		.ops = &s3c64xx_i2s_dai_ops,
+		.symmetric_rates = 1,
+	},
 };
 EXPORT_SYMBOL_GPL(s3c64xx_i2s_dai);
 
-- 
1.6.2.5
