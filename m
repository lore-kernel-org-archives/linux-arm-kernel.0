From: tiwai@suse.de (Takashi Iwai)
Date: Sun, 21 May 2017 21:02:55 +0200
Subject: [PATCH 4/7] ALSA: emu10k1: Deliver indirect-PCM transfer error
In-Reply-To: <20170521190258.1178-1-tiwai@suse.de>
References: <20170521190258.1178-1-tiwai@suse.de>
Message-ID: <20170521190258.1178-5-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the indirect-PCM transfer helper gives back an error, we
should return the error from ack callbacks.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/emu10k1/emupcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/emu10k1/emupcm.c b/sound/pci/emu10k1/emupcm.c
index ef1cf530c929..bdda29f335f6 100644
--- a/sound/pci/emu10k1/emupcm.c
+++ b/sound/pci/emu10k1/emupcm.c
@@ -1632,8 +1632,8 @@ static int snd_emu10k1_fx8010_playback_transfer(struct snd_pcm_substream *substr
 	struct snd_emu10k1 *emu = snd_pcm_substream_chip(substream);
 	struct snd_emu10k1_fx8010_pcm *pcm = &emu->fx8010.pcm[substream->number];
 
-	snd_pcm_indirect_playback_transfer(substream, &pcm->pcm_rec, fx8010_pb_trans_copy);
-	return 0;
+	return snd_pcm_indirect_playback_transfer(substream, &pcm->pcm_rec,
+						  fx8010_pb_trans_copy);
 }
 
 static int snd_emu10k1_fx8010_playback_hw_params(struct snd_pcm_substream *substream,
-- 
2.13.0
