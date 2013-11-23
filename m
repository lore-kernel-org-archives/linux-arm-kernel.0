From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 23 Nov 2013 18:34:12 -0500
Subject: [PATCH 2/3] ARM: mm: Don't allow resizing of memblock data until
 "low" memory is not mapped
In-Reply-To: <1385249653-9250-1-git-send-email-santosh.shilimkar@ti.com>
References: <1385249653-9250-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1385249653-9250-3-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

If allowed by call to memblock_allow_resize() - The Memblock core will
try to allocate additional memory and rearrange its internal data in
case, if there are more then INIT_MEMBLOCK_REGIONS(128) memory regions
of any type have been allocated. If this happens before Low memory is
mapped (which is done now by map_lowmem()) the system will hang, because
the Memblock core will try to operate with virtual addresses which
aren't mapped yet.

In ARM code, the memblock resizing is allowed (memblock_allow_resize())
from arm_memblock_init() which is called before map_lowmem(), so
this may lead to an error as described above.

Hence, allow Memblock resizing later during init, from bootmem_init()
when all appropriate mappings are ready.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mm/init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 4c7bab4..ea66341 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -384,7 +384,6 @@ void __init arm_memblock_init(struct meminfo *mi,
 	dma_contiguous_reserve(min(arm_dma_limit, arm_lowmem_limit));
 
 	arm_memblock_steal_permitted = false;
-	memblock_allow_resize();
 	memblock_dump_all();
 }
 
@@ -392,6 +391,7 @@ void __init bootmem_init(void)
 {
 	unsigned long min, max_low, max_high;
 
+	memblock_allow_resize();
 	max_low = max_high = 0;
 
 	find_limits(&min, &max_low, &max_high);
-- 
1.7.9.5
