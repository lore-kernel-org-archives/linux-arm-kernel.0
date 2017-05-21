From: tiwai@suse.de (Takashi Iwai)
Date: Sun, 21 May 2017 21:02:56 +0200
Subject: [PATCH 5/7] ALSA: rme32: Deliver indirect-PCM transfer error
In-Reply-To: <20170521190258.1178-1-tiwai@suse.de>
References: <20170521190258.1178-1-tiwai@suse.de>
Message-ID: <20170521190258.1178-6-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the indirect-PCM transfer helper gives back an error, we
should return the error from ack callbacks.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/rme32.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/pci/rme32.c b/sound/pci/rme32.c
index 96d15db65dfd..f9b424056d0f 100644
--- a/sound/pci/rme32.c
+++ b/sound/pci/rme32.c
@@ -1157,9 +1157,8 @@ static int snd_rme32_playback_fd_ack(struct snd_pcm_substream *substream)
 	if (rme32->running & (1 << SNDRV_PCM_STREAM_CAPTURE))
 		rec->hw_queue_size -= cprec->hw_ready;
 	spin_unlock(&rme32->lock);
-	snd_pcm_indirect_playback_transfer(substream, rec,
-					   snd_rme32_pb_trans_copy);
-	return 0;
+	return snd_pcm_indirect_playback_transfer(substream, rec,
+						  snd_rme32_pb_trans_copy);
 }
 
 static void snd_rme32_cp_trans_copy(struct snd_pcm_substream *substream,
@@ -1174,9 +1173,8 @@ static void snd_rme32_cp_trans_copy(struct snd_pcm_substream *substream,
 static int snd_rme32_capture_fd_ack(struct snd_pcm_substream *substream)
 {
 	struct rme32 *rme32 = snd_pcm_substream_chip(substream);
-	snd_pcm_indirect_capture_transfer(substream, &rme32->capture_pcm,
-					  snd_rme32_cp_trans_copy);
-	return 0;
+	return snd_pcm_indirect_capture_transfer(substream, &rme32->capture_pcm,
+						 snd_rme32_cp_trans_copy);
 }
 
 static snd_pcm_uframes_t
-- 
2.13.0
