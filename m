From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Wed, 18 Sep 2013 15:01:31 +0200
Subject: BUG: sleeping function called from invalid context at
 arch/arm/mm/fault.c:301
In-Reply-To: <20130918094117.GT12758@n2100.arm.linux.org.uk> (Russell King's
 message of "Wed, 18 Sep 2013 10:41:17 +0100")
References: <m3mwnaa4sk.fsf@t19.piap.pl>
 <20130918094117.GT12758@n2100.arm.linux.org.uk>
Message-ID: <m3ioxy9tck.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

>> ipx435, v3.11, the card hw has gone wild (another issue) and generates
>> data abort on register access in ISR. The issue here is the warning in
>> do_page_fault(), is it normal?
>
> It is normal if the data abort gets caused from a non-atomic context.

Hmm, the ISR should be an atomic context...

#define in_atomic()     ((preempt_count() & ~PREEMPT_ACTIVE) != 0)

I think a hardware IRQ is supposed to add_preempt_count() via
irq_enter() -> __irq_enter()? How could in_atomic() return 0?
A delayed, imprecise abort?

> The real question is what is solo_isr() doing causing a data abort
> in the first place.

Right.

> I suspect it's this great bit of coding in free_solo_dev():

		/* Now cleanup the PCI device */
		solo_irq_off(solo_dev, ~0);
		pci_iounmap(pdev, solo_dev->reg_base);
		if (pdev->irq)
			free_irq(pdev->irq, solo_dev);

solo_irq_off() tries to disable IRQ by masking the hw line but I guess
there may be some time window in which a problem may show up.
Anyway, there is no reason to unmap registers before free_irq().

> Yep, we try to read from memory we've just unmapped.

> It's a driver bug.  Please report this to the driver authors.

Right (that's a "staging" driver and I better fix it myself).
Thanks.
-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
