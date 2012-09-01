From: dgreid@chromium.org (Dylan Reid)
Date: Sat,  1 Sep 2012 01:38:19 -0700
Subject: [PATCH v2] ASoC: samsung dma - Don't indicate support for
 pause/resume.
Message-ID: <1346488699-11027-1-git-send-email-dgreid@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pause and resume operations indicate that the stream can be
un-paused/resumed from the exact location they were paused/suspended.
This is not true for this driver, the pause and suspend triggers share
the same code path with stop, they flush all pending DMA transfers.
This drops all pending samples.  The pause_release/resume triggers are
the same as start, except that prepare won't be called beforehand,
nothing will be enqueued to the DMA engine and nothing will happen (no
audio).  Removing the pause flag will let apps know that it isn't
supported.  Removing the resume flag will cause user space to call
prepare and start instead of resume, so audio will continue playing when
the system wakes up.

Before removing the pause and resume flags, I tested this on an exynos
5250, using 'aplay -i'. Pause/un-pause leads to silence followed by a
write error.  Suspend/resume testing led to the same result.  Removing
the two flags fixes suspend/resume (since snd_pcm_prepare is called
again). And leads to a proper reporting of pause not supported.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/soc/samsung/dma.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
index f3ebc38..b70964e 100644
--- a/sound/soc/samsung/dma.c
+++ b/sound/soc/samsung/dma.c
@@ -34,9 +34,7 @@ static const struct snd_pcm_hardware dma_hardware = {
 	.info			= SNDRV_PCM_INFO_INTERLEAVED |
 				    SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				    SNDRV_PCM_INFO_MMAP |
-				    SNDRV_PCM_INFO_MMAP_VALID |
-				    SNDRV_PCM_INFO_PAUSE |
-				    SNDRV_PCM_INFO_RESUME,
+				    SNDRV_PCM_INFO_MMAP_VALID,
 	.formats		= SNDRV_PCM_FMTBIT_S16_LE |
 				    SNDRV_PCM_FMTBIT_U16_LE |
 				    SNDRV_PCM_FMTBIT_U8 |
@@ -248,15 +246,11 @@ static int dma_trigger(struct snd_pcm_substream *substream, int cmd)
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_RESUME:
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		prtd->state |= ST_RUNNING;
 		prtd->params->ops->trigger(prtd->params->ch);
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		prtd->state &= ~ST_RUNNING;
 		prtd->params->ops->stop(prtd->params->ch);
 		break;
-- 
1.7.12.146.g16d26b1
