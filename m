From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 19 Feb 2015 11:23:46 +0000
Subject: [PATCH v4 3/5] irqchip: Add DT binding doc for the virtual irq
 demuxer chip
In-Reply-To: <2502710.nOuZfdq5QP@vostro.rjw.lan>
References: <1422527620-8308-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150216092814.GF7119@twins.programming.kicks-ass.net>
 <20150216122343.GA8994@leverpostej>
 <2502710.nOuZfdq5QP@vostro.rjw.lan>
Message-ID: <20150219112346.GA13659@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 19, 2015 at 01:16:50AM +0000, Rafael J. Wysocki wrote:
> On Monday, February 16, 2015 12:23:43 PM Mark Rutland wrote:
> > [...]
> > 
> > > > The "suspend" part is kind of a distraction to me here, because that really
> > > > only is about sharing an IRQ with a timer and the "your interrupt handler
> > > > may be called when the device is suspended" part is just a consequence of that.
> > > > 
> > > > So IMO it's better to have "TIMER" in the names to avoid encouraging people to
> > > > abuse this for other purposes not related to timers.
> > > 
> > > Sorry to be late to the bike-shed party, but what about:
> > 
> > [...]
> > 
> > > arch/arm/mach-omap2/mux.c:		omap_hwmod_mux_handle_irq, IRQF_SHARED | IRQF_NO_SUSPEND,
> > > arch/arm/mach-omap2/pm34xx.c:		_prcm_int_handle_io, IRQF_SHARED | IRQF_NO_SUSPEND, "pm_io",
> > > drivers/pinctrl/pinctrl-single.c:				  IRQF_SHARED | IRQF_NO_SUSPEND,
> > 
> > These are chained IRQ handlers. If any of these have a chained timer irq
> > then the IRQF_NO_SUSPEND may be legitimate. I can't imagine why these
> > would be shared, however.
> > 
> > It also looks like these abuse IRQF_NO_SUSPEND for wakeup interrupts.
> > 
> > > drivers/rtc/rtc-pl031.c:	.irqflags = IRQF_SHARED | IRQF_NO_SUSPEND,
> > 
> > This looks to be an abuse and should use {enable,disable}_irq_wake.
> > 
> > However, we'd then need to handle mismatch with wakeup interrupts (which
> > is effectively the same problem as sharing with a timer).
> 
> IRQF_NO_SUSPEND and wakeup fundamentally don't match due to the way
> wakeup is implemented in the IRQ core now.
> 
> Unless drivers with IRQF_NO_SUSPEND do the wakeup behind the core's back
> which is just disgusting and should never happen.

I completely agree that using IRQF_NO_SUSPEND in that manner is a
disgusting abuse. It seems like some drivers are abusing it for wakeup,
and those need to be corrected.

If those are corrected, the same issue with mismatch will happen with
those wakeup interrupts, and we need to fix that somehow given people
seem to already be relying on being able to share a line with a wakeup
device.

I propose we add a new IRQF_BIKESHED, meaning that this interrupt line
may be shared with an IRQF_NO_SUSPEND or wakeup interrupt handler.
Specifically: 

* This driver ensures that its device will be quiesced during suspend,
  and will not assert interrupts.

* This handler can be called spuriously during suspend (or we somehow
  mask out IRQF_BIKSHED irq actions in the core).

* It will be documented and enforced that each use of IRQF_BIKESHED must
  have an associated comment explaining why the driver has to use it,
  and how it meets the requirements.

With that in place we can audit+fix the drivers sharing the line to use
IRQF_BIKESHED, which solves the warning Boris is seeing. In parallel
with that we can audit+fix the IRQF_NO_SUSPEND abuses to use the correct
infrastructure.

Does that make any sense? I'll have a go at patches on the assumption
that it's not the absolute worst idea, unless/until corrected otherwise.

Thanks,
Mark.
