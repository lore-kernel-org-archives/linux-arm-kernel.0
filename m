From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 29 Aug 2018 16:11:13 +0200
Subject: ASoC: pxa: remove pxa2xx-pcm driver, which caused regression
In-Reply-To: <1e1c5084-840d-a378-7c57-def6d6c0a096@gmail.com> (Petr Cvek's
 message of "Wed, 29 Aug 2018 03:32:26 +0200")
References: <f12148b7c9102c67d92a0467f1d653e37c6548ee.1534534854.git.petrcvekcz@gmail.com>
 <87r2iwau3u.fsf@belgarion.home>
 <4deb5304-8efc-3093-7f8e-0dfe50781790@gmail.com>
 <87mutjbidr.fsf@belgarion.home>
 <16bb94b6-089d-f78e-1bb7-2550414be2fb@gmail.com>
 <878t4u96wq.fsf@belgarion.home>
 <1e1c5084-840d-a378-7c57-def6d6c0a096@gmail.com>
Message-ID: <87y3cp6z5q.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petrcvekcz@gmail.com> writes:
> Hi guys,
>
> ...the continuation of a sound fix for (not only) HTC magician
>
> I think I got it now. It seems mioa701_wm9713 calls snd_pcm_new() twice
> (once in pxa2xx-ac97.c and once in mioa701_wm9713.c by
> devm_snd_soc_register_card() .
Mmh no, at least no if you're speaking of sound/soc/pxa/pxa2xx-ac97.c.

I placed a printk in snd_pcm_new(), and it is called 2 times from
mioa701_wm9713.c, to register the wm9713-hifi and wm9713-aux devices.

Now if you speak of sound/arm/pxa2xx-ac97.c, it should never be selected in an
"soc" variant, whenre sound/soc/pxa/pxa2xx-ac97.c should be used.

> Problem on non AC97 boards is as follows:
>
> As defined in machine's struct snd_soc_dai_link the individual
> components' .pcm_new() gets called. The first will be the component
> .cpu_dai_name="pxa-ssp-dai.0" and by definition in pxa-ssp.c this calls
> pxa2xx_soc_pcm_new() which allocates DMA.
>
> The problem is when the second component's .pcm_new() is called by the
> definition .platform_name = "pxa-pcm-audio" which calls again
> pxa2xx_soc_pcm_new() which allocates the DMA for the second time.
>
> This problem should be same for the most of the PXA boards, which are
> using SSP.
Ok, I suppose you have checked this with a printk, WARN_ON() be sure, right ?
And could you send me you .config, just to be sure we're on the same page on the
drivers you're using.

If that's the case, Daniel would you have a look into it please ?

> The PXA27x DMA controller doesn't support a full 8192 bytes per
> transmission (limited by .period_bytes_max), but only up to 8191 bytes
> (o_O), so any DMA buffer request must be in multiples of like 8160 bytes
> (or less, 8160 itself must be in the multiples of 32). This hw
> constraint gets set by calling pxa2xx_pcm_open(). The problem is
> snd-soc-dummy registers its own dummy_dma_open() and indeed it gets
> called after pxa2xx_pcm_open() and rewrites the values by its own dummy
> data. (Un)luckily the value gets overwritten to 8192 bytes and DMA
> allocation fails.
Very true. I hope you're using CONFIG_PXA_DMA=1 and not CONFIG_MMP_PDMA, this
will enable us to debug when things will get out of control.

> Can somebody give me suggestions how to fix this? Changing the
> .period_bytes_max value in snd-soc-dummy works, deleting
> dummy_dma_open() works, changing pxa2xx_soc_platform_probe() to just
> return works too (that's why I've decided pxa2xx-pcm.c could be
> removed). But all these changes are ugly and not usable.
At least we must find a way to have :
 - pxa2xx_pcm_open() called only once
 - pxa-pcm-audio shoud be used for SSP based PXA boards

I'll wait for Daniel to comment on that, he's more advanced in the sound
framework understanding than I am.

Cheers.

-- 
Robert
