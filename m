From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 7 Oct 2016 10:31:14 +0100
Subject: [PATCH v3] arm64: mm: move zero page from .bss to right before
 swapper_pg_dir
In-Reply-To: <1473696925-26156-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1473696925-26156-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu-V+OKoeNFqvHvQOOFYi4VLm5mLKrmf9Z5oZY4KQkirsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 September 2016 at 17:15, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> Move the statically allocated zero page from the .bss section to right
> before swapper_pg_dir. This allows us to refer to its physical address
> by simply reading TTBR1_EL1 (which always points to swapper_pg_dir and
> always has its ASID field cleared), and subtracting PAGE_SIZE.
>
> To protect the zero page from inadvertent modification, carve out a
> segment that covers it as well as idmap_pg_dir[], and mark it read-only
> in both the primary and the linear mappings of the kernel.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
[...]
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 05615a3fdc6f..d2be62ff1ad3 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
[...]
> @@ -424,13 +430,19 @@ static void __init map_kernel_segment(pgd_t *pgd, void *va_start, void *va_end,
>   */
>  static void __init map_kernel(pgd_t *pgd)
>  {
> -       static struct vm_struct vmlinux_text, vmlinux_rodata, vmlinux_init, vmlinux_data;
> +       static struct vm_struct vmlinux_text, vmlinux_rodata, vmlinux_init,
> +                               vmlinux_data, vmlinux_robss, vmlinux_swapper;
>
>         map_kernel_segment(pgd, _text, _etext, PAGE_KERNEL_EXEC, &vmlinux_text);
>         map_kernel_segment(pgd, __start_rodata, __init_begin, PAGE_KERNEL, &vmlinux_rodata);
>         map_kernel_segment(pgd, __init_begin, __init_end, PAGE_KERNEL_EXEC,
>                            &vmlinux_init);
> -       map_kernel_segment(pgd, _data, _end, PAGE_KERNEL, &vmlinux_data);
> +       map_kernel_segment(pgd, _data, __robss_start, PAGE_KERNEL,
> +                          &vmlinux_data);
> +       map_kernel_segment(pgd, __robss_start, __robss_end, PAGE_KERNEL_RO,
> +                          &vmlinux_robss);

I realised it is actually unnecessary to map the idmap and the zero
page into the kernel mapping, so we could drop this line.
