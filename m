From: voice.shen@atmel.com (Bo Shen)
Date: Fri, 30 Jan 2015 17:38:44 +0800
Subject: [PATCH 3/3] ASoC: atmel_ssc_dai: only clean PDC when using PDC
In-Reply-To: <1422610724-7222-1-git-send-email-voice.shen@atmel.com>
References: <1422610724-7222-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1422610724-7222-4-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only using PDC, it needs to clean PDC registers.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---

 sound/soc/atmel/atmel_ssc_dai.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 0ed5ac3..80eb1f1 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -599,15 +599,17 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 			rcmr, rfmr, tcmr, tfmr);
 
 	if (!ssc_p->initialized) {
-		ssc_writel(ssc_p->ssc->regs, PDC_RPR, 0);
-		ssc_writel(ssc_p->ssc->regs, PDC_RCR, 0);
-		ssc_writel(ssc_p->ssc->regs, PDC_RNPR, 0);
-		ssc_writel(ssc_p->ssc->regs, PDC_RNCR, 0);
-
-		ssc_writel(ssc_p->ssc->regs, PDC_TPR, 0);
-		ssc_writel(ssc_p->ssc->regs, PDC_TCR, 0);
-		ssc_writel(ssc_p->ssc->regs, PDC_TNPR, 0);
-		ssc_writel(ssc_p->ssc->regs, PDC_TNCR, 0);
+		if (!ssc_p->ssc->pdata->use_dma) {
+			ssc_writel(ssc_p->ssc->regs, PDC_RPR, 0);
+			ssc_writel(ssc_p->ssc->regs, PDC_RCR, 0);
+			ssc_writel(ssc_p->ssc->regs, PDC_RNPR, 0);
+			ssc_writel(ssc_p->ssc->regs, PDC_RNCR, 0);
+
+			ssc_writel(ssc_p->ssc->regs, PDC_TPR, 0);
+			ssc_writel(ssc_p->ssc->regs, PDC_TCR, 0);
+			ssc_writel(ssc_p->ssc->regs, PDC_TNPR, 0);
+			ssc_writel(ssc_p->ssc->regs, PDC_TNCR, 0);
+		}
 
 		ret = request_irq(ssc_p->ssc->irq, atmel_ssc_interrupt, 0,
 				ssc_p->name, ssc_p);
-- 
2.3.0.rc0
