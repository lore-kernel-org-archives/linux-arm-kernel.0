From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Wed, 4 Nov 2015 06:38:45 +0000
Subject: [PATCH v7] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
In-Reply-To: <5638DE62.6050605@arm.com>
References: <1446564227-4704-1-git-send-email-bharatku@xilinx.com>
 <5638DE62.6050605@arm.com>
Message-ID: <8520D5D51A55D047800579B09414719801693C20@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +static struct msi_domain_info nwl_msi_domain_info = {
> > +	.flags = (MSI_FLAG_USE_DEF_DOM_OPS |
> MSI_FLAG_USE_DEF_CHIP_OPS |
> > +		  MSI_FLAG_MULTI_PCI_MSI),
> 
> If you're supporting multi-MSI, how do you ensure that all hwirqs are
> contiguous as required by the spec? Clearly, your allocator doesn't provide
> this guarantee.
> 
Oh ok, then how can we know if one EP is requesting for multiple irq's, because in pci_enable_msi_range,
 it does do while loop according to msi_capability_init return value 
which in turn requests for multiple irq's. Is there any way to find out when single EP requesting for multiple MSI?

> Also, you still lack support for MSI-X (which would come for free...).

We don't support MSI-X in root port mode.
> 
> > +	.chip = &nwl_msi_irq_chip,
> > +};
> > +#endif
> > +
> > +	irq_domain_remove(pcie->legacy_irq_domain);
> > +
> > +#ifdef CONFIG_PCI_MSI
> > +	irq_set_chained_handler_and_data(msi->irq_msi0, NULL, NULL);
> > +	irq_set_chained_handler_and_data(msi->irq_msi1, NULL, NULL);
> > +
> > +	irq_domain_remove(msi->msi_domain);
> > +	irq_domain_remove(msi->dev_domain);
> > +#endif
> > +
> > +}
> 
> Remove these #ifdefs. You can test the validity of these fields before calling
> the various functions. You can also move this to a separate function.

Without #ifdefs if we compile driver for legacy, MSI structures will not be available and we get compile time error.
> 
> > +
> > +	/* setup AFI/FPCI range */
> > +	msi->pages = __get_free_pages(GFP_KERNEL, 0);
> > +	base = virt_to_phys((void *)msi->pages);
> > +	nwl_bridge_writel(pcie, lower_32_bits(base), I_MSII_BASE_LO);
> > +	nwl_bridge_writel(pcie, upper_32_bits(base), I_MSII_BASE_HI);
> 
> I just read this, and I'm puzzled. Actually, puzzled is an understatement. Why
> on Earth do you need to give RAM to your MSI HW?
> This should be a device, not RAM. By the look of it, this could be absolutely
> anything. Are you sure you have to supply RAM here?
> 
This is required in our hardware, so that bridge identifies incoming MWr as MSI.
> > +
> > +	/* Disable high range msi interrupts */
> > +	nwl_bridge_writel(pcie, (u32)~MSGF_MSI_SR_HI_MASK,
> > +MSGF_MSI_MASK_HI);
> > +
> > +

Bharat
