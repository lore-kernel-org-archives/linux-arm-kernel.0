From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 7 Oct 2014 21:39:54 +0200
Subject: [PATCH v2 1/3] arm64: KVM: Implement 48 VA support for KVM EL2
 and Stage-2
In-Reply-To: <5433EA8B.6010502@arm.com>
References: <1412627427-28629-1-git-send-email-christoffer.dall@linaro.org>
 <1412627427-28629-2-git-send-email-christoffer.dall@linaro.org>
 <20141007104846.GB12675@e104818-lin.cambridge.arm.com>
 <5433EA8B.6010502@arm.com>
Message-ID: <20141007193954.GI3717@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 07, 2014 at 02:28:43PM +0100, Marc Zyngier wrote:
> On 07/10/14 11:48, Catalin Marinas wrote:
> > On Mon, Oct 06, 2014 at 09:30:25PM +0100, Christoffer Dall wrote:
> >> +/**
> >> + * kvm_prealloc_hwpgd - allocate inital table for VTTBR
> >> + * @kvm:       The KVM struct pointer for the VM.
> >> + * @pgd:       The kernel pseudo pgd
> >> + *
> >> + * When the kernel uses more levels of page tables than the guest, we allocate
> >> + * a fake PGD and pre-populate it to point to the next-level page table, which
> >> + * will be the real initial page table pointed to by the VTTBR.
> >> + *
> >> + * When KVM_PREALLOC_LEVEL==2, we allocate a single page for the PMD and
> >> + * the kernel will use folded pud.  When KVM_PREALLOC_LEVEL==1, we
> >> + * allocate 2 consecutive PUD pages.
> >> + */
> >> +#if defined(CONFIG_ARM64_64K_PAGES) && CONFIG_ARM64_PGTABLE_LEVELS == 3
> >> +#define KVM_PREALLOC_LEVEL     2
> >> +#define PTRS_PER_S2_PGD                1
> >> +#define S2_PGD_ORDER           get_order(PTRS_PER_S2_PGD * sizeof(pgd_t))
> > 
> > I agree that my magic equation wasn't readable ;) (I had troubles
> > re-understanding it as well), but you also have some constants here that
> > are not immediately obvious where you got to them from. IIUC,
> > KVM_PREALLOC_LEVEL == 2 here means that the hardware only understands
> > stage 2 pmd and pte. I guess you could look into the ARM ARM tables but
> > it's still not clear.
> > 
> > Let's look at PTRS_PER_S2_PGD as I think it's simpler. My proposal was:
> > 
> > #if PGDIR_SHIFT > KVM_PHYS_SHIFT
> > #define PTRS_PER_S2_PGD			(1)
> > #else
> > #define PTRS_PER_S2_PGD			(1 << (KVM_PHYS_SHIFT - PGDIR_SHIFT))
> > #endif
> > 
> > In this case PGDIR_SHIFT is 42, so we get PTRS_PER_S2_PGD == 1. The 4K
> > and 4 levels case below is also correct.
> > 
> > The KVM start level calculation, we could assume that KVM needs either
> > host levels or host levels - 1 (unless we go for some weirdly small
> > KVM_PHYS_SHIFT). So we could define them KVM_PREALLOC_LEVEL as:
> > 
> > #if PTRS_PER_S2_PGD <= 16
> > #define KVM_PREALLOC_LEVEL	(4 - CONFIG_ARM64_PGTABLE_LEVELS + 1)
> > #else
> > #define KVM_PREALLOC_LEVEL	(0)
> > #endif
> > 
> > Basically if you can concatenate 16 or less pages at the level below the
> > top, the architecture does not allow a small top level. In this case,
> > (4 - CONFIG_ARM64_PGTABLE_LEVELS) represents the first level for the
> > host and we add 1 to go to the next level for KVM stage 2 when
> > PTRS_PER_S2_PGD is 16 or less. We use 0 when we don't need to
> > preallocate.
> 
> I think this makes the whole thing clearer (at least for me), as it
> makes the relationship between KVM_PREALLOC_LEVEL and
> CONFIG_ARM64_PGTABLE_LEVELS explicit (it wasn't completely obvious to me
> initially).

Agreed.

> 
> >> +static inline int kvm_prealloc_hwpgd(struct kvm *kvm, pgd_t *pgd)
> >> +{
> >> +       pud_t *pud;
> >> +       pmd_t *pmd;
> >> +
> >> +       pud = pud_offset(pgd, 0);
> >> +       pmd = (pmd_t *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, 0);
> >> +
> >> +       if (!pmd)
> >> +               return -ENOMEM;
> >> +       pud_populate(NULL, pud, pmd);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static inline void kvm_free_hwpgd(struct kvm *kvm)
> >> +{
> >> +       pgd_t *pgd = kvm->arch.pgd;
> >> +       pud_t *pud = pud_offset(pgd, 0);
> >> +       pmd_t *pmd = pmd_offset(pud, 0);
> >> +       free_pages((unsigned long)pmd, 0);
> >> +}
> >> +
> >> +static inline phys_addr_t kvm_get_hwpgd(struct kvm *kvm)
> >> +{
> >> +       pgd_t *pgd = kvm->arch.pgd;
> >> +       pud_t *pud = pud_offset(pgd, 0);
> >> +       pmd_t *pmd = pmd_offset(pud, 0);
> >> +       return virt_to_phys(pmd);
> >> +
> >> +}
> >> +#elif defined(CONFIG_ARM64_4K_PAGES) && CONFIG_ARM64_PGTABLE_LEVELS == 4
> >> +#define KVM_PREALLOC_LEVEL     1
> >> +#define PTRS_PER_S2_PGD                2
> >> +#define S2_PGD_ORDER           get_order(PTRS_PER_S2_PGD * sizeof(pgd_t))
> > 
> > Here PGDIR_SHIFT is 39, so we get PTRS_PER_S2_PGD == (1 << (40 - 39))
> > which is 2 and KVM_PREALLOC_LEVEL == 1.
> > 
> >> +static inline int kvm_prealloc_hwpgd(struct kvm *kvm, pgd_t *pgd)
> >> +{
> >> +       pud_t *pud;
> >> +
> >> +       pud = (pud_t *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, 1);
> >> +       if (!pud)
> >> +               return -ENOMEM;
> >> +       pgd_populate(NULL, pgd, pud);
> >> +       pgd_populate(NULL, pgd + 1, pud + PTRS_PER_PUD);
> >> +
> >> +       return 0;
> >> +}
> > 
> > You still need to define these functions but you can make their
> > implementation dependent solely on the KVM_PREALLOC_LEVEL rather than
> > 64K/4K and levels combinations. If it is KVM_PREALLOC_LEVEL is 1, you
> > allocate pud and populate the pgds (in a loop based on the
> > PTRS_PER_S2_PGD). If it is 2, you allocate the pmd and populate the pud
> > (still in a loop though it would probably be 1 iteration). We know based
> > on the assumption above that you can't get KVM_PREALLOC_LEVEL == 2 and
> > CONFIG_ARM64_PGTABLE_LEVELS == 4.
> > 
> 
> Also agreed. Most of what you wrote here could also be gathered as
> comments in the patch.
> 
Yes, I reworded some of the text slightly as comments for the next
version of the patch.

However, I'm not sure I have a clear idea of how you'd like these
functions to look like.

I came up with the following based on your feedback, but I personally
don't find it a lot easier to read than what I had already.  Suggestions
are welcome:

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index a030d16..7941a51 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -41,6 +41,18 @@
  */
 #define TRAMPOLINE_VA		(HYP_PAGE_OFFSET_MASK & PAGE_MASK)
 
+/*
+ * KVM_MMU_CACHE_MIN_PAGES is the number of stage2 page table translation
+ * levels in addition to the PGD and potentially the PUD which are
+ * pre-allocated (we pre-allocate the fake PGD and the PUD when the Stage-2
+ * tables use one level of tables less than the kernel.
+ */
+#ifdef CONFIG_ARM64_64K_PAGES
+#define KVM_MMU_CACHE_MIN_PAGES	1
+#else
+#define KVM_MMU_CACHE_MIN_PAGES	2
+#endif
+
 #ifdef __ASSEMBLY__
 
 /*
@@ -53,6 +65,7 @@
 
 #else
 
+#include <asm/pgalloc.h>
 #include <asm/cachetype.h>
 #include <asm/cacheflush.h>
 
@@ -65,10 +78,6 @@
 #define KVM_PHYS_SIZE	(1UL << KVM_PHYS_SHIFT)
 #define KVM_PHYS_MASK	(KVM_PHYS_SIZE - 1UL)
 
-/* Make sure we get the right size, and thus the right alignment */
-#define PTRS_PER_S2_PGD (1 << (KVM_PHYS_SHIFT - PGDIR_SHIFT))
-#define S2_PGD_ORDER	get_order(PTRS_PER_S2_PGD * sizeof(pgd_t))
-
 int create_hyp_mappings(void *from, void *to);
 int create_hyp_io_mappings(void *from, void *to, phys_addr_t);
 void free_boot_hyp_pgd(void);
@@ -93,6 +102,7 @@ void kvm_clear_hyp_idmap(void);
 #define	kvm_set_pmd(pmdp, pmd)		set_pmd(pmdp, pmd)
 
 static inline void kvm_clean_pgd(pgd_t *pgd) {}
+static inline void kvm_clean_pmd(pmd_t *pmd) {}
 static inline void kvm_clean_pmd_entry(pmd_t *pmd) {}
 static inline void kvm_clean_pte(pte_t *pte) {}
 static inline void kvm_clean_pte_entry(pte_t *pte) {}
@@ -118,13 +128,115 @@ static inline bool kvm_page_empty(void *ptr)
 }
 
 #define kvm_pte_table_empty(ptep) kvm_page_empty(ptep)
-#ifndef CONFIG_ARM64_64K_PAGES
-#define kvm_pmd_table_empty(pmdp) kvm_page_empty(pmdp)
-#else
+
+#ifdef __PAGETABLE_PMD_FOLDED
 #define kvm_pmd_table_empty(pmdp) (0)
+#else
+#define kvm_pmd_table_empty(pmdp) kvm_page_empty(pmdp)
 #endif
+
+#ifdef __PAGETABLE_PUD_FOLDED
 #define kvm_pud_table_empty(pudp) (0)
+#else
+#define kvm_pud_table_empty(pudp) kvm_page_empty(pudp)
+#endif
+
+/*
+ * In the case where PGDIR_SHIFT is larger than KVM_PHYS_SHIFT, we can address
+ * the entire IPA input range with a single pgd entry, and we would only need
+ * one pgd entry.
+ */
+#if PGDIR_SHIFT > KVM_PHYS_SHIFT
+#define PTRS_PER_S2_PGD		(1)
+#else
+#define PTRS_PER_S2_PGD		(1 << (KVM_PHYS_SHIFT - PGDIR_SHIFT))
+#endif
+#define S2_PGD_ORDER		get_order(PTRS_PER_S2_PGD * sizeof(pgd_t))
 
+/*
+ * If we are concatenating first level stage-2 page tables, we would have less
+ * than or equal to 16 pointers in the fake PGD, because that's what the
+ * architecture allows.  In this case, (4 - CONFIG_ARM64_PGTABLE_LEVELS)
+ * represents the first level for the host, and we add 1 to go to the next
+ * level (which uses contatenation) for the stage-2 tables.
+ */
+#if PTRS_PER_S2_PGD <= 16
+#define KVM_PREALLOC_LEVEL	(4 - CONFIG_ARM64_PGTABLE_LEVELS + 1)
+#else
+#define KVM_PREALLOC_LEVEL	(0)
+#endif
+
+/**
+ * kvm_prealloc_hwpgd - allocate inital table for VTTBR
+ * @kvm:	The KVM struct pointer for the VM.
+ * @pgd:	The kernel pseudo pgd
+ *
+ * When the kernel uses more levels of page tables than the guest, we allocate
+ * a fake PGD and pre-populate it to point to the next-level page table, which
+ * will be the real initial page table pointed to by the VTTBR.
+ *
+ * When KVM_PREALLOC_LEVEL==2, we allocate a single page for the PMD and
+ * the kernel will use folded pud.  When KVM_PREALLOC_LEVEL==1, we
+ * allocate 2 consecutive PUD pages.
+ */
+static inline int kvm_prealloc_hwpgd(struct kvm *kvm, pgd_t *pgd)
+{
+	pud_t *pud;
+	pmd_t *pmd;
+	unsigned int order, i;
+	unsigned long hwpgd;
+
+	if (KVM_PREALLOC_LEVEL == 0)
+		return 0;
+
+	order = get_order(PTRS_PER_S2_PGD);
+	hwpgd = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
+	if (!hwpgd)
+		return -ENOMEM;
+
+	if (KVM_PREALLOC_LEVEL == 1) {
+		pud = (pud_t *)hwpgd;
+		for (i = 0; i < PTRS_PER_S2_PGD; i++)
+			pgd_populate(NULL, pgd + i, pud + i * PTRS_PER_PUD);
+	} else if (KVM_PREALLOC_LEVEL == 2) {
+		pud = pud_offset(pgd, 0);
+		pmd = (pmd_t *)hwpgd;
+		for (i = 0; i < PTRS_PER_S2_PGD; i++)
+			pud_populate(NULL, pud + i, pmd + i * PTRS_PER_PMD);
+	}
+
+	return 0;
+}
+
+static inline void *kvm_get_hwpgd(struct kvm *kvm)
+{
+	pgd_t *pgd = kvm->arch.pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	switch (KVM_PREALLOC_LEVEL) {
+	case 0:
+		return pgd;
+	case 1:
+		pud = pud_offset(pgd, 0);
+		return pud;
+	case 2:
+		pud = pud_offset(pgd, 0);
+		pmd = pmd_offset(pud, 0);
+		return pmd;
+	default:
+		BUG();
+		return NULL;
+	}
+}
+
+static inline void kvm_free_hwpgd(struct kvm *kvm)
+{
+	if (KVM_PREALLOC_LEVEL > 0) {
+		unsigned long hwpgd = (unsigned long)kvm_get_hwpgd(kvm);
+		free_pages(hwpgd, get_order(S2_PGD_ORDER));
+	}
+}
 
 struct kvm;
 

Thanks,
-Christoffer
