From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 8 Jan 2016 11:59:44 +0100
Subject: [PATCH] arm64: Honour !PTE_WRITE in set_pte_at() for kernel
 mappings
In-Reply-To: <1452182840-5120-1-git-send-email-catalin.marinas@arm.com>
References: <1452182840-5120-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <CAKv+Gu9RbzCNi-UHbL52rP=vtfutxqy8Vkn=WkQ-UQqo2Csdmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(+ Andrey)

On 7 January 2016 at 17:07, Catalin Marinas <catalin.marinas@arm.com> wrote:
> Currently, set_pte_at() only checks the software PTE_WRITE bit for user
> mappings when it sets or clears the hardware PTE_RDONLY accordingly. The
> kernel ptes are written directly without any modification, relying
> solely on the protection bits in macros like PAGE_KERNEL. However,
> modifying kernel pte attributes via pte_wrprotect() would be ignored by
> set_pte_at(). Since pte_wrprotect() does not set PTE_RDONLY (it only
> clears PTE_WRITE), the new permission is not taken into account.
>
> This patch changes set_pte_at() to adjust the read-only permission for
> kernel ptes as well. As a side effect, existing PROT_* definitions used
> for kernel ioremap*() need to include PTE_DIRTY | PTE_WRITE.
>
> (additionally, white space fix for PTE_KERNEL_ROX)
>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 63f52b55defe..8bdf47cd1bc3 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -67,11 +67,11 @@ extern void __pgd_error(const char *file, int line, unsigned long val);
>  #define PROT_DEFAULT           (PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
>  #define PROT_SECT_DEFAULT      (PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
>
> -#define PROT_DEVICE_nGnRnE     (PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_ATTRINDX(MT_DEVICE_nGnRnE))
> -#define PROT_DEVICE_nGnRE      (PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_ATTRINDX(MT_DEVICE_nGnRE))
> -#define PROT_NORMAL_NC         (PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_ATTRINDX(MT_NORMAL_NC))
> -#define PROT_NORMAL_WT         (PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_ATTRINDX(MT_NORMAL_WT))
> -#define PROT_NORMAL            (PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_ATTRINDX(MT_NORMAL))
> +#define PROT_DEVICE_nGnRnE     (PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_ATTRINDX(MT_DEVICE_nGnRnE))
> +#define PROT_DEVICE_nGnRE      (PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_ATTRINDX(MT_DEVICE_nGnRE))
> +#define PROT_NORMAL_NC         (PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_ATTRINDX(MT_NORMAL_NC))
> +#define PROT_NORMAL_WT         (PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_ATTRINDX(MT_NORMAL_WT))
> +#define PROT_NORMAL            (PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_ATTRINDX(MT_NORMAL))
>
>  #define PROT_SECT_DEVICE_nGnRE (PROT_SECT_DEFAULT | PMD_SECT_PXN | PMD_SECT_UXN | PMD_ATTRINDX(MT_DEVICE_nGnRE))
>  #define PROT_SECT_NORMAL       (PROT_SECT_DEFAULT | PMD_SECT_PXN | PMD_SECT_UXN | PMD_ATTRINDX(MT_NORMAL))
> @@ -81,7 +81,7 @@ extern void __pgd_error(const char *file, int line, unsigned long val);
>
>  #define PAGE_KERNEL            __pgprot(_PAGE_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE)
>  #define PAGE_KERNEL_RO         __pgprot(_PAGE_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_RDONLY)
> -#define PAGE_KERNEL_ROX        __pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_RDONLY)
> +#define PAGE_KERNEL_ROX                __pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_RDONLY)
>  #define PAGE_KERNEL_EXEC       __pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_WRITE)
>  #define PAGE_KERNEL_EXEC_CONT  __pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_CONT)
>
> @@ -153,6 +153,7 @@ extern struct page *empty_zero_page;
>  #define pte_write(pte)         (!!(pte_val(pte) & PTE_WRITE))
>  #define pte_exec(pte)          (!(pte_val(pte) & PTE_UXN))
>  #define pte_cont(pte)          (!!(pte_val(pte) & PTE_CONT))
> +#define pte_user(pte)          (!!(pte_val(pte) & PTE_USER))
>
>  #ifdef CONFIG_ARM64_HW_AFDBM
>  #define pte_hw_dirty(pte)      (pte_write(pte) && !(pte_val(pte) & PTE_RDONLY))
> @@ -163,8 +164,6 @@ extern struct page *empty_zero_page;
>  #define pte_dirty(pte)         (pte_sw_dirty(pte) || pte_hw_dirty(pte))
>
>  #define pte_valid(pte)         (!!(pte_val(pte) & PTE_VALID))
> -#define pte_valid_user(pte) \
> -       ((pte_val(pte) & (PTE_VALID | PTE_USER)) == (PTE_VALID | PTE_USER))
>  #define pte_valid_not_user(pte) \
>         ((pte_val(pte) & (PTE_VALID | PTE_USER)) == PTE_VALID)
>
> @@ -262,13 +261,13 @@ extern void __sync_icache_dcache(pte_t pteval, unsigned long addr);
>  static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
>                               pte_t *ptep, pte_t pte)
>  {
> -       if (pte_valid_user(pte)) {
> -               if (!pte_special(pte) && pte_exec(pte))
> -                       __sync_icache_dcache(pte, addr);
> +       if (pte_valid(pte)) {
>                 if (pte_sw_dirty(pte) && pte_write(pte))
>                         pte_val(pte) &= ~PTE_RDONLY;
>                 else
>                         pte_val(pte) |= PTE_RDONLY;
> +               if (pte_user(pte) && pte_exec(pte) && !pte_special(pte))
> +                       __sync_icache_dcache(pte, addr);
>         }
>
>         /*


This works, as far as I can tell. However, I still need the patch
below to make sure that the KAsan zero page is mapped read-only. (The
reason is that, depending on the alignment of the regions,
kasan_populate_zero_shadow() may never call
zero_[pud|pmd|pte]_populate())

Before this patch (and my change), the KAsan shadow regions looks like this:

0xffffff8000000000-0xffffff8200800000  8200M RW NX SHD AF     UXN MEM/NORMAL
0xffffff8200800000-0xffffff8200c00000     4M RW NX SHD AF BLK UXN MEM/NORMAL
0xffffff8200c00000-0xffffff8800000000 24564M RW NX SHD AF     UXN MEM/NORMAL
0xffffff8800000000-0xffffff8820200000   514M RW NX SHD AF BLK UXN MEM/NORMAL

and after:

0xffffff8000000000-0xffffff8200800000  8200M ro NX SHD AF     UXN MEM/NORMAL
0xffffff8200800000-0xffffff8200c00000     4M RW NX SHD AF BLK UXN MEM/NORMAL
0xffffff8200c00000-0xffffff8800000000 24564M ro NX SHD AF     UXN MEM/NORMAL
0xffffff8800000000-0xffffff8820200000   514M RW NX SHD AF BLK UXN MEM/NORMAL


---------8<--------------
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 72fe2978b38a..c3c14204d196 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -140,6 +140,7 @@ void __init kasan_init(void)
 {
        u64 kimg_shadow_start, kimg_shadow_end;
        struct memblock_region *reg;
+       int i;

        kimg_shadow_start = round_down((u64)kasan_mem_to_shadow(_text),
                                       SWAPPER_BLOCK_SIZE);
@@ -185,6 +186,14 @@ void __init kasan_init(void)
                                pfn_to_nid(virt_to_pfn(start)));
        }

+       /*
+        * KAsan may reuse the current contents of kasan_zero_pte
directly, so we
+        * should make sure that it maps the zero page read-only.
+        */
+       for (i = 0; i < PTRS_PER_PTE; i++)
+               set_pte(&kasan_zero_pte[i],
+                       pfn_pte(virt_to_pfn(kasan_zero_page), PAGE_KERNEL_RO));
+
        memset(kasan_zero_page, 0, PAGE_SIZE);
        cpu_replace_ttbr1(swapper_pg_dir);
