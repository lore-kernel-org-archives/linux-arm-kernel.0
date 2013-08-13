From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 13 Aug 2013 14:08:44 -0600
Subject: [PATCH v5 2/3] drivers: of: add initialization code for dma
 reserved memory
In-Reply-To: <1376049119-12655-3-git-send-email-m.szyprowski@samsung.com>
References: <1376049119-12655-1-git-send-email-m.szyprowski@samsung.com>
 <1376049119-12655-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <520A924C.6070309@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/2013 05:51 AM, Marek Szyprowski wrote:
> Add device tree support for contiguous and reserved memory regions
> defined in device tree. Initialization is done in 2 steps. First, the
> memory is reserved, what happens very early when only flattened device
> tree is available. Then on device initialization the corresponding cma
> and reserved regions are assigned to each device structure.

Hmmm. This seems an awful lot like putting SW configuration/policy
information into DT rather than HW description. This feels like a
slippery slope... Isn't this kind of thing better handled by a kernel
command-line option to set up the CMA size?

> diff --git a/Documentation/devicetree/bindings/memory.txt b/Documentation/devicetree/bindings/memory.txt

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

You probably want to mention that baseaddrX is #address-cells long and
sizeX is #size-cells long. Same for the reserved regions below.

> +*** Reserved memory regions ***
...
> +Parameters for each memory region can be encoded into the device tree
> +wit the following convention:
> +
> +[(label):] (name)@(address) {

That line is DT syntax nothing to do with this binding. I would re-write
this in the more typical DT binding style where the documentation only
specifies the content of the node, not the node itself.

In particular, there's no requirement for a node name to include the
unit address (@address) if it's already unique.

> +	compatible = "contiguous-memory-region", "reserved-memory-region";
> +	reg = <(address) (size)>;
> +	(linux,default-contiguous-region);

(...) isn't a syntax typically used in DT bindings. You'd usually put
that in a a list of "Optional Properties:".

> +Each defined region must use unique name.

Well, DT nodes are supposed to be names based on the type of object they
represent, not by the name/identity of the object they represent.

> +*** Device node's properties ***
> +
> +Once the regions in the /memory/reserved-memory node are defined, they
> +can be assigned to device nodes to enable drivers for their special use.
> +The following properties are defined:
> +
> +memory-region = <&phandle_to_defined_region>;
> +
> +This property indicates that the device driver should use the
> +memory region pointed by the given phandle.

That's quite scary. This is essentially forcing a memory-region property
into every single binding that ever exists. I guess that's not too much
worse than e.g. interrupts/clocks/..., but I think it's worth somehow
requiring bindings to "opt-in" to allowing this property to be part of
their binding rather than just definining the property globally.
