From: robert.jarzmik@free.fr (robert.jarzmik at free.fr)
Date: Mon, 16 Feb 2015 12:12:14 +0100 (CET)
Subject: [PATCH RFC 2/2] ARM: pxa: transition to dmaengine phase 1
In-Reply-To: <2708248.TZ13zqn6jW@wuerfel>
Message-ID: <1627069656.469844934.1424085134263.JavaMail.root@zimbra1-e1.priv.proxad.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

----- Mail original -----
De: "Arnd Bergmann" <arnd@arndb.de>
?: linux-arm-kernel at lists.infradead.org
Cc: "Robert Jarzmik" <robert.jarzmik@free.fr>, "Vinod Koul" <vinod.koul@intel.com>, "Olof Johansson" <olof@lixom.net>, "Daniel Mack" <zonque@gmail.com>, "Haojian Zhuang" <haojian.zhuang@gmail.com>, dmaengine at vger.kernel.org, linux-kernel at vger.kernel.org
Envoy?: Lundi 16 F?vrier 2015 11:28:57
Objet: Re: [PATCH RFC 2/2] ARM: pxa: transition to dmaengine phase 1

On Saturday 14 February 2015 23:47:33 Robert Jarzmik wrote:
>> @@ -294,7 +294,8 @@ int pxa_request_dma (char *name, pxa_dma_prio prio,
>>                 /* try grabbing a DMA channel with the requested priority */
>>                 for (i = 0; i < num_dma_channels; i++) {
>>                         if ((dma_channels[i].prio == prio) &&
>> -                           !dma_channels[i].name) {
>> +                           !dma_channels[i].name &&
>> +                           !mmp_pdma_toggle_reserved_channel(i)) {
>>                                 found = 1;
>>                                 break;
>>                         }
>> 

> How is the order between the two enforced? I.e. can it be that the dmaengine
> driver uses the same channel for a different slave before we get here?

If a request is made for a "low prio channel", ie. channel 8, 9 or 10 if I remember
correctly :
 - suppose dmaengine has transactions underway, and channel 8 is busy
 - this loop, for i == 8 : mmp_pdma_toggle_reserved_channel(8) -> -EBUSY
 - loop continues, i == 9 : mmp_pdma_toggle_reserved_channel(8) -> 0
   => pxa_request_dma reserves channel 9

>From now on, mmp_pdma will "skip" channel 9 from its candidates to serve requests.

> If this is ensured to work, I'm fine with your approach.
Actually it does. Not exactly this version, as the mmp_pdma interrupt was a bit
amended to "skip" also reserved channels and not steal events from legacy code,
but that will be for official submission.

It's also designed to be race free, relying on the fact that there is only one
CPU on pxa{2,3}xx SocS (irq_save covers). 

I'm testing it right now with 2 drivers :
 - pxa3xx_nand, which is converted to dmaengine
 - pxamci, which is not converted to dmaengine
In 3 variants :
 - zylonite pxa3xx board booted with device-tree
 - zylonite pxa3xx board booted in legacy
 - mioa701 board booted in device-tree

So far so good. If the mmp_pdma patch is accepted for the transition, it will
open up my path towards dmaengine conversion of all pxa drivers (mmc, nand,
pxa_camera and pxa2xx-pcm-lib). As Daniel has already done most of the work,
and because I have kept it for 2 years, that part will be less a burden than
it would seem ... only the camera will give me a small headache.

Cheers.

--
Robert
