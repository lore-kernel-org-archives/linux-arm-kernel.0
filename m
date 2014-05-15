From: rickard_strandqvist@spectrumdigital.se (Rickard Strandqvist)
Date: Thu, 15 May 2014 23:57:56 +0200
Subject: =?UTF-8?q?=5BPATCH=5D=20Fix=20for=20possible=20null=20pointer=20dereference=20in=20dma=2Ec?=
Message-ID: <1400191076-28279-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is otherwise a risk of a possible null pointer dereference.

Was largely found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 sound/soc/samsung/dma.c |   10 ++++++----
 1 fil ?ndrad, 6 till?gg(+), 4 borttagningar(-)

diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
index dc09b71..b1f6757 100644
--- a/sound/soc/samsung/dma.c
+++ b/sound/soc/samsung/dma.c
@@ -115,17 +115,19 @@ static void dma_enqueue(struct snd_pcm_substream *substream)
 static void audio_buffdone(void *data)
 {
 	struct snd_pcm_substream *substream = data;
-	struct runtime_data *prtd = substream->runtime->private_data;
+	struct runtime_data *prtd = NULL;
 
 	pr_debug("Entered %s\n", __func__);
 
-	if (prtd->state & ST_RUNNING) {
+	if(substream)
+		prtd = substream->runtime->private_data;
+
+	if (prtd && prtd->state & ST_RUNNING) {
 		prtd->dma_pos += prtd->dma_period;
 		if (prtd->dma_pos >= prtd->dma_end)
 			prtd->dma_pos = prtd->dma_start;
 
-		if (substream)
-			snd_pcm_period_elapsed(substream);
+		snd_pcm_period_elapsed(substream);
 
 		spin_lock(&prtd->lock);
 		if (!samsung_dma_has_circular()) {
-- 
1.7.10.4
