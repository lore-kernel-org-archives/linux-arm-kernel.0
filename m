From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 8 Nov 2013 18:41:49 -0500
Subject: [PATCH 13/24] mm/power: Use memblock apis for early memory allocations
In-Reply-To: <1383954120-24368-1-git-send-email-santosh.shilimkar@ti.com>
References: <1383954120-24368-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1383954120-24368-14-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to memblock interfaces for early memory allocator instead of
bootmem allocator. No functional change in beahvior than what it is
in current code from bootmem users points of view.

Archs already converted to NO_BOOTMEM now directly use memblock
interfaces instead of bootmem wrappers build on top of memblock. And the
archs which still uses bootmem, these new apis just fallback to exiting
bootmem APIs.

Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm at vger.kernel.org

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 kernel/power/snapshot.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 358a146..887134e 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -637,7 +637,7 @@ __register_nosave_region(unsigned long start_pfn, unsigned long end_pfn,
 		BUG_ON(!region);
 	} else
 		/* This allocation cannot fail */
-		region = alloc_bootmem(sizeof(struct nosave_region));
+		region = memblock_virt_alloc(sizeof(struct nosave_region));
 	region->start_pfn = start_pfn;
 	region->end_pfn = end_pfn;
 	list_add_tail(&region->list, &nosave_regions);
-- 
1.7.9.5
