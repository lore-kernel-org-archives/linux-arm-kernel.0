From: sfaragnaus@gmail.com (Andrea della Porta)
Date: Sun, 9 Apr 2017 00:25:25 +0100
Subject: [PATCH v3 1/2] staging: vc04_services: bcm2835-audio: bcm2835-pcm.c
 Fixed checkpatch warning about unaligned function params
In-Reply-To: <cover.1491693395.git.sfaragnaus@gmail.com>
References: <cover.1491693395.git.sfaragnaus@gmail.com>
Message-ID: <2b55563dd9824e6f9d45b174f1eccd301fccc2d5.1491693395.git.sfaragnaus@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixed unaligned function parameters issues, as per checkpatch warning

Signed-off-by: Andrea della Porta <sfaragnaus@gmail.com>
---
Changes in v3:
- rebased on staging-testing

 .../vc04_services/bcm2835-audio/bcm2835-pcm.c      | 43 ++++++++++------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index e8cf0b9..a2cc09a 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -67,7 +67,7 @@ void bcm2835_playback_fifo(struct bcm2835_alsa_stream *alsa_stream)
 
 
 	audio_info("alsa_stream=%p substream=%p\n", alsa_stream,
-		alsa_stream ? alsa_stream->substream : 0);
+		   alsa_stream ? alsa_stream->substream : 0);
 
 	if (alsa_stream->open)
 		consumed = bcm2835_audio_retrieve_buffers(alsa_stream);
@@ -82,10 +82,10 @@ void bcm2835_playback_fifo(struct bcm2835_alsa_stream *alsa_stream)
 			new_period = 1;
 	}
 	audio_debug("updating pos cur: %d + %d max:%d period_bytes:%d, hw_ptr: %d new_period:%d\n",
-		alsa_stream->pos,
+		    alsa_stream->pos,
 		consumed,
 		alsa_stream->buffer_size,
-		(int) (alsa_stream->period_size * alsa_stream->substream->runtime->periods),
+		(int)(alsa_stream->period_size * alsa_stream->substream->runtime->periods),
 		frames_to_bytes(alsa_stream->substream->runtime, alsa_stream->substream->runtime->status->hw_ptr),
 		new_period);
 	if (alsa_stream->buffer_size) {
@@ -224,6 +224,7 @@ static int snd_bcm2835_playback_close(struct snd_pcm_substream *substream)
 	 */
 	if (alsa_stream->running) {
 		int err;
+
 		err = bcm2835_audio_stop(alsa_stream);
 		alsa_stream->running = 0;
 		if (err)
@@ -253,7 +254,7 @@ static int snd_bcm2835_playback_close(struct snd_pcm_substream *substream)
 
 /* hw_params callback */
 static int snd_bcm2835_pcm_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
+				     struct snd_pcm_hw_params *params)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct bcm2835_alsa_stream *alsa_stream = runtime->private_data;
@@ -302,18 +303,16 @@ static int snd_bcm2835_pcm_prepare(struct snd_pcm_substream *substream)
 		channels = alsa_stream->channels;
 
 	err = bcm2835_audio_set_params(alsa_stream, channels,
-		alsa_stream->params_rate,
-		alsa_stream->pcm_format_width);
+				       alsa_stream->params_rate,
+				       alsa_stream->pcm_format_width);
 	if (err < 0)
 		audio_error(" error setting hw params\n");
 
-
 	bcm2835_audio_setup(alsa_stream);
 
 	/* in preparation of the stream, set the controls (volume level) of the stream */
 	bcm2835_audio_set_ctls(alsa_stream->chip);
 
-
 	memset(&alsa_stream->pcm_indirect, 0, sizeof(alsa_stream->pcm_indirect));
 
 	alsa_stream->pcm_indirect.hw_buffer_size =
@@ -325,25 +324,24 @@ static int snd_bcm2835_pcm_prepare(struct snd_pcm_substream *substream)
 	alsa_stream->pos = 0;
 
 	audio_debug("buffer_size=%d, period_size=%d pos=%d frame_bits=%d\n",
-		alsa_stream->buffer_size, alsa_stream->period_size,
-		alsa_stream->pos, runtime->frame_bits);
+		    alsa_stream->buffer_size, alsa_stream->period_size,
+		    alsa_stream->pos, runtime->frame_bits);
 
 	mutex_unlock(&chip->audio_mutex);
 	return 0;
 }
 
 static void snd_bcm2835_pcm_transfer(struct snd_pcm_substream *substream,
-	struct snd_pcm_indirect *rec, size_t bytes)
+				     struct snd_pcm_indirect *rec, size_t bytes)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct bcm2835_alsa_stream *alsa_stream = runtime->private_data;
-	void *src = (void *) (substream->runtime->dma_area + rec->sw_data);
+	void *src = (void *)(substream->runtime->dma_area + rec->sw_data);
 	int err;
 
 	err = bcm2835_audio_write(alsa_stream, bytes, src);
 	if (err)
 		audio_error(" Failed to transfer to alsa device (%d)\n", err);
-
 }
 
 static int snd_bcm2835_pcm_ack(struct snd_pcm_substream *substream)
@@ -369,14 +367,14 @@ static int snd_bcm2835_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		audio_debug("bcm2835_AUDIO_TRIGGER_START running=%d\n",
-			alsa_stream->running);
+			    alsa_stream->running);
 		if (!alsa_stream->running) {
 			err = bcm2835_audio_start(alsa_stream);
 			if (!err) {
 				alsa_stream->pcm_indirect.hw_io =
 					alsa_stream->pcm_indirect.hw_data =
 					bytes_to_frames(runtime,
-					alsa_stream->pos);
+							alsa_stream->pos);
 				substream->ops->ack(substream);
 				alsa_stream->running = 1;
 				alsa_stream->draining = 1;
@@ -419,9 +417,9 @@ snd_bcm2835_pcm_pointer(struct snd_pcm_substream *substream)
 
 
 	audio_debug("pcm_pointer... (%d) hwptr=%d appl=%d pos=%d\n", 0,
-		frames_to_bytes(runtime, runtime->status->hw_ptr),
-		frames_to_bytes(runtime, runtime->control->appl_ptr),
-		alsa_stream->pos);
+		    frames_to_bytes(runtime, runtime->status->hw_ptr),
+		    frames_to_bytes(runtime, runtime->control->appl_ptr),
+		    alsa_stream->pos);
 
 	return snd_pcm_indirect_playback_pointer(substream,
 		&alsa_stream->pcm_indirect,
@@ -429,12 +427,12 @@ snd_bcm2835_pcm_pointer(struct snd_pcm_substream *substream)
 }
 
 static int snd_bcm2835_pcm_lib_ioctl(struct snd_pcm_substream *substream,
-	unsigned int cmd, void *arg)
+				     unsigned int cmd, void *arg)
 {
 	int ret = snd_pcm_lib_ioctl(substream, cmd, arg);
 
 	audio_info(" .. substream=%p, cmd=%d, arg=%p (%x) ret=%d\n", substream,
-		cmd, arg, arg ? *(unsigned *) arg : 0, ret);
+		   cmd, arg, arg ? *(unsigned *) arg : 0, ret);
 	return ret;
 }
 
@@ -494,7 +492,6 @@ int snd_bcm2835_new_pcm(struct bcm2835_chip *chip, u32 numchannels)
 					      snd_bcm2835_playback_hw.buffer_bytes_max,
 					      snd_bcm2835_playback_hw.buffer_bytes_max);
 
-
 out:
 	mutex_unlock(&chip->audio_mutex);
 
@@ -523,8 +520,8 @@ int snd_bcm2835_new_spdif_pcm(struct bcm2835_chip *chip)
 	/* pre-allocation of buffers */
 	/* NOTE: this may fail */
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
-		snd_dma_continuous_data(GFP_KERNEL),
-		snd_bcm2835_playback_spdif_hw.buffer_bytes_max, snd_bcm2835_playback_spdif_hw.buffer_bytes_max);
+					      snd_dma_continuous_data(GFP_KERNEL),
+					      snd_bcm2835_playback_spdif_hw.buffer_bytes_max, snd_bcm2835_playback_spdif_hw.buffer_bytes_max);
 out:
 	mutex_unlock(&chip->audio_mutex);
 
-- 
2.4.10
