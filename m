From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 11 Sep 2015 18:22:00 +0100
Subject: [PATCH 1/3] arm64: Fix the pte_hw_dirty() check when AF/DBM is enabled
In-Reply-To: <1441992122-19888-1-git-send-email-catalin.marinas@arm.com>
References: <1441992122-19888-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1441992122-19888-2-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 2f4b829c625e (arm64: Add support for hardware updates of the
access and dirty pte bits) introduced support for handling hardware
updates of the access flag and dirty status. The PTE is automatically
dirtied in hardware (if supported) by clearing the PTE_RDONLY bit when
the PTE_DBM/PTE_WRITE bit is set. The pte_hw_dirty() macro was added to
detect a hardware dirtied pte. The pte_dirty() macro checks for both
software PTE_DIRTY and pte_hw_dirty().

Functions like pte_modify() clear the PTE_RDONLY bit since it is meant
to be set in set_pte_at() when written to memory. In such cases,
pte_hw_dirty() would return true even though such pte is clean. This
patch changes pte_hw_dirty() to test the PTE_DBM/PTE_WRITE bit together
with PTE_RDONLY.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Julien Grall <julien.grall@citrix.com>
Cc: Will Deacon <will.deacon@arm.com>
Fixes: 2f4b829c625e ("arm64: Add support for hardware updates of the access and dirty pte bits")
---
 arch/arm64/include/asm/pgtable.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 6900b2d95371..69207f016891 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -146,7 +146,7 @@ extern struct page *empty_zero_page;
 #define pte_exec(pte)		(!(pte_val(pte) & PTE_UXN))
 
 #ifdef CONFIG_ARM64_HW_AFDBM
-#define pte_hw_dirty(pte)	(!(pte_val(pte) & PTE_RDONLY))
+#define pte_hw_dirty(pte)	(pte_write(pte) && !(pte_val(pte) & PTE_RDONLY))
 #else
 #define pte_hw_dirty(pte)	(0)
 #endif
@@ -238,7 +238,7 @@ extern void __sync_icache_dcache(pte_t pteval, unsigned long addr);
  * When hardware DBM is not present, the sofware PTE_DIRTY bit is updated via
  * the page fault mechanism. Checking the dirty status of a pte becomes:
  *
- *   PTE_DIRTY || !PTE_RDONLY
+ *   PTE_DIRTY || (PTE_WRITE && !PTE_RDONLY)
  */
 static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep, pte_t pte)
