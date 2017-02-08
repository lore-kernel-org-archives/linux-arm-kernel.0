From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Wed, 08 Feb 2017 11:11:04 +0000
Subject: [PATCH 2/3] ARM: mm: clean up initrd initialisation
In-Reply-To: <20170208111024.GV27312@n2100.armlinux.org.uk>
References: <20170208111024.GV27312@n2100.armlinux.org.uk>
Message-ID: <E1cbQ9Q-0003tY-9P@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than repeatedly testing phys_initrd_size to see if the initrd
is still enabled, return from the new function to avoid executing the
remaining initialisation.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mm/init.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 43d8825e59bb..15739a95552a 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -236,26 +236,29 @@ static void __init arm_initrd_init(void)
 		phys_initrd_start = __virt_to_phys(initrd_start);
 		phys_initrd_size = initrd_end - initrd_start;
 	}
+
 	initrd_start = initrd_end = 0;
-	if (phys_initrd_size &&
-	    !memblock_is_region_memory(phys_initrd_start, phys_initrd_size)) {
+
+	if (!phys_initrd_size)
+		return;
+
+	if (!memblock_is_region_memory(phys_initrd_start, phys_initrd_size)) {
 		pr_err("INITRD: 0x%08llx+0x%08lx is not a memory region - disabling initrd\n",
 		       (u64)phys_initrd_start, phys_initrd_size);
-		phys_initrd_start = phys_initrd_size = 0;
+		return;
 	}
-	if (phys_initrd_size &&
-	    memblock_is_region_reserved(phys_initrd_start, phys_initrd_size)) {
+
+	if (memblock_is_region_reserved(phys_initrd_start, phys_initrd_size)) {
 		pr_err("INITRD: 0x%08llx+0x%08lx overlaps in-use memory region - disabling initrd\n",
 		       (u64)phys_initrd_start, phys_initrd_size);
-		phys_initrd_start = phys_initrd_size = 0;
+		return;
 	}
-	if (phys_initrd_size) {
-		memblock_reserve(phys_initrd_start, phys_initrd_size);
 
-		/* Now convert initrd to virtual addresses */
-		initrd_start = __phys_to_virt(phys_initrd_start);
-		initrd_end = initrd_start + phys_initrd_size;
-	}
+	memblock_reserve(phys_initrd_start, phys_initrd_size);
+
+	/* Now convert initrd to virtual addresses */
+	initrd_start = __phys_to_virt(phys_initrd_start);
+	initrd_end = initrd_start + phys_initrd_size;
 #endif
 }
 
-- 
2.7.4
