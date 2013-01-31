From: cyril@ti.com (Cyril Chemparathy)
Date: Thu, 31 Jan 2013 16:58:23 -0500
Subject: [PATCH v4 04/13] ARM: LPAE: use phys_addr_t for initrd location
In-Reply-To: <1359669512-31276-1-git-send-email-cyril@ti.com>
References: <1359669512-31276-1-git-send-email-cyril@ti.com>
Message-ID: <1359669512-31276-5-git-send-email-cyril@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vitaly Andrianov <vitalya@ti.com>

This patch fixes the initrd setup code to use phys_addr_t instead of assuming
32-bit addressing.  Without this we cannot boot on systems where initrd is
located above the 4G physical address limit.

Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
Signed-off-by: Cyril Chemparathy <cyril@ti.com>
Acked-by: Nicolas Pitre <nico@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/init.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 1c5151a..87ee0ec 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -36,12 +36,13 @@
 
 #include "mm.h"
 
-static unsigned long phys_initrd_start __initdata = 0;
+static phys_addr_t phys_initrd_start __initdata = 0;
 static unsigned long phys_initrd_size __initdata = 0;
 
 static int __init early_initrd(char *p)
 {
-	unsigned long start, size;
+	phys_addr_t start;
+	unsigned long size;
 	char *endp;
 
 	start = memparse(p, &endp);
@@ -347,14 +348,14 @@ void __init arm_memblock_init(struct meminfo *mi, struct machine_desc *mdesc)
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (phys_initrd_size &&
 	    !memblock_is_region_memory(phys_initrd_start, phys_initrd_size)) {
-		pr_err("INITRD: 0x%08lx+0x%08lx is not a memory region - disabling initrd\n",
-		       phys_initrd_start, phys_initrd_size);
+		pr_err("INITRD: 0x%08llx+0x%08lx is not a memory region - disabling initrd\n",
+		       (u64)phys_initrd_start, phys_initrd_size);
 		phys_initrd_start = phys_initrd_size = 0;
 	}
 	if (phys_initrd_size &&
 	    memblock_is_region_reserved(phys_initrd_start, phys_initrd_size)) {
-		pr_err("INITRD: 0x%08lx+0x%08lx overlaps in-use memory region - disabling initrd\n",
-		       phys_initrd_start, phys_initrd_size);
+		pr_err("INITRD: 0x%08llx+0x%08lx overlaps in-use memory region - disabling initrd\n",
+		       (u64)phys_initrd_start, phys_initrd_size);
 		phys_initrd_start = phys_initrd_size = 0;
 	}
 	if (phys_initrd_size) {
-- 
1.7.9.5
