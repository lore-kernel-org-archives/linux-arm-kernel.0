From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  2 Nov 2017 10:21:21 +0100
Subject: [PATCH] ARM: NOMMU: work around maybe-uninitialized warning
Message-ID: <20171102092155.737712-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The reworked MPU code produces a new warning in some configurations,
presumably starting with the code move after the compiler now makes
different inlining decisions:

arch/arm/mm/pmsa-v7.c: In function 'adjust_lowmem_bounds_mpu':
arch/arm/mm/pmsa-v7.c:310:5: error: 'specified_mem_size' may be used uninitialized in this function [-Werror=maybe-uninitialized]

This appears to be harmless, as we know that there is always at
least one memblock, and the only way this could get triggered is
if the for_each_memblock() loop was never entered.

I could not come up with a better workaround than initializing
the specified_mem_size to zero, but at least that is the value
that the variable would have in the hypothetical case of no
memblocks.

Fixes: 877ec119dbbf ("ARM: 8706/1: NOMMU: Move out MPU setup in separate module")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Vladimir, if this looks good to you, can you forward it to Russell's
patch tracker, or otherwise suggest a different fix?
---
 arch/arm/mm/pmsa-v7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/pmsa-v7.c b/arch/arm/mm/pmsa-v7.c
index 106ae1c435a3..976df60ac426 100644
--- a/arch/arm/mm/pmsa-v7.c
+++ b/arch/arm/mm/pmsa-v7.c
@@ -234,7 +234,7 @@ static int __init allocate_region(phys_addr_t base, phys_addr_t size,
 /* MPU initialisation functions */
 void __init adjust_lowmem_bounds_mpu(void)
 {
-	phys_addr_t  specified_mem_size, total_mem_size = 0;
+	phys_addr_t  specified_mem_size = 0, total_mem_size = 0;
 	struct memblock_region *reg;
 	bool first = true;
 	phys_addr_t mem_start;
-- 
2.9.0
