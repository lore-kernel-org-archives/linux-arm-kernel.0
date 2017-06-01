From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 1 Jun 2017 17:40:45 +0000
Subject: [PATCH v5] arm64: fix the overlap between the kernel image and
 vmalloc address
In-Reply-To: <1496323611-53377-1-git-send-email-zhongjiang@huawei.com>
References: <1496323611-53377-1-git-send-email-zhongjiang@huawei.com>
Message-ID: <CAKv+Gu-WL33LHKzwmNaw8-QDVEh6VjwhFohLUrOZH41CLUHG_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On 1 June 2017 at 13:26, zhongjiang <zhongjiang@huawei.com> wrote:
> Recently, xiaojun report the following issue.
>
> [ 4544.984139] Unable to handle kernel paging request at virtual address ffff804392800000

This is not a vmalloc address ^^^

[...]
>
> I find the issue is introduced when applying commit f9040773b7bb
> ("arm64: move kernel image to base of vmalloc area"). This patch
> make the kernel image overlap with vmalloc area. It will result in
> vmalloc area have the huge page table. but the vmalloc_to_page is
> not realize the change. and the function is public to any arch.
>
> I fix it by adding the another kernel image condition in vmalloc_to_page
> to make it keep the accordance with previous vmalloc mapping.
>

... so while I agree that there is probably an issue to be solved
here, I don't see how this patch fixes the problem. This particular
crash may be caused by an assumption on the part of the kcore code
that there are no holes in the linear region.

> Fixes: f9040773b7bb ("arm64: move kernel image to base of vmalloc area")
> Reported-by: tan xiaojun <tanxiaojun@huawei.com>
> Reviewed-by: Laura Abbott <labbott@redhat.com>
> Signed-off-by: zhongjiang <zhongjiang@huawei.com>

So while I think we all agree that the kcore code is likely to get
confused due to the overlap between vmlinux and the vmalloc region, I
would like to better understand how it breaks things, and whether we'd
be better off simply teaching vread/vwrite how to interpret block
mappings.

Could you check whether CONFIG_DEBUG_PAGEALLOC makes the issue go away
(once you have really managed to reproduce it?)

Thanks,
Ard.


> ---
>  arch/arm64/mm/mmu.c     |  2 +-
>  include/linux/vmalloc.h |  1 +
>  mm/vmalloc.c            | 31 ++++++++++++++++++++++++-------
>  3 files changed, 26 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 0c429ec..2265c39 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -509,7 +509,7 @@ static void __init map_kernel_segment(pgd_t *pgd, void *va_start, void *va_end,
>         vma->addr       = va_start;
>         vma->phys_addr  = pa_start;
>         vma->size       = size;
> -       vma->flags      = VM_MAP;
> +       vma->flags      = VM_KERNEL;
>         vma->caller     = __builtin_return_address(0);
>
>         vm_area_add_early(vma);
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 0328ce0..c9245af 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -17,6 +17,7 @@
>  #define VM_ALLOC               0x00000002      /* vmalloc() */
>  #define VM_MAP                 0x00000004      /* vmap()ed pages */
>  #define VM_USERMAP             0x00000008      /* suitable for remap_vmalloc_range */
> +#define VM_KERNEL              0x00000010      /* kernel pages */
>  #define VM_UNINITIALIZED       0x00000020      /* vm_struct is not fully initialized */
>  #define VM_NO_GUARD            0x00000040      /* don't add guard page */
>  #define VM_KASAN               0x00000080      /* has allocated kasan shadow memory */
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 1dda6d8..104fc70 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1966,12 +1966,25 @@ void *vmalloc_32_user(unsigned long size)
>  }
>  EXPORT_SYMBOL(vmalloc_32_user);
>
> +static inline struct page *vmalloc_image_to_page(char *addr,
> +                                               struct vm_struct *vm)
> +{
> +       struct page *p = NULL;
> +
> +       if (vm->flags & VM_KERNEL)
> +               p = virt_to_page(lm_alias(addr));
> +       else
> +               p = vmalloc_to_page(addr);
> +
> +       return p;
> +}
> +
>  /*
>   * small helper routine , copy contents to buf from addr.
>   * If the page is not present, fill zero.
>   */
> -
> -static int aligned_vread(char *buf, char *addr, unsigned long count)
> +static int aligned_vread(char *buf, char *addr, unsigned long count,
> +                                       struct vm_struct *vm)
>  {
>         struct page *p;
>         int copied = 0;
> @@ -1983,7 +1996,7 @@ static int aligned_vread(char *buf, char *addr, unsigned long count)
>                 length = PAGE_SIZE - offset;
>                 if (length > count)
>                         length = count;
> -               p = vmalloc_to_page(addr);
> +               p = vmalloc_image_to_page(addr, vm);
>                 /*
>                  * To do safe access to this _mapped_ area, we need
>                  * lock. But adding lock here means that we need to add
> @@ -2010,7 +2023,8 @@ static int aligned_vread(char *buf, char *addr, unsigned long count)
>         return copied;
>  }
>
> -static int aligned_vwrite(char *buf, char *addr, unsigned long count)
> +static int aligned_vwrite(char *buf, char *addr, unsigned long count,
> +                                       struct vm_struct *vm)
>  {
>         struct page *p;
>         int copied = 0;
> @@ -2022,7 +2036,7 @@ static int aligned_vwrite(char *buf, char *addr, unsigned long count)
>                 length = PAGE_SIZE - offset;
>                 if (length > count)
>                         length = count;
> -               p = vmalloc_to_page(addr);
> +               p = vmalloc_image_to_page(addr, vm);
>                 /*
>                  * To do safe access to this _mapped_ area, we need
>                  * lock. But adding lock here means that we need to add
> @@ -2109,7 +2123,7 @@ long vread(char *buf, char *addr, unsigned long count)
>                 if (n > count)
>                         n = count;
>                 if (!(vm->flags & VM_IOREMAP))
> -                       aligned_vread(buf, addr, n);
> +                       aligned_vread(buf, addr, n, vm);
>                 else /* IOREMAP area is treated as memory hole */
>                         memset(buf, 0, n);
>                 buf += n;
> @@ -2190,7 +2204,7 @@ long vwrite(char *buf, char *addr, unsigned long count)
>                 if (n > count)
>                         n = count;
>                 if (!(vm->flags & VM_IOREMAP)) {
> -                       aligned_vwrite(buf, addr, n);
> +                       aligned_vwrite(buf, addr, n, vm);
>                         copied++;
>                 }
>                 buf += n;
> @@ -2710,6 +2724,9 @@ static int s_show(struct seq_file *m, void *p)
>         if (v->flags & VM_USERMAP)
>                 seq_puts(m, " user");
>
> +       if (v->flags & VM_KERNEL)
> +               seq_puts(m, " kernel");
> +
>         if (is_vmalloc_addr(v->pages))
>                 seq_puts(m, " vpages");
>
> --
> 1.7.12.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
