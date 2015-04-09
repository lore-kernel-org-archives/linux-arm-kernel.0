From: lexszero@gmail.com (Alexey Ignatov)
Date: Fri, 10 Apr 2015 02:00:50 +0300
Subject: [PATCH 1/2] ASoC: davinci: Clear VCIF read FIFO on errors
Message-ID: <1428620479-32696-1-git-send-email-lexszero@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clearing VCIF read FIFO on overflow and underflow events fixes audio glitching
when DMA load is high. This happened when simultaneously capturing and encoding
video and audio, for example.

Signed-off-by: Alexey Ignatov <lexszero@gmail.com>
---
 sound/soc/davinci/davinci-vcif.c | 60 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 56 insertions(+), 4 deletions(-)

diff --git a/sound/soc/davinci/davinci-vcif.c b/sound/soc/davinci/davinci-vcif.c
index 5bee0427..0d8014e 100644
--- a/sound/soc/davinci/davinci-vcif.c
+++ b/sound/soc/davinci/davinci-vcif.c
@@ -45,6 +45,10 @@
 	} \
 } while (0)
 
+#define DAVINCI_VC_INT_RERR_MASK \
+	(DAVINCI_VC_INT_RERRUDR_MASK | \
+	 DAVINCI_VC_INT_RERROVF_MASK)
+
 struct davinci_vcif_dev {
 	struct davinci_vc *davinci_vc;
 	struct davinci_pcm_dma_params	dma_params[2];
@@ -87,6 +91,22 @@ static void davinci_vcif_stop(struct snd_pcm_substream *substream)
 	writel(w, davinci_vc->base + DAVINCI_VC_CTRL);
 }
 
+static void davinci_vcif_interrupts(struct snd_pcm_substream *substream,
+		int enable)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct davinci_vcif_dev *davinci_vcif_dev =
+			snd_soc_dai_get_drvdata(rtd->cpu_dai);
+	struct davinci_vc *davinci_vc = davinci_vcif_dev->davinci_vc;
+
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		writel(DAVINCI_VC_INT_RERR_MASK,
+				davinci_vc->base + DAVINCI_VC_INTCLR);
+		writel(enable ? DAVINCI_VC_INT_RERR_MASK : 0,
+				davinci_vc->base + DAVINCI_VC_INTEN);
+	}
+}
+
 static int davinci_vcif_hw_params(struct snd_pcm_substream *substream,
 				  struct snd_pcm_hw_params *params,
 				  struct snd_soc_dai *dai)
@@ -104,10 +124,6 @@ static int davinci_vcif_hw_params(struct snd_pcm_substream *substream,
 	/* General line settings */
 	writel(DAVINCI_VC_CTRL_MASK, davinci_vc->base + DAVINCI_VC_CTRL);
 
-	writel(DAVINCI_VC_INT_MASK, davinci_vc->base + DAVINCI_VC_INTCLR);
-
-	writel(DAVINCI_VC_INT_MASK, davinci_vc->base + DAVINCI_VC_INTEN);
-
 	w = readl(davinci_vc->base + DAVINCI_VC_CTRL);
 
 	/* Determine xfer data type */
@@ -149,6 +165,32 @@ static int davinci_vcif_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static irqreturn_t davinci_vcif_irq_handler(int irq, void *data)
+{
+	struct davinci_vcif_dev *davinci_vcif_dev = data;
+	struct davinci_vc *davinci_vc = davinci_vcif_dev->davinci_vc;
+	uint32_t w;
+
+	w = readl(davinci_vc->base + DAVINCI_VC_INTSTATUS);
+
+	if (w & DAVINCI_VC_INT_RERR_MASK) {
+		pr_debug("vc overflow or underflow occurred, resetting fifo\n");
+
+		w = readl(davinci_vc->base + DAVINCI_VC_CTRL);
+		MOD_REG_BIT(w, DAVINCI_VC_CTRL_RFIFOCL, 1);
+		writel(w, davinci_vc->base + DAVINCI_VC_CTRL);
+
+		w = readl(davinci_vc->base + DAVINCI_VC_CTRL);
+		MOD_REG_BIT(w, DAVINCI_VC_CTRL_RFIFOCL, 0);
+		writel(w, davinci_vc->base + DAVINCI_VC_CTRL);
+
+		writel(DAVINCI_VC_INT_RERR_MASK,
+				davinci_vc->base + DAVINCI_VC_INTCLR);
+	}
+
+	return IRQ_HANDLED;
+}
+
 static int davinci_vcif_trigger(struct snd_pcm_substream *substream, int cmd,
 				struct snd_soc_dai *dai)
 {
@@ -159,10 +201,12 @@ static int davinci_vcif_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		davinci_vcif_start(substream);
+		davinci_vcif_interrupts(substream, 1);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		davinci_vcif_interrupts(substream, 0);
 		davinci_vcif_stop(substream);
 		break;
 	default:
@@ -178,6 +222,7 @@ static int davinci_vcif_startup(struct snd_pcm_substream *substream,
 	struct davinci_vcif_dev *dev = snd_soc_dai_get_drvdata(dai);
 
 	snd_soc_dai_set_dma_data(dai, substream, dev->dma_params);
+
 	return 0;
 }
 
@@ -238,6 +283,13 @@ static int davinci_vcif_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(&pdev->dev, davinci_vcif_dev);
 
+	ret = devm_request_irq(&pdev->dev, IRQ_MBXINT, davinci_vcif_irq_handler,
+			0, "vcif", davinci_vcif_dev);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "could not request irq: %d\n", ret);
+		return ret;
+	}
+
 	ret = snd_soc_register_component(&pdev->dev, &davinci_vcif_component,
 					 &davinci_vcif_dai, 1);
 	if (ret != 0) {
-- 
2.3.5
