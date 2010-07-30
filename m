From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 Jul 2010 21:08:57 +0100
Subject: [PATCH] ARM: fix regression in RealView after the introduction
	of pclk
In-Reply-To: <AANLkTin2+hwoRmBxaxUi5Rt-9qpJO2N61YQA=0UgVPtm@mail.gmail.com>
References: <1280408722-31995-1-git-send-email-linus.walleij@stericsson.com>
	<20100729135639.GE18923@n2100.arm.linux.org.uk>
	<AANLkTi=xcFsL7vCtG31v0yWfkBV+vYqQZ4z=_p-=wZnH@mail.gmail.com>
	<20100729222114.GC28330@n2100.arm.linux.org.uk>
	<AANLkTin2+hwoRmBxaxUi5Rt-9qpJO2N61YQA=0UgVPtm@mail.gmail.com>
Message-ID: <20100730200857.GA15062@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 30, 2010 at 05:27:28PM +0200, Linus Walleij wrote:
> In the PB1176 manual there is a drawing of the clock tree, it
> shows that the fixed 24MHz reference clock is divided by a binary
> divider down to 1 MHz. So this one is likewise set in stone. I would
> be surprised if some other scheme was used for the other boards.

That's not quite the full story, because there's this in the code:

        /*
         * set clock frequency:
         *      REALVIEW_REFCLK is 32KHz
         *      REALVIEW_TIMCLK is 1MHz
         */
        val = readl(__io_address(REALVIEW_SCTL_BASE));
        writel((REALVIEW_TIMCLK << REALVIEW_TIMER1_EnSel) |
               (REALVIEW_TIMCLK << REALVIEW_TIMER2_EnSel) |
               (REALVIEW_TIMCLK << REALVIEW_TIMER3_EnSel) |
               (REALVIEW_TIMCLK << REALVIEW_TIMER4_EnSel) | val,
               __io_address(REALVIEW_SCTL_BASE));

which isn't documented in the user manual.  Yet it's necessary in order
to run the timers@1MHz.

> Thinking about it I however see that since some platforms are
> initializing their clocks in .init_irq and some in core_initcall(), some
> in arch_initcall() etc, and since most platforms have some clock
> implementation these dats, it might be worth it to add an
> optional .init_clocks() call to the struct machine_desc and
> MACHINE_START() macro to get this in uniform and call
> that even before .init_irq(). Do you think it's worth it?

It may be, but it's rather a large change to do.  We can certainly
provide the .init_clocks callback so new stuff can use it.
