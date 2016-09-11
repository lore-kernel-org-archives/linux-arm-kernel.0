From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 11 Sep 2016 17:40:35 +0100
Subject: [PATCH] arm64: mm: move zero page from .bss to right before
 swapper_pg_dir
In-Reply-To: <1473604714-5512-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1473604714-5512-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu-72w5G-0=5xh70LtcpVsuK2i_jJNiG1cWnOycVGKSzbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 September 2016 at 15:38, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> Move the statically allocated zero page from the .bss section to right
> before swapper_pg_dir. This allows us to refer to its physical address
> by simply reading TTBR1_EL1 (which always points to swapper_pg_dir and
> always has its ASID field cleared), and subtracting PAGE_SIZE.
>
> Inspired-by: http://marc.info/?l=linux-arm-kernel&m=147282867511801
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/include/asm/mmu_context.h | 10 ++++++----
>  arch/arm64/kernel/head.S             |  1 -
>  arch/arm64/kernel/vmlinux.lds.S      |  2 ++
>  arch/arm64/mm/mmu.c                  |  1 -
>  4 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index b1892a0dbcb0..94461ba5febd 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -49,13 +49,15 @@ static inline void contextidr_thread_switch(struct task_struct *next)
>   */
>  static inline void cpu_set_reserved_ttbr0(void)
>  {
> -       unsigned long ttbr = virt_to_phys(empty_zero_page);
> +       unsigned long dummy;
>
> -       asm(
> +       asm volatile(
> +       "       mrs     %0, ttbr1_el1                   // get TTBR1\n"
> +       "       sub     %0, %0, %1                      // subtract PAGE_SIZE\n"
>         "       msr     ttbr0_el1, %0                   // set TTBR0\n"
>         "       isb"
> -       :
> -       : "r" (ttbr));
> +       : "=&r" (dummy)
> +       : "I" (PAGE_SIZE));
>  }
>
>  /*

This first hunk is wrong, given that cpu_set_reserved_ttbr0() may be
called when ttbr1_el1 does not point to swapper_pg_dir. But we should
be able to simply drop it without affecting the remainder of the
patch.

> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 8bc9458f9add..6020b884b076 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -449,7 +449,6 @@ __primary_switched:
>         adr_l   x2, __bss_stop
>         sub     x2, x2, x0
>         bl      __pi_memset
> -       dsb     ishst                           // Make zero page visible to PTW
>
>  #ifdef CONFIG_KASAN
>         bl      kasan_early_init
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 659963d40bb4..a14eb8ff5144 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -193,6 +193,8 @@ SECTIONS
>         . = ALIGN(PAGE_SIZE);
>         idmap_pg_dir = .;
>         . += IDMAP_DIR_SIZE;
> +       empty_zero_page = .;
> +       . += PAGE_SIZE;
>         swapper_pg_dir = .;
>         . += SWAPPER_DIR_SIZE;
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 4989948d1feb..539ce9d11325 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -53,7 +53,6 @@ EXPORT_SYMBOL(kimage_voffset);
>   * Empty_zero_page is a special page that is used for zero-initialized data
>   * and COW.
>   */
> -unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)] __page_aligned_bss;
>  EXPORT_SYMBOL(empty_zero_page);
>
>  static pte_t bm_pte[PTRS_PER_PTE] __page_aligned_bss;
> --
> 2.7.4
>
