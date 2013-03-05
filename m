From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 5 Mar 2013 20:24:01 +0800
Subject: [PATCH v2 09/12] ASoC: dmaengine_pcm: add
 snd_dmaengine_generic_pcm_open()
In-Reply-To: <1362486244-24593-1-git-send-email-shawn.guo@linaro.org>
References: <1362486244-24593-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1362486244-24593-10-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With generic DMA device tree binding and helper function
dma_request_slave_channel() in place, dmaengine_pcm should support
that in requesting DMA channel for users that support generic DMA
device tree binding.

Add a new API snd_dmaengine_generic_pcm_open() as the variant of
snd_dmaengine_pcm_open().  It takes DMA client struct device pointer
and slave channel name as arguments and calls generic DMA helper
dma_request_slave_channel() to request DMA channel from dmaengine.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel at alsa-project.org
---
Mark,

Please maintain a topic branch for the patch if it looks good to you.
It should be useful for any dmaengine_pcm user that is moving to
generic DMA device tree binding.

Thanks,
Shawn

 include/sound/dmaengine_pcm.h |    2 ++
 sound/soc/soc-dmaengine-pcm.c |   39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index b877334..452df15 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -43,6 +43,8 @@ snd_pcm_uframes_t snd_dmaengine_pcm_pointer_no_residue(struct snd_pcm_substream
 
 int snd_dmaengine_pcm_open(struct snd_pcm_substream *substream,
 	dma_filter_fn filter_fn, void *filter_data);
+int snd_dmaengine_generic_pcm_open(struct snd_pcm_substream *substream,
+				   struct device *dev, const char *name);
 int snd_dmaengine_pcm_close(struct snd_pcm_substream *substream);
 
 struct dma_chan *snd_dmaengine_pcm_get_chan(struct snd_pcm_substream *substream);
diff --git a/sound/soc/soc-dmaengine-pcm.c b/sound/soc/soc-dmaengine-pcm.c
index 111b7d92..970eb2b 100644
--- a/sound/soc/soc-dmaengine-pcm.c
+++ b/sound/soc/soc-dmaengine-pcm.c
@@ -304,6 +304,45 @@ int snd_dmaengine_pcm_open(struct snd_pcm_substream *substream,
 EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_open);
 
 /**
+ * snd_dmaengine_generic_pcm_open - Open a dmaengine based PCM substream
+ * @substream: PCM substream
+ * @dev: pointer to DMA client device structure
+ * @name: DMA slave channel name
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ *
+ * This function is a variant of snd_dmaengine_pcm_open(). It takes different
+ * parameters and calls generic DMA helper dma_request_slave_channel() to
+ * request a DMA channel from dmaengine.
+ */
+int snd_dmaengine_generic_pcm_open(struct snd_pcm_substream *substream,
+				   struct device *dev, const char *name)
+{
+	struct dmaengine_pcm_runtime_data *prtd;
+	int ret;
+
+	ret = snd_pcm_hw_constraint_integer(substream->runtime,
+					    SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0)
+		return ret;
+
+	prtd = kzalloc(sizeof(*prtd), GFP_KERNEL);
+	if (!prtd)
+		return -ENOMEM;
+
+	prtd->dma_chan = dma_request_slave_channel(dev, name);
+	if (!prtd->dma_chan) {
+		kfree(prtd);
+		return -ENXIO;
+	}
+
+	substream->runtime->private_data = prtd;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_dmaengine_generic_pcm_open);
+
+/**
  * snd_dmaengine_pcm_close - Close a dmaengine based PCM substream
  * @substream: PCM substream
  */
-- 
1.7.9.5
