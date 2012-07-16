From: shc_work@mail.ru (Alexander Shiyan)
Date: Mon, 16 Jul 2012 22:21:46 +0400
Subject: [PATCH 2/4] ARM: clps711x: Removed superfluous transform virt_to_bus
 and related functions
In-Reply-To: <1342462908-18547-1-git-send-email-shc_work@mail.ru>
References: <1342462908-18547-1-git-send-email-shc_work@mail.ru>
Message-ID: <1342462908-18547-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This override does not allow support for multiple machines in a single core.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/include/mach/memory.h |   37 --------------------------
 1 files changed, 0 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-clps711x/include/mach/memory.h b/arch/arm/mach-clps711x/include/mach/memory.h
index 3a032a6..fc0e028 100644
--- a/arch/arm/mach-clps711x/include/mach/memory.h
+++ b/arch/arm/mach-clps711x/include/mach/memory.h
@@ -25,26 +25,6 @@
  */
 #define PLAT_PHYS_OFFSET	UL(0xc0000000)
 
-#if !defined(CONFIG_ARCH_CDB89712) && !defined (CONFIG_ARCH_AUTCPU12)
-
-#define __virt_to_bus(x)	((x) - PAGE_OFFSET)
-#define __bus_to_virt(x)	((x) + PAGE_OFFSET)
-#define __pfn_to_bus(x)		(__pfn_to_phys(x) - PHYS_OFFSET)
-#define __bus_to_pfn(x)		__phys_to_pfn((x) + PHYS_OFFSET)
-
-#endif
-
-
-/*
- * Like the SA1100, the EDB7211 has a large gap between physical RAM
- * banks.  In 2.2, the Psion (CL-PS7110) port added custom support for
- * discontiguous physical memory.  In 2.4, we can use the standard
- * Linux NUMA support.
- *
- * This is not necessary for EP7211 implementations with only one used
- * memory bank.  For those systems, simply undefine CONFIG_DISCONTIGMEM.
- */
-
 /*
  * The PS7211 allows up to 256MB max per DRAM bank, but the EDB7211
  * uses only one of the two banks (bank #1).  However, even within
@@ -54,23 +34,6 @@
  * them, so we use 24 for the node max shift to get 16MB node sizes.
  */
 
-/*
- * Because of the wide memory address space between physical RAM banks on the 
- * SA1100, it's much more convenient to use Linux's NUMA support to implement
- * our memory map representation.  Assuming all memory nodes have equal access 
- * characteristics, we then have generic discontiguous memory support.
- *
- * Of course, all this isn't mandatory for SA1100 implementations with only
- * one used memory bank.  For those, simply undefine CONFIG_DISCONTIGMEM.
- *
- * The nodes are matched with the physical memory bank addresses which are 
- * incidentally the same as virtual addresses.
- * 
- * 	node 0:  0xc0000000 - 0xc7ffffff
- * 	node 1:  0xc8000000 - 0xcfffffff
- * 	node 2:  0xd0000000 - 0xd7ffffff
- * 	node 3:  0xd8000000 - 0xdfffffff
- */
 #define SECTION_SIZE_BITS	24
 #define MAX_PHYSMEM_BITS	32
 
-- 
1.7.3.4
