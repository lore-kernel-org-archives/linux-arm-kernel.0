From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Thu, 19 Feb 2015 19:54:06 +0100
Subject: [PATCH 1/6] ASoC: max98088: Document DT bindings
In-Reply-To: <54E62E1C.4030105@suse.de>
References: <1424283959-16289-1-git-send-email-afaerber@suse.de>	<1424283959-16289-2-git-send-email-afaerber@suse.de>	<54E5EB36.9020007@collabora.co.uk>	<54E5EF73.2090302@suse.de>
 <CAD=FV=VoFnbEsKi4mDDkaTrTXboJmm0UNV5iCk1CvV5ndEZtsA@mail.gmail.com>
 <54E62E1C.4030105@suse.de>
Message-ID: <54E6314E.5060509@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 19.02.2015 um 19:40 schrieb Andreas F?rber:
> Am 19.02.2015 um 18:48 schrieb Doug Anderson:
>> On Thu, Feb 19, 2015 at 6:13 AM, Andreas F?rber <afaerber@suse.de> wrote:
>>>> I see that a master clock (mclk) is added in patch 6/6 but the
>>>> max98088 codec driver does handle this clock.
>>>>
>>>> If the SoC XCLKOUT provides the master clock to the max98089
>>>> codec in Spring like is the case for the max9809{0,5} codecs
>>>> in the Snow and Peach Pit/Pi Chromebooks then you need to do
>>>> something along the lines of the following commits:
>>>>
>>>> e3048c3d2be5 ASoC: max98095: Add master clock handling
>>>> b10ab7b838bd ASoC: max98090: Add master clock handling
>>>>
>>>> If that's the case you also have to mention in the DT binding
>>>> doc that "clocks" and "clock-names" are optional properties
>>>> like Documentation/devicetree/bindings/sound/max9809{0,5}.txt.
>>>
>>> When I prepared this patch, I believe it was a straight copy from
>>> max98090. Sounds like they changed since then.
>>>
>>> My 6/6 adopted the mclk clock from your now-cancelled v2 patch for Snow,
>>> assuming it would be the same on all Chromebooks. I tested that last
>>> change by checking for errors in dmesg.
>>>
>>> Doug, can you advise on how the clock wiring is for Spring?
>>
>> I can confirm that XCLKOUT is connected to the codec MCLK on the
>> Spring schematics I have.
> 
> Thanks! I updated max98088 and had it working on first boot, but on
> second boot it complained about the frequency:
> 
> [    7.896834] max98088 7-0010: revision A
> [    7.912776] snow-audio sound: HiFi <-> 3830000.i2s mapping ok
> [    7.919367] max98088 7-0010: Invalid master clock frequency
> [    7.919429] snow-audio sound: ASoC: Spring-I2S-MAX98089 late_probe()
> failed: -22
> [    7.920019] snow-audio sound: snd_soc_register_card failed (-22)
> [    7.920109] snow-audio: probe of sound failed with error -22

Reproducible on third boot.

On a suspicion, the fourth boot I waited for the double-beep of the
firmware (waiting for Ctrl+d/u), and then it did work.

So it seems the mclk is not always set up properly by the kernel,
relying on firmware. Who's in charge of setting that clock up?

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Jennifer Guild, Dilip Upmanyu,
Graham Norton; HRB 21284 (AG N?rnberg)
