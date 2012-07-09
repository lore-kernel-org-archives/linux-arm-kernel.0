From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 08 Jul 2012 22:53:52 -0400 (EDT)
Subject: [PATCH 03/15] ARM: tegra: use fixed PCI i/o mapping
In-Reply-To: <4FF9EE93.3010200@gmail.com>
References: <1341600040-30993-1-git-send-email-robherring2@gmail.com>
 <20120708060932.GB5186@avionic-0098.mockup.avionic-design.de>
 <4FF99688.1040703@gmail.com> <201207081635.30864.arnd@arndb.de>
 <4FF9EE93.3010200@gmail.com>
Message-ID: <alpine.LFD.2.02.1207082236530.31100@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 8 Jul 2012, Rob Herring wrote:

> On 07/08/2012 11:35 AM, Arnd Bergmann wrote:
> > On Sunday 08 July 2012, Rob Herring wrote:
> >>> I'm not very familiar with the inner workings of the iotable and the
> >>> mappings initialized by it, but I wonder if this can be done dynamically
> >>> at a later stage. The way this is currently done in this patch, the I/O
> >>> region is statically mapped from a fixed offset within the PCIe address
> >>> range. Part of the patches to add DT support is to allow this region to
> >>> be defined by the DT, so that will obviously also create problems.
> >>
> >> Is the i/o address something you could extract from DT earlier? This can
> >> be done separately if it doesn't require information from the driver.
> >>
> >> I'm sure exactly how to do a fixed virtual mapping other than the
> >> io_table mappings. There was some discussion of use fixmap region
> >> previously, but doing so will be a bit more complex. I'll look into this
> >> some.
> > 
> > I think you can call ioremap_page_range() to do this.
> 
> Thanks for the pointer. But this has to be in 2 steps. First reserve the
> virtual space and then map it. For the first part I think something like
> this function will work:
> 
> void __init pci_reserve_io(void)
> {
> 	struct vm_struct *vm;
> 
> 	vm = early_alloc_aligned(sizeof(*vm), __alignof__(*vm));
> 
> 	vm->addr = (void *)PCI_IO_VIRT_BASE;
> 	vm->size = SZ_1M;
> 	vm->phys_addr = 0;
> 	vm->flags = VM_IOREMAP | VM_ARM_STATIC_MAPPING;
> 	vm->flags |= VM_ARM_MTYPE(MT_DEVICE);
> 	vm->caller = pci_reserve_io;
> 	vm_area_add_early(vm++);
> }
> 
> There's a big fat warning on vm_area_add_early from Nico to not use
> unless you know what you're doing. I'll pretend I do...

:-)

This warning was inherited from vm_area_register_early() which used to 
make the core of what vm_area_add_early() is today.

Your usage of vm_area_add_early() should be fine as long as it is done 
before vmalloc_init(() is called.


Nicolas
