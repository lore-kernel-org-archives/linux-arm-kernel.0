From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 5 Oct 2016 11:02:36 +0300
Subject: [PATCH 6/6] ARM: da850: adjust memory settings for tilcdc
In-Reply-To: <CAMpxmJW=JgXvM8Rnk40nXxNL7dcqX2jU6HCR2MtQZXRJMd-UZw@mail.gmail.com>
References: <1475166715-7857-1-git-send-email-bgolaszewski@baylibre.com>
 <1475166715-7857-7-git-send-email-bgolaszewski@baylibre.com>
 <4e089d20-d00f-ff54-7c54-85aa061e23c2@ti.com>
 <CAMpxmJXafyT5G8ZyD8RBAtzD6R9HmvyS0NBpz5i2fJ0SwOhXBA@mail.gmail.com>
 <91db8934-bfd6-8fc4-74e3-4844ef3bd3e7@ti.com>
 <CAMpxmJW=JgXvM8Rnk40nXxNL7dcqX2jU6HCR2MtQZXRJMd-UZw@mail.gmail.com>
Message-ID: <0b6b9bdd-c761-7c54-54ac-3313f38af159@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/16 12:20, Bartosz Golaszewski wrote:
> 2016-09-30 21:19 GMT+02:00 Peter Ujfalusi <peter.ujfalusi@ti.com>:
>> On 09/30/2016 06:06 PM, Bartosz Golaszewski wrote:
>>>
>>> Just ran a quick test with speaker-test -c2 -twav. Besides the fact
>>> that the left and right channels are inverted (I'm looking into that),
>>> I didn't notice any problems. Even at 1024x768 resolution, playing
>>> audio at the same time seems to work fine.
>>
> 
> Hi Peter
> 
>> That's good to hear, but I think the priorities should be set:
>> LCDC and EDMA30TC1 to highest priority
>> EDMA30TC0 to priority 2
>>
>> The 0TC0 is used by MMC and if you want to play a video you might need the
>> servicing TC to be higher priority then other masters.
>>
>> If audio playback would trigger sync losts in lcdc then we might need to move
>> 0TC1 to priority 1.
>>
> 
> Did you mean "set EDMA31TC0 to priority 2"? EDMA30TC0 is already at
> the highest priority. Or did you mean that we need to lower the
> EDMA30TC0 priority? In that case: is 2 the correct value? EDMA31TC0 is
> used by mmc1 and its priority is 4. Shouldn't we set both to be the
> same?

What I mean is:
EMDA30TC1 = LCDC = 0;
EDMA30TC0 = 2;

I don't know what the MMC1 is used on the LCDK, but it is only used by add-on
card on Logic's OMAP-L138 EVM (wifi if I recall right). I would leave
EDMA31TC0 as 4.

And while we are here: this is my problem, I don't want LCDC to be high
priority on OMAP-L138 EVM as it has no display by default, no point of
fiddling with the EMIF priority there.

This is the reason why we should have a way via DT to set these priorities. A
DT fragment for OMAP-L138 EVM's wifi module might want to increase the
EDMA31TC0 priority to get better throughput, but on a bare board we don't want
that. If I would have the display module for the EVM, I would like to rise the
LCDC priority also, but I don't have one. If I have the aduio add-on module I
would want to keep audio as the highest priority (and the MMC0 to be able to
record/play audio files). etc.

>> I agree that LCDC priority needs to be higher, but I do wonder why the default
>> (5) is not working and if it is not working why it is 5...
>>
>> My guess is that the change in the PBBPR register is the one actually helping
>> here.
>>
> 
> While it seems that lowering the EDMA30TC0 priority is indeed
> unnecessary, if I don't set the LCDC master to priority 0, I still get
> FIFO underflows even with the change in PBBPR.

I believe it is valid to raise the LCDC priority, but I wonder what blocks the
LCDC accesses when you don't really have anything going on in the background.

-- 
P?ter
