From: steve.capper@linaro.org (Steve Capper)
Date: Mon, 16 Jun 2014 15:32:39 +0100
Subject: [PATCH V4 2/2] arm: mm: Switch back to L_PTE_WRITE
In-Reply-To: <1402929159-11028-1-git-send-email-steve.capper@linaro.org>
References: <1402929159-11028-1-git-send-email-steve.capper@linaro.org>
Message-ID: <1402929159-11028-3-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For LPAE, we have the following means for encoding writable or dirty
ptes:
                              L_PTE_DIRTY       L_PTE_RDONLY
    !pte_dirty && !pte_write        0               1
    !pte_dirty && pte_write         0               1
    pte_dirty && !pte_write         1               1
    pte_dirty && pte_write          1               0

So we can't distinguish between writable clean ptes and read only
ptes. This can cause problems with ptes being incorrectly flagged as
read only when they are writable but not dirty.

This patch re-introduces the L_PTE_WRITE bit for both short descriptors
and long descriptors, by reverting
  36bb94b ARM: pgtable: provide RDONLY page table bit rather than WRITE bit

For short descriptors the L_PTE_RDONLY bit is renamed to L_PTE_WRITE
and the pertinent logic changed. For long descriptors, L_PTE_WRITE is
implemented as a new software bit.

HugeTLB pages will use the L_PTE_WRITE semantics automatically.

We need to add some logic to Transparent HugePages to ensure that they
correctly interpret the revised pgprot permissions.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm/include/asm/pgtable-2level.h |  2 +-
 arch/arm/include/asm/pgtable-3level.h | 16 ++++++++++++----
 arch/arm/include/asm/pgtable.h        | 36 +++++++++++++++++------------------
 arch/arm/mm/dump.c                    |  8 ++++----
 arch/arm/mm/mmu.c                     | 25 ++++++++++++------------
 arch/arm/mm/proc-macros.S             | 16 ++++++++--------
 arch/arm/mm/proc-v7-2level.S          |  6 +++---
 arch/arm/mm/proc-v7-3level.S          |  4 +++-
 arch/arm/mm/proc-xscale.S             |  4 ++--
 9 files changed, 64 insertions(+), 53 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index 219ac88..e2eec86 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -120,7 +120,7 @@
 #define L_PTE_YOUNG		(_AT(pteval_t, 1) << 1)
 #define L_PTE_FILE		(_AT(pteval_t, 1) << 2)	/* only when !PRESENT */
 #define L_PTE_DIRTY		(_AT(pteval_t, 1) << 6)
-#define L_PTE_RDONLY		(_AT(pteval_t, 1) << 7)
+#define L_PTE_WRITE		(_AT(pteval_t, 1) << 7)
 #define L_PTE_USER		(_AT(pteval_t, 1) << 8)
 #define L_PTE_XN		(_AT(pteval_t, 1) << 9)
 #define L_PTE_SHARED		(_AT(pteval_t, 1) << 10)	/* shared(v6), coherent(xsc3) */
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index bde49f9..9a6c8ec 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -86,11 +86,13 @@
 #define L_PTE_DIRTY		(_AT(pteval_t, 1) << 55)	/* unused */
 #define L_PTE_SPECIAL		(_AT(pteval_t, 1) << 56)	/* unused */
 #define L_PTE_NONE		(_AT(pteval_t, 1) << 57)	/* PROT_NONE */
+#define L_PTE_WRITE		(_AT(pteval_t, 1) << 58)
 
 #define PMD_SECT_VALID		(_AT(pmdval_t, 1) << 0)
 #define PMD_SECT_DIRTY		(_AT(pmdval_t, 1) << 55)
 #define PMD_SECT_SPLITTING	(_AT(pmdval_t, 1) << 56)
 #define PMD_SECT_NONE		(_AT(pmdval_t, 1) << 57)
+#define PMD_SECT_WRITE		(_AT(pmdval_t, 1) << 58)
 
 /*
  * To be used in assembly code with the upper page attributes.
@@ -212,9 +214,10 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 #define pmd_isclear(pmd, val)	(!(pmd_val(pmd) & (val)))
 
 #define pmd_young(pmd)		(pmd_isset((pmd), PMD_SECT_AF))
+#define pmd_dirty(pmd)		(pmd_isset((pmd), PMD_SECT_DIRTY))
 
 #define __HAVE_ARCH_PMD_WRITE
-#define pmd_write(pmd)		(pmd_isclear((pmd), PMD_SECT_RDONLY))
+#define pmd_write(pmd)		(pmd_isset((pmd), PMD_SECT_WRITE))
 
 #define pmd_hugewillfault(pmd)	(!pmd_young(pmd) || !pmd_write(pmd))
 #define pmd_thp_or_huge(pmd)	(pmd_huge(pmd) || pmd_trans_huge(pmd))
@@ -227,10 +230,10 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 #define PMD_BIT_FUNC(fn,op) \
 static inline pmd_t pmd_##fn(pmd_t pmd) { pmd_val(pmd) op; return pmd; }
 
-PMD_BIT_FUNC(wrprotect,	|= PMD_SECT_RDONLY);
+PMD_BIT_FUNC(wrprotect,	&= ~PMD_SECT_WRITE);
 PMD_BIT_FUNC(mkold,	&= ~PMD_SECT_AF);
 PMD_BIT_FUNC(mksplitting, |= PMD_SECT_SPLITTING);
-PMD_BIT_FUNC(mkwrite,   &= ~PMD_SECT_RDONLY);
+PMD_BIT_FUNC(mkwrite,   |= PMD_SECT_WRITE);
 PMD_BIT_FUNC(mkdirty,   |= PMD_SECT_DIRTY);
 PMD_BIT_FUNC(mkyoung,   |= PMD_SECT_AF);
 
@@ -245,7 +248,7 @@ PMD_BIT_FUNC(mkyoung,   |= PMD_SECT_AF);
 
 static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 {
-	const pmdval_t mask = PMD_SECT_USER | PMD_SECT_XN | PMD_SECT_RDONLY |
+	const pmdval_t mask = PMD_SECT_USER | PMD_SECT_XN | PMD_SECT_WRITE |
 				PMD_SECT_VALID | PMD_SECT_NONE;
 	pmd_val(pmd) = (pmd_val(pmd) & ~mask) | (pgprot_val(newprot) & mask);
 	return pmd;
@@ -260,6 +263,11 @@ static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 	if (pmd_val(pmd) & PMD_SECT_NONE)
 		pmd_val(pmd) &= ~PMD_SECT_VALID;
 
+	if (pmd_write(pmd) && pmd_dirty(pmd))
+		pmd_val(pmd) &= ~PMD_SECT_RDONLY;
+	else
+		pmd_val(pmd) |= PMD_SECT_RDONLY;
+
 	*pmdp = __pmd(pmd_val(pmd) | PMD_SECT_nG);
 	flush_pmd_entry(pmdp);
 }
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 01baef0..8c4a941 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -88,13 +88,13 @@ extern pgprot_t		pgprot_s2_device;
 
 #define _MOD_PROT(p, b)	__pgprot(pgprot_val(p) | (b))
 
-#define PAGE_NONE		_MOD_PROT(pgprot_user, L_PTE_XN | L_PTE_RDONLY | L_PTE_NONE)
-#define PAGE_SHARED		_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_XN)
-#define PAGE_SHARED_EXEC	_MOD_PROT(pgprot_user, L_PTE_USER)
-#define PAGE_COPY		_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_RDONLY | L_PTE_XN)
-#define PAGE_COPY_EXEC		_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_RDONLY)
-#define PAGE_READONLY		_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_RDONLY | L_PTE_XN)
-#define PAGE_READONLY_EXEC	_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_RDONLY)
+#define PAGE_NONE		_MOD_PROT(pgprot_user, L_PTE_XN | L_PTE_NONE)
+#define PAGE_SHARED		_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_WRITE | L_PTE_XN)
+#define PAGE_SHARED_EXEC	_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_WRITE)
+#define PAGE_COPY		_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_XN)
+#define PAGE_COPY_EXEC		_MOD_PROT(pgprot_user, L_PTE_USER)
+#define PAGE_READONLY		_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_XN)
+#define PAGE_READONLY_EXEC	_MOD_PROT(pgprot_user, L_PTE_USER)
 #define PAGE_KERNEL		_MOD_PROT(pgprot_kernel, L_PTE_XN)
 #define PAGE_KERNEL_EXEC	pgprot_kernel
 #define PAGE_HYP		_MOD_PROT(pgprot_kernel, L_PTE_HYP)
@@ -102,13 +102,13 @@ extern pgprot_t		pgprot_s2_device;
 #define PAGE_S2			_MOD_PROT(pgprot_s2, L_PTE_S2_RDONLY)
 #define PAGE_S2_DEVICE		_MOD_PROT(pgprot_s2_device, L_PTE_S2_RDWR)
 
-#define __PAGE_NONE		__pgprot(_L_PTE_DEFAULT | L_PTE_RDONLY | L_PTE_XN | L_PTE_NONE)
-#define __PAGE_SHARED		__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_XN)
-#define __PAGE_SHARED_EXEC	__pgprot(_L_PTE_DEFAULT | L_PTE_USER)
-#define __PAGE_COPY		__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_RDONLY | L_PTE_XN)
-#define __PAGE_COPY_EXEC	__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_RDONLY)
-#define __PAGE_READONLY		__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_RDONLY | L_PTE_XN)
-#define __PAGE_READONLY_EXEC	__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_RDONLY)
+#define __PAGE_NONE		__pgprot(_L_PTE_DEFAULT | L_PTE_XN | L_PTE_NONE)
+#define __PAGE_SHARED		__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_WRITE | L_PTE_XN)
+#define __PAGE_SHARED_EXEC	__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_WRITE)
+#define __PAGE_COPY		__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_XN)
+#define __PAGE_COPY_EXEC	__pgprot(_L_PTE_DEFAULT | L_PTE_USER)
+#define __PAGE_READONLY		__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_XN)
+#define __PAGE_READONLY_EXEC	__pgprot(_L_PTE_DEFAULT | L_PTE_USER)
 
 #define __pgprot_modify(prot,mask,bits)		\
 	__pgprot((pgprot_val(prot) & ~(mask)) | (bits))
@@ -222,7 +222,7 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 #define pte_present(pte)	(pte_isset((pte), L_PTE_PRESENT))
 #define pte_valid(pte)		(pte_isset((pte), L_PTE_VALID))
 #define pte_accessible(mm, pte)	(mm_tlb_flush_pending(mm) ? pte_present(pte) : pte_valid(pte))
-#define pte_write(pte)		(pte_isclear((pte), L_PTE_RDONLY))
+#define pte_write(pte)		(pte_isset((pte), L_PTE_WRITE))
 #define pte_dirty(pte)		(pte_isset((pte), L_PTE_DIRTY))
 #define pte_young(pte)		(pte_isset((pte), L_PTE_YOUNG))
 #define pte_exec(pte)		(pte_isclear((pte), L_PTE_XN))
@@ -255,8 +255,8 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 #define PTE_BIT_FUNC(fn,op) \
 static inline pte_t pte_##fn(pte_t pte) { pte_val(pte) op; return pte; }
 
-PTE_BIT_FUNC(wrprotect, |= L_PTE_RDONLY);
-PTE_BIT_FUNC(mkwrite,   &= ~L_PTE_RDONLY);
+PTE_BIT_FUNC(wrprotect, &= ~L_PTE_WRITE);
+PTE_BIT_FUNC(mkwrite,   |= L_PTE_WRITE);
 PTE_BIT_FUNC(mkclean,   &= ~L_PTE_DIRTY);
 PTE_BIT_FUNC(mkdirty,   |= L_PTE_DIRTY);
 PTE_BIT_FUNC(mkold,     &= ~L_PTE_YOUNG);
@@ -268,7 +268,7 @@ static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
-	const pteval_t mask = L_PTE_XN | L_PTE_RDONLY | L_PTE_USER |
+	const pteval_t mask = L_PTE_XN | L_PTE_WRITE | L_PTE_USER |
 		L_PTE_NONE | L_PTE_VALID;
 	pte_val(pte) = (pte_val(pte) & ~mask) | (pgprot_val(newprot) & mask);
 	return pte;
diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
index c508f41..4d79c02 100644
--- a/arch/arm/mm/dump.c
+++ b/arch/arm/mm/dump.c
@@ -58,10 +58,10 @@ static const struct prot_bits pte_bits[] = {
 		.set	= "USR",
 		.clear	= "   ",
 	}, {
-		.mask	= L_PTE_RDONLY,
-		.val	= L_PTE_RDONLY,
-		.set	= "ro",
-		.clear	= "RW",
+		.mask	= L_PTE_WRITE,
+		.val	= L_PTE_WRITE,
+		.set	= "RW",
+		.clear	= "ro",
 	}, {
 		.mask	= L_PTE_XN,
 		.val	= L_PTE_XN,
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index ab14b79..4952ca68 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -235,7 +235,7 @@ __setup("noalign", noalign_setup);
 
 #endif /* ifdef CONFIG_CPU_CP15 / else */
 
-#define PROT_PTE_DEVICE		L_PTE_PRESENT|L_PTE_YOUNG|L_PTE_DIRTY|L_PTE_XN
+#define PROT_PTE_DEVICE		L_PTE_PRESENT|L_PTE_YOUNG|L_PTE_DIRTY|L_PTE_WRITE|L_PTE_XN
 #define PROT_PTE_S2_DEVICE	PROT_PTE_DEVICE
 #define PROT_SECT_DEVICE	PMD_TYPE_SECT|PMD_SECT_AP_WRITE
 
@@ -285,26 +285,26 @@ static struct mem_type mem_types[] = {
 	},
 #endif
 	[MT_LOW_VECTORS] = {
-		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
-				L_PTE_RDONLY,
+		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY,
 		.prot_l1   = PMD_TYPE_TABLE,
 		.domain    = DOMAIN_USER,
 	},
 	[MT_HIGH_VECTORS] = {
 		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
-				L_PTE_USER | L_PTE_RDONLY,
+				L_PTE_USER,
 		.prot_l1   = PMD_TYPE_TABLE,
 		.domain    = DOMAIN_USER,
 	},
 	[MT_MEMORY_RWX] = {
-		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY,
+		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
+				L_PTE_WRITE,
 		.prot_l1   = PMD_TYPE_TABLE,
 		.prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE,
 		.domain    = DOMAIN_KERNEL,
 	},
 	[MT_MEMORY_RW] = {
 		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
-			     L_PTE_XN,
+				L_PTE_WRITE | L_PTE_XN,
 		.prot_l1   = PMD_TYPE_TABLE,
 		.prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE,
 		.domain    = DOMAIN_KERNEL,
@@ -315,26 +315,27 @@ static struct mem_type mem_types[] = {
 	},
 	[MT_MEMORY_RWX_NONCACHED] = {
 		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
-				L_PTE_MT_BUFFERABLE,
+				L_PTE_WRITE | L_PTE_MT_BUFFERABLE,
 		.prot_l1   = PMD_TYPE_TABLE,
 		.prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE,
 		.domain    = DOMAIN_KERNEL,
 	},
 	[MT_MEMORY_RW_DTCM] = {
 		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
-				L_PTE_XN,
+				L_PTE_WRITE | L_PTE_XN,
 		.prot_l1   = PMD_TYPE_TABLE,
 		.prot_sect = PMD_TYPE_SECT | PMD_SECT_XN,
 		.domain    = DOMAIN_KERNEL,
 	},
 	[MT_MEMORY_RWX_ITCM] = {
-		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY,
+		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
+				L_PTE_WRITE,
 		.prot_l1   = PMD_TYPE_TABLE,
 		.domain    = DOMAIN_KERNEL,
 	},
 	[MT_MEMORY_RW_SO] = {
 		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
-				L_PTE_MT_UNCACHED | L_PTE_XN,
+				L_PTE_MT_UNCACHED | L_PTE_WRITE | L_PTE_XN,
 		.prot_l1   = PMD_TYPE_TABLE,
 		.prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_S |
 				PMD_SECT_UNCACHED | PMD_SECT_XN,
@@ -342,7 +343,7 @@ static struct mem_type mem_types[] = {
 	},
 	[MT_MEMORY_DMA_READY] = {
 		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
-				L_PTE_XN,
+				L_PTE_WRITE | L_PTE_XN,
 		.prot_l1   = PMD_TYPE_TABLE,
 		.domain    = DOMAIN_KERNEL,
 	},
@@ -617,7 +618,7 @@ static void __init build_mem_type_table(void)
 
 	pgprot_user   = __pgprot(L_PTE_PRESENT | L_PTE_YOUNG | user_pgprot);
 	pgprot_kernel = __pgprot(L_PTE_PRESENT | L_PTE_YOUNG |
-				 L_PTE_DIRTY | kern_pgprot);
+				 L_PTE_DIRTY | L_PTE_WRITE | kern_pgprot);
 	pgprot_s2  = __pgprot(L_PTE_PRESENT | L_PTE_YOUNG | s2_pgprot);
 	pgprot_s2_device  = __pgprot(s2_device_pgprot);
 	pgprot_hyp_device  = __pgprot(hyp_device_pgprot);
diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index ee1d805..2da9a62 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -97,7 +97,7 @@
 #error PTE shared bit mismatch
 #endif
 #if !defined (CONFIG_ARM_LPAE) && \
-	(L_PTE_XN+L_PTE_USER+L_PTE_RDONLY+L_PTE_DIRTY+L_PTE_YOUNG+\
+	(L_PTE_XN+L_PTE_USER+L_PTE_WRITE+L_PTE_DIRTY+L_PTE_YOUNG+\
 	 L_PTE_FILE+L_PTE_PRESENT) > L_PTE_SHARED
 #error Invalid Linux PTE bit settings
 #endif
@@ -148,9 +148,9 @@
 	and	r2, r1, #L_PTE_MT_MASK
 	ldr	r2, [ip, r2]
 
-	eor	r1, r1, #L_PTE_DIRTY
-	tst	r1, #L_PTE_DIRTY|L_PTE_RDONLY
-	orrne	r3, r3, #PTE_EXT_APX
+	tst	r1, #L_PTE_WRITE
+	tstne	r1, #L_PTE_DIRTY
+	orreq	r3, r3, #PTE_EXT_APX
 
 	tst	r1, #L_PTE_USER
 	orrne	r3, r3, #PTE_EXT_AP1
@@ -192,7 +192,7 @@
 	.macro	armv3_set_pte_ext wc_disable=1
 	str	r1, [r0], #2048			@ linux version
 
-	eor	r3, r1, #L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY
+	eor	r3, r1, #L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_WRITE | L_PTE_DIRTY
 
 	bic	r2, r1, #PTE_SMALL_AP_MASK	@ keep C, B bits
 	bic	r2, r2, #PTE_TYPE_MASK
@@ -201,7 +201,7 @@
 	tst	r3, #L_PTE_USER			@ user?
 	orrne	r2, r2, #PTE_SMALL_AP_URO_SRW
 
-	tst	r3, #L_PTE_RDONLY | L_PTE_DIRTY	@ write and dirty?
+	tst	r3, #L_PTE_WRITE | L_PTE_DIRTY	@ write and dirty?
 	orreq	r2, r2, #PTE_SMALL_AP_UNO_SRW
 
 	tst	r3, #L_PTE_PRESENT | L_PTE_YOUNG	@ present and young?
@@ -235,7 +235,7 @@
 	.macro	xscale_set_pte_ext_prologue
 	str	r1, [r0]			@ linux version
 
-	eor	r3, r1, #L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY
+	eor	r3, r1, #L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_WRITE | L_PTE_DIRTY
 
 	bic	r2, r1, #PTE_SMALL_AP_MASK	@ keep C, B bits
 	orr	r2, r2, #PTE_TYPE_EXT		@ extended page
@@ -243,7 +243,7 @@
 	tst	r3, #L_PTE_USER			@ user?
 	orrne	r2, r2, #PTE_EXT_AP_URO_SRW	@ yes -> user r/o, system r/w
 
-	tst	r3, #L_PTE_RDONLY | L_PTE_DIRTY	@ write and dirty?
+	tst	r3, #L_PTE_WRITE | L_PTE_DIRTY	@ write and dirty?
 	orreq	r2, r2, #PTE_EXT_AP_UNO_SRW	@ yes -> user n/a, system r/w
 						@ combined with user -> user r/w
 	.endm
diff --git a/arch/arm/mm/proc-v7-2level.S b/arch/arm/mm/proc-v7-2level.S
index 1f52915..a9dad38 100644
--- a/arch/arm/mm/proc-v7-2level.S
+++ b/arch/arm/mm/proc-v7-2level.S
@@ -84,9 +84,9 @@ ENTRY(cpu_v7_set_pte_ext)
 	tst	r1, #1 << 4
 	orrne	r3, r3, #PTE_EXT_TEX(1)
 
-	eor	r1, r1, #L_PTE_DIRTY
-	tst	r1, #L_PTE_RDONLY | L_PTE_DIRTY
-	orrne	r3, r3, #PTE_EXT_APX
+	tst	r1, #L_PTE_WRITE
+	tstne	r1, #L_PTE_DIRTY
+	orreq	r3, r3, #PTE_EXT_APX
 
 	tst	r1, #L_PTE_USER
 	orrne	r3, r3, #PTE_EXT_AP1
diff --git a/arch/arm/mm/proc-v7-3level.S b/arch/arm/mm/proc-v7-3level.S
index 22e3ad6..a459f62 100644
--- a/arch/arm/mm/proc-v7-3level.S
+++ b/arch/arm/mm/proc-v7-3level.S
@@ -86,7 +86,9 @@ ENTRY(cpu_v7_set_pte_ext)
 	tst	rh, #1 << (57 - 32)		@ L_PTE_NONE
 	bicne	rl, #L_PTE_VALID
 	bne	1f
-	tst	rh, #1 << (55 - 32)		@ L_PTE_DIRTY
+	bic	rl, #L_PTE_RDONLY
+	tst	rh, #1 << (58 - 32)		@ L_PTE_WRITE
+	tstne	rh, #1 << (55 - 32)		@ L_PTE_DIRTY
 	orreq	rl, #L_PTE_RDONLY
 1:	strd	r2, r3, [r0]
 	ALT_SMP(W(nop))
diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
index d19b1cf..d5b23e8 100644
--- a/arch/arm/mm/proc-xscale.S
+++ b/arch/arm/mm/proc-xscale.S
@@ -510,8 +510,8 @@ ENTRY(cpu_xscale_set_pte_ext)
 	@
 	@ Erratum 40: must set memory to write-through for user read-only pages
 	@
-	and	ip, r1, #(L_PTE_MT_MASK | L_PTE_USER | L_PTE_RDONLY) & ~(4 << 2)
-	teq	ip, #L_PTE_MT_WRITEBACK | L_PTE_USER | L_PTE_RDONLY
+	and	ip, r1, #(L_PTE_MT_MASK | L_PTE_USER | L_PTE_WRITE) & ~(4 << 2)
+	teq	ip, #L_PTE_MT_WRITEBACK | L_PTE_USER
 
 	moveq	r1, #L_PTE_MT_WRITETHROUGH
 	and	r1, r1, #L_PTE_MT_MASK
-- 
1.8.1.4
