From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Wed, 28 Oct 2015 10:17:22 +0000
Subject: [PATCH v5] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
In-Reply-To: <20151027234032.GA7238@localhost>
References: <1445871386-2377-1-git-send-email-bharatku@xilinx.com>
 <20151027234032.GA7238@localhost>
Message-ID: <8520D5D51A55D047800579B0941471980169316D@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Mon, Oct 26, 2015 at 08:26:26PM +0530, Bharat Kumar Gogada wrote:
> > Adding PCIe Root Port driver for Xilinx PCIe NWL bridge IP.

> > +
> > +	while ((status = nwl_bridge_readl(pcie, MSGF_MSI_STATUS_LO)) !=
> 0) {
> > +		for_each_set_bit(bit, &status, 32) {
> > +			nwl_bridge_writel(pcie, 1 << bit,
> MSGF_MSI_STATUS_LO);
> > +			virq = irq_find_mapping(msi->dev_domain, bit);
> > +			if (virq)
> > +				generic_handle_irq(virq);
> > +		}
> > +	}
> > +
> > +	chained_irq_exit(chip, desc);
> > +}
> 
> These are basically identical.  Can you factor them out somehow to avoid
> repeating the code?

Is it okay if irq_set_chained_handler_and_data being invoked with two different interrupt numbers, but pointing to 
same interrupt handler?

> > +
> > +	pcie->legacy_irq_domain =
> irq_domain_add_linear(legacy_intc_node, 4,
> > +
> 	&legacy_domain_ops,
> > +							pcie);
> > +
> > +	if (!pcie->legacy_irq_domain) {
> > +		dev_err(pcie->dev, "failed to create IRQ domain\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +#ifdef CONFIG_PCI_MSI
> > +	msi->dev_domain = irq_domain_add_linear(NULL,
> INT_PCI_MSI_NR,
> > +					&dev_msi_domain_ops, pcie);
> > +	if (!msi->dev_domain) {
> > +		dev_err(pcie->dev, "failed to create dev IRQ domain\n");
> > +		return -ENOMEM;
> > +	}
> > +	msi->msi_chip.domain = pci_msi_create_irq_domain(node,
> > +
> 	&nwl_msi_domain_info,
> > +							msi->dev_domain);
> > +	if (!msi->msi_chip.domain) {
> > +		dev_err(pcie->dev, "failed to create msi IRQ domain\n");
> > +		irq_domain_remove(msi->dev_domain);
> > +		return -ENOMEM;
> > +	}
> > +#endif
> > +	return 0;
> > +}
> > +
> > +static int nwl_pcie_enable_msi(struct nwl_pcie *pcie, struct pci_bus
> > +*bus) {
> 
> It looks strange to have all the "#ifdef CONFIG_PCI_MSI" above, and here
> we have this long MSI-related function without any ifdefs around it.  Seems
> like this should be ifdef'ed also?  What about nwl_pcie_msi_handler_high(),
> nwl_pcie_msi_handler_low(), nwl_compose_msi_msg(),
> nwl_msi_set_affinity(), etc.?
> 
In probe I'm invoking "nwl_pcie_enable_msi" using "if (IS_ENABLED(CONFIG_PCI_MSI)) " check, since this is at run time 
I haven't kept above mentioned functions under #ifdef CONFIG_PCI_MSI.
The above MSI domain allocation was under ifdef, since if driver was compiled for legacy some of the MSI hierarchy API's and structures aren't available.

> > +	struct platform_device *pdev = to_platform_device(pcie->dev);
> > +	struct nwl_msi *msi = &pcie->msi;

Regards,
Bharat
