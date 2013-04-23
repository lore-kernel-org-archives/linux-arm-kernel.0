From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Apr 2013 17:54:33 +0200
Subject: [PATCH] ASoC: don't call of_dma_request_slave_channel directly
In-Reply-To: <1366732475-479886-1-git-send-email-arnd@arndb.de>
References: <1366732475-479886-1-git-send-email-arnd@arndb.de>
Message-ID: <1366732475-479886-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The exported interface for device drivers is dma_request_slave_channel,
not of_dma_request_slave_channel. The former does not depend on device
tree but also works with ACPI and other interfaces providing an
abstraction for DMA channels.

This fixes link errors when building ALSA as a loadable module.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel at alsa-project.org
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 5fd5ed4..8ee9859 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -219,19 +219,20 @@ static const char * const dmaengine_pcm_dma_channel_names[] = {
 };
 
 static void dmaengine_pcm_request_chan_of(struct dmaengine_pcm *pcm,
-	struct device_node *of_node)
+	struct device *dev)
 {
 	unsigned int i;
+	struct device_node *of_node = dev->of_node;
 
 	if ((pcm->flags & SND_DMAENGINE_PCM_FLAG_NO_DT) || !of_node)
 		return;
 
 	if (pcm->flags & SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX) {
-		pcm->chan[0] = of_dma_request_slave_channel(of_node, "tx_rx");
+		pcm->chan[0] = dma_request_slave_channel(dev, "tx_rx");
 		pcm->chan[1] = pcm->chan[0];
 	} else {
 		for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_CAPTURE; i++) {
-			pcm->chan[i] = of_dma_request_slave_channel(of_node,
+			pcm->chan[i] = dma_request_slave_channel(dev,
 					dmaengine_pcm_dma_channel_names[i]);
 		}
 	}
@@ -255,7 +256,7 @@ int snd_dmaengine_pcm_register(struct device *dev,
 	pcm->config = config;
 	pcm->flags = flags;
 
-	dmaengine_pcm_request_chan_of(pcm, dev->of_node);
+	dmaengine_pcm_request_chan_of(pcm, dev);
 
 	if (flags & SND_DMAENGINE_PCM_FLAG_NO_RESIDUE)
 		return snd_soc_add_platform(dev, &pcm->platform,
-- 
1.8.1.2
