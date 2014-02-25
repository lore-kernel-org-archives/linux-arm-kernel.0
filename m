From: steve.capper@linaro.org (Steve Capper)
Date: Tue, 25 Feb 2014 11:38:54 +0000
Subject: [PATCH V2 3/3] arm: mm: Switch back to L_PTE_WRITE
In-Reply-To: <1393328334-27285-1-git-send-email-steve.capper@linaro.org>
References: <1393328334-27285-1-git-send-email-steve.capper@linaro.org>
Message-ID: <1393328334-27285-4-git-send-email-steve.capper@linaro.org>
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

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
Changes in V2: L_PTE_SPECIAL preserved, L_PTE_WRITE moved to bit #58
for LPAE, retained the L_PTE_RDONLY definition.

Rebased against 3.14-rc4 (fixed minor merge conflict in mmu.c)
---
 arch/arm/include/asm/pgtable-2level.h |  2 +-
 arch/arm/include/asm/pgtable-3level.h |  1 +
 arch/arm/include/asm/pgtable.h        | 36 +++++++++++++++++------------------
 arch/arm/mm/dump.c                    |  8 ++++----
 arch/arm/mm/mmu.c                     | 25 ++++++++++++------------
 arch/arm/mm/proc-macros.S             | 16 ++++++++--------
 arch/arm/mm/proc-v7-2level.S          |  6 +++---
 arch/arm/mm/proc-v7-3level.S          |  4 +++-
 arch/arm/mm/proc-xscale.S             |  4 ++--
 9 files changed, 53 insertions(+), 49 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index dfff709..ca43b84 100644
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
index 85c60ad..e30c98b 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -86,6 +86,7 @@
 #define L_PTE_DIRTY		(_AT(pteval_t, 1) << 55)	/* unused */
 #define L_PTE_SPECIAL		(_AT(pteval_t, 1) << 56)	/* unused */
 #define L_PTE_NONE		(_AT(pteval_t, 1) << 57)	/* PROT_NONE */
+#define L_PTE_WRITE		(_AT(pteval_t, 1) << 58)
 
 #define PMD_SECT_VALID		(_AT(pmdval_t, 1) << 0)
 #define PMD_SECT_DIRTY		(_AT(pmdval_t, 1) << 55)
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 02ee408..0d24469 100644
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
@@ -216,7 +216,7 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 
 #define pte_none(pte)		(!pte_val(pte))
 #define pte_present(pte)	(!!(pte_val(pte) & L_PTE_PRESENT))
-#define pte_write(pte)		(!(pte_val(pte) & L_PTE_RDONLY))
+#define pte_write(pte)		(!!(pte_val(pte) & L_PTE_WRITE))
 #define pte_dirty(pte)		(!!(pte_val(pte) & L_PTE_DIRTY))
 #define pte_young(pte)		(!!(pte_val(pte) & L_PTE_YOUNG))
 #define pte_exec(pte)		(!(pte_val(pte) & L_PTE_XN))
@@ -248,8 +248,8 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 #define PTE_BIT_FUNC(fn,op) \
 static inline pte_t pte_##fn(pte_t pte) { pte_val(pte) op; return pte; }
 
-PTE_BIT_FUNC(wrprotect, |= L_PTE_RDONLY);
-PTE_BIT_FUNC(mkwrite,   &= ~L_PTE_RDONLY);
+PTE_BIT_FUNC(wrprotect, &= ~L_PTE_WRITE);
+PTE_BIT_FUNC(mkwrite,   |= L_PTE_WRITE);
 PTE_BIT_FUNC(mkclean,   &= ~L_PTE_DIRTY);
 PTE_BIT_FUNC(mkdirty,   |= L_PTE_DIRTY);
 PTE_BIT_FUNC(mkold,     &= ~L_PTE_YOUNG);
@@ -261,7 +261,7 @@ static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
-	const pteval_t mask = L_PTE_XN | L_PTE_RDONLY | L_PTE_USER |
+	const pteval_t mask = L_PTE_XN | L_PTE_WRITE | L_PTE_USER |
 		L_PTE_NONE | L_PTE_VALID;
 	pte_val(pte) = (pte_val(pte) & ~mask) | (pgprot_val(newprot) & mask);
 	return pte;
diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
index 2b3a564..715ca93 100644
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
index a623cb3..03cf9e9 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -231,7 +231,7 @@ __setup("noalign", noalign_setup);
 
 #endif /* ifdef CONFIG_CPU_CP15 / else */
 
-#define PROT_PTE_DEVICE		L_PTE_PRESENT|L_PTE_YOUNG|L_PTE_DIRTY|L_PTE_XN
+#define PROT_PTE_DEVICE		L_PTE_PRESENT|L_PTE_YOUNG|L_PTE_DIRTY|L_PTE_WRITE|L_PTE_XN
 #define PROT_PTE_S2_DEVICE	PROT_PTE_DEVICE
 #define PROT_SECT_DEVICE	PMD_TYPE_SECT|PMD_SECT_AP_WRITE
 
@@ -281,26 +281,26 @@ static struct mem_type mem_types[] = {
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
@@ -311,26 +311,27 @@ static struct mem_type mem_types[] = {
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
@@ -338,7 +339,7 @@ static struct mem_type mem_types[] = {
 	},
 	[MT_MEMORY_DMA_READY] = {
 		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
-				L_PTE_XN,
+				L_PTE_WRITE | L_PTE_XN,
 		.prot_l1   = PMD_TYPE_TABLE,
 		.domain    = DOMAIN_KERNEL,
 	},
@@ -593,7 +594,7 @@ static void __init build_mem_type_table(void)
 
 	pgprot_user   = __pgprot(L_PTE_PRESENT | L_PTE_YOUNG | user_pgprot);
 	pgprot_kernel = __pgprot(L_PTE_PRESENT | L_PTE_YOUNG |
-				 L_PTE_DIRTY | kern_pgprot);
+				 L_PTE_DIRTY | L_PTE_WRITE | kern_pgprot);
 	pgprot_s2  = __pgprot(L_PTE_PRESENT | L_PTE_YOUNG | s2_pgprot);
 	pgprot_s2_device  = __pgprot(s2_device_pgprot);
 	pgprot_hyp_device  = __pgprot(hyp_device_pgprot);
diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index e3c48a3..c62fd89 100644
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
@@ -152,9 +152,9 @@
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
@@ -199,7 +199,7 @@
 	.macro	armv3_set_pte_ext wc_disable=1
 	str	r1, [r0], #2048			@ linux version
 
-	eor	r3, r1, #L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY
+	eor	r3, r1, #L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_WRITE | L_PTE_DIRTY
 
 	bic	r2, r1, #PTE_SMALL_AP_MASK	@ keep C, B bits
 	bic	r2, r2, #PTE_TYPE_MASK
@@ -208,7 +208,7 @@
 	tst	r3, #L_PTE_USER			@ user?
 	orrne	r2, r2, #PTE_SMALL_AP_URO_SRW
 
-	tst	r3, #L_PTE_RDONLY | L_PTE_DIRTY	@ write and dirty?
+	tst	r3, #L_PTE_WRITE | L_PTE_DIRTY	@ write and dirty?
 	orreq	r2, r2, #PTE_SMALL_AP_UNO_SRW
 
 	tst	r3, #L_PTE_PRESENT | L_PTE_YOUNG	@ present and young?
@@ -242,7 +242,7 @@
 	.macro	xscale_set_pte_ext_prologue
 	str	r1, [r0]			@ linux version
 
-	eor	r3, r1, #L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY
+	eor	r3, r1, #L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_WRITE | L_PTE_DIRTY
 
 	bic	r2, r1, #PTE_SMALL_AP_MASK	@ keep C, B bits
 	orr	r2, r2, #PTE_TYPE_EXT		@ extended page
@@ -250,7 +250,7 @@
 	tst	r3, #L_PTE_USER			@ user?
 	orrne	r2, r2, #PTE_EXT_AP_URO_SRW	@ yes -> user r/o, system r/w
 
-	tst	r3, #L_PTE_RDONLY | L_PTE_DIRTY	@ write and dirty?
+	tst	r3, #L_PTE_WRITE | L_PTE_DIRTY	@ write and dirty?
 	orreq	r2, r2, #PTE_EXT_AP_UNO_SRW	@ yes -> user n/a, system r/w
 						@ combined with user -> user r/w
 	.endm
diff --git a/arch/arm/mm/proc-v7-2level.S b/arch/arm/mm/proc-v7-2level.S
index bdd3be4..297fccf 100644
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
index 01a719e..7726edd 100644
--- a/arch/arm/mm/proc-v7-3level.S
+++ b/arch/arm/mm/proc-v7-3level.S
@@ -78,7 +78,9 @@ ENTRY(cpu_v7_set_pte_ext)
 	tst	r3, #1 << (57 - 32)		@ L_PTE_NONE
 	bicne	r2, #L_PTE_VALID
 	bne	1f
-	tst	r3, #1 << (55 - 32)		@ L_PTE_DIRTY
+	bic	r2, #L_PTE_RDONLY
+	tst	r3, #1 << (58 - 32)		@ L_PTE_WRITE
+	tstne	r3, #1 << (55 - 32)		@ L_PTE_DIRTY
 	orreq	r2, #L_PTE_RDONLY
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
