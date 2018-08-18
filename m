From: petrcvekcz@gmail.com (Petr Cvek)
Date: Sat, 18 Aug 2018 15:00:29 +0200
Subject: ASoC: pxa: remove pxa2xx-pcm driver, which caused regression
In-Reply-To: <87r2iwau3u.fsf@belgarion.home>
References: <f12148b7c9102c67d92a0467f1d653e37c6548ee.1534534854.git.petrcvekcz@gmail.com>
 <87r2iwau3u.fsf@belgarion.home>
Message-ID: <4deb5304-8efc-3093-7f8e-0dfe50781790@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Dne 18.8.2018 v 11:42 Robert Jarzmik napsal(a):
> petrcvekcz at gmail.com writes:
> 
>> From: Petr Cvek <petrcvekcz@gmail.com>
>>
>> The switch of PXA to dmaengine caused a regression for devices which are
>> using SSP/I2S and probably AC97. The problem is in multiple allocation
>> of DMA by function pxa2xx_soc_pcm_new() called by pxa-pcm-audio and
>> (SSP/I2S/AC97). The regression was found on HTC Magician and after playback
>> kernel generates an oops:
> With AC97, this is still continuously tested and works fine, and the pcm part is
> what makes aplay happy for playing music. This is used both in a devicetree and
> non devicetree build, which makes me thing the AC97 part is fine, and the
> SSP/I2S needs some love.
> 
I was looking into the code and if there is no .platform_name present
soc_bind_dai_link() will just use "snd-soc-dummy" as the name.

> With your patch, a compilation of mioa701 fails with [1].
> 
My bad I've forgot to add "select SND_PXA2XX_LIB" from removed
SND_PXA2XX_SOC, now it should compile, can you test it if it works now?
fixed patch in [1].

BTW can you try insmod-aplay-stop-rmmod with the current -next on your
board?

> Therefore, I'll NAK this patch, as removing SND_PAX2XX_SOC config is a bad idea.
> 
> As a way forward, please submit a patch for magician only, which makes it work
> again (by work I mean you can play and hear a song with aplay or equivalent).
> 
> Then hopefully Daniel can interpolate to all the SSP/I2S platforms. And maybe
> Daniel can test on his platform too so that we're safe on both pxa2xx and pxa3xx
> side.
> 

OK I can do that, (I can speak only for I2S and SSP) but if fixed patch
work it should be fine.

best regards
Petr

Attached:
[1] Fixed patch v2, forgotten "select SND_PXA2XX_LIB"
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ASoC-pxa-remove-pxa2xx-pcm-driver-which-caused-regre.patch
Type: text/x-patch
Size: 23727 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180818/86106b7e/attachment-0001.bin>
