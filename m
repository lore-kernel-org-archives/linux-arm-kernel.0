From: dk-arm-linux@gmx.de (Dieter Kiermaier)
Date: Tue, 3 Nov 2009 15:36:20 +0100
Subject: marvell kirkwood / openrd-base kernel freeze on bootup with
	PICe->PCI bridge
In-Reply-To: <200910300955.24344.dk-arm-linux@gmx.de>
References: <200910290936.40397.dk-arm-linux@gmx.de>
	<c70ff3ad0910291547ya72000mc8c12609459bfba9@mail.gmail.com>
	<200910300955.24344.dk-arm-linux@gmx.de>
Message-ID: <200911031536.20569.dk-arm-linux@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some news, but allready no solution...

> 
> > For Kirkwood, the registers physical addresses start at 0xF1000000
> > (KIRKWOOD_REGS_PHYS_BASE ). so the physical address that you need to
> > pass to ioremap is  0xf1020100. alternatley, you can use the existing
> > virtual mapping of the register that defined by
> > KIRKWOOD_REGS_VIRT_BASE, so just use: readl(KIRKWOOD_REGS_VIRT_BASE |
> > 0x20100)
> > 
> > saeed
> 
> thanks for the help.
> 
> ok - now I'm able to read the register:
> register 0x20100: 3fb8
> 
> So it looks like bit 2 isn't set. That's what Ronen wanted me to have a look for.
> 
> Hopefully someone has any further suggestions?
> 
> Dieter

I've tracked down the now until pci_setup_device() in drivers/pci/probe.c

if I do something like:

#if 0
	case PCI_HEADER_TYPE_BRIDGE:		    /* bridge header */
		if (class != PCI_CLASS_BRIDGE_PCI)
			goto bad;
		/* The PCI-to-PCI bridge spec requires that subtractive
		   decoding (i.e. transparent) bridge must have programming
		   interface code of 0x01. */ 
		pci_read_irq(dev);
		dev->transparent = ((dev->class & 0xff) == 1);
		pci_read_bases(dev, 2, PCI_ROM_ADDRESS1);
		set_pcie_hotplug_bridge(dev);
		break;
#endif

everything except my pcie->pci bridge seems to work fine.
So I looks like that's a problem with only pcie->pci bridges (or pci bridges more general)?

Is this possible or do I complete understand something wrong?

Could someone please try to reproduce this on a marvell or at least an arm platform?

Many, many thanks,
Dieter






> 
> > 
> > 
> > On Thu, Oct 29, 2009 at 5:16 PM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > > On Thu, Oct 29, 2009 at 05:11:02PM +0200, Dieter Kiermaier wrote:
> > >> Am Donnerstag 29 Oktober 2009 12:33:03 schrieb Ronen Shitrit:
> > >> > Sorry I don't have experience with the OpenOCD.
> > >> > Any way by using the printk hack, u can simply read the register and print it...
> > >>
> > >> I fear I need any further help:
> > >>
> > >> I've tried to read the register you told me but now I get an oops:
> > >> <1>Unable to handle kernel paging request at virtual address 40020100
> > >> <1>pgd = c0004000
> > >> <1>[40020100] *pgd=00000000
> > >> <0>Internal error: Oops: 5 [#1] PREEMP
> > >>
> > >> My code to read the register is:
> > >> #include <asm/io.h>
> > >> printk("register 0x20100: %x\n", readl(virt_to_phys(0x20100)))
> > >>
> > >> also a
> > >> printk("register 0x20100: %x\n", readl(0x20100));
> > >> fail with an Ooops :(
> > >>
> > >> What am I doing wrong here?
> > >
> > > 1. virt_to_phys() is only valid for the kernel memory region in the
> > > ? virtual address space. ?0x20100 is not within such a region.
> > >
> > > 2. readl() takes an offsettable cookie representing the location you
> > > ? want to access. ?(you get this cookie via ioremap of a bus address
> > > ? or via a platform defined constant.) ?Practially (for most existing
> > > ? implementations but not all) it is a virtual address.
> > >
> > > Assuming 0x20100 is the physical address of the register, you should be
> > > able to read it like this:
> > >
> > > ? ? ? ?void __iomem *base = ioremap(0x20100, 4);
> > > ? ? ? ?if (base)
> > > ? ? ? ? ? ? ? ?printk("register 0x20100: %x\n", readl(base));
> > > ? ? ? ?iounmap(base);
> > >
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel at lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > >
> > 
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
