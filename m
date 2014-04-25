From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:48:01 +0100
Subject: [PATCH 161/222] dw-hdmi-audio: try to fix burbling audio
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1Wdebp-0007O8-Pu@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/dw-hdmi-audio.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/staging/imx-drm/dw-hdmi-audio.c b/drivers/staging/imx-drm/dw-hdmi-audio.c
index b2595b0a82ce..05fe6024fe17 100644
--- a/drivers/staging/imx-drm/dw-hdmi-audio.c
+++ b/drivers/staging/imx-drm/dw-hdmi-audio.c
@@ -61,6 +61,7 @@ enum {
 	HDMI_REVISION_ID = 0x0001,
 	HDMI_IH_AHBDMAAUD_STAT0 = 0x0109,
 	HDMI_IH_MUTE_AHBDMAAUD_STAT0 = 0x0189,
+	HDMI_AUD_N1 = 0x3200,
 	HDMI_AHB_DMA_CONF0 = 0x3600,
 	HDMI_AHB_DMA_START = 0x3601,
 	HDMI_AHB_DMA_STOP = 0x3602,
@@ -479,6 +480,13 @@ static int dw_hdmi_trigger(struct snd_pcm_substream *substream, int cmd)
 		dw->buf_offset = 0;
 		dw->substream = substream;
 		dw_hdmi_start_dma(dw);
+		if (dw->revision == 0x0a) {
+			void __iomem *base = dw->data.base;
+			unsigned val;
+
+			val = readb_relaxed(base + HDMI_AUD_N1);
+			writeb_relaxed(val, base + HDMI_AUD_N1);
+		}
 		substream->runtime->delay = substream->runtime->period_size;
 		break;
 
-- 
1.8.3.1
