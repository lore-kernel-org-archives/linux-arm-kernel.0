From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Wed, 4 Nov 2015 12:30:16 +0000
Subject: [PATCH v7] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
In-Reply-To: <5639C681.6060007@arm.com>
References: <1446564227-4704-1-git-send-email-bharatku@xilinx.com>
 <5638DE62.6050605@arm.com>
 <8520D5D51A55D047800579B09414719801693C20@XAP-PVEXMBX01.xlnx.xilinx.com>
 <5639C681.6060007@arm.com>
Message-ID: <8520D5D51A55D047800579B09414719801693D38@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> >> Also, you still lack support for MSI-X (which would come for free...).
> >
> > We don't support MSI-X in root port mode.
> 
> I don't believe you. If you support single MSI, you support MSI-X (because
> that's mostly a property of the endpoint).

In our architecture specification MSI-X is unsupported for Root Port.
> 
> >>> +	.chip = &nwl_msi_irq_chip,
> >>> +};
> >>> +#endif
> >>> +
> >>> +
> >>> +	/* setup AFI/FPCI range */
> >>> +	msi->pages = __get_free_pages(GFP_KERNEL, 0);
> >>> +	base = virt_to_phys((void *)msi->pages);
> >>> +	nwl_bridge_writel(pcie, lower_32_bits(base), I_MSII_BASE_LO);
> >>> +	nwl_bridge_writel(pcie, upper_32_bits(base), I_MSII_BASE_HI);
> >>
> >> I just read this, and I'm puzzled. Actually, puzzled is an
> >> understatement. Why on Earth do you need to give RAM to your MSI
> HW?
> >> This should be a device, not RAM. By the look of it, this could be
> >> absolutely anything. Are you sure you have to supply RAM here?
> >>
> > This is required in our hardware, so that bridge identifies incoming MWr as
> MSI.
> 
> I'm asking why this has to be RAM. What is the actual requirement?

We are allocating RAM for MSI (which is expected) and assigning this address to msi->pages
this is what EP MSI capability will be programmed with.
For the bridge to detect an incoming MWr from EP as MSI, hardware needs to know MSI address
so the same address is programmed in the hardware register for comparison purpose.
It is the actual requirement from hardware.
