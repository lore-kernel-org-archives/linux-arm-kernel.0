From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 12 Mar 2012 09:00:23 +0100
Subject: [PATCH 10/11] ARM: tegra: pcie: Add MSI support
In-Reply-To: <4F59213F.6070107@wwwdotorg.org>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
 <1331218291-16119-11-git-send-email-thierry.reding@avionic-design.de>
 <4F59213F.6070107@wwwdotorg.org>
Message-ID: <20120312080023.GA13788@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren wrote:
> On 03/08/2012 07:51 AM, Thierry Reding wrote:
> > diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c
> 
> > +static int tegra_pcie_enable_msi(struct platform_device *pdev)
> > +{
> > +	struct tegra_pcie_info *pcie = platform_get_drvdata(pdev);
> > +	volatile void *pages;
> > +	unsigned long base;
> > +	unsigned int msi;
> > +	int msi_base;
> > +	int err;
> > +	u32 reg;
> > +
> > +	mutex_init(&pcie->msi_lock);
> > +
> > +	msi_base = irq_alloc_descs(-1, 0, INT_PCI_MSI_NR, 0);
> > +	if (msi_base < 0) {
> > +		dev_err(&pdev->dev, "failed to allocate IRQs\n");
> > +		return msi_base;
> > +	}
> > +
> > +	pcie->msi_domain = irq_domain_add_legacy(pcie->dev->of_node,
> > +						 INT_PCI_MSI_NR, msi_base,
> > +						 0, &irq_domain_simple_ops,
> > +						 NULL);
> > +	if (!pcie->msi_domain) {
> > +		dev_err(&pdev->dev, "failed to create IRQ domain\n");
> 
> Free the IRQ descriptors in the error paths?
> 
> > +		return -ENOMEM;
> > +	}
> > +
> > +	pcie->msi_chip.name = "PCIe-MSI";
> > +	pcie->msi_chip.irq_enable = unmask_msi_irq;
> > +	pcie->msi_chip.irq_disable = mask_msi_irq;
> > +	pcie->msi_chip.irq_mask = mask_msi_irq;
> > +	pcie->msi_chip.irq_unmask = unmask_msi_irq;
> > +
> > +	for (msi = 0; msi < INT_PCI_MSI_NR; msi++) {
> > +		unsigned int irq = irq_find_mapping(pcie->msi_domain, msi);
> > +
> > +		irq_set_chip_data(irq, pcie);
> > +		irq_set_chip_and_handler(irq, &pcie->msi_chip,
> > +					 handle_simple_irq);
> > +		set_irq_flags(irq, IRQF_VALID);
> > +	}
> > +
> > +	err = platform_get_irq(pdev, 1);
> > +	if (err < 0) {
> > +		dev_err(&pdev->dev, "failed to get IRQ: %d\n", err);
> 
> Same here, and undo setting IRQF_VALID?

Does it make sense to explicitly unset the IRQF_VALID flag when the IRQ
descriptors are free'd afterwards anyway? I also think it would be necessary
to free the struct irq_domain, but I wasn't able to find any function that
does this other than just calling kfree(), which obviously wouldn't be
enough. Maybe Grant can shed some light onto this. I'm also Cc'ing Thomas
Gleixner as maintainer of the IRQ subsystem, he probably knows best how
dynamically allocated interrupts should be cleaned up.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120312/33a4109c/attachment-0001.sig>
