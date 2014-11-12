From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Wed, 12 Nov 2014 22:52:57 +0800
Subject: [RFC Part4 v1 00/17] Refine support of non-PCI-compliant Message
In-Reply-To: <alpine.DEB.2.11.1411121512270.3935@nanos>
References: <1415545839-28263-1-git-send-email-jiang.liu@linux.intel.com>
 <546364FA.7010806@arm.com> <alpine.DEB.2.11.1411121512270.3935@nanos>
Message-ID: <54637449.4070302@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/11/12 22:46, Thomas Gleixner wrote:
> On Wed, 12 Nov 2014, Marc Zyngier wrote:
>> This patch introduces two optionnal fields to the msi_chip structure:
>> - a pointer to an irq domain, describing the MSI domain associated
>>   with this msi_chip. To be populated with msi_create_irq_domain.
>> - a domain_alloc_irqs() callback that has the same purpose as
>>   arch_setup_msi_irqs(), with the above domain as an additional
>>   parameter.
>>
>> If both of these fields are non-NULL, then domain_alloc_irqs() is
>> called, bypassing the setup_irq callback. This allows the MSI driver
>> to use the domain stacking feature without mandating core support in
>> the architecture.
> 
> I'd rather have the callback in the irqdomain itself. Along with a
> callback to free the interrupts.
> 
> AFAICT is msi_chip more or less a wrapper around the actual MSI irq
> domain. So we rather move towards assigning irqdomain to the pci bus
> and get rid of msi_chip instead of adding another level of obscure
> indirection through msi_chip.
Hi Thomas and Marc,

I'm trying to replace all weak functions , such as
arch_setup_msi_irqs()/arch_setup_msi_irq(), in drivers/pci/msi.c.

The framework core changes are almost ready, but it does take time
to convert current arch_setup_msi_irqs() implementations to new
irqdomain interfaces.

Not sure whether it's the right direction to go:(
Regards!
Gerry
> 
> Thanks,
> 
> 	tglx
> 
