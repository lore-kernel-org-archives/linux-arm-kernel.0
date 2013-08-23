From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 23 Aug 2013 13:27:11 -0600
Subject: [PATCH v6 3/4 UPDATED] drivers: of: add initialization code for
 dma reserved memory
In-Reply-To: <1377247141-11284-1-git-send-email-m.szyprowski@samsung.com>
References: <1376924669-28873-4-git-send-email-m.szyprowski@samsung.com>
 <1377247141-11284-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <5217B78F.1080300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/23/2013 02:39 AM,  wrote:
> From: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> This patch adds device tree support for contiguous and reserved memory
> regions defined in device tree.
> 
> Large memory blocks can be reliably reserved only during early boot.
> This must happen before the whole memory management subsystem is
> initialized, because we need to ensure that the given contiguous blocks
> are not yet allocated by kernel. Also it must happen before kernel
> mappings for the whole low memory are created, to ensure that there will
> be no mappings (for reserved blocks) or mapping with special properties
> can be created (for CMA blocks). This all happens before device tree
> structures are unflattened, so we need to get reserved memory layout
> directly from fdt.
> 
> Later, those reserved memory regions are assigned to devices on each
> device structure initialization.

I think the binding looks OK now; just a couple minor comments below.

> diff --git a/Documentation/devicetree/bindings/memory.txt b/Documentation/devicetree/bindings/memory.txt

> +*** Reserved memory regions ***

> +compatible:	one or more of:
> +	- "linux,contiguous-memory-region" - enables binding of this
> +	  region to Contiguous Memory Allocator (special region for
> +	  contiguous memory allocations, shared with movable system
> +	  memory, Linux kernel-specific).
> +	- "reserved-memory-region" - compatibility is defined, given
> +	  region is assigned for exclusive usage for by the respective
> +	  devices.

I'm slightly hesitant to agree with "linux" in the name here, since it
seems like the concept of a memory region where DMA buffers/... should
be allocated is pretty OS-independant. Similar for:

> +linux,default-contiguous-region: property indicating that the region
> +	is the default region for all contiguous memory
> +	allocations, Linux specific (optional)

But, I guess there's nothing stopping any other OS from parsing this
same property, so I suppose it's OK. What do other DT maintainers think?

> +*** Example ***

> +		reserved-memory {
...
> +			contig_region at 0 {
...
> +			display_mem: region at 78000000 {
...
> +			multimedia_mem: region at 77000000 {

Nit: I think all 3 of those nodes should be called region, but it's
probably fine as-is.

So, the binding,
Acked-by: Stephen Warren <swarren@nvidia.com>
