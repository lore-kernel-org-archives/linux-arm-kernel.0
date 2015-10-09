From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Fri, 9 Oct 2015 13:47:35 +0000
Subject: [PATCH v3] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
In-Reply-To: <5613F310.6060305@arm.com>
References: <1444146289-28940-1-git-send-email-bharatku@xilinx.com>
 <5613F310.6060305@arm.com>
Message-ID: <8520D5D51A55D047800579B09414719801690DEC@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi Bharat,
>> > Adding PCIe Root Port driver for Xilinx PCIe NWL bridge IP.
> >
> > +/* SSPL ERROR */
> > +#define SLVERR					0x02
> > +#define DECERR					0x03
> > +
> > +struct nwl_msi {			/* struct nwl_msi - MSI information
> */
> > +	struct msi_controller chip;	/* chip: MSI controller */
> 
> We're moving away from msi_controller altogether, as the kernel now has all
> the necessary infrastructure to do this properly.
> 
> Please convert this driver to msi domains (see drivers/pci/host/pci-xgene-
> msi.c or the gic-v2m driver as examples of how this is being done).

As suggested I have gone through the code in pci-gene-msi.c for msi domains, 
and have gone through IRQ Domain documentation. 
I mainly observe when we have more than one interrupt controller involved
between device and cpu we use "Hierarchy IRQ domain" (parent and child msi domains). But in our case we 
don't have any such Hierarchy and we have single interrupt controller.
In such case is it necessary to use multiple domains in software which actually isn't case in hardware.

Thanks 
Bharat
> 
> > +	DECLARE_BITMAP(used, INT_PCI_MSI_NR);	/* used: Declare
> Bitmap
> > +						for MSI	*/
> > +	struct irq_domain *domain;	/* domain: IRQ domain pointer */
> > +	unsigned long pages;		/* pages: MSI pages */
> 
> Overall, I think it would make sense to split the PCIe controller driver and the
> MSI controller (in separate files as well).
> 
> Please keep me posted on the updates.
> 
> Thanks,
> 
> 	M.
> --
> Jazz is not dead. It just smells funny...
