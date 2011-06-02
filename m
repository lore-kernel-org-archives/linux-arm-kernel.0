From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 2 Jun 2011 11:35:26 +0200 (CEST)
Subject: [PATCH 3/3] mach-u300: cleanup clockevent code
In-Reply-To: <4DE6ECAF.9080409@codeaurora.org>
References: <1306876145-6778-1-git-send-email-linus.walleij@stericsson.com>
	<alpine.LFD.2.02.1105312319530.3078@ionos>
	<BANLkTi=UyypKZUQOCCL-KWyAbMQBKY4ccg@mail.gmail.com>
	<alpine.LFD.2.02.1106011027360.3078@ionos>
	<20110601092229.GE3660@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1106011201530.3078@ionos>
	<4DE6ECAF.9080409@codeaurora.org>
Message-ID: <alpine.LFD.2.02.1106021134190.3078@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 1 Jun 2011, Stephen Boyd wrote:
> On 06/01/2011 03:03 AM, Thomas Gleixner wrote:
> > Something like the below should work for both UP and SMP
> >
> > diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
> > index c027d4f..739801b 100644
> > --- a/kernel/time/clockevents.c
> > +++ b/kernel/time/clockevents.c
> > @@ -173,6 +173,12 @@ static void clockevents_notify_released(void)
> >  	}
> >  }
> >  
> > +#ifdef CONFIG_SMP
> > +# define CPU_MASK_CHECK(x)		WARN_ON(!x)
> > +#else
> > +# define CPU_MASK_CHECK(x)		(!x)
> > +#endif
> > +
> >  /**
> >   * clockevents_register_device - register a clock event device
> >   * @dev:	device to register
> > @@ -182,7 +188,8 @@ void clockevents_register_device(struct clock_event_device *dev)
> >  	unsigned long flags;
> >  
> >  	BUG_ON(dev->mode != CLOCK_EVT_MODE_UNUSED);
> > -	BUG_ON(!dev->cpumask);
> > +	if (CPU_MASK_CHECK(dev->cpumask))
> > +		dev->cpumask = cpumask_of(smp_processor_id());
> >  
> >  	raw_spin_lock_irqsave(&clockevents_lock, flags);
> 
> Won't this print a big WARNING on SMP_ON_UP=y and is_smp() == false
> kernels? Is there a generic cross-architecture way to check for SMP at

Need to check that.

> runtime?
> 
> Also, I don't understand the original motivation for this change. The
> assignment to cpumask was there in the u300 timer code already so the
> commit text from Linus is a bit misleading/confusing.

The point is that we can remove these assignements for UP all over the
place and just do it in the core code.
