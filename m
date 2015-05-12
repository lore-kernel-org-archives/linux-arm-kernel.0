From: labbott@fedoraproject.org (Laura Abbott)
Date: Mon, 11 May 2015 19:53:41 -0700
Subject: [PATCH] arm: Don't use memblock limit for the lowmem bound
Message-ID: <1431399221-25337-1-git-send-email-labbott@fedoraproject.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laura Abbott <labbott@redhat.com>

The memblock limit is currently used in find_limits
to find the bounds for ZONE_NORMAL. The memblock
limit may need to be rounded down a PMD size to ensure
allocations are fully mapped though. This has the side
effect of reducing the amount of memory in ZONE_NORMAL.
Since we generally want to optimize for more lowmem, fix
this by using arm_lowmem_limit to calculate the bounds.
This what is used for actually mapping lowmem anyway.

Before:
# cat /proc/zoneinfo | grep managed
        managed  62920

After:
# cat /proc/zoneinfo | grep managed
        managed  63336



Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 arch/arm/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index be92fa0..b4f9513 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -89,7 +89,7 @@ __tagtable(ATAG_INITRD2, parse_tag_initrd2);
 static void __init find_limits(unsigned long *min, unsigned long *max_low,
 			       unsigned long *max_high)
 {
-	*max_low = PFN_DOWN(memblock_get_current_limit());
+	*max_low = PFN_DOWN(arm_lowmem_limit);
 	*min = PFN_UP(memblock_start_of_DRAM());
 	*max_high = PFN_DOWN(memblock_end_of_DRAM());
 }
-- 
2.1.0
