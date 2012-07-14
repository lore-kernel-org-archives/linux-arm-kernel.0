From: robherring2@gmail.com (Rob Herring)
Date: Fri, 13 Jul 2012 21:03:57 -0500
Subject: [PATCH v2 01/15] ARM: Add fixed PCI i/o mapping
In-Reply-To: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
References: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
Message-ID: <1342231451-28861-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This adds a fixed virtual mapping for PCI i/o addresses. The mapping is
located at the last 2MB of vmalloc region (0xfee00000-0xff000000). 2MB
is used to align with PMD size, but IO_SPACE_LIMIT is 1MB. The space
is reserved just before .map_io and can be mapped at any time later with
pci_ioremap_io.

This has changed completely from the 1st implementation which only
supported creating the static mapping at .map_io.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nico@linaro.org>
---
 Documentation/arm/memory.txt    |    3 +++
 arch/arm/include/asm/io.h       |    8 ++++++++
 arch/arm/include/asm/mach/map.h |    7 +++++++
 arch/arm/include/asm/mach/pci.h |   15 +++++++++++++++
 arch/arm/kernel/bios32.c        |    1 +
 arch/arm/mm/ioremap.c           |   14 ++++++++++++++
 arch/arm/mm/mmu.c               |   25 +++++++++++++++++--------
 7 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/Documentation/arm/memory.txt b/Documentation/arm/memory.txt
index 208a2d4..83e9b18 100644
--- a/Documentation/arm/memory.txt
+++ b/Documentation/arm/memory.txt
@@ -51,6 +51,9 @@ ffc00000	ffefffff	DMA memory mapping region.  Memory returned
 ff000000	ffbfffff	Reserved for future expansion of DMA
 				mapping region.
 
+fef00000	feffffff	Mapping of PCI I/O space. This is a static
+				mapping within the vmalloc space.
+
 VMALLOC_START	VMALLOC_END-1	vmalloc() / ioremap() space.
 				Memory returned by vmalloc/ioremap will
 				be dynamically placed in this region.
diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 815c669..8f4db67 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -113,11 +113,19 @@ static inline void __iomem *__typesafe_io(unsigned long addr)
 #define __iowmb()		do { } while (0)
 #endif
 
+/* PCI fixed i/o mapping */
+#define PCI_IO_VIRT_BASE	0xfee00000
+
+extern int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr);
+
 /*
  * Now, pick up the machine-defined IO definitions
  */
 #ifdef CONFIG_NEED_MACH_IO_H
 #include <mach/io.h>
+#elif defined(CONFIG_PCI)
+#define IO_SPACE_LIMIT	((resource_size_t)0xfffff)
+#define __io(a)		__typesafe_io(PCI_IO_VIRT_BASE + ((a) & IO_SPACE_LIMIT))
 #else
 #define __io(a)		__typesafe_io((a) & IO_SPACE_LIMIT)
 #endif
diff --git a/arch/arm/include/asm/mach/map.h b/arch/arm/include/asm/mach/map.h
index a6efcdd..808c517 100644
--- a/arch/arm/include/asm/mach/map.h
+++ b/arch/arm/include/asm/mach/map.h
@@ -9,6 +9,9 @@
  *
  *  Page table mapping constructs and function prototypes
  */
+#ifndef __ASM_MACH_MAP_H
+#define __ASM_MACH_MAP_H
+
 #include <asm/io.h>
 
 struct map_desc {
@@ -34,6 +37,7 @@ struct map_desc {
 
 #ifdef CONFIG_MMU
 extern void iotable_init(struct map_desc *, int);
+extern void vm_reserve_area_early(unsigned long addr, unsigned long size);
 
 struct mem_type;
 extern const struct mem_type *get_mem_type(unsigned int type);
@@ -44,4 +48,7 @@ extern int ioremap_page(unsigned long virt, unsigned long phys,
 			const struct mem_type *mtype);
 #else
 #define iotable_init(map,num)	do { } while (0)
+#define vm_reserve_area_early(a,s)	do { } while (0)
+#endif
+
 #endif
diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index 26c511f..51630c0 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -11,6 +11,8 @@
 #ifndef __ASM_MACH_PCI_H
 #define __ASM_MACH_PCI_H
 
+#include <asm/mach/map.h>
+
 struct pci_sys_data;
 struct pci_ops;
 struct pci_bus;
@@ -55,6 +57,19 @@ struct pci_sys_data {
 void pci_common_init(struct hw_pci *);
 
 /*
+ * Setup fixed I/O mapping.
+ */
+#if defined(CONFIG_PCI) && !defined(CONFIG_NEED_MACH_IO_H)
+/* Called from devicemaps_init before .map_io */
+static inline void pci_reserve_io(void)
+{
+	vm_reserve_area_early(PCI_IO_VIRT_BASE, SZ_2M);
+}
+#else
+static inline void pci_reserve_io(void) {}
+#endif
+
+/*
  * PCI controllers
  */
 extern struct pci_ops iop3xx_ops;
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 2555250..311e1cc 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -13,6 +13,7 @@
 #include <linux/io.h>
 
 #include <asm/mach-types.h>
+#include <asm/mach/map.h>
 #include <asm/mach/pci.h>
 
 static int debug_pci;
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index 4f55f50..8727802 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -36,6 +36,7 @@
 #include <asm/system_info.h>
 
 #include <asm/mach/map.h>
+#include <asm/mach/pci.h>
 #include "mm.h"
 
 int ioremap_page(unsigned long virt, unsigned long phys,
@@ -383,3 +384,16 @@ void __arm_iounmap(volatile void __iomem *io_addr)
 	arch_iounmap(io_addr);
 }
 EXPORT_SYMBOL(__arm_iounmap);
+
+#ifdef CONFIG_PCI
+int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr)
+{
+	BUG_ON(offset + SZ_64K > IO_SPACE_LIMIT);
+
+	return ioremap_page_range(PCI_IO_VIRT_BASE + offset,
+				  PCI_IO_VIRT_BASE + offset + SZ_64K,
+				  phys_addr,
+				  __pgprot(get_mem_type(MT_DEVICE)->prot_pte));
+}
+EXPORT_SYMBOL_GPL(pci_ioremap_io);
+#endif
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index cf4528d..c5ca07b 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -31,6 +31,7 @@
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include <asm/mach/pci.h>
 
 #include "mm.h"
 
@@ -791,6 +792,18 @@ void __init iotable_init(struct map_desc *io_desc, int nr)
 	}
 }
 
+void __init vm_reserve_area_early(unsigned long addr, unsigned long size)
+{
+	struct vm_struct *vm;
+
+	vm = early_alloc_aligned(sizeof(*vm), __alignof__(*vm));
+	vm->addr = (void *)addr;
+	vm->size = size;
+	vm->flags = VM_IOREMAP | VM_ARM_STATIC_MAPPING;
+	vm->caller = vm_reserve_area_early;
+	vm_area_add_early(vm++);
+}
+
 #ifndef CONFIG_ARM_LPAE
 
 /*
@@ -808,14 +821,7 @@ void __init iotable_init(struct map_desc *io_desc, int nr)
 
 static void __init pmd_empty_section_gap(unsigned long addr)
 {
-	struct vm_struct *vm;
-
-	vm = early_alloc_aligned(sizeof(*vm), __alignof__(*vm));
-	vm->addr = (void *)addr;
-	vm->size = SECTION_SIZE;
-	vm->flags = VM_IOREMAP | VM_ARM_STATIC_MAPPING;
-	vm->caller = pmd_empty_section_gap;
-	vm_area_add_early(vm);
+	vm_reserve_area_early(addr, SECTION_SIZE);
 }
 
 static void __init fill_pmd_gaps(void)
@@ -1140,6 +1146,9 @@ static void __init devicemaps_init(struct machine_desc *mdesc)
 		create_mapping(&map);
 	}
 
+	/* Reserve fixed i/o space in VMALLOC region */
+	pci_reserve_io();
+
 	/*
 	 * Ask the machine support to map in the statically mapped devices.
 	 */
-- 
1.7.9.5
