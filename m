From: labbott@fedoraproject.org (Laura Abbott)
Date: Thu,  4 Jun 2015 12:15:49 -0700
Subject: [PATCH] arm: Update memblock limit after mapping lowmem
Message-ID: <1433445349-12497-1-git-send-email-labbott@fedoraproject.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The memblock limit is currently used in find_limits
to find the bounds for ZONE_NORMAL. The memblock
limit may need to be rounded down a PMD size to ensure
allocations are fully mapped though. This has the side
effect of reducing the amount of memory in ZONE_NORMAL.
Once all lowmem is mapped, it's safe to change the memblock
limit back to include the unaligned section. Adjust the
memblock limit after lowmem mapping is complete.

Before:
 # cat /proc/zoneinfo | grep managed
        managed  62907
        managed  424

After:
 # cat /proc/zoneinfo | grep managed
        managed  63331

Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
---
This is a replacement for
'arm: Don't use memblock limit for the lowmem bound' which
doesn't actually work on NOMMU systems.
---
 arch/arm/mm/mmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 7186382..904d153 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1519,6 +1519,7 @@ void __init paging_init(const struct machine_desc *mdesc)
 	build_mem_type_table();
 	prepare_page_table();
 	map_lowmem();
+	memblock_set_current_limit(arm_lowmem_limit);
 	dma_contiguous_remap();
 	devicemaps_init(mdesc);
 	kmap_init();
-- 
2.4.1
