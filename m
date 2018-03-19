From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 20 Mar 2018 00:17:25 +0800
Subject: [RFC PATCH 6/6] arm64/mm: use independent physical allocation for
 pgdir segment
In-Reply-To: <20180319111958.4171-7-ard.biesheuvel@linaro.org>
References: <20180319111958.4171-1-ard.biesheuvel@linaro.org>
 <20180319111958.4171-7-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu8fWMRWPZG6iCXHmcY1ediAPTXJX329yR1-kQdRkFmOjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 March 2018 at 19:19, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> In order to avoid leaking the physical placement of the kernel via
> the value off TTBR1_EL1 on platforms that are affected by variant 3a,
> replace the statically allocated page table region with a dynamically
> allocated buffer whose placement in the physical address space does
> not correlate with the placement of the kernel itself.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/mm/mmu.c | 41 ++++++++------------
>  1 file changed, 16 insertions(+), 25 deletions(-)
>

Note: this patch needs some work to use the correct
__pa_swapper_pg_dir value when booting secondaries, which is not
complicated, just missing.


> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 55c84d63244d..6c16e71c26e2 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -572,7 +572,7 @@ core_initcall(map_entry_trampoline);
>  /*
>   * Create fine-grained mappings for the kernel.
>   */
> -static void __init map_kernel(pgd_t *pgdp)
> +static void __init map_kernel(pgd_t *pgdp, phys_addr_t pgdir_phys)
>  {
>         static struct vm_struct vmlinux_text, vmlinux_rodata, vmlinux_inittext,
>                                 vmlinux_initdata, vmlinux_data, vmlinux_pgdir;
> @@ -603,8 +603,7 @@ static void __init map_kernel(pgd_t *pgdp)
>                            __pa_symbol(_data), PAGE_KERNEL,
>                            &vmlinux_data, 0, VM_NO_GUARD);
>         map_kernel_segment(pgdp, __pgdir_segment_start, __pgdir_segment_end,
> -                          __pa_symbol(__pgdir_segment_start), PAGE_KERNEL,
> -                          &vmlinux_pgdir, 0, 0);
> +                          pgdir_phys, PAGE_KERNEL, &vmlinux_pgdir, 0, 0);
>
>         if (!READ_ONCE(pgd_val(*pgd_offset_raw(pgdp, FIXADDR_START)))) {
>                 /*
> @@ -639,36 +638,28 @@ static void __init map_kernel(pgd_t *pgdp)
>   */
>  void __init paging_init(void)
>  {
> -       phys_addr_t pgd_phys = early_pgtable_alloc();
> -       pgd_t *pgdp = pgd_set_fixmap(pgd_phys);
> +       int pgdir_segment_size = __pgdir_segment_end - __pgdir_segment_start;
> +       phys_addr_t pgdir_phys = memblock_alloc(pgdir_segment_size, PAGE_SIZE);
> +       phys_addr_t p;
> +       pgd_t *pgdp;
> +
> +       for (p = 0; p < pgdir_segment_size; p += PAGE_SIZE)
> +               clear_page_phys(p);
>
> -       __pa_swapper_pg_dir = __pa_symbol(swapper_pg_dir);
> +       __pa_swapper_pg_dir = pgdir_phys + (u64)swapper_pg_dir -
> +                             (u64)__pgdir_segment_start;
>
> -       map_kernel(pgdp);
> +       pgdp = pgd_set_fixmap(__pa_swapper_pg_dir);
> +
> +       map_kernel(pgdp, pgdir_phys);
>         map_mem(pgdp);
>
> -       /*
> -        * We want to reuse the original swapper_pg_dir so we don't have to
> -        * communicate the new address to non-coherent secondaries in
> -        * secondary_entry, and so cpu_switch_mm can generate the address with
> -        * adrp+add rather than a load from some global variable.
> -        *
> -        * To do this we need to go via a temporary pgd.
> -        */
> -       cpu_replace_ttbr1(pgd_phys);
> -       memcpy(swapper_pg_dir, pgdp, PGD_SIZE);
>         cpu_replace_ttbr1(__pa_swapper_pg_dir);
>
>         pgd_clear_fixmap();
> -       memblock_free(pgd_phys, PAGE_SIZE);
>
> -       /*
> -        * We only reuse the PGD from the swapper_pg_dir, not the pud + pmd
> -        * allocated with it.
> -        */
> -       memblock_free(__pa_symbol(swapper_pg_dir) + PAGE_SIZE,
> -                     __pa_symbol(swapper_pg_end) - __pa_symbol(swapper_pg_dir)
> -                     - PAGE_SIZE);
> +       /* the statically allocated pgdir is no longer used after this point */
> +       memblock_free(__pa_symbol(__pgdir_segment_start), pgdir_segment_size);
>  }
>
>  /*
> --
> 2.11.0
>
