From: labbott@redhat.com (Laura Abbott)
Date: Tue, 10 Jan 2017 13:35:50 -0800
Subject: [PATCHv7 11/11] arm64: Add support for CONFIG_DEBUG_VIRTUAL
In-Reply-To: <1484084150-1523-1-git-send-email-labbott@redhat.com>
References: <1484084150-1523-1-git-send-email-labbott@redhat.com>
Message-ID: <1484084150-1523-12-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


x86 has an option CONFIG_DEBUG_VIRTUAL to do additional checks
on virt_to_phys calls. The goal is to catch users who are calling
virt_to_phys on non-linear addresses immediately. This inclues callers
using virt_to_phys on image addresses instead of __pa_symbol. As features
such as CONFIG_VMAP_STACK get enabled for arm64, this becomes increasingly
important. Add checks to catch bad virt_to_phys usage.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 arch/arm64/Kconfig              |  1 +
 arch/arm64/include/asm/memory.h | 31 ++++++++++++++++++++++++++++---
 arch/arm64/mm/Makefile          |  2 ++
 arch/arm64/mm/physaddr.c        | 30 ++++++++++++++++++++++++++++++
 4 files changed, 61 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/mm/physaddr.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1117421..359bca2 100644
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
index 0ff237a..7011f08 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -172,10 +172,33 @@ static inline unsigned long kaslr_offset(void)
  * private definitions which should NOT be used outside memory.h
  * files.  Use virt_to_phys/phys_to_virt/__pa/__va instead.
  */
-#define __virt_to_phys(x) ({						\
+
+
+/*
+ * The linear kernel range starts in the middle of the virtual adddress
+ * space. Testing the top bit for the start of the region is a
+ * sufficient check.
+ */
+#define __is_lm_address(addr)	(!!((addr) & BIT(VA_BITS - 1)))
+
+#define __lm_to_phys(addr)	(((addr) & ~PAGE_OFFSET) + PHYS_OFFSET)
+#define __kimg_to_phys(addr)	((addr) - kimage_voffset)
+
+#define __virt_to_phys_nodebug(x) ({					\
 	phys_addr_t __x = (phys_addr_t)(x);				\
-	__x & BIT(VA_BITS - 1) ? (__x & ~PAGE_OFFSET) + PHYS_OFFSET :	\
-				 (__x - kimage_voffset); })
+	__is_lm_address(__x) ? __lm_to_phys(__x) :			\
+			       __kimg_to_phys(__x);			\
+})
+
+#define __pa_symbol_nodebug(x)	__kimg_to_phys((phys_addr_t)(x))
+
+#ifdef CONFIG_DEBUG_VIRTUAL
+extern phys_addr_t __virt_to_phys(unsigned long x);
+extern phys_addr_t __phys_addr_symbol(unsigned long x);
+#else
+#define __virt_to_phys(x)	__virt_to_phys_nodebug(x)
+#define __phys_addr_symbol(x)	__pa_symbol_nodebug(x)
+#endif
 
 #define __phys_to_virt(x)	((unsigned long)((x) - PHYS_OFFSET) | PAGE_OFFSET)
 #define __phys_to_kimg(x)	((unsigned long)((x) + kimage_voffset))
@@ -207,6 +230,8 @@ static inline void *phys_to_virt(phys_addr_t x)
  * Drivers should NOT use these either.
  */
 #define __pa(x)			__virt_to_phys((unsigned long)(x))
+#define __pa_symbol(x)		__phys_addr_symbol(RELOC_HIDE((unsigned long)(x), 0))
+#define __pa_nodebug(x)		__virt_to_phys_nodebug((unsigned long)(x))
 #define __va(x)			((void *)__phys_to_virt((phys_addr_t)(x)))
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
 #define virt_to_pfn(x)      __phys_to_pfn(__virt_to_phys((unsigned long)(x)))
diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
index e703fb9..9b0ba19 100644
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@ -6,6 +6,8 @@ obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 obj-$(CONFIG_ARM64_PTDUMP_CORE)	+= dump.o
 obj-$(CONFIG_ARM64_PTDUMP_DEBUGFS)	+= ptdump_debugfs.o
 obj-$(CONFIG_NUMA)		+= numa.o
+obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
+KASAN_SANITIZE_physaddr.o	+= n
 
 obj-$(CONFIG_KASAN)		+= kasan_init.o
 KASAN_SANITIZE_kasan_init.o	:= n
diff --git a/arch/arm64/mm/physaddr.c b/arch/arm64/mm/physaddr.c
new file mode 100644
index 0000000..91371da
--- /dev/null
+++ b/arch/arm64/mm/physaddr.c
@@ -0,0 +1,30 @@
+#include <linux/bug.h>
+#include <linux/export.h>
+#include <linux/types.h>
+#include <linux/mmdebug.h>
+#include <linux/mm.h>
+
+#include <asm/memory.h>
+
+phys_addr_t __virt_to_phys(unsigned long x)
+{
+	WARN(!__is_lm_address(x),
+	     "virt_to_phys used for non-linear address: %pK (%pS)\n",
+	      (void *)x,
+	      (void *)x);
+
+	return __virt_to_phys_nodebug(x);
+}
+EXPORT_SYMBOL(__virt_to_phys);
+
+phys_addr_t __phys_addr_symbol(unsigned long x)
+{
+	/*
+	 * This is bounds checking against the kernel image only.
+	 * __pa_symbol should only be used on kernel symbol addresses.
+	 */
+	VIRTUAL_BUG_ON(x < (unsigned long) KERNEL_START ||
+		       x > (unsigned long) KERNEL_END);
+	return __pa_symbol_nodebug(x);
+}
+EXPORT_SYMBOL(__phys_addr_symbol);
-- 
2.7.4
