From: voice.shen@atmel.com (Bo Shen)
Date: Wed, 11 Jun 2014 18:14:40 +0800
Subject: [PATCH v2 2/4] ASoC: atmel_ssc_dai: enable fslen extension feature
In-Reply-To: <1402481682-9811-1-git-send-email-voice.shen@atmel.com>
References: <1402481682-9811-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1402481682-9811-3-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When SSC work as master, it will generate the frame sync signal.
On old SoCs, it only supports frame sync length less or equal to
16bits, on newer SoCs, it supports frame sync length extension,
which can support frame size larger than 16 bits.
So, add this to make it supports playback 24/32 bits audio clips.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
Changes in v2:
  - Add comments for the fslen extension bits.

 include/linux/atmel-ssc.h       | 12 ++++++++++++
 sound/soc/atmel/atmel_ssc_dai.c | 34 ++++++++++++++++++----------------
 2 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/include/linux/atmel-ssc.h b/include/linux/atmel-ssc.h
index e8dd408..7c0f654 100644
--- a/include/linux/atmel-ssc.h
+++ b/include/linux/atmel-ssc.h
@@ -72,6 +72,12 @@ void ssc_free(struct ssc_device *ssc);
 #define SSC_RFMR_DATNB_OFFSET			 8
 #define SSC_RFMR_FSEDGE_SIZE			 1
 #define SSC_RFMR_FSEDGE_OFFSET			24
+/*
+ * The FSLEN_EXT exist on at91sam9rl, at91sam9g10,
+ * at91sam9g20, and at91sam9g45 and newer SoCs
+ */
+#define SSC_RFMR_FSLEN_EXT_SIZE			 4
+#define SSC_RFMR_FSLEN_EXT_OFFSET		28
 #define SSC_RFMR_FSLEN_SIZE			 4
 #define SSC_RFMR_FSLEN_OFFSET			16
 #define SSC_RFMR_FSOS_SIZE			 4
@@ -110,6 +116,12 @@ void ssc_free(struct ssc_device *ssc);
 #define SSC_TFMR_FSDEN_OFFSET			23
 #define SSC_TFMR_FSEDGE_SIZE			 1
 #define SSC_TFMR_FSEDGE_OFFSET			24
+/*
+ * The FSLEN_EXT exist on at91sam9rl, at91sam9g10,
+ * at91sam9g20, and at91sam9g45 and newer SoCs
+ */
+#define SSC_TFMR_FSLEN_EXT_SIZE			 4
+#define SSC_TFMR_FSLEN_EXT_OFFSET		28
 #define SSC_TFMR_FSLEN_SIZE			 4
 #define SSC_TFMR_FSLEN_OFFSET			16
 #define SSC_TFMR_FSOS_SIZE			 3
diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index de433cfd..f403f39 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -347,6 +347,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 	u32 tfmr, rfmr, tcmr, rcmr;
 	int start_event;
 	int ret;
+	int fslen, fslen_ext;
 
 	/*
 	 * Currently, there is only one set of dma params for
@@ -388,18 +389,6 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/*
-	 * The SSC only supports up to 16-bit samples in I2S format, due
-	 * to the size of the Frame Mode Register FSLEN field.
-	 */
-	if ((ssc_p->daifmt & SND_SOC_DAIFMT_FORMAT_MASK) == SND_SOC_DAIFMT_I2S
-		&& bits > 16) {
-		printk(KERN_WARNING
-				"atmel_ssc_dai: sample size %d "
-				"is too large for I2S\n", bits);
-		return -EINVAL;
-	}
-
-	/*
 	 * Compute SSC register settings.
 	 */
 	switch (ssc_p->daifmt
@@ -413,6 +402,17 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 		 * from the MCK divider, and the BCLK signal
 		 * is output on the SSC TK line.
 		 */
+
+		if (bits > 16 && !ssc->pdata->has_fslen_ext) {
+			dev_err(dai->dev,
+				"sample size %d is too large for SSC device\n",
+				bits);
+			return -EINVAL;
+		}
+
+		fslen_ext = (bits - 1) / 16;
+		fslen = (bits - 1) % 16;
+
 		rcmr =	  SSC_BF(RCMR_PERIOD, ssc_p->rcmr_period)
 			| SSC_BF(RCMR_STTDLY, START_DELAY)
 			| SSC_BF(RCMR_START, SSC_START_FALLING_RF)
@@ -420,9 +420,10 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 			| SSC_BF(RCMR_CKO, SSC_CKO_NONE)
 			| SSC_BF(RCMR_CKS, SSC_CKS_DIV);
 
-		rfmr =	  SSC_BF(RFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
+		rfmr =    SSC_BF(RFMR_FSLEN_EXT, fslen_ext)
+			| SSC_BF(RFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
 			| SSC_BF(RFMR_FSOS, SSC_FSOS_NEGATIVE)
-			| SSC_BF(RFMR_FSLEN, (bits - 1))
+			| SSC_BF(RFMR_FSLEN, fslen)
 			| SSC_BF(RFMR_DATNB, (channels - 1))
 			| SSC_BIT(RFMR_MSBF)
 			| SSC_BF(RFMR_LOOP, 0)
@@ -435,10 +436,11 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 			| SSC_BF(TCMR_CKO, SSC_CKO_CONTINUOUS)
 			| SSC_BF(TCMR_CKS, SSC_CKS_DIV);
 
-		tfmr =	  SSC_BF(TFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
+		tfmr =    SSC_BF(TFMR_FSLEN_EXT, fslen_ext)
+			| SSC_BF(TFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
 			| SSC_BF(TFMR_FSDEN, 0)
 			| SSC_BF(TFMR_FSOS, SSC_FSOS_NEGATIVE)
-			| SSC_BF(TFMR_FSLEN, (bits - 1))
+			| SSC_BF(TFMR_FSLEN, fslen)
 			| SSC_BF(TFMR_DATNB, (channels - 1))
 			| SSC_BIT(TFMR_MSBF)
 			| SSC_BF(TFMR_DATDEF, 0)
-- 
1.8.5.2
