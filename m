From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:48:06 +0100
Subject: [PATCH 162/222] dw-hdmi-audio: try implementing ERR005174 to fix
 burbling audio
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1Wdebu-0007OC-Tc@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/dw-hdmi-audio.c | 35 +++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/imx-drm/dw-hdmi-audio.c b/drivers/staging/imx-drm/dw-hdmi-audio.c
index 05fe6024fe17..f70fe00f9c41 100644
--- a/drivers/staging/imx-drm/dw-hdmi-audio.c
+++ b/drivers/staging/imx-drm/dw-hdmi-audio.c
@@ -7,6 +7,7 @@
  *
  * Written and tested against the (alleged) DW HDMI Tx found in iMX6S.
  */
+#include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -68,6 +69,8 @@ enum {
 	HDMI_AHB_DMA_THRSLD = 0x3603,
 	HDMI_AHB_DMA_STRADDR0 = 0x3604,
 	HDMI_AHB_DMA_STPADDR0 = 0x3608,
+	HDMI_AHB_DMA_STAT = 0x3612,
+	HDMI_AHB_DMA_STAT_FULL = BIT(1),
 	HDMI_AHB_DMA_MASK = 0x3614,
 	HDMI_AHB_DMA_POL = 0x3615,
 	HDMI_AHB_DMA_CONF1 = 0x3616,
@@ -473,20 +476,40 @@ static int dw_hdmi_prepare(struct snd_pcm_substream *substream)
 static int dw_hdmi_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_dw_hdmi *dw = substream->private_data;
-	int ret = 0;
+	void __iomem *base = dw->data.base;
+	unsigned val[3];
+	unsigned timeout = 10000;
+	int ret = 0, i;
+	bool err005174;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
+		err005174 = dw->revision == 0x0a;
+		if (err005174) {
+			for (i = 2; i >= 0; i--) {
+				val[i] = readb_relaxed(base + HDMI_AUD_N1 + i);
+				writeb_relaxed(0, base + HDMI_AUD_N1 + i);
+			}
+		}
+
 		dw->buf_offset = 0;
 		dw->substream = substream;
 		dw_hdmi_start_dma(dw);
-		if (dw->revision == 0x0a) {
-			void __iomem *base = dw->data.base;
-			unsigned val;
 
-			val = readb_relaxed(base + HDMI_AUD_N1);
-			writeb_relaxed(val, base + HDMI_AUD_N1);
+		if (err005174) {
+			do {
+				if (readb_relaxed(base + HDMI_AHB_DMA_STAT) & HDMI_AHB_DMA_STAT_FULL)
+					break;
+				udelay(1);
+			} while (timeout--);
+
+			if (!(readb_relaxed(base + HDMI_AHB_DMA_STAT) & HDMI_AHB_DMA_STAT_FULL))
+				pr_info("timeout!\n");
+
+			for (i = 2; i >= 0; i--)
+				writeb_relaxed(val[i], base + HDMI_AUD_N1 + i);
 		}
+
 		substream->runtime->delay = substream->runtime->period_size;
 		break;
 
-- 
1.8.3.1
