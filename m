From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed,  9 Dec 2015 17:26:57 +0000
Subject: [PATCH 2/2] arm64: Implement ptep_set_access_flags() for hardware
 AF/DBM
In-Reply-To: <1449682017-23729-1-git-send-email-catalin.marinas@arm.com>
References: <1449682017-23729-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1449682017-23729-3-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When hardware updates of the access and dirty states are enabled, the
default ptep_set_access_flags() implementation based on calling
set_pte_at() directly is potentially racy. This triggers the "racy dirty
state clearing" warning in set_pte_at() because an existing writable PTE
is overridden with a clean entry.

There are two main scenarios for this situation:

1. The CPU getting an access fault does not support hardware updates of
   the access/dirty flags. However, a different agent in the system
   (e.g. SMMU) can do this, therefore overriding a writable entry with a
   clean one could potentially lose the automatically updated dirty
   status

2. A more complex situation is possible when all CPUs support hardware
   AF/DBM:

   a) Initial state: shareable + writable vma and pte_none(pte)
   b) Read fault taken by two threads of the same process on different
      CPUs
   c) CPU0 takes the mmap_sem and proceeds to handling the fault. It
      eventually reaches do_set_pte() which sets a writable + clean pte.
      CPU0 releases the mmap_sem
   d) CPU1 acquires the mmap_sem and proceeds to handle_pte_fault(). The
      pte entry it reads is present, writable and clean and it continues
      to pte_mkyoung()
   e) CPU1 calls ptep_set_access_flags()

   If between (d) and (e) the hardware (another CPU) updates the dirty
   state (clears PTE_RDONLY), CPU1 will override the PTR_RDONLY bit
   marking the entry clean again.

This patch implements an arm64-specific ptep_set_access_flags() function
which performs an atomic update of the AF bit. For the cases where the
new entry is already dirty or read-only, there is no race with the
hardware update, therefore it performs a set_pte() directly.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Ming Lei <tom.leiming@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/pgtable.h |  5 ++++
 arch/arm64/mm/fault.c            | 57 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 002dc61a4dff..77bc5d6ed4e9 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -536,6 +536,11 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 }
 
 #ifdef CONFIG_ARM64_HW_AFDBM
+#define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
+extern int ptep_set_access_flags(struct vm_area_struct *vma,
+				 unsigned long address, pte_t *ptep,
+				 pte_t entry, int dirty);
+
 /*
  * Atomic pte/pmd modifications.
  */
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 92ddac1e8ca2..b393ee2eeda2 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -81,6 +81,63 @@ void show_pte(struct mm_struct *mm, unsigned long addr)
 	printk("\n");
 }
 
+#ifdef CONFIG_ARM64_HW_AFDBM
+/*
+ * It only sets the access flags (dirty, accessed), as well as write
+ * permission, and only to a more permissive setting. This function needs to
+ * cope with hardware update of the accessed/dirty state by other agents in
+ * the system. It can safely skip the __sync_icache_dcache() call as in
+ * set_pte_at() since the PTE is never changed from no-exec to exec by this
+ * function.
+ * It returns whether the PTE actually changed.
+ */
+int ptep_set_access_flags(struct vm_area_struct *vma,
+			  unsigned long address, pte_t *ptep,
+			  pte_t entry, int dirty)
+{
+	unsigned int tmp;
+
+	if (pte_same(*ptep, entry))
+		return 0;
+
+	/*
+	 * If the PTE is read-only, the hardware cannot update the dirty state
+	 * (clear the PTE_RDONLY bit). If we write a dirty entry, we can
+	 * ignore the race with the hardware update since we set both accessed
+	 * and dirty states anyway. The caller guarantees that the new PTE is
+	 * writable when dirty != 0.
+	 */
+	if (dirty || !pte_write(entry)) {
+		/* avoid a subsequent fault on read-only entries */
+		if (dirty)
+			pte_val(entry) &= ~PTE_RDONLY;
+		set_pte(ptep, entry);
+		goto flush;
+	}
+
+	VM_WARN_ONCE(!pte_write(*ptep) && pte_write(entry),
+		     "%s: making pte writable without dirty: %016llx -> %016llx\n",
+		     __func__, pte_val(*ptep), pte_val(entry));
+
+	/*
+	 * Setting the access flag on a writable entry must be done atomically
+	 * to avoid racing with the hardware update of the dirty state.
+	 */
+	asm volatile("//	ptep_set_access_flags\n"
+	"	prfm	pstl1strm, %2\n"
+	"1:	ldxr	%0, %2\n"
+	"	orr	%0, %0, %3		// set PTE_AF\n"
+	"	stxr	%w1, %0, %2\n"
+	"	cbnz	%w1, 1b\n"
+	: "=&r" (entry), "=&r" (tmp), "+Q" (pte_val(*ptep))
+	: "L" (PTE_AF));
+
+flush:
+	flush_tlb_fix_spurious_fault(vma, address);
+	return 1;
+}
+#endif
+
 /*
  * The kernel tried to access some page that wasn't present.
  */
