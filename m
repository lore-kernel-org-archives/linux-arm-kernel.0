From: andrew@ncrmnt.org (Andrew)
Date: Sun, 12 Apr 2015 16:02:12 +0300
Subject: Fwd: Re: [PATCH 2/2] ARM: mvebu: dts: Add dts file for DLink
 DNS-327L
In-Reply-To: <552A6209.9040903@gmail.com>
References: <b6534b962d2cf9d21cb72d43f19a6574@mail.ncrmnt.org>
 <552A6209.9040903@gmail.com>
Message-ID: <cd7445f789f1082f464d464f77807f12@mail.ncrmnt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian Hesselbarth ????? 12.04.2015 15:16:
> On 12.04.2015 13:43, Andrew wrote:
>> Sebastian Hesselbarth ????? 12.04.2015 14:20:
>>> On 11.04.2015 22:29, Andrew Andrianov wrote:
>>>> Signed-off-by: Andrew Andrianov <andrew@ncrmnt.org>
> [...]
>>>> + * CONFIG_ARM_MVEBU_V7_CPUIDLE=y causes hard freezes every 1-8 
>>>> hours
>>> 
>>> I don't think the dts is the right place for Linux issues.
>> 
>> Not sure if that's a hardware weirdness or software issue (yet).
>> Just checked - this goblin is there in 4.0-rc7.
> 
> I understand the issue, but still the dts is not the right place
> for this comment.

Okay, got it.
I'll file a bug about this issue to the the bugzilla. However something
tells me it might not be cpuidle, but D-link. This one's sounds nasty
and it has been around since 3.16.x. How could it go unnoticed?
Unfortunately I have no other armada-370 hardware to test it.

> 
> [...]
>>>> +                marvell,nand-keep-config;
>>>> +                marvell,nand-enable-arbiter;
>>>> +                nand-on-flash-bbt;
>>> 
>>> Do you know the ECC scheme used?
>> 
>> Any hints on how to find it apart from dumping NAND controller 
>> registers
>> from bootloader ?
> 
> From the original bootlog:
> 
> armada-nand armada-nand.0: Initialize HAL based NFC in 8bit mode with
> DMA Disabled using BCH 4bit ECC
> 
> that translates into
> 
> nand-ecc-strength = <4>;
> nand-ecc-step-size = <512>;

Thanks!

> 
> [...]
>>>> +                /* Hardwired into stock bootloader */
>>> 
>>> I don't get the comment above.
>> 
>> The stock u-boot is hacked with a 'failsafe' kernel address.
> 
> Ok, the above partition isn't passed by the bootloader on mtdparts
> cmdline, i.e. that is why you call it "hardwired" ?

As far I got - stock u-boot knows nothing about partition tables and
operates just on raw NAND offsets.

> Just remove the comment, actually the whole partition table is
> "hacked" into the stock bootloader.
> 
>> If for some reason running the 'bootcmd' fails, it reads
>> 5MiBs from partition @ (5d00000 + 0x800) and tries to boot it.
>> There's no way to change this via environment, only by replacing
>> the bootloader.
>> Personally I'm more happy with a simpler partition table, but I
>> guess upstream should be oriented towards the stock bootloader.
> 
> Yeah, leave the original partition table. Any other, smarter
> bootloader can replace it.
> 
> [...]
>> Thanks for the review, I'll resubmit the fixed patchset shortly.
>> Please disregard my [PATCH v2] messages. I've send them the moment 
>> before
>> I noticed your email and review.
> 
> Please always leave the Cc-list in place.

Sorry, I had to resend that email twice. First one to you, next to the 
list
and others. I'm quite new to LKML so still playing with proper email 
setup.

> And you should relax and leave patches there a day or two (or three).
> Not everybody is reading patches immediately.
> 
> We are in no hurry, the current merge window is already closed,
> the new one is 6 weeks away.
> 
> Sebastian

I only have a chance to play with the hardware at the weekend, since the
spare dns327l is at the country house, so I try to send fixes as soon as
get feedback while I can quickly test it.

-- 
Regards,
Andrew
