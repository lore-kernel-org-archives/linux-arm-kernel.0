From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 02 Nov 2015 22:56:02 +0100
Subject: [PATCH] clocksource: dw_apb_timer_of: support timer-based delay
In-Reply-To: <20151102110334.049b5439@xhacker>
References: <1446193659-1698-1-git-send-email-jszhang@marvell.com>
 <3950525.pKSJGoymu4@wuerfel> <20151102110334.049b5439@xhacker>
Message-ID: <5909853.Bs72yAP0HH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 November 2015 11:03:34 Jisheng Zhang wrote:
> On Fri, 30 Oct 2015 13:42:01 +0100 Arnd Bergmann wrote:
> > 
> > This is not ideal from an overall maintenance perspective. We want to
> > be able to have a kernel with all drivers enabled that gives us the
> > best behavior on all platforms.
> > 
> > The current behavior appears to be that we override all previous
> > registrations as long as the new one is higher resolution. Is that
> > the case here? I.e. does the arch timer have a lower resultion than
> > the dw-apb timer but have some other advantages?
> 
> Take one Marvell Berlin platform for example, the arch timer freq is 25MHZ,
> whose resolution is lower than the dw apb timer at 100MHZ. But dw apb timer
> is on the APB bus while arch timer sits in CPU, so I guess the cost of
> accessing the apb timer is higher than arch timer. 

Ok, I see.

> I have a solution for this case: in platforms with arch timer, I can mark
> the dw apb timer as "disabled" in the dts even though the timer sits there.
> Then I could make DW_APB_TIMER_BASED_DELAY non-optional but selected by the
> the ARCH_XYZ. Is this acceptable?

That would do the right thing, but doesn't look ideal: The DW_APB timer
on those platforms is fully functional, and a future Linux version or
another OS might decide to use both timers for one reason or another.

I'd be happier with a solution that keeps the DT describing the hardware
and not the way we expect Linux to use it, and instead has some heuristic
in the selection of the delay timer. At the moment, we purely base this
on the frequency, which as you say is suboptimal.

One possible way to improve this would be to add an optional 'latency'
property to the DT nodes (or the driver), and use a combination of latency
and resolution to make the decision.
A simpler way would be to always prefer the arch timer on ARM if that
is present, even if another timer has a higher resolution. This should
be only a few additional lines in register_current_timer_delay(), or
possibly an additional function argument.

	Arnd
