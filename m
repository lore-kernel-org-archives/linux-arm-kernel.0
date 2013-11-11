From: kmpark@infradead.org (Kyungmin Park)
Date: Tue, 12 Nov 2013 08:37:09 +0900
Subject: [RFC PATCH 3/4] mm/vmalloc.c: Allow lowmem to be tracked in
 vmalloc
In-Reply-To: <1384212412-21236-4-git-send-email-lauraa@codeaurora.org>
References: <1384212412-21236-1-git-send-email-lauraa@codeaurora.org>
 <1384212412-21236-4-git-send-email-lauraa@codeaurora.org>
Message-ID: <CAH9JG2Uh7PBEqRGPe5H6H+n1cnqwLFrFfB9aUOee8myG27DoiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

On Tue, Nov 12, 2013 at 8:26 AM, Laura Abbott <lauraa@codeaurora.org> wrote:
> vmalloc is currently assumed to be a completely separate address space
> from the lowmem region. While this may be true in the general case,
> there are some instances where lowmem and virtual space intermixing
> provides gains. One example is needing to steal a large chunk of physical
> lowmem for another purpose outside the systems usage. Rather than
> waste the precious lowmem space on a 32-bit system, we can allow the
> virtual holes created by the physical holes to be used by vmalloc
> for virtual addressing. Track lowmem allocations in vmalloc to
> allow mixing of lowmem and vmalloc.
>
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> Signed-off-by: Neeti Desai <neetid@codeaurora.org>
> ---
>  include/linux/mm.h      |    6 ++++++
>  include/linux/vmalloc.h |    1 +
>  mm/Kconfig              |   11 +++++++++++
>  mm/vmalloc.c            |   26 ++++++++++++++++++++++++++
>  4 files changed, 44 insertions(+), 0 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index f022460..76df50d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -308,6 +308,10 @@ unsigned long vmalloc_to_pfn(const void *addr);
>   * On nommu, vmalloc/vfree wrap through kmalloc/kfree directly, so there
>   * is no special casing required.
>   */
> +
> +#ifdef CONFIG_VMALLOC_SAVING
mismatch below Kconfig. CONFIG_ENABLE_VMALLOC_SAVING?
> +extern int is_vmalloc_addr(const void *x)
> +#else
>  static inline int is_vmalloc_addr(const void *x)
>  {
>  #ifdef CONFIG_MMU
> @@ -318,6 +322,8 @@ static inline int is_vmalloc_addr(const void *x)
>         return 0;
>  #endif
>  }
> +#endif
> +
>  #ifdef CONFIG_MMU
>  extern int is_vmalloc_or_module_addr(const void *x);
>  #else
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 4b8a891..e0c8c49 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -16,6 +16,7 @@ struct vm_area_struct;                /* vma defining user mapping in mm_types.h */
>  #define VM_USERMAP             0x00000008      /* suitable for remap_vmalloc_range */
>  #define VM_VPAGES              0x00000010      /* buffer for pages was vmalloc'ed */
>  #define VM_UNINITIALIZED       0x00000020      /* vm_struct is not fully initialized */
> +#define VM_LOWMEM              0x00000040      /* Tracking of direct mapped lowmem */
>  /* bits [20..32] reserved for arch specific ioremap internals */
>
>  /*
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 8028dcc..b3c459d 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -519,3 +519,14 @@ config MEM_SOFT_DIRTY
>           it can be cleared by hands.
>
>           See Documentation/vm/soft-dirty.txt for more details.
> +
> +config ENABLE_VMALLOC_SAVING
> +       bool "Intermix lowmem and vmalloc virtual space"
> +       depends on ARCH_TRACKS_VMALLOC
> +       help
> +         Some memory layouts on embedded systems steal large amounts
> +         of lowmem physical memory for purposes outside of the kernel.
> +         Rather than waste the physical and virtual space, allow the
> +         kernel to use the virtual space as vmalloc space.
> +
> +         If unsure, say N.
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 13a5495..c7b138b 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -204,6 +204,29 @@ static int vmap_page_range(unsigned long start, unsigned long end,
>         return ret;
>  }
>
> +#ifdef ENABLE_VMALLOC_SAVING
missing "CONFIG_"

Thank you,
Kyungimn Park
> +int is_vmalloc_addr(const void *x)
> +{
> +       struct rb_node *n;
> +       struct vmap_area *va;
> +       int ret = 0;
> +
> +       spin_lock(&vmap_area_lock);
> +
> +       for (n = rb_first(vmap_area_root); n; rb_next(n)) {
> +               va = rb_entry(n, struct vmap_area, rb_node);
> +               if (x >= va->va_start && x < va->va_end) {
> +                       ret = 1;
> +                       break;
> +               }
> +       }
> +
> +       spin_unlock(&vmap_area_lock);
> +       return ret;
> +}
> +EXPORT_SYMBOL(is_vmalloc_addr);
> +#endif
> +
>  int is_vmalloc_or_module_addr(const void *x)
>  {
>         /*
> @@ -2628,6 +2651,9 @@ static int s_show(struct seq_file *m, void *p)
>         if (v->flags & VM_VPAGES)
>                 seq_printf(m, " vpages");
>
> +       if (v->flags & VM_LOWMEM)
> +               seq_printf(m, " lowmem");
> +
>         show_numa_info(m, v);
>         seq_putc(m, '\n');
>         return 0;
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by The Linux Foundation
>
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo at kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email at kvack.org </a>
