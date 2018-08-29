From: petrcvekcz@gmail.com (Petr Cvek)
Date: Wed, 29 Aug 2018 03:32:26 +0200
Subject: ASoC: pxa: remove pxa2xx-pcm driver, which caused regression
In-Reply-To: <878t4u96wq.fsf@belgarion.home>
References: <f12148b7c9102c67d92a0467f1d653e37c6548ee.1534534854.git.petrcvekcz@gmail.com>
 <87r2iwau3u.fsf@belgarion.home>
 <4deb5304-8efc-3093-7f8e-0dfe50781790@gmail.com>
 <87mutjbidr.fsf@belgarion.home>
 <16bb94b6-089d-f78e-1bb7-2550414be2fb@gmail.com>
 <878t4u96wq.fsf@belgarion.home>
Message-ID: <1e1c5084-840d-a378-7c57-def6d6c0a096@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 25.8.2018 v 10:39 Robert Jarzmik napsal(a):
> Petr Cvek <petrcvekcz@gmail.com> writes:
> 
>> Dne 18.8.2018 v 21:10 Robert Jarzmik napsal(a):
>>> Petr Cvek <petrcvekcz@gmail.com> writes:
>>>
>>>> My bad I've forgot to add "select SND_PXA2XX_LIB" from removed
>>>> SND_PXA2XX_SOC, now it should compile, can you test it if it works now?
>>>> fixed patch in [1].
>>> Still NAK.
>>>
>>> You must realise that as long as you will delete sound/soc/pxa/pxa2xx-pcm.c,
>>> I'll block the patch, as it is being used for music playback on several pxa
>>> platforms, at least the AC97 based ones.
>>>
>> I know I will send the magician only patch. I've just wanted to know how
>> it is working with AC97 ;-) (+ it is still a good test for possible
>> future changes).
>>
>>>> BTW can you try insmod-aplay-stop-rmmod with the current -next on your
>>>> board?
> 
> Ok, I just did that.
> I based my work on linux-next, plus one extra patch which
> was lost in my last submissions :
> https://groups.google.com/forum/#!topic/linux.kernel/0iw-VDxIyZk
> 
> I insmoded the modules, called aplay, heard the music, rmmoded all the modules,
> then insmoded again, called aplay, and rmmoded again. Everything worked
> smoothly.

Hi guys,

...the continuation of a sound fix for (not only) HTC magician

I think I got it now. It seems mioa701_wm9713 calls snd_pcm_new() twice
(once in pxa2xx-ac97.c and once in mioa701_wm9713.c by
devm_snd_soc_register_card() . This doesn't cause a double DMA
allocation (as both will be for the different "card"). Still you should
have allocated unused DMA resources somewhere on mioa by
pxa2xx_soc_pcm_new() from pxa2xx-pcm.c (= dead code).

Problem on non AC97 boards is as follows:

As defined in machine's struct snd_soc_dai_link the individual
components' .pcm_new() gets called. The first will be the component
.cpu_dai_name="pxa-ssp-dai.0" and by definition in pxa-ssp.c this calls
pxa2xx_soc_pcm_new() which allocates DMA.

The problem is when the second component's .pcm_new() is called by the
definition .platform_name = "pxa-pcm-audio" which calls again
pxa2xx_soc_pcm_new() which allocates the DMA for the second time.

This problem should be same for the most of the PXA boards, which are
using SSP.

A trivial comment-out of .platform_name works sometimes works, as
drivers without .platform_name record gets supplied by snd-soc-dummy.
And this solution has yet another problem.

The PXA27x DMA controller doesn't support a full 8192 bytes per
transmission (limited by .period_bytes_max), but only up to 8191 bytes
(o_O), so any DMA buffer request must be in multiples of like 8160 bytes
(or less, 8160 itself must be in the multiples of 32). This hw
constraint gets set by calling pxa2xx_pcm_open(). The problem is
snd-soc-dummy registers its own dummy_dma_open() and indeed it gets
called after pxa2xx_pcm_open() and rewrites the values by its own dummy
data. (Un)luckily the value gets overwritten to 8192 bytes and DMA
allocation fails.

Can somebody give me suggestions how to fix this? Changing the
.period_bytes_max value in snd-soc-dummy works, deleting
dummy_dma_open() works, changing pxa2xx_soc_platform_probe() to just
return works too (that's why I've decided pxa2xx-pcm.c could be
removed). But all these changes are ugly and not usable.

Thanks for help.

best regards,
Petr
