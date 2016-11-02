From: labbott@redhat.com (Laura Abbott)
Date: Wed,  2 Nov 2016 15:00:54 -0600
Subject: [PATCHv2 6/6] arm64: Add support for CONFIG_DEBUG_VIRTUAL
In-Reply-To: <20161102210054.16621-1-labbott@redhat.com>
References: <20161102210054.16621-1-labbott@redhat.com>
Message-ID: <20161102210054.16621-7-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


x86 has an option CONFIG_DEBUG_VIRTUAL to do additional checks
on virt_to_phys calls. The goal is to catch users who are calling
virt_to_phys on non-linear addresses immediately. As features
such as CONFIG_VMAP_STACK get enabled for arm64, this becomes
increasingly important. Add checks to catch bad virt_to_phys
usage.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 arch/arm64/Kconfig              |  1 +
 arch/arm64/include/asm/memory.h | 12 +++++++++++-
 arch/arm64/mm/Makefile          |  2 ++
 arch/arm64/mm/physaddr.c        | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/mm/physaddr.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 969ef88..83b95bc 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -6,6 +6,7 @@ config ARM64
 	select ACPI_MCFG if ACPI
 	select ACPI_SPCR_TABLE if ACPI
 	select ARCH_CLOCKSOURCE_DATA
+	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ACPI_TABLE_UPGRADE if ACPI
 	select ARCH_HAS_ELF_RANDOMIZE
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index d773e2c..eac3dbb 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -167,11 +167,19 @@ extern u64			kimage_voffset;
  * private definitions which should NOT be used outside memory.h
  * files.  Use virt_to_phys/phys_to_virt/__pa/__va instead.
  */
-#define __virt_to_phys(x) ({						\
+#define __virt_to_phys_nodebug(x) ({					\
 	phys_addr_t __x = (phys_addr_t)(x);				\
 	__x & BIT(VA_BITS - 1) ? (__x & ~PAGE_OFFSET) + PHYS_OFFSET :	\
 				 (__x - kimage_voffset); })
 
+#ifdef CONFIG_DEBUG_VIRTUAL
+extern unsigned long __virt_to_phys(unsigned long x);
+extern unsigned long __phys_addr_symbol(unsigned long x);
+#else
+#define __virt_to_phys(x)	__virt_to_phys_nodebug(x)
+#define __phys_addr_symbol	__pa
+#endif
+
 #define __phys_to_virt(x)	((unsigned long)((x) - PHYS_OFFSET) | PAGE_OFFSET)
 #define __phys_to_kimg(x)	((unsigned long)((x) + kimage_voffset))
 
@@ -202,6 +210,8 @@ static inline void *phys_to_virt(phys_addr_t x)
  * Drivers should NOT use these either.
  */
 #define __pa(x)			__virt_to_phys((unsigned long)(x))
+#define __pa_symbol(x)  __phys_addr_symbol(RELOC_HIDE((unsigned long)(x), 0))
+#define __pa_nodebug(x)		__virt_to_phys_nodebug((unsigned long)(x))
 #define __va(x)			((void *)__phys_to_virt((phys_addr_t)(x)))
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
 #define virt_to_pfn(x)      __phys_to_pfn(__virt_to_phys((unsigned long)(x)))
diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
index 54bb209..377f4ab 100644
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@ -5,6 +5,8 @@ obj-y				:= dma-mapping.o extable.o fault.o init.o \
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 obj-$(CONFIG_ARM64_PTDUMP)	+= dump.o
 obj-$(CONFIG_NUMA)		+= numa.o
+CFLAGS_physaddr.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
+obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
 
 obj-$(CONFIG_KASAN)		+= kasan_init.o
 KASAN_SANITIZE_kasan_init.o	:= n
diff --git a/arch/arm64/mm/physaddr.c b/arch/arm64/mm/physaddr.c
new file mode 100644
index 0000000..874c782
--- /dev/null
+++ b/arch/arm64/mm/physaddr.c
@@ -0,0 +1,34 @@
+#include <linux/mm.h>
+
+#include <asm/memory.h>
+
+unsigned long __virt_to_phys(unsigned long x)
+{
+	phys_addr_t __x = (phys_addr_t)x;
+
+	if (__x & BIT(VA_BITS - 1)) {
+		/*
+		 * The linear kernel range starts in the middle of the virtual
+		 * adddress space. Testing the top bit for the start of the
+		 * region is a sufficient check.
+		 */
+		return (__x & ~PAGE_OFFSET) + PHYS_OFFSET;
+	} else {
+		VIRTUAL_BUG_ON(x < kimage_vaddr || x >= (unsigned long)_end);
+		return (__x - kimage_voffset);
+	}
+}
+EXPORT_SYMBOL(__virt_to_phys);
+
+unsigned long __phys_addr_symbol(unsigned long x)
+{
+	phys_addr_t __x = (phys_addr_t)x;
+
+	/*
+	 * This is intentionally different than above to be a tighter check
+	 * for symbols.
+	 */
+	VIRTUAL_BUG_ON(x < kimage_vaddr + TEXT_OFFSET || x > (unsigned long) _end);
+	return (__x - kimage_voffset);
+}
+EXPORT_SYMBOL(__phys_addr_symbol);
-- 
2.10.1
