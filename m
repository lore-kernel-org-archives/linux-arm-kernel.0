From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 09 Sep 2013 14:05:53 +0100
Subject: [PATCH v7 3/4] drivers: of: add initialization code for dma
 reserved memory
In-Reply-To: <52209278.8040106@samsung.com>
References: <1377527959-5080-1-git-send-email-m.szyprowski@samsung.com>
 <1377527959-5080-4-git-send-email-m.szyprowski@samsung.com>
 <20130829224637.D09183E1222@localhost> <52209278.8040106@samsung.com>
Message-ID: <20130909130553.21F683E0E75@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 30 Aug 2013 14:39:20 +0200, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> Hello,
> 
> On 8/30/2013 12:46 AM, Grant Likely wrote:
> > On Mon, 26 Aug 2013 16:39:18 +0200, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> > > This patch adds device tree support for contiguous and reserved memory
> > > regions defined in device tree.
> > >
> > > Large memory blocks can be reliably reserved only during early boot.
> > > This must happen before the whole memory management subsystem is
> > > initialized, because we need to ensure that the given contiguous blocks
> > > are not yet allocated by kernel. Also it must happen before kernel
> > > mappings for the whole low memory are created, to ensure that there will
> > > be no mappings (for reserved blocks) or mapping with special properties
> > > can be created (for CMA blocks). This all happens before device tree
> > > structures are unflattened, so we need to get reserved memory layout
> > > directly from fdt.
> > >
> > > Later, those reserved memory regions are assigned to devices on each
> > > device structure initialization.
> > >
> > > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> > > Acked-by: Michal Nazarewicz <mina86@mina86.com>
> > > Acked-by: Tomasz Figa <t.figa@samsung.com>
> > > Acked-by: Stephen Warren <swarren@nvidia.com>
> > > Reviewed-by: Rob Herring <rob.herring@calxeda.com>
> >
> > Hi Marek,
> >
> > This patch is in good shape, but I have some comments below and a few
> > concerns about the binding....
> >
> > g.
> >
> > > ---
> > >  Documentation/devicetree/bindings/memory.txt |  168 +++++++++++++++++++++++++
> > >  drivers/of/Kconfig                           |    6 +
> > >  drivers/of/Makefile                          |    1 +
> > >  drivers/of/of_reserved_mem.c                 |  175 ++++++++++++++++++++++++++
> > >  drivers/of/platform.c                        |    4 +
> > >  include/linux/of_reserved_mem.h              |   14 +++
> > >  6 files changed, 368 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/memory.txt
> > >  create mode 100644 drivers/of/of_reserved_mem.c
> > >  create mode 100644 include/linux/of_reserved_mem.h
> > >
> > > diff --git a/Documentation/devicetree/bindings/memory.txt b/Documentation/devicetree/bindings/memory.txt
> > > new file mode 100644
> > > index 0000000..eb24693
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/memory.txt
> > > @@ -0,0 +1,168 @@
> > > +*** Memory binding ***
> > > +
> > > +The /memory node provides basic information about the address and size
> > > +of the physical memory. This node is usually filled or updated by the
> > > +bootloader, depending on the actual memory configuration of the given
> > > +hardware.
> > > +
> > > +The memory layout is described by the following node:
> > > +
> > > +/ {
> > > +	#address-cells = <(n)>;
> > > +	#size-cells = <(m)>;
> > > +	memory {
> > > +		device_type = "memory";
> > > +		reg =  <(baseaddr1) (size1)
> > > +			(baseaddr2) (size2)
> > > +			...
> > > +			(baseaddrN) (sizeN)>;
> > > +	};
> > > +	...
> > > +};
> > > +
> > > +A memory node follows the typical device tree rules for "reg" property:
> > > +n:		number of cells used to store base address value
> > > +m:		number of cells used to store size value
> > > +baseaddrX:	defines a base address of the defined memory bank
> > > +sizeX:		the size of the defined memory bank
> > > +
> > > +
> > > +More than one memory bank can be defined.
> > > +
> > > +
> > > +*** Reserved memory regions ***
> > > +
> > > +In /memory/reserved-memory node one can create child nodes describing
> > > +particular reserved (excluded from normal use) memory regions. Such
> > > +memory regions are usually designed for the special usage by various
> > > +device drivers. A good example are contiguous memory allocations or
> > > +memory sharing with other operating system on the same hardware board.
> > > +Those special memory regions might depend on the board configuration and
> > > +devices used on the target system.
> > > +
> > > +Parameters for each memory region can be encoded into the device tree
> > > +with the following convention:
> > > +
> > > +[(label):] (name) {
> > > +	compatible = "linux,contiguous-memory-region", "reserved-memory-region";
> > > +	reg = <(address) (size)>;
> > > +	(linux,default-contiguous-region);
> > > +};
> > > +
> > > +compatible:	one or more of:
> >
> > It's unclear what the meaning of having both values means for the
> > kernel. Does it mean the regions is sharable with the kernel or not? I
> > would think they are mutually exclusive.
> 
> I consider CMA ("linux,contiguous-memory-region") as a special case of the
> reserved memory driver. The main advantage is the ability of sharing the 
> memory
> with the system instead of just allocating it from the carved out memory
> region. From the device and hardware perspective there is no difference
> if the buffer comes from CMA or reserved memory. However if you insist, I
> can change it to something different, like "shareable-memory-region".
> 
> Specifying both compatible values would let kernel to bind the more specific
> driver (cma, if available) over the generic one (simple reserved memory
> carve-out allocator based on dma_coherent).

I guess the question is that if they are effectively identical, then why
would they have separate compatible values? CMA is a particular user,
but there are other potential users (out of tree ION for example). The
other difference would be reserved regions that are in-use at boot time
(ie. framebuffer) and others that are completely free, but need to be
made available later. Are there any other conditions that could be
applicable here?

Compatible happens to be a convenient property to use for identifying
the usage model, but I wonder if it is the best. Another option would be
to add flag properties to indicate usage.... However, I am thinking out
loud at the moment and not telling you that you must change the model.
However, the document needs to be very explicit about the precedence and
how compatible or extra properties affect the behaviour.

As a thought experiment, how would you differentiate between regions
intended for different allocators? Say you had an imaginary system that
needs to support both GEM and CMA regions?

> 
> > > +	- "linux,contiguous-memory-region" - enables binding of this
> > > +	  region to Contiguous Memory Allocator (special region for
> > > +	  contiguous memory allocations, shared with movable system
> > > +	  memory, Linux kernel-specific).
> >
> > As mentioned in the older thread, you can drop the 'linux,' prefix here.
> > Perhaps something like "shareable-memory-region" or merely
> > "memory-region". It is reasonable for any kernel (not just Linux) to use
> > marked regions for movable pages until it gets requested by a driver, in
> > which case a rather generic "memory-region" makes a lot of sense as a
> > name.

Actually, I got this backwards; I think it is /NOT/ reasonable for Linux
to use a reserved region unless explicitly told that it can do so.
Otherwise it goes and overwrites framebuffers and stuff.

> >
> > > +	- "reserved-memory-region" - compatibility is defined, given
> > > +	  region is assigned for exclusive usage for by the respective
> > > +	  devices.
> >
> > BTW, just so you're aware there is already a binding for marking regions
> > as reserved. It was recently added to arch/powerpc/kernel/prom.c.
> > Unfortunately it doesn't look like it got documented. Search for
> > "reserved-ranges". However, I don't think it blocks your work here. That
> > binding doesn't provide any way for matching devices to reserved ranges.
> > It is only for telling the kernel "hands of that memory".
> 
> ok, good to know.
> 
> > > +
> > > +reg:	standard property defining the base address and size of
> > > +	the memory region
> > > +
> > > +linux,default-contiguous-region: property indicating that the region
> > > +	is the default region for all contiguous memory
> > > +	allocations, Linux specific (optional)
> > > +
> > > +It is optional to specify the base address, so if one wants to use
> > > +autoconfiguration of the base address, '0' can be specified as a base
> > > +address in the 'reg' property.
> >
> > I don't understand this. What does autoconfiguration of the base address
> > actually do? If this is intended to dynamically allocate a region of RAM
> > for contiguous allocations, then don't use 'reg'. Use a different
> > property that only specifies the size.
> 
> Ok, I will try to make a patch which removes special 'zero' base address
> handling and adds separate 'size' property for automatically configured
> regions.
> 
> > > +The /memory/reserved-memory node must contain the same #address-cells
> > > +and #size-cells value as the root node.
> >
> > That seems to be an arbitrary restriction. Why does the reserved-memory
> > node need to have exactly the same #address/size values? The 'reg'
> > property binding quite easily handles different values at different
> > levels of the tree. More below....
> 
> Does it really makes sense to have such configuration with different
> #address-cells/#size-cells than the root memory node?

Possibly not, but I've learned the hard way not to gratuitously deviate
from established convention.

g.
