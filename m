From: hychao@chromium.org (Hsin-Yu Chao)
Date: Wed, 19 Feb 2014 14:30:35 +0800
Subject: [PATCH 2/2] ALSA: hda/ca0132 - Fix recording from mode id 0x8
In-Reply-To: <s5htxcbtc71.wl%tiwai@suse.de>
References: <s5htxcbtc71.wl%tiwai@suse.de>
Message-ID: <1392791435-17170-1-git-send-email-hychao@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Incorrect ADC is picked in ca0132_capture_pcm_prepare(),
where it assumes multiple streams while there is one stream
per ADC. Note that ca0132_capture_pcm_cleanup() already does
the right thing.

The Chromebook Pixel has a microphone under the keyboard that
is attached to node id 0x8. Before this fix, recording would
always go to the main internal mic (node id 0x7).

Signed-off-by: Hsin-Yu Chao <hychao@chromium.org>
Reviewed-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/patch_ca0132.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 0aa72ee..46ecdbb 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -2768,9 +2768,7 @@ static int ca0132_capture_pcm_prepare(struct hda_pcm_stream *hinfo,
 					unsigned int format,
 					struct snd_pcm_substream *substream)
 {
-	struct ca0132_spec *spec = codec->spec;
-
-	snd_hda_codec_setup_stream(codec, spec->adcs[substream->number],
+	snd_hda_codec_setup_stream(codec, hinfo->nid,
 				   stream_tag, 0, format);
 
 	return 0;
-- 
1.8.3.2
