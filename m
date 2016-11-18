From: labbott@redhat.com (Laura Abbott)
Date: Thu, 17 Nov 2016 17:16:56 -0800
Subject: [PATCHv3 6/6] arm64: Add support for CONFIG_DEBUG_VIRTUAL
In-Reply-To: <1479431816-5028-1-git-send-email-labbott@redhat.com>
References: <1479431816-5028-1-git-send-email-labbott@redhat.com>
Message-ID: <1479431816-5028-7-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


x86 has an option CONFIG_DEBUG_VIRTUAL to do additional checks
on virt_to_phys calls. The goal is to catch users who are calling
virt_to_phys on non-linear addresses immediately. This inclues callers
using virt_to_phys on image addresses instead of __pa_symbol. As features
such as CONFIG_VMAP_STACK get enabled for arm64, this becomes increasingly
important. Add checks to catch bad virt_to_phys usage.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v3: Make use of __pa_symbol required via debug checks. It's a WARN for now but
it can become a BUG after wider testing. __virt_to_phys is
now for linear addresses only. Dropped the VM_BUG_ON from Catalin's suggested
version from the nodebug version since having that in the nodebug version
essentially made them the debug version. Changed to KERNEL_START/KERNEL_END
for bounds checking. More comments.
---
 arch/arm64/Kconfig              |  1 +
 arch/arm64/include/asm/memory.h | 32 ++++++++++++++++++++++++++++----
 arch/arm64/mm/Makefile          |  1 +
 arch/arm64/mm/physaddr.c        | 39 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+), 4 deletions(-)
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
index 1e65299..2ed712e 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -167,10 +167,33 @@ extern u64			kimage_voffset;
  * private definitions which should NOT be used outside memory.h
  * files.  Use virt_to_phys/phys_to_virt/__pa/__va instead.
  */
-#define __virt_to_phys(x) ({						\
+
+
+/*
+ * This is for translation from the standard linear map to physical addresses.
+ * It is not to be used for kernel symbols.
+ */
+#define __virt_to_phys_nodebug(x) ({					\
 	phys_addr_t __x = (phys_addr_t)(x);				\
-	__x & BIT(VA_BITS - 1) ? (__x & ~PAGE_OFFSET) + PHYS_OFFSET :	\
-				 (__x - kimage_voffset); })
+	((__x & ~PAGE_OFFSET) + PHYS_OFFSET);				\
+})
+
+/*
+ * This is for translation from a kernel image/symbol address to a
+ * physical address.
+ */
+#define __pa_symbol_nodebug(x) ({					\
+	phys_addr_t __x = (phys_addr_t)(x);				\
+	(__x - kimage_voffset);						\
+})
+
+#ifdef CONFIG_DEBUG_VIRTUAL
+extern unsigned long __virt_to_phys(unsigned long x);
+extern unsigned long __phys_addr_symbol(unsigned long x);
+#else
+#define __virt_to_phys(x)	__virt_to_phys_nodebug(x)
+#define __phys_addr_symbol(x)	__pa_symbol_nodebug(x)
+#endif
 
 #define __phys_to_virt(x)	((unsigned long)((x) - PHYS_OFFSET) | PAGE_OFFSET)
 #define __phys_to_kimg(x)	((unsigned long)((x) + kimage_voffset))
@@ -202,7 +225,8 @@ static inline void *phys_to_virt(phys_addr_t x)
  * Drivers should NOT use these either.
  */
 #define __pa(x)			__virt_to_phys((unsigned long)(x))
-#define __pa_symbol(x)		__pa(RELOC_HIDE((unsigned long)(x), 0))
+#define __pa_symbol(x)		__phys_addr_symbol(RELOC_HIDE((unsigned long)(x), 0))
+#define __pa_nodebug(x)		__virt_to_phys_nodebug((unsigned long)(x))
 #define __va(x)			((void *)__phys_to_virt((phys_addr_t)(x)))
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
 #define virt_to_pfn(x)      __phys_to_pfn(__virt_to_phys((unsigned long)(x)))
diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
index 54bb209..0d37c19 100644
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@ -5,6 +5,7 @@ obj-y				:= dma-mapping.o extable.o fault.o init.o \
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 obj-$(CONFIG_ARM64_PTDUMP)	+= dump.o
 obj-$(CONFIG_NUMA)		+= numa.o
+obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
 
 obj-$(CONFIG_KASAN)		+= kasan_init.o
 KASAN_SANITIZE_kasan_init.o	:= n
diff --git a/arch/arm64/mm/physaddr.c b/arch/arm64/mm/physaddr.c
new file mode 100644
index 0000000..f8eb781
--- /dev/null
+++ b/arch/arm64/mm/physaddr.c
@@ -0,0 +1,39 @@
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
+		/*
+		 * __virt_to_phys should not be used on symbol addresses.
+		 * This should be changed to a BUG once all basic bad uses have
+		 * been cleaned up.
+		 */
+		WARN(1, "Do not use virt_to_phys on symbol addresses");
+		return __phys_addr_symbol(x);
+	}
+}
+EXPORT_SYMBOL(__virt_to_phys);
+
+unsigned long __phys_addr_symbol(unsigned long x)
+{
+	phys_addr_t __x = (phys_addr_t)x;
+
+	/*
+	 * This is bounds checking against the kernel image only.
+	 * __pa_symbol should only be used on kernel symbol addresses.
+	 */
+	VIRTUAL_BUG_ON(x < (unsigned long) KERNEL_START || x > (unsigned long) KERNEL_END);
+	return (__x - kimage_voffset);
+}
+EXPORT_SYMBOL(__phys_addr_symbol);
-- 
2.7.4
