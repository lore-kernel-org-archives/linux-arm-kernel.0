From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 05 Jul 2011 15:20:50 -0400 (EDT)
Subject: [PATCH] ARM: move memory layout sanity checking before meminfo
	initialization
In-Reply-To: <20110705185758.GI8286@n2100.arm.linux.org.uk>
References: <20110705185758.GI8286@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1107051520270.14596@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 5 Jul 2011, Russell King - ARM Linux wrote:

> Ensure that the meminfo array is sanity checked before we pass the
> memory to memblock.  This helps to ensure that memblock and meminfo
> agree on the dimensions of memory, especially when more memory is
> passed than the kernel can deal with.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>


> ---
>  arch/arm/kernel/setup.c |    2 ++
>  arch/arm/mm/mmu.c       |    5 +++--
>  arch/arm/mm/nommu.c     |    4 ++++
>  3 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index edcab02..9c3278f 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -73,6 +73,7 @@ __setup("fpe=", fpe_setup);
>  #endif
>  
>  extern void paging_init(struct machine_desc *desc);
> +extern void sanity_check_meminfo(void);
>  extern void reboot_setup(char *str);
>  
>  unsigned int processor_id;
> @@ -902,6 +903,7 @@ void __init setup_arch(char **cmdline_p)
>  
>  	parse_early_param();
>  
> +	sanity_check_meminfo();
>  	arm_memblock_init(&meminfo, mdesc);
>  
>  	paging_init(mdesc);
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index c3337de..027f118 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -781,7 +781,7 @@ early_param("vmalloc", early_vmalloc);
>  
>  static phys_addr_t lowmem_limit __initdata = 0;
>  
> -static void __init sanity_check_meminfo(void)
> +void __init sanity_check_meminfo(void)
>  {
>  	int i, j, highmem = 0;
>  
> @@ -1056,8 +1056,9 @@ void __init paging_init(struct machine_desc *mdesc)
>  {
>  	void *zero_page;
>  
> +	memblock_set_current_limit(lowmem_limit);
> +
>  	build_mem_type_table();
> -	sanity_check_meminfo();
>  	prepare_page_table();
>  	map_lowmem();
>  	devicemaps_init(mdesc);
> diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
> index 687d023..941a98c 100644
> --- a/arch/arm/mm/nommu.c
> +++ b/arch/arm/mm/nommu.c
> @@ -27,6 +27,10 @@ void __init arm_mm_memblock_reserve(void)
>  	memblock_reserve(CONFIG_VECTORS_BASE, PAGE_SIZE);
>  }
>  
> +void __init sanity_check_meminfo(void)
> +{
> +}
> +
>  /*
>   * paging_init() sets up the page tables, initialises the zone memory
>   * maps, and sets up the zero page, bad page and bad page tables.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
