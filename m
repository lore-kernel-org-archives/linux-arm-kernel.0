From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 12 Nov 2014 15:46:58 +0100 (CET)
Subject: [RFC Part4 v1 00/17] Refine support of non-PCI-compliant Message
In-Reply-To: <546364FA.7010806@arm.com>
References: <1415545839-28263-1-git-send-email-jiang.liu@linux.intel.com>
 <546364FA.7010806@arm.com>
Message-ID: <alpine.DEB.2.11.1411121512270.3935@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Nov 2014, Marc Zyngier wrote:
> This patch introduces two optionnal fields to the msi_chip structure:
> - a pointer to an irq domain, describing the MSI domain associated
>   with this msi_chip. To be populated with msi_create_irq_domain.
> - a domain_alloc_irqs() callback that has the same purpose as
>   arch_setup_msi_irqs(), with the above domain as an additional
>   parameter.
> 
> If both of these fields are non-NULL, then domain_alloc_irqs() is
> called, bypassing the setup_irq callback. This allows the MSI driver
> to use the domain stacking feature without mandating core support in
> the architecture.

I'd rather have the callback in the irqdomain itself. Along with a
callback to free the interrupts.

AFAICT is msi_chip more or less a wrapper around the actual MSI irq
domain. So we rather move towards assigning irqdomain to the pci bus
and get rid of msi_chip instead of adding another level of obscure
indirection through msi_chip.

Thanks,

	tglx
