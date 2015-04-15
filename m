From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 15 Apr 2015 17:34:21 +0200
Subject: [PATCH v4 10/13] arm64: move kernel mapping out of linear region
In-Reply-To: <1429112064-19952-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1429112064-19952-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1429112064-19952-11-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the primary mapping of the kernel Image out of
the linear region. This is a preparatory step towards allowing
the kernel Image to reside anywhere in physical memory without
affecting the ability to map all of it efficiently.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/boot.h   |  7 +++++++
 arch/arm64/include/asm/memory.h | 28 ++++++++++++++++++++++++----
 arch/arm64/kernel/head.S        |  8 ++++----
 arch/arm64/kernel/vmlinux.lds.S | 11 +++++++++--
 arch/arm64/mm/mmu.c             | 11 ++++++++++-
 5 files changed, 54 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/boot.h b/arch/arm64/include/asm/boot.h
index 81151b67b26b..092d1096ce9a 100644
--- a/arch/arm64/include/asm/boot.h
+++ b/arch/arm64/include/asm/boot.h
@@ -11,4 +11,11 @@
 #define MIN_FDT_ALIGN		8
 #define MAX_FDT_SIZE		SZ_2M
 
+/*
+ * arm64 requires the kernel image to be 2 MB aligned and
+ * not exceed 64 MB in size.
+ */
+#define MIN_KIMG_ALIGN		SZ_2M
+#define MAX_KIMG_SIZE		SZ_64M
+
 #endif
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index f800d45ea226..801331793bd3 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -24,6 +24,7 @@
 #include <linux/compiler.h>
 #include <linux/const.h>
 #include <linux/types.h>
+#include <asm/boot.h>
 #include <asm/sizes.h>
 
 /*
@@ -39,7 +40,12 @@
 #define PCI_IO_SIZE		SZ_16M
 
 /*
- * PAGE_OFFSET - the virtual address of the start of the kernel image (top
+ * Offset below PAGE_OFFSET where to map the kernel Image.
+ */
+#define KIMAGE_OFFSET		MAX_KIMG_SIZE
+
+/*
+ * PAGE_OFFSET - the virtual address of the base of the linear mapping (top
  *		 (VA_BITS - 1))
  * VA_BITS - the maximum number of bits for virtual addresses.
  * TASK_SIZE - the maximum size of a user space task.
@@ -49,7 +55,8 @@
  */
 #define VA_BITS			(CONFIG_ARM64_VA_BITS)
 #define PAGE_OFFSET		(UL(0xffffffffffffffff) << (VA_BITS - 1))
-#define MODULES_END		(PAGE_OFFSET)
+#define KIMAGE_VADDR		(PAGE_OFFSET - KIMAGE_OFFSET)
+#define MODULES_END		KIMAGE_VADDR
 #define MODULES_VADDR		(MODULES_END - SZ_64M)
 #define PCI_IO_END		(MODULES_VADDR - SZ_2M)
 #define PCI_IO_START		(PCI_IO_END - PCI_IO_SIZE)
@@ -77,7 +84,11 @@
  * private definitions which should NOT be used outside memory.h
  * files.  Use virt_to_phys/phys_to_virt/__pa/__va instead.
  */
-#define __virt_to_phys(x)	(((phys_addr_t)(x) - PAGE_OFFSET + PHYS_OFFSET))
+#define __virt_to_phys(x) ({						\
+	long __x = (long)(x) - PAGE_OFFSET;				\
+	__x >= 0 ? (phys_addr_t)(__x + PHYS_OFFSET) : 			\
+		   (phys_addr_t)(__x + PHYS_OFFSET + kernel_va_offset); })
+
 #define __phys_to_virt(x)	((unsigned long)((x) - PHYS_OFFSET + PAGE_OFFSET))
 
 /*
@@ -111,7 +122,16 @@
 
 extern phys_addr_t		memstart_addr;
 /* PHYS_OFFSET - the physical address of the start of memory. */
-#define PHYS_OFFSET		({ memstart_addr; })
+#define PHYS_OFFSET		({ memstart_addr + phys_offset_bias; })
+
+/*
+ * Before the linear mapping has been set up, __va() translations will
+ * not produce usable virtual addresses unless we tweak PHYS_OFFSET to
+ * compensate for the offset between the kernel mapping and the base of
+ * the linear mapping. We will undo this in map_mem().
+ */
+extern u64 phys_offset_bias;
+extern u64 kernel_va_offset;
 
 /*
  * PFNs are used to describe any physical page; this means
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index c0ff3ce4299e..3bf1d339dd8d 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -36,8 +36,6 @@
 #include <asm/page.h>
 #include <asm/virt.h>
 
-#define __PHYS_OFFSET	(KERNEL_START - TEXT_OFFSET)
-
 #if (TEXT_OFFSET & 0xfff) != 0
 #error TEXT_OFFSET must be at least 4KB aligned
 #elif (PAGE_OFFSET & 0x1fffff) != 0
@@ -58,6 +56,8 @@
 
 #define KERNEL_START	_text
 #define KERNEL_END	_end
+#define KERNEL_BASE	(KERNEL_START - TEXT_OFFSET)
+
 
 /*
  * Initial memory map attributes.
@@ -235,7 +235,7 @@ section_table:
 ENTRY(stext)
 	bl	preserve_boot_args
 	bl	el2_setup			// Drop to EL1, w20=cpu_boot_mode
-	adrp	x24, __PHYS_OFFSET
+	adrp	x24, KERNEL_BASE
 	bl	set_cpu_boot_mode_flag
 	bl	__create_page_tables		// x25=TTBR0, x26=TTBR1
 	/*
@@ -411,7 +411,7 @@ __create_page_tables:
 	 * Map the kernel image (starting with PHYS_OFFSET).
 	 */
 	mov	x0, x26				// swapper_pg_dir
-	mov	x5, #PAGE_OFFSET
+	ldr	x5, =KERNEL_BASE
 	create_pgd_entry x0, x5, x3, x6
 	ldr	x6, =KERNEL_END			// __va(KERNEL_END)
 	mov	x3, x24				// phys offset
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 338eaa7bcbfd..8dbb816c0338 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -6,6 +6,7 @@
 
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/thread_info.h>
+#include <asm/boot.h>
 #include <asm/memory.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
@@ -95,7 +96,7 @@ SECTIONS
 		*(.discard.*)
 	}
 
-	. = PAGE_OFFSET + TEXT_OFFSET;
+	. = KIMAGE_VADDR + TEXT_OFFSET;
 
 	.head.text : {
 		_text = .;
@@ -203,4 +204,10 @@ ASSERT(SIZEOF(.pgdir) < ALIGNOF(.pgdir), ".pgdir size exceeds its alignment")
 /*
  * If padding is applied before .head.text, virt<->phys conversions will fail.
  */
-ASSERT(_text == (PAGE_OFFSET + TEXT_OFFSET), "HEAD is misaligned")
+ASSERT(_text == (KIMAGE_VADDR + TEXT_OFFSET), "HEAD is misaligned")
+
+/*
+ * Make sure the memory footprint of the kernel Image does not exceed the limit.
+ */
+ASSERT(_end - _text + TEXT_OFFSET <= MAX_KIMG_SIZE,
+	"Kernel Image memory footprint exceeds MAX_KIMG_SIZE")
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 93e5a2497f01..b457b7e425cc 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -50,6 +50,9 @@ u64 idmap_t0sz = TCR_T0SZ(VA_BITS);
 struct page *empty_zero_page;
 EXPORT_SYMBOL(empty_zero_page);
 
+u64 phys_offset_bias __read_mostly = KIMAGE_OFFSET;
+u64 kernel_va_offset __read_mostly;
+
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 			      unsigned long size, pgprot_t vma_prot)
 {
@@ -386,6 +389,9 @@ static void __init bootstrap_linear_mapping(unsigned long va_offset)
 	 * Bootstrap the linear range that covers swapper_pg_dir so that the
 	 * statically allocated page tables as well as newly allocated ones
 	 * are accessible via the linear mapping.
+	 * Since@this point, PHYS_OFFSET is still biased to redirect __va()
+	 * translations into the kernel text mapping, we need to apply an
+	 * explicit va_offset to calculate virtual linear addresses.
 	 */
 	static struct bootstrap_pgtables linear_bs_pgtables __pgdir;
 	const phys_addr_t swapper_phys = __pa(swapper_pg_dir);
@@ -441,7 +447,10 @@ static void __init map_mem(void)
 {
 	struct memblock_region *reg;
 
-	bootstrap_linear_mapping(0);
+	bootstrap_linear_mapping(KIMAGE_OFFSET);
+
+	kernel_va_offset = KIMAGE_OFFSET;
+	phys_offset_bias = 0;
 
 	/* map all the memory banks */
 	for_each_memblock(memory, reg) {
-- 
1.8.3.2
