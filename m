From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 07 Dec 2009 14:14:10 +0000
Subject: [PATCH 5/6] ARMv7: Improved page table format with TRE and AFE
In-Reply-To: <20091207135603.30429.74812.stgit@pc1117.cambridge.arm.com>
References: <20091207135603.30429.74812.stgit@pc1117.cambridge.arm.com>
Message-ID: <20091207141404.30429.85379.stgit@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the Access Flag in SCTLR and, together with the TEX
remapping, allows the use of the spare bits in the page table entry thus
removing the Linux specific PTEs. The simplified permission model is
used which means that "kernel read/write, user read-only" is no longer
available. This was used for the vectors page but with a dedicated TLS
register it is no longer necessary.

With this feature, the following bits were changed to overlap with the
hardware bits:

L_PTE_NOEXEC	-> XN
L_PTE_PRESENT	-> bit 1
L_PTE_YOUNG	-> AP[0] (access flag)
L_PTE_USER	-> AP[1] (simplified permission model)
L_PTE_NOWRITE	-> AP[2] (simplified permission model)
L_PTE_DIRTY	-> TEX[1] (spare bit)

The TEX[2] spare bit is available for future use.

Since !L_PTE_PRESENT requires bit 0 to be unset (otherwise it is a Large
Page Table entry), L_PTE_FILE occupies bit 2. This requires some changes
to the __swp_* and pte_to_pgoff/pgoff_to_pte macros to avoid overriding
this bit. PTE_FILE_MAXBITS becomes 29 if AFE is enabled.

There are no changes required to the PMD_SECT_* macros because the
current usage is compatible with the simplified permission model.

If hardware management of the access flag is available and SCTLR.HA is
set, the L_PTE_YOUNG bit is automatically set when a page is
accessed. With software management of the access flag, an "access flag"
fault is generated which is handled by the do_page_fault() function.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/memory.h  |    6 ++
 arch/arm/include/asm/page.h    |    8 +++
 arch/arm/include/asm/pgalloc.h |   10 ++-
 arch/arm/include/asm/pgtable.h |  117 +++++++++++++++++++++++++++++++++++-----
 arch/arm/mm/Kconfig            |   12 ++++
 arch/arm/mm/dma-mapping.c      |    6 ++
 arch/arm/mm/fault.c            |   10 +++
 arch/arm/mm/mmu.c              |    7 +-
 arch/arm/mm/proc-v7.S          |   56 ++++++++-----------
 9 files changed, 177 insertions(+), 55 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index bc2ff8b..d57040a 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -113,11 +113,15 @@
 #endif /* !CONFIG_MMU */
 
 /*
- * Size of DMA-consistent memory region.  Must be multiple of 2M,
+ * Size of DMA-consistent memory region.  Must be multiple of 2M (4MB if AFE),
  * between 2MB and 14MB inclusive.
  */
 #ifndef CONSISTENT_DMA_SIZE
+#ifndef CONFIG_CPU_AFE
 #define CONSISTENT_DMA_SIZE SZ_2M
+#else
+#define CONSISTENT_DMA_SIZE SZ_4M
+#endif
 #endif
 
 /*
diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
index 3a32af4..224159d 100644
--- a/arch/arm/include/asm/page.h
+++ b/arch/arm/include/asm/page.h
@@ -158,7 +158,11 @@ extern void copy_page(void *to, const void *from);
  */
 typedef struct { unsigned long pte; } pte_t;
 typedef struct { unsigned long pmd; } pmd_t;
+#ifndef CONFIG_CPU_AFE
 typedef struct { unsigned long pgd[2]; } pgd_t;
+#else
+typedef struct { unsigned long pgd[4]; } pgd_t;
+#endif
 typedef struct { unsigned long pgprot; } pgprot_t;
 
 #define pte_val(x)      ((x).pte)
@@ -176,7 +180,11 @@ typedef struct { unsigned long pgprot; } pgprot_t;
  */
 typedef unsigned long pte_t;
 typedef unsigned long pmd_t;
+#ifndef CONFIG_CPU_AFE
 typedef unsigned long pgd_t[2];
+#else
+typedef unsigned long pgd_t[4];
+#endif
 typedef unsigned long pgprot_t;
 
 #define pte_val(x)      (x)
diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
index b12cc98..57083dd 100644
--- a/arch/arm/include/asm/pgalloc.h
+++ b/arch/arm/include/asm/pgalloc.h
@@ -62,7 +62,7 @@ pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr)
 	pte = (pte_t *)__get_free_page(PGALLOC_GFP);
 	if (pte) {
 		clean_dcache_area(pte, sizeof(pte_t) * PTRS_PER_PTE);
-		pte += PTRS_PER_PTE;
+		pte += LINUX_PTE_OFFSET;
 	}
 
 	return pte;
@@ -95,7 +95,7 @@ pte_alloc_one(struct mm_struct *mm, unsigned long addr)
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
 	if (pte) {
-		pte -= PTRS_PER_PTE;
+		pte -= LINUX_PTE_OFFSET;
 		free_page((unsigned long)pte);
 	}
 }
@@ -110,6 +110,10 @@ static inline void __pmd_populate(pmd_t *pmdp, unsigned long pmdval)
 {
 	pmdp[0] = __pmd(pmdval);
 	pmdp[1] = __pmd(pmdval + 256 * sizeof(pte_t));
+#ifdef CONFIG_CPU_AFE
+	pmdp[2] = __pmd(pmdval + 512 * sizeof(pte_t));
+	pmdp[3] = __pmd(pmdval + 768 * sizeof(pte_t));
+#endif
 	flush_pmd_entry(pmdp);
 }
 
@@ -128,7 +132,7 @@ pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp, pte_t *ptep)
 	 * The pmd must be loaded with the physical
 	 * address of the PTE table
 	 */
-	pte_ptr -= PTRS_PER_PTE * sizeof(void *);
+	pte_ptr -= LINUX_PTE_OFFSET * sizeof(void *);
 	__pmd_populate(pmdp, __pa(pte_ptr) | _PAGE_KERNEL_TABLE);
 }
 
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 201ccaa..8429868 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -40,6 +40,7 @@
 #define VMALLOC_START		(((unsigned long)high_memory + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1))
 #endif
 
+#ifndef CONFIG_CPU_AFE
 /*
  * Hardware-wise, we have a two level page table structure, where the first
  * level has 4096 entries, and the second level has 256 entries.  Each entry
@@ -101,13 +102,31 @@
 #define PTRS_PER_PTE		512
 #define PTRS_PER_PMD		1
 #define PTRS_PER_PGD		2048
+#define LINUX_PTE_OFFSET	PTRS_PER_PTE
+#else
+/*
+ * If the Access Flag is enabled, Linux only uses one version of PTEs. We tell
+ * LInux that we have 1024 entries in the first level, each of which is 16
+ * bytes long (4 hardware pointers to the second level). The PTE level has
+ * 1024 entries.
+ */
+#define PTRS_PER_PTE		1024
+#define PTRS_PER_PMD		1
+#define PTRS_PER_PGD		1024
+#define LINUX_PTE_OFFSET	0
+#endif
 
 /*
  * PMD_SHIFT determines the size of the area a second-level page table can map
  * PGDIR_SHIFT determines what a third-level page table entry can map
  */
+#ifndef CONFIG_CPU_AFE
 #define PMD_SHIFT		21
 #define PGDIR_SHIFT		21
+#else
+#define PMD_SHIFT		22
+#define PGDIR_SHIFT		22
+#endif
 
 #define LIBRARY_TEXT_START	0x0c000000
 
@@ -150,6 +169,7 @@ extern void __pgd_error(const char *file, int line, unsigned long val);
 #define SUPERSECTION_SIZE	(1UL << SUPERSECTION_SHIFT)
 #define SUPERSECTION_MASK	(~(SUPERSECTION_SIZE-1))
 
+#ifndef CONFIG_CPU_AFE
 /*
  * "Linux" PTE definitions.
  *
@@ -169,7 +189,30 @@ extern void __pgd_error(const char *file, int line, unsigned long val);
 #define L_PTE_USER		(1 << 8)
 #define L_PTE_EXEC		(1 << 9)
 #define L_PTE_SHARED		(1 << 10)	/* shared(v6), coherent(xsc3) */
+#define L_PTE_NOEXEC		0
+#define L_PTE_NOWRITE		0
+#else
+/*
+ * "Linux" PTE definitions with AFE set.
+ *
+ * These bits overlap with the hardware bits but the naming is preserved for
+ * consistency with the non-AFE version.
+ */
+#define L_PTE_NOEXEC		(1 << 0)	/* XN */
+#define L_PTE_PRESENT		(1 << 1)
+#define L_PTE_FILE		(1 << 2)	/* only when !PRESENT */
+#define L_PTE_BUFFERABLE	(1 << 2)	/* B */
+#define L_PTE_CACHEABLE		(1 << 3)	/* C */
+#define L_PTE_YOUNG		(1 << 4)	/* access flag */
+#define L_PTE_USER		(1 << 5)	/* AP[1] */
+#define L_PTE_DIRTY		(1 << 7)	/* TEX[1] */
+#define L_PTE_NOWRITE		(1 << 9)	/* AP[2] */
+#define L_PTE_SHARED		(1 << 10)	/* shared(v6+) */
+#define L_PTE_EXEC		0
+#define L_PTE_WRITE		0
+#endif
 
+#ifndef CONFIG_CPU_AFE
 /*
  * These are the memory types, defined to be compatible with
  * pre-ARMv6 CPUs cacheable and bufferable bits:   XXCB
@@ -185,6 +228,22 @@ extern void __pgd_error(const char *file, int line, unsigned long val);
 #define L_PTE_MT_DEV_WC		(0x09 << 2)	/* 1001 */
 #define L_PTE_MT_DEV_CACHED	(0x0b << 2)	/* 1011 */
 #define L_PTE_MT_MASK		(0x0f << 2)
+#else
+/*
+ * AFE page table format requires TEX remapping as well: TEX[0], C, B.
+ */
+#define L_PTE_MT_UNCACHED	((0 << 6) | (0 << 2))	/* 000 */
+#define L_PTE_MT_BUFFERABLE	((0 << 6) | (1 << 2))	/* 001 */
+#define L_PTE_MT_WRITETHROUGH	((0 << 6) | (2 << 2))	/* 010 */
+#define L_PTE_MT_WRITEBACK	((0 << 6) | (3 << 2))	/* 011 */
+#define L_PTE_MT_MINICACHE	((1 << 6) | (2 << 2))	/* 110 (sa1100, xscale) */
+#define L_PTE_MT_WRITEALLOC	((1 << 6) | (3 << 2))	/* 111 */
+#define L_PTE_MT_DEV_SHARED	((1 << 6) | (0 << 2))	/* 100 */
+#define L_PTE_MT_DEV_NONSHARED	((1 << 6) | (0 << 2))	/* 100 */
+#define L_PTE_MT_DEV_WC		((0 << 6) | (1 << 2))	/* 001 */
+#define L_PTE_MT_DEV_CACHED	((0 << 6) | (3 << 2))	/* 011 */
+#define L_PTE_MT_MASK		((1 << 6) | (3 << 2))
+#endif
 
 #ifndef __ASSEMBLY__
 
@@ -202,22 +261,22 @@ extern pgprot_t		pgprot_kernel;
 #define _MOD_PROT(p, b)	__pgprot(pgprot_val(p) | (b))
 
 #define PAGE_NONE		pgprot_user
-#define PAGE_SHARED		_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_WRITE)
+#define PAGE_SHARED		_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_WRITE | L_PTE_NOEXEC)
 #define PAGE_SHARED_EXEC	_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_WRITE | L_PTE_EXEC)
-#define PAGE_COPY		_MOD_PROT(pgprot_user, L_PTE_USER)
-#define PAGE_COPY_EXEC		_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_EXEC)
-#define PAGE_READONLY		_MOD_PROT(pgprot_user, L_PTE_USER)
-#define PAGE_READONLY_EXEC	_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_EXEC)
-#define PAGE_KERNEL		pgprot_kernel
+#define PAGE_COPY		_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_NOEXEC | L_PTE_NOWRITE)
+#define PAGE_COPY_EXEC		_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_EXEC | L_PTE_NOWRITE)
+#define PAGE_READONLY		_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_NOEXEC | L_PTE_NOWRITE)
+#define PAGE_READONLY_EXEC	_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_EXEC | L_PTE_NOWRITE)
+#define PAGE_KERNEL		_MOD_PROT(pgprot_kernel, L_PTE_NOEXEC)
 #define PAGE_KERNEL_EXEC	_MOD_PROT(pgprot_kernel, L_PTE_EXEC)
 
-#define __PAGE_NONE		__pgprot(_L_PTE_DEFAULT)
-#define __PAGE_SHARED		__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_WRITE)
+#define __PAGE_NONE		__pgprot(_L_PTE_DEFAULT | L_PTE_NOEXEC | L_PTE_NOWRITE)
+#define __PAGE_SHARED		__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_WRITE | L_PTE_NOEXEC)
 #define __PAGE_SHARED_EXEC	__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_WRITE | L_PTE_EXEC)
-#define __PAGE_COPY		__pgprot(_L_PTE_DEFAULT | L_PTE_USER)
-#define __PAGE_COPY_EXEC	__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_EXEC)
-#define __PAGE_READONLY		__pgprot(_L_PTE_DEFAULT | L_PTE_USER)
-#define __PAGE_READONLY_EXEC	__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_EXEC)
+#define __PAGE_COPY		__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_NOEXEC | L_PTE_NOWRITE)
+#define __PAGE_COPY_EXEC	__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_EXEC | L_PTE_NOWRITE)
+#define __PAGE_READONLY		__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_NOEXEC | L_PTE_NOWRITE)
+#define __PAGE_READONLY_EXEC	__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_EXEC | L_PTE_NOWRITE)
 
 #endif /* __ASSEMBLY__ */
 
@@ -287,7 +346,11 @@ extern struct page *empty_zero_page;
  * Undefined behaviour if not..
  */
 #define pte_present(pte)	(pte_val(pte) & L_PTE_PRESENT)
+#ifndef CONFIG_CPU_AFE
 #define pte_write(pte)		(pte_val(pte) & L_PTE_WRITE)
+#else
+#define pte_write(pte)		(!(pte_val(pte) & L_PTE_NOWRITE))
+#endif
 #define pte_dirty(pte)		(pte_val(pte) & L_PTE_DIRTY)
 #define pte_young(pte)		(pte_val(pte) & L_PTE_YOUNG)
 #define pte_special(pte)	(0)
@@ -295,8 +358,13 @@ extern struct page *empty_zero_page;
 #define PTE_BIT_FUNC(fn,op) \
 static inline pte_t pte_##fn(pte_t pte) { pte_val(pte) op; return pte; }
 
+#ifndef CONFIG_CPU_AFE
 PTE_BIT_FUNC(wrprotect, &= ~L_PTE_WRITE);
 PTE_BIT_FUNC(mkwrite,   |= L_PTE_WRITE);
+#else
+PTE_BIT_FUNC(wrprotect, |= L_PTE_NOWRITE);
+PTE_BIT_FUNC(mkwrite,   &= ~L_PTE_NOWRITE);
+#endif
 PTE_BIT_FUNC(mkclean,   &= ~L_PTE_DIRTY);
 PTE_BIT_FUNC(mkdirty,   |= L_PTE_DIRTY);
 PTE_BIT_FUNC(mkold,     &= ~L_PTE_YOUNG);
@@ -316,10 +384,27 @@ static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
 #define pmd_present(pmd)	(pmd_val(pmd))
 #define pmd_bad(pmd)		(pmd_val(pmd) & 2)
 
+#ifndef CONFIG_CPU_AFE
+#define copy_pmd(pmdpd,pmdps)		\
+	do {				\
+		pmdpd[0] = pmdps[0];	\
+		pmdpd[1] = pmdps[1];	\
+		flush_pmd_entry(pmdpd);	\
+	} while (0)
+
+#define pmd_clear(pmdp)			\
+	do {				\
+		pmdp[0] = __pmd(0);	\
+		pmdp[1] = __pmd(0);	\
+		clean_pmd_entry(pmdp);	\
+	} while (0)
+#else
 #define copy_pmd(pmdpd,pmdps)		\
 	do {				\
 		pmdpd[0] = pmdps[0];	\
 		pmdpd[1] = pmdps[1];	\
+		pmdpd[2] = pmdps[2];	\
+		pmdpd[3] = pmdps[3];	\
 		flush_pmd_entry(pmdpd);	\
 	} while (0)
 
@@ -327,15 +412,18 @@ static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
 	do {				\
 		pmdp[0] = __pmd(0);	\
 		pmdp[1] = __pmd(0);	\
+		pmdp[2] = __pmd(0);	\
+		pmdp[3] = __pmd(0);	\
 		clean_pmd_entry(pmdp);	\
 	} while (0)
+#endif
 
 static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 {
 	unsigned long ptr;
 
 	ptr = pmd_val(pmd) & ~(PTRS_PER_PTE * sizeof(void *) - 1);
-	ptr += PTRS_PER_PTE * sizeof(void *);
+	ptr += LINUX_PTE_OFFSET * sizeof(void *);
 
 	return __va(ptr);
 }
@@ -375,7 +463,8 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
-	const unsigned long mask = L_PTE_EXEC | L_PTE_WRITE | L_PTE_USER;
+	const unsigned long mask = L_PTE_EXEC | L_PTE_WRITE | L_PTE_USER |
+		L_PTE_NOEXEC | L_PTE_NOWRITE;
 	pte_val(pte) = (pte_val(pte) & ~mask) | (pgprot_val(newprot) & mask);
 	return pte;
 }
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index ce382f5..56aadfa 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -454,6 +454,18 @@ config CPU_32v6
 config CPU_32v7
 	bool
 
+# Page table format
+config CPU_AFE
+	bool
+	depends on MMU
+	default y if CPU_V7
+	help
+	  This option sets the Access Flag Enable bit forcing the simplified
+	  permission model and automatic management of the access bit (if
+	  supported by the hardware). With this option enabled and TEX
+	  remapping, Linux no longer keeps a separate page table entry for
+	  storing additional bits.
+
 # The abort model
 config CPU_ABRT_NOMMU
 	bool
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 176c696..15dafb6 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -25,9 +25,15 @@
 #include <asm/sizes.h>
 
 /* Sanity check size */
+#ifndef CONFIG_CPU_AFE
 #if (CONSISTENT_DMA_SIZE % SZ_2M)
 #error "CONSISTENT_DMA_SIZE must be multiple of 2MiB"
 #endif
+#else
+#if (CONSISTENT_DMA_SIZE % SZ_4M)
+#error "CONSISTENT_DMA_SIZE must be multiple of 4MiB"
+#endif
+#endif
 
 #define CONSISTENT_END	(0xffe00000)
 #define CONSISTENT_BASE	(CONSISTENT_END - CONSISTENT_DMA_SIZE)
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 10e0680..e398ade 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -107,7 +107,9 @@ void show_pte(struct mm_struct *mm, unsigned long addr)
 
 		pte = pte_offset_map(pmd, addr);
 		printk(", *pte=%08lx", pte_val(*pte));
+#ifndef CONFIG_CPU_AFE
 		printk(", *ppte=%08lx", pte_val(pte[-PTRS_PER_PTE]));
+#endif
 		pte_unmap(pte);
 	} while(0);
 
@@ -458,7 +460,11 @@ static struct fsr_info {
 	{ do_bad,		SIGILL,	 BUS_ADRALN,	"alignment exception"		   },
 	{ do_bad,		SIGBUS,	 0,		"external abort on linefetch"	   },
 	{ do_translation_fault,	SIGSEGV, SEGV_MAPERR,	"section translation fault"	   },
+#ifndef CONFIG_CPU_AFE
 	{ do_bad,		SIGBUS,	 0,		"external abort on linefetch"	   },
+#else
+	{ do_page_fault,	SIGSEGV, SEGV_MAPERR,	"access flag fault"		   },
+#endif
 	{ do_page_fault,	SIGSEGV, SEGV_MAPERR,	"page translation fault"	   },
 	{ do_bad,		SIGBUS,	 0,		"external abort on non-linefetch"  },
 	{ do_bad,		SIGSEGV, SEGV_ACCERR,	"section domain fault"		   },
@@ -532,7 +538,11 @@ static struct fsr_info ifsr_info[] = {
 	{ do_bad,		SIGSEGV, SEGV_ACCERR,	"section access flag fault"	   },
 	{ do_bad,		SIGBUS,  0,		"unknown 4"			   },
 	{ do_translation_fault,	SIGSEGV, SEGV_MAPERR,	"section translation fault"	   },
+#ifndef CONFIG_CPU_AFE
 	{ do_bad,		SIGSEGV, SEGV_ACCERR,	"page access flag fault"	   },
+#else
+	{ do_page_fault,	SIGSEGV, SEGV_MAPERR,	"access flag fault"		   },
+#endif
 	{ do_page_fault,	SIGSEGV, SEGV_MAPERR,	"page translation fault"	   },
 	{ do_bad,		SIGBUS,	 0,		"external abort on non-linefetch"  },
 	{ do_bad,		SIGSEGV, SEGV_ACCERR,	"section domain fault"		   },
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index ea67be0..b3796a0 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -190,7 +190,7 @@ void adjust_cr(unsigned long mask, unsigned long set)
 }
 #endif
 
-#define PROT_PTE_DEVICE		L_PTE_PRESENT|L_PTE_YOUNG|L_PTE_DIRTY|L_PTE_WRITE
+#define PROT_PTE_DEVICE		L_PTE_PRESENT|L_PTE_YOUNG|L_PTE_DIRTY|L_PTE_WRITE|L_PTE_NOEXEC
 #define PROT_SECT_DEVICE	PMD_TYPE_SECT|PMD_SECT_AP_WRITE
 
 static struct mem_type mem_types[] = {
@@ -241,7 +241,7 @@ static struct mem_type mem_types[] = {
 	},
 	[MT_HIGH_VECTORS] = {
 		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
-				L_PTE_USER | L_PTE_EXEC,
+				L_PTE_USER | L_PTE_EXEC | L_PTE_NOWRITE,
 		.prot_l1   = PMD_TYPE_TABLE,
 		.domain    = DOMAIN_USER,
 	},
@@ -491,7 +491,8 @@ static void __init alloc_init_pte(pmd_t *pmd, unsigned long addr,
 	pte_t *pte;
 
 	if (pmd_none(*pmd)) {
-		pte = alloc_bootmem_low_pages(2 * PTRS_PER_PTE * sizeof(pte_t));
+		pte = alloc_bootmem_low_pages((LINUX_PTE_OFFSET
+					       + PTRS_PER_PTE) * sizeof(pte_t));
 		__pmd_populate(pmd, __pa(pte) | type->prot_l1);
 	}
 
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 3a28521..568ccfc 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -126,38 +126,26 @@ ENDPROC(cpu_v7_switch_mm)
  *		  (hardware version is stored at -1024 bytes)
  *	- pte   - PTE value to store
  *	- ext	- value for extended PTE bits
+ *
+ *	Simplified permission translation (AP0 is the access flag):
+ *	YUWD  AP2 AP1 AP0	SVC	User
+ *	0xxx   0   0   0	no acc	no acc
+ *	100x   1   0   1	r/o	no acc
+ *	10x0   1   0   1	r/o	no acc
+ *	1011   0   0   1	r/w	no acc
+ *	110x   1   1   1	r/o	r/o
+ *	11x0   1   1   1	r/o	r/o
+ *	1111   0   1   1	r/w	r/w
  */
 ENTRY(cpu_v7_set_pte_ext)
 #ifdef CONFIG_MMU
- ARM(	str	r1, [r0], #-2048	)	@ linux version
- THUMB(	str	r1, [r0]		)	@ linux version
- THUMB(	sub	r0, r0, #2048		)
-
-	bic	r3, r1, #0x000003f0
-	bic	r3, r3, #PTE_TYPE_MASK
-	orr	r3, r3, r2
-	orr	r3, r3, #PTE_EXT_AP0 | 2
-
-	tst	r1, #1 << 4
-	orrne	r3, r3, #PTE_EXT_TEX(1)
-
-	tst	r1, #L_PTE_WRITE
-	tstne	r1, #L_PTE_DIRTY
-	orreq	r3, r3, #PTE_EXT_APX
-
-	tst	r1, #L_PTE_USER
-	orrne	r3, r3, #PTE_EXT_AP1
-	tstne	r3, #PTE_EXT_APX
-	bicne	r3, r3, #PTE_EXT_APX | PTE_EXT_AP0
-
-	tst	r1, #L_PTE_EXEC
-	orreq	r3, r3, #PTE_EXT_XN
-
-	tst	r1, #L_PTE_YOUNG
-	tstne	r1, #L_PTE_PRESENT
-	moveq	r3, #0
-
-	str	r3, [r0]
+	tst	r1, #L_PTE_PRESENT
+	beq	1f
+	tst	r1, #L_PTE_DIRTY
+	orreq	r1, #L_PTE_NOWRITE
+	orr	r1, r1, r2
+1:
+	str	r1, [r0]
 	mcr	p15, 0, r0, c7, c10, 1		@ flush_pte
 #endif
 	mov	pc, lr
@@ -283,14 +271,14 @@ __v7_setup:
 ENDPROC(__v7_setup)
 
 	/*   AT
-	 *  TFR   EV X F   I D LR    S
-	 * .EEE ..EE PUI. .T.T 4RVI ZWRS BLDP WCAM
-	 * rxxx rrxx xxx0 0101 xxxx xxxx x111 xxxx < forced
-	 *    1    0 110       0011 1100 .111 1101 < we want
+	 *  TFR   EV X F   IHD LR    S
+	 * .EEE ..EE PUI. .TAT 4RVI ZWRS BLDP WCAM
+	 * rxxx rrxx xxx0 01x1 xxxx xxxx x111 xxxx < forced
+	 *   11    0 110    1  0011 1100 .111 1101 < we want
 	 */
 	.type	v7_crval, #object
 v7_crval:
-	crval	clear=0x0120c302, mmuset=0x10c03c7d, ucset=0x00c01c7c
+	crval	clear=0x0120c302, mmuset=0x30c23c7d, ucset=0x00c01c7c
 
 __v7_setup_stack:
 	.space	4 * 11				@ 11 registers
