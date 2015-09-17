From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Sep 2015 13:50:19 +0100
Subject: [PATCH 10/10] arm64: mm: remove dsb from update_mmu_cache
In-Reply-To: <1442494219-6133-1-git-send-email-will.deacon@arm.com>
References: <1442494219-6133-1-git-send-email-will.deacon@arm.com>
Message-ID: <1442494219-6133-11-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

update_mmu_cache() consists of a dsb(ishst) instruction so that new user
mappings are guaranteed to be visible to the page table walker on
exception return.

In reality this can be a very expensive operation which is rarely needed.
Removing this barrier shows a modest improvement in hackbench scores and
, in the worst case, we re-take the user fault and establish that there
was nothing to do.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 6900b2d95371..7be3c16d8545 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -650,10 +650,10 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
 				    unsigned long addr, pte_t *ptep)
 {
 	/*
-	 * set_pte() does not have a DSB for user mappings, so make sure that
-	 * the page table write is visible.
+	 * We don't do anything here, so there's a very small chance of
+	 * us retaking a user fault which we just fixed up. The alternative
+	 * is doing a dsb(ishst), but that penalises the fastpath.
 	 */
-	dsb(ishst);
 }
 
 #define update_mmu_cache_pmd(vma, address, pmd) do { } while (0)
-- 
2.1.4
