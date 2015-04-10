From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 10 Apr 2015 15:53:53 +0200
Subject: [PATCH v3 09/11] arm64: move kernel mapping out of linear region
In-Reply-To: <1428674035-26603-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1428674035-26603-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1428674035-26603-10-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the primary mapping of the kernel Image out of
the linear region. This is a preparatory step towards allowing
the kernel Image to reside anywhere in physical memory without
affecting the ability to map all of it efficiently.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/memory.h | 15 ++++++++++++---
 arch/arm64/kernel/head.S        |  8 ++++----
 arch/arm64/kernel/vmlinux.lds.S |  4 ++--
 arch/arm64/mm/mmu.c             |  2 ++
 4 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index f800d45ea226..d92268614ddc 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -38,8 +38,10 @@
  */
 #define PCI_IO_SIZE		SZ_16M
 
+#define KIMAGE_OFFSET		SZ_64M
+
 /*
- * PAGE_OFFSET - the virtual address of the start of the kernel image (top
+ * PAGE_OFFSET - the virtual address of the base of the linear mapping (top
  *		 (VA_BITS - 1))
  * VA_BITS - the maximum number of bits for virtual addresses.
  * TASK_SIZE - the maximum size of a user space task.
@@ -49,7 +51,8 @@
  */
 #define VA_BITS			(CONFIG_ARM64_VA_BITS)
 #define PAGE_OFFSET		(UL(0xffffffffffffffff) << (VA_BITS - 1))
-#define MODULES_END		(PAGE_OFFSET)
+#define KIMAGE_VADDR		(PAGE_OFFSET - KIMAGE_OFFSET)
+#define MODULES_END		KIMAGE_VADDR
 #define MODULES_VADDR		(MODULES_END - SZ_64M)
 #define PCI_IO_END		(MODULES_VADDR - SZ_2M)
 #define PCI_IO_START		(PCI_IO_END - PCI_IO_SIZE)
@@ -77,7 +80,11 @@
  * private definitions which should NOT be used outside memory.h
  * files.  Use virt_to_phys/phys_to_virt/__pa/__va instead.
  */
-#define __virt_to_phys(x)	(((phys_addr_t)(x) - PAGE_OFFSET + PHYS_OFFSET))
+#define __virt_to_phys(x) ({						\
+	long __x = (long)(x) - PAGE_OFFSET;				\
+	__x >= 0 ? (phys_addr_t)(__x + PHYS_OFFSET) : 			\
+		   (phys_addr_t)(__x + PHYS_OFFSET + image_offset); })
+
 #define __phys_to_virt(x)	((unsigned long)((x) - PHYS_OFFSET + PAGE_OFFSET))
 
 /*
@@ -113,6 +120,8 @@ extern phys_addr_t		memstart_addr;
 /* PHYS_OFFSET - the physical address of the start of memory. */
 #define PHYS_OFFSET		({ memstart_addr; })
 
+extern u64 image_offset;
+
 /*
  * PFNs are used to describe any physical page; this means
  * PFN 0 == physical address 0.
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 208ca21868cc..729526a45f60 100644
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
index b7cdf4feb9f1..7241dd428462 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -84,7 +84,7 @@ SECTIONS
 		*(.discard.*)
 	}
 
-	. = PAGE_OFFSET + TEXT_OFFSET;
+	. = KIMAGE_VADDR + TEXT_OFFSET;
 
 	.head.text : {
 		_text = .;
@@ -195,4 +195,4 @@ ASSERT(SIZEOF(.pgdir) < ALIGNOF(.pgdir), ".pgdir size exceeds its alignment")
 /*
  * If padding is applied before .head.text, virt<->phys conversions will fail.
  */
-ASSERT(_text == (PAGE_OFFSET + TEXT_OFFSET), "HEAD is misaligned")
+ASSERT(_text == (KIMAGE_VADDR + TEXT_OFFSET), "HEAD is misaligned")
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index ea35ec911393..4e2d696c5b9e 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -49,6 +49,8 @@ u64 idmap_t0sz = TCR_T0SZ(VA_BITS);
 struct page *empty_zero_page;
 EXPORT_SYMBOL(empty_zero_page);
 
+u64 image_offset __read_mostly = KIMAGE_OFFSET;
+
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 			      unsigned long size, pgprot_t vma_prot)
 {
-- 
1.8.3.2
