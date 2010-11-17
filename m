From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Nov 2010 17:29:35 +0000
Subject: [PATCH 4/5] ARM: pgtable: invert L_PTE_EXEC to L_PTE_XN
In-Reply-To: <20101117172717.GF5308@n2100.arm.linux.org.uk>
References: <20101117172717.GF5308@n2100.arm.linux.org.uk>
Message-ID: <E1PIlp9-0007qg-7F@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The hardware page tables use an XN bit 'execute never'.  Historically,
we've had a Linux 'execute allow' bit, in the positive sense.  Get rid
of this artifact as future hardware will continue to have the XN sense.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/pgtable.h |   44 ++++++++++++++++++++--------------------
 arch/arm/mm/mmu.c              |   15 ++++++-------
 arch/arm/mm/proc-macros.S      |    6 ++--
 arch/arm/mm/proc-v7.S          |    4 +-
 4 files changed, 34 insertions(+), 35 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 59e0ea2..a4eda5f 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -172,7 +172,7 @@ extern void __pgd_error(const char *file, int line, pgd_t);
 #define L_PTE_DIRTY		(_AT(pteval_t, 1) << 6)
 #define L_PTE_WRITE		(_AT(pteval_t, 1) << 7)
 #define L_PTE_USER		(_AT(pteval_t, 1) << 8)
-#define L_PTE_EXEC		(_AT(pteval_t, 1) << 9)
+#define L_PTE_XN		(_AT(pteval_t, 1) << 9)
 #define L_PTE_SHARED		(_AT(pteval_t, 1) << 10)	/* shared(v6), coherent(xsc3) */
 
 /*
@@ -206,23 +206,23 @@ extern pgprot_t		pgprot_kernel;
 
 #define _MOD_PROT(p, b)	__pgprot(pgprot_val(p) | (b))
 
-#define PAGE_NONE		pgprot_user
-#define PAGE_SHARED		_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_WRITE)
-#define PAGE_SHARED_EXEC	_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_WRITE | L_PTE_EXEC)
-#define PAGE_COPY		_MOD_PROT(pgprot_user, L_PTE_USER)
-#define PAGE_COPY_EXEC		_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_EXEC)
-#define PAGE_READONLY		_MOD_PROT(pgprot_user, L_PTE_USER)
-#define PAGE_READONLY_EXEC	_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_EXEC)
-#define PAGE_KERNEL		pgprot_kernel
-#define PAGE_KERNEL_EXEC	_MOD_PROT(pgprot_kernel, L_PTE_EXEC)
-
-#define __PAGE_NONE		__pgprot(_L_PTE_DEFAULT)
-#define __PAGE_SHARED		__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_WRITE)
-#define __PAGE_SHARED_EXEC	__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_WRITE | L_PTE_EXEC)
-#define __PAGE_COPY		__pgprot(_L_PTE_DEFAULT | L_PTE_USER)
-#define __PAGE_COPY_EXEC	__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_EXEC)
-#define __PAGE_READONLY		__pgprot(_L_PTE_DEFAULT | L_PTE_USER)
-#define __PAGE_READONLY_EXEC	__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_EXEC)
+#define PAGE_NONE		_MOD_PROT(pgprot_user, L_PTE_XN)
+#define PAGE_SHARED		_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_WRITE | L_PTE_XN)
+#define PAGE_SHARED_EXEC	_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_WRITE)
+#define PAGE_COPY		_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_XN)
+#define PAGE_COPY_EXEC		_MOD_PROT(pgprot_user, L_PTE_USER)
+#define PAGE_READONLY		_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_XN)
+#define PAGE_READONLY_EXEC	_MOD_PROT(pgprot_user, L_PTE_USER)
+#define PAGE_KERNEL		_MOD_PROT(pgprot_kernel, L_PTE_XN)
+#define PAGE_KERNEL_EXEC	pgprot_kernel
+
+#define __PAGE_NONE		__pgprot(_L_PTE_DEFAULT | L_PTE_XN)
+#define __PAGE_SHARED		__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_WRITE | L_PTE_XN)
+#define __PAGE_SHARED_EXEC	__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_WRITE)
+#define __PAGE_COPY		__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_XN)
+#define __PAGE_COPY_EXEC	__pgprot(_L_PTE_DEFAULT | L_PTE_USER)
+#define __PAGE_READONLY		__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_XN)
+#define __PAGE_READONLY_EXEC	__pgprot(_L_PTE_DEFAULT | L_PTE_USER)
 
 #endif /* __ASSEMBLY__ */
 
@@ -308,7 +308,7 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 #define pte_write(pte)		(pte_val(pte) & L_PTE_WRITE)
 #define pte_dirty(pte)		(pte_val(pte) & L_PTE_DIRTY)
 #define pte_young(pte)		(pte_val(pte) & L_PTE_YOUNG)
-#define pte_exec(pte)		(pte_val(pte) & L_PTE_EXEC)
+#define pte_exec(pte)		(!(pte_val(pte) & L_PTE_XN))
 #define pte_special(pte)	(0)
 
 #define pte_present_user(pte) \
@@ -339,14 +339,14 @@ static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
 	__pgprot_modify(prot, L_PTE_MT_MASK, L_PTE_MT_BUFFERABLE)
 #ifdef CONFIG_ARM_DMA_MEM_BUFFERABLE
 #define pgprot_dmacoherent(prot) \
-	__pgprot_modify(prot, L_PTE_MT_MASK|L_PTE_EXEC, L_PTE_MT_BUFFERABLE)
+	__pgprot_modify(prot, L_PTE_MT_MASK, L_PTE_MT_BUFFERABLE|L_PTE_XN)
 #define __HAVE_PHYS_MEM_ACCESS_PROT
 struct file;
 extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 				     unsigned long size, pgprot_t vma_prot);
 #else
 #define pgprot_dmacoherent(prot) \
-	__pgprot_modify(prot, L_PTE_MT_MASK|L_PTE_EXEC, L_PTE_MT_UNCACHED)
+	__pgprot_modify(prot, L_PTE_MT_MASK, L_PTE_MT_UNCACHED|L_PTE_XN)
 #endif
 
 #define pmd_none(pmd)		(!pmd_val(pmd))
@@ -408,7 +408,7 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
-	const unsigned long mask = L_PTE_EXEC | L_PTE_WRITE | L_PTE_USER;
+	const unsigned long mask = L_PTE_XN | L_PTE_WRITE | L_PTE_USER;
 	pte_val(pte) = (pte_val(pte) & ~mask) | (pgprot_val(newprot) & mask);
 	return pte;
 }
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 9963189..a7f56fc 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -190,7 +190,7 @@ void adjust_cr(unsigned long mask, unsigned long set)
 }
 #endif
 
-#define PROT_PTE_DEVICE		L_PTE_PRESENT|L_PTE_YOUNG|L_PTE_DIRTY|L_PTE_WRITE
+#define PROT_PTE_DEVICE		L_PTE_PRESENT|L_PTE_YOUNG|L_PTE_DIRTY|L_PTE_WRITE|L_PTE_XN
 #define PROT_SECT_DEVICE	PMD_TYPE_SECT|PMD_SECT_AP_WRITE
 
 static struct mem_type mem_types[] = {
@@ -234,20 +234,19 @@ static struct mem_type mem_types[] = {
 		.domain    = DOMAIN_KERNEL,
 	},
 	[MT_LOW_VECTORS] = {
-		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
-				L_PTE_EXEC,
+		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY,
 		.prot_l1   = PMD_TYPE_TABLE,
 		.domain    = DOMAIN_USER,
 	},
 	[MT_HIGH_VECTORS] = {
 		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
-				L_PTE_USER | L_PTE_EXEC,
+				L_PTE_USER,
 		.prot_l1   = PMD_TYPE_TABLE,
 		.domain    = DOMAIN_USER,
 	},
 	[MT_MEMORY] = {
 		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
-				L_PTE_WRITE | L_PTE_EXEC,
+				L_PTE_WRITE,
 		.prot_l1   = PMD_TYPE_TABLE,
 		.prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE,
 		.domain    = DOMAIN_KERNEL,
@@ -258,21 +257,21 @@ static struct mem_type mem_types[] = {
 	},
 	[MT_MEMORY_NONCACHED] = {
 		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
-				L_PTE_WRITE | L_PTE_EXEC | L_PTE_MT_BUFFERABLE,
+				L_PTE_WRITE| L_PTE_MT_BUFFERABLE,
 		.prot_l1   = PMD_TYPE_TABLE,
 		.prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE,
 		.domain    = DOMAIN_KERNEL,
 	},
 	[MT_MEMORY_DTCM] = {
 		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
-				L_PTE_WRITE,
+				L_PTE_WRITE | L_PTE_XN,
 		.prot_l1   = PMD_TYPE_TABLE,
 		.prot_sect = PMD_TYPE_SECT | PMD_SECT_XN,
 		.domain    = DOMAIN_KERNEL,
 	},
 	[MT_MEMORY_ITCM] = {
 		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
-				L_PTE_WRITE | L_PTE_EXEC,
+				L_PTE_WRITE,
 		.prot_l1   = PMD_TYPE_TABLE,
 		.domain    = DOMAIN_KERNEL,
 	},
diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index cbedf9c..4a7a9e1 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -81,7 +81,7 @@
 #if L_PTE_SHARED != PTE_EXT_SHARED
 #error PTE shared bit mismatch
 #endif
-#if (L_PTE_EXEC+L_PTE_USER+L_PTE_WRITE+L_PTE_DIRTY+L_PTE_YOUNG+\
+#if (L_PTE_XN+L_PTE_USER+L_PTE_WRITE+L_PTE_DIRTY+L_PTE_YOUNG+\
      L_PTE_FILE+L_PTE_PRESENT) > L_PTE_SHARED
 #error Invalid Linux PTE bit settings
 #endif
@@ -141,8 +141,8 @@
 	tstne	r3, #PTE_EXT_APX
 	bicne	r3, r3, #PTE_EXT_APX | PTE_EXT_AP0
 
-	tst	r1, #L_PTE_EXEC
-	orreq	r3, r3, #PTE_EXT_XN
+	tst	r1, #L_PTE_XN
+	orrne	r3, r3, #PTE_EXT_XN
 
 	orr	r3, r3, r2
 
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 89c31a6..4f5a594 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -149,8 +149,8 @@ ENTRY(cpu_v7_set_pte_ext)
 	tstne	r3, #PTE_EXT_APX
 	bicne	r3, r3, #PTE_EXT_APX | PTE_EXT_AP0
 
-	tst	r1, #L_PTE_EXEC
-	orreq	r3, r3, #PTE_EXT_XN
+	tst	r1, #L_PTE_XN
+	orrne	r3, r3, #PTE_EXT_XN
 
 	tst	r1, #L_PTE_YOUNG
 	tstne	r1, #L_PTE_PRESENT
-- 
1.6.2.5
