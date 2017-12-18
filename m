From: steve.capper@arm.com (Steve Capper)
Date: Mon, 18 Dec 2017 21:47:33 +0000
Subject: [PATCH V2 4/7] arm64: mm: Replace fixed map BUILD_BUG_ON's with
 BUG_ON's
In-Reply-To: <20171218214736.13761-1-steve.capper@arm.com>
References: <20171218214736.13761-1-steve.capper@arm.com>
Message-ID: <20171218214736.13761-5-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to prepare for a variable VA_BITS we need to account for a
variable size VMEMMAP which in turn means the position of the fixed map
is variable at compile time.

Thus, we need to replace the BUILD_BUG_ON's that check the fixed map
position with BUG_ON's.

Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm64/mm/mmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 5a16e2b9b1a2..7c04479a809a 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -760,7 +760,7 @@ void __init early_fixmap_init(void)
 	 * The boot-ioremap range spans multiple pmds, for which
 	 * we are not prepared:
 	 */
-	BUILD_BUG_ON((__fix_to_virt(FIX_BTMAP_BEGIN) >> PMD_SHIFT)
+	BUG_ON((__fix_to_virt(FIX_BTMAP_BEGIN) >> PMD_SHIFT)
 		     != (__fix_to_virt(FIX_BTMAP_END) >> PMD_SHIFT));
 
 	if ((pmd != fixmap_pmd(fix_to_virt(FIX_BTMAP_BEGIN)))
@@ -828,9 +828,9 @@ void *__init __fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
 	 * On 4k pages, we'll use section mappings for the FDT so we only
 	 * have to be in the same PUD.
 	 */
-	BUILD_BUG_ON(dt_virt_base % SZ_2M);
+	BUG_ON(dt_virt_base % SZ_2M);
 
-	BUILD_BUG_ON(__fix_to_virt(FIX_FDT_END) >> SWAPPER_TABLE_SHIFT !=
+	BUG_ON(__fix_to_virt(FIX_FDT_END) >> SWAPPER_TABLE_SHIFT !=
 		     __fix_to_virt(FIX_BTMAP_BEGIN) >> SWAPPER_TABLE_SHIFT);
 
 	offset = dt_phys % SWAPPER_BLOCK_SIZE;
-- 
2.11.0
