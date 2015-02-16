From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 16 Feb 2015 10:28:14 +0100
Subject: [PATCH v4 3/5] irqchip: Add DT binding doc for the virtual irq
 demuxer chip
In-Reply-To: <1487331.cgC9j5u0aF@vostro.rjw.lan>
References: <1422527620-8308-1-git-send-email-boris.brezillon@free-electrons.com>
 <2437801.56xPyk3atd@vostro.rjw.lan>
 <20150211151237.GN9154@leverpostej>
 <1487331.cgC9j5u0aF@vostro.rjw.lan>
Message-ID: <20150216092814.GF7119@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Guys, trim your emails, please!

On Wed, Feb 11, 2015 at 04:51:36PM +0100, Rafael J. Wysocki wrote:
> On Wednesday, February 11, 2015 03:12:38 PM Mark Rutland wrote:
> > I guess that would have to imply IRQF_SHARED, so we'd have something
> > like:
> > 
> > IRQF_SHARED_SUSPEND_OK - This handler is safe to call spuriously during
> > 			 suspend in the case the line is shared. The
> > 			 handler will not access unavailable hardware
> > 			 or kernel infrastructure during this period.
> > 
> > #define __IRQF_SUSPEND_SPURIOUS		0x00040000
> > #define	IRQF_SHARED_SUSPEND_OK		(IRQF_SHARED | __IRQF_SUSPEND_SPURIOUS)
> 
> What about
> 
> #define __IRQF_TIMER_SIBLING_OK	0x00040000
> #define	IRQF_SHARED_TIMER_OK	(IRQF_SHARED | __IRQF_TIMER_SIBLING_OK)
> 
> The "suspend" part is kind of a distraction to me here, because that really
> only is about sharing an IRQ with a timer and the "your interrupt handler
> may be called when the device is suspended" part is just a consequence of that.
> 
> So IMO it's better to have "TIMER" in the names to avoid encouraging people to
> abuse this for other purposes not related to timers.

Sorry to be late to the bike-shed party, but what about:

Documentation/power/suspend-and-interrupts.txt:the IRQ's users.  For this reason, using IRQF_NO_SUSPEND and IRQF_SHARED at the

arch/arm/mach-omap2/mux.c:		omap_hwmod_mux_handle_irq, IRQF_SHARED | IRQF_NO_SUSPEND,
arch/arm/mach-omap2/pm34xx.c:		_prcm_int_handle_io, IRQF_SHARED | IRQF_NO_SUSPEND, "pm_io",
drivers/mfd/ab8500-debugfs.c:				   IRQF_SHARED | IRQF_NO_SUSPEND,
drivers/mfd/ab8500-gpadc.c:			IRQF_NO_SUSPEND | IRQF_SHARED, "ab8500-gpadc-sw",
drivers/mfd/ab8500-gpadc.c:			IRQF_NO_SUSPEND | IRQF_SHARED, "ab8500-gpadc-hw",
drivers/pinctrl/pinctrl-single.c:				  IRQF_SHARED | IRQF_NO_SUSPEND,
drivers/power/ab8500_btemp.c:			IRQF_SHARED | IRQF_NO_SUSPEND,
drivers/power/ab8500_charger.c:			IRQF_SHARED | IRQF_NO_SUSPEND,
drivers/power/ab8500_fg.c:			IRQF_SHARED | IRQF_NO_SUSPEND,
drivers/rtc/rtc-pl031.c:	.irqflags = IRQF_SHARED | IRQF_NO_SUSPEND,
drivers/usb/phy/phy-ab8500-usb.c:				IRQF_NO_SUSPEND | IRQF_SHARED,
drivers/usb/phy/phy-ab8500-usb.c:				IRQF_NO_SUSPEND | IRQF_SHARED,
drivers/usb/phy/phy-ab8500-usb.c:				IRQF_NO_SUSPEND | IRQF_SHARED,
drivers/watchdog/intel-mid_wdt.c:			       IRQF_SHARED | IRQF_NO_SUSPEND, "watchdog",

Is there a single legitimate user in that list? If so, the TIMER name
might be misleading.
