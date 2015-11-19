From: songjun.wu@atmel.com (Songjun Wu)
Date: Thu, 19 Nov 2015 11:45:32 +0800
Subject: [PATCH] ASoC: Atmel: ClassD: supports mono audio
Message-ID: <1447904732-10784-1-git-send-email-songjun.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modify the code to support mono audio.

Signed-off-by: Songjun Wu <songjun.wu@atmel.com>
---

 sound/soc/atmel/atmel-classd.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/atmel/atmel-classd.c b/sound/soc/atmel/atmel-classd.c
index 2f5190b..10ac47d 100644
--- a/sound/soc/atmel/atmel-classd.c
+++ b/sound/soc/atmel/atmel-classd.c
@@ -106,7 +106,7 @@ static const struct snd_pcm_hardware atmel_classd_hw = {
 	.rates			= ATMEL_CLASSD_RATES,
 	.rate_min		= 8000,
 	.rate_max		= 96000,
-	.channels_min		= 2,
+	.channels_min		= 1,
 	.channels_max		= 2,
 	.buffer_bytes_max	= 64 * 1024,
 	.period_bytes_min	= 256,
@@ -145,7 +145,7 @@ static const struct snd_soc_dai_ops atmel_classd_cpu_dai_ops = {
 
 static struct snd_soc_dai_driver atmel_classd_cpu_dai = {
 	.playback = {
-		.channels_min	= 2,
+		.channels_min	= 1,
 		.channels_max	= 2,
 		.rates		= ATMEL_CLASSD_RATES,
 		.formats	= SNDRV_PCM_FMTBIT_S16_LE,},
@@ -171,9 +171,13 @@ atmel_classd_platform_configure_dma(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	if (params_channels(params) == 1)
+		slave_config->dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+	else
+		slave_config->dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+
 	slave_config->direction		= DMA_MEM_TO_DEV;
 	slave_config->dst_addr		= dd->phy_base + CLASSD_THR;
-	slave_config->dst_addr_width	= DMA_SLAVE_BUSWIDTH_4_BYTES;
 	slave_config->dst_maxburst	= 1;
 	slave_config->src_maxburst	= 1;
 	slave_config->device_fc		= false;
@@ -486,7 +490,7 @@ static struct snd_soc_dai_driver atmel_classd_codec_dai = {
 	.name = ATMEL_CLASSD_CODEC_DAI_NAME,
 	.playback = {
 		.stream_name	= "Playback",
-		.channels_min	= 2,
+		.channels_min	= 1,
 		.channels_max	= 2,
 		.rates		= ATMEL_CLASSD_RATES,
 		.formats	= SNDRV_PCM_FMTBIT_S16_LE,
-- 
1.7.9.5
