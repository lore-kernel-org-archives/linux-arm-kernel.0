From: arnaud.pouliquen@st.com (Arnaud Pouliquen)
Date: Mon, 23 Jan 2017 17:32:23 +0100
Subject: [PATCH 5/7] ASoC: dmaengine_pcm: add copy support
In-Reply-To: <1485189145-29576-1-git-send-email-arnaud.pouliquen@st.com>
References: <1485189145-29576-1-git-send-email-arnaud.pouliquen@st.com>
Message-ID: <1485189145-29576-6-git-send-email-arnaud.pouliquen@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: olivier moysan <olivier.moysan@st.com>

Add copy support in pcm damengine operations.
This allows to pre/post process samples (apply shift, mask ...)
for playback/capture to support hardware contrains.

Signed-off-by: olivier moysan <omoysan.stm32@gmail.com>
Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 include/sound/dmaengine_pcm.h         |  3 +++
 sound/soc/soc-generic-dmaengine-pcm.c | 37 +++++++++++++++++++++++++++++++++--
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index 67be244..9d7bce8 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -137,6 +137,9 @@ struct snd_dmaengine_pcm_config {
 	int (*prepare_slave_config)(struct snd_pcm_substream *substream,
 			struct snd_pcm_hw_params *params,
 			struct dma_slave_config *slave_config);
+	int (*copy)(struct snd_pcm_substream *substream, int channel,
+		    snd_pcm_uframes_t pos,
+		    void __user *buf, snd_pcm_uframes_t count);
 	struct dma_chan *(*compat_request_channel)(
 			struct snd_soc_pcm_runtime *rtd,
 			struct snd_pcm_substream *substream);
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 6cef397..bd8332ce 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -329,6 +329,16 @@ static snd_pcm_uframes_t dmaengine_pcm_pointer(
 		return snd_dmaengine_pcm_pointer(substream);
 }
 
+int dmaengine_pcm_copy(struct snd_pcm_substream *substream, int channel,
+		       snd_pcm_uframes_t pos, void __user *buf,
+		       snd_pcm_uframes_t count)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct dmaengine_pcm *pcm = soc_platform_to_pcm(rtd->platform);
+
+	return pcm->config->copy(substream, channel, pos, buf, count);
+}
+
 static const struct snd_pcm_ops dmaengine_pcm_ops = {
 	.open		= dmaengine_pcm_open,
 	.close		= snd_dmaengine_pcm_close,
@@ -339,6 +349,17 @@ static snd_pcm_uframes_t dmaengine_pcm_pointer(
 	.pointer	= dmaengine_pcm_pointer,
 };
 
+static const struct snd_pcm_ops dmaengine_pcm_ops_with_cpy = {
+	.open		= dmaengine_pcm_open,
+	.close		= snd_dmaengine_pcm_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= dmaengine_pcm_hw_params,
+	.hw_free	= snd_pcm_lib_free_pages,
+	.trigger	= snd_dmaengine_pcm_trigger,
+	.pointer	= dmaengine_pcm_pointer,
+	.copy		= dmaengine_pcm_copy,
+};
+
 static const struct snd_soc_platform_driver dmaengine_pcm_platform = {
 	.component_driver = {
 		.probe_order = SND_SOC_COMP_ORDER_LATE,
@@ -347,6 +368,14 @@ static snd_pcm_uframes_t dmaengine_pcm_pointer(
 	.pcm_new	= dmaengine_pcm_new,
 };
 
+static const struct snd_soc_platform_driver dmaengine_pcm_platform_with_cpy = {
+	.component_driver = {
+		.probe_order = SND_SOC_COMP_ORDER_LATE,
+	},
+	.ops		= &dmaengine_pcm_ops_with_cpy,
+	.pcm_new	= dmaengine_pcm_new,
+};
+
 static const char * const dmaengine_pcm_dma_channel_names[] = {
 	[SNDRV_PCM_STREAM_PLAYBACK] = "tx",
 	[SNDRV_PCM_STREAM_CAPTURE] = "rx",
@@ -439,8 +468,12 @@ int snd_dmaengine_pcm_register(struct device *dev,
 	if (ret)
 		goto err_free_dma;
 
-	ret = snd_soc_add_platform(dev, &pcm->platform,
-		&dmaengine_pcm_platform);
+	if (config && config->copy)
+		ret = snd_soc_add_platform(dev, &pcm->platform,
+					   &dmaengine_pcm_platform_with_cpy);
+	else
+		ret = snd_soc_add_platform(dev, &pcm->platform,
+					   &dmaengine_pcm_platform);
 	if (ret)
 		goto err_free_dma;
 
-- 
1.9.1
