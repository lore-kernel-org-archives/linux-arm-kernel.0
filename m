From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 15 Nov 2013 13:54:09 -0700
Subject: [PATCH 14/31] ASoC: dmaengine: support deferred probe for DMA channels
In-Reply-To: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1384548866-13141-15-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Enhance dmaengine_pcm_request_chan_of() to support deferred probe for
DMA channels, by using the new dma_request_slave_channel_or_err() API.
This prevents snd_dmaengine_pcm_register() from succeeding without
acquiring DMA channels due to the relevant DMA controller not yet being
registered.

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
 sound/soc/soc-generic-dmaengine-pcm.c | 77 +++++++++++++++++++++++++----------
 1 file changed, 55 insertions(+), 22 deletions(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index cbc9c96ce1f4..f7e65e1552ef 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -284,24 +284,52 @@ static const char * const dmaengine_pcm_dma_channel_names[] = {
 	[SNDRV_PCM_STREAM_CAPTURE] = "rx",
 };
 
-static void dmaengine_pcm_request_chan_of(struct dmaengine_pcm *pcm,
-	struct device *dev)
+static int dmaengine_pcm_request_chan_of(struct dmaengine_pcm *pcm,
+					 struct device *dev)
 {
 	unsigned int i;
+	const char *name;
+	struct dma_chan *chan;
 
 	if ((pcm->flags & (SND_DMAENGINE_PCM_FLAG_NO_DT |
 			   SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME)) ||
 	    !dev->of_node)
-		return;
+		return 0;
+
+	for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_CAPTURE;
+	     i++) {
+		if (pcm->flags & SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX)
+			name = "rx-tx";
+		else
+			name = dmaengine_pcm_dma_channel_names[i];
+		chan = dma_request_slave_channel_or_err(dev, name);
+		if (IS_ERR(chan)) {
+			if (PTR_ERR(pcm->chan[i]) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+			pcm->chan[i] = NULL;
+		} else
+			pcm->chan[i] = chan;
+		if (pcm->flags & SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX)
+			break;
+	}
 
-	if (pcm->flags & SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX) {
-		pcm->chan[0] = dma_request_slave_channel(dev, "rx-tx");
+	if (pcm->flags & SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX)
 		pcm->chan[1] = pcm->chan[0];
-	} else {
-		for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_CAPTURE; i++) {
-			pcm->chan[i] = dma_request_slave_channel(dev,
-					dmaengine_pcm_dma_channel_names[i]);
-		}
+
+	return 0;
+}
+
+static void dmaengine_pcm_release_chan(struct dmaengine_pcm *pcm)
+{
+	unsigned int i;
+
+	for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_CAPTURE;
+	     i++) {
+		if (!pcm->chan[i])
+			continue;
+		dma_release_channel(pcm->chan[i]);
+		if (pcm->flags & SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX)
+			break;
 	}
 }
 
@@ -315,6 +343,7 @@ int snd_dmaengine_pcm_register(struct device *dev,
 	const struct snd_dmaengine_pcm_config *config, unsigned int flags)
 {
 	struct dmaengine_pcm *pcm;
+	int ret;
 
 	pcm = kzalloc(sizeof(*pcm), GFP_KERNEL);
 	if (!pcm)
@@ -323,14 +352,26 @@ int snd_dmaengine_pcm_register(struct device *dev,
 	pcm->config = config;
 	pcm->flags = flags;
 
-	dmaengine_pcm_request_chan_of(pcm, dev);
+	ret = dmaengine_pcm_request_chan_of(pcm, dev);
+	if (ret)
+		goto err_free_pcm;
 
 	if (flags & SND_DMAENGINE_PCM_FLAG_NO_RESIDUE)
-		return snd_soc_add_platform(dev, &pcm->platform,
+		ret = snd_soc_add_platform(dev, &pcm->platform,
 				&dmaengine_no_residue_pcm_platform);
 	else
-		return snd_soc_add_platform(dev, &pcm->platform,
+		ret = snd_soc_add_platform(dev, &pcm->platform,
 				&dmaengine_pcm_platform);
+	if (ret)
+		goto err_free_dma;
+
+	return 0;
+
+err_free_dma:
+	dmaengine_pcm_release_chan(pcm);
+err_free_pcm:
+	kfree(pcm);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_register);
 
@@ -345,7 +386,6 @@ void snd_dmaengine_pcm_unregister(struct device *dev)
 {
 	struct snd_soc_platform *platform;
 	struct dmaengine_pcm *pcm;
-	unsigned int i;
 
 	platform = snd_soc_lookup_platform(dev);
 	if (!platform)
@@ -353,15 +393,8 @@ void snd_dmaengine_pcm_unregister(struct device *dev)
 
 	pcm = soc_platform_to_pcm(platform);
 
-	for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_CAPTURE; i++) {
-		if (pcm->chan[i]) {
-			dma_release_channel(pcm->chan[i]);
-			if (pcm->flags & SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX)
-				break;
-		}
-	}
-
 	snd_soc_remove_platform(platform);
+	dmaengine_pcm_release_chan(pcm);
 	kfree(pcm);
 }
 EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_unregister);
-- 
1.8.1.5
