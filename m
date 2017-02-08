From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Wed, 08 Feb 2017 11:11:09 +0000
Subject: [PATCH 3/3] ARM: mm: round the initrd reservation to page boundaries
In-Reply-To: <20170208111024.GV27312@n2100.armlinux.org.uk>
References: <20170208111024.GV27312@n2100.armlinux.org.uk>
Message-ID: <E1cbQ9V-0003th-DG@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Round the initrd memblock reservation to page boundaries to prevent
other data sharing the initrd pages.  This prevents an allocation
possibly overlapping with the initrd, which would later get trampled
on in free_initrd_mem().

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mm/init.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 15739a95552a..d1e26610977d 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -231,6 +231,9 @@ phys_addr_t __init arm_memblock_steal(phys_addr_t size, phys_addr_t align)
 static void __init arm_initrd_init(void)
 {
 #ifdef CONFIG_BLK_DEV_INITRD
+	phys_addr_t start;
+	unsigned long size;
+
 	/* FDT scan will populate initrd_start */
 	if (initrd_start && !phys_initrd_size) {
 		phys_initrd_start = __virt_to_phys(initrd_start);
@@ -242,19 +245,29 @@ static void __init arm_initrd_init(void)
 	if (!phys_initrd_size)
 		return;
 
-	if (!memblock_is_region_memory(phys_initrd_start, phys_initrd_size)) {
+	/*
+	 * Round the memory region to page boundaries as per free_initrd_mem()
+	 * This allows us to detect whether the pages overlapping the initrd
+	 * are in use, but more importantly, reserves the entire set of pages
+	 * as we don't want these pages allocated for other purposes.
+	 */
+	start = round_down(phys_initrd_start, PAGE_SIZE);
+	size = phys_initrd_size + (phys_initrd_start - start);
+	size = round_up(size, PAGE_SIZE);
+
+	if (!memblock_is_region_memory(start, size)) {
 		pr_err("INITRD: 0x%08llx+0x%08lx is not a memory region - disabling initrd\n",
-		       (u64)phys_initrd_start, phys_initrd_size);
+		       (u64)start, size);
 		return;
 	}
 
-	if (memblock_is_region_reserved(phys_initrd_start, phys_initrd_size)) {
+	if (memblock_is_region_reserved(start, size)) {
 		pr_err("INITRD: 0x%08llx+0x%08lx overlaps in-use memory region - disabling initrd\n",
-		       (u64)phys_initrd_start, phys_initrd_size);
+		       (u64)start, size);
 		return;
 	}
 
-	memblock_reserve(phys_initrd_start, phys_initrd_size);
+	memblock_reserve(start, size);
 
 	/* Now convert initrd to virtual addresses */
 	initrd_start = __phys_to_virt(phys_initrd_start);
-- 
2.7.4
