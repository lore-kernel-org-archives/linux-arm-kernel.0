From: aishpant@gmail.com (Aishwarya Pant)
Date: Fri, 31 Mar 2017 18:01:23 +0530
Subject: [PATCH] staging: bcm2835-audio: remove unnecessary log messages
Message-ID: <20170331123123.GA31657@aishwarya>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unnecessary log messages in the driver which were just tracking
function entry and exits.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---

There are many functions here like:
bcm2835_audio_setup(..)
bcm2835_audio_flush_playback_buffers(..)
bcm2835_audio_flush_buffers(..)
which are not doing any work. Should they be removed or kept here as
placeholder?

 .../vc04_services/bcm2835-audio/bcm2835-ctl.c      |  2 --
 .../vc04_services/bcm2835-audio/bcm2835-pcm.c      | 19 ------------
 .../vc04_services/bcm2835-audio/bcm2835-vchiq.c    | 36 ----------------------
 3 files changed, 57 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
index 1fae169..f484bb0 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
@@ -41,7 +41,6 @@
 static int snd_bcm2835_ctl_info(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_info *uinfo)
 {
-	audio_info(" ... IN\n");
 	if (kcontrol->private_value == PCM_PLAYBACK_VOLUME) {
 		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 		uinfo->count = 1;
@@ -58,7 +57,6 @@ static int snd_bcm2835_ctl_info(struct snd_kcontrol *kcontrol,
 		uinfo->value.integer.min = 0;
 		uinfo->value.integer.max = AUDIO_DEST_MAX - 1;
 	}
-	audio_info(" ... OUT\n");
 	return 0;
 }
 
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index 8bd69b9..e8cf0b9 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -65,7 +65,6 @@ void bcm2835_playback_fifo(struct bcm2835_alsa_stream *alsa_stream)
 	unsigned int consumed = 0;
 	int new_period = 0;
 
-	audio_info(" .. IN\n");
 
 	audio_info("alsa_stream=%p substream=%p\n", alsa_stream,
 		alsa_stream ? alsa_stream->substream : 0);
@@ -100,7 +99,6 @@ void bcm2835_playback_fifo(struct bcm2835_alsa_stream *alsa_stream)
 	} else {
 		audio_warning(" unexpected NULL substream\n");
 	}
-	audio_info(" .. OUT\n");
 }
 
 /* open callback */
@@ -113,7 +111,6 @@ static int snd_bcm2835_playback_open_generic(
 	int idx;
 	int err;
 
-	audio_info(" .. IN (%d)\n", substream->number);
 
 	if (mutex_lock_interruptible(&chip->audio_mutex)) {
 		audio_error("Interrupted whilst waiting for lock\n");
@@ -187,7 +184,6 @@ static int snd_bcm2835_playback_open_generic(
 out:
 	mutex_unlock(&chip->audio_mutex);
 
-	audio_info(" .. OUT =%d\n", err);
 
 	return err;
 }
@@ -211,7 +207,6 @@ static int snd_bcm2835_playback_close(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime;
 	struct bcm2835_alsa_stream *alsa_stream;
 
-	audio_info(" .. IN\n");
 
 	chip = snd_pcm_substream_chip(substream);
 	if (mutex_lock_interruptible(&chip->audio_mutex)) {
@@ -252,7 +247,6 @@ static int snd_bcm2835_playback_close(struct snd_pcm_substream *substream)
 	chip->opened &= ~(1 << substream->number);
 
 	mutex_unlock(&chip->audio_mutex);
-	audio_info(" .. OUT\n");
 
 	return 0;
 }
@@ -265,7 +259,6 @@ static int snd_bcm2835_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct bcm2835_alsa_stream *alsa_stream = runtime->private_data;
 	int err;
 
-	audio_info(" .. IN\n");
 
 	err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
 	if (err < 0) {
@@ -277,7 +270,6 @@ static int snd_bcm2835_pcm_hw_params(struct snd_pcm_substream *substream,
 	alsa_stream->channels = params_channels(params);
 	alsa_stream->params_rate = params_rate(params);
 	alsa_stream->pcm_format_width = snd_pcm_format_width(params_format(params));
-	audio_info(" .. OUT\n");
 
 	return err;
 }
@@ -285,7 +277,6 @@ static int snd_bcm2835_pcm_hw_params(struct snd_pcm_substream *substream,
 /* hw_free callback */
 static int snd_bcm2835_pcm_hw_free(struct snd_pcm_substream *substream)
 {
-	audio_info(" .. IN\n");
 	return snd_pcm_lib_free_pages(substream);
 }
 
@@ -298,7 +289,6 @@ static int snd_bcm2835_pcm_prepare(struct snd_pcm_substream *substream)
 	int channels;
 	int err;
 
-	audio_info(" .. IN\n");
 
 	if (mutex_lock_interruptible(&chip->audio_mutex))
 		return -EINTR;
@@ -339,7 +329,6 @@ static int snd_bcm2835_pcm_prepare(struct snd_pcm_substream *substream)
 		alsa_stream->pos, runtime->frame_bits);
 
 	mutex_unlock(&chip->audio_mutex);
-	audio_info(" .. OUT\n");
 	return 0;
 }
 
@@ -376,7 +365,6 @@ static int snd_bcm2835_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	struct bcm2835_alsa_stream *alsa_stream = runtime->private_data;
 	int err = 0;
 
-	audio_info(" .. IN\n");
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -419,7 +407,6 @@ static int snd_bcm2835_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 		err = -EINVAL;
 	}
 
-	audio_info(" .. OUT\n");
 	return err;
 }
 
@@ -430,14 +417,12 @@ snd_bcm2835_pcm_pointer(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct bcm2835_alsa_stream *alsa_stream = runtime->private_data;
 
-	audio_info(" .. IN\n");
 
 	audio_debug("pcm_pointer... (%d) hwptr=%d appl=%d pos=%d\n", 0,
 		frames_to_bytes(runtime, runtime->status->hw_ptr),
 		frames_to_bytes(runtime, runtime->control->appl_ptr),
 		alsa_stream->pos);
 
-	audio_info(" .. OUT\n");
 	return snd_pcm_indirect_playback_pointer(substream,
 		&alsa_stream->pcm_indirect,
 		alsa_stream->pos);
@@ -484,7 +469,6 @@ int snd_bcm2835_new_pcm(struct bcm2835_chip *chip, u32 numchannels)
 	struct snd_pcm *pcm;
 	int err;
 
-	audio_info(" .. IN\n");
 	mutex_init(&chip->audio_mutex);
 	if (mutex_lock_interruptible(&chip->audio_mutex)) {
 		audio_error("Interrupted whilst waiting for lock\n");
@@ -513,7 +497,6 @@ int snd_bcm2835_new_pcm(struct bcm2835_chip *chip, u32 numchannels)
 
 out:
 	mutex_unlock(&chip->audio_mutex);
-	audio_info(" .. OUT\n");
 
 	return 0;
 }
@@ -523,7 +506,6 @@ int snd_bcm2835_new_spdif_pcm(struct bcm2835_chip *chip)
 	struct snd_pcm *pcm;
 	int err;
 
-	audio_info(" .. IN\n");
 	if (mutex_lock_interruptible(&chip->audio_mutex)) {
 		audio_error("Interrupted whilst waiting for lock\n");
 		return -EINTR;
@@ -545,7 +527,6 @@ int snd_bcm2835_new_spdif_pcm(struct bcm2835_chip *chip)
 		snd_bcm2835_playback_spdif_hw.buffer_bytes_max, snd_bcm2835_playback_spdif_hw.buffer_bytes_max);
 out:
 	mutex_unlock(&chip->audio_mutex);
-	audio_info(" .. OUT\n");
 
 	return 0;
 }
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index 6e007db..dcc4dc4 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -109,7 +109,6 @@ static void my_wq_function(struct work_struct *work)
 		container_of(work, struct bcm2835_audio_work, my_work);
 	int ret = -9;
 
-	LOG_DBG(" .. IN %p:%d\n", w->alsa_stream, w->cmd);
 	switch (w->cmd) {
 	case BCM2835_AUDIO_START:
 		ret = bcm2835_audio_start_worker(w->alsa_stream);
@@ -126,12 +125,10 @@ static void my_wq_function(struct work_struct *work)
 		break;
 	}
 	kfree((void *)work);
-	LOG_DBG(" .. OUT %d\n", ret);
 }
 
 int bcm2835_audio_start(struct bcm2835_alsa_stream *alsa_stream)
 {
-	LOG_DBG(" .. IN\n");
 	if (alsa_stream->my_wq) {
 		struct bcm2835_audio_work *work;
 
@@ -149,13 +146,11 @@ int bcm2835_audio_start(struct bcm2835_alsa_stream *alsa_stream)
 			return -EBUSY;
 		}
 	}
-	LOG_DBG(" .. OUT\n");
 	return 0;
 }
 
 int bcm2835_audio_stop(struct bcm2835_alsa_stream *alsa_stream)
 {
-	LOG_DBG(" .. IN\n");
 	if (alsa_stream->my_wq) {
 		struct bcm2835_audio_work *work;
 
@@ -173,14 +168,12 @@ int bcm2835_audio_stop(struct bcm2835_alsa_stream *alsa_stream)
 			return -EBUSY;
 		}
 	}
-	LOG_DBG(" .. OUT\n");
 	return 0;
 }
 
 int bcm2835_audio_write(struct bcm2835_alsa_stream *alsa_stream,
 			unsigned int count, void *src)
 {
-	LOG_DBG(" .. IN\n");
 	if (alsa_stream->my_wq) {
 		struct bcm2835_audio_work *work;
 
@@ -200,7 +193,6 @@ int bcm2835_audio_write(struct bcm2835_alsa_stream *alsa_stream,
 			return -EBUSY;
 		}
 	}
-	LOG_DBG(" .. OUT\n");
 	return 0;
 }
 
@@ -227,7 +219,6 @@ static void audio_vchi_callback(void *param,
 	int msg_len;
 	struct vc_audio_msg m;
 
-	LOG_DBG(" .. IN instance=%p, handle=%p, alsa=%p, reason=%d, handle=%p\n",
 		instance, instance ? instance->vchi_handle[0] : NULL, instance ? instance->alsa_stream : NULL, reason, msg_handle);
 
 	if (reason != VCHI_CALLBACK_MSG_AVAILABLE)
@@ -269,7 +260,6 @@ static void audio_vchi_callback(void *param,
 	} else {
 		LOG_ERR(" .. unexpected m.type=%d\n", m.type);
 	}
-	LOG_DBG(" .. OUT\n");
 }
 
 static struct bcm2835_audio_instance *
@@ -349,7 +339,6 @@ static int vc_vchi_audio_deinit(struct bcm2835_audio_instance *instance)
 {
 	unsigned int i;
 
-	LOG_DBG(" .. IN\n");
 
 	if (!instance) {
 		LOG_ERR("%s: invalid handle %p\n", __func__, instance);
@@ -382,7 +371,6 @@ static int vc_vchi_audio_deinit(struct bcm2835_audio_instance *instance)
 
 	kfree(instance);
 
-	LOG_DBG(" .. OUT\n");
 
 	return 0;
 }
@@ -396,7 +384,6 @@ static int bcm2835_audio_open_connection(struct bcm2835_alsa_stream *alsa_stream
 		(struct bcm2835_audio_instance *)alsa_stream->instance;
 	int ret;
 
-	LOG_DBG(" .. IN\n");
 
 	LOG_INFO("%s: start\n", __func__);
 	BUG_ON(instance);
@@ -447,7 +434,6 @@ static int bcm2835_audio_open_connection(struct bcm2835_alsa_stream *alsa_stream
 	ret = 0;
 err_free_mem:
 	kfree(vchi_instance);
-	LOG_DBG(" .. OUT\n");
 
 	return ret;
 }
@@ -459,7 +445,6 @@ int bcm2835_audio_open(struct bcm2835_alsa_stream *alsa_stream)
 	int status;
 	int ret;
 
-	LOG_DBG(" .. IN\n");
 
 	my_workqueue_init(alsa_stream);
 
@@ -497,7 +482,6 @@ int bcm2835_audio_open(struct bcm2835_alsa_stream *alsa_stream)
 	vchi_service_release(instance->vchi_handle[0]);
 	mutex_unlock(&instance->vchi_mutex);
 exit:
-	LOG_DBG(" .. OUT\n");
 	return ret;
 }
 
@@ -509,7 +493,6 @@ static int bcm2835_audio_set_ctls_chan(struct bcm2835_alsa_stream *alsa_stream,
 	int status;
 	int ret;
 
-	LOG_DBG(" .. IN\n");
 
 	LOG_INFO(" Setting ALSA dest(%d), volume(%d)\n",
 		 chip->dest, chip->volume);
@@ -558,7 +541,6 @@ static int bcm2835_audio_set_ctls_chan(struct bcm2835_alsa_stream *alsa_stream,
 	vchi_service_release(instance->vchi_handle[0]);
 	mutex_unlock(&instance->vchi_mutex);
 
-	LOG_DBG(" .. OUT\n");
 	return ret;
 }
 
@@ -567,7 +549,6 @@ int bcm2835_audio_set_ctls(struct bcm2835_chip *chip)
 	int i;
 	int ret = 0;
 
-	LOG_DBG(" .. IN\n");
 	LOG_DBG(" Setting ALSA dest(%d), volume(%d)\n", chip->dest, chip->volume);
 
 	/* change ctls for all substreams */
@@ -584,7 +565,6 @@ int bcm2835_audio_set_ctls(struct bcm2835_chip *chip)
 			}
 		}
 	}
-	LOG_DBG(" .. OUT ret=%d\n", ret);
 	return ret;
 }
 
@@ -597,7 +577,6 @@ int bcm2835_audio_set_params(struct bcm2835_alsa_stream *alsa_stream,
 	int status;
 	int ret;
 
-	LOG_DBG(" .. IN\n");
 
 	LOG_INFO(" Setting ALSA channels(%d), samplerate(%d), bits-per-sample(%d)\n",
 		 channels, samplerate, bps);
@@ -653,15 +632,12 @@ int bcm2835_audio_set_params(struct bcm2835_alsa_stream *alsa_stream,
 	vchi_service_release(instance->vchi_handle[0]);
 	mutex_unlock(&instance->vchi_mutex);
 
-	LOG_DBG(" .. OUT\n");
 	return ret;
 }
 
 int bcm2835_audio_setup(struct bcm2835_alsa_stream *alsa_stream)
 {
-	LOG_DBG(" .. IN\n");
 
-	LOG_DBG(" .. OUT\n");
 
 	return 0;
 }
@@ -673,7 +649,6 @@ static int bcm2835_audio_start_worker(struct bcm2835_alsa_stream *alsa_stream)
 	int status;
 	int ret;
 
-	LOG_DBG(" .. IN\n");
 
 	if (mutex_lock_interruptible(&instance->vchi_mutex)) {
 		LOG_DBG("Interrupted whilst waiting for lock on (%d)\n",
@@ -701,7 +676,6 @@ static int bcm2835_audio_start_worker(struct bcm2835_alsa_stream *alsa_stream)
 unlock:
 	vchi_service_release(instance->vchi_handle[0]);
 	mutex_unlock(&instance->vchi_mutex);
-	LOG_DBG(" .. OUT\n");
 	return ret;
 }
 
@@ -712,7 +686,6 @@ static int bcm2835_audio_stop_worker(struct bcm2835_alsa_stream *alsa_stream)
 	int status;
 	int ret;
 
-	LOG_DBG(" .. IN\n");
 
 	if (mutex_lock_interruptible(&instance->vchi_mutex)) {
 		LOG_DBG("Interrupted whilst waiting for lock on (%d)\n",
@@ -741,7 +714,6 @@ static int bcm2835_audio_stop_worker(struct bcm2835_alsa_stream *alsa_stream)
 unlock:
 	vchi_service_release(instance->vchi_handle[0]);
 	mutex_unlock(&instance->vchi_mutex);
-	LOG_DBG(" .. OUT\n");
 	return ret;
 }
 
@@ -752,7 +724,6 @@ int bcm2835_audio_close(struct bcm2835_alsa_stream *alsa_stream)
 	int status;
 	int ret;
 
-	LOG_DBG(" .. IN\n");
 
 	my_workqueue_quit(alsa_stream);
 
@@ -800,7 +771,6 @@ int bcm2835_audio_close(struct bcm2835_alsa_stream *alsa_stream)
 	vc_vchi_audio_deinit(instance);
 	alsa_stream->instance = NULL;
 
-	LOG_DBG(" .. OUT\n");
 	return ret;
 }
 
@@ -812,7 +782,6 @@ static int bcm2835_audio_write_worker(struct bcm2835_alsa_stream *alsa_stream,
 	int status;
 	int ret;
 
-	LOG_DBG(" .. IN\n");
 
 	LOG_INFO(" Writing %d bytes from %p\n", count, src);
 
@@ -878,7 +847,6 @@ static int bcm2835_audio_write_worker(struct bcm2835_alsa_stream *alsa_stream,
 unlock:
 	vchi_service_release(instance->vchi_handle[0]);
 	mutex_unlock(&instance->vchi_mutex);
-	LOG_DBG(" .. OUT\n");
 	return ret;
 }
 
@@ -887,8 +855,6 @@ static int bcm2835_audio_write_worker(struct bcm2835_alsa_stream *alsa_stream,
  */
 void bcm2835_audio_flush_buffers(struct bcm2835_alsa_stream *alsa_stream)
 {
-	LOG_DBG(" .. IN\n");
-	LOG_DBG(" .. OUT\n");
 }
 
 /**
@@ -897,8 +863,6 @@ void bcm2835_audio_flush_buffers(struct bcm2835_alsa_stream *alsa_stream)
  */
 void bcm2835_audio_flush_playback_buffers(struct bcm2835_alsa_stream *alsa_stream)
 {
-	LOG_DBG(" .. IN\n");
-	LOG_DBG(" .. OUT\n");
 }
 
 unsigned int bcm2835_audio_retrieve_buffers(struct bcm2835_alsa_stream *alsa_stream)
-- 
2.7.4
