From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Fri, 20 Feb 2015 01:36:56 +0100
Subject: [PATCH 1/6] ASoC: max98088: Document DT bindings
In-Reply-To: <54E64C09.5000505@collabora.co.uk>
References: <1424283959-16289-1-git-send-email-afaerber@suse.de>	<1424283959-16289-2-git-send-email-afaerber@suse.de>	<54E5EB36.9020007@collabora.co.uk>	<54E5EF73.2090302@suse.de>
 <CAD=FV=VoFnbEsKi4mDDkaTrTXboJmm0UNV5iCk1CvV5ndEZtsA@mail.gmail.com>
 <54E62E1C.4030105@suse.de> <54E6314E.5060509@suse.de>
 <54E64C09.5000505@collabora.co.uk>
Message-ID: <54E681A8.6040702@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 19.02.2015 um 21:48 schrieb Javier Martinez Canillas:
> On 02/19/2015 07:54 PM, Andreas F?rber wrote:
>> Am 19.02.2015 um 19:40 schrieb Andreas F?rber:
>>> I updated max98088 and had it working on first boot, but on
>>> second boot it complained about the frequency:
>>>
>>> [    7.896834] max98088 7-0010: revision A
>>> [    7.912776] snow-audio sound: HiFi <-> 3830000.i2s mapping ok
>>> [    7.919367] max98088 7-0010: Invalid master clock frequency
>>> [    7.919429] snow-audio sound: ASoC: Spring-I2S-MAX98089 late_probe()
>>> failed: -22
>>> [    7.920019] snow-audio sound: snd_soc_register_card failed (-22)
>>> [    7.920109] snow-audio: probe of sound failed with error -22
>>
> 
> I had the same error on Snow but even on the first boot and after doing some
> code archeology, I found the following commit [0] in a Samsung downstream
> tree that solves the issue.
> 
> The problem is that clk_round_rate(max98095->mclk, freq) returns 0 as the
> rounded rate if XCLOUT is not allowed to be re-parented on rate change.

Same on Spring:

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 1aa81321afba..46dc64675c26 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -1365,6 +1365,7 @@ static int max98088_dai_set_sysclk(struct
snd_soc_dai *dai,

        if (!IS_ERR(max98088->mclk)) {
                freq = clk_round_rate(max98088->mclk, freq);
+               dev_warn(codec->dev, "freq = %u\n", freq);
                clk_set_rate(max98088->mclk, freq);
        }


> With Tushar's patch I see that clk_round_rate() returns 24000000 (24MHz)
> so the codec driver setups the correct PLL clock.

Ditto. With the clkout reparenting patch, clk_round_rate() returns 24MHz
just like when double-beep-initialized. However when not
double-beep-initialized, the driver initializes, but no audible output,
so there must be another missing puzzle piece.

>> On a suspicion, the fourth boot I waited for the double-beep of the
>> firmware (waiting for Ctrl+d/u), and then it did work.
>>
>> So it seems the mclk is not always set up properly by the kernel,
>> relying on firmware. Who's in charge of setting that clock up?
> 
> Right, it seems audio is only working due the firmware doing some previous
> setup. Probably it works on every boot if you have "sound init" as a part of
> the u-boot boot commands?

Indeed it does, 24 MHz without the reparenting patch, and sound working.

'sound init' code:
https://github.com/afaerber/u-boot/blob/spring/drivers/sound/max98088.c

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Jennifer Guild, Dilip Upmanyu,
Graham Norton; HRB 21284 (AG N?rnberg)
