From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Sep 2013 16:07:30 +0100
Subject: BUG: sleeping function called from invalid context at
 arch/arm/mm/fault.c:301
In-Reply-To: <m3ioxy9tck.fsf@t19.piap.pl>
References: <m3mwnaa4sk.fsf@t19.piap.pl>
 <20130918094117.GT12758@n2100.arm.linux.org.uk> <m3ioxy9tck.fsf@t19.piap.pl>
Message-ID: <20130918150730.GU12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 18, 2013 at 03:01:31PM +0200, Krzysztof Ha?asa wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> > I suspect it's this great bit of coding in free_solo_dev():
> 
> 		/* Now cleanup the PCI device */
> 		solo_irq_off(solo_dev, ~0);
> 		pci_iounmap(pdev, solo_dev->reg_base);
> 		if (pdev->irq)
> 			free_irq(pdev->irq, solo_dev);
> 
> solo_irq_off() tries to disable IRQ by masking the hw line but I guess
> there may be some time window in which a problem may show up.
> Anyway, there is no reason to unmap registers before free_irq().

Except that it's part of debugging shared interrupts.

Remember, any driver which is still hooked into the IRQ handling subsystem
with a shared interrupt can still receive an interrupt at any moment due
to another device on that shared interrupt line raising its request.

So, in order to find buggy drivers, the IRQ layer will call a shared
interrupt handler immediately upon registration, and also upon freeing.

So, it's not a spurious IRQ, it's an attempt by the IRQ layer to find
buggy drivers, and it's done exactly that.  It's working as designed.
