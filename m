From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 03 Feb 2015 10:38:25 +0000
Subject: [PATCH] PCI: Fix pcibios_update_irq misuse of irq number
In-Reply-To: <4145359.V8A0ARGtXz@wuerfel>
References: <1422456683-797-1-git-send-email-marc.zyngier@arm.com>
 <4145359.V8A0ARGtXz@wuerfel>
Message-ID: <54D0A521.7030405@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/02/15 17:02, Arnd Bergmann wrote:
> On Wednesday 28 January 2015 14:51:23 Marc Zyngier wrote:
>>  void __weak pcibios_update_irq(struct pci_dev *dev, int irq)
>>  {
>> -       dev_dbg(&dev->dev, "assigning IRQ %02d\n", irq);
>> -       pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
>> +       struct irq_data *d;
>> +
>> +       d = irq_get_irq_data(irq);
>> +#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
>> +       while (d->parent_data)
>> +               d = d->parent_data;
>> +#endif
>> +       dev_dbg(&dev->dev, "assigning IRQ %02ld\n", d->hwirq);
>> +       pci_write_config_byte(dev, PCI_INTERRUPT_LINE, d->hwirq);
>>  }
> 
> I'm puzzled by this. Why is it even important what we write into
> the config space? Isn't this just an interface between BIOS and
> OS for systems that rely on the interrupt numbers to be statically
> assigned before boot?

That's exactly what I thought until Lorenzo reported kvmtool falling
over because of this write. Obviously, some platforms must actually
require this (possibly for bridges that are not known by the firmware).

Entirely removing that code solves my problem too, but that'd cannot be
the right solution...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
