From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 23 Nov 2013 18:34:11 -0500
Subject: [PATCH 1/3] ARM: mm: Fix max_mapnr with recent max*pfn updates
In-Reply-To: <1385249653-9250-1-git-send-email-santosh.shilimkar@ti.com>
References: <1385249653-9250-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1385249653-9250-2-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With commit  26ba47b1 {ARM: 7805/1: mm: change max*pfn to include
the physical offset of memory}, the max_pfn already contain
PHYS_PFN_OFFSET, so it shouldn't be taken into account again.

While at it, use use set_max_mapnr() helper.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mm/init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 3e8f106..4c7bab4 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -587,7 +587,7 @@ void __init mem_init(void)
 	extern u32 itcm_end;
 #endif
 
-	max_mapnr   = pfn_to_page(max_pfn + PHYS_PFN_OFFSET) - mem_map;
+	set_max_mapnr(pfn_to_page(max_pfn) - mem_map);
 
 	/* this will put all unused low memory onto the freelists */
 	free_unused_memmap(&meminfo);
-- 
1.7.9.5
