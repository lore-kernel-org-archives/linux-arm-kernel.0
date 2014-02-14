From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Feb 2014 13:02:38 +0100
Subject: [PATCH 6/6] RFC: ARM: integrator: get rid of <mach/memory.h>
In-Reply-To: <1392373771-17303-7-git-send-email-linus.walleij@linaro.org>
References: <1392373771-17303-1-git-send-email-linus.walleij@linaro.org>
 <1392373771-17303-7-git-send-email-linus.walleij@linaro.org>
Message-ID: <10797321.8ugLLdzljr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 February 2014 11:29:31 Linus Walleij wrote:
> The Integrator has a custom <mach/memory.h> header defining the
> BUS_OFFSET for *_to_bus and bus_to_* operations as offset from
> 0x80000000.
> 
> I have searched the documentation and cannot find any clue to
> this set-up. The Integrators have no intrinsic DMA engine(s)
> that need to perform any bus translations. The only thing I can
> think of is the PCIv3 host found in the Integrator/AP. After
> searching its documentation I cannot find any hint whatsoever
> saying that it would perform DMA operations to memory offset
> to 0x80000000. The PCIv3 driver does not configure anything
> for DMA, and the hardware contains registers to configure
> the local (CPU) side address translation. When I dump the
> default values of these registers (the Linux driver does not
> touch them) they contain zeroes meaning a 1-to-1 mapping to
> the bus.

I think this will be break bus-mastering PCI adapters. In theory
any PCI add-on card can be a bus-master and write to the host
memory. An offset of 0x80000000 in the PCI host is not uncommon
for this. Basically what the PCI host does is forward any PCI
transaction with a destination below 2GB to the PCI bus so it
can target an MMIO register, and forward transactions above
2GB to the parent bus, flipping the high-order bit in the process.

In the old days, we had virt_to_bus() and bus_to_virt() as
interfaces for drivers to convert between a kernel pointer
and an address that can be used for DMA. We have long ago
(except for a handful of drivers that depend on CONFIG_TO_BUS
and won't build on integrator or multiplatform) stopped using
those in drivers, since the translation may be dependent on
the specific device (e.g. different offsets), or may be nonlinear
in case of an IOMMU.

The interface that drivers use now is defined in dma-mapping.h
and abstracted through dma_map_ops on ARM and some other
architectures. What you need for a multiplatform kernel to
work on integrator is to set the dma_map_ops for all PCI
devices to an implementation that adds the correct offset.

One way to do this would be to define an integrator specific
dma_map_ops struct that adds a constant value for each operation
and then calls into the regular arm_dma_ops. That would be
an easy way out, but would not help the next person with the
same problem.
A more sophisticated approach, following what we did on
powerpc, would be to add an offset field to struct dev_archdata
and apply that in pfn_to_dma/dma_to_pfn/dma_to_virt/virt_to_dma
so it gets used by all dma_map_ops implementations. For PCI
devices, you probably have to copy the offset from the parent
in the pcibios_add_device() function in that case, while for
devices probed through DT (only the pci host bridge in this
case), you have to parse the "dma_ranges" property.

	Arnd
