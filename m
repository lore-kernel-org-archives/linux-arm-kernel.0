From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 17 Sep 2011 16:19:53 +0100
Subject: [PATCH 16/19] ARM: move iotable mappings within the vmalloc region
In-Reply-To: <1316156850-31013-17-git-send-email-nico@fluxnic.net>
References: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
	<1316156850-31013-17-git-send-email-nico@fluxnic.net>
Message-ID: <20110917151953.GJ16381@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2011 at 03:07:27AM -0400, Nicolas Pitre wrote:
>  void __init iotable_init(struct map_desc *io_desc, int nr)
>  {
> -	int i;
> +	struct map_desc *md;
> +	struct vm_struct *vm;
> +
> +	vm = __va(memblock_alloc(sizeof(*vm) * nr, __alignof__(*vm)));
> +	memset(vm, 0, sizeof(*vm) * nr);

Any reason not to adapt early_alloc() ?

>  
> -	for (i = 0; i < nr; i++)
> -		create_mapping(io_desc + i);
> +	for (md = io_desc; nr; md++, nr--) {
> +		create_mapping(md);
> +		vm->addr = (void *)(md->virtual & PAGE_MASK);
> +		vm->size = PAGE_ALIGN(md->length + (md->virtual & ~PAGE_MASK));
> +		vm->phys_addr = __pfn_to_phys(md->pfn); 
> +		vm->flags = VM_IOREMAP;
> +		vm->caller = iotable_init;
> +		vm_area_add_early(vm++);
> +	}
>  }
>  
> -static void * __initdata vmalloc_min = (void *)(VMALLOC_END - SZ_128M);
> +static void * __initdata vmalloc_min = (void *)(0xf0000000UL - VMALLOC_OFFSET);

This is silly.  You're defining VMALLOC_END to be 0xff000000UL, and
then defining this to be 0xf0000000UL - 8MB.  Why hide the 240MB
inside these constants?  Why not set it to VMALLOC_END - 240MB -
VMALLOC_OFFSET - making the size in their _explicit_ instead of hidden?

>  /*
>   * vmalloc=size forces the vmalloc area to be exactly 'size'
>   * bytes. This can be used to increase (or decrease) the vmalloc
> - * area - the default is 128m.
> + * area - the default is 240m.
>   */
>  static int __init early_vmalloc(char *arg)
>  {
> @@ -853,6 +866,7 @@ void __init sanity_check_meminfo(void)
>  #endif
>  	meminfo.nr_banks = j;
>  	memblock_set_current_limit(lowmem_limit);
> +	high_memory = __va(lowmem_limit - 1) + 1;

NAK.  This ends up initializing this setting twice during the boot,
potentially leading to bugs because they're both done in different ways.
You don't describe why this change is necessary so I assume that it's
part of some debugging you were trying and shouldn't be in this patch.

> @@ -977,6 +991,12 @@ static void __init devicemaps_init(struct machine_desc *mdesc)
>  	}
>  
>  	/*
> +	 * Clear the vmalloc area.
> +	 */
> +	for (addr = VMALLOC_START; addr < VMALLOC_END; addr += PGDIR_SIZE)
> +		pmd_clear(pmd_off_k(addr));

Why not combine this with the clearance above:

        for (addr = VMALLOC_END; addr; addr += PGDIR_SIZE)
                pmd_clear(pmd_off_k(addr));

?
