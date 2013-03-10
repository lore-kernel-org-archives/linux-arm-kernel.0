From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 10 Mar 2013 19:33:09 +0100
Subject: [PATCH 08/10] ASoC: dmaengine_pcm: Add open function for DT DMA
 request
In-Reply-To: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1362940391-8338-9-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a function to open a DMA PCM substream using devicetree data
provided via the client device node. The patch introduces a public
function and a private subfunction that is called by both open
functions.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 include/sound/dmaengine_pcm.h |  2 +
 sound/soc/soc-dmaengine-pcm.c | 89 ++++++++++++++++++++++++++++++++++---------
 2 files changed, 72 insertions(+), 19 deletions(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index b877334..358951a 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -43,6 +43,8 @@ snd_pcm_uframes_t snd_dmaengine_pcm_pointer_no_residue(struct snd_pcm_substream
 
 int snd_dmaengine_pcm_open(struct snd_pcm_substream *substream,
 	dma_filter_fn filter_fn, void *filter_data);
+int of_snd_dmaengine_pcm_open(struct snd_pcm_substream *substream,
+	struct device_node *client_node, const char *name);
 int snd_dmaengine_pcm_close(struct snd_pcm_substream *substream);
 
 struct dma_chan *snd_dmaengine_pcm_get_chan(struct snd_pcm_substream *substream);
diff --git a/sound/soc/soc-dmaengine-pcm.c b/sound/soc/soc-dmaengine-pcm.c
index 111b7d92..017b691 100644
--- a/sound/soc/soc-dmaengine-pcm.c
+++ b/sound/soc/soc-dmaengine-pcm.c
@@ -20,6 +20,8 @@
  */
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/of.h>
+#include <linux/of_dma.h>
 #include <linux/dmaengine.h>
 #include <linux/slab.h>
 #include <sound/pcm.h>
@@ -260,24 +262,21 @@ static int dmaengine_pcm_request_channel(struct dmaengine_pcm_runtime_data *prtd
 	return 0;
 }
 
-/**
- * snd_dmaengine_pcm_open - Open a dmaengine based PCM substream
- * @substream: PCM substream
- * @filter_fn: Filter function used to request the DMA channel
- * @filter_data: Data passed to the DMA filter function
- *
- * Returns 0 on success, a negative error code otherwise.
- *
- * This function will request a DMA channel using the passed filter function and
- * data. The function should usually be called from the pcm open callback.
- *
- * Note that this function will use private_data field of the substream's
- * runtime. So it is not availabe to your pcm driver implementation. If you need
- * to keep additional data attached to a substream use
- * snd_dmaengine_pcm_{set,get}_data.
- */
-int snd_dmaengine_pcm_open(struct snd_pcm_substream *substream,
-	dma_filter_fn filter_fn, void *filter_data)
+static int of_dmaengine_pcm_request_channel(
+		struct dmaengine_pcm_runtime_data *prtd, struct device_node *np,
+		const char *name)
+{
+	prtd->dma_chan = of_dma_request_slave_channel(np, name);
+
+	if (!prtd->dma_chan)
+		return -ENXIO;
+
+	return 0;
+}
+
+static int _snd_dmaengine_pcm_open(struct snd_pcm_substream *substream,
+		dma_filter_fn filter_fn, void *filter_data,
+		struct device_node *np, const char *slave_name)
 {
 	struct dmaengine_pcm_runtime_data *prtd;
 	int ret;
@@ -291,7 +290,11 @@ int snd_dmaengine_pcm_open(struct snd_pcm_substream *substream,
 	if (!prtd)
 		return -ENOMEM;
 
-	ret = dmaengine_pcm_request_channel(prtd, filter_fn, filter_data);
+	if (np)
+		ret = of_dmaengine_pcm_request_channel(prtd, np, slave_name);
+	else
+		ret = dmaengine_pcm_request_channel(prtd, filter_fn,
+						    filter_data);
 	if (ret < 0) {
 		kfree(prtd);
 		return ret;
@@ -301,9 +304,57 @@ int snd_dmaengine_pcm_open(struct snd_pcm_substream *substream,
 
 	return 0;
 }
+
+/**
+ * snd_dmaengine_pcm_open - Open a dmaengine based PCM substream
+ * @substream: PCM substream
+ * @filter_fn: Filter function used to request the DMA channel
+ * @filter_data: Data passed to the DMA filter function
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ *
+ * This function will request a DMA channel using the passed filter function and
+ * data. The function should usually be called from the pcm open callback.
+ *
+ * Note that this function will use private_data field of the substream's
+ * runtime. So it is not availabe to your pcm driver implementation. If you need
+ * to keep additional data attached to a substream use
+ * snd_dmaengine_pcm_{set,get}_data.
+ */
+int snd_dmaengine_pcm_open(struct snd_pcm_substream *substream,
+	dma_filter_fn filter_fn, void *filter_data)
+{
+	return _snd_dmaengine_pcm_open(substream, filter_fn, filter_data, NULL,
+					NULL);
+}
 EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_open);
 
 /**
+ * of_snd_dmaengine_pcm_open - Open a dmaengine based PCM substream using oftree data
+ * @substream: PCM substream
+ * @client_node: DMA client oftree node used to request a DMA channel
+ * @name: DMA request name
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ *
+ * This function will request a DMA channel using devicetree data.
+ *
+ * Note that this function will use private_data field of the substream's
+ * runtime. So it is not availabe to your pcm driver implementation. If you need
+ * to keep additional data attached to a substream use
+ * snd_dmaengine_pcm_{set,get}_data.
+ *
+ * Use the normal snd_dmaengine_pcm_close function to close the substream.
+ */
+int of_snd_dmaengine_pcm_open(struct snd_pcm_substream *substream,
+		struct device_node *client_node, const char *name)
+{
+	return _snd_dmaengine_pcm_open(substream, NULL, NULL, client_node,
+					name);
+}
+EXPORT_SYMBOL_GPL(of_snd_dmaengine_pcm_open);
+
+/**
  * snd_dmaengine_pcm_close - Close a dmaengine based PCM substream
  * @substream: PCM substream
  */
-- 
1.8.1.5
