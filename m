From: kyle.roeschley@ni.com (Kyle Roeschley)
Date: Mon, 31 Oct 2016 11:26:17 -0500
Subject: [PATCH] ARM: zynq: Reserve correct amount of non-DMA RAM
Message-ID: <20161031162617.10565-1-kyle.roeschley@ni.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Zynq, we haven't been reserving the correct amount of DMA-incapable
RAM to keep DMA away from it (per the Zynq TRM Section 4.1, it should be
the first 512k). In older kernels, this was masked by the
memblock_reserve call in arm_memblock_init(). Now, reserve the correct
amount excplicitly rather than relying on swapper_pg_dir, which is an
address and not a size anyway.

Fixes: 46f5b96 ("ARM: zynq: Reserve not DMAable space in front of the
kernel")

Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
---
Found when migrating from 4.1 to 4.6.

 arch/arm/mach-zynq/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 6cefdb8..75885bc 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -59,7 +59,7 @@ void __iomem *zynq_scu_base;
 static void __init zynq_memory_init(void)
 {
 	if (!__pa(PAGE_OFFSET))
-		memblock_reserve(__pa(PAGE_OFFSET), __pa(swapper_pg_dir));
+		memblock_reserve(__pa(PAGE_OFFSET), 0x80000);
 }
 
 static struct platform_device zynq_cpuidle_device = {
-- 
2.9.3
