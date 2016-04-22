From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri, 22 Apr 2016 12:43:34 +0100
Subject: [PATCH 1/3] ARM: nommu: fix PMSAv7 setup
In-Reply-To: <1461325416-29570-1-git-send-email-vladimir.murzin@arm.com>
References: <1461325416-29570-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1461325416-29570-2-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

Commit 1c2f87c (ARM: 8025/1: Get rid of meminfo) broke the support for
MPU on ARMv7-R. This patch adapts the code inside CONFIG_ARM_MPU to use
memblocks appropriately.

MPU initialisation only uses the first memory region, and removes all
subsequent ones. Because looping over all regions that need removal is
inefficient, and memblock_remove already handles memory ranges, we can
flatten the 'for_each_memblock' part.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/mm/nommu.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 1dd1093..4d113fc 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -87,7 +87,6 @@ static unsigned long irbar_read(void)
 /* MPU initialisation functions */
 void __init sanity_check_meminfo_mpu(void)
 {
-	int i;
 	phys_addr_t phys_offset = PHYS_OFFSET;
 	phys_addr_t aligned_region_size, specified_mem_size, rounded_mem_size;
 	struct memblock_region *reg;
@@ -110,11 +109,13 @@ void __init sanity_check_meminfo_mpu(void)
 		} else {
 			/*
 			 * memblock auto merges contiguous blocks, remove
-			 * all blocks afterwards
+			 * all blocks afterwards in one go (we can't remove
+			 * blocks separately while iterating)
 			 */
 			pr_notice("Ignoring RAM after %pa, memory at %pa ignored\n",
-				  &mem_start, &reg->base);
-			memblock_remove(reg->base, reg->size);
+				  &mem_end, &reg->base);
+			memblock_remove(reg->base, 0 - reg->base);
+			break;
 		}
 	}
 
@@ -144,7 +145,7 @@ void __init sanity_check_meminfo_mpu(void)
 		pr_warn("Truncating memory from %pa to %pa (MPU region constraints)",
 				&specified_mem_size, &aligned_region_size);
 		memblock_remove(mem_start + aligned_region_size,
-				specified_mem_size - aligned_round_size);
+				specified_mem_size - aligned_region_size);
 
 		mem_end = mem_start + aligned_region_size;
 	}
@@ -261,7 +262,7 @@ void __init mpu_setup(void)
 		return;
 
 	region_err = mpu_setup_region(MPU_RAM_REGION, PHYS_OFFSET,
-					ilog2(meminfo.bank[0].size),
+					ilog2(memblock.memory.regions[0].size),
 					MPU_AP_PL1RW_PL0RW | MPU_RGN_NORMAL);
 	if (region_err) {
 		panic("MPU region initialization failure! %d", region_err);
-- 
1.7.9.5
