From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 17 Feb 2016 17:46:34 +0100
Subject: [PATCH v2 1/2] arm64: mm: Mark .rodata as RO
In-Reply-To: <1455727274-16328-2-git-send-email-jeremy.linton@arm.com>
References: <1455727274-16328-1-git-send-email-jeremy.linton@arm.com>
 <1455727274-16328-2-git-send-email-jeremy.linton@arm.com>
Message-ID: <CAKv+Gu82_sXwRjZpqsLDMc_MVwZ3bRLodS4TEQRoRSKQCNQu3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 February 2016 at 17:41, Jeremy Linton <jeremy.linton@arm.com> wrote:
> Currently the .rodata section is actually still executable when DEBUG_RODATA
> is enabled. This changes that so the .rodata is actually read only, no execute.
>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/kernel/vmlinux.lds.S |  5 +++--
>  arch/arm64/mm/mmu.c             | 17 +++++++++++++----
>  2 files changed, 16 insertions(+), 6 deletions(-)
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
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index ab69a99..9aa5201 100644
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
> +       map_kernel_chunk(pgd, __start_rodata, _etext, PAGE_KERNEL_EXEC);

Couldn't we map this non-exec from the start?

>         map_kernel_chunk(pgd, __init_begin, __init_end, PAGE_KERNEL_EXEC);
>         map_kernel_chunk(pgd, _data, _end, PAGE_KERNEL);
>
> --
> 2.4.3
>
