From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 23 Feb 2012 14:47:24 +0800
Subject: [PATCH 4/4] ASoC: imx: separate imx-pcm bits from imx-ssi driver
In-Reply-To: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1329979644-31046-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the imx-ssi.c[h] accommodates the imx-pcm common bits which
are shared between imx-pcm-dma-mx2 and imx-pcm-fiq drivers.  It assumes
that imx-pcm-dma-mx2 and imx-pcm-fiq will always be used together with
imx-ssi driver.  However this becomes untrue when we see that driver
sound/soc/fsl/fsl_ssi could possibly work with imx-pcm-dma-mx2 too.

The patch moves the imx-pcm common bits from imx-ssi.c[h] into new
files imx-pcm.c[h], and let imx-pcm-dma-mx2 and imx-pcm-fiq drivers
build it in, so that imx-pcm-dma-mx2 can work with no dependency on
imx-ssi driver.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/imx/Kconfig           |    5 ++
 sound/soc/imx/Makefile          |   10 ++--
 sound/soc/imx/imx-pcm-dma-mx2.c |    2 +-
 sound/soc/imx/imx-pcm.c         |  105 +++++++++++++++++++++++++++++++++++++++
 sound/soc/imx/imx-pcm.h         |   32 ++++++++++++
 sound/soc/imx/imx-ssi.c         |   88 --------------------------------
 sound/soc/imx/imx-ssi.h         |   16 +------
 7 files changed, 149 insertions(+), 109 deletions(-)
 create mode 100644 sound/soc/imx/imx-pcm.c
 create mode 100644 sound/soc/imx/imx-pcm.h

diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
index bca5d34..863a6b4 100644
--- a/sound/soc/imx/Kconfig
+++ b/sound/soc/imx/Kconfig
@@ -8,12 +8,17 @@ menuconfig SND_IMX_SOC
 
 if SND_IMX_SOC
 
+config SND_SOC_IMX_PCM
+	tristate
+
 config SND_MXC_SOC_FIQ
 	tristate
 	select FIQ
+	select SND_SOC_IMX_PCM
 
 config SND_MXC_SOC_MX2
 	tristate
+	select SND_SOC_IMX_PCM
 
 config SND_MXC_SOC_WM1133_EV1
 	tristate "Audio on the the i.MX31ADS with WM1133-EV1 fitted"
diff --git a/sound/soc/imx/Makefile b/sound/soc/imx/Makefile
index d6d609b..303bc05 100644
--- a/sound/soc/imx/Makefile
+++ b/sound/soc/imx/Makefile
@@ -1,11 +1,11 @@
 # i.MX Platform Support
 snd-soc-imx-objs := imx-ssi.o
-snd-soc-imx-fiq-objs := imx-pcm-fiq.o
-snd-soc-imx-mx2-objs := imx-pcm-dma-mx2.o
-
 obj-$(CONFIG_SND_IMX_SOC) += snd-soc-imx.o
-obj-$(CONFIG_SND_MXC_SOC_FIQ) += snd-soc-imx-fiq.o
-obj-$(CONFIG_SND_MXC_SOC_MX2) += snd-soc-imx-mx2.o
+
+obj-$(CONFIG_SND_SOC_IMX_PCM) += snd-soc-imx-pcm.o
+snd-soc-imx-pcm-y := imx-pcm.o
+snd-soc-imx-pcm-$(CONFIG_SND_MXC_SOC_FIQ) += imx-pcm-fiq.o
+snd-soc-imx-pcm-$(CONFIG_SND_MXC_SOC_MX2) += imx-pcm-dma-mx2.o
 
 # i.MX Machine Support
 snd-soc-eukrea-tlv320-objs := eukrea-tlv320.o
diff --git a/sound/soc/imx/imx-pcm-dma-mx2.c b/sound/soc/imx/imx-pcm-dma-mx2.c
index 1737141..e2d7287 100644
--- a/sound/soc/imx/imx-pcm-dma-mx2.c
+++ b/sound/soc/imx/imx-pcm-dma-mx2.c
@@ -30,7 +30,7 @@
 
 #include <mach/dma.h>
 
-#include "imx-ssi.h"
+#include "imx-pcm.h"
 
 struct imx_pcm_runtime_data {
 	int period_bytes;
diff --git a/sound/soc/imx/imx-pcm.c b/sound/soc/imx/imx-pcm.c
new file mode 100644
index 0000000..93dc360
--- /dev/null
+++ b/sound/soc/imx/imx-pcm.c
@@ -0,0 +1,105 @@
+/*
+ * Copyright 2009 Sascha Hauer <s.hauer@pengutronix.de>
+ *
+ * This code is based on code copyrighted by Freescale,
+ * Liam Girdwood, Javier Martin and probably others.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include "imx-pcm.h"
+
+int snd_imx_pcm_mmap(struct snd_pcm_substream *substream,
+		struct vm_area_struct *vma)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int ret;
+
+	ret = dma_mmap_writecombine(substream->pcm->card->dev, vma,
+		runtime->dma_area, runtime->dma_addr, runtime->dma_bytes);
+
+	pr_debug("%s: ret: %d %p 0x%08x 0x%08x\n", __func__, ret,
+			runtime->dma_area,
+			runtime->dma_addr,
+			runtime->dma_bytes);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_imx_pcm_mmap);
+
+static int imx_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
+{
+	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
+	struct snd_dma_buffer *buf = &substream->dma_buffer;
+	size_t size = IMX_SSI_DMABUF_SIZE;
+
+	buf->dev.type = SNDRV_DMA_TYPE_DEV;
+	buf->dev.dev = pcm->card->dev;
+	buf->private_data = NULL;
+	buf->area = dma_alloc_writecombine(pcm->card->dev, size,
+					   &buf->addr, GFP_KERNEL);
+	if (!buf->area)
+		return -ENOMEM;
+	buf->bytes = size;
+
+	return 0;
+}
+
+static u64 imx_pcm_dmamask = DMA_BIT_MASK(32);
+
+int imx_pcm_new(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_card *card = rtd->card->snd_card;
+	struct snd_pcm *pcm = rtd->pcm;
+	int ret = 0;
+
+	if (!card->dev->dma_mask)
+		card->dev->dma_mask = &imx_pcm_dmamask;
+	if (!card->dev->coherent_dma_mask)
+		card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
+	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream) {
+		ret = imx_pcm_preallocate_dma_buffer(pcm,
+			SNDRV_PCM_STREAM_PLAYBACK);
+		if (ret)
+			goto out;
+	}
+
+	if (pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream) {
+		ret = imx_pcm_preallocate_dma_buffer(pcm,
+			SNDRV_PCM_STREAM_CAPTURE);
+		if (ret)
+			goto out;
+	}
+
+out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(imx_pcm_new);
+
+void imx_pcm_free(struct snd_pcm *pcm)
+{
+	struct snd_pcm_substream *substream;
+	struct snd_dma_buffer *buf;
+	int stream;
+
+	for (stream = 0; stream < 2; stream++) {
+		substream = pcm->streams[stream].substream;
+		if (!substream)
+			continue;
+
+		buf = &substream->dma_buffer;
+		if (!buf->area)
+			continue;
+
+		dma_free_writecombine(pcm->card->dev, buf->bytes,
+				      buf->area, buf->addr);
+		buf->area = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(imx_pcm_free);
diff --git a/sound/soc/imx/imx-pcm.h b/sound/soc/imx/imx-pcm.h
new file mode 100644
index 0000000..b5f5c3a
--- /dev/null
+++ b/sound/soc/imx/imx-pcm.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright 2009 Sascha Hauer <s.hauer@pengutronix.de>
+ *
+ * This code is based on code copyrighted by Freescale,
+ * Liam Girdwood, Javier Martin and probably others.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef _IMX_PCM_H
+#define _IMX_PCM_H
+
+/*
+ * Do not change this as the FIQ handler depends on this size
+ */
+#define IMX_SSI_DMABUF_SIZE	(64 * 1024)
+
+struct imx_pcm_dma_params {
+	int dma;
+	unsigned long dma_addr;
+	int burstsize;
+};
+
+int snd_imx_pcm_mmap(struct snd_pcm_substream *substream,
+		     struct vm_area_struct *vma);
+int imx_pcm_new(struct snd_soc_pcm_runtime *rtd);
+void imx_pcm_free(struct snd_pcm *pcm);
+
+#endif /* _IMX_PCM_H */
diff --git a/sound/soc/imx/imx-ssi.c b/sound/soc/imx/imx-ssi.c
index 25c6231..9203cdd 100644
--- a/sound/soc/imx/imx-ssi.c
+++ b/sound/soc/imx/imx-ssi.c
@@ -363,94 +363,6 @@ static const struct snd_soc_dai_ops imx_ssi_pcm_dai_ops = {
 	.trigger	= imx_ssi_trigger,
 };
 
-int snd_imx_pcm_mmap(struct snd_pcm_substream *substream,
-		struct vm_area_struct *vma)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	int ret;
-
-	ret = dma_mmap_writecombine(substream->pcm->card->dev, vma,
-		runtime->dma_area, runtime->dma_addr, runtime->dma_bytes);
-
-	pr_debug("%s: ret: %d %p 0x%08x 0x%08x\n", __func__, ret,
-			runtime->dma_area,
-			runtime->dma_addr,
-			runtime->dma_bytes);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(snd_imx_pcm_mmap);
-
-static int imx_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
-{
-	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
-	struct snd_dma_buffer *buf = &substream->dma_buffer;
-	size_t size = IMX_SSI_DMABUF_SIZE;
-
-	buf->dev.type = SNDRV_DMA_TYPE_DEV;
-	buf->dev.dev = pcm->card->dev;
-	buf->private_data = NULL;
-	buf->area = dma_alloc_writecombine(pcm->card->dev, size,
-					   &buf->addr, GFP_KERNEL);
-	if (!buf->area)
-		return -ENOMEM;
-	buf->bytes = size;
-
-	return 0;
-}
-
-static u64 imx_pcm_dmamask = DMA_BIT_MASK(32);
-
-int imx_pcm_new(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_card *card = rtd->card->snd_card;
-	struct snd_pcm *pcm = rtd->pcm;
-	int ret = 0;
-
-	if (!card->dev->dma_mask)
-		card->dev->dma_mask = &imx_pcm_dmamask;
-	if (!card->dev->coherent_dma_mask)
-		card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
-	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream) {
-		ret = imx_pcm_preallocate_dma_buffer(pcm,
-			SNDRV_PCM_STREAM_PLAYBACK);
-		if (ret)
-			goto out;
-	}
-
-	if (pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream) {
-		ret = imx_pcm_preallocate_dma_buffer(pcm,
-			SNDRV_PCM_STREAM_CAPTURE);
-		if (ret)
-			goto out;
-	}
-
-out:
-	return ret;
-}
-EXPORT_SYMBOL_GPL(imx_pcm_new);
-
-void imx_pcm_free(struct snd_pcm *pcm)
-{
-	struct snd_pcm_substream *substream;
-	struct snd_dma_buffer *buf;
-	int stream;
-
-	for (stream = 0; stream < 2; stream++) {
-		substream = pcm->streams[stream].substream;
-		if (!substream)
-			continue;
-
-		buf = &substream->dma_buffer;
-		if (!buf->area)
-			continue;
-
-		dma_free_writecombine(pcm->card->dev, buf->bytes,
-				      buf->area, buf->addr);
-		buf->area = NULL;
-	}
-}
-EXPORT_SYMBOL_GPL(imx_pcm_free);
-
 static int imx_ssi_dai_probe(struct snd_soc_dai *dai)
 {
 	struct imx_ssi *ssi = dev_get_drvdata(dai->dev);
diff --git a/sound/soc/imx/imx-ssi.h b/sound/soc/imx/imx-ssi.h
index 1072dfb..5744e86 100644
--- a/sound/soc/imx/imx-ssi.h
+++ b/sound/soc/imx/imx-ssi.h
@@ -187,12 +187,7 @@
 
 #include <linux/dmaengine.h>
 #include <mach/dma.h>
-
-struct imx_pcm_dma_params {
-	int dma;
-	unsigned long dma_addr;
-	int burstsize;
-};
+#include "imx-pcm.h"
 
 struct imx_ssi {
 	struct platform_device *ac97_dev;
@@ -218,13 +213,4 @@ struct imx_ssi {
 	struct platform_device *soc_platform_pdev_fiq;
 };
 
-int snd_imx_pcm_mmap(struct snd_pcm_substream *substream, struct vm_area_struct *vma);
-int imx_pcm_new(struct snd_soc_pcm_runtime *rtd);
-void imx_pcm_free(struct snd_pcm *pcm);
-
-/*
- * Do not change this as the FIQ handler depends on this size
- */
-#define IMX_SSI_DMABUF_SIZE	(64 * 1024)
-
 #endif /* _IMX_SSI_H */
-- 
1.7.5.4
