From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Nov 2011 12:51:36 +0000
Subject: [PATCHv2 02/10] ARM: vic: MULTI_IRQ_HANDLER handler
In-Reply-To: <CACRpkdY+EBkHfupO5T4SYKPxzX2L2kr8fLVMJK=JctNeYAzn2g@mail.gmail.com>
References: <1317206507-18867-1-git-send-email-jamie@jamieiles.com>
	<1317206507-18867-3-git-send-email-jamie@jamieiles.com>
	<20110928203905.GB2838@ponder.secretlab.ca>
	<CACRpkdZKns-GraGp-YMD6jzOPETkvEpt9bC8HcYUmf3JUyCV3A@mail.gmail.com>
	<20110929093009.GM17204@pulham.picochip.com>
	<20111102134024.GE19187@n2100.arm.linux.org.uk>
	<20111102140811.GA22491@totoro>
	<CACRpkdY+EBkHfupO5T4SYKPxzX2L2kr8fLVMJK=JctNeYAzn2g@mail.gmail.com>
Message-ID: <20111103125136.GL12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2011 at 01:29:08PM +0100, Linus Walleij wrote:
> No, if we receive another IRQ *after* the read of the register was the
> question, right?
> 
> Just replace
> 
> stat &= ~(1 << irq);
> 
> with a second
> 
> stat = readl_relaxed(vic->base + VIC_IRQ_STATUS);
> 
> It'll work just fine, the IRQ line should be low when you read
> it the second time, else it is probably fully proper to call
> the IRQ handler again anyway.

It depends on what kind of behaviour you want.  There are two solutions:

	stat = readl_relaxed(vic->base + VIC_IRQ_STATUS);
	while (stat) {
		irq = ffs(stat) - 1;
		handle_irq(irq);
		stat = readl_relaxed(vic->base + VIC_IRQ_STATUS);
	}

This gives priority to the lowest numbered interrupts; if these get stuck
then they can exclude higher numbered interrupts.  This is what we
implement in the assembly code versions, and as far as I know, no one has
ever complained about that behaviour.

	stat = readl_relaxed(vic->base + VIC_IRQ_STATUS);
	while (stat) {
		while (stat) {
			irq = ffs(stat) - 1;
			stat &= ~(1 << irq);
			handle_irq(irq);
		}
		stat = readl_relaxed(vic->base + VIC_IRQ_STATUS);
	}

This ensures that we process all interrupts found pending before we
re-check for any new interrupts pending.  Arguably this is a much
fairer implementation (and may mean if things get irrevokably stuck,
things like sysrq via the console uart may still work.)
