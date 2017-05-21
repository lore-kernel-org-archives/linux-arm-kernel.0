From: tiwai@suse.de (Takashi Iwai)
Date: Sun, 21 May 2017 21:02:52 +0200
Subject: [PATCH 1/7] ALSA: pcm: Fix negative appl_ptr handling in pcm-indirect
 helpers
In-Reply-To: <20170521190258.1178-1-tiwai@suse.de>
References: <20170521190258.1178-1-tiwai@suse.de>
Message-ID: <20170521190258.1178-2-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The indirect-PCM helper codes have an implicit assumption that the
appl_ptr always increases.  But the PCM core may deal with the
decrement of appl_ptr via rewind ioctls, and it may screw up the
buffer pointer management.

This patch adds the negative appl_ptr diff in transfer functions and
let returning an error instead of always accepting the appl_ptr
updates.  The callers are usually PCM ack callbacks, and they pass the
error to the upper layer accordingly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/pcm-indirect.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/sound/pcm-indirect.h b/include/sound/pcm-indirect.h
index 1df7acaaa535..7ade285328cf 100644
--- a/include/sound/pcm-indirect.h
+++ b/include/sound/pcm-indirect.h
@@ -43,7 +43,7 @@ typedef void (*snd_pcm_indirect_copy_t)(struct snd_pcm_substream *substream,
 /*
  * helper function for playback ack callback
  */
-static inline void
+static inline int
 snd_pcm_indirect_playback_transfer(struct snd_pcm_substream *substream,
 				   struct snd_pcm_indirect *rec,
 				   snd_pcm_indirect_copy_t copy)
@@ -56,6 +56,8 @@ snd_pcm_indirect_playback_transfer(struct snd_pcm_substream *substream,
 	if (diff) {
 		if (diff < -(snd_pcm_sframes_t) (runtime->boundary / 2))
 			diff += runtime->boundary;
+		if (diff < 0)
+			return -EINVAL;
 		rec->sw_ready += (int)frames_to_bytes(runtime, diff);
 		rec->appl_ptr = appl_ptr;
 	}
@@ -82,6 +84,7 @@ snd_pcm_indirect_playback_transfer(struct snd_pcm_substream *substream,
 		rec->hw_ready += bytes;
 		rec->sw_ready -= bytes;
 	}
+	return 0;
 }
 
 /*
@@ -109,7 +112,7 @@ snd_pcm_indirect_playback_pointer(struct snd_pcm_substream *substream,
 /*
  * helper function for capture ack callback
  */
-static inline void
+static inline int
 snd_pcm_indirect_capture_transfer(struct snd_pcm_substream *substream,
 				  struct snd_pcm_indirect *rec,
 				  snd_pcm_indirect_copy_t copy)
@@ -121,6 +124,8 @@ snd_pcm_indirect_capture_transfer(struct snd_pcm_substream *substream,
 	if (diff) {
 		if (diff < -(snd_pcm_sframes_t) (runtime->boundary / 2))
 			diff += runtime->boundary;
+		if (diff < 0)
+			return -EINVAL;
 		rec->sw_ready -= frames_to_bytes(runtime, diff);
 		rec->appl_ptr = appl_ptr;
 	}
@@ -147,6 +152,7 @@ snd_pcm_indirect_capture_transfer(struct snd_pcm_substream *substream,
 		rec->hw_ready -= bytes;
 		rec->sw_ready += bytes;
 	}
+	return 0;
 }
 
 /*
-- 
2.13.0
