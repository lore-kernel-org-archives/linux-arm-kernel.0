From: chenzhou10@huawei.com (Chen Zhou)
Date: Sun, 20 May 2018 20:20:39 +0800
Subject: [PATCH] arm64: kdump: fix out of memory issue in __alloc_bootmem_low
Message-ID: <1526818839-8497-1-git-send-email-chenzhou10@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mao Wenan <maowenan@huawei.com>

On arm64 kdump capture kernel, ACPI runtime code and data are outside
of usable memory range and __alloc_bootmem_low may alloc memory below
4G. If we use "crashkernel=Y[@X]" and the start address is above 4G,
there will be out of memory.

In this patch, we get max_zone_dma_phys by memblock_start_of_DRAM
and __pa_symbol(_end).

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 arch/arm64/mm/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 1b18b47..df4d212 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -223,7 +223,8 @@ static void __init reserve_elfcorehdr(void)
  */
 static phys_addr_t __init max_zone_dma_phys(void)
 {
-	phys_addr_t offset = memblock_start_of_DRAM() & GENMASK_ULL(63, 32);
+	phys_addr_t offset = max(memblock_start_of_DRAM(), __pa_symbol(_end)) &
+		GENMASK_ULL(63, 32);
 	return min(offset + (1ULL << 32), memblock_end_of_DRAM());
 }
 
-- 
1.8.3
