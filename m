From: voice.shen@atmel.com (Bo Shen)
Date: Fri, 23 Nov 2012 14:14:15 +0800
Subject: [PATCH 1/3] ASoC: snd_dmaengine_pcm: add inline empty function
In-Reply-To: <1353651257-2476-1-git-send-email-voice.shen@atmel.com>
References: <1353651257-2476-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1353651257-2476-2-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As to atmel pcm driver support pdc and dma for audio transfer, which
will be used for audio transfer depends on the ssc capability.

If without these inline empty functions, when compile the driver, it will
give out following information. So, add these inline empty functions.
---<8---
sound/built-in.o: In function `atmel_pcm_hw_free':
last.c:(.text+0x20a84): undefined reference to `snd_dmaengine_pcm_get_data'
sound/built-in.o: In function `atmel_pcm_dma_prepare':
last.c:(.text+0x20adc): undefined reference to `snd_dmaengine_pcm_get_data'
sound/built-in.o: In function `atmel_pcm_hw_params':
last.c:(.text+0x20c1c): undefined reference to `snd_dmaengine_pcm_open'
last.c:(.text+0x20c40): undefined reference to `snd_dmaengine_pcm_set_data'
last.c:(.text+0x20c50): undefined reference to `snd_hwparams_to_dma_slave_config'
last.c:(.text+0x20ca0): undefined reference to `snd_dmaengine_pcm_get_chan'
last.c:(.text+0x20cd0): undefined reference to `snd_dmaengine_pcm_close'
last.c:(.text+0x20d00): undefined reference to `snd_dmaengine_pcm_get_chan'
sound/built-in.o: In function `atmel_pcm_dma_irq':
last.c:(.text+0x20ec0): undefined reference to `snd_dmaengine_pcm_get_data'
sound/built-in.o: In function `atmel_pcm_close':
last.c:(.text+0x20f90): undefined reference to `snd_dmaengine_pcm_get_data'
last.c:(.text+0x20f9c): undefined reference to `snd_dmaengine_pcm_close'
sound/built-in.o: In function `atmel_pcm_platform_register':
last.c:(.text+0x21078): undefined reference to `snd_dmaengine_pcm_trigger'
last.c:(.text+0x2107c): undefined reference to `snd_dmaengine_pcm_pointer_no_residue'
make: *** [vmlinux] Error 1
--->8---

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 include/sound/dmaengine_pcm.h |   53 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index b877334..58241e9 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -32,6 +32,7 @@ snd_pcm_substream_to_dma_direction(const struct snd_pcm_substream *substream)
 		return DMA_DEV_TO_MEM;
 }
 
+#ifdef CONFIG_SND_SOC_DMAENGINE_PCM
 void snd_dmaengine_pcm_set_data(struct snd_pcm_substream *substream, void *data);
 void *snd_dmaengine_pcm_get_data(struct snd_pcm_substream *substream);
 
@@ -46,5 +47,57 @@ int snd_dmaengine_pcm_open(struct snd_pcm_substream *substream,
 int snd_dmaengine_pcm_close(struct snd_pcm_substream *substream);
 
 struct dma_chan *snd_dmaengine_pcm_get_chan(struct snd_pcm_substream *substream);
+#else
+static inline void
+snd_dmaengine_pcm_set_data(struct snd_pcm_substream *substream, void *data)
+{
+}
+static inline void
+*snd_dmaengine_pcm_get_data(struct snd_pcm_substream *substream)
+{
+	return NULL;
+}
+
+static inline int
+snd_hwparams_to_dma_slave_config(const struct snd_pcm_substream *substream,
+		const struct snd_pcm_hw_params *params,
+		struct dma_slave_config *slave_config)
+{
+	return 0;
+}
+static inline int
+snd_dmaengine_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	return 0;
+}
+static inline snd_pcm_uframes_t
+snd_dmaengine_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	return 0;
+}
+static inline snd_pcm_uframes_t
+snd_dmaengine_pcm_pointer_no_residue(struct snd_pcm_substream *substream)
+{
+	return 0;
+}
+
+static inline int
+snd_dmaengine_pcm_open(struct snd_pcm_substream *substream,
+		dma_filter_fn filter_fn, void *filter_data)
+{
+	return 0;
+}
+static inline int
+snd_dmaengine_pcm_close(struct snd_pcm_substream *substream)
+{
+	return 0;
+}
+
+static inline struct dma_chan
+*snd_dmaengine_pcm_get_chan(struct snd_pcm_substream *substream)
+{
+	return NULL;
+}
+#endif
 
 #endif
-- 
1.7.9.5
