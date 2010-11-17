From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Nov 2010 17:29:55 +0000
Subject: [PATCH 5/5] ARM: pgtable: provide RDONLY page table bit rather than
	WRITE bit
In-Reply-To: <20101117172717.GF5308@n2100.arm.linux.org.uk>
References: <20101117172717.GF5308@n2100.arm.linux.org.uk>
Message-ID: <E1PIlpT-0007qk-BD@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/pgtable.h |   38 +++++++++++++++++++-------------------
 arch/arm/mm/mmu.c              |   19 +++++++++----------
 arch/arm/mm/proc-macros.S      |   16 ++++++++--------
 arch/arm/mm/proc-v7.S          |    6 +++---
 arch/arm/mm/proc-xscale.S      |    4 ++--
 5 files changed, 41 insertions(+), 42 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index a4eda5f..77b6634 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -170,7 +170,7 @@ extern void __pgd_error(const char *file, int line, pgd_t);
 #define L_PTE_YOUNG		(_AT(pteval_t, 1) << 1)
 #define L_PTE_FILE		(_AT(pteval_t, 1) << 2)	/* only when !PRESENT */
 #define L_PTE_DIRTY		(_AT(pteval_t, 1) << 6)
-#define L_PTE_WRITE		(_AT(pteval_t, 1) << 7)
+#define L_PTE_RDONLY		(_AT(pteval_t, 1) << 7)
 #define L_PTE_USER		(_AT(pteval_t, 1) << 8)
 #define L_PTE_XN		(_AT(pteval_t, 1) << 9)
 #define L_PTE_SHARED		(_AT(pteval_t, 1) << 10)	/* shared(v6), coherent(xsc3) */
@@ -206,23 +206,23 @@ extern pgprot_t		pgprot_kernel;
 
 #define _MOD_PROT(p, b)	__pgprot(pgprot_val(p) | (b))
 
-#define PAGE_NONE		_MOD_PROT(pgprot_user, L_PTE_XN)
-#define PAGE_SHARED		_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_WRITE | L_PTE_XN)
-#define PAGE_SHARED_EXEC	_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_WRITE)
-#define PAGE_COPY		_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_XN)
-#define PAGE_COPY_EXEC		_MOD_PROT(pgprot_user, L_PTE_USER)
-#define PAGE_READONLY		_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_XN)
-#define PAGE_READONLY_EXEC	_MOD_PROT(pgprot_user, L_PTE_USER)
+#define PAGE_NONE		_MOD_PROT(pgprot_user, L_PTE_XN | L_PTE_RDONLY)
+#define PAGE_SHARED		_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_XN)
+#define PAGE_SHARED_EXEC	_MOD_PROT(pgprot_user, L_PTE_USER)
+#define PAGE_COPY		_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_RDONLY | L_PTE_XN)
+#define PAGE_COPY_EXEC		_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_RDONLY)
+#define PAGE_READONLY		_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_RDONLY | L_PTE_XN)
+#define PAGE_READONLY_EXEC	_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_RDONLY)
 #define PAGE_KERNEL		_MOD_PROT(pgprot_kernel, L_PTE_XN)
 #define PAGE_KERNEL_EXEC	pgprot_kernel
 
-#define __PAGE_NONE		__pgprot(_L_PTE_DEFAULT | L_PTE_XN)
-#define __PAGE_SHARED		__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_WRITE | L_PTE_XN)
-#define __PAGE_SHARED_EXEC	__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_WRITE)
-#define __PAGE_COPY		__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_XN)
-#define __PAGE_COPY_EXEC	__pgprot(_L_PTE_DEFAULT | L_PTE_USER)
-#define __PAGE_READONLY		__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_XN)
-#define __PAGE_READONLY_EXEC	__pgprot(_L_PTE_DEFAULT | L_PTE_USER)
+#define __PAGE_NONE		__pgprot(_L_PTE_DEFAULT | L_PTE_RDONLY | L_PTE_XN)
+#define __PAGE_SHARED		__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_XN)
+#define __PAGE_SHARED_EXEC	__pgprot(_L_PTE_DEFAULT | L_PTE_USER)
+#define __PAGE_COPY		__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_RDONLY | L_PTE_XN)
+#define __PAGE_COPY_EXEC	__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_RDONLY)
+#define __PAGE_READONLY		__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_RDONLY | L_PTE_XN)
+#define __PAGE_READONLY_EXEC	__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_RDONLY)
 
 #endif /* __ASSEMBLY__ */
 
@@ -305,7 +305,7 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
  * Undefined behaviour if not..
  */
 #define pte_present(pte)	(pte_val(pte) & L_PTE_PRESENT)
-#define pte_write(pte)		(pte_val(pte) & L_PTE_WRITE)
+#define pte_write(pte)		(!(pte_val(pte) & L_PTE_RDONLY))
 #define pte_dirty(pte)		(pte_val(pte) & L_PTE_DIRTY)
 #define pte_young(pte)		(pte_val(pte) & L_PTE_YOUNG)
 #define pte_exec(pte)		(!(pte_val(pte) & L_PTE_XN))
@@ -318,8 +318,8 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 #define PTE_BIT_FUNC(fn,op) \
 static inline pte_t pte_##fn(pte_t pte) { pte_val(pte) op; return pte; }
 
-PTE_BIT_FUNC(wrprotect, &= ~L_PTE_WRITE);
-PTE_BIT_FUNC(mkwrite,   |= L_PTE_WRITE);
+PTE_BIT_FUNC(wrprotect, |= L_PTE_RDONLY);
+PTE_BIT_FUNC(mkwrite,   &= ~L_PTE_RDONLY);
 PTE_BIT_FUNC(mkclean,   &= ~L_PTE_DIRTY);
 PTE_BIT_FUNC(mkdirty,   |= L_PTE_DIRTY);
 PTE_BIT_FUNC(mkold,     &= ~L_PTE_YOUNG);
@@ -408,7 +408,7 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
-	const unsigned long mask = L_PTE_XN | L_PTE_WRITE | L_PTE_USER;
+	const unsigned long mask = L_PTE_XN | L_PTE_RDONLY | L_PTE_USER;
 	pte_val(pte) = (pte_val(pte) & ~mask) | (pgprot_val(newprot) & mask);
 	return pte;
 }
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index a7f56fc..3447c1b 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -190,7 +190,7 @@ void adjust_cr(unsigned long mask, unsigned long set)
 }
 #endif
 
-#define PROT_PTE_DEVICE		L_PTE_PRESENT|L_PTE_YOUNG|L_PTE_DIRTY|L_PTE_WRITE|L_PTE_XN
+#define PROT_PTE_DEVICE		L_PTE_PRESENT|L_PTE_YOUNG|L_PTE_DIRTY|L_PTE_XN
 #define PROT_SECT_DEVICE	PMD_TYPE_SECT|PMD_SECT_AP_WRITE
 
 static struct mem_type mem_types[] = {
@@ -234,19 +234,19 @@ static struct mem_type mem_types[] = {
 		.domain    = DOMAIN_KERNEL,
 	},
 	[MT_LOW_VECTORS] = {
-		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY,
+		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
+				L_PTE_RDONLY,
 		.prot_l1   = PMD_TYPE_TABLE,
 		.domain    = DOMAIN_USER,
 	},
 	[MT_HIGH_VECTORS] = {
 		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
-				L_PTE_USER,
+				L_PTE_USER | L_PTE_RDONLY,
 		.prot_l1   = PMD_TYPE_TABLE,
 		.domain    = DOMAIN_USER,
 	},
 	[MT_MEMORY] = {
-		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
-				L_PTE_WRITE,
+		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY,
 		.prot_l1   = PMD_TYPE_TABLE,
 		.prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE,
 		.domain    = DOMAIN_KERNEL,
@@ -257,21 +257,20 @@ static struct mem_type mem_types[] = {
 	},
 	[MT_MEMORY_NONCACHED] = {
 		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
-				L_PTE_WRITE| L_PTE_MT_BUFFERABLE,
+				L_PTE_MT_BUFFERABLE,
 		.prot_l1   = PMD_TYPE_TABLE,
 		.prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE,
 		.domain    = DOMAIN_KERNEL,
 	},
 	[MT_MEMORY_DTCM] = {
 		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
-				L_PTE_WRITE | L_PTE_XN,
+				L_PTE_XN,
 		.prot_l1   = PMD_TYPE_TABLE,
 		.prot_sect = PMD_TYPE_SECT | PMD_SECT_XN,
 		.domain    = DOMAIN_KERNEL,
 	},
 	[MT_MEMORY_ITCM] = {
-		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
-				L_PTE_WRITE,
+		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY,
 		.prot_l1   = PMD_TYPE_TABLE,
 		.domain    = DOMAIN_KERNEL,
 	},
@@ -478,7 +477,7 @@ static void __init build_mem_type_table(void)
 
 	pgprot_user   = __pgprot(L_PTE_PRESENT | L_PTE_YOUNG | user_pgprot);
 	pgprot_kernel = __pgprot(L_PTE_PRESENT | L_PTE_YOUNG |
-				 L_PTE_DIRTY | L_PTE_WRITE | kern_pgprot);
+				 L_PTE_DIRTY | kern_pgprot);
 
 	mem_types[MT_LOW_VECTORS].prot_l1 |= ecc_mask;
 	mem_types[MT_HIGH_VECTORS].prot_l1 |= ecc_mask;
diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index 4a7a9e1..f5ca6aa 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -81,7 +81,7 @@
 #if L_PTE_SHARED != PTE_EXT_SHARED
 #error PTE shared bit mismatch
 #endif
-#if (L_PTE_XN+L_PTE_USER+L_PTE_WRITE+L_PTE_DIRTY+L_PTE_YOUNG+\
+#if (L_PTE_XN+L_PTE_USER+L_PTE_RDONLY+L_PTE_DIRTY+L_PTE_YOUNG+\
      L_PTE_FILE+L_PTE_PRESENT) > L_PTE_SHARED
 #error Invalid Linux PTE bit settings
 #endif
@@ -132,9 +132,9 @@
 	and	r2, r1, #L_PTE_MT_MASK
 	ldr	r2, [ip, r2]
 
-	tst	r1, #L_PTE_WRITE
-	tstne	r1, #L_PTE_DIRTY
-	orreq	r3, r3, #PTE_EXT_APX
+	eor	r1, r1, #L_PTE_DIRTY
+	tst	r1, #L_PTE_DIRTY|L_PTE_RDONLY
+	orrne	r3, r3, #PTE_EXT_APX
 
 	tst	r1, #L_PTE_USER
 	orrne	r3, r3, #PTE_EXT_AP1
@@ -172,7 +172,7 @@
 	.macro	armv3_set_pte_ext wc_disable=1
 	str	r1, [r0], #2048			@ linux version
 
-	eor	r3, r1, #L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_WRITE | L_PTE_DIRTY
+	eor	r3, r1, #L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY
 
 	bic	r2, r1, #PTE_SMALL_AP_MASK	@ keep C, B bits
 	bic	r2, r2, #PTE_TYPE_MASK
@@ -181,7 +181,7 @@
 	tst	r3, #L_PTE_USER			@ user?
 	orrne	r2, r2, #PTE_SMALL_AP_URO_SRW
 
-	tst	r3, #L_PTE_WRITE | L_PTE_DIRTY	@ write and dirty?
+	tst	r3, #L_PTE_RDONLY | L_PTE_DIRTY	@ write and dirty?
 	orreq	r2, r2, #PTE_SMALL_AP_UNO_SRW
 
 	tst	r3, #L_PTE_PRESENT | L_PTE_YOUNG	@ present and young?
@@ -215,7 +215,7 @@
 	.macro	xscale_set_pte_ext_prologue
 	str	r1, [r0]			@ linux version
 
-	eor	r3, r1, #L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_WRITE | L_PTE_DIRTY
+	eor	r3, r1, #L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY
 
 	bic	r2, r1, #PTE_SMALL_AP_MASK	@ keep C, B bits
 	orr	r2, r2, #PTE_TYPE_EXT		@ extended page
@@ -223,7 +223,7 @@
 	tst	r3, #L_PTE_USER			@ user?
 	orrne	r2, r2, #PTE_EXT_AP_URO_SRW	@ yes -> user r/o, system r/w
 
-	tst	r3, #L_PTE_WRITE | L_PTE_DIRTY	@ write and dirty?
+	tst	r3, #L_PTE_RDONLY | L_PTE_DIRTY	@ write and dirty?
 	orreq	r2, r2, #PTE_EXT_AP_UNO_SRW	@ yes -> user n/a, system r/w
 						@ combined with user -> user r/w
 	.endm
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 4f5a594..210d051 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -140,9 +140,9 @@ ENTRY(cpu_v7_set_pte_ext)
 	tst	r1, #1 << 4
 	orrne	r3, r3, #PTE_EXT_TEX(1)
 
-	tst	r1, #L_PTE_WRITE
-	tstne	r1, #L_PTE_DIRTY
-	orreq	r3, r3, #PTE_EXT_APX
+	eor	r1, r1, #L_PTE_DIRTY
+	tst	r1, #L_PTE_RDONLY | L_PTE_DIRTY
+	orrne	r3, r3, #PTE_EXT_APX
 
 	tst	r1, #L_PTE_USER
 	orrne	r3, r3, #PTE_EXT_AP1
diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
index 523408c..5a37c5e 100644
--- a/arch/arm/mm/proc-xscale.S
+++ b/arch/arm/mm/proc-xscale.S
@@ -500,8 +500,8 @@ ENTRY(cpu_xscale_set_pte_ext)
 	@
 	@ Erratum 40: must set memory to write-through for user read-only pages
 	@
-	and	ip, r1, #(L_PTE_MT_MASK | L_PTE_USER | L_PTE_WRITE) & ~(4 << 2)
-	teq	ip, #L_PTE_MT_WRITEBACK | L_PTE_USER
+	and	ip, r1, #(L_PTE_MT_MASK | L_PTE_USER | L_PTE_RDONLY) & ~(4 << 2)
+	teq	ip, #L_PTE_MT_WRITEBACK | L_PTE_USER | L_PTE_RDONLY
 
 	moveq	r1, #L_PTE_MT_WRITETHROUGH
 	and	r1, r1, #L_PTE_MT_MASK
-- 
1.6.2.5
