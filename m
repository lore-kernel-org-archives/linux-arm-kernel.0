From: mikebrady@eircom.net (Mike Brady)
Date: Wed, 24 Oct 2018 20:54:51 +0100
Subject: [alsa-devel] [PATCH v2] staging: bcm2835-audio: interpolate audio
 delay
In-Reply-To: <046aea96-e0d3-60f4-c61a-c26bb1b5c193@gmail.com>
References: <20181022191708.GA4659@ubuntu>
 <a703f8a2-e85a-bc5b-750a-cc43ef252ba5@gmail.com>
 <EA85FEC9-B1C7-4548-88F5-F0E7BC12158E@eircom.net>
 <046aea96-e0d3-60f4-c61a-c26bb1b5c193@gmail.com>
Message-ID: <B9A84822-3780-4E01-96AD-FD3B42C44B45@eircom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kirill. Thanks again for your comments.

> On 24 Oct 2018, at 19:06, Kirill Marinushkin <k.marinushkin@gmail.com> wrote:
> 
> Hello Mike,
> 
> On 10/24/18 10:20, Mike Brady wrote:
>> Hi Kirill. Thanks for your comments.
>> 
>>> On 22 Oct 2018, at 23:25, Kirill Marinushkin <k.marinushkin@gmail.com> wrote:
>>> 
>>> AFAIU, this patch is wrong. Please correct me, maybe I misunderstand something.
>>> 
>>>> The problem that this patch seeks to resolve is that when userland asks for
>>>> the delay
>>> 
>>> The userspace asks not for delay, but for the pointer.
>> 
>> The call in question is snd_pcm_delay. I presume this delay is calculated from knowledge of the stream position ?pos", the period (buffer?) number (and period/buffer size) and the snd_pcm_runtime structure?s ?delay" field (?runtime->delay?).
>> 
> 
> 
> In kernel, this delay is calculated in `snd_pcm_calc_delay()`, defined at
> `sound/core/pcm_native.c:889`. If you analyze how this calculation is done, you
> will see that the returned value is a summary of the following fields:
> 
> * runtime->status->hw_ptr
> * runtime->buffer_size
> * runtime->control->appl_ptr
> * runtime->boundary
> * runtime->delay

That?s very useful, thanks.

>>> You modify the function, which is called `snd_bcm2835_pcm_pointer`. Here you are
>>> supposed to increase `alsa_stream->pos` with the proper offset. Instead, you
>>> imitate a delay, but in fact the delay is not increased.
>>> 
>>> So, the proper solution should be to fix the reported pointer.
>> 
>> I think there is a difficulty with this. The ?pos? pointer looks to have to be modulo the buffer size. This causes a problem, as I see it, in that if the calculated (pos + interpolated delay in bytes) is longer than the buffer size
> 
> 
> There is no "interpolated delay". The concept of "interpolated delay" is
> incorrect.

Yes, my language here is wrong. What I mean is the estimated number of frames output since the pointer was last updated ? let?s call it the `interpolated frame count`.

> When you play sound - the pointer increments.

Unfortunately, when you play sound, the pointer does not actually increment, for up to about 10 milliseconds. I know of no way to actually access the true ?live? position of the frame that is being played at any instant; hence the desire to estimate it.

What actually seems to be happening is that when `bcm2835_playback_fifo` is called, the pointer is updated, but as frames are individually output to the DAC, this pointer does not increment. It is not updated until the next time `bcm2835_playback_fifo` is called.

> But in this commit you increment the delay, as if sound doesn't play.

It is true that the patch does make use of the  snd_pcm_runtime structure?s ?delay" field (aka "runtime->delay? here). That field is defined for: ?/* extra delay; typically FIFO size */?. Clearly it is not being used for that here ? it is being used simply because it is part of the calculation done in snd_pcm_calc_delay(), as you point out. At present, it looks like that field isn?t being used ?? it?s set to zero ?? and not modified anywhere else in the driver, AFAICS. If it was necessary, it would be a simple matter to preserve whatever value it was given.

>>> As a result,
>>> userspace will recieve the correct delay, instead of these crazy 10 ms.
>> 
>> Just to point out that with the proposed patch, it appears that the correct delay is being reported, (apart, possibly, from any delay originally set in the snd_pcm_delay field, as mentioned above).
> 
> 
> Then I would like to point out the alsa-lib function `snd_pcm_avail()` - it will return the wrong value.

It is already the case that snd_pcm_avail() does not return the true delay. The ALSA documentation states: "The value returned by that call [i.e. the snd_pcm_avail*() functions] is not directly related to the delay?? 

Kind regards
Mike

>> 
>>> FYI, there is
>>>> a discussion of the effects of a downstream equivalent of this suggested patch
>>>> at:
>>>> https://github.com/raspberrypi/firmware/issues/1026#issuecomment-415746016.
>>> 
>>> Thank you for the link, it clarified for me what you try to achieve.
>>> 
>>> On 10/22/18 21:17, Mike Brady wrote:
>>>> When the BCM2835 audio output is used, userspace sees a jitter up to 10ms
>>>> in the audio position, aka "delay" -- the number of frames that must
>>>> be output before a new frame would be played.
>>>> Make this a bit nicer for userspace by interpolating the position
>>>> using the CPU clock.
>>>> The overhead is small -- an extra ktime_get() every time a GPU message
>>>> is sent -- and another call and a few calculations whenever the delay
>>>> is sought from userland.
>>>> At 48,000 frames per second, i.e. approximately 20 microseconds per
>>>> frame, it would take a clock inaccuracy of
>>>> 20 microseconds in 10 milliseconds -- 2,000 parts per million --
>>>> to result in an inaccurate estimate, whereas
>>>> crystal- or resonator-based clocks typically have an
>>>> inaccuracy of 10s to 100s of parts per million.
>>>> 
>>>> Signed-off-by: Mike Brady <mikebrady@eircom.net>
>>>> ---
>>>> Changes in v2 -- remove inappropriate addition of SNDRV_PCM_INFO_BATCH flag
>>>> 
>>>> .../vc04_services/bcm2835-audio/bcm2835-pcm.c | 20 +++++++++++++++++++
>>>> .../vc04_services/bcm2835-audio/bcm2835.h     |  1 +
>>>> 2 files changed, 21 insertions(+)
>>>> 
>>>> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
>>>> index e66da11af5cf..9053b996cada 100644
>>>> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
>>>> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
>>>> @@ -74,6 +74,7 @@ void bcm2835_playback_fifo(struct bcm2835_alsa_stream *alsa_stream,
>>>> 	atomic_set(&alsa_stream->pos, pos);
>>>> 
>>>> 	alsa_stream->period_offset += bytes;
>>>> +	alsa_stream->interpolate_start = ktime_get();
>>>> 	if (alsa_stream->period_offset >= alsa_stream->period_size) {
>>>> 		alsa_stream->period_offset %= alsa_stream->period_size;
>>>> 		snd_pcm_period_elapsed(substream);
>>>> @@ -243,6 +244,7 @@ static int snd_bcm2835_pcm_prepare(struct snd_pcm_substream *substream)
>>>> 	atomic_set(&alsa_stream->pos, 0);
>>>> 	alsa_stream->period_offset = 0;
>>>> 	alsa_stream->draining = false;
>>>> +	alsa_stream->interpolate_start = ktime_get();
>>>> 
>>>> 	return 0;
>>>> }
>>>> @@ -292,6 +294,24 @@ snd_bcm2835_pcm_pointer(struct snd_pcm_substream *substream)
>>>> {
>>>> 	struct snd_pcm_runtime *runtime = substream->runtime;
>>>> 	struct bcm2835_alsa_stream *alsa_stream = runtime->private_data;
>>>> +	ktime_t now = ktime_get();
>>>> +
>>>> +	/* Give userspace better delay reporting by interpolating between GPU
>>>> +	 * notifications, assuming audio speed is close enough to the clock
>>>> +	 * used for ktime
>>>> +	 */
>>>> +
>>>> +	if ((ktime_to_ns(alsa_stream->interpolate_start)) &&
>>>> +	    (ktime_compare(alsa_stream->interpolate_start, now) < 0)) {
>>>> +		u64 interval =
>>>> +			(ktime_to_ns(ktime_sub(now,
>>>> +				alsa_stream->interpolate_start)));
>>>> +		u64 frames_output_in_interval =
>>>> +			div_u64((interval * runtime->rate), 1000000000);
>>>> +		snd_pcm_sframes_t frames_output_in_interval_sized =
>>>> +			-frames_output_in_interval;
>>>> +		runtime->delay = frames_output_in_interval_sized;
>>>> +	}
>>>> 
>>>> 	return snd_pcm_indirect_playback_pointer(substream,
>>>> 		&alsa_stream->pcm_indirect,
>>>> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
>>>> index e13435d1c205..595ad584243f 100644
>>>> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
>>>> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
>>>> @@ -78,6 +78,7 @@ struct bcm2835_alsa_stream {
>>>> 	unsigned int period_offset;
>>>> 	unsigned int buffer_size;
>>>> 	unsigned int period_size;
>>>> +	ktime_t interpolate_start;
>>>> 
>>>> 	struct bcm2835_audio_instance *instance;
>>>> 	int idx;
>>>> 
>>> _______________________________________________
>>> Alsa-devel mailing list
>>> Alsa-devel at alsa-project.org
>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel at alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
