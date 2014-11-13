From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 13 Nov 2014 11:27:39 +0000
Subject: [RFC Part4 v1 00/17] Refine support of non-PCI-compliant Message
In-Reply-To: <alpine.DEB.2.11.1411121512270.3935@nanos>
References: <1415545839-28263-1-git-send-email-jiang.liu@linux.intel.com>
 <546364FA.7010806@arm.com> <alpine.DEB.2.11.1411121512270.3935@nanos>
Message-ID: <546495AB.9050308@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 12/11/14 14:46, Thomas Gleixner wrote:
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

I can see that putting the irq domain at the bus level makes a lot of 
sense (assuming nobody tries to have multiple MSI controllers per bus...).

So I'm starting with something like this:

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 640a1ec..07e50fc 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -41,6 +41,7 @@ struct irq_domain;
 struct of_device_id;
 struct irq_chip;
 struct irq_data;
+struct device;
 
 /* Number of irqs reserved for a legacy isa controller */
 #define NUM_ISA_INTERRUPTS	16
@@ -76,6 +77,10 @@ struct irq_domain_ops {
 		     unsigned int nr_irqs);
 	void (*activate)(struct irq_domain *d, struct irq_data *irq_data);
 	void (*deactivate)(struct irq_domain *d, struct irq_data *irq_data);
+	int (*prepare_alloc_irqs)(struct irq_domain *d, struct device *dev,
+				  unsigned int nr_irqs, int type);
+	int (*cleanup_free_irqs)(struct irq_domain *d, struct device *dev,
+				 unsigned int virq, unsigned int nr_irqs);
 #endif
 };

How do you see this behaving? At the moment, I have the "prepare" callback
directly calling into pci_msi_domain_alloc_irqs() so that the irqs get
created, but I have the nagging feeling that it's not what you want... ;-)
The main issue I can see is that if more than one domain in the stack
implements that, who gets to call pci_msi_domain_alloc_irqs?

If we try to decouple those two, there is a problem with the creation of
the intermediate structure (the irq_alloc_info that's in Jiang's patches),
as this is a arch/driver/whatever specific structure.

For reference, I've pushed out my current branch (very much a work in
progress):
http://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/branch-from-hell

The commits related to this discussion are:
http://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/branch-from-hell&id=56ea48e6389fe461cb3ddf01e19afcdcd8f12f66
and
http://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/branch-from-hell&id=855ab8b937967854dd070de2d0aaa07639e19526

as well as the code making use of that:
http://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git/tree/drivers/irqchip/irq-gic-v3-its.c?h=irq/branch-from-hell&id=9f8ed988c2411831b7512006642e484c151e9a7a#n1184

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
