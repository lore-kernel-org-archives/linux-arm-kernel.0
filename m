From: dima@android.com (Dima Zavin)
Date: Wed, 12 Jan 2011 14:35:57 -0800
Subject: [PATCH] ARM: use memblock memory regions for "System RAM" I/O
	resources
Message-ID: <1294871757-11391-1-git-send-email-dima@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do not use memory bank info to request the "system ram" resources as
they do not track holes created by memblock_remove inside
machine's reserve callback. If the removed memory is passed as
platform_device's ioresource, then drivers that call
request_mem_region would fail due to a conflict with the incorrectly
configured system ram resource.

Instead, iterate through the regions of memblock.memory and add
those as "System RAM" resources.

Signed-off-by: Dima Zavin <dima@android.com>
---
 arch/arm/kernel/setup.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 336f14e..c3aa394 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -520,6 +520,7 @@ setup_ramdisk(int doload, int prompt, int image_start, unsigned int rd_sz)
 static void __init
 request_standard_resources(struct meminfo *mi, struct machine_desc *mdesc)
 {
+	struct memblock_type *mem = &memblock.memory;
 	struct resource *res;
 	int i;
 
@@ -528,14 +529,11 @@ request_standard_resources(struct meminfo *mi, struct machine_desc *mdesc)
 	kernel_data.start   = virt_to_phys(_sdata);
 	kernel_data.end     = virt_to_phys(_end - 1);
 
-	for (i = 0; i < mi->nr_banks; i++) {
-		if (mi->bank[i].size == 0)
-			continue;
-
+	for (i = 0; i < mem->cnt; i++) {
 		res = alloc_bootmem_low(sizeof(*res));
 		res->name  = "System RAM";
-		res->start = mi->bank[i].start;
-		res->end   = mi->bank[i].start + mi->bank[i].size - 1;
+		res->start = mem->regions[i].base;
+		res->end   = mem->regions[i].base + mem->regions[i].size - 1;
 		res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
 
 		request_resource(&iomem_resource, res);
-- 
1.7.3.1
