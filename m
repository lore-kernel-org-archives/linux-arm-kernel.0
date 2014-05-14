From: wangnan0@huawei.com (Wang Nan)
Date: Wed, 14 May 2014 14:03:59 +0800
Subject: [PATCH] arm: mm: fix lowmem virtual address range check
Message-ID: <1400047439-23961-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes sure the argument of __phys_to_virt is a valid physical
address when clear lowmem memory maps.

The last few lines prepare_page_table() clear page mapping in the gap
between largest low physical memory and the upper bound of lowmem. It
uses __phys_to_virt(end) to calculate virtual address from where the
clearing start.

However, if the platform uses private nonliner __phys_to_virt(), 'end'
may goes into another mapping region.

This patch uses __phys_to_virt(end - 1) + 1 for insurance purposes.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Cc: Geng Hui <hui.geng@huawei.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index b68c6b2..87340ee 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1217,7 +1217,7 @@ static inline void prepare_page_table(void)
 	 * Clear out all the kernel space mappings, except for the first
 	 * memory bank, up to the vmalloc region.
 	 */
-	for (addr = __phys_to_virt(end);
+	for (addr = __phys_to_virt(end - 1) + 1;
 	     addr < VMALLOC_START; addr += PMD_SIZE)
 		pmd_clear(pmd_off_k(addr));
 }
-- 
1.8.4
