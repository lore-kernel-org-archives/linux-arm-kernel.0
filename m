From: Minghuan.Lian@freescale.com (Minghuan.Lian at freescale.com)
Date: Fri, 5 Sep 2014 07:22:08 +0000
Subject: =?gb2312?B?tPC4tDogW1BBVENIIDIvMl0gUENJOiBMYXllcnNjYXBlOiBBZGQgTGF5ZXJz?=
 =?gb2312?Q?cape_PCIe_driver?=
In-Reply-To: <2799937.bNtU9KXR6t@wuerfel>
References: <1409856338-1730-1-git-send-email-Minghuan.Lian@freescale.com>
 <1409856338-1730-2-git-send-email-Minghuan.Lian@freescale.com>,
 <2799937.bNtU9KXR6t@wuerfel>
Message-ID: <1409930568256.17564@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please see my comments inline.
________________________________________
???: Arnd Bergmann <arnd@arndb.de>
????: 2014?9?4? 20:14
???: linux-arm-kernel at lists.infradead.org
??: Lian Minghuan-B31939; linux-pci at vger.kernel.org; Hu Mingkai-B21284; Zang Roy-R61911
??: Re: [PATCH 2/2] PCI: Layerscape: Add Layerscape PCIe driver

On Thursday 04 September 2014 18:45:38 Minghuan Lian wrote:

> +
> +#define PCIE_LS1021A_BASE    0x3400000
> +#define PCIE_LS1021A_REG_SIZE        0x0100000

This does not belong here. All addresses must come from DT,
and you should not do the calculation below based on the address.

[Minghuan] LS1021A contains two PCI controllers. I use them to calculation the PCI controller index.
There are several separate registers for PEX1 and PEX2 in SCFG register space. It is hard to get them address from DTS. Could you tell me a way to get PCI controller index?


> +struct ls_pcie {
> +     struct list_head node;
> +     struct device *dev;
> +     struct pci_bus *bus;
> +     void __iomem *dbi;
> +     void __iomem *scfg;
> +     struct pcie_port pp;
> +     int id;
> +     int index;
> +     int irq;
> +     int msi_irq;
> +     int pme_irq;
> +};

irq and pme_irq seem to be completely unused, so better
not add them until they are actually used.
[Minghuan] Ok, I will remove them.

The scfg registers seem to belong to another device that
is responsible for multiple instances. Unfortunately,
this "fsl,ls1021a-scfg" device is not documented anywhere
that I can see.

Is this some sort of syscon node, or is it specific to the
pcie controller(s)?

[Minghaun] SCFG provides SoC specific configuration and status
registers for the device including PCI USB eTSEC SATA ...
The platform patches that contains SCFG code are being upstream.


> +static LIST_HEAD(ls_pcie_list);

Don't maintain your own lists please.

[Minghuan] Ok, I will remove it.

> +static int ls_pcie_link_up(struct pcie_port *pp)
> +{
> +     u32 rc, tmp;
> +     struct ls_pcie *pcie = to_ls_pcie(pp);
> +
> +     tmp = ioread32(pcie->scfg + SCFG_SCFGREVCR_OFF);
> +     iowrite32(SCFG_NO_BIT_REVERSE, pcie->scfg + SCFG_SCFGREVCR_OFF);
> +
> +     rc = (ioread32(pcie->scfg + PEXMSCPORTSR(pcie->index)) >>
> +          LTSSM_STATE_SHIFT) & LTSSM_STATE_MASK;
> +
> +     iowrite32(tmp, pcie->scfg + SCFG_SCFGREVCR_OFF);
> +
> +     if (rc < LTSSM_PCIE_L0)
> +             return 0;
> +
> +     return 1;
> +}

This looks like it is really a phy driver, although a pretty minimal
one.

[Minghuan] I read SCFG register. SCFG provides SoC specific configuration and status
registers for the device including PCI USB eTSEC SATA ...

> +static u32 ls_pcie_get_msi_addr(struct pcie_port *pp)
> +{
> +     return SCFG_SPIMSICR_ADDR;
> +}
> +
> +static u32 ls_pcie_get_msi_data(struct pcie_port *pp, int pos)
> +{
> +     struct ls_pcie *pcie = to_ls_pcie(pp);
> +
> +     if (pcie->id == PCI_DEVICE_ID_LS1021A)
> +             return MSI_LS1021A_DATA(pcie->index);
> +
> +     return pos;
> +}

My impression is that you have two distinct MSI controller
implementations, one for LS1021A and the other one for everything
else. How about using separate pcie_host_ops for them, possibly
also moving them into separate files?

A good way to deal with this is to put the pointers to the two
pcie_host_ops into the data fields of the ls_pcie_of_match table.

[Minghuan] LS1021 contains the same two PCI controllers PEX1 and PEX2.
both PEX1 and PEX use the same MSI address, but different MSI message data.

> +/* Freescale PCIe driver does not allow module unload */
> +static int __init ls_pcie_init(void)
> +{
> +     return platform_driver_probe(&ls_pcie_driver, ls_pcie_probe);
> +}
> +subsys_initcall(ls_pcie_init);

Better change to platform_driver_register, so you can use deferred probing.
[Minghuan] I will try.
        Arnd
