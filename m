From: chris.brandt@renesas.com (Chris Brandt)
Date: Mon, 16 Nov 2015 13:05:40 -0500
Subject: [PATCH v3] ARM: xip: Use correct symbol for end of ROM marker
In-Reply-To: <1447362108-4333-1-git-send-email-chris.brandt@renesas.com>
References: <1447362108-4333-1-git-send-email-chris.brandt@renesas.com>
Message-ID: <1447697140-4099-1-git-send-email-chris.brandt@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For an XIP build, _edata_loc, not _etext, represents the end of the
binary image that will be programmed into ROM and mapped into the
MODULES_VADDR area.
With an XIP kernel, nothing is loaded into RAM before boot, meaning
you have to take into account the size of the entire binary image
that was programmed, including the init data values that will be copied
to RAM during kernel boot.

This fixes the bug where you might lose the end of your kernel area
after page table setup is complete.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
v3:
* Removed sections.h from Kbuild
v2:
* Added change for MODULES_VADDR
* Moved extern to new file asm/sections.h
---
 arch/arm/include/asm/Kbuild     |    1 -
 arch/arm/include/asm/sections.h |    8 ++++++++
 arch/arm/kernel/module.c        |    2 +-
 arch/arm/mm/mmu.c               |    4 ++--
 4 files changed, 11 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/include/asm/sections.h

diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index be648eb..6d3da22 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -21,7 +21,6 @@ generic-y += preempt.h
 generic-y += resource.h
 generic-y += rwsem.h
 generic-y += seccomp.h
-generic-y += sections.h
 generic-y += segment.h
 generic-y += sembuf.h
 generic-y += serial.h
diff --git a/arch/arm/include/asm/sections.h b/arch/arm/include/asm/sections.h
new file mode 100644
index 0000000..401eb3c2
--- /dev/null
+++ b/arch/arm/include/asm/sections.h
@@ -0,0 +1,8 @@
+#ifndef _ASM_ARM_SECTIONS_H
+#define _ASM_ARM_SECTIONS_H
+
+#include <asm-generic/sections.h>
+
+extern char _edata_loc[];
+
+#endif	/* _ASM_ARM_SECTIONS_H */
diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index efdddcb..41ae2cc 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -34,7 +34,7 @@
  * recompiling the whole kernel when CONFIG_XIP_KERNEL is turned on/off.
  */
 #undef MODULES_VADDR
-#define MODULES_VADDR	(((unsigned long)_etext + ~PMD_MASK) & PMD_MASK)
+#define MODULES_VADDR	(((unsigned long)_edata_loc + ~PMD_MASK) & PMD_MASK)
 #endif
 
 #ifdef CONFIG_MMU
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 4867f5d..dd5a56b 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1210,7 +1210,7 @@ static inline void prepare_page_table(void)
 
 #ifdef CONFIG_XIP_KERNEL
 	/* The XIP kernel is mapped in the module area -- skip over it */
-	addr = ((unsigned long)_etext + PMD_SIZE - 1) & PMD_MASK;
+	addr = ((unsigned long)_edata_loc + PMD_SIZE - 1) & PMD_MASK;
 #endif
 	for ( ; addr < PAGE_OFFSET; addr += PMD_SIZE)
 		pmd_clear(pmd_off_k(addr));
@@ -1292,7 +1292,7 @@ static void __init devicemaps_init(const struct machine_desc *mdesc)
 #ifdef CONFIG_XIP_KERNEL
 	map.pfn = __phys_to_pfn(CONFIG_XIP_PHYS_ADDR & SECTION_MASK);
 	map.virtual = MODULES_VADDR;
-	map.length = ((unsigned long)_etext - map.virtual + ~SECTION_MASK) & SECTION_MASK;
+	map.length = ((unsigned long)_edata_loc - map.virtual + ~SECTION_MASK) & SECTION_MASK;
 	map.type = MT_ROM;
 	create_mapping(&map);
 #endif
-- 
1.7.9.5
