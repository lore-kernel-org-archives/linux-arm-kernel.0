From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 24 Oct 2013 13:31:11 -0400 (EDT)
Subject: [PATCH] Simple NX lowmem mappings
In-Reply-To: <20131024071258.GB16735@n2100.arm.linux.org.uk>
References: <20131024071258.GB16735@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.03.1310241315290.1951@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 24 Oct 2013, Russell King - ARM Linux wrote:

> This patch has similar functionality to Laura's patch set earlier this
> month, except I've just done the basic change - we don't increase the
> size of the kernel for this, so there should be no kernel size related
> problems with this.  We mark sections which do not overlap any kernel
> text as non-executable.  
> 
> 8<====
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> ARM: Implement basic NX support for kernel lowmem mappings
> 
> Add basic NX support for kernel lowmem mappings.  We mark any section
> which does not overlap kernel text as non-executable, preventing it
> from being used to write code and then execute directly from there.
> 
> This does not change the alignment of the sections, so the kernel
> image doesn't grow significantly via this change, so we can do this
> without needing a config option.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

[...]

> @@ -1294,6 +1309,8 @@ static void __init kmap_init(void)
>  static void __init map_lowmem(void)
>  {
>  	struct memblock_region *reg;
> +	unsigned long kernel_x_start = round_down(__pa(_stext), SECTION_SIZE);
> +	unsigned long kernel_x_end = round_up(__pa(__init_end), SECTION_SIZE);

Maybe a worthwhile config option could allow for the above to be rounded 
to PAGE_SIZE instead.  That would require a second level page table for 
the kernel text edges with increased TLB pressure but also with tighter 
protection.  That would also allow removing executability of __init 
memory after it is discarded.

>  	/* Map all the lowmem memory banks. */
>  	for_each_memblock(memory, reg) {
> @@ -1306,12 +1323,40 @@ static void __init map_lowmem(void)
>  		if (start >= end)
>  			break;
>  
> -		map.pfn = __phys_to_pfn(start);
> -		map.virtual = __phys_to_virt(start);
> -		map.length = end - start;
> -		map.type = MT_MEMORY;
> +		if (end < kernel_x_start || start >= kernel_x_end) {

Isn't it supposed to be "end <= kernel_x_start" ?

> +			map.pfn = __phys_to_pfn(start);
> +			map.virtual = __phys_to_virt(start);
> +			map.length = end - start;
> +			map.type = MT_MEMORY;

Isn't it supposed to be MT_MEMORY_NX here?

> -		create_mapping(&map);
> +			create_mapping(&map);
> +		} else {
> +			/* This better cover the entire kernel */
> +			if (start < kernel_x_start) {
> +				map.pfn = __phys_to_pfn(start);
> +				map.virtual = __phys_to_virt(start);
> +				map.length = kernel_x_start - start;
> +				map.type = MT_MEMORY_NX;
> +
> +				create_mapping(&map);
> +			}
> +
> +			map.pfn = __phys_to_pfn(kernel_x_start);
> +			map.virtual = __phys_to_virt(kernel_x_start);
> +			map.length = kernel_x_end - kernel_x_start;
> +			map.type = MT_MEMORY;
> +
> +			create_mapping(&map);
> +
> +			if (kernel_x_end < end) {
> +				map.pfn = __phys_to_pfn(kernel_x_end);
> +				map.virtual = __phys_to_virt(kernel_x_end);
> +				map.length = end - kernel_x_end;
> +				map.type = MT_MEMORY_NX;
> +
> +				create_mapping(&map);
> +			}
> +		}
>  	}
>  }
>  
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
