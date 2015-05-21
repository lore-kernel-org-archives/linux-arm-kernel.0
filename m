From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Fri, 22 May 2015 00:01:03 +0200
Subject: [PATCH v8 07/16] drivers: reset: Add STM32 reset driver
In-Reply-To: <CALszF6Bhc1MkDaqM3oJ93Rrxxbsss7=FA8WUpbtwmDERUdD0KA@mail.gmail.com>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>	<1431158038-3813-8-git-send-email-mcoquelin.stm32@gmail.com>	<555D1C7D.1060205@suse.de>	<CALszF6CrouFF3oS_Qz6+qQRqa4a5PurdYNdvHnZRDb4zwOJ6mQ@mail.gmail.com>	<555E1CC4.9090605@suse.de>
 <CALszF6Bhc1MkDaqM3oJ93Rrxxbsss7=FA8WUpbtwmDERUdD0KA@mail.gmail.com>
Message-ID: <555E559F.8040403@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 21.05.2015 um 21:57 schrieb Maxime Coquelin:
> 2015-05-21 19:58 GMT+02:00 Andreas F?rber <afaerber@suse.de>:
>> Actually, I've updated a timer implementation of mine to invoke a reset
>> controller similar to how you do in the STM32 clocksource patch, but no
>> reset controller is getting returned.
>>
>> It seems to me, you are working around that by simply ignoring the error
>> in the timer code and not doing a reset then, so the STM32 timer does in
>> fact _not_ depend on the reset controller? What happened to your efforts
>> of making the reset controller usable for the timer? In my case, my
>> timer is originally in reset state and needs to be deasserted, so I
>> can't just ignore it.
> 
> Indeed, I made the reset optionnal in the clocksource patch since v3.
> Rob and Arnd said a lot of platform relies on such things are done by
> the bootloader [0].
> I decided to deassert timers reset at bootloader stage, and make it
> optionnal in clocksource driver.
> I made it optionnal in case we decide one day to move reset
> initialization before timer are initialized.
> 
> Note that for now, I still use your bootloader.
> I have done the changes to reset the timers in the afboot-stm32.
> That's the reason why I asked you under which licence it is delivered
> few months ago.

Sorry, too many mails... The stm32 one is GPL-2.0, as parts of it were
derived from a U-Boot fork. (Personally I prefer GPL-2.0+; fm4 and
xmc4000 are MIT/X11.)

> I can share you the patch if you want, even if I understand it is more
> about the concept that you are reluctant.
> 
> On my side, I plan to move to U-Boot soon, as Kamil Lulko added STM32
> support in mainline [1].

You're free to use any bootloader you like, but you will find it
difficult to build in USB etc. drivers given the sheer size of U-Boot.
That was my motivation for writing the tiny one. ;)

> In case of U-Boot, the timer reset should be de-asserted when jumping
> into the Kernel, as Rob mentionned [0].

Thanks, I've updated the xmc4000 one accordingly and can do the same for
stm32. But you are right that I consider that an ugly workaround,
although on the other hand my earlyprintk patches also depend on the
bootloader setting up GPIOs and UART.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Dilip Upmanyu, Graham Norton; HRB
21284 (AG N?rnberg)
