From: steve.capper@arm.com (Steve Capper)
Date: Wed, 15 Jan 2014 14:07:13 +0000
Subject: [PATCH 2/2] arm64: mm: Introduce PTE_WRITE
In-Reply-To: <1389794833-7505-1-git-send-email-steve.capper@arm.com>
References: <1389794833-7505-1-git-send-email-steve.capper@arm.com>
Message-ID: <1389794833-7505-3-git-send-email-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have the following means for encoding writable or dirty ptes:

                                PTE_DIRTY       PTE_RDONLY
!pte_dirty && !pte_write        0               1
!pte_dirty && pte_write         0               1
pte_dirty && !pte_write         1               1
pte_dirty && pte_write          1               0

So we can't distinguish between writable clean ptes and read only
ptes. This can cause problems with ptes being incorrectly flagged as
read only when they are writable but not dirty.

This patch introduces a new software bit PTE_WRITE which allows us to
correctly identify writable ptes. PTE_RDONLY is now only clear for
valid ptes where a page is both writable and dirty.

Signed-off-by: Steve Capper <steve.capper@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 48 +++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 27c7839..b524dcd 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -28,7 +28,7 @@
 #define PTE_FILE		(_AT(pteval_t, 1) << 2)	/* only when !pte_present() */
 #define PTE_DIRTY		(_AT(pteval_t, 1) << 55)
 #define PTE_SPECIAL		(_AT(pteval_t, 1) << 56)
-				/* bit 57 for PMD_SECT_SPLITTING */
+#define PTE_WRITE		(_AT(pteval_t, 1) << 57)
 #define PTE_PROT_NONE		(_AT(pteval_t, 1) << 58) /* only when !PTE_VALID */
 
 /*
@@ -67,15 +67,15 @@ extern pgprot_t pgprot_default;
 
 #define _MOD_PROT(p, b)		__pgprot_modify(p, 0, b)
 
-#define PAGE_NONE		__pgprot_modify(pgprot_default, PTE_TYPE_MASK, PTE_PROT_NONE | PTE_RDONLY | PTE_PXN | PTE_UXN)
-#define PAGE_SHARED		_MOD_PROT(pgprot_default, PTE_USER | PTE_NG | PTE_PXN | PTE_UXN)
-#define PAGE_SHARED_EXEC	_MOD_PROT(pgprot_default, PTE_USER | PTE_NG | PTE_PXN)
-#define PAGE_COPY		_MOD_PROT(pgprot_default, PTE_USER | PTE_NG | PTE_PXN | PTE_UXN | PTE_RDONLY)
-#define PAGE_COPY_EXEC		_MOD_PROT(pgprot_default, PTE_USER | PTE_NG | PTE_PXN | PTE_RDONLY)
-#define PAGE_READONLY		_MOD_PROT(pgprot_default, PTE_USER | PTE_NG | PTE_PXN | PTE_UXN | PTE_RDONLY)
-#define PAGE_READONLY_EXEC	_MOD_PROT(pgprot_default, PTE_USER | PTE_NG | PTE_PXN | PTE_RDONLY)
-#define PAGE_KERNEL		_MOD_PROT(pgprot_default, PTE_PXN | PTE_UXN | PTE_DIRTY)
-#define PAGE_KERNEL_EXEC	_MOD_PROT(pgprot_default, PTE_UXN | PTE_DIRTY)
+#define PAGE_NONE		__pgprot_modify(pgprot_default, PTE_TYPE_MASK, PTE_PROT_NONE | PTE_PXN | PTE_UXN)
+#define PAGE_SHARED		_MOD_PROT(pgprot_default, PTE_USER | PTE_NG | PTE_PXN | PTE_UXN | PTE_WRITE)
+#define PAGE_SHARED_EXEC	_MOD_PROT(pgprot_default, PTE_USER | PTE_NG | PTE_PXN | PTE_WRITE)
+#define PAGE_COPY		_MOD_PROT(pgprot_default, PTE_USER | PTE_NG | PTE_PXN | PTE_UXN)
+#define PAGE_COPY_EXEC		_MOD_PROT(pgprot_default, PTE_USER | PTE_NG | PTE_PXN)
+#define PAGE_READONLY		_MOD_PROT(pgprot_default, PTE_USER | PTE_NG | PTE_PXN | PTE_UXN)
+#define PAGE_READONLY_EXEC	_MOD_PROT(pgprot_default, PTE_USER | PTE_NG | PTE_PXN)
+#define PAGE_KERNEL		_MOD_PROT(pgprot_default, PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE)
+#define PAGE_KERNEL_EXEC	_MOD_PROT(pgprot_default, PTE_UXN | PTE_DIRTY | PTE_WRITE)
 
 #define PAGE_HYP		_MOD_PROT(pgprot_default, PTE_HYP)
 #define PAGE_HYP_DEVICE		__pgprot(PROT_DEVICE_nGnRE | PTE_HYP)
@@ -83,13 +83,13 @@ extern pgprot_t pgprot_default;
 #define PAGE_S2			__pgprot_modify(pgprot_default, PTE_S2_MEMATTR_MASK, PTE_S2_MEMATTR(MT_S2_NORMAL) | PTE_S2_RDONLY)
 #define PAGE_S2_DEVICE		__pgprot(PROT_DEFAULT | PTE_S2_MEMATTR(MT_S2_DEVICE_nGnRE) | PTE_S2_RDWR | PTE_UXN)
 
-#define __PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_TYPE_MASK) | PTE_PROT_NONE | PTE_RDONLY | PTE_PXN | PTE_UXN)
-#define __PAGE_SHARED		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_UXN)
-#define __PAGE_SHARED_EXEC	__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN)
-#define __PAGE_COPY		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_UXN | PTE_RDONLY)
-#define __PAGE_COPY_EXEC	__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_RDONLY)
-#define __PAGE_READONLY		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_UXN | PTE_RDONLY)
-#define __PAGE_READONLY_EXEC	__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_RDONLY)
+#define __PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_TYPE_MASK) | PTE_PROT_NONE | PTE_PXN | PTE_UXN)
+#define __PAGE_SHARED		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_UXN | PTE_WRITE)
+#define __PAGE_SHARED_EXEC	__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_WRITE)
+#define __PAGE_COPY		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_UXN)
+#define __PAGE_COPY_EXEC	__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN)
+#define __PAGE_READONLY		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_UXN)
+#define __PAGE_READONLY_EXEC	__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN)
 
 #endif /* __ASSEMBLY__ */
 
@@ -140,7 +140,7 @@ extern struct page *empty_zero_page;
 #define pte_dirty(pte)		(pte_val(pte) & PTE_DIRTY)
 #define pte_young(pte)		(pte_val(pte) & PTE_AF)
 #define pte_special(pte)	(pte_val(pte) & PTE_SPECIAL)
-#define pte_write(pte)		(!(pte_val(pte) & PTE_RDONLY))
+#define pte_write(pte)		(pte_val(pte) & PTE_WRITE)
 #define pte_exec(pte)		(!(pte_val(pte) & PTE_UXN))
 
 #define pte_valid_user(pte) \
@@ -148,13 +148,13 @@ extern struct page *empty_zero_page;
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
-	pte_val(pte) |= PTE_RDONLY;
+	pte_val(pte) &= ~PTE_WRITE;
 	return pte;
 }
 
 static inline pte_t pte_mkwrite(pte_t pte)
 {
-	pte_val(pte) &= ~PTE_RDONLY;
+	pte_val(pte) |= PTE_WRITE;
 	return pte;
 }
 
@@ -201,8 +201,10 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 	if (pte_valid_user(pte)) {
 		if (pte_exec(pte))
 			__sync_icache_dcache(pte, addr);
-		if (!pte_dirty(pte))
-			pte = pte_wrprotect(pte);
+		if (pte_dirty(pte) && pte_write(pte))
+			pte_val(pte) &= ~PTE_RDONLY;
+		else
+			pte_val(pte) |= PTE_RDONLY;
 	}
 
 	set_pte(ptep, pte);
@@ -376,7 +378,7 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	const pteval_t mask = PTE_USER | PTE_PXN | PTE_UXN | PTE_RDONLY |
-			      PTE_PROT_NONE | PTE_VALID;
+			      PTE_PROT_NONE | PTE_VALID | PTE_WRITE;
 	pte_val(pte) = (pte_val(pte) & ~mask) | (pgprot_val(newprot) & mask);
 	return pte;
 }
-- 
1.8.1.4
