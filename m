From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 14 Apr 2016 20:42:38 +0100
Subject: [PATCH] ARM: provide improved virt_to_idmap() functionality
Message-ID: <E1aqn9y-00012K-8h@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For kexec, we need more functionality from the IDMAP system.  We need to
be able to convert physical addresses to their identity mappped versions
as well as virtual addresses.

Convert the existing arch_virt_to_idmap() to deal with physical
addresses instead.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
Obviously, this is for Keystone 2 Kexec with its weird physical memory
layout.

 arch/arm/include/asm/memory.h     | 27 ++++++++++++++++++++++-----
 arch/arm/mach-keystone/keystone.c |  7 +------
 arch/arm/mm/idmap.c               |  2 +-
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 9427fd632552..59c93a224d14 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -288,19 +288,36 @@ static inline void *phys_to_virt(phys_addr_t x)
 #define __va(x)			((void *)__phys_to_virt((phys_addr_t)(x)))
 #define pfn_to_kaddr(pfn)	__va((phys_addr_t)(pfn) << PAGE_SHIFT)
 
-extern unsigned long (*arch_virt_to_idmap)(unsigned long x);
+extern long long arch_phys_to_idmap_offset;
 
 /*
  * These are for systems that have a hardware interconnect supported alias of
  * physical memory for idmap purposes.  Most cases should leave these
  * untouched.  Note: this can only return addresses less than 4GiB.
  */
+static inline unsigned long phys_to_idmap(phys_addr_t addr)
+{
+	if (IS_ENABLED(CONFIG_MMU) && arch_phys_to_idmap_offset) {
+		addr += arch_phys_to_idmap_offset;
+		if (addr > (u32)~0)
+			addr = (u32)~0;
+	}
+	return addr;
+}
+
+static inline phys_addr_t idmap_to_phys(unsigned long idmap)
+{
+	phys_addr_t addr = idmap;
+
+	if (IS_ENABLED(CONFIG_MMU) && arch_phys_to_idmap_offset)
+		addr -= arch_phys_to_idmap_offset;
+
+	return addr;
+}
+
 static inline unsigned long __virt_to_idmap(unsigned long x)
 {
-	if (IS_ENABLED(CONFIG_MMU) && arch_virt_to_idmap)
-		return arch_virt_to_idmap(x);
-	else
-		return __virt_to_phys(x);
+	return phys_to_idmap(__virt_to_phys(x));
 }
 
 #define virt_to_idmap(x)	__virt_to_idmap((unsigned long)(x))
diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index e6b9cb1e6709..a33a296b00dc 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -63,11 +63,6 @@ static void __init keystone_init(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-static unsigned long keystone_virt_to_idmap(unsigned long x)
-{
-	return (phys_addr_t)(x) - CONFIG_PAGE_OFFSET + KEYSTONE_LOW_PHYS_START;
-}
-
 static long long __init keystone_pv_fixup(void)
 {
 	long long offset;
@@ -91,7 +86,7 @@ static long long __init keystone_pv_fixup(void)
 	offset = KEYSTONE_HIGH_PHYS_START - KEYSTONE_LOW_PHYS_START;
 
 	/* Populate the arch idmap hook */
-	arch_virt_to_idmap = keystone_virt_to_idmap;
+	arch_phys_to_idmap_offset = -offset;
 
 	return offset;
 }
diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
index bd274a05b8ff..c1a48f88764e 100644
--- a/arch/arm/mm/idmap.c
+++ b/arch/arm/mm/idmap.c
@@ -15,7 +15,7 @@
  * page tables.
  */
 pgd_t *idmap_pgd;
-unsigned long (*arch_virt_to_idmap)(unsigned long x);
+long long arch_phys_to_idmap_offset;
 
 #ifdef CONFIG_ARM_LPAE
 static void idmap_add_pmd(pud_t *pud, unsigned long addr, unsigned long end,
-- 
2.1.0
