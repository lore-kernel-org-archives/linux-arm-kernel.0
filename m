From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 18 Aug 2017 18:26:00 +0100
Subject: [PATCH v2 3/5] arm64: Move PTE_RDONLY bit handling out of set_pte_at()
In-Reply-To: <20170818172602.7624-1-catalin.marinas@arm.com>
References: <20170818172602.7624-1-catalin.marinas@arm.com>
Message-ID: <20170818172602.7624-4-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently PTE_RDONLY is treated as a hardware only bit and not handled
by the pte_mkwrite(), pte_wrprotect() or the user PAGE_* definitions.
The set_pte_at() function is responsible for setting this bit based on
the write permission or dirty state. This patch moves the PTE_RDONLY
handling out of set_pte_at into the pte_mkwrite()/pte_wrprotect()
functions. The PAGE_* definitions to need to be updated to explicitly
include PTE_RDONLY when !PTE_WRITE.

The patch also removes the redundant PAGE_COPY(_EXEC) definitions as
they are identical to the corresponding PAGE_READONLY(_EXEC).

Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/pgtable-prot.h | 18 ++++++++----------
 arch/arm64/include/asm/pgtable.h      | 34 ++++++++++------------------------
 arch/arm64/kernel/hibernate.c         |  4 ++--
 arch/arm64/mm/fault.c                 |  6 +-----
 4 files changed, 21 insertions(+), 41 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 2142c7726e76..0a5635fb0ef9 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -63,23 +63,21 @@
 #define PAGE_S2			__pgprot(PROT_DEFAULT | PTE_S2_MEMATTR(MT_S2_NORMAL) | PTE_S2_RDONLY)
 #define PAGE_S2_DEVICE		__pgprot(PROT_DEFAULT | PTE_S2_MEMATTR(MT_S2_DEVICE_nGnRE) | PTE_S2_RDONLY | PTE_UXN)
 
-#define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_PROT_NONE | PTE_PXN | PTE_UXN)
+#define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_PROT_NONE | PTE_RDONLY | PTE_PXN | PTE_UXN)
 #define PAGE_SHARED		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_UXN | PTE_WRITE)
 #define PAGE_SHARED_EXEC	__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_WRITE)
-#define PAGE_COPY		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_UXN)
-#define PAGE_COPY_EXEC		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN)
-#define PAGE_READONLY		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_UXN)
-#define PAGE_READONLY_EXEC	__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN)
-#define PAGE_EXECONLY		__pgprot(_PAGE_DEFAULT | PTE_NG | PTE_PXN)
+#define PAGE_READONLY		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)
+#define PAGE_READONLY_EXEC	__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_RDONLY | PTE_NG | PTE_PXN)
+#define PAGE_EXECONLY		__pgprot(_PAGE_DEFAULT | PTE_RDONLY | PTE_NG | PTE_PXN)
 
 #define __P000  PAGE_NONE
 #define __P001  PAGE_READONLY
-#define __P010  PAGE_COPY
-#define __P011  PAGE_COPY
+#define __P010  PAGE_READONLY
+#define __P011  PAGE_READONLY
 #define __P100  PAGE_EXECONLY
 #define __P101  PAGE_READONLY_EXEC
-#define __P110  PAGE_COPY_EXEC
-#define __P111  PAGE_COPY_EXEC
+#define __P110  PAGE_READONLY_EXEC
+#define __P111  PAGE_READONLY_EXEC
 
 #define __S000  PAGE_NONE
 #define __S001  PAGE_READONLY
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 9127688ae775..a04bfb869a80 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -125,12 +125,16 @@ static inline pte_t set_pte_bit(pte_t pte, pgprot_t prot)
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
-	return clear_pte_bit(pte, __pgprot(PTE_WRITE));
+	pte = clear_pte_bit(pte, __pgprot(PTE_WRITE));
+	pte = set_pte_bit(pte, __pgprot(PTE_RDONLY));
+	return pte;
 }
 
 static inline pte_t pte_mkwrite(pte_t pte)
 {
-	return set_pte_bit(pte, __pgprot(PTE_WRITE));
+	pte = set_pte_bit(pte, __pgprot(PTE_WRITE));
+	pte = clear_pte_bit(pte, __pgprot(PTE_RDONLY));
+	return pte;
 }
 
 static inline pte_t pte_mkclean(pte_t pte)
@@ -169,16 +173,6 @@ static inline pte_t pte_mknoncont(pte_t pte)
 	return clear_pte_bit(pte, __pgprot(PTE_CONT));
 }
 
-static inline pte_t pte_clear_rdonly(pte_t pte)
-{
-	return clear_pte_bit(pte, __pgprot(PTE_RDONLY));
-}
-
-static inline pte_t pte_set_rdonly(pte_t pte)
-{
-	return set_pte_bit(pte, __pgprot(PTE_RDONLY));
-}
-
 static inline pte_t pte_mkpresent(pte_t pte)
 {
 	return set_pte_bit(pte, __pgprot(PTE_VALID));
@@ -226,14 +220,8 @@ extern void __sync_icache_dcache(pte_t pteval, unsigned long addr);
 static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep, pte_t pte)
 {
-	if (pte_present(pte)) {
-		if (pte_sw_dirty(pte) && pte_write(pte))
-			pte_val(pte) &= ~PTE_RDONLY;
-		else
-			pte_val(pte) |= PTE_RDONLY;
-		if (pte_user_exec(pte) && !pte_special(pte))
-			__sync_icache_dcache(pte, addr);
-	}
+	if (pte_present(pte) && pte_user_exec(pte) && !pte_special(pte))
+		__sync_icache_dcache(pte, addr);
 
 	/*
 	 * If the existing pte is valid, check for potential race with
@@ -659,12 +647,10 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addres
 		old_pte = pte;
 		/*
 		 * If hardware-dirty (PTE_WRITE/DBM bit set and PTE_RDONLY
-		 * clear), set the PTE_DIRTY and PTE_RDONLY bits.
+		 * clear), set the PTE_DIRTY bit.
 		 */
-		if (pte_hw_dirty(pte)) {
+		if (pte_hw_dirty(pte))
 			pte = pte_mkdirty(pte);
-			pte = pte_set_rdonly(pte);
-		}
 		pte = pte_wrprotect(pte);
 		pte_val(pte) = cmpxchg_relaxed(&pte_val(*ptep),
 					       pte_val(old_pte), pte_val(pte));
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index a44e13942d30..095d3c170f5d 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -330,7 +330,7 @@ static void _copy_pte(pte_t *dst_pte, pte_t *src_pte, unsigned long addr)
 		 * read only (code, rodata). Clear the RDONLY bit from
 		 * the temporary mappings we use during restore.
 		 */
-		set_pte(dst_pte, pte_clear_rdonly(pte));
+		set_pte(dst_pte, pte_mkwrite(pte));
 	} else if (debug_pagealloc_enabled() && !pte_none(pte)) {
 		/*
 		 * debug_pagealloc will removed the PTE_VALID bit if
@@ -343,7 +343,7 @@ static void _copy_pte(pte_t *dst_pte, pte_t *src_pte, unsigned long addr)
 		 */
 		BUG_ON(!pfn_valid(pte_pfn(pte)));
 
-		set_pte(dst_pte, pte_mkpresent(pte_clear_rdonly(pte)));
+		set_pte(dst_pte, pte_mkpresent(pte_mkwrite(pte)));
 	}
 }
 
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 9b861986548e..c3eebb4afd6c 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -161,11 +161,7 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
 		return 0;
 
 	/* only preserve the access flags and write permission */
-	pte_val(entry) &= PTE_AF | PTE_WRITE | PTE_DIRTY;
-
-	/* set PTE_RDONLY if actual read-only or clean PTE */
-	if (!pte_write(entry) || !pte_sw_dirty(entry))
-		entry = pte_set_rdonly(entry);
+	pte_val(entry) &= PTE_RDONLY | PTE_AF | PTE_WRITE | PTE_DIRTY;
 
 	/*
 	 * Setting the flags must be done atomically to avoid racing with the
