From: keescook@chromium.org (Kees Cook)
Date: Fri, 19 Feb 2016 11:05:17 -0800
Subject: [PATCH v3] arm64: mm: Mark .rodata as RO
In-Reply-To: <1455904232-24053-1-git-send-email-jeremy.linton@arm.com>
References: <1455904232-24053-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <CAGXu5jJi9174OGM_xc2qriRrfajZ4UNgiTCODkhreRck_Q9NAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 19, 2016 at 9:50 AM, Jeremy Linton <jeremy.linton@arm.com> wrote:
> Currently the .rodata section is actually still executable when DEBUG_RODATA
> is enabled. This changes that so the .rodata is actually read only, no execute.
> It also adds the .rodata section to the mem_init banner.
>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/arm64/kernel/vmlinux.lds.S |  5 +++--
>  arch/arm64/mm/init.c            |  4 +++-
>  arch/arm64/mm/mmu.c             | 17 +++++++++++++----
>  3 files changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 8f4fc2c..9208f53 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -114,8 +114,9 @@ SECTIONS
>                 *(.got)                 /* Global offset table          */
>         }
>
> -       RO_DATA(PAGE_SIZE)
> -       EXCEPTION_TABLE(8)
> +       ALIGN_DEBUG_RO_MIN(0)
> +       RO_DATA(PAGE_SIZE)              /* everything from this point to */
> +       EXCEPTION_TABLE(8)              /* _etext will be marked RO NX   */
>         NOTES
>
>         ALIGN_DEBUG_RO_MIN(PAGE_SIZE)
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 5dd0831..41be7db 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -325,6 +325,7 @@ void __init mem_init(void)
>                   "    memory  : 0x%16lx - 0x%16lx   (%6ld MB)\n"
>                   "      .init : 0x%p" " - 0x%p" "   (%6ld KB)\n"
>                   "      .text : 0x%p" " - 0x%p" "   (%6ld KB)\n"
> +                 "    .rodata : 0x%p" " - 0x%p" "   (%6ld KB)\n"
>                   "      .data : 0x%p" " - 0x%p" "   (%6ld KB)\n",
>  #ifdef CONFIG_KASAN
>                   MLG(KASAN_SHADOW_START, KASAN_SHADOW_END),
> @@ -341,7 +342,8 @@ void __init mem_init(void)
>                   MLM(MODULES_VADDR, MODULES_END),
>                   MLM(PAGE_OFFSET, (unsigned long)high_memory),
>                   MLK_ROUNDUP(__init_begin, __init_end),
> -                 MLK_ROUNDUP(_text, _etext),
> +                 MLK_ROUNDUP(_text, __start_rodata),
> +                 MLK_ROUNDUP(__start_rodata, _etext),
>                   MLK_ROUNDUP(_sdata, _edata));
>
>  #undef MLK
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index ab69a99..a18dfd0 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -453,10 +453,18 @@ static void __init map_mem(pgd_t *pgd)
>  #ifdef CONFIG_DEBUG_RODATA
>  void mark_rodata_ro(void)
>  {
> -       create_mapping_late(__pa(_stext), (unsigned long)_stext,
> -                               (unsigned long)_etext - (unsigned long)_stext,
> -                               PAGE_KERNEL_ROX);
> +       unsigned long section_size;
>
> +       section_size = (unsigned long)__start_rodata - (unsigned long)_stext;
> +       create_mapping_late(__pa(_stext), (unsigned long)_stext,
> +                           section_size, PAGE_KERNEL_ROX);
> +       /*
> +        * mark .rodata as read only. Use _etext rather than __end_rodata to
> +        * cover NOTES and EXCEPTION_TABLE.
> +        */
> +       section_size = (unsigned long)_etext - (unsigned long)__start_rodata;
> +       create_mapping_late(__pa(__start_rodata), (unsigned long)__start_rodata,
> +                           section_size, PAGE_KERNEL_RO);
>  }
>  #endif
>
> @@ -486,7 +494,8 @@ static void __init map_kernel_chunk(pgd_t *pgd, void *va_start, void *va_end,
>  static void __init map_kernel(pgd_t *pgd)
>  {
>
> -       map_kernel_chunk(pgd, _stext, _etext, PAGE_KERNEL_EXEC);
> +       map_kernel_chunk(pgd, _stext, __start_rodata, PAGE_KERNEL_EXEC);
> +       map_kernel_chunk(pgd, __start_rodata, _etext, PAGE_KERNEL);
>         map_kernel_chunk(pgd, __init_begin, __init_end, PAGE_KERNEL_EXEC);
>         map_kernel_chunk(pgd, _data, _end, PAGE_KERNEL);
>
> --
> 2.4.3
>



-- 
Kees Cook
Chrome OS & Brillo Security
