From: liuwenliang@huawei.com (Liuwenliang (Lamb))
Date: Thu, 19 Oct 2017 06:52:54 +0000
Subject: [PATCH 01/11] Initialize the mapping of KASan shadow memory
In-Reply-To: <31b16c9d-48c7-bc0a-51d1-cc6cf892329b@gmail.com>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
 <20171011082227.20546-2-liuwenliang@huawei.com>
 <31b16c9d-48c7-bc0a-51d1-cc6cf892329b@gmail.com>
Message-ID: <B8AC3E80E903784988AB3003E3E97330C005CCBC@dggemm510-mbx.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017.10.12 7:43AM  Dmitry Osipenko [mailto:digetx at gmail.com] wrote:
>Shouldn't all __pgprot's contain L_PTE_MT_WRITETHROUGH ?
>
>[...]
>
>--
>Dmitry

Thanks for your review. I'm sorry that my replay is so late.

I don't think L_PTE_MT_WRITETHROUGH is need for all arm soc. So I think kasan's
mapping can use PAGE_KERNEL which can be initialized for different arm soc and 
__pgprot(pgprot_val(PAGE_KERNEL) | L_PTE_RDONLY)).

I don't think the mapping table flags in kasan_early_init need be changed because of the follow reason:
1) PAGE_KERNEL can't be used in early_kasan_init because the pgprot_kernel which is used to define 
  PAGE_KERNEL doesn't be initialized. 

2) all of the kasan shadow's mapping table is going to be created again in kasan_init function.


All what I say is: I think only the mapping table flags in kasan_init function need to be changed into PAGE_KERNEL 
or  __pgprot(pgprot_val(PAGE_KERNEL) | L_PTE_RDONLY)). 

Here is the code, I has already tested:
--- a/arch/arm/mm/kasan_init.c
+++ b/arch/arm/mm/kasan_init.c
@@ -124,7 +124,7 @@ pte_t * __meminit kasan_pte_populate(pmd_t *pmd, unsigned long addr, int node)
                void *p = kasan_alloc_block(PAGE_SIZE, node);
                if (!p)
                        return NULL;
-           entry = pfn_pte(virt_to_pfn(p), __pgprot(_L_PTE_DEFAULT | L_PTE_DIRTY | L_PTE_XN));
+         entry = pfn_pte(virt_to_pfn(p), __pgprot(pgprot_val(PAGE_KERNEL)));
                set_pte_at(&init_mm, addr, pte, entry);
        }
        return pte;
@@ -253,7 +254,7 @@ void __init kasan_init(void)
                 set_pte_at(&init_mm, KASAN_SHADOW_START + i*PAGE_SIZE,
                         &kasan_zero_pte[i], pfn_pte(
                                 virt_to_pfn(kasan_zero_page),
-                                __pgprot(_L_PTE_DEFAULT | L_PTE_DIRTY | L_PTE_XN | L_PTE_RDONLY)));
+                         __pgprot(pgprot_val(PAGE_KERNEL) | L_PTE_RDONLY)));
        memset(kasan_zero_page, 0, PAGE_SIZE);
        cpu_set_ttbr0(orig_ttbr0);
        flush_cache_all();
