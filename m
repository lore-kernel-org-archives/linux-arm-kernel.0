From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Fri, 30 Jul 2010 17:27:28 +0200
Subject: [PATCH] ARM: fix regression in RealView after the introduction of
	pclk
In-Reply-To: <20100729222114.GC28330@n2100.arm.linux.org.uk>
References: <1280408722-31995-1-git-send-email-linus.walleij@stericsson.com>
	<20100729135639.GE18923@n2100.arm.linux.org.uk>
	<AANLkTi=xcFsL7vCtG31v0yWfkBV+vYqQZ4z=_p-=wZnH@mail.gmail.com>
	<20100729222114.GC28330@n2100.arm.linux.org.uk>
Message-ID: <AANLkTin2+hwoRmBxaxUi5Rt-9qpJO2N61YQA=0UgVPtm@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/30 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> On Thu, Jul 29, 2010 at 11:41:44PM +0200, Linus Walleij wrote:
>> Yep that is true, currently. More like this then:
>
> Yup - and the patch is a lot smaller.

OK putting it in the tracker.

>> There is a reason why we have it on the interrupt init in ux500
>> though, and that is that we want to use the clock framework to
>> get the clock for the timer. If we want to fix up the hardcoded
>> way it is currently done in plat-versatile/timer-sp.c we would need
>> a change like this across the versatiles.
>
> I don't think it makes sense to use the clk API for those timers -
> it's rather unclear from the manuals where they get their clocks
> from - or even what the magic bits in the system controller do in
> terms of switching their clock source.

In the PB1176 manual there is a drawing of the clock tree, it
shows that the fixed 24MHz reference clock is divided by a binary
divider down to 1 MHz. So this one is likewise set in stone. I would
be surprised if some other scheme was used for the other boards.

I have a partial patch actually bringing these clocks into the
clkdev framwork but if it makes things complicated for no good
let's just skip it.

Thinking about it I however see that since some platforms are
initializing their clocks in .init_irq and some in core_initcall(), some
in arch_initcall() etc, and since most platforms have some clock
implementation these dats, it might be worth it to add an
optional .init_clocks() call to the struct machine_desc and
MACHINE_START() macro to get this in uniform and call
that even before .init_irq(). Do you think it's worth it?

Yours,
Linus Walleij
