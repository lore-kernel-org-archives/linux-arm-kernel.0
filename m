From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 27 Dec 2017 16:11:58 +0000
Subject: [PATCH] ARM: NOMMU: Make sure we do not hold stale data in mem[] array
Message-ID: <1514391118-4877-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

adjust_lowmem_bounds() called twice which can lead to stalled data
(i.e. subreg) value in mem[] array after the first call.

Zero out mem[] array before we allocate MPU regions for memory.

Fixes: 5c9d9a1b3a54 ("ARM: 8712/1: NOMMU: Use more MPU regions to cover memory")
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
KernelVersion: 4.15-rc1

 arch/arm/mm/pmsa-v7.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mm/pmsa-v7.c b/arch/arm/mm/pmsa-v7.c
index 976df60..f65c01f 100644
--- a/arch/arm/mm/pmsa-v7.c
+++ b/arch/arm/mm/pmsa-v7.c
@@ -6,6 +6,7 @@
 
 #include <linux/bitops.h>
 #include <linux/memblock.h>
+#include <linux/string.h>
 
 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
@@ -296,6 +297,7 @@ void __init adjust_lowmem_bounds_mpu(void)
 		}
 	}
 
+	memset(mem, 0, sizeof(mem));
 	num = allocate_region(mem_start, specified_mem_size, mem_max_regions, mem);
 
 	for (i = 0; i < num; i++) {
-- 
2.0.0
