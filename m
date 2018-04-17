From: zhangshaokun@hisilicon.com (Shaokun Zhang)
Date: Tue, 17 Apr 2018 20:03:09 +0800
Subject: [PATCH] arm64: mm: drop addr parameter from sync icache and dcache
Message-ID: <1523966589-62603-1-git-send-email-zhangshaokun@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The addr parameter isn't used for anything. Let's simplify and get rid of
it, like arm.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 arch/arm64/include/asm/pgtable.h | 4 ++--
 arch/arm64/mm/flush.c            | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 7e2c27e..7c4c8f3 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -230,7 +230,7 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
 	}
 }
 
-extern void __sync_icache_dcache(pte_t pteval, unsigned long addr);
+extern void __sync_icache_dcache(pte_t pteval);
 
 /*
  * PTE bits configuration in the presence of hardware Dirty Bit Management
@@ -253,7 +253,7 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 	pte_t old_pte;
 
 	if (pte_present(pte) && pte_user_exec(pte) && !pte_special(pte))
-		__sync_icache_dcache(pte, addr);
+		__sync_icache_dcache(pte);
 
 	/*
 	 * If the existing pte is valid, check for potential race with
diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index e36ed50..1059884 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -58,7 +58,7 @@ void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
 	flush_ptrace_access(vma, page, uaddr, dst, len);
 }
 
-void __sync_icache_dcache(pte_t pte, unsigned long addr)
+void __sync_icache_dcache(pte_t pte)
 {
 	struct page *page = pte_page(pte);
 
-- 
2.7.4
