From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 4 Oct 2016 11:20:34 +0200
Subject: [PATCH 6/6] ARM: da850: adjust memory settings for tilcdc
In-Reply-To: <91db8934-bfd6-8fc4-74e3-4844ef3bd3e7@ti.com>
References: <1475166715-7857-1-git-send-email-bgolaszewski@baylibre.com>
 <1475166715-7857-7-git-send-email-bgolaszewski@baylibre.com>
 <4e089d20-d00f-ff54-7c54-85aa061e23c2@ti.com>
 <CAMpxmJXafyT5G8ZyD8RBAtzD6R9HmvyS0NBpz5i2fJ0SwOhXBA@mail.gmail.com>
 <91db8934-bfd6-8fc4-74e3-4844ef3bd3e7@ti.com>
Message-ID: <CAMpxmJW=JgXvM8Rnk40nXxNL7dcqX2jU6HCR2MtQZXRJMd-UZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-09-30 21:19 GMT+02:00 Peter Ujfalusi <peter.ujfalusi@ti.com>:
> On 09/30/2016 06:06 PM, Bartosz Golaszewski wrote:
>>
>> Just ran a quick test with speaker-test -c2 -twav. Besides the fact
>> that the left and right channels are inverted (I'm looking into that),
>> I didn't notice any problems. Even at 1024x768 resolution, playing
>> audio at the same time seems to work fine.
>

Hi Peter

> That's good to hear, but I think the priorities should be set:
> LCDC and EDMA30TC1 to highest priority
> EDMA30TC0 to priority 2
>
> The 0TC0 is used by MMC and if you want to play a video you might need the
> servicing TC to be higher priority then other masters.
>
> If audio playback would trigger sync losts in lcdc then we might need to move
> 0TC1 to priority 1.
>

Did you mean "set EDMA31TC0 to priority 2"? EDMA30TC0 is already at
the highest priority. Or did you mean that we need to lower the
EDMA30TC0 priority? In that case: is 2 the correct value? EDMA31TC0 is
used by mmc1 and its priority is 4. Shouldn't we set both to be the
same?

> I agree that LCDC priority needs to be higher, but I do wonder why the default
> (5) is not working and if it is not working why it is 5...
>
> My guess is that the change in the PBBPR register is the one actually helping
> here.
>

While it seems that lowering the EDMA30TC0 priority is indeed
unnecessary, if I don't set the LCDC master to priority 0, I still get
FIFO underflows even with the change in PBBPR.

Thanks,
Bartosz
