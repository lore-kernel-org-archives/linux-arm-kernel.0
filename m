From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Sep 2013 10:41:17 +0100
Subject: BUG: sleeping function called from invalid context at
 arch/arm/mm/fault.c:301
In-Reply-To: <m3mwnaa4sk.fsf@t19.piap.pl>
References: <m3mwnaa4sk.fsf@t19.piap.pl>
Message-ID: <20130918094117.GT12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 18, 2013 at 10:54:19AM +0200, Krzysztof Ha?asa wrote:
> ipx435, v3.11, the card hw has gone wild (another issue) and generates
> data abort on register access in ISR. The issue here is the warning in
> do_page_fault(), is it normal?

It is normal if the data abort gets caused from a non-atomic context.
The real question is what is solo_isr() doing causing a data abort
in the first place.

I suspect it's this great bit of coding in free_solo_dev():

                pci_iounmap(pdev, solo_dev->reg_base);
                if (pdev->irq)
                        free_irq(pdev->irq, solo_dev);

So, what happens if you receive an IRQ (possibly shared by other PCI
devices) but you've unmapped the registers?

        status = solo_reg_read(solo_dev, SOLO_IRQ_STAT);
        if (!status)
                return IRQ_NONE;

where solo_reg_read() does this:
        ret = readl(solo_dev->reg_base + reg);

Yep, we try to read from memory we've just unmapped.

It's a driver bug.  Please report this to the driver authors.
