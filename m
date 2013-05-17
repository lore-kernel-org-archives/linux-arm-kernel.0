From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 May 2013 18:07:52 +0100
Subject: [PATCH 13/14] ARM: lpae: fix definition of PTE_HWTABLE_PTRS
In-Reply-To: <1368810473-26070-1-git-send-email-will.deacon@arm.com>
References: <1368810473-26070-1-git-send-email-will.deacon@arm.com>
Message-ID: <1368810473-26070-14-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For 2-level page tables, PTE_HWTABLE_PTRS describes the offset between
Linux PTEs and hardware PTEs. On LPAE, there is no distinction (since
we have 64-bit descriptors with plenty of space) so PTE_HWTABLE_PTRS
should be 0. Unfortunately, it is wrongly defined as PTRS_PER_PTE,
meaning that current pte table flushing is off by a page. Luckily,
all current LPAE implementations are SMP, so the hardware walker can
snoop L1.

This patch fixes the broken definition.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/pgtable-3level.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 5b85b21..d03c589 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -33,7 +33,7 @@
 #define PTRS_PER_PMD		512
 #define PTRS_PER_PGD		4
 
-#define PTE_HWTABLE_PTRS	(PTRS_PER_PTE)
+#define PTE_HWTABLE_PTRS	(0)
 #define PTE_HWTABLE_OFF		(0)
 #define PTE_HWTABLE_SIZE	(PTRS_PER_PTE * sizeof(u64))
 
-- 
1.8.2.2
