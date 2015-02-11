From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 11 Feb 2015 17:17:01 +0000
Subject: [PATCH v4 3/5] irqchip: Add DT binding doc for the virtual irq
 demuxer chip
In-Reply-To: <20150211173823.30c42c6a@bbrezillon>
References: <1422527620-8308-1-git-send-email-boris.brezillon@free-electrons.com>
 <2437801.56xPyk3atd@vostro.rjw.lan>
 <20150211151237.GN9154@leverpostej>
 <1487331.cgC9j5u0aF@vostro.rjw.lan>
 <20150211155720.GQ9154@leverpostej>
 <20150211171515.55d5066f@bbrezillon>
 <20150211163231.GR9154@leverpostej>
 <20150211173823.30c42c6a@bbrezillon>
Message-ID: <20150211171701.GT9154@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 11, 2015 at 04:38:23PM +0000, Boris Brezillon wrote:
> On Wed, 11 Feb 2015 16:32:31 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > On Wed, Feb 11, 2015 at 04:15:15PM +0000, Boris Brezillon wrote:
> > > On Wed, 11 Feb 2015 15:57:20 +0000
> > > Mark Rutland <mark.rutland@arm.com> wrote:
> > > 
> > > > [...]
> > > > 
> > > > > > > > So for the flag at request time approach to work, all the drivers using
> > > > > > > > the interrupt would have to flag they're safe in that context.
> > > > > > > 
> > > > > > > Something like IRQF_"I can share the line with a timer" I guess?  That wouldn't
> > > > > > > hurt and can be checked at request time even.
> > > > > > 
> > > > > > I guess that would have to imply IRQF_SHARED, so we'd have something
> > > > > > like:
> > > > > > 
> > > > > > IRQF_SHARED_SUSPEND_OK - This handler is safe to call spuriously during
> > > > > > 			 suspend in the case the line is shared. The
> > > > > > 			 handler will not access unavailable hardware
> > > > > > 			 or kernel infrastructure during this period.
> > > > > > 
> > > > > > #define __IRQF_SUSPEND_SPURIOUS		0x00040000
> > > > > > #define	IRQF_SHARED_SUSPEND_OK		(IRQF_SHARED | __IRQF_SUSPEND_SPURIOUS)
> > > > > 
> > > > > What about
> > > > > 
> > > > > #define __IRQF_TIMER_SIBLING_OK	0x00040000
> > > > > #define	IRQF_SHARED_TIMER_OK	(IRQF_SHARED | __IRQF_TIMER_SIBLING_OK)
> > > > > 
> > > > > The "suspend" part is kind of a distraction to me here, because that really
> > > > > only is about sharing an IRQ with a timer and the "your interrupt handler
> > > > > may be called when the device is suspended" part is just a consequence of that.
> > > > 
> > > > My rationale was that you didn't really care who else was using the IRQ
> > > > (e.g. the timer); you're just stating that you can survive being called
> > > > during suspend (which is what the driver may need to check for in the
> > > > handler if the device happens to be powered down or whatever).
> > > > 
> > > > So I guess I see it the other way around. This is essentially claiming
> > > > we can handle sharing with IRQF_NO_SUSPEND rather than IRQF_TIMER.
> > > > 
> > > > > So IMO it's better to have "TIMER" in the names to avoid encouraging people to
> > > > > abuse this for other purposes not related to timers.
> > > > 
> > > > In the end a name is a name, and if you think IRQF_SHARED_TIMER_OK is
> > > > better I shan't complain.
> > > > 
> > > > The fundamental issue I'm concerned with is addressed by this approach.
> > > 
> > > Okay then, is anyone taking care of submitting such a patch (Mark ?) ?
> > 
> > I'll have the core patch shortly.
> > 
> > I'll need to ask for your help tagging the relevant drivers and testing.
> 
> For the list of impacted drivers, you can have a look at this series [1]
> (patches 2 to 5), and I'll take care of the testing part once every one
> has agreed on the solution ;-).
> 
> [1]https://lkml.org/lkml/2014/12/15/552

Thanks for the link.

I'll take a look at this once Rafael's given the core patch a once-over.

Thanks,
Mark.
