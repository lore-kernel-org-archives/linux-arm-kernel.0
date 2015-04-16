From: Minghuan.Lian@freescale.com (Minghuan.Lian at freescale.com)
Date: Thu, 16 Apr 2015 10:57:03 +0000
Subject: [PATCH 1/2] irqchip/gicv3-its: Support share device ID
In-Reply-To: <552F8910.9000701@arm.com>
References: <1429091364-31939-1-git-send-email-Minghuan.Lian@freescale.com>
 <1429091364-31939-2-git-send-email-Minghuan.Lian@freescale.com>
 <20150415173654.431f5d89@arm.com>
 <DM2PR0301MB0640576D29E70392C41444DFE2E40@DM2PR0301MB0640.namprd03.prod.outlook.com>
 <552F8910.9000701@arm.com>
Message-ID: <DM2PR0301MB0640C59C08CBEB4F2F392BAEE2E40@DM2PR0301MB0640.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

Thanks for your comments.
I still have a couple of questions,
1. If I add a new flag and all PCI DEVID will be replaced with a fixed ID,  does SMMU can work correctly?
For example, If we insert an  Ethernet card with two ports, a port is assigned to kvm1, another port is assigned to kvm2. In this case, we should use one or two fixed ID?
2. If using PCIe device with SR-IOV, the driver will dynamically create some new PCIe devices. At this time, ITS device may has been created for PF.  So we must previously  create ITS device with a large enough nvesc.
However its_get_pci_alias: dev_alias->count += its_pci_msi_vec_count(dev_alias->pdev) only calculate with the exiting PCIe device, could not meet this requirement.
How to change dev_alias->count?  

Thanks,
Minghuan
  
> -----Original Message-----
> From: Marc Zyngier [mailto:marc.zyngier at arm.com]
> Sent: Thursday, April 16, 2015 6:04 PM
> To: Lian Minghuan-B31939
> Cc: linux-pci at vger.kernel.org; Arnd Bergmann; Hu Mingkai-B21284; Zang
> Roy-R61911; Yoder Stuart-B08248; Bjorn Helgaas; Wood Scott-B07421; linux-
> arm-kernel at lists.infradead.org; Jason Cooper; Thomas Gleixner
> Subject: Re: [PATCH 1/2] irqchip/gicv3-its: Support share device ID
> 
> On 16/04/15 03:57, Minghuan.Lian at freescale.com wrote:
> > Hi Marc,
> >
> > Please see my comments inline
> >
> >> -----Original Message----- From: Marc Zyngier
> >> [mailto:marc.zyngier at arm.com] Sent: Thursday, April 16, 2015 12:37
> >> AM To: Lian Minghuan-B31939 Cc: linux-pci at vger.kernel.org; Arnd
> >> Bergmann; Hu Mingkai-B21284; Zang Roy-R61911; Yoder Stuart-B08248;
> >> Bjorn Helgaas; Wood Scott-B07421; linux-
> >> arm-kernel at lists.infradead.org; Jason Cooper; Thomas Gleixner
> >> Subject: Re: [PATCH 1/2] irqchip/gicv3-its: Support share device ID
> >>
> >> On Wed, 15 Apr 2015 17:49:23 +0800 Minghuan Lian
> >> <Minghuan.Lian@freescale.com> wrote:
> >>
> >>> SMMU of some platforms can only isolate limited device ID. This may
> >>> require that all PCI devices share the same ITS device with the
> >>> fixed device ID. The patch adds function arch_msi_share_devid_update
> >>> used for these platforms to update the fixed device ID and maximum
> >>> MSI interrupts number.
> >>>
> >>> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com> ---
> >>> drivers/irqchip/irq-gic-v3-its.c | 11 +++++++++++ 1 file changed,
> >>> 11 insertions(+)
> >>>
> >>> diff --git a/drivers/irqchip/irq-gic-v3-its.c
> >>> b/drivers/irqchip/irq-gic-v3-its.c index d0374a6..be78d0a 100644
> >>> --- a/drivers/irqchip/irq-gic-v3-its.c +++
> >>> b/drivers/irqchip/irq-gic-v3-its.c @@ -1169,6 +1169,15 @@ static
> >>> int its_get_pci_alias(struct pci_dev *pdev,
> >> u16 alias, void *data)
> >>> return 0; }
> >>>
> >>> +void __weak +arch_msi_share_devid_update(struct pci_dev *pdev,
> >>> u32 *dev_id, u32 +*nvesc) { +	/* +	 * use PCI_DEVID NOT share
> >>> device ID as default +	 * so nothing need to do +	 */ +} +
> >>
> >> NAK. On top of being ugly as sin, this breaks any form of
> >> multiplatform support. No way anything like this is going in. Guys,
> >> you really should know better.
> >>
> > [Minghuan]  The current ITS MSI will create an individual ITS device
> > for each PCIe device, and use PCI_DEVID as ITS dev_id However, out
> > platform only supports  ITS dev_id 0 -63.  A normal PCIe DEVID of
> > 0000:01:00.0 is 256 bigger than 63. Besides, because of the limited
> > dev_id number, all the PCIe device will share the same ITS dev. Our
> > platform provides a hardware module LUT to map PCI DEVID to ITS
> > dev_id.  So, when creating ITS device, we need to update dev_id and
> > the nvesc. I may change pci_for_each_dma_alias to add a new flag to
> > use alias_bus and alias_devfn.
> 
> Yes, that's where you should take care of this hack.
> 
> > But I also need to update nvesc which should contains all the PCI
> > device MSI/MSIX nvesc and PCIe PME, aerdrv interrupts. The main
> > difference is that we need a ITS device to service multiple PCIe
> > devices. Could you give me some suggestions how to implement this
> > requirement.
> 
> It you take the time to read the code in its_msi_prepare(), you'll quickly
> notice that we already handle aliasing of multiple PCI devices to a single
> DeviceID. Once you have the aliasing taken care of in
> pci_for_each_dma_alias, the ITS code will automatically adjust the number
> of vectors (using its_get_pci_alias as a callback from
> pci_for_each_dma_alias).
> 
> >>> static int its_msi_prepare(struct irq_domain *domain, struct device
> >>> *dev, int nvec, msi_alloc_info_t *info)  { @@ -1185,6
> >> +1194,8 @@
> >>> static int its_msi_prepare(struct irq_domain *domain, struct device
> >>> *dev, dev_alias.count = nvec;
> >>>
> >>> pci_for_each_dma_alias(pdev, its_get_pci_alias, &dev_alias); +
> >>> arch_msi_share_devid_update(pdev, &dev_alias.dev_id,
> >>> +&dev_alias.count); +
> >>
> >> See the function above? That's where the aliasing should be taken
> >> care of.
> >>
> > [Minghuan] The alias will use dma_alias_devfn, but it does not
> > contains alias_bus. I need to translate PCI_DEVID to a fixed ID.
> 
> Then add another flag to deal with that. Your hardware is "creative"
> (some might even argue it is broken), so deal with the creativity as a quirk,
> which has no business in the ITS driver (or any other driver).
> 
> Thanks,
> 
> 	M.
> --
> Jazz is not dead. It just smells funny...
