From: olof@lixom.net (Olof Johansson)
Date: Thu, 15 Aug 2013 22:32:56 -0700
Subject: [PATCH v5 2/3] drivers: of: add initialization code for dma
 reserved memory
In-Reply-To: <1376049119-12655-3-git-send-email-m.szyprowski@samsung.com>
References: <1376049119-12655-1-git-send-email-m.szyprowski@samsung.com>
 <1376049119-12655-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20130816053256.GB7035@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Aug 09, 2013 at 01:51:58PM +0200, Marek Szyprowski wrote:
> Add device tree support for contiguous and reserved memory regions
> defined in device tree. Initialization is done in 2 steps. First, the
> memory is reserved, what happens very early when only flattened device
> tree is available. Then on device initialization the corresponding cma
> and reserved regions are assigned to each device structure.

Bikeshedding on some wording, mostly in case you have to respin for other
reasons.

> diff --git a/Documentation/devicetree/bindings/memory.txt b/Documentation/devicetree/bindings/memory.txt
> new file mode 100644
> index 0000000..167d013
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory.txt
> @@ -0,0 +1,152 @@
> +*** Memory binding ***
> +
> +The /memory node provides basic information about the address and size
> +of the physical memory. This node is usually filled or updated by the
> +bootloader, depending on the actual memory configuration of the given
> +hardware.
> +
> +The memory layout is described by the folllowing node:
> +
> +memory {
> +	device_type = "memory";
> +	reg =  <(baseaddr1) (size1)
> +		(baseaddr2) (size2)
> +		...
> +		(baseaddrN) (sizeN)>;
> +};
> +
> +baseaddrX:	the base address of the defined memory bank
> +sizeX:		the size of the defined memory bank
> +
> +More than one memory bank can be defined.
> +
> +
> +*** Reserved memory regions ***
> +
> +In /memory/reserved-memory node one can create additional nodes

There's really no requirement on naming here. We should instead search all of
/memory for the compatible properties.

> +describing particular reserved (excluded from normal use) memory
> +regions. Such memory regions are usually designed for the special usage
> +by various device drivers. A good example are contiguous memory
> +allocations or memory sharing with other operating system on the same
> +hardware board. Those special memory regions might depend on the board
> +configuration and devices used on the target system.
> +
> +Parameters for each memory region can be encoded into the device tree
> +wit the following convention:
> +
> +[(label):] (name)@(address) {

@(unit-address)

> +	compatible = "contiguous-memory-region", "reserved-memory-region";
> +	reg = <(address) (size)>;
> +	(linux,default-contiguous-region);
> +};
> +
> +label:		label given to the defined region (optional)
> +name:		an name given to the defined region
> +address:	the base address of the defined region

unit-address. It's optional unless there are conflicting node names.

> +size:		the size of the memory region
> +
> +compatible:	"contiguous-memory-region" - enables binding of this
> +		region to Contiguous Memory Allocator (special region for
> +		contiguous memory allocations, shared with movable system
> +		memory, Linux kernel-specific), alternatively if
> +		"reserved-memory-region" - compatibility is defined, given
> +		region is assigned for exclusive usage for DMA transfers

"reserved-memory-region" isn't necessarily just for DMA transfers, it can be
used pretty much for anything. pstore comes to mind.

> +linux,default-contiguous-region: property indicating that the region
> +		is the default region for all contiguous memory
> +		allocations, Linux specific (optional)

Hmm. We handle some of these defaults such as device naming (i2c busses, etc)
through /alias nodes. Maybe it would be more consistent to do that here too,
by providing a phandle there instead.

> +Each defined region must use unique name.

Hmm, this is quite different from how memory nodes work, and it'd
be nice to keep similar semantics. A "name" property would make more
sense for areas that need to be named, but even then, why do names here
matter? References should be by phandle, not by name. So I think it
should likely just be scrapped.

> It is optional to specify the
> +base address, so if one wants to use autoconfiguration of the base
> +address, he must specify the '0' as base address in the 'reg' property
> +and assign ann unique name to such regions.

"an unique"

But I don't think this is a good idea, since it violates basic use of the reg
properties, where you usually don't have overlaps, and no real requirements on
names (as mentioned above).



-Olof
