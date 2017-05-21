From: tiwai@suse.de (Takashi Iwai)
Date: Sun, 21 May 2017 21:02:53 +0200
Subject: [PATCH 2/7] ALSA: mips: Deliver indirect-PCM transfer error
In-Reply-To: <20170521190258.1178-1-tiwai@suse.de>
References: <20170521190258.1178-1-tiwai@suse.de>
Message-ID: <20170521190258.1178-3-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the indirect-PCM transfer helper gives back an error, we
should return the error from ack callbacks.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/mips/hal2.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/mips/hal2.c b/sound/mips/hal2.c
index 00fc9241d266..684dc4ddef41 100644
--- a/sound/mips/hal2.c
+++ b/sound/mips/hal2.c
@@ -616,10 +616,9 @@ static int hal2_playback_ack(struct snd_pcm_substream *substream)
 	struct hal2_codec *dac = &hal2->dac;
 
 	dac->pcm_indirect.hw_queue_size = H2_BUF_SIZE / 2;
-	snd_pcm_indirect_playback_transfer(substream,
-					   &dac->pcm_indirect,
-					   hal2_playback_transfer);
-	return 0;
+	return snd_pcm_indirect_playback_transfer(substream,
+						  &dac->pcm_indirect,
+						  hal2_playback_transfer);
 }
 
 static int hal2_capture_open(struct snd_pcm_substream *substream)
@@ -707,10 +706,9 @@ static int hal2_capture_ack(struct snd_pcm_substream *substream)
 	struct snd_hal2 *hal2 = snd_pcm_substream_chip(substream);
 	struct hal2_codec *adc = &hal2->adc;
 
-	snd_pcm_indirect_capture_transfer(substream,
-					  &adc->pcm_indirect,
-					  hal2_capture_transfer);
-	return 0;
+	return snd_pcm_indirect_capture_transfer(substream,
+						 &adc->pcm_indirect,
+						 hal2_capture_transfer);
 }
 
 static struct snd_pcm_ops hal2_playback_ops = {
-- 
2.13.0
