From: gadiyar@ti.com (Anand Gadiyar)
Date: Fri, 12 Nov 2010 11:49:13 +0530
Subject: ARM: fix compile warning in mm/init.c
Message-ID: <1289542753-30185-1-git-send-email-gadiyar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 7c63984b86 (ARM: do not define VMALLOC_END relative to PAGE_OFFSET)
changed VMALLOC_END to be an explicit value. Before this, it was
relative to PAGE_OFFSET and therefore automatically upgraded to
unsigned long as PAGE_OFFSET was an unsigned long. This introduced
the following build warning. Fix this.

  CC      arch/arm/mm/init.o
arch/arm/mm/init.c: In function 'mem_init':
arch/arm/mm/init.c:606: warning: format '%08lx' expects type 'long unsigned int', but argument 12 has type 'unsigned int'

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Cc: Nicolas Pitre <nico@fluxnic.net>
---
 arch/arm/mm/init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: ehci/arch/arm/mm/init.c
===================================================================
--- ehci.orig/arch/arm/mm/init.c
+++ ehci/arch/arm/mm/init.c
@@ -593,7 +593,7 @@ void __init mem_init(void)
 #ifdef CONFIG_MMU
 			MLM(CONSISTENT_BASE, CONSISTENT_END),
 #endif
-			MLM(VMALLOC_START, VMALLOC_END),
+			MLM(VMALLOC_START, (unsigned long)VMALLOC_END),
 			MLM(PAGE_OFFSET, (unsigned long)high_memory),
 #ifdef CONFIG_HIGHMEM
 			MLM(PKMAP_BASE, (PKMAP_BASE) + (LAST_PKMAP) *
