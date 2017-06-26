From: opendmb@gmail.com (Doug Berger)
Date: Mon, 26 Jun 2017 10:23:15 -0700
Subject: [PATCH] ARM: memblock limit must be pmd-aligned
Message-ID: <20170626172315.26369-1-opendmb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a path through the adjust_lowmem_bounds() routine where if all
memory regions start and end on pmd-aligned addresses the memblock_limit
will be set to arm_lowmem_limit.

However, since arm_lowmem_limit can be affected by the vmalloc early
parameter, the value of arm_lowmem_limit may not be pmd-aligned. This
commit corrects this oversight such that memblock_limit is always rounded
down to pmd-alignment.

The pmd containing arm_lowmem_limit is cleared by prepare_page_table()
and without this commit it is possible for early_alloc() to allocate
unmapped memory in that range when mapping the lowmem.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 arch/arm/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 31af3cb59a60..2ae4f9c9d757 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1226,7 +1226,7 @@ void __init adjust_lowmem_bounds(void)
 	if (memblock_limit)
 		memblock_limit = round_down(memblock_limit, PMD_SIZE);
 	if (!memblock_limit)
-		memblock_limit = arm_lowmem_limit;
+		memblock_limit = round_down(arm_lowmem_limit, PMD_SIZE);
 
 	if (!IS_ENABLED(CONFIG_HIGHMEM) || cache_is_vipt_aliasing()) {
 		if (memblock_end_of_DRAM() > arm_lowmem_limit) {
-- 
2.13.0
