From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 Jul 2014 15:45:07 +0200
Subject: [PATCH 3/4] ASoC: samsung: s3c24xx dmaengine follow-up
In-Reply-To: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
References: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
Message-ID: <1405086308-1461192-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit ae602456e83c92 ("ASoC: samsung: drop support for legacy
S3C24XX DMA API") removed the old code for the samsung specific
DMA interfaces, now that everybody can use dmaengine.

This picks up the few remaining pieces left over by that patch:

The most important one is the removal of the dma_data->ops->started()
calls in ac97. My understanding is that these are only required
for drivers that do not support cyclic transfers, which the new dma
engine driver now does, so we can simply remove them. This would also
fix at least one bug in the ac97 driver on newer machines, which
currently gives us a NULL pointer dereference from trying to call
dma_data->ops->started().

Further, we must no longer 'select' S3C2410_DMA, which conflicts
with the dmaengine driver. The SND_S3C_DMA symbol is now
useless, because it is always selected, so we can remove it
and build the dmaengine support unconditionally.

Finally, we should not 'select' S3C24XX_DMAC or S3C64XX_PL080,
which may have additional dependencies. This replaces it with
'depends on', to be more conservative.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Sangbeom Kim <sbkim73@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-samsung-soc at vger.kernel.org
---
 sound/soc/samsung/Kconfig  | 10 ++--------
 sound/soc/samsung/Makefile |  2 +-
 sound/soc/samsung/ac97.c   | 17 -----------------
 3 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 7622af82ac4f..afcf95c6e212 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -1,18 +1,14 @@
 config SND_SOC_SAMSUNG
 	tristate "ASoC support for Samsung"
 	depends on PLAT_SAMSUNG
-	select S3C24XX_DMAC if ARCH_S3C24XX
-	select S3C64XX_PL080 if ARCH_S3C64XX
-	select SND_S3C_DMA
+	depends on S3C64XX_PL080 || !ARCH_S3C64XX
+	depends on S3C24XX_DMAC || !ARCH_S3C24XX
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the Samsung SoCs' Audio interfaces. You will also need to
 	  select the audio interfaces to support below.
 
-config SND_S3C_DMA
-	tristate
-
 config SND_S3C24XX_I2S
 	tristate
 
@@ -77,7 +73,6 @@ config SND_SOC_SAMSUNG_SMDK_WM8994
 config SND_SOC_SAMSUNG_SMDK2443_WM9710
 	tristate "SoC AC97 Audio support for SMDK2443 - WM9710"
 	depends on SND_SOC_SAMSUNG && MACH_SMDK2443
-	select S3C2410_DMA
 	select AC97_BUS
 	select SND_SOC_AC97_CODEC
 	select SND_SAMSUNG_AC97
@@ -88,7 +83,6 @@ config SND_SOC_SAMSUNG_SMDK2443_WM9710
 config SND_SOC_SAMSUNG_LN2440SBC_ALC650
 	tristate "SoC AC97 Audio support for LN2440SBC - ALC650"
 	depends on SND_SOC_SAMSUNG && ARCH_S3C24XX
-	select S3C2410_DMA
 	select AC97_BUS
 	select SND_SOC_AC97_CODEC
 	select SND_SAMSUNG_AC97
diff --git a/sound/soc/samsung/Makefile b/sound/soc/samsung/Makefile
index e8d9ccdc41fd..91505ddaaf95 100644
--- a/sound/soc/samsung/Makefile
+++ b/sound/soc/samsung/Makefile
@@ -9,7 +9,7 @@ snd-soc-samsung-spdif-objs := spdif.o
 snd-soc-pcm-objs := pcm.o
 snd-soc-i2s-objs := i2s.o
 
-obj-$(CONFIG_SND_S3C_DMA) += snd-soc-s3c-dma.o
+obj-$(CONFIG_SND_SOC_SAMSUNG) += snd-soc-s3c-dma.o
 obj-$(CONFIG_SND_S3C24XX_I2S) += snd-soc-s3c24xx-i2s.o
 obj-$(CONFIG_SND_SAMSUNG_AC97) += snd-soc-ac97.o
 obj-$(CONFIG_SND_S3C2412_SOC_I2S) += snd-soc-s3c2412-i2s.o
diff --git a/sound/soc/samsung/ac97.c b/sound/soc/samsung/ac97.c
index 68d9303047e8..2aa24d052a4a 100644
--- a/sound/soc/samsung/ac97.c
+++ b/sound/soc/samsung/ac97.c
@@ -19,7 +19,6 @@
 
 #include <sound/soc.h>
 
-#include <mach/dma.h>
 #include "regs-ac97.h"
 #include <linux/platform_data/asoc-s3c.h>
 
@@ -225,9 +224,6 @@ static int s3c_ac97_trigger(struct snd_pcm_substream *substream, int cmd,
 				struct snd_soc_dai *dai)
 {
 	u32 ac_glbctrl;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct s3c_dma_params *dma_data =
-		snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
 	ac_glbctrl = readl(s3c_ac97.regs + S3C_AC97_GLBCTRL);
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
@@ -253,11 +249,6 @@ static int s3c_ac97_trigger(struct snd_pcm_substream *substream, int cmd,
 
 	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
 
-	if (!dma_data->ops)
-		dma_data->ops = samsung_dma_get_ops();
-
-	dma_data->ops->started(dma_data->channel);
-
 	return 0;
 }
 
@@ -265,9 +256,6 @@ static int s3c_ac97_mic_trigger(struct snd_pcm_substream *substream,
 				    int cmd, struct snd_soc_dai *dai)
 {
 	u32 ac_glbctrl;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct s3c_dma_params *dma_data =
-		snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
 	ac_glbctrl = readl(s3c_ac97.regs + S3C_AC97_GLBCTRL);
 	ac_glbctrl &= ~S3C_AC97_GLBCTRL_MICINTM_MASK;
@@ -287,11 +275,6 @@ static int s3c_ac97_mic_trigger(struct snd_pcm_substream *substream,
 
 	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
 
-	if (!dma_data->ops)
-		dma_data->ops = samsung_dma_get_ops();
-
-	dma_data->ops->started(dma_data->channel);
-
 	return 0;
 }
 
-- 
1.8.3.2
