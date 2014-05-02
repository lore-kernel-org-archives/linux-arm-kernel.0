From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri,  2 May 2014 16:49:52 +0100
Subject: [PATCH] arm64: Introduce execute-only page access permissions
Message-ID: <1399045792-5490-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARMv8 architecture allows execute-only user permissions by clearing
the PTE_UXN and PTE_USER bits. The kernel, however, can still access
such page.

This patch changes the arm64 __P100 and __S100 protection_map[] macros
to the new __PAGE_EXECONLY attributes. A side effect is that
pte_valid_user() no longer triggers for __PAGE_EXECONLY since PTE_USER
isn't set. To work around this, the check is done on the PTE_NG bit via
the pte_valid_ng() macro. VM_READ is also checked now for page faults.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 11 ++++++-----
 arch/arm64/mm/fault.c            |  5 ++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 90c811f05a2e..e50bb3cbd8f2 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -90,6 +90,7 @@ extern pgprot_t pgprot_default;
 #define __PAGE_COPY_EXEC	__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN)
 #define __PAGE_READONLY		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_UXN)
 #define __PAGE_READONLY_EXEC	__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN)
+#define __PAGE_EXECONLY		__pgprot(_PAGE_DEFAULT | PTE_NG | PTE_PXN)
 
 #endif /* __ASSEMBLY__ */
 
@@ -97,7 +98,7 @@ extern pgprot_t pgprot_default;
 #define __P001  __PAGE_READONLY
 #define __P010  __PAGE_COPY
 #define __P011  __PAGE_COPY
-#define __P100  __PAGE_READONLY_EXEC
+#define __P100  __PAGE_EXECONLY
 #define __P101  __PAGE_READONLY_EXEC
 #define __P110  __PAGE_COPY_EXEC
 #define __P111  __PAGE_COPY_EXEC
@@ -106,7 +107,7 @@ extern pgprot_t pgprot_default;
 #define __S001  __PAGE_READONLY
 #define __S010  __PAGE_SHARED
 #define __S011  __PAGE_SHARED
-#define __S100  __PAGE_READONLY_EXEC
+#define __S100  __PAGE_EXECONLY
 #define __S101  __PAGE_READONLY_EXEC
 #define __S110  __PAGE_SHARED_EXEC
 #define __S111  __PAGE_SHARED_EXEC
@@ -143,8 +144,8 @@ extern struct page *empty_zero_page;
 #define pte_write(pte)		(!!(pte_val(pte) & PTE_WRITE))
 #define pte_exec(pte)		(!(pte_val(pte) & PTE_UXN))
 
-#define pte_valid_user(pte) \
-	((pte_val(pte) & (PTE_VALID | PTE_USER)) == (PTE_VALID | PTE_USER))
+#define pte_valid_ng(pte) \
+	((pte_val(pte) & (PTE_VALID | PTE_NG)) == (PTE_VALID | PTE_NG))
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
@@ -198,7 +199,7 @@ extern void __sync_icache_dcache(pte_t pteval, unsigned long addr);
 static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep, pte_t pte)
 {
-	if (pte_valid_user(pte)) {
+	if (pte_valid_ng(pte)) {
 		if (!pte_special(pte) && pte_exec(pte))
 			__sync_icache_dcache(pte, addr);
 		if (pte_dirty(pte) && pte_write(pte))
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index bcc965e2cce1..89c6763d5e7e 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -173,8 +173,7 @@ static int __do_page_fault(struct mm_struct *mm, unsigned long addr,
 good_area:
 	/*
 	 * Check that the permissions on the VMA allow for the fault which
-	 * occurred. If we encountered a write or exec fault, we must have
-	 * appropriate permissions, otherwise we allow any permission.
+	 * occurred.
 	 */
 	if (!(vma->vm_flags & vm_flags)) {
 		fault = VM_FAULT_BADACCESS;
@@ -196,7 +195,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	struct task_struct *tsk;
 	struct mm_struct *mm;
 	int fault, sig, code;
-	unsigned long vm_flags = VM_READ | VM_WRITE | VM_EXEC;
+	unsigned long vm_flags = VM_READ | VM_WRITE;
 	unsigned int mm_flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
 	tsk = current;
