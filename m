From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Fri, 31 Aug 2012 18:20:57 +0530
Subject: [PATCH 1/3] ASoC: Davinci: McASP: add support new McASP IP Variant
In-Reply-To: <1346417459-30042-1-git-send-email-gururaja.hebbar@ti.com>
References: <1346417459-30042-1-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <1346417459-30042-2-git-send-email-gururaja.hebbar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OMAP2+ variant of McASP is different from Davinci variant w.r.to
some register offset.

Changes
- Add new MCASP_VERSION_3 to identify new variant. New DT compatible
  "ti,omap2-mcasp-audio" to identify version 3 controller.
- The register offsets are handled depending on the version.

Note:
    DMA parameters (dma fifo offset) are not updated and will be done later.

Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
---
:100644 100644 e6148ec... 374e145... M	Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
:100644 100644 79c26aa... d0c5825... M	include/linux/platform_data/davinci_asp.h
:100644 100644 c3eae1d... bb6ae9d... M	sound/soc/davinci/davinci-mcasp.c
 .../bindings/sound/davinci-mcasp-audio.txt         |    1 +
 include/linux/platform_data/davinci_asp.h          |    1 +
 sound/soc/davinci/davinci-mcasp.c                  |   71 ++++++++++++++++----
 3 files changed, 60 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
index e6148ec..374e145 100644
--- a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
+++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible :
 	"ti,dm646x-mcasp-audio"	: for DM646x platforms
 	"ti,da830-mcasp-audio"	: for both DA830 & DA850 platforms
+	"ti,omap2-mcasp-audio"	: for OMAP2 platforms (TI81xx, AM33xx)
 
 - reg : Should contain McASP registers offset and length
 - interrupts : Interrupt number for McASP
diff --git a/include/linux/platform_data/davinci_asp.h b/include/linux/platform_data/davinci_asp.h
index 79c26aa..d0c5825 100644
--- a/include/linux/platform_data/davinci_asp.h
+++ b/include/linux/platform_data/davinci_asp.h
@@ -87,6 +87,7 @@ struct snd_platform_data {
 enum {
 	MCASP_VERSION_1 = 0,	/* DM646x */
 	MCASP_VERSION_2,	/* DA8xx/OMAPL1x */
+	MCASP_VERSION_3,        /* TI81xx/AM33xx */
 };
 
 enum mcbsp_clk_input_pin {
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index c3eae1d..bb6ae9d 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -111,6 +111,10 @@
 #define DAVINCI_MCASP_WFIFOSTS		(0x1014)
 #define DAVINCI_MCASP_RFIFOCTL		(0x1018)
 #define DAVINCI_MCASP_RFIFOSTS		(0x101C)
+#define MCASP_VER3_WFIFOCTL		(0x1000)
+#define MCASP_VER3_WFIFOSTS		(0x1004)
+#define MCASP_VER3_RFIFOCTL		(0x1008)
+#define MCASP_VER3_RFIFOSTS		(0x100C)
 
 /*
  * DAVINCI_MCASP_PWREMUMGT_REG - Power Down and Emulation Management
@@ -384,18 +388,32 @@ static void davinci_mcasp_start(struct davinci_audio_dev *dev, int stream)
 {
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		if (dev->txnumevt) {	/* enable FIFO */
-			mcasp_clr_bits(dev->base + DAVINCI_MCASP_WFIFOCTL,
+			if (dev->version == MCASP_VERSION_3) {
+				mcasp_clr_bits(dev->base + MCASP_VER3_WFIFOCTL,
 								FIFO_ENABLE);
-			mcasp_set_bits(dev->base + DAVINCI_MCASP_WFIFOCTL,
+				mcasp_set_bits(dev->base + MCASP_VER3_WFIFOCTL,
 								FIFO_ENABLE);
+			} else {
+				mcasp_clr_bits(dev->base +
+					DAVINCI_MCASP_WFIFOCTL,	FIFO_ENABLE);
+				mcasp_set_bits(dev->base +
+					DAVINCI_MCASP_WFIFOCTL,	FIFO_ENABLE);
+			}
 		}
 		mcasp_start_tx(dev);
 	} else {
 		if (dev->rxnumevt) {	/* enable FIFO */
-			mcasp_clr_bits(dev->base + DAVINCI_MCASP_RFIFOCTL,
+			if (dev->version == MCASP_VERSION_3) {
+				mcasp_clr_bits(dev->base + MCASP_VER3_RFIFOCTL,
 								FIFO_ENABLE);
-			mcasp_set_bits(dev->base + DAVINCI_MCASP_RFIFOCTL,
+				mcasp_set_bits(dev->base + MCASP_VER3_RFIFOCTL,
 								FIFO_ENABLE);
+			} else {
+				mcasp_clr_bits(dev->base +
+					DAVINCI_MCASP_RFIFOCTL,	FIFO_ENABLE);
+				mcasp_set_bits(dev->base +
+					DAVINCI_MCASP_RFIFOCTL,	FIFO_ENABLE);
+			}
 		}
 		mcasp_start_rx(dev);
 	}
@@ -416,14 +434,24 @@ static void mcasp_stop_tx(struct davinci_audio_dev *dev)
 static void davinci_mcasp_stop(struct davinci_audio_dev *dev, int stream)
 {
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		if (dev->txnumevt)	/* disable FIFO */
-			mcasp_clr_bits(dev->base + DAVINCI_MCASP_WFIFOCTL,
+		if (dev->txnumevt) {	/* disable FIFO */
+			if (dev->version == MCASP_VERSION_3)
+				mcasp_clr_bits(dev->base + MCASP_VER3_WFIFOCTL,
 								FIFO_ENABLE);
+			else
+				mcasp_clr_bits(dev->base +
+					DAVINCI_MCASP_WFIFOCTL,	FIFO_ENABLE);
+		}
 		mcasp_stop_tx(dev);
 	} else {
-		if (dev->rxnumevt)	/* disable FIFO */
-			mcasp_clr_bits(dev->base + DAVINCI_MCASP_RFIFOCTL,
+		if (dev->rxnumevt) {	/* disable FIFO */
+			if (dev->version == MCASP_VERSION_3)
+				mcasp_clr_bits(dev->base + MCASP_VER3_RFIFOCTL,
 								FIFO_ENABLE);
+			else
+				mcasp_clr_bits(dev->base +
+					DAVINCI_MCASP_RFIFOCTL,	FIFO_ENABLE);
+		}
 		mcasp_stop_rx(dev);
 	}
 }
@@ -622,20 +650,33 @@ static void davinci_hw_common_param(struct davinci_audio_dev *dev, int stream)
 		if (dev->txnumevt * tx_ser > 64)
 			dev->txnumevt = 1;
 
-		mcasp_mod_bits(dev->base + DAVINCI_MCASP_WFIFOCTL, tx_ser,
+		if (dev->version == MCASP_VERSION_3) {
+			mcasp_mod_bits(dev->base + MCASP_VER3_WFIFOCTL, tx_ser,
 								NUMDMA_MASK);
-		mcasp_mod_bits(dev->base + DAVINCI_MCASP_WFIFOCTL,
+			mcasp_mod_bits(dev->base + MCASP_VER3_WFIFOCTL,
+				((dev->txnumevt * tx_ser) << 8), NUMEVT_MASK);
+		} else {
+			mcasp_mod_bits(dev->base + DAVINCI_MCASP_WFIFOCTL,
+							tx_ser,	NUMDMA_MASK);
+			mcasp_mod_bits(dev->base + DAVINCI_MCASP_WFIFOCTL,
 				((dev->txnumevt * tx_ser) << 8), NUMEVT_MASK);
+		}
 	}
 
 	if (dev->rxnumevt && stream == SNDRV_PCM_STREAM_CAPTURE) {
 		if (dev->rxnumevt * rx_ser > 64)
 			dev->rxnumevt = 1;
-
-		mcasp_mod_bits(dev->base + DAVINCI_MCASP_RFIFOCTL, rx_ser,
+		if (dev->version == MCASP_VERSION_3) {
+			mcasp_mod_bits(dev->base + MCASP_VER3_RFIFOCTL, rx_ser,
 								NUMDMA_MASK);
-		mcasp_mod_bits(dev->base + DAVINCI_MCASP_RFIFOCTL,
+			mcasp_mod_bits(dev->base + MCASP_VER3_RFIFOCTL,
 				((dev->rxnumevt * rx_ser) << 8), NUMEVT_MASK);
+		} else {
+			mcasp_mod_bits(dev->base + DAVINCI_MCASP_RFIFOCTL,
+							rx_ser,	NUMDMA_MASK);
+			mcasp_mod_bits(dev->base + DAVINCI_MCASP_RFIFOCTL,
+				((dev->rxnumevt * rx_ser) << 8), NUMEVT_MASK);
+		}
 	}
 }
 
@@ -874,6 +915,10 @@ static const struct of_device_id mcasp_dt_ids[] = {
 		.compatible = "ti,da830-mcasp-audio",
 		.data = (void *)MCASP_VERSION_2,
 	},
+	{
+		.compatible = "ti,omap2-mcasp-audio",
+		.data = (void *)MCASP_VERSION_3,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mcasp_dt_ids);
-- 
1.7.1
