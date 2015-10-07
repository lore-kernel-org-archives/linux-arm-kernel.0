From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Oct 2015 22:01:49 +0200
Subject: [PATCH] ARM: cns3xxx: pci: avoid potential stack overflow
In-Reply-To: <m3fv6i8qnh.fsf@t19.piap.pl>
References: <2273145.0Ls8cProhs@wuerfel> <m3fv6i8qnh.fsf@t19.piap.pl>
Message-ID: <201510072201.51697.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 May 2015, Krzysztof Ha?asa wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > The cns3xxx_pcie_hw_init function uses excessive kernel
> > stack space because of a hack that puts a fake struct
> > pci_sys_data and struct pci_bus on the stack in order to
> > call the generic pci_bus_read_config accessors, which causes
> > a warning in ARM allmodconfig builds:
> >
> > arch/arm/mach-cns3xxx/pcie.c:266:1: warning: the frame size of 1080 bytes is larger than 1024 bytes
> >
> > This rewrites the code in question to use a private
> > implementation of the config space access for the same
> > purpose, getting rid of the local variables and the
> > warning in the process. As part of this, we have to
> > use an open-coded version of pci_bus_find_capability(),
> > which unfortunately complicates the implementation.
> 
> Wouldn't it be better to simply use static structs for this purpose?
> The hack isn't pretty, though.

Hi Krzysztof,

sorry for the late reply. I sent the patch shortly before my
parental leave and have only now picked up this work again.

I've looked at the driver once more and have come up with
a modified approach that should hopefully address all the
concerns.

> > +	regs = cnspci->cfg0_regs + (PCI_DEVFN(1, 0) << 12);
> > +
> 
> Some comment about would be helpful. Such as this:
> 
> 
> > -	bus.number = 1; /* directly connected PCIe device */
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Agreed. I think I've managed to get rid of this part completely though.

> > +	pos = cns3xxx_pci_raw_read_config(regs, PCI_CAPABILITY_LIST, 1);
> > +	while (cns3xxx_pci_raw_read_config(regs, pos, 1) != PCI_CAP_ID_EXP)
> > +		pos = cns3xxx_pci_raw_read_config(regs, pos + PCI_CAP_LIST_NEXT, 1);
> > +
> 
> I wonder if this can fail (i.e., no PCI_CAP_ID_EXP capability).

This is now gone too, so we no longer have to worry about it. I
was mistakingly assuming that these were registers inside of the SoC
rather than in the device that gets attached.

> > +	dc = cns3xxx_pci_raw_read_config(regs, pos + PCI_EXP_DEVCTL, 2);
> > +	dc &= ~(0x3 << 12);	/* Clear Device Control Register [14:12] */
> > +	cns3xxx_pci_raw_write_config(regs, pos + PCI_EXP_DEVCTL, 2, dc);
> > +	dc = cns3xxx_pci_raw_read_config(regs, pos + PCI_EXP_DEVCTL, 2);
> > +	if (!(dc & (0x3 << 12)))
> > +		pr_info("PCIe: Set Device Max_Read_Request_Size to 128 byte\n");
> > +
> 
> This seems to revert 367dc4b75f4349d5363bc3ebdc030939db944786. Why do
> you want to do it?

My mistake. Gone too now.

Thanks for your careful review back then!

	Arnd
