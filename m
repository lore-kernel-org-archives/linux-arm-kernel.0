From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 16 Feb 2015 12:23:43 +0000
Subject: [PATCH v4 3/5] irqchip: Add DT binding doc for the virtual irq
 demuxer chip
In-Reply-To: <20150216092814.GF7119@twins.programming.kicks-ass.net>
References: <1422527620-8308-1-git-send-email-boris.brezillon@free-electrons.com>
 <2437801.56xPyk3atd@vostro.rjw.lan>
 <20150211151237.GN9154@leverpostej>
 <1487331.cgC9j5u0aF@vostro.rjw.lan>
 <20150216092814.GF7119@twins.programming.kicks-ass.net>
Message-ID: <20150216122343.GA8994@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> > The "suspend" part is kind of a distraction to me here, because that really
> > only is about sharing an IRQ with a timer and the "your interrupt handler
> > may be called when the device is suspended" part is just a consequence of that.
> > 
> > So IMO it's better to have "TIMER" in the names to avoid encouraging people to
> > abuse this for other purposes not related to timers.
> 
> Sorry to be late to the bike-shed party, but what about:

[...]

> arch/arm/mach-omap2/mux.c:		omap_hwmod_mux_handle_irq, IRQF_SHARED | IRQF_NO_SUSPEND,
> arch/arm/mach-omap2/pm34xx.c:		_prcm_int_handle_io, IRQF_SHARED | IRQF_NO_SUSPEND, "pm_io",
> drivers/pinctrl/pinctrl-single.c:				  IRQF_SHARED | IRQF_NO_SUSPEND,

These are chained IRQ handlers. If any of these have a chained timer irq
then the IRQF_NO_SUSPEND may be legitimate. I can't imagine why these
would be shared, however.

It also looks like these abuse IRQF_NO_SUSPEND for wakeup interrupts.

> drivers/rtc/rtc-pl031.c:	.irqflags = IRQF_SHARED | IRQF_NO_SUSPEND,

This looks to be an abuse and should use {enable,disable}_irq_wake.

However, we'd then need to handle mismatch with wakeup interrupts (which
is effectively the same problem as sharing with a timer).

> drivers/mfd/ab8500-debugfs.c:				   IRQF_SHARED | IRQF_NO_SUSPEND,
> drivers/mfd/ab8500-gpadc.c:			IRQF_NO_SUSPEND | IRQF_SHARED, "ab8500-gpadc-sw",
> drivers/mfd/ab8500-gpadc.c:			IRQF_NO_SUSPEND | IRQF_SHARED, "ab8500-gpadc-hw",
> drivers/power/ab8500_btemp.c:			IRQF_SHARED | IRQF_NO_SUSPEND,
> drivers/power/ab8500_charger.c:			IRQF_SHARED | IRQF_NO_SUSPEND,
> drivers/power/ab8500_fg.c:			IRQF_SHARED | IRQF_NO_SUSPEND,
> drivers/usb/phy/phy-ab8500-usb.c:				IRQF_NO_SUSPEND | IRQF_SHARED,
> drivers/usb/phy/phy-ab8500-usb.c:				IRQF_NO_SUSPEND | IRQF_SHARED,
> drivers/usb/phy/phy-ab8500-usb.c:				IRQF_NO_SUSPEND | IRQF_SHARED,

All the *ab8500* look cargo-culted. There's other nonsense in these
(e.g. mutex_lock in irq handlers...). I suspect these are not
legitimate.

> drivers/watchdog/intel-mid_wdt.c:			       IRQF_SHARED | IRQF_NO_SUSPEND, "watchdog",

Watchdogs could be a legitimate case, but this driver relies on another
timer and the timeout irq handler simply calls panic(), which seems a
little extreme.

> Is there a single legitimate user in that list? If so, the TIMER name
> might be misleading.

The watchdog case could be legitimate, and with drivers corrected to use
{enable,disable}_irq_wake we'll need to handle mismatch for wakeup
interrupts too.

Having separate flags for sharing with timers and sharing with wakeup
sources seems redundant, and IRQF_SHARED_TIMER_OK would be misleading.

Thanks,
Mark.
