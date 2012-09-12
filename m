From: r.sricharan@ti.com (R Sricharan)
Date: Wed, 12 Sep 2012 12:44:13 +0530
Subject: [PATCH V2] ARM: OMAP2+: Round of the carve out memory requested to
 section_size
Message-ID: <1347434053-11431-1-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

memblock_steal tries to reserve physical memory during boot.
When the requested size is not aligned on the section size
then, the remaining memory available for lowmem becomes
unaligned on the section boundary. There is a issue with this,
which is discussed in the thread below.

https://lkml.org/lkml/2012/6/28/112

The final conclusion from the thread seems to
be align the memblock_steal calls on the SECTION boundary.
The issue comes out when LPAE is enabled, where the
section size is 2MB.

Boot tested this on OMAP5 evm with and without LPAE.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
---
 [V2] Corrected the subject and added one more description line.

 arch/arm/mach-omap2/omap-secure.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-secure.c b/arch/arm/mach-omap2/omap-secure.c
index d9ae4a5..26edfec 100644
--- a/arch/arm/mach-omap2/omap-secure.c
+++ b/arch/arm/mach-omap2/omap-secure.c
@@ -61,8 +61,8 @@ int __init omap_secure_ram_reserve_memblock(void)
 {
 	u32 size = OMAP_SECURE_RAM_STORAGE;
 
-	size = ALIGN(size, SZ_1M);
-	omap_secure_memblock_base = arm_memblock_steal(size, SZ_1M);
+	size = ALIGN(size, SECTION_SIZE);
+	omap_secure_memblock_base = arm_memblock_steal(size, SECTION_SIZE);
 
 	return 0;
 }
-- 
1.7.9.5
