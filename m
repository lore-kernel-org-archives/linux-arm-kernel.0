From: tiwai@suse.de (Takashi Iwai)
Date: Tue, 13 Nov 2018 17:50:37 +0100
Subject: [PATCH v2] ARM: staging: bcm2835-audio: interpolate audio delay
In-Reply-To: <B1CDD261-AB22-43CE-AF46-DFB5460B5D50@eircom.net>
References: <B1CDD261-AB22-43CE-AF46-DFB5460B5D50@eircom.net>
Message-ID: <s5h7ehgdiqq.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 11 Nov 2018 19:21:29 +0100,
Mike Brady wrote:
> 
>  /* hardware definition */
>  static const struct snd_pcm_hardware snd_bcm2835_playback_hw = {
>  	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
>  		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
> -		 SNDRV_PCM_INFO_DRAIN_TRIGGER | SNDRV_PCM_INFO_SYNC_APPLPTR),
> +		 SNDRV_PCM_INFO_BATCH | SNDRV_PCM_INFO_DRAIN_TRIGGER |
> +		 SNDRV_PCM_INFO_SYNC_APPLPTR),

As already mentioned, the addition of SNDRV_PCM_INFO_BATCH should be
irrelevant with this change.  Please create another patch to add this
and clarify it in the changelog.

> diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
> index 4e6110d778bd..574df7d7a1fa 100644
> --- a/sound/core/pcm_lib.c
> +++ b/sound/core/pcm_lib.c
> @@ -229,19 +229,38 @@ static void update_audio_tstamp(struct snd_pcm_substream *substream,
>  		(runtime->audio_tstamp_report.actual_type ==
>  			SNDRV_PCM_AUDIO_TSTAMP_TYPE_DEFAULT)) {
>  
> -		/*
> -		 * provide audio timestamp derived from pointer position
> -		 * add delay only if requested
> -		 */
> +		// provide audio timestamp derived from pointer position
>  
>  		audio_frames = runtime->hw_ptr_wrap + runtime->status->hw_ptr;
>  
> -		if (runtime->audio_tstamp_config.report_delay) {
> +		/*
> +		 * If the runtime->delay is greater than zero, it's a
> +		 * genuine delay, e.g. a delay due to a hardware fifo.
> +		 *
> +		 * But if the runtime->delay is less than zero, it's an
> +		 * interpolated estimate of the number of frames output
> +		 * since the hardware pointer was last updated.
> +		 *
> +		 * It would be calculated in the pointer callback.
> +		 * For example, for the bcm_2835 driver, it is calculated in
> +		 * snd_bcm2835_pcm_pointer().
> +		 */
> +
> +		if (runtime->delay < 0) {
> +			// The delay is an interpolated estimate...
>  			if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> -				audio_frames -=  runtime->delay;
> -			else
> -				audio_frames +=  runtime->delay;
> +				audio_frames += runtime->delay;
> +		} else {
> +			// The delay is a real delay. Add it if requested.
> +			if (runtime->audio_tstamp_config.report_delay) {
> +				if (substream->stream ==
> +				    SNDRV_PCM_STREAM_PLAYBACK)
> +					audio_frames -=  runtime->delay;
> +				else
> +					audio_frames +=  runtime->delay;
> +			}
>  		}

Well, honestly speaking, I'm really not fond of changing the PCM core
just for this.

Can we make bcm audio driver providing the finer pointer update
instead?  If we have a module option to disable that behavior, it's an
enough excuse in case anyone really cares about the accuracy.


thanks,

Takashi
