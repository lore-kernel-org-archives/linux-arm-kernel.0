From: Marc.Zyngier@arm.com (Marc Zyngier)
Date: Wed, 18 May 2011 12:06:33 +0100
Subject: [RFC PATCH v2 02/12] ARM: smp_twd: add support for remapped
	PPI interrupts
In-Reply-To: <4DCC2018.3030007@codeaurora.org>
References: <1304677997-26947-1-git-send-email-marc.zyngier@arm.com>
	<1304677997-26947-3-git-send-email-marc.zyngier@arm.com>
	<4DCC2018.3030007@codeaurora.org>
Message-ID: <1305716793.30788.75.camel@e102391-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-05-12 at 10:59 -0700, Stephen Boyd wrote:
> On 5/6/2011 3:33 AM, Marc Zyngier wrote:
> > diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> > index f29b8a2..30201a0 100644
> > --- a/arch/arm/kernel/smp.c
> > +++ b/arch/arm/kernel/smp.c
> > @@ -452,6 +452,18 @@ asmlinkage void __exception_irq_entry do_local_timer(struct pt_regs *regs)
> >  	set_irq_regs(old_regs);
> >  }
> >  
> > +irqreturn_t percpu_timer_handler(int irq, void *dev_id)
> > +{
> > +	struct clock_event_device *evt = dev_id;
> > +
> > +	if (local_timer_ack()) {
> > +		evt->event_handler(evt);
> > +		return IRQ_HANDLED;
> > +	}
> > +
> > +	return IRQ_NONE;
> > +}
> > +
> 
> MSM needs this second patch again. I suppose it's not titled correctly?
> I'd rather not have MSM use this function at all though. Perhaps its
> better to just hide this in smp_twd.c along with local_timer_ack()?

I'd like to keep the handler in a separate file, as I have an additional
patch set for the A15 timers that are using the same handler.

> What is going on with mach-exynos4/mct.c? Their local_timer_ack() is a
> return 0 and they do a setup_irq() in their local_timer_setup() path.
> That all seems very broken and I would be surprised if hotplug and local
> timer stats worked on that system.

MCT is an odd case. They're using SPI, not PPI, and local_timer_ack() is
only present to please the linker (never called).

Could probably have them to converge as well.

	M.
-- 
Reality is an implementation detail.
-- 
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
