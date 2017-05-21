From: tiwai@suse.de (Takashi Iwai)
Date: Sun, 21 May 2017 21:02:58 +0200
Subject: [PATCH 7/7] ALSA: pcm: Call ack() whenever appl_ptr is updated
In-Reply-To: <20170521190258.1178-1-tiwai@suse.de>
References: <20170521190258.1178-1-tiwai@suse.de>
Message-ID: <20170521190258.1178-8-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Although the ack callback is supposed to be called at each appl_ptr or
hw_ptr update, we missed a few opportunities: namely, forward, rewind
and sync_ptr.

Formerly calling ack at rewind may have leaded to unexpected results
due to the forgotten negative appl_ptr update in indirect-PCM helper,
which is the major user of the PCM ack callback.  But now we fixed
this oversights, thus we can call ack callback safely even at rewind
callback -- of course with the proper handling of the error from the
callback.

This patch adds the calls of ack callback in the places mentioned in
the above.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 46 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index ecde57afa45a..7bc4a0bbad6f 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2455,13 +2455,35 @@ static int do_pcm_hwsync(struct snd_pcm_substream *substream)
 	}
 }
 
-/* increase the appl_ptr; returns the processed frames */
+/* update to the given appl_ptr and call ack callback if needed;
+ * when an error is returned, take back to the original value
+ */
+static int apply_appl_ptr(struct snd_pcm_substream *substream,
+			  snd_pcm_uframes_t appl_ptr)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	snd_pcm_uframes_t old_appl_ptr = runtime->control->appl_ptr;
+	int ret;
+
+	runtime->control->appl_ptr = appl_ptr;
+	if (substream->ops->ack) {
+		ret = substream->ops->ack(substream);
+		if (ret < 0) {
+			runtime->control->appl_ptr = old_appl_ptr;
+			return ret;
+		}
+	}
+	return 0;
+}
+
+/* increase the appl_ptr; returns the processed frames or a negative error */
 static snd_pcm_sframes_t forward_appl_ptr(struct snd_pcm_substream *substream,
 					  snd_pcm_uframes_t frames,
 					   snd_pcm_sframes_t avail)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_pcm_sframes_t appl_ptr;
+	int ret;
 
 	if (avail <= 0)
 		return 0;
@@ -2470,17 +2492,18 @@ static snd_pcm_sframes_t forward_appl_ptr(struct snd_pcm_substream *substream,
 	appl_ptr = runtime->control->appl_ptr + frames;
 	if (appl_ptr >= (snd_pcm_sframes_t)runtime->boundary)
 		appl_ptr -= runtime->boundary;
-	runtime->control->appl_ptr = appl_ptr;
-	return frames;
+	ret = apply_appl_ptr(substream, appl_ptr);
+	return ret < 0 ? ret : frames;
 }
 
-/* decrease the appl_ptr; returns the processed frames */
+/* decrease the appl_ptr; returns the processed frames or a negative error */
 static snd_pcm_sframes_t rewind_appl_ptr(struct snd_pcm_substream *substream,
 					 snd_pcm_uframes_t frames,
 					 snd_pcm_sframes_t avail)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_pcm_sframes_t appl_ptr;
+	int ret;
 
 	if (avail <= 0)
 		return 0;
@@ -2489,8 +2512,8 @@ static snd_pcm_sframes_t rewind_appl_ptr(struct snd_pcm_substream *substream,
 	appl_ptr = runtime->control->appl_ptr - frames;
 	if (appl_ptr < 0)
 		appl_ptr += runtime->boundary;
-	runtime->control->appl_ptr = appl_ptr;
-	return frames;
+	ret = apply_appl_ptr(substream, appl_ptr);
+	return ret < 0 ? ret : frames;
 }
 
 static snd_pcm_sframes_t snd_pcm_playback_rewind(struct snd_pcm_substream *substream,
@@ -2620,10 +2643,15 @@ static int snd_pcm_sync_ptr(struct snd_pcm_substream *substream,
 			return err;
 	}
 	snd_pcm_stream_lock_irq(substream);
-	if (!(sync_ptr.flags & SNDRV_PCM_SYNC_PTR_APPL))
-		control->appl_ptr = sync_ptr.c.control.appl_ptr;
-	else
+	if (!(sync_ptr.flags & SNDRV_PCM_SYNC_PTR_APPL)) {
+		err = apply_appl_ptr(substream, sync_ptr.c.control.appl_ptr);
+		if (err < 0) {
+			snd_pcm_stream_unlock_irq(substream);
+			return err;
+		}
+	} else {
 		sync_ptr.c.control.appl_ptr = control->appl_ptr;
+	}
 	if (!(sync_ptr.flags & SNDRV_PCM_SYNC_PTR_AVAIL_MIN))
 		control->avail_min = sync_ptr.c.control.avail_min;
 	else
-- 
2.13.0
