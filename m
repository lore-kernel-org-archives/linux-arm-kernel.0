From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 26 Jul 2016 13:01:59 +0200 (CEST)
Subject: [PATCH v11 09/10] genirq/msi: map/unmap the MSI doorbells on
 msi_domain_alloc/free_irqs
In-Reply-To: <f8e83628-5fb0-70d4-c32c-237d190ec98f@redhat.com>
References: <1468933367-23159-1-git-send-email-eric.auger@redhat.com>
 <1468933367-23159-10-git-send-email-eric.auger@redhat.com>
 <alpine.DEB.2.11.1607201016060.3564@nanos>
 <75f5e846-6ca4-4178-e7aa-fed90e45e546@redhat.com>
 <alpine.DEB.2.11.1607261022330.19896@nanos>
 <f8e83628-5fb0-70d4-c32c-237d190ec98f@redhat.com>
Message-ID: <alpine.DEB.2.11.1607261202250.19896@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Jul 2016, Auger Eric wrote:
> On 26/07/2016 11:00, Thomas Gleixner wrote:
> > In your case you don't want to have a partial allocation, so instead of
> > playing silly games with desc->irq you should add a flag which tells the PCI
> > code that you are not interested in a partial allocation and that it should
> > return an error code instead.
> 

> In that case can we consider we even succeeded in allocating 1 MSI? In case
> the IOMMU mapping fails, the MSI transaction will never reach the target MSI
> frame so it is not usable. So when you mean "partial" I understand we did
> not succeed in allocating maxvec IRQs, correct? Here we succeeded in
> allocating 0 IRQ and still msi_capability_init returns 1.
>
> msi_capability_init doc-comment says "a positive return value indicates the
> number of interrupts which could have been allocated."
> 
> I understand allocation success currently only depends on the fact virq was
> allocated and set to desc->irq. But with that IOMMU stuff doesn't the
> criteria changes?

Right. But then you need to express it differently in a consistent way. Not by
hacking around it by setting desc->irq to 0.

Something like a flag field in msi_desc which denotes various properties would
be a possible solution. MSI_IRQ_ALLOCATED and MSI_IRQ_REMAPPED would be
sufficient for now. And the deallocation/cleanup would rely on those flags
rather than checking desc->irq.

Thanks,

	tglx
