From: james.morse@arm.com (James Morse)
Date: Fri, 6 Jul 2018 09:58:16 +0100
Subject: [PATCH v3 3/5] arm64/mm: Create initial page tables in init_pg_dir
In-Reply-To: <20180702111659.25570-4-yaojun8558363@gmail.com>
References: <20180702111659.25570-1-yaojun8558363@gmail.com>
 <20180702111659.25570-4-yaojun8558363@gmail.com>
Message-ID: <3977afaa-63ae-e390-7660-4d25146140b8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jun,

On 02/07/18 12:16, Jun Yao wrote:
> Create initial page tables in init_pg_dir and then create final
> page tables in swapper_pg_dir directly.

This is what the patch does, but doesn't preserve the why for the git-log. Could
you expand it to describe why we're doing this.


The series so far fails to boot from me. This is because the kaslr code tries to
read the kaslr-seed from the DT, via the fixmap. To do this, it needs the fixmap
tables installed, which early_fixmap_init() does.

early_fixmap_init() calls pgd_offset_k(), which assumes init_mm.pgd is in use,
so we hit a BUG_ON() when trying to setup the fixmap because we added the tables
to the wrong page tables.

If you enable 'CONFIG_RANDOMIZE_BASE', even without EFI you should see the same
thing happen.


I think we should move this hunk:
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 30ad2f085d1f..b065c08d4008 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -249,6 +249,7 @@ void __init setup_arch(char **cmdline_p)
>  	init_mm.end_code   = (unsigned long) _etext;
>  	init_mm.end_data   = (unsigned long) _edata;
>  	init_mm.brk	   = (unsigned long) _end;
> +	init_mm.pgd	   = init_pg_dir;
>
>  	*cmdline_p = boot_command_line;
>

into early_fixmap_init(), which is the first thing setup_arch() calls.
Something like [0] fixes it.

This looks to be the only thing that goes near init_mm.pgd before paging_init().


> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 7c4c8f318ba9..3b408f21fe2e 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -718,6 +718,8 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
>  }
>  #endif
>  
> +extern pgd_t init_pg_dir[PTRS_PER_PGD] __section(.init.data);
> +extern pgd_t init_pg_end[] __section(.init.data);

normally we'd spell this '__initdata', but if we move them out of the
'.init.data' section we shouldn't, otherwise the extern definition doesn't match
where the symbol appears. (Looks like I was wrong to think that tools like
sparse pick this up, that's just the __iomem/__user stuff.)


> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 2dbb2c9f1ec1..a7ab0010ff80 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -628,26 +628,10 @@ static void __init map_kernel(pgd_t *pgdp)
>   */
>  void __init paging_init(void)
>  {
> -	phys_addr_t pgd_phys = early_pgtable_alloc();
> -	pgd_t *pgdp = pgd_set_fixmap(pgd_phys);
> -
> -	map_kernel(pgdp);
> -	map_mem(pgdp);
> -
> -	/*
> -	 * We want to reuse the original swapper_pg_dir so we don't have to
> -	 * communicate the new address to non-coherent secondaries in
> -	 * secondary_entry, and so cpu_switch_mm can generate the address with
> -	 * adrp+add rather than a load from some global variable.
> -	 *
> -	 * To do this we need to go via a temporary pgd.
> -	 */
> -	cpu_replace_ttbr1(__va(pgd_phys));
> -	memcpy(swapper_pg_dir, pgdp, PGD_SIZE);
> -	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
> -
> -	pgd_clear_fixmap();
> -	memblock_free(pgd_phys, PAGE_SIZE);
> +	map_kernel(swapper_pg_dir);
> +	map_mem(swapper_pg_dir);

> +	cpu_replace_ttbr1(swapper_pg_dir);

The lm_alias() here is important: cpu_replace_ttbr1() calls virt_to_phys() on
its argument, virt_to_phys() is only intended for addresses in the linear-map
region of the VA space, as it works by doing some arithmetic with the address.

swapper_pg_dir is the name of the kernel symbol, so its address will be in the
kernel-text region of the VA space.

Today virt_to_phys() catches this happening and fixes it, CONFIG_DEBUG_VIRTUAL
will give you a warning, at some point virt_to_phys()'s safety net will go-away.

The original call that did this was wrapped in lm_alias(), which gives you the
linear-map address of a symbol in the kernel-text.


Thanks,

James


[0] make sure fixmap tables go in the init page tables
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 117d080639b3..e097c78a66f8 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -770,6 +771,13 @@ void __init early_fixmap_init(void)
        pmd_t *pmdp;
        unsigned long addr = FIXADDR_START;

+       /*
+        * During early setup we use init_pg_dir, update init_mm so its
+        * implicit use by pgd_offset_k() gets the live page tables.
+        * swapper_pg_dir is restored by paging_init().
+        */
+       init_mm.pgd = init_pg_dir;
+
        pgdp = pgd_offset_k(addr);
        pgd = READ_ONCE(*pgdp);
        if (CONFIG_PGTABLE_LEVELS > 3 &&
