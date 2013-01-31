From: voice.shen@atmel.com (Bo Shen)
Date: Thu, 31 Jan 2013 11:53:37 +0800
Subject: [PATCH 1/4] ASoC: atmel_pcm: make it buildable as module
In-Reply-To: <1359604420-15171-1-git-send-email-voice.shen@atmel.com>
References: <1359604420-15171-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1359604420-15171-2-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When build as module, it reports following error, using this patch
fix it

sound/soc/atmel/atmel-pcm-pdc.c:387: error: redefinition of 'atmel_pcm_pdc_platform_register'
sound/soc/atmel/atmel-pcm.h:95: note: previous definition of 'atmel_pcm_pdc_platform_register' was here
sound/soc/atmel/atmel-pcm-pdc.c:393: error: redefinition of 'atmel_pcm_pdc_platform_unregister'
sound/soc/atmel/atmel-pcm.h:99: note: previous definition of 'atmel_pcm_pdc_platform_unregister' was here

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 sound/soc/atmel/atmel-pcm.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/atmel/atmel-pcm.h b/sound/soc/atmel/atmel-pcm.h
index bb45d20..12ae814 100644
--- a/sound/soc/atmel/atmel-pcm.h
+++ b/sound/soc/atmel/atmel-pcm.h
@@ -88,7 +88,8 @@ void atmel_pcm_free(struct snd_pcm *pcm);
 int atmel_pcm_mmap(struct snd_pcm_substream *substream,
 		struct vm_area_struct *vma);
 
-#ifdef CONFIG_SND_ATMEL_SOC_PDC
+#if defined(CONFIG_SND_ATMEL_SOC_PDC) || \
+	defined(CONFIG_SND_ATMEL_SOC_PDC_MODULE)
 int atmel_pcm_pdc_platform_register(struct device *dev);
 void atmel_pcm_pdc_platform_unregister(struct device *dev);
 #else
@@ -101,7 +102,8 @@ static inline void atmel_pcm_pdc_platform_unregister(struct device *dev)
 }
 #endif
 
-#ifdef CONFIG_SND_ATMEL_SOC_DMA
+#if defined(CONFIG_SND_ATMEL_SOC_DMA) || \
+	defined(CONFIG_SND_ATMEL_SOC_DMA_MODULE)
 int atmel_pcm_dma_platform_register(struct device *dev);
 void atmel_pcm_dma_platform_unregister(struct device *dev);
 #else
-- 
1.7.9.5
