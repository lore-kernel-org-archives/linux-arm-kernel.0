From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu,  8 Jul 2010 23:16:45 +0200
Subject: [PATCH 1/2] ARM: add memory types for the TCMs
Message-ID: <1278623805-17027-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The earlier TCM memory regions were mapped as MT_MEMORY_UNCACHED
which doesn't really work on platforms supporting the new v6
features like the NX bit. Add unique MT_MEMORY_[I|D]TCM types
instead.

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
Need help to get this right, so CC:in Russell and Nicolas on this,
since they usually knows about these things.

The settings here work fine, code executes nicely from ITCM
and data, variables and constants can be stored and retrieved.

I'm especially in the dark about the usage of the L_PTE_* stuff,
and when to use DOMAIN_KERNEL, DOMAIN_USER and DOMAIN_IO. For
example: does DOMAIN_KERNEL imply kernel usage? DOMAIN_KERNEL
for ITCM makes the code non-executable. Does DOMAIN_USER imply
that L_PTE_USER shall also be set?

I tried reading the map.h and ARM manuals already but I don't
find my way out so might as well ask.
---
 arch/arm/include/asm/mach/map.h |    2 ++
 arch/arm/kernel/tcm.c           |    5 ++---
 arch/arm/mm/mmu.c               |   13 +++++++++++++
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/mach/map.h b/arch/arm/include/asm/mach/map.h
index 742c2aa..d2fedb5 100644
--- a/arch/arm/include/asm/mach/map.h
+++ b/arch/arm/include/asm/mach/map.h
@@ -27,6 +27,8 @@ struct map_desc {
 #define MT_MEMORY		9
 #define MT_ROM			10
 #define MT_MEMORY_NONCACHED	11
+#define MT_MEMORY_DTCM		12
+#define MT_MEMORY_ITCM		13
 
 #ifdef CONFIG_MMU
 extern void iotable_init(struct map_desc *, int);
diff --git a/arch/arm/kernel/tcm.c b/arch/arm/kernel/tcm.c
index e503038..0c62aa2 100644
--- a/arch/arm/kernel/tcm.c
+++ b/arch/arm/kernel/tcm.c
@@ -13,7 +13,6 @@
 #include <linux/ioport.h>
 #include <linux/genalloc.h>
 #include <linux/string.h> /* memcpy */
-#include <asm/page.h> /* PAGE_SHIFT */
 #include <asm/cputype.h>
 #include <asm/mach/map.h>
 #include <mach/memory.h>
@@ -53,7 +52,7 @@ static struct map_desc dtcm_iomap[] __initdata = {
 		.virtual	= DTCM_OFFSET,
 		.pfn		= __phys_to_pfn(DTCM_OFFSET),
 		.length		= (DTCM_END - DTCM_OFFSET + 1),
-		.type		= MT_UNCACHED
+		.type		= MT_MEMORY_DTCM
 	}
 };
 
@@ -62,7 +61,7 @@ static struct map_desc itcm_iomap[] __initdata = {
 		.virtual	= ITCM_OFFSET,
 		.pfn		= __phys_to_pfn(ITCM_OFFSET),
 		.length		= (ITCM_END - ITCM_OFFSET + 1),
-		.type		= MT_UNCACHED
+		.type		= MT_MEMORY_ITCM
 	}
 };
 
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index f61c21c..a4f89f7 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -257,6 +257,19 @@ static struct mem_type mem_types[] = {
 		.prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE,
 		.domain    = DOMAIN_KERNEL,
 	},
+	[MT_MEMORY_DTCM] = {
+		.prot_pte	= L_PTE_PRESENT | L_PTE_YOUNG |
+		                  L_PTE_DIRTY | L_PTE_WRITE,
+		.prot_l1	= PMD_TYPE_TABLE,
+		.prot_sect	= PMD_TYPE_SECT | PMD_SECT_XN,
+		.domain		= DOMAIN_KERNEL,
+	},
+	[MT_MEMORY_ITCM] = {
+		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
+				L_PTE_USER | L_PTE_EXEC,
+		.prot_l1   = PMD_TYPE_TABLE,
+		.domain    = DOMAIN_IO,
+	},
 };
 
 const struct mem_type *get_mem_type(unsigned int type)
-- 
1.7.1
