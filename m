From: voice.shen@atmel.com (Bo Shen)
Date: Fri, 30 Jan 2015 17:38:43 +0800
Subject: [PATCH 2/3] ASoC: atmel_ssc_dai: refactor the startup and shutdown
In-Reply-To: <1422610724-7222-1-git-send-email-voice.shen@atmel.com>
References: <1422610724-7222-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1422610724-7222-3-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In startup function, enable ssc clock and in shutdown function,
disable clock. And also remove disable ssc in shutdown function,
as ssc is disabled in prepare function.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---

 sound/soc/atmel/atmel_ssc_dai.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index c1d93b8..0ed5ac3 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -204,6 +204,13 @@ static int atmel_ssc_startup(struct snd_pcm_substream *substream,
 	pr_debug("atmel_ssc_startup: SSC_SR=0x%u\n",
 		ssc_readl(ssc_p->ssc->regs, SR));
 
+	/* Enable PMC peripheral clock for this SSC */
+	pr_debug("atmel_ssc_dai: Starting clock\n");
+	clk_enable(ssc_p->ssc->clk);
+
+	/* Reset the SSC to keep it at a clean status */
+	ssc_writel(ssc_p->ssc->regs, CR, SSC_BIT(CR_SWRST));
+
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		dir = 0;
 		dir_mask = SSC_DIR_MASK_PLAYBACK;
@@ -250,11 +257,6 @@ static void atmel_ssc_shutdown(struct snd_pcm_substream *substream,
 	dma_params = ssc_p->dma_params[dir];
 
 	if (dma_params != NULL) {
-		ssc_writel(ssc_p->ssc->regs, CR, dma_params->mask->ssc_disable);
-		pr_debug("atmel_ssc_shutdown: %s disabled SSC_SR=0x%08x\n",
-			(dir ? "receive" : "transmit"),
-			ssc_readl(ssc_p->ssc->regs, SR));
-
 		dma_params->ssc = NULL;
 		dma_params->substream = NULL;
 		ssc_p->dma_params[dir] = NULL;
@@ -266,10 +268,6 @@ static void atmel_ssc_shutdown(struct snd_pcm_substream *substream,
 	ssc_p->dir_mask &= ~dir_mask;
 	if (!ssc_p->dir_mask) {
 		if (ssc_p->initialized) {
-			/* Shutdown the SSC clock. */
-			pr_debug("atmel_ssc_dai: Stopping clock\n");
-			clk_disable(ssc_p->ssc->clk);
-
 			free_irq(ssc_p->ssc->irq, ssc_p);
 			ssc_p->initialized = 0;
 		}
@@ -280,6 +278,10 @@ static void atmel_ssc_shutdown(struct snd_pcm_substream *substream,
 		ssc_p->cmr_div = ssc_p->tcmr_period = ssc_p->rcmr_period = 0;
 	}
 	spin_unlock_irq(&ssc_p->lock);
+
+	/* Shutdown the SSC clock. */
+	pr_debug("atmel_ssc_dai: Stopping clock\n");
+	clk_disable(ssc_p->ssc->clk);
 }
 
 
@@ -597,14 +599,6 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 			rcmr, rfmr, tcmr, tfmr);
 
 	if (!ssc_p->initialized) {
-
-		/* Enable PMC peripheral clock for this SSC */
-		pr_debug("atmel_ssc_dai: Starting clock\n");
-		clk_enable(ssc_p->ssc->clk);
-
-		/* Reset the SSC and its PDC registers */
-		ssc_writel(ssc_p->ssc->regs, CR, SSC_BIT(CR_SWRST));
-
 		ssc_writel(ssc_p->ssc->regs, PDC_RPR, 0);
 		ssc_writel(ssc_p->ssc->regs, PDC_RCR, 0);
 		ssc_writel(ssc_p->ssc->regs, PDC_RNPR, 0);
-- 
2.3.0.rc0
