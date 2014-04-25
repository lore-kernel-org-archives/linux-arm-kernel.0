From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:46:21 +0100
Subject: [PATCH 159/222] dw-hdmi-audio: better hardware position tracking
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeaD-0007Nu-P3@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/dw-hdmi-audio.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/imx-drm/dw-hdmi-audio.c b/drivers/staging/imx-drm/dw-hdmi-audio.c
index e7d41249c817..9c27df0112d2 100644
--- a/drivers/staging/imx-drm/dw-hdmi-audio.c
+++ b/drivers/staging/imx-drm/dw-hdmi-audio.c
@@ -238,6 +238,11 @@ static void dw_hdmi_start_dma(struct snd_dw_hdmi *dw)
 
 	writeb_relaxed((u8)~HDMI_AHB_DMA_MASK_DONE, base + HDMI_AHB_DMA_MASK);
 	writeb(HDMI_AHB_DMA_START_START, base + HDMI_AHB_DMA_START);
+
+	offset += period;
+	if (offset >= dw->buf_size)
+		offset = 0;
+	dw->buf_offset = offset;
 }
 
 static void dw_hdmi_stop_dma(struct snd_dw_hdmi *dw)
@@ -263,10 +268,6 @@ static irqreturn_t snd_dw_hdmi_irq(int irq, void *data)
 
 	substream = dw->substream;
 	if (stat & HDMI_IH_AHBDMAAUD_STAT0_DONE && substream) {
-		dw->buf_offset += dw->buf_period;
-		if (dw->buf_offset >= dw->buf_size)
-			dw->buf_offset = 0;
-
 		snd_pcm_period_elapsed(substream);
 		if (dw->substream)
 			dw_hdmi_start_dma(dw);
@@ -427,6 +428,7 @@ static int dw_hdmi_trigger(struct snd_pcm_substream *substream, int cmd)
 		dw->buf_offset = 0;
 		dw->substream = substream;
 		dw_hdmi_start_dma(dw);
+		substream->runtime->delay = substream->runtime->period_size;
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
-- 
1.8.3.1
