From: eric@anholt.net (Eric Anholt)
Date: Thu, 17 Mar 2016 10:39:28 -0700
Subject: [PATCH 3/6] clk: bcm2835: enable clocks that have been enabled by
 firmware
In-Reply-To: <87vb575ld9.fsf@eliezer.anholt.net>
References: <1456745963-2403-1-git-send-email-kernel@martin.sperl.org>
 <1456745963-2403-4-git-send-email-kernel@martin.sperl.org>
 <87vb575ld9.fsf@eliezer.anholt.net>
Message-ID: <87poutf1gv.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Anholt <eric@anholt.net> writes:

> kernel at martin.sperl.org writes:
>
>> From: Martin Sperl <kernel@martin.sperl.org>
>>
>> If a clock that has been enabled by the firmware gets disabled
>> by a driver this may right now result in a crash of the system
>> as then also the corresponding PLL_dividers as well as PLLs
>> get disabled (if not used) - some of which are used by the
>> VideoCore GPU (which also runs the firmware)
>>
>> This patch prepares/enables those clocks that have been
>> configured by the firmware.
>>
>> Whenever the clock framework implements either
>> CLK_IS_CRITICAL or HAND_OFF this can get changed to use this
>> new mechanism.
>>
>> For this to be completely successful (i.e not missing a clock
>> and subsequently a pll) it is recommended to add all the known
>> clocks of the soc so that this can get applied to all clocks.
>
> I think this makes sense to have, for now at least.
>
> Reviewed-by: Eric Anholt <eric@anholt.net>

Scratch that, this breaks display.  Since the clkgen clocks are flagged
as needing to be gated in order to change dividers, it means you can't
set clock rates for anything that was turned on at boot.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160317/4248041e/attachment-0001.sig>
