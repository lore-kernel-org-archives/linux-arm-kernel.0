From: tiwai@suse.de (Takashi Iwai)
Date: Sun, 21 May 2017 21:02:57 +0200
Subject: [PATCH 6/7] staging: bcm2835-audio: Deliver indirect-PCM transfer
 error
In-Reply-To: <20170521190258.1178-1-tiwai@suse.de>
References: <20170521190258.1178-1-tiwai@suse.de>
Message-ID: <20170521190258.1178-7-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the indirect-PCM transfer helper gives back an error, we
should return the error from ack callbacks.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index e8cf0b97bf02..3637ddf909a4 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -353,9 +353,8 @@ static int snd_bcm2835_pcm_ack(struct snd_pcm_substream *substream)
 	struct snd_pcm_indirect *pcm_indirect = &alsa_stream->pcm_indirect;
 
 	pcm_indirect->hw_queue_size = runtime->hw.buffer_bytes_max;
-	snd_pcm_indirect_playback_transfer(substream, pcm_indirect,
-					   snd_bcm2835_pcm_transfer);
-	return 0;
+	return snd_pcm_indirect_playback_transfer(substream, pcm_indirect,
+						  snd_bcm2835_pcm_transfer);
 }
 
 /* trigger callback */
-- 
2.13.0
