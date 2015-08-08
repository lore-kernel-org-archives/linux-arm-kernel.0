From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 08 Aug 2015 17:10:21 +0100
Subject: [PATCH 4/9] drm: bridge/dw_hdmi-ahb-audio: allow larger buffer sizes
In-Reply-To: <20150808160936.GN7557@n2100.arm.linux.org.uk>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZO6hR-0003NE-Rq@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With multichannel audio, we need to allow larger buffer sizes to avoid
XRUNs during playback.  Push the buffer size up to 1024K, but as we
maintain two buffers, ensure that the vmalloc buffer does not exceed
the userspace buffer size.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.c b/drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.c
index 3a8f32e04b63..4b537f9ce8f0 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.c
@@ -312,7 +312,7 @@ static struct snd_pcm_hardware dw_hdmi_hw = {
 		 SNDRV_PCM_RATE_192000,
 	.channels_min = 2,
 	.channels_max = 8,
-	.buffer_bytes_max = 64 * 1024,
+	.buffer_bytes_max = 1024 * 1024,
 	.period_bytes_min = 256,
 	.period_bytes_max = 8192,	/* ERR004323: must limit to 8k */
 	.periods_min = 2,
@@ -337,7 +337,15 @@ static int dw_hdmi_open(struct snd_pcm_substream *substream)
 	if (ret < 0)
 		return ret;
 
-	ret = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
+	ret = snd_pcm_hw_constraint_integer(runtime,
+					    SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0)
+		return ret;
+
+	/* Limit the buffer size to the size of the preallocated buffer */
+	ret = snd_pcm_hw_constraint_minmax(runtime,
+					   SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
+					   0, substream->dma_buffer.bytes);
 	if (ret < 0)
 		return ret;
 
@@ -387,6 +395,7 @@ static int dw_hdmi_hw_free(struct snd_pcm_substream *substream)
 static int dw_hdmi_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
+	/* Allocate the PCM runtime buffer, which is exposed to userspace. */
 	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
 						params_buffer_bytes(params));
 }
@@ -552,8 +561,12 @@ static int snd_dw_hdmi_probe(struct platform_device *pdev)
 	strlcpy(pcm->name, DRIVER_NAME, sizeof(pcm->name));
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_dw_hdmi_ops);
 
+	/*
+	 * To support 8-channel 96kHz audio reliably, we need 512k
+	 * to satisfy alsa with our restricted period (ERR004323).
+	 */
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-			dev, 64 * 1024, 64 * 1024);
+			dev, 128 * 1024, 1024 * 1024);
 
 	ret = snd_card_register(card);
 	if (ret < 0)
-- 
2.1.0
