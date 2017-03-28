From: sfaragnaus@gmail.com (Andrea della Porta)
Date: Tue, 28 Mar 2017 13:21:06 +0100
Subject: [PATCH] coding style issue fixed
Message-ID: <20170328122106.GA2553@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Coding style issues fixed

Signed-off-by: Andrea della Porta <sfaragnaus@gmail.com>
---
 .../vc04_services/bcm2835-audio/bcm2835-pcm.c      | 47 ++++++++++------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index 8bd69b9..fa6d3d2 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -68,7 +68,7 @@ void bcm2835_playback_fifo(struct bcm2835_alsa_stream *alsa_stream)
 	audio_info(" .. IN\n");
 
 	audio_info("alsa_stream=%p substream=%p\n", alsa_stream,
-		alsa_stream ? alsa_stream->substream : 0);
+		   alsa_stream ? alsa_stream->substream : 0);
 
 	if (alsa_stream->open)
 		consumed = bcm2835_audio_retrieve_buffers(alsa_stream);
@@ -83,10 +83,10 @@ void bcm2835_playback_fifo(struct bcm2835_alsa_stream *alsa_stream)
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
@@ -229,6 +229,7 @@ static int snd_bcm2835_playback_close(struct snd_pcm_substream *substream)
 	 */
 	if (alsa_stream->running) {
 		int err;
+
 		err = bcm2835_audio_stop(alsa_stream);
 		alsa_stream->running = 0;
 		if (err)
@@ -259,7 +260,7 @@ static int snd_bcm2835_playback_close(struct snd_pcm_substream *substream)
 
 /* hw_params callback */
 static int snd_bcm2835_pcm_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
+				     struct snd_pcm_hw_params *params)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct bcm2835_alsa_stream *alsa_stream = runtime->private_data;
@@ -312,18 +313,16 @@ static int snd_bcm2835_pcm_prepare(struct snd_pcm_substream *substream)
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
@@ -335,8 +334,8 @@ static int snd_bcm2835_pcm_prepare(struct snd_pcm_substream *substream)
 	alsa_stream->pos = 0;
 
 	audio_debug("buffer_size=%d, period_size=%d pos=%d frame_bits=%d\n",
-		alsa_stream->buffer_size, alsa_stream->period_size,
-		alsa_stream->pos, runtime->frame_bits);
+		    alsa_stream->buffer_size, alsa_stream->period_size,
+		    alsa_stream->pos, runtime->frame_bits);
 
 	mutex_unlock(&chip->audio_mutex);
 	audio_info(" .. OUT\n");
@@ -344,17 +343,16 @@ static int snd_bcm2835_pcm_prepare(struct snd_pcm_substream *substream)
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
@@ -381,14 +379,14 @@ static int snd_bcm2835_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
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
@@ -433,23 +431,23 @@ snd_bcm2835_pcm_pointer(struct snd_pcm_substream *substream)
 	audio_info(" .. IN\n");
 
 	audio_debug("pcm_pointer... (%d) hwptr=%d appl=%d pos=%d\n", 0,
-		frames_to_bytes(runtime, runtime->status->hw_ptr),
-		frames_to_bytes(runtime, runtime->control->appl_ptr),
-		alsa_stream->pos);
+		    frames_to_bytes(runtime, runtime->status->hw_ptr),
+		    frames_to_bytes(runtime, runtime->control->appl_ptr),
+		    alsa_stream->pos);
 
 	audio_info(" .. OUT\n");
 	return snd_pcm_indirect_playback_pointer(substream,
-		&alsa_stream->pcm_indirect,
-		alsa_stream->pos);
+						 &alsa_stream->pcm_indirect,
+						 alsa_stream->pos);
 }
 
 static int snd_bcm2835_pcm_lib_ioctl(struct snd_pcm_substream *substream,
-	unsigned int cmd, void *arg)
+				     unsigned int cmd, void *arg)
 {
 	int ret = snd_pcm_lib_ioctl(substream, cmd, arg);
 
 	audio_info(" .. substream=%p, cmd=%d, arg=%p (%x) ret=%d\n", substream,
-		cmd, arg, arg ? *(unsigned *) arg : 0, ret);
+		   cmd, arg, arg ? *(unsigned *)arg : 0, ret);
 	return ret;
 }
 
@@ -510,7 +508,6 @@ int snd_bcm2835_new_pcm(struct bcm2835_chip *chip, u32 numchannels)
 					      snd_bcm2835_playback_hw.buffer_bytes_max,
 					      snd_bcm2835_playback_hw.buffer_bytes_max);
 
-
 out:
 	mutex_unlock(&chip->audio_mutex);
 	audio_info(" .. OUT\n");
@@ -541,8 +538,8 @@ int snd_bcm2835_new_spdif_pcm(struct bcm2835_chip *chip)
 	/* pre-allocation of buffers */
 	/* NOTE: this may fail */
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
-		snd_dma_continuous_data(GFP_KERNEL),
-		snd_bcm2835_playback_spdif_hw.buffer_bytes_max, snd_bcm2835_playback_spdif_hw.buffer_bytes_max);
+					      snd_dma_continuous_data(GFP_KERNEL),
+					      snd_bcm2835_playback_spdif_hw.buffer_bytes_max, snd_bcm2835_playback_spdif_hw.buffer_bytes_max);
 out:
 	mutex_unlock(&chip->audio_mutex);
 	audio_info(" .. OUT\n");
-- 
2.4.10
