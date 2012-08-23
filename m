From: dgreid@chromium.org (Dylan Reid)
Date: Thu, 23 Aug 2012 13:51:09 -0700
Subject: [PATCH] ASoC: samsung dma - prepare dma in start/resume trigger path
Message-ID: <1345755069-9512-1-git-send-email-dgreid@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On suspend all dma transactions are terminated (by the stop/suspend
trigger calling ops->stop), they need to be set up again during resume.
Move the prepare op to the start/resume/unpause trigger path so that dma
and audio will restart on resume/unpause.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/soc/samsung/dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
index f3ebc38..5772762 100644
--- a/sound/soc/samsung/dma.c
+++ b/sound/soc/samsung/dma.c
@@ -250,6 +250,7 @@ static int dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		dma_prepare(substream);
 		prtd->state |= ST_RUNNING;
 		prtd->params->ops->trigger(prtd->params->ch);
 		break;
@@ -352,7 +353,6 @@ static struct snd_pcm_ops dma_ops = {
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= dma_hw_params,
 	.hw_free	= dma_hw_free,
-	.prepare	= dma_prepare,
 	.trigger	= dma_trigger,
 	.pointer	= dma_pointer,
 	.mmap		= dma_mmap,
-- 
1.7.7.3
