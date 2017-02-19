From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 19 Feb 2017 11:21:18 +0000
Subject: [RFC 6/7] arm64: add __map_kernel_segment to accept additional vm
 flags
In-Reply-To: <1487498660-16600-6-git-send-email-hoeun.ryu@gmail.com>
References: <1487498660-16600-1-git-send-email-hoeun.ryu@gmail.com>
 <1487498660-16600-6-git-send-email-hoeun.ryu@gmail.com>
Message-ID: <CAKv+Gu-10eLtEa-=LChCL1q=4awARp3y8pqVdhVZfmmBFs6VzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 February 2017 at 10:04, Hoeun Ryu <hoeun.ryu@gmail.com> wrote:
>  Memory attribute for `__ro_mostly_after_init` section should be changed
> via set_memory_rw/ro that doesn't work against vm areas which don't have
> VM_ALLOC.

This is for a good reason: VMALLOC regions are guaranteed to be mapped
down to pages, which is the only thing set_memory_rX() supports. On
arm64, kernel segments may be mapped using contiguous page mappings or
block mappings, which cannot be modified like this.

> Add this function to map `__ro_mostly_after_init` section with
> VM_ALLOC flag set in map_kernel.
>

If we add this functionality, I'd rather we have a special handler for
the __ro_mostly_after_init section and not use set_memory_rX().

> Signed-off-by: Hoeun Ryu <hoeun.ryu@gmail.com>
> ---
>  arch/arm64/mm/mmu.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index b805c01..91271b1 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -444,8 +444,10 @@ void mark_rodata_ro(void)
>         debug_checkwx();
>  }
>
> -static void __init map_kernel_segment(pgd_t *pgd, void *va_start, void *va_end,
> -                                     pgprot_t prot, struct vm_struct *vma)
> +static void __init __map_kernel_segment(pgd_t *pgd,
> +                                       void *va_start, void *va_end,
> +                                       pgprot_t prot, struct vm_struct *vma,
> +                                       unsigned long flags)
>  {
>         phys_addr_t pa_start = __pa_symbol(va_start);
>         unsigned long size = va_end - va_start;
> @@ -459,12 +461,18 @@ static void __init map_kernel_segment(pgd_t *pgd, void *va_start, void *va_end,
>         vma->addr       = va_start;
>         vma->phys_addr  = pa_start;
>         vma->size       = size;
> -       vma->flags      = VM_MAP;
> +       vma->flags      = flags;
>         vma->caller     = __builtin_return_address(0);
>
>         vm_area_add_early(vma);
>  }
>
> +static void __init map_kernel_segment(pgd_t *pgd, void *va_start, void *va_end,
> +                                     pgprot_t prot, struct vm_struct *vma)
> +{
> +       return __map_kernel_segment(pgd, va_start, va_end, prot, vma, VM_MAP);
> +}
> +
>  /*
>   * Create fine-grained mappings for the kernel.
>   */
> --
> 2.7.4
>
