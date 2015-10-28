From: koro.chen@mediatek.com (Koro Chen)
Date: Wed, 28 Oct 2015 10:15:34 +0800
Subject: [PATCH] ASoC: dpcm: Make BE prepare possible in suspend state
Message-ID: <1445998534-38246-1-git-send-email-koro.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During suspend/resume, there is a flow that if a driver does not support
SNDRV_PCM_INFO_RESUME, it will fail at snd_pcm_resume(), and user space
can then issue SNDRV_PCM_IOCTL_PREPARE to let audio continue to play.

However, in dpcm_be_dai_prepare() it only allows BEs to be prepared
in state SND_SOC_DPCM_STATE_HW_PARAMS or SND_SOC_DPCM_STATE_STOP.
The BE state will then stay in SND_SOC_DPCM_STATE_SUSPEND, consequently
dpcm_be_dai_shutdown() is skipped in the end of playback and
be_substream->runtime is not cleared while this runtime is actually freed
by snd_pcm_detach_substream(). If another suspend comes, a NULL pointer
dereference will happen in snd_pcm_suspend() when accessing
BE substream's runtime.

Signed-off-by: Koro Chen <koro.chen@mediatek.com>
---
 sound/soc/soc-pcm.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 3173958..5c41a58 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2117,7 +2117,8 @@ int dpcm_be_dai_prepare(struct snd_soc_pcm_runtime *fe, int stream)
 			continue;
 
 		if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_PARAMS) &&
-		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP))
+		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP) &&
+		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_SUSPEND))
 			continue;
 
 		dev_dbg(be->dev, "ASoC: prepare BE %s\n",
-- 
1.7.9.5
