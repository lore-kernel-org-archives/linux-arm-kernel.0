From: minghuan.lian@nxp.com (Minghuan Lian)
Date: Wed, 23 Mar 2016 10:50:02 +0000
Subject: [PATCH 2/2 v5] irqchip/Layerscape: Add SCFG MSI controller support
In-Reply-To: <7239962.9Fyo0vfqsc@ws-stein>
References: <1457321782-3245-1-git-send-email-Minghuan.Lian@nxp.com>
 <1457321782-3245-2-git-send-email-Minghuan.Lian@nxp.com>
 <7239962.9Fyo0vfqsc@ws-stein>
Message-ID: <VI1PR04MB1615DEFA517CEDD7867DE667E8810@VI1PR04MB1615.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

Thanks for your test.

Number 134742016 is calculated by the following code

/**
 * pci_msi_domain_calc_hwirq - Generate a unique ID for an MSI source
 * @dev:	Pointer to the PCI device
 * @desc:	Pointer to the msi descriptor
 *
 * The ID number is only used within the irqdomain.
 */
irq_hw_number_t pci_msi_domain_calc_hwirq(struct pci_dev *dev,
					  struct msi_desc *desc)
{
	return (irq_hw_number_t)desc->msi_attrib.entry_nr |
		PCI_DEVID(dev->bus->number, dev->devfn) << 11 |
		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
}

And this value is assigned to the hwirq in the function:
static void pci_msi_domain_set_desc(msi_alloc_info_t *arg,
				    struct msi_desc *desc)
{
	arg->desc = desc;
	arg->hwirq = pci_msi_domain_calc_hwirq(msi_desc_to_pci_dev(desc),
					       desc);
}


Thanks,
Minghuan

> -----Original Message-----
> From: Alexander Stein [mailto:alexander.stein at systec-electronic.com]
> Sent: Wednesday, March 23, 2016 5:18 PM
> To: linux-kernel at vger.kernel.org
> Cc: Minghuan Lian <minghuan.lian@nxp.com>;
> linux-arm-kernel at lists.infradead.org; Marc Zyngier <marc.zyngier@arm.com>;
> Thomas Gleixner <tglx@linutronix.de>; Jason Cooper
> <jason@lakedaemon.net>; Roy Zang <roy.zang@nxp.com>; Mingkai Hu
> <mingkai.hu@nxp.com>; Stuart Yoder <stuart.yoder@nxp.com>; Yang-Leo Li
> <leoyang.li@nxp.com>
> Subject: Re: [PATCH 2/2 v5] irqchip/Layerscape: Add SCFG MSI controller
> support
> 
> On Monday 07 March 2016 11:36:22, Minghuan Lian wrote:
> > Some kind of NXP Layerscape SoC provides a MSI
> > implementation which uses two SCFG registers MSIIR and
> > MSIR to support 32 MSI interrupts for each PCIe controller.
> > The patch is to support it.
> >
> > Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> 
> Tested-by: Alexander Stein <alexander.stein@systec-electronic.com>
> 
> Using an intel e1000e card which uses 3 MSIs. But the IRQ numbers are a bit
> strange though:
> > grep eth3 /proc/interrupts
> >
> >  63:         49          0       MSI 134742016 Edge
> eth3-rx-0
> >  64:          3          0       MSI 134742017 Edge
> eth3-tx-0
> >  65:          4          0       MSI 134742018 Edge      eth3
> 
> Best regards,
> Alexander
