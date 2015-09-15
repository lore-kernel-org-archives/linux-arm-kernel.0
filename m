From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 15 Sep 2015 16:41:12 +0100
Subject: [PATCH 03/15] arm64: Introduce helpers for page table levels
In-Reply-To: <1442331684-28818-1-git-send-email-suzuki.poulose@arm.com>
References: <1442331684-28818-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1442331684-28818-4-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

Introduce helpers for finding the number of page table
levels required for a given VA width, shift for a particular
page table level.

Convert the existing users to the new helpers. More users
to follow.

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/pgtable-hwdef.h |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 24154b0..ce18389 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -16,13 +16,21 @@
 #ifndef __ASM_PGTABLE_HWDEF_H
 #define __ASM_PGTABLE_HWDEF_H
 
+/*
+ * Number of page-table levels required to address 'va_bits' wide
+ * address, without section mapping
+ */
+#define ARM64_HW_PGTABLE_LEVELS(va_bits) (((va_bits) - 4) / (PAGE_SHIFT - 3))
+#define ARM64_HW_PGTABLE_LEVEL_SHIFT(level) \
+		((PAGE_SHIFT - 3) * (level) + 3)
+
 #define PTRS_PER_PTE		(1 << (PAGE_SHIFT - 3))
 
 /*
  * PMD_SHIFT determines the size a level 2 page table entry can map.
  */
 #if CONFIG_PGTABLE_LEVELS > 2
-#define PMD_SHIFT		((PAGE_SHIFT - 3) * 2 + 3)
+#define PMD_SHIFT		ARM64_HW_PGTABLE_LEVEL_SHIFT(2)
 #define PMD_SIZE		(_AC(1, UL) << PMD_SHIFT)
 #define PMD_MASK		(~(PMD_SIZE-1))
 #define PTRS_PER_PMD		PTRS_PER_PTE
@@ -32,7 +40,7 @@
  * PUD_SHIFT determines the size a level 1 page table entry can map.
  */
 #if CONFIG_PGTABLE_LEVELS > 3
-#define PUD_SHIFT		((PAGE_SHIFT - 3) * 3 + 3)
+#define PUD_SHIFT		ARM64_HW_PGTABLE_LEVEL_SHIFT(3)
 #define PUD_SIZE		(_AC(1, UL) << PUD_SHIFT)
 #define PUD_MASK		(~(PUD_SIZE-1))
 #define PTRS_PER_PUD		PTRS_PER_PTE
@@ -42,7 +50,8 @@
  * PGDIR_SHIFT determines the size a top-level page table entry can map
  * (depending on the configuration, this level can be 0, 1 or 2).
  */
-#define PGDIR_SHIFT		((PAGE_SHIFT - 3) * CONFIG_PGTABLE_LEVELS + 3)
+#define PGDIR_SHIFT	\
+		ARM64_HW_PGTABLE_LEVEL_SHIFT(CONFIG_PGTABLE_LEVELS)
 #define PGDIR_SIZE		(_AC(1, UL) << PGDIR_SHIFT)
 #define PGDIR_MASK		(~(PGDIR_SIZE-1))
 #define PTRS_PER_PGD		(1 << (VA_BITS - PGDIR_SHIFT))
-- 
1.7.9.5
