From: tiwai@suse.de (Takashi Iwai)
Date: Mon, 22 May 2017 07:27:40 +0200
Subject: [PATCH 0/7] ALSA: Fix/improve PCM ack callback
In-Reply-To: <7685a366-5b2f-0a96-a686-c49b79975c56@sakamocchi.jp>
References: <20170521190258.1178-1-tiwai@suse.de>
 <7685a366-5b2f-0a96-a686-c49b79975c56@sakamocchi.jp>
Message-ID: <s5htw4dihpv.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 May 2017 05:49:00 +0200,
Takashi Sakamoto wrote:
> 
> Hi,
> 
> On May 22 2017 04:02, Takashi Iwai wrote:
> > Hi,
> >
> > this is a series of patches to fix the potential bugs in PCM ack
> > callback using the pcm-indirect helper functions, and also to enhance
> > the ack callback to be called properly in all appl_ptr updates, as
> > similarly done by Pierre and Subhransu's patches.
> >
> > The changes in the pcm-indirect helper code and its users are fairly
> > trivial, just passing the error code back.
> >
> > ARM/R-Pi people are Cc'ed because of bcm2835-audio driver.
> >
> >
> > Takashi
> >
> > ===
> >
> > Takashi Iwai (7):
> >    ALSA: pcm: Fix negative appl_ptr handling in pcm-indirect helpers
> >    ALSA: mips: Deliver indirect-PCM transfer error
> >    ALSA: cs46xx: Deliver indirect-PCM transfer error
> >    ALSA: emu10k1: Deliver indirect-PCM transfer error
> >    ALSA: rme32: Deliver indirect-PCM transfer error
> >    staging: bcm2835-audio: Deliver indirect-PCM transfer error
> >    ALSA: pcm: Call ack() whenever appl_ptr is updated
> >
> >   .../vc04_services/bcm2835-audio/bcm2835-pcm.c      |  5 +--
> >   include/sound/pcm-indirect.h                       | 10 ++++-
> >   sound/core/pcm_native.c                            | 46 +++++++++++++++++-----
> >   sound/mips/hal2.c                                  | 14 +++----
> >   sound/pci/cs46xx/cs46xx_lib.c                      |  8 ++--
> >   sound/pci/emu10k1/emupcm.c                         |  4 +-
> >   sound/pci/rme32.c                                  | 10 ++---
> >   7 files changed, 63 insertions(+), 34 deletions(-)
> 
> I mostly agree with this patchset, except for one point.
> 
> The added helper function, apply_appl_ptr(), copies given data to the
> runtime for application-side pointer, then call 'struct
> snd_pcm_ops.ack'. We have similar code block in
> 'sound/core/pcm_lib.c', as well. See 'snd_pcm_lib_write1()' and
> 'snd_pcm_lib_read1()'.
> 
> In a point of code maintenance, it's better to share the function
> between two objects; pcm_native.o and pcm_lib.o.
> 
> For instance, I can propose a below patch. I expect you to squash it
> up within one of your patches.
> 
> ========== 8< ----------
> 
> diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
> index ab4b1d1e44ee..9d048f91bd3f 100644
> --- a/sound/core/pcm_lib.c
> +++ b/sound/core/pcm_lib.c
> @@ -2010,6 +2010,12 @@ typedef int (*transfer_f)(struct
> snd_pcm_substream *substream, unsigned int hwof
>  			  unsigned long data, unsigned int off,
>  			  snd_pcm_uframes_t size);
> 
> +/* This symbol is shared by several relocatable objects for the same shared
> + * object.
> + */
> +int snd_pcm_apply_appl_ptr(struct snd_pcm_substream *substream,
> +			  snd_pcm_uframes_t appl_ptr);
> +
>  static snd_pcm_sframes_t snd_pcm_lib_write1(struct snd_pcm_substream
> *substream,
>  					    unsigned long data,
>  					    snd_pcm_uframes_t size,
> @@ -2087,11 +2093,9 @@ static snd_pcm_sframes_t
> snd_pcm_lib_write1(struct snd_pcm_substream *substream,
>  			break;
>  		}
>  		appl_ptr += frames;
> -		if (appl_ptr >= runtime->boundary)
> -			appl_ptr -= runtime->boundary;
> -		runtime->control->appl_ptr = appl_ptr;
> -		if (substream->ops->ack)
> -			substream->ops->ack(substream);
> +		err = snd_pcm_apply_appl_ptr(substream, appl_ptr);
> +		if (err < 0)
> +			goto _end_unlock;
> 
>  		offset += frames;
>  		size -= frames;
> @@ -2321,9 +2325,9 @@ static snd_pcm_sframes_t
> snd_pcm_lib_read1(struct snd_pcm_substream *substream,
>  		appl_ptr += frames;
>  		if (appl_ptr >= runtime->boundary)
>  			appl_ptr -= runtime->boundary;
> -		runtime->control->appl_ptr = appl_ptr;
> -		if (substream->ops->ack)
> -			substream->ops->ack(substream);
> +		err = snd_pcm_apply_appl_ptr(substream, appl_ptr);
> +		if (err < 0)
> +			goto _end_unlock;
> 
>  		offset += frames;
>  		size -= frames;
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index 7bc4a0bbad6f..0b176b35ade1 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -2456,9 +2456,11 @@ static int do_pcm_hwsync(struct
> snd_pcm_substream *substream)
>  }
> 
>  /* update to the given appl_ptr and call ack callback if needed;
> - * when an error is returned, take back to the original value
> + * when an error is returned, take back to the original value.
> + * The given argument should have valid value as application pointer on PCM
> + * buffer.
>   */
> -static int apply_appl_ptr(struct snd_pcm_substream *substream,
> +int snd_pcm_apply_appl_ptr(struct snd_pcm_substream *substream,
>  			  snd_pcm_uframes_t appl_ptr)
>  {
>  	struct snd_pcm_runtime *runtime = substream->runtime;
> @@ -2492,7 +2494,7 @@ static snd_pcm_sframes_t forward_appl_ptr(struct
> snd_pcm_substream *substream,
>  	appl_ptr = runtime->control->appl_ptr + frames;
>  	if (appl_ptr >= (snd_pcm_sframes_t)runtime->boundary)
>  		appl_ptr -= runtime->boundary;
> -	ret = apply_appl_ptr(substream, appl_ptr);
> +	ret = snd_pcm_apply_appl_ptr(substream, appl_ptr);
>  	return ret < 0 ? ret : frames;
>  }
> 
> @@ -2512,7 +2514,7 @@ static snd_pcm_sframes_t rewind_appl_ptr(struct
> snd_pcm_substream *substream,
>  	appl_ptr = runtime->control->appl_ptr - frames;
>  	if (appl_ptr < 0)
>  		appl_ptr += runtime->boundary;
> -	ret = apply_appl_ptr(substream, appl_ptr);
> +	ret = snd_pcm_apply_appl_ptr(substream, appl_ptr);
>  	return ret < 0 ? ret : frames;
>  }
> 
> @@ -2644,7 +2646,8 @@ static int snd_pcm_sync_ptr(struct
> snd_pcm_substream *substream,
>  	}
>  	snd_pcm_stream_lock_irq(substream);
>  	if (!(sync_ptr.flags & SNDRV_PCM_SYNC_PTR_APPL)) {
> -		err = apply_appl_ptr(substream, sync_ptr.c.control.appl_ptr);
> +		err = snd_pcm_apply_appl_ptr(substream,
> +					     sync_ptr.c.control.appl_ptr);
>  		if (err < 0) {
>  			snd_pcm_stream_unlock_irq(substream);
>  			return err;

These functions will be modified again by other upcoming patchsets, so
I'd like not to touch so much for minor optimization at this stage.
Let's postpone that after all settled down.


thanks,

Takashi
