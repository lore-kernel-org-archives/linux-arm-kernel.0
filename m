From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 9 Oct 2018 14:37:22 +0200
Subject: [PATCH] arm64: mm: Use #ifdef for the __PAGETABLE_P?D_FOLDED
 defines
In-Reply-To: <20181005134916.12937-1-james.morse@arm.com>
References: <20181005134916.12937-1-james.morse@arm.com>
Message-ID: <CAMuHMdUFzHUJk7dT9CqF1uCg3bPr-Mh6LWTj6RpdcXLPRQkFEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 5, 2018 at 3:55 PM James Morse <james.morse@arm.com> wrote:
> __is_defined(__PAGETABLE_P?D_FOLDED) doesn't quite work as intended
> as these symbols are internal to asm-generic and aren't defined in the
> way kconfig expects. This makes them always evaluate to false.
> Switch to #ifdef.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> CC: Mark Rutland <mark.rutland@arm.com>
> ---
>
>  arch/arm64/include/asm/pgtable.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index b58f764babf8..50b1ef8584c0 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -445,10 +445,12 @@ static inline bool in_swapper_pgdir(void *addr)
>
>  static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
>  {
> -       if (__is_defined(__PAGETABLE_PMD_FOLDED) && in_swapper_pgdir(pmdp)) {
> +#ifdef __PAGETABLE_PMD_FOLDED
> +       if (in_swapper_pgdir(pmdp)) {
>                 set_swapper_pgd((pgd_t *)pmdp, __pgd(pmd_val(pmd)));
>                 return;
>         }
> +#endif /* __PAGETABLE_PMD_FOLDED */
>
>         WRITE_ONCE(*pmdp, pmd);
>
> @@ -503,10 +505,12 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
>
>  static inline void set_pud(pud_t *pudp, pud_t pud)
>  {
> -       if (__is_defined(__PAGETABLE_PUD_FOLDED) && in_swapper_pgdir(pudp)) {
> +#ifdef __PAGETABLE_PUD_FOLDED
> +       if (in_swapper_pgdir(pudp)) {
>                 set_swapper_pgd((pgd_t *)pudp, __pgd(pud_val(pud)));
>                 return;
>         }
> +#endif /* __PAGETABLE_PUD_FOLDED */
>
>         WRITE_ONCE(*pudp, pud);
>

This is now e9ed821be48600ea ("arm64: mm: Use #ifdef for the
__PAGETABLE_P?D_FOLDED defines") in arm64/for-next/core.

If CONFIG_DEBUG_VIRTUAL=y, it prints a few times during boot on
several R-Car Gen3 platforms:

virt_to_phys used for non-linear address: (____ptrval____)
(swapper_pg_dir+0x7e0/0x1000)
WARNING: CPU: 0 PID: 0 at arch/arm64/mm/physaddr.c:15 __virt_to_phys+0x28/0x60
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted
4.19.0-rc7-ebisu-06695-ga0f4930e0a9c94c9 #36
Hardware name: Renesas Ebisu board based on r8a77990 (DT)
pstate: 60400085 (nZCv daIf +PAN -UAO)
pc : __virt_to_phys+0x28/0x60
lr : __virt_to_phys+0x28/0x60
sp : ffffff8009003d00
x29: ffffff8009003d00 x28: 0000000048e00018
x27: ffffffbf00000000 x26: 0060000000000711
x25: 0060000000000f11 x24: ffffffbf00dfffff
x23: ffffff8009107628 x22: ffffffbf00e00000
x21: 000000007b1cf003 x20: ffffff8008d3c7e0
x19: ffffff8008d3c7e0 x18: 000000000000000a
x17: 0000000000000000 x16: 0000000061cb4b2b
x15: 0000000000000000 x14: 645f67705f726570
x13: 706177732820295f x12: 5f5f5f6c61767274
x11: 705f5f5f5f28203a x10: 7373657264646120
x9 : ffffff800900e6d0 x8 : 0000000000000000
x7 : ffffff800814bcd4 x6 : 0000000000000001
x5 : 0000000000000000 x4 : 0000000000000000
x3 : ffffffffffffffff x2 : ffffff8009036f60
x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 __virt_to_phys+0x28/0x60
 set_swapper_pgd+0x2c/0xc8
 vmemmap_pud_populate+0x48/0x6c
 vmemmap_populate+0x74/0x150
 sparse_mem_map_populate+0x48/0x5c
 sparse_init_nid+0x234/0x2f4
 sparse_init+0xf4/0x1b4
 bootmem_init+0x80/0x1a4
 setup_arch+0x1ec/0x52c
 start_kernel+0x78/0x45c

Reverting this commit fixes the symptoms, but I doubt it fixes the real
underlying issue.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
