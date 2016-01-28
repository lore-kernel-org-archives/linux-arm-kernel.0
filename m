From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 28 Jan 2016 14:49:45 +0000
Subject: [PATCH V2 3/5] PCI: xilinx: Modifying AXI PCIe Host Bridge
 driver to  work on both  Zynq and Microblaze
In-Reply-To: <3706176.5tvYx0gSBz@wuerfel>
References: <1452620173-4905-1-git-send-email-bharatku@xilinx.com>
 <1917083.LB4Ng3Y2yP@wuerfel>
 <8520D5D51A55D047800579B094147198258741F5@XAP-PVEXMBX01.xlnx.xilinx.com>
 <3706176.5tvYx0gSBz@wuerfel>
Message-ID: <20160128144944.GA12690@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2016 at 03:23:37PM +0100, Arnd Bergmann wrote:
> On Thursday 28 January 2016 14:18:15 Bharat Kumar Gogada wrote:
> > > 
> > > I see. In the upstream code you seem to do it in
> > > pcibios_setup_bus_devices(), while arm64 and powerpc do it in
> > > pcibios_add_device().
> > > 
> > No that function is not getting called with generic API's, its getting called with pcibios_init flow which is tightly bound with struct pci_controller microblaze specific structure. So I added pcibios_add_device in pci-common.c.
> 
> Ok
> 
> > > > May be we can add similar on arm and test out, but we might need some
> > > > cleanup in arch/arm/kernel/bios32.c
> > > 
> > > I think that would still just be a half-baked solution. This should really be fully
> > > automatic. We could do it in the __weak
> > > pcibios_add_device() for all architectures that don't override it when the bus
> > > was probed from DT, or we could do it in pci_read_irq().
> > When will pci_read_irq() call get invoked ?
> 
> This is called early on when a device gets created in pci_setup_device(),
> so platforms can still override the value later.
> 
> The idea here is that normally a BIOS stores the interrupt number in
> the PCI_INTERRUPT_LINE config space byte, and we just read it from
> there. Generally speaking though, for non-PC systems we tend to not
> have a BIOS that writes these values to start with, and any values
> stored in here have no meaning in combination with SPARSE_IRQ
> and/or IRQ_DOMAINS because the bootloader or BIOS doesn't know
> what IRQ number will refer to hardware IRQ line in Linux.

I think the best way to handle this is through Matthew's series (below),
in the interim a callback in arch code would do, we will clean it up when
Matthew's series goes upstream, it should not take too long.

http://www.spinics.net/lists/linux-pci/msg45950.html

Thanks,
Lorenzo
