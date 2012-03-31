From: b29396@freescale.com (Dong Aisheng)
Date: Sat, 31 Mar 2012 20:37:48 +0800
Subject: [PATCH 1/1] ASoC: soc-dmaengine-pcm: fix compile error since dma api
 is changed
Message-ID: <1333197468-3263-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

The following compiling error is caused by the API device_prep_dma_cyclic
is changed. Using dmaengine_prep_dma_cyclic to fix it.

sound/soc/soc-dmaengine-pcm.c: In function 'dmaengine_pcm_prepare_and_submit':
sound/soc/soc-dmaengine-pcm.c:149: error: too few arguments to function 'chan->device->device_prep_dma_cyclic'
make[2]: *** [sound/soc/soc-dmaengine-pcm.o] Error 1
make[1]: *** [sound/soc] Error 2
make: *** [sound] Error 2

Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 sound/soc/soc-dmaengine-pcm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-dmaengine-pcm.c b/sound/soc/soc-dmaengine-pcm.c
index 4420b70..4756952 100644
--- a/sound/soc/soc-dmaengine-pcm.c
+++ b/sound/soc/soc-dmaengine-pcm.c
@@ -143,7 +143,7 @@ static int dmaengine_pcm_prepare_and_submit(struct snd_pcm_substream *substream)
 	direction = snd_pcm_substream_to_dma_direction(substream);
 
 	prtd->pos = 0;
-	desc = chan->device->device_prep_dma_cyclic(chan,
+	desc = dmaengine_prep_dma_cyclic(chan,
 		substream->runtime->dma_addr,
 		snd_pcm_lib_buffer_bytes(substream),
 		snd_pcm_lib_period_bytes(substream), direction);
-- 
1.7.0.4
