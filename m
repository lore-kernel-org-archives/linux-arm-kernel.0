From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 26 Jan 2016 18:21:24 +0000
Subject: [PATCH 1/2] ARM: make virt_to_idmap() return unsigned long
Message-ID: <E1aO8F2-00074N-E8@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make virt_to_idmap() return an unsigned long rather than phys_addr_t.

Returning phys_addr_t here makes no sense, because the definition of
virt_to_idmap() is that it shall return a physical address which maps
identically with the virtual address.  Since virtual addresses are
limited to 32-bit, identity mapped physical addresses are as well.

Almost all users already had an implicit narrowing cast to unsigned long
so let's make this official and part of this interface.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/memory.h     | 6 +++---
 arch/arm/kernel/reboot.c          | 2 +-
 arch/arm/mach-keystone/keystone.c | 2 +-
 arch/arm/mm/idmap.c               | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 42aac86b1bb5..c3fc80190cbd 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -275,14 +275,14 @@ static inline void *phys_to_virt(phys_addr_t x)
 #define __va(x)			((void *)__phys_to_virt((phys_addr_t)(x)))
 #define pfn_to_kaddr(pfn)	__va((phys_addr_t)(pfn) << PAGE_SHIFT)
 
-extern phys_addr_t (*arch_virt_to_idmap)(unsigned long x);
+extern unsigned long (*arch_virt_to_idmap)(unsigned long x);
 
 /*
  * These are for systems that have a hardware interconnect supported alias of
  * physical memory for idmap purposes.  Most cases should leave these
- * untouched.
+ * untouched.  Note: this can only return addresses less than 4GiB.
  */
-static inline phys_addr_t __virt_to_idmap(unsigned long x)
+static inline unsigned long __virt_to_idmap(unsigned long x)
 {
 	if (IS_ENABLED(CONFIG_MMU) && arch_virt_to_idmap)
 		return arch_virt_to_idmap(x);
diff --git a/arch/arm/kernel/reboot.c b/arch/arm/kernel/reboot.c
index 38269358fd25..71a2ff9ec490 100644
--- a/arch/arm/kernel/reboot.c
+++ b/arch/arm/kernel/reboot.c
@@ -50,7 +50,7 @@ static void __soft_restart(void *addr)
 	flush_cache_all();
 
 	/* Switch to the identity mapping. */
-	phys_reset = (phys_reset_t)(unsigned long)virt_to_idmap(cpu_reset);
+	phys_reset = (phys_reset_t)virt_to_idmap(cpu_reset);
 	phys_reset((unsigned long)addr);
 
 	/* Should never get here. */
diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index c279293f084c..d80879ce4963 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -63,7 +63,7 @@ static void __init keystone_init(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-static phys_addr_t keystone_virt_to_idmap(unsigned long x)
+static unsigned long keystone_virt_to_idmap(unsigned long x)
 {
 	return (phys_addr_t)(x) - CONFIG_PAGE_OFFSET + KEYSTONE_LOW_PHYS_START;
 }
diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
index d65909697165..bd274a05b8ff 100644
--- a/arch/arm/mm/idmap.c
+++ b/arch/arm/mm/idmap.c
@@ -15,7 +15,7 @@
  * page tables.
  */
 pgd_t *idmap_pgd;
-phys_addr_t (*arch_virt_to_idmap) (unsigned long x);
+unsigned long (*arch_virt_to_idmap)(unsigned long x);
 
 #ifdef CONFIG_ARM_LPAE
 static void idmap_add_pmd(pud_t *pud, unsigned long addr, unsigned long end,
-- 
2.1.0
