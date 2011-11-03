From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 3 Nov 2011 15:03:37 +0000
Subject: [PATCHv2 02/10] ARM: vic: MULTI_IRQ_HANDLER handler
In-Reply-To: <20111103133102.GM12913@n2100.arm.linux.org.uk>
References: <1317206507-18867-3-git-send-email-jamie@jamieiles.com>
	<20110928203905.GB2838@ponder.secretlab.ca>
	<CACRpkdZKns-GraGp-YMD6jzOPETkvEpt9bC8HcYUmf3JUyCV3A@mail.gmail.com>
	<20110929093009.GM17204@pulham.picochip.com>
	<20111102134024.GE19187@n2100.arm.linux.org.uk>
	<20111102140811.GA22491@totoro>
	<CACRpkdY+EBkHfupO5T4SYKPxzX2L2kr8fLVMJK=JctNeYAzn2g@mail.gmail.com>
	<20111103125136.GL12913@n2100.arm.linux.org.uk>
	<CACRpkdZ1qfVduMAmusNoLjDoqy2kDA4crN__iW9qEeXBgVT4cA@mail.gmail.com>
	<20111103133102.GM12913@n2100.arm.linux.org.uk>
Message-ID: <20111103150337.GC5008@totoro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2011 at 01:31:02PM +0000, Russell King - ARM Linux wrote:
> On Thu, Nov 03, 2011 at 02:00:15PM +0100, Linus Walleij wrote:
> > On Thu, Nov 3, 2011 at 1:51 PM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > 
> > > ? ? ? ?stat = readl_relaxed(vic->base + VIC_IRQ_STATUS);
> > > ? ? ? ?while (stat) {
> > > ? ? ? ? ? ? ? ?while (stat) {
> > > ? ? ? ? ? ? ? ? ? ? ? ?irq = ffs(stat) - 1;
> > > ? ? ? ? ? ? ? ? ? ? ? ?stat &= ~(1 << irq);
> > > ? ? ? ? ? ? ? ? ? ? ? ?handle_irq(irq);
> > > ? ? ? ? ? ? ? ?}
> > > ? ? ? ? ? ? ? ?stat = readl_relaxed(vic->base + VIC_IRQ_STATUS);
> > > ? ? ? ?}
> > >
> > > This ensures that we process all interrupts found pending before we
> > > re-check for any new interrupts pending. ?Arguably this is a much
> > > fairer implementation (and may mean if things get irrevokably stuck,
> > > things like sysrq via the console uart may still work.)
> > 
> > I really like the looks of this, Jamie can you do it like that?
> > 
> > Maybe some smallish comment about what's going on can be
> > good for future generations reading that code...
> 
> Bear in mind that it gets a little more complex when you have more
> than one VIC, because the outer loop should be across all VICs.

OK, so I think what I posted yesterday does that (updated for slightly 
better naming) and with a description.  In the spirit of fairness 
iterating over the VIC's this way seemed right to me.

/*
 * Handle each interrupt in a single VIC.  Returns non-zero if we've 
 * handled at least one interrupt.  This does a single read of the 
 * status register and handles all interrupts in order from LSB first.
 */
static int handle_one_vic(struct vic_device *vic,
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

/*
 * Keep iterating over all registered VIC's until there are no pending 
 * interrupts.
 */
asmlinkage void __exception_irq_entry vic_handle_irq(struct pt_regs *regs)
{
	int i, handled;

	do {
		for (i = 0, handled = 0; i < vic_id; ++i)
			handled |= vic_single_handle_irq(&vic_devices[i],
							 regs))
	} while (handled);
}

Jamie
