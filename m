From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 15 Nov 2013 13:54:10 -0700
Subject: [PATCH 15/31] ASoC: dmaengine: add custom DMA config to
 snd_dmaengine_pcm_config
In-Reply-To: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1384548866-13141-16-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Add fields to struct snd_dmaengine_pcm_config to allow custom:

- DMA channel names.

  This is useful when the default "tx" and "rx" channel names don't
  apply, for example if a HW module supports multiple channels, each
  having different DMA channel names. This is the case with the FIFOs
  in Tegra's AHUB. This new facility can replace
  SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME.

- DMA device

  This allows requesting DMA channels for a device other than the device
  which is registering the "PCM" driver. This is quite unusual, but is
  currently useful on Tegra. In much HW, and in Tegra20, each DAI HW
  module contains its own FIFOs which DMA writes to. However, in Tegra30,
  the DMA FIFOs were split out AHUB HW module, which then routes the data
  through a cross-bar, and into the DAI HW modules. However, the current
  ASoC driver structure does not expose this detail, and acts as if the
  FIFOs are still part of the DAI HW modules. Consequently, the "PCM"
  driver is registered with the DAI HW module, yet the DMA channels must
  be looked up in the AHUB HW module's device tree node. This new config
  field allows that to happen. Eventually, the Tegra drivers will be
  reworked to fully expose the AHUB, and this config field can be
  removed.

Cc: treding at nvidia.com
Cc: linux-tegra at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel at alsa-project.org
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This patch is part of a series with strong internal depdendencies. I'm
looking for an ack so that I can take the entire series through the Tegra
and arm-soc trees. The series will be part of a stable branch that can be
merged into other subsystems if needed to avoid/resolve dependencies.
---
 include/sound/dmaengine_pcm.h         | 6 ++++++
 sound/soc/soc-generic-dmaengine-pcm.c | 9 +++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index 15017311f2e9..87e9d481d7b6 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -114,6 +114,10 @@ void snd_dmaengine_pcm_set_config_from_dai_data(
  * @compat_filter_fn: Will be used as the filter function when requesting a
  *  channel for platforms which do not use devicetree. The filter parameter
  *  will be the DAI's DMA data.
+ * @dma_dev: If set, request DMA channel on this device rather than the DAI
+ *  device.
+ * @chan_names: If set, these custom DMA channel names will be requested at
+ *  registration time.
  * @pcm_hardware: snd_pcm_hardware struct to be used for the PCM.
  * @prealloc_buffer_size: Size of the preallocated audio buffer.
  *
@@ -130,6 +134,8 @@ struct snd_dmaengine_pcm_config {
 			struct snd_soc_pcm_runtime *rtd,
 			struct snd_pcm_substream *substream);
 	dma_filter_fn compat_filter_fn;
+	struct device *dma_dev;
+	const char *chan_names[SNDRV_PCM_STREAM_LAST + 1];
 
 	const struct snd_pcm_hardware *pcm_hardware;
 	unsigned int prealloc_buffer_size;
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index f7e65e1552ef..40e0943a06b8 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -285,7 +285,7 @@ static const char * const dmaengine_pcm_dma_channel_names[] = {
 };
 
 static int dmaengine_pcm_request_chan_of(struct dmaengine_pcm *pcm,
-					 struct device *dev)
+	struct device *dev, const struct snd_dmaengine_pcm_config *config)
 {
 	unsigned int i;
 	const char *name;
@@ -296,12 +296,17 @@ static int dmaengine_pcm_request_chan_of(struct dmaengine_pcm *pcm,
 	    !dev->of_node)
 		return 0;
 
+	if (config->dma_dev)
+		dev = config->dma_dev;
+
 	for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_CAPTURE;
 	     i++) {
 		if (pcm->flags & SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX)
 			name = "rx-tx";
 		else
 			name = dmaengine_pcm_dma_channel_names[i];
+		if (config->chan_names[i])
+			name = config->chan_names[i];
 		chan = dma_request_slave_channel_or_err(dev, name);
 		if (IS_ERR(chan)) {
 			if (PTR_ERR(pcm->chan[i]) == -EPROBE_DEFER)
@@ -352,7 +357,7 @@ int snd_dmaengine_pcm_register(struct device *dev,
 	pcm->config = config;
 	pcm->flags = flags;
 
-	ret = dmaengine_pcm_request_chan_of(pcm, dev);
+	ret = dmaengine_pcm_request_chan_of(pcm, dev, config);
 	if (ret)
 		goto err_free_pcm;
 
-- 
1.8.1.5
