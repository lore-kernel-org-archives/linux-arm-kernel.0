From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 19 Oct 2015 14:19:30 +0100
Subject: [PATCHv4 04/12] arm64: Calculate size for idmap_pg_dir at compile time
In-Reply-To: <1445260779-22242-1-git-send-email-suzuki.poulose@arm.com>
References: <1445260779-22242-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1445260779-22242-5-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we can calculate the number of levels required for
mapping a va width, reserve exact number of pages that would
be required to cover the idmap. The idmap should be able to handle
the maximum physical address size supported.

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/kernel-pgtable.h |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
index 4e08faa..a459714 100644
--- a/arch/arm64/include/asm/kernel-pgtable.h
+++ b/arch/arm64/include/asm/kernel-pgtable.h
@@ -39,16 +39,19 @@
  * map to pte level. The swapper also maps the FDT (see __create_page_tables
  * for more information). Note that the number of ID map translation levels
  * could be increased on the fly if system RAM is out of reach for the default
- * VA range, so 3 pages are reserved in all cases.
+ * VA range, so pages required to map highest possible PA are reserved in all
+ * cases.
  */
 #if ARM64_SWAPPER_USES_SECTION_MAPS
 #define SWAPPER_PGTABLE_LEVELS	(CONFIG_PGTABLE_LEVELS - 1)
+#define IDMAP_PGTABLE_LEVELS	(ARM64_HW_PGTABLE_LEVELS(PHYS_MASK_SHIFT) - 1)
 #else
 #define SWAPPER_PGTABLE_LEVELS	(CONFIG_PGTABLE_LEVELS)
+#define IDMAP_PGTABLE_LEVELS	(ARM64_HW_PGTABLE_LEVELS(PHYS_MASK_SHIFT))
 #endif
 
 #define SWAPPER_DIR_SIZE	(SWAPPER_PGTABLE_LEVELS * PAGE_SIZE)
-#define IDMAP_DIR_SIZE		(3 * PAGE_SIZE)
+#define IDMAP_DIR_SIZE		(IDMAP_PGTABLE_LEVELS * PAGE_SIZE)
 
 /* Initial memory map size */
 #if ARM64_SWAPPER_USES_SECTION_MAPS
-- 
1.7.9.5
