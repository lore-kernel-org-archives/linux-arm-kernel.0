From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue,  3 Jan 2017 17:14:16 -0800
Subject: [PATCH v5 3/4] ARM: Add support for CONFIG_DEBUG_VIRTUAL
In-Reply-To: <20170104011417.1496-1-f.fainelli@gmail.com>
References: <edc8eaa2-5414-506c-1dad-f2404ef19c81@gmail.com>
 <20170104011417.1496-1-f.fainelli@gmail.com>
Message-ID: <20170104011417.1496-4-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

x86 has an option: CONFIG_DEBUG_VIRTUAL to do additional checks on
virt_to_phys calls. The goal is to catch users who are calling
virt_to_phys on non-linear addresses immediately. This includes caller
using __virt_to_phys() on image addresses instead of __pa_symbol(). This
is a generally useful debug feature to spot bad code (particulary in
drivers).

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/Kconfig              |  1 +
 arch/arm/include/asm/memory.h | 16 +++++++++++--
 arch/arm/mm/Makefile          |  1 +
 arch/arm/mm/physaddr.c        | 55 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mm/physaddr.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5fab553fd03a..4700294f4e09 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2,6 +2,7 @@ config ARM
 	bool
 	default y
 	select ARCH_CLOCKSOURCE_DATA
+	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index bee7511c5098..d90300193adf 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -213,7 +213,7 @@ extern const void *__pv_table_begin, *__pv_table_end;
 	: "r" (x), "I" (__PV_BITS_31_24)		\
 	: "cc")
 
-static inline phys_addr_t __virt_to_phys(unsigned long x)
+static inline phys_addr_t __virt_to_phys_nodebug(unsigned long x)
 {
 	phys_addr_t t;
 
@@ -245,7 +245,7 @@ static inline unsigned long __phys_to_virt(phys_addr_t x)
 #define PHYS_OFFSET	PLAT_PHYS_OFFSET
 #define PHYS_PFN_OFFSET	((unsigned long)(PHYS_OFFSET >> PAGE_SHIFT))
 
-static inline phys_addr_t __virt_to_phys(unsigned long x)
+static inline phys_addr_t __virt_to_phys_nodebug(unsigned long x)
 {
 	return (phys_addr_t)x - PAGE_OFFSET + PHYS_OFFSET;
 }
@@ -261,6 +261,16 @@ static inline unsigned long __phys_to_virt(phys_addr_t x)
 	((((unsigned long)(kaddr) - PAGE_OFFSET) >> PAGE_SHIFT) + \
 	 PHYS_PFN_OFFSET)
 
+#define __pa_symbol_nodebug(x)	__virt_to_phys_nodebug((x))
+
+#ifdef CONFIG_DEBUG_VIRTUAL
+extern phys_addr_t __virt_to_phys(unsigned long x);
+extern phys_addr_t __phys_addr_symbol(unsigned long x);
+#else
+#define __virt_to_phys(x)	__virt_to_phys_nodebug(x)
+#define __phys_addr_symbol(x)	__pa_symbol_nodebug(x)
+#endif
+
 /*
  * These are *only* valid on the kernel direct mapped RAM memory.
  * Note: Drivers should NOT use these.  They are the wrong
@@ -283,9 +293,11 @@ static inline void *phys_to_virt(phys_addr_t x)
  * Drivers should NOT use these either.
  */
 #define __pa(x)			__virt_to_phys((unsigned long)(x))
+#define __pa_symbol(x)		__phys_addr_symbol(RELOC_HIDE((unsigned long)(x), 0))
 #define __va(x)			((void *)__phys_to_virt((phys_addr_t)(x)))
 #define pfn_to_kaddr(pfn)	__va((phys_addr_t)(pfn) << PAGE_SHIFT)
 
+
 extern long long arch_phys_to_idmap_offset;
 
 /*
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index e8698241ece9..b3dea80715b4 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -14,6 +14,7 @@ endif
 
 obj-$(CONFIG_ARM_PTDUMP)	+= dump.o
 obj-$(CONFIG_MODULES)		+= proc-syms.o
+obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
 
 obj-$(CONFIG_ALIGNMENT_TRAP)	+= alignment.o
 obj-$(CONFIG_HIGHMEM)		+= highmem.o
diff --git a/arch/arm/mm/physaddr.c b/arch/arm/mm/physaddr.c
new file mode 100644
index 000000000000..f10bdcbcb155
--- /dev/null
+++ b/arch/arm/mm/physaddr.c
@@ -0,0 +1,55 @@
+#include <linux/bug.h>
+#include <linux/export.h>
+#include <linux/types.h>
+#include <linux/mmdebug.h>
+#include <linux/mm.h>
+
+#include <asm/sections.h>
+#include <asm/memory.h>
+#include <asm/fixmap.h>
+#include <asm/dma.h>
+
+#include "mm.h"
+
+static inline bool __virt_addr_valid(unsigned long x)
+{
+	/* high_memory does not get immediately defined, and there
+	 * are early callers of __pa() against PAGE_OFFSET
+	 */
+	if (!high_memory && x >= PAGE_OFFSET)
+		return true;
+
+	if (high_memory && x >= PAGE_OFFSET && x < (unsigned long)high_memory)
+		return true;
+
+	/* ARM uses the default per-CPU allocation routing which forces us to
+	 * have an explicit check here to avoid a false positive
+	 */
+	if (x == MAX_DMA_ADDRESS)
+		return true;
+
+	return false;
+}
+
+phys_addr_t __virt_to_phys(unsigned long x)
+{
+	WARN(!__virt_addr_valid(x),
+	     "virt_to_phys used for non-linear address: %pK (%pS)\n",
+	     (void *)x,
+	     (void *)x);
+
+	return __virt_to_phys_nodebug(x);
+}
+EXPORT_SYMBOL(__virt_to_phys);
+
+phys_addr_t __phys_addr_symbol(unsigned long x)
+{
+	/* This is bounds checking against the kernel image only.
+	 * __pa_symbol should only be used on kernel symbol addresses.
+	 */
+	VIRTUAL_BUG_ON(x < (unsigned long)KERNEL_START ||
+		       x > (unsigned long)KERNEL_END);
+
+	return __pa_symbol_nodebug(x);
+}
+EXPORT_SYMBOL(__phys_addr_symbol);
-- 
2.9.3
