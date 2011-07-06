From: heechul@illinois.edu (heechul Yun)
Date: Tue, 5 Jul 2011 20:14:57 -0700
Subject: A few other cache related optimizations for Cortex-A9.
Message-ID: <CAN_5kQBszi=hV1RVjyKO6gOhOuymGjsMwLk6ORaWpkaL-4USxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I found a few other places which, I believe, are not necessary for Cortex-A9.

diff --git a/arch/arm/mm/copypage-v6.c b/arch/arm/mm/copypage-v6.c
index bdba6c6..6d5a847 100644
--- a/arch/arm/mm/copypage-v6.c
+++ b/arch/arm/mm/copypage-v6.c
@@ -41,7 +41,9 @@ static void v6_copy_user_highpage_nonaliasing(struct page *to,
        kfrom = kmap_atomic(from, KM_USER0);
        kto = kmap_atomic(to, KM_USER1);
        copy_page(kto, kfrom);
+#ifndef CONFIG_CPU_CACHE_V7
        __cpuc_flush_dcache_area(kto, PAGE_SIZE);
+#endif
        kunmap_atomic(kto, KM_USER1);
        kunmap_atomic(kfrom, KM_USER0);
 }

On handling COW page fault, the above function is called to copy the
page content of the parent to a newly allocate page frame for the
child. Again, since D cache of A9 is PIPT, we do not need to flush the
page as in x86. This modification improves lmbench (fork/exec/shell)
performance by 4-6%.

diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
index b12cc98..bff9858 100644
--- a/arch/arm/include/asm/pgalloc.h
+++ b/arch/arm/include/asm/pgalloc.h
@@ -61,7 +61,9 @@ pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr)

        pte = (pte_t *)__get_free_page(PGALLOC_GFP);
        if (pte) {
+#if !CONFIG_CPU_CACHE_V7
                clean_dcache_area(pte, sizeof(pte_t) * PTRS_PER_PTE);
+#endif
                pte += PTRS_PER_PTE;
        }

@@ -81,7 +83,9 @@ pte_alloc_one(struct mm_struct *mm, unsigned long addr)
        if (pte) {
                if (!PageHighMem(pte)) {
                        void *page = page_address(pte);
+#if !CONFIG_CPU_CACHE_V7
                        clean_dcache_area(page, sizeof(pte_t) * PTRS_PER_PTE);
+#endif
                }
                pgtable_page_ctor(pte);
        }
diff --git a/arch/arm/mm/pgd.c b/arch/arm/mm/pgd.c
index be5f58e..343df1b 100644
--- a/arch/arm/mm/pgd.c
+++ b/arch/arm/mm/pgd.c
@@ -41,8 +41,9 @@ pgd_t *get_pgd_slow(struct mm_struct *mm)
        memcpy(new_pgd + FIRST_KERNEL_PGD_NR, init_pgd + FIRST_KERNEL_PGD_NR,
                       (PTRS_PER_PGD - FIRST_KERNEL_PGD_NR) * sizeof(pgd_t));

+#if !CONFIG_CPU_CACHE_V7
        clean_dcache_area(new_pgd, PTRS_PER_PGD * sizeof(pgd_t));
-
+#endif
        if (!vectors_high()) {
                /*
                 * On ARM, first page must always be allocated since it

Creating page tables also do not need to clean cache-line because of
the same reason as above.
This patch improves lmbench3 (fork/exec/shell) performance by 10%~20%
in my test.

I think above two patches work for least Cortex-A9 although I am not
sure the use of CONFIG_CPU_CACHE_V7 is appropriate.

Thanks
