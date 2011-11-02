From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 2 Nov 2011 14:08:11 +0000
Subject: [PATCHv2 02/10] ARM: vic: MULTI_IRQ_HANDLER handler
In-Reply-To: <20111102134024.GE19187@n2100.arm.linux.org.uk>
References: <1317206507-18867-1-git-send-email-jamie@jamieiles.com>
	<1317206507-18867-3-git-send-email-jamie@jamieiles.com>
	<20110928203905.GB2838@ponder.secretlab.ca>
	<CACRpkdZKns-GraGp-YMD6jzOPETkvEpt9bC8HcYUmf3JUyCV3A@mail.gmail.com>
	<20110929093009.GM17204@pulham.picochip.com>
	<20111102134024.GE19187@n2100.arm.linux.org.uk>
Message-ID: <20111102140811.GA22491@totoro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 02, 2011 at 01:40:24PM +0000, Russell King - ARM Linux wrote:
> On Thu, Sep 29, 2011 at 10:30:09AM +0100, Jamie Iles wrote:
> > +#ifdef CONFIG_MULTI_IRQ_HANDLER
> > +static void vic_single_handle_irq(struct vic_device *vic, struct pt_regs *regs)
> > +{
> > +	u32 stat, irq;
> > +
> > +	stat = readl_relaxed(vic->base + VIC_IRQ_STATUS);
> > +	while (stat) {
> > +		irq = ffs(stat) - 1;
> > +		handle_IRQ(irq_domain_to_irq(&vic->domain, irq), regs);
> > +		stat &= ~(1 << irq);
> > +	}
> > +}
> > +
> > +asmlinkage void __exception_irq_entry vic_handle_irq(struct pt_regs *regs)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < vic_id; ++i)
> > +		vic_single_handle_irq(&vic_devices[i], regs);
> > +}
> 
> And if we receive another interrupt after the read of the register, we'll
> have to exit all the way back (possibly to userspace) before re-entering
> the IRQ handling paths back to this point to process it.

OK, so how about something like this instead:

static int vic_single_handle_irq(struct vic_device *vic,
				 struct pt_regs *regs)
{
	u32 stat, irq;
	int handled = 0;

	stat = readl_relaxed(vic->base + VIC_IRQ_STATUS);
	while (stat) {
		irq = ffs(stat) - 1;
		handle_IRQ(irq_domain_to_irq(&vic->domain, irq), regs);
		stat &= ~(1 << irq);
		handled = 1;
	}

	return handled;
}

asmlinkage void __exception_irq_entry vic_handle_irq(struct pt_regs *regs)
{
	int i, handled;

	do {
		handled = 0;
		for (i = 0; i < vic_id; ++i)
			if (vic_single_handle_irq(&vic_devices[i], regs))
				handled = 1;
	} while (handled);
}

which I think should keep handling IRQ's until no VIC has them pending 
(or as best can be determined).

> Is there any particular reason folk are destroying the built-in efficiency
> of the IRQ handling which is common-place in the existing assembly
> approach?

Well this approach makes a single image kernel a bit easier.  The other 
thing is that it plays a lot nicer with dynamic irq_desc assignment.  
Grant's IRQ domain patches make this quite easy here, but I can't see an 
obvious way to do that with the assembly method.

Jamie
