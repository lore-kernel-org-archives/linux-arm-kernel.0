From: cavokz@gmail.com (Domenico Andreoli)
Date: Mon, 11 Apr 2011 19:00:47 +0200
Subject: [PATCH] increase the use of CONFIG_VECTORS_BASE
Message-ID: <20110411170047.GA12509@dandreoli.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Domenico Andreoli <cavokz@gmail.com>

If CONFIG_VECTORS_BASE is meant to make vectors base address
configurable, it is not consistently used. At least in arch/arm/mm/mmu.c
the explicit value 0xffff0000 is still widely used.

This is an attempt to improve the situation.

Signed-off-by: Domenico Andreoli <cavokz@gmail.com>

---

I'm in the footsteps of the vectors' initialization but following
CONFIG_VECTORS_BASE alone does not bring anywhere.  Even if this patch
does not allow to freely set the vectors base elsewhere (if it has any
sense) it could anyway improve the way for the others coming along.

Grepping for ffff0000 in arch/arm shows a lot of false positives, this
is my guess of other possible places in which CONFIG_VECTORS_BASE may
have sense:

arch/arm/include/asm/fixmap.h:8: * the architecture such as the vector page which is located at 0xffff0000,
arch/arm/include/asm/system.h:33:#define CR_V   (1 << 13)       /* Vectors relocated to 0xffff0000      */
arch/arm/kernel/process.c:496:  return install_special_mapping(mm, 0xffff0000, PAGE_SIZE,
arch/arm/kernel/process.c:505:  return (vma->vm_start == 0xffff0000) ? "[vectors]" : NULL;
arch/arm/kernel/traps.c:773:     * into the vector page, mapped at 0xffff0000, and ensure these
arch/arm/mach-sa1100/generic.c:376: * 0xffff0000-0xffff0fff:    SA1100 exception vectors
arch/arm/mm/mmu.c:1044: top_pmd = pmd_off_k(0xffff0000);
...

Surely the most important are missing :)

cheers,
Domenico

---
 arch/arm/mm/mmu.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Index: b/arch/arm/mm/mmu.c
===================================================================
--- a/arch/arm/mm/mmu.c	2011-04-11 18:03:50.000000000 +0200
+++ b/arch/arm/mm/mmu.c	2011-04-11 18:09:46.000000000 +0200
@@ -521,7 +521,7 @@
 EXPORT_SYMBOL(phys_mem_access_prot);
 #endif
 
-#define vectors_base()	(vectors_high() ? 0xffff0000 : 0)
+#define vectors_base()	(vectors_high() ? CONFIG_VECTORS_BASE : 0)
 
 static void __init *early_alloc(unsigned long sz)
 {
@@ -962,11 +962,12 @@
 
 	/*
 	 * Create a mapping for the machine vectors at the high-vectors
-	 * location (0xffff0000).  If we aren't using high-vectors, also
-	 * create a mapping at the low-vectors virtual address.
+	 * location (defined by CONFIG_VECTORS_BASE).  If we aren't
+	 * using high-vectors, also create a mapping at the low-vectors
+	 * virtual address.
 	 */
 	map.pfn = __phys_to_pfn(virt_to_phys(vectors_page));
-	map.virtual = 0xffff0000;
+	map.virtual = CONFIG_VECTORS_BASE;
 	map.length = PAGE_SIZE;
 	map.type = MT_HIGH_VECTORS;
 	create_mapping(&map);
