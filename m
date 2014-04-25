From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:48:12 +0100
Subject: [PATCH 163/222] dw-hdmi-audio: another attempt at fixing burbling
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1Wdec0-0007OG-0a@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/dw-hdmi-audio.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/imx-drm/dw-hdmi-audio.c b/drivers/staging/imx-drm/dw-hdmi-audio.c
index f70fe00f9c41..185c1de2c8ef 100644
--- a/drivers/staging/imx-drm/dw-hdmi-audio.c
+++ b/drivers/staging/imx-drm/dw-hdmi-audio.c
@@ -63,6 +63,7 @@ enum {
 	HDMI_IH_AHBDMAAUD_STAT0 = 0x0109,
 	HDMI_IH_MUTE_AHBDMAAUD_STAT0 = 0x0189,
 	HDMI_AUD_N1 = 0x3200,
+	HDMI_AUD_CTS1 = 0x3203,
 	HDMI_AHB_DMA_CONF0 = 0x3600,
 	HDMI_AHB_DMA_START = 0x3601,
 	HDMI_AHB_DMA_STOP = 0x3602,
@@ -477,8 +478,7 @@ static int dw_hdmi_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_dw_hdmi *dw = substream->private_data;
 	void __iomem *base = dw->data.base;
-	unsigned val[3];
-	unsigned timeout = 10000;
+	unsigned n[3], cts[3];
 	int ret = 0, i;
 	bool err005174;
 
@@ -486,9 +486,11 @@ static int dw_hdmi_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_START:
 		err005174 = dw->revision == 0x0a;
 		if (err005174) {
-			for (i = 2; i >= 0; i--) {
-				val[i] = readb_relaxed(base + HDMI_AUD_N1 + i);
+			for (i = 2; i >= 1; i--) {
+				n[i] = readb_relaxed(base + HDMI_AUD_N1 + i);
+				cts[i] = readb_relaxed(base + HDMI_AUD_CTS1 + i);
 				writeb_relaxed(0, base + HDMI_AUD_N1 + i);
+				writeb_relaxed(0, base + HDMI_AUD_CTS1 + i);
 			}
 		}
 
@@ -497,17 +499,10 @@ static int dw_hdmi_trigger(struct snd_pcm_substream *substream, int cmd)
 		dw_hdmi_start_dma(dw);
 
 		if (err005174) {
-			do {
-				if (readb_relaxed(base + HDMI_AHB_DMA_STAT) & HDMI_AHB_DMA_STAT_FULL)
-					break;
-				udelay(1);
-			} while (timeout--);
-
-			if (!(readb_relaxed(base + HDMI_AHB_DMA_STAT) & HDMI_AHB_DMA_STAT_FULL))
-				pr_info("timeout!\n");
-
-			for (i = 2; i >= 0; i--)
-				writeb_relaxed(val[i], base + HDMI_AUD_N1 + i);
+			for (i = 2; i >= 1; i--)
+				writeb_relaxed(cts[i], base + HDMI_AUD_CTS1 + i);
+			for (i = 2; i >= 1; i--)
+				writeb_relaxed(n[i], base + HDMI_AUD_N1 + i);
 		}
 
 		substream->runtime->delay = substream->runtime->period_size;
-- 
1.8.3.1
