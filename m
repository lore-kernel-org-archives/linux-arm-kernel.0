From: petrcvekcz@gmail.com (Petr Cvek)
Date: Wed, 15 Aug 2018 16:29:10 +0200
Subject: ASoC: pxa: possible regressions
In-Reply-To: <d803b938-3212-6485-8786-43dff6e46e6a@zonque.org>
References: <5be00a36-d54b-e8ab-2d5f-4c1870f14aac@gmail.com>
 <58f65d89-c342-026f-6e24-a67fcd625a26@zonque.org>
 <3ff3c732-b598-f2c3-9a0a-cc92f234326b@gmail.com>
 <d803b938-3212-6485-8786-43dff6e46e6a@zonque.org>
Message-ID: <41991989-8f9f-9ca5-94fb-8c0a09c51ada@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 13.8.2018 v 07:54 Daniel Mack napsal(a):
> Hi Petr,
> 
> On Wednesday, August 08, 2018 11:07 AM, Petr Cvek wrote:
>> Dne 8.8.2018 v 07:38 Daniel Mack napsal(a):
> 
>> I was planning to send patches before I've found regressions in the
>> current -next.
>>
>> I think I've had the first working version somewhere around 3.13, but I
>> was updating versions only sporadically and fixing audio had low
>> priority (higher priority got iwmmxt compiler, platform init source
>> code, charger, USB, MMC and IrDA). Some versions until now worked, some
>> didn't.
>>
>> The last version I've used and where the sound worked was
>> 4.14.0-rc7-next from somewhere around 3rd November 2017. The patch for
>> sound subsystem should be the same as the current one.
> 
> That's strange, because as I said, the SSP rework went in in 4.0, so
> without my regression fix (737e370a57e4e8 "ASoC: pxa-ssp: allow more
> flexible setup order"), I doubt SSP had worked for you.
> 

OK I found the problem I've had compiled and load (on both v4.14 and
v4.18) snd-soc-pxa2xx driver (from linux/sound/arm/pxa2xx-pcm.c). This
component calls pxa2xx_soc_pcm_new() which is already called by
snd_soc_pxa_ssp (pxa-ssp-dai.0) or snd_soc_pxa2xx_i2s (pxa2xx-i2s). In
the function the dma gets registered twice, which is a wrong behavior
(kernel oops on DMA stopping). Without snd-soc-pxa2xx driver loaded the
playback works (after the rest of my patches) so it seems in the old
version DMA wasn't registered twice.

So the easy solution for snd_soc_pxa_ssp OR snd_soc_pxa2xx_i2s would be
a mutual exclusivity with snd_soc_pxa_ssp. I don't know about other
users, but I can add a condition to magician Kconfig entry.

Best regards,
Petr
