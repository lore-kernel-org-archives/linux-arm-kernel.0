From: mikebrady@eircom.net (Mike Brady)
Date: Mon, 22 Oct 2018 20:17:08 +0100
Subject: [PATCH v2] staging: bcm2835-audio: interpolate audio delay
In-Reply-To: <20181018105715.GA6660@ubuntu>
Message-ID: <20181022191708.GA4659@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the BCM2835 audio output is used, userspace sees a jitter up to 10ms
in the audio position, aka "delay" -- the number of frames that must
be output before a new frame would be played.
Make this a bit nicer for userspace by interpolating the position
using the CPU clock.
The overhead is small -- an extra ktime_get() every time a GPU message
is sent -- and another call and a few calculations whenever the delay
is sought from userland.
At 48,000 frames per second, i.e. approximately 20 microseconds per
frame, it would take a clock inaccuracy of
20 microseconds in 10 milliseconds -- 2,000 parts per million --
to result in an inaccurate estimate, whereas
crystal- or resonator-based clocks typically have an
inaccuracy of 10s to 100s of parts per million.

Signed-off-by: Mike Brady <mikebrady@eircom.net>
---
Changes in v2 -- remove inappropriate addition of SNDRV_PCM_INFO_BATCH flag

 .../vc04_services/bcm2835-audio/bcm2835-pcm.c | 20 +++++++++++++++++++
 .../vc04_services/bcm2835-audio/bcm2835.h     |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index e66da11af5cf..9053b996cada 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -74,6 +74,7 @@ void bcm2835_playback_fifo(struct bcm2835_alsa_stream *alsa_stream,
 	atomic_set(&alsa_stream->pos, pos);
 
 	alsa_stream->period_offset += bytes;
+	alsa_stream->interpolate_start = ktime_get();
 	if (alsa_stream->period_offset >= alsa_stream->period_size) {
 		alsa_stream->period_offset %= alsa_stream->period_size;
 		snd_pcm_period_elapsed(substream);
@@ -243,6 +244,7 @@ static int snd_bcm2835_pcm_prepare(struct snd_pcm_substream *substream)
 	atomic_set(&alsa_stream->pos, 0);
 	alsa_stream->period_offset = 0;
 	alsa_stream->draining = false;
+	alsa_stream->interpolate_start = ktime_get();
 
 	return 0;
 }
@@ -292,6 +294,24 @@ snd_bcm2835_pcm_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct bcm2835_alsa_stream *alsa_stream = runtime->private_data;
+	ktime_t now = ktime_get();
+
+	/* Give userspace better delay reporting by interpolating between GPU
+	 * notifications, assuming audio speed is close enough to the clock
+	 * used for ktime
+	 */
+
+	if ((ktime_to_ns(alsa_stream->interpolate_start)) &&
+	    (ktime_compare(alsa_stream->interpolate_start, now) < 0)) {
+		u64 interval =
+			(ktime_to_ns(ktime_sub(now,
+				alsa_stream->interpolate_start)));
+		u64 frames_output_in_interval =
+			div_u64((interval * runtime->rate), 1000000000);
+		snd_pcm_sframes_t frames_output_in_interval_sized =
+			-frames_output_in_interval;
+		runtime->delay = frames_output_in_interval_sized;
+	}
 
 	return snd_pcm_indirect_playback_pointer(substream,
 		&alsa_stream->pcm_indirect,
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
index e13435d1c205..595ad584243f 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
@@ -78,6 +78,7 @@ struct bcm2835_alsa_stream {
 	unsigned int period_offset;
 	unsigned int buffer_size;
 	unsigned int period_size;
+	ktime_t interpolate_start;
 
 	struct bcm2835_audio_instance *instance;
 	int idx;
-- 
2.17.1
