From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Oct 2017 15:43:28 +0100
Subject: [RFC/PATCH v3] arm64: define MODULES_VADDR by module_alloc_base
In-Reply-To: <1504093593-2586-1-git-send-email-miles.chen@mediatek.com>
References: <1504093593-2586-1-git-send-email-miles.chen@mediatek.com>
Message-ID: <20171017144328.GG14051@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 30, 2017 at 07:46:33PM +0800, Miles Chen wrote:
> After the kernel ASLR, the module virtual address is moved to
> [module_alloc_base, module_alloc_base + MODULES_VSIZE).
> However, the MODULES_VADDR is still defined as a constant and functions
> like is_vmalloc_or_module_addr() or dump functions will not able to
> use correct module range information.
> 
> The patch omits modules information in virtual kenrel memory layout if
> the modules area is fully mapped whitin vmalloc area.
> 
> Use module_alloc_base to define MODULES_VADDR. I tested the patch under
> three different conditions:
> 1.CONFIG_RANDOMIZE_BASE=y, seed=0
> CONFIG_KASAN=n
> 2.CONFIG_RANDOMIZE_BASE=y, seed=0x2304909023333333
> CONFIG_KASAN=n
> 3.CONFIG_RANDOMIZE_BASE=y, seed=0x2304909023333333
> CONFIG_KASAN=y
> 
> test log:

[...]

> diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
> index ca74a2a..18be771 100644
> --- a/arch/arm64/mm/dump.c
> +++ b/arch/arm64/mm/dump.c
> @@ -29,15 +29,36 @@
>  #include <asm/pgtable-hwdef.h>
>  #include <asm/ptdump.h>
>  
> -static const struct addr_marker address_markers[] = {
> +enum marker {
> +#ifdef CONFIG_KASAN
> +	E_KASAN_SHADOW_START,
> +	E_KASAN_SHADOW_END,
> +#endif
> +	E_MODULES_VADDR,
> +	E_MODULES_END,
> +	E_VMALLOC_START,
> +	E_VMALLOC_END,
> +	E_FIXADDR_START,
> +	E_FIXADDR_TOP,
> +	E_PCI_IO_START,
> +	E_PCI_IO_END,
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> +	E_VMEMMAP_START,
> +	E_VMEMMAP_END,
> +#endif
> +	E_PAGE_OFFSET,
> +	E_NR_MARKER,
> +};
> +
> +static struct addr_marker address_markers[] = {
>  #ifdef CONFIG_KASAN
>  	{ KASAN_SHADOW_START,		"Kasan shadow start" },
>  	{ KASAN_SHADOW_END,		"Kasan shadow end" },
>  #endif
> -	{ MODULES_VADDR,		"Modules start" },
> -	{ MODULES_END,			"Modules end" },
> -	{ VMALLOC_START,		"vmalloc() Area" },
> -	{ VMALLOC_END,			"vmalloc() End" },
> +	{ -1,				"Modules start" },
> +	{ -1,				"Modules end" },
> +	{ -1,				"vmalloc() Area" },
> +	{ -1,				"vmalloc() End" },
>  	{ FIXADDR_START,		"Fixmap start" },
>  	{ FIXADDR_TOP,			"Fixmap end" },
>  	{ PCI_IO_START,			"PCI I/O start" },
> @@ -362,10 +383,32 @@ void ptdump_walk_pgd(struct seq_file *m, struct ptdump_info *info)
>  	note_page(&st, 0, 0, 0);
>  }
>  
> +static void fixup_markers(void)
> +{
> +	int i;
> +
> +	address_markers[E_MODULES_VADDR].start_address = MODULES_VADDR;
> +	address_markers[E_MODULES_END].start_address = MODULES_END;
> +	address_markers[E_VMALLOC_START].start_address = VMALLOC_START;
> +	address_markers[E_VMALLOC_END].start_address = VMALLOC_END;
> +
> +	if (MODULES_VADDR < VMALLOC_START) {
> +		address_markers[E_MODULES_END].start_address =
> +			(MODULES_END < VMALLOC_START) ?
> +			MODULES_END : VMALLOC_START;
> +	} else {
> +		/* modules is contains in vamlloc area, don't show them */
> +		for (i = E_MODULES_VADDR; i <= E_NR_MARKER - 2; i++)
> +			address_markers[i] = address_markers[i + 2];
> +	}
> +}

This all seems a bit over-engineered to me and we end up having to maintain
enum marker in conjunction with the address_markers array. Fixing the array
up at runtime also worries me slightly, because we end up with the last two
entries being duplicated. That doesn't seem to hurt for now, but it's weird
and I can imagine it causing problems in the future.

Is there not a simpler fix here?

Will
