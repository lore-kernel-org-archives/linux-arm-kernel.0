From: galak@codeaurora.org (Kumar Gala)
Date: Wed, 7 Aug 2013 10:07:57 -0500
Subject: [PATCH v4 3/4] drivers: of: add initialization code for dma
 reserved memory
In-Reply-To: <1375275119-12787-4-git-send-email-m.szyprowski@samsung.com>
References: <1375275119-12787-1-git-send-email-m.szyprowski@samsung.com>
 <1375275119-12787-4-git-send-email-m.szyprowski@samsung.com>
Message-ID: <4BB8CECD-DBAC-496D-88EE-570A01875535@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Jul 31, 2013, at 7:51 AM, Marek Szyprowski wrote:

> Add device tree support for contiguous and reserved memory regions
> defined in device tree. Initialization is done in 2 steps. First, the
> memory is reserved, what happens very early when only flattened device
> tree is available. Then on device initialization the corresponding cma
> and reserved regions are assigned to each device structure.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> Documentation/devicetree/bindings/memory.txt |  152 ++++++++++++++++++++++
> drivers/of/Kconfig                           |    6 +
> drivers/of/Makefile                          |    1 +
> drivers/of/of_reserved_mem.c                 |  175 ++++++++++++++++++++++++++
> include/asm-generic/dma-coherent.h           |    6 +
> 5 files changed, 340 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/memory.txt
> create mode 100644 drivers/of/of_reserved_mem.c
> 
> diff --git a/Documentation/devicetree/bindings/memory.txt b/Documentation/devicetree/bindings/memory.txt
> new file mode 100644
> index 0000000..4aece19
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
> +	compatible = "contiguous-memory-region", "reserved-memory-region";
> +	reg = <(address) (size)>;
> +	(linux,contiguous-region);
> +	(linux,default-contiguous-region);
> +};
> +
> +label:		label given to the defined region (optional)
> +name:		an name given to the defined region
> +address:	the base address of the defined region
> +size:		the size of the memory region

Should we try and convey some type of cacheability attributes, I know this is difficult to do in a generic way, but would seem useful and necessary.

> +
> +compatible:	"contiguous-memory-region" - enables binding of this
> +		region to Contiguous Memory Allocator (special region for
> +		contiguous memory allocations, shared with movable system
> +		memory, Linux kernel-specific), alternatively if
> +		"reserved-memory-region" - compatibility is defined, given
> +		region is assigned for exclusive usage for DMA transfers
> +
> +linux,default-contiguous-region: property indicating that the region
> +		is the default region for all contiguous memory
> +		allocations, Linux specific (optional)
> +
> +Each defined region must use unique name. It is optional to specify the
> +base address, so if one wants to use autoconfiguration of the base
> +address, he must specify the '0' as base address in the 'reg' property
> +and assign ann uniqe name to such regions.
> +
> +
> +*** Device node's properties ***
> +
> +Once the regions in the /memory/reserved-memory node are defined, they
> +can be assigned to device nodes to enable drivers for their special use.
> +The following properties are defined:
> +
> +dma-memory-region = <&phandle_to_defined_region>;

Should we go with just 'memory-region' to be more generic?  An example might be a region of memory used for multiprocessor communication that isn't cache-able.

> +
> +This property indicates that the device driver should use the
> +memory region pointed by the given phandle.
> +
> +
> +*** Example ***
> +
> +This example defines a memory consisting of 4 memory banks. 3 contiguous
> +regions are defined for Linux kernel, one default of all device drivers
> +(named contig_mem, placed at 0x72000000, 64MiB), one dedicated to the
> +framebuffer device (labelled display_mem, placed at 0x78000000, 8MiB)
> +and one for multimedia processing (labelled multimedia_mem, placed at
> +0x77000000, 64MiB). 'display_mem' region is then assigned to fb at 12300000
> +device for DMA memory allocations (Linux kernel drivers will use CMA is
> +available or dma-exclusive usage otherwise). 'multimedia_mem' is
> +assigned to scaller at 12500000 and codec at 12600000 devices for contiguous
> +memory allocations when CMA driver is enabled.
> +
> +The reason for creating a separate region for framebuffer device is to
> +match the framebuffer base address to the one configured by bootloader,
> +so once Linux kernel drivers starts no glitches on the displayed boot
> +logo appears. Scaller and codec drivers should share the memory
> +allocations.
> +
> +/ {
> +	/* ... */
> +	memory {
> +		reg =  <0x40000000 0x10000000
> +			0x50000000 0x10000000
> +			0x60000000 0x10000000
> +			0x70000000 0x10000000>;
> +
> +		reserved-memory {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			/*
> +			 * global autoconfigured region for contiguous allocations
> +			 * (used only with Contiguous Memory Allocator)
> +			 */
> +			contig_region at 0 {
> +				compatible = "contiguous-memory-region";
> +				reg = <0x0 0x4000000>;
> +				linux,default-contiguous-region;
> +			};
> +
> +			/*
> +			 * special region for framebuffer
> +			 */
> +			display_mem: region at 78000000 {
> +				compatible = "contiguous-memory-region", "reserved-memory-region";
> +				reg = <0x78000000 0x800000>;
> +			};
> +
> +			/*
> +			 * special region for multimedia processing devices
> +			 */
> +			multimedia_mem: region at 77000000 {
> +				compatible = "contiguous-memory-region";
> +				reg = <0x77000000 0x4000000>;
> +			};
> +		};
> +	};
> +
> +	/* ... */
> +
> +	fb0: fb at 12300000 {
> +		status = "okay";
> +		dma-memory-region = <&display_mem>;
> +	};
> +
> +	scaller: scaller at 12500000 {
> +		status = "okay";
> +		dma-memory-region = <&multimedia_mem>;
> +	};
> +
> +	codec: codec at 12600000 {
> +		status = "okay";
> +		dma-memory-region = <&multimedia_mem>;
> +	};
> +};

- k


--
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
