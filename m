From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 14 Oct 2015 12:20:26 +0100
Subject: [PATCHv3 03/11] arm64: Introduce helpers for page table levels
In-Reply-To: <1444821634-1689-1-git-send-email-suzuki.poulose@arm.com>
References: <1444821634-1689-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1444821634-1689-4-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce helpers for finding the number of page table
levels required for a given VA width, shift for a particular
page table level.

Convert the existing users to the new helpers. More users
to follow.

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>

---
Changes since V2:
  - Add comments around the macros
  - Change ARM64_HW_PGTABLE_LEVEL_SHIFT to accept pagetable level as
    described by ARM ARM
---
 arch/arm64/include/asm/pgtable-hwdef.h |   25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 95c1ec0..c6194ab 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -16,13 +16,31 @@
 #ifndef __ASM_PGTABLE_HWDEF_H
 #define __ASM_PGTABLE_HWDEF_H
 
+/*
+ * Number of page-table levels required to address 'va_bits' wide
+ * address, without section mapping. We resolve the top (va_bits - PAGE_SHIFT)
+ * bits with (PAGE_SHIFT - 3) bits at each page table level. Hence:
+ *
+ *  levels = DIV_ROUND_UP((va_bits - PAGE_SHIFT), (PAGE_SHIFT - 3))
+ *
+ * We cannot include linux/kernel.h which defines DIV_ROUND_UP here
+ * due to build issues. So we use the following magic formula.
+ */
+#define ARM64_HW_PGTABLE_LEVELS(va_bits) (((va_bits) - 4) / (PAGE_SHIFT - 3))
+
+/*
+ * Size mapped by an entry at level n
+ * We map PAGE_SHIFT - 3 at all levels, except the PAGE_SHIFT bits at the last level
+ */
+#define ARM64_HW_PGTABLE_LEVEL_SHIFT(n)	((PAGE_SHIFT - 3) * (4 - (n)) + 3)
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
@@ -32,7 +50,7 @@
  * PUD_SHIFT determines the size a level 1 page table entry can map.
  */
 #if CONFIG_PGTABLE_LEVELS > 3
-#define PUD_SHIFT		((PAGE_SHIFT - 3) * 3 + 3)
+#define PUD_SHIFT		ARM64_HW_PGTABLE_LEVEL_SHIFT(1)
 #define PUD_SIZE		(_AC(1, UL) << PUD_SHIFT)
 #define PUD_MASK		(~(PUD_SIZE-1))
 #define PTRS_PER_PUD		PTRS_PER_PTE
@@ -42,7 +60,8 @@
  * PGDIR_SHIFT determines the size a top-level page table entry can map
  * (depending on the configuration, this level can be 0, 1 or 2).
  */
-#define PGDIR_SHIFT		((PAGE_SHIFT - 3) * CONFIG_PGTABLE_LEVELS + 3)
+#define PGDIR_SHIFT	\
+		ARM64_HW_PGTABLE_LEVEL_SHIFT(4 - CONFIG_PGTABLE_LEVELS)
 #define PGDIR_SIZE		(_AC(1, UL) << PGDIR_SHIFT)
 #define PGDIR_MASK		(~(PGDIR_SIZE-1))
 #define PTRS_PER_PGD		(1 << (VA_BITS - PGDIR_SHIFT))
-- 
1.7.9.5
