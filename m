From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 19 Feb 2011 10:54:57 +0100
Subject: platform/i2c busses: pm runtime and system sleep
In-Reply-To: <20110218202744.GA19427@n2100.arm.linux.org.uk>
References: <AANLkTinyDE3OxKup_aqsN8HJH_r5LcwkP17OtuMRpACx@mail.gmail.com>
	<201102181928.05911.rjw@sisk.pl>
	<AANLkTi=j9KeX2TSzMaKMWR6GpXjFcsjp0z8Rt+ArLXiV@mail.gmail.com>
	<201102182120.29977.rjw@sisk.pl>
	<20110218202744.GA19427@n2100.arm.linux.org.uk>
Message-ID: <AANLkTim2TfG-18XN3r9m3Rq68ZD6QHUY7X82E4-XWH83@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/2/18 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> Do we have any pressing need to convert AMBA stuff? ?I haven't heard any
> reason yet to convert them to runtime PM - they don't even make any
> runtime PM calls.
>
> Maybe Linus can comment on the PM stuff as he has SoCs with these in.
> As my boards don't have any sensible PM support, I don't have any
> visibility of what PM facilities would be required.

Sure, basically I ACK Rabins patch and his reasoning for it. (BTW
Rabin spends most of his days working on the Ux500 SoCs too.)

The runtime PM we need for Ux500 is to switch off silicon core
voltage first and foremost. The call I've added to switch of a core
voltage regulator will need to be called when the silicon is idle.

In spi/amba-pl022.c I take the most brutal approach with a recent
patch: hammer off this core switch (and clock) whenever the hardware
is not used. This is simple in this driver since it has no state to preserve
across transfers, it is written such that the core is loaded with the
appropriate state for each message.

Continuing this approach we run into two problems with this
and other drivers:

-  Hammering off/on the clock+voltage is causing delays in HW
   so what you want is some hysteresis (usually, wait a few us/ms
   then switch off) - sort of a takeoff/landing effect.

-  Modelling voltage domains as regulators is nice, but require
   us to switch on/off from process context, so we cannot do this
   from interrupt handlers.

Both of these problems are solved by elegance if we use runtime
PM, since it will provide a hysteresis timeout that can be triggered
from interrupt context and call the idling hooks in process context.

Yours,
Linus Walleij
