From: robherring2@gmail.com (Rob Herring)
Date: Fri,  6 Jul 2012 13:40:26 -0500
Subject: [PATCH 01/15] ARM: Add fixed PCI i/o mapping
In-Reply-To: <1341600040-30993-1-git-send-email-robherring2@gmail.com>
References: <1341600040-30993-1-git-send-email-robherring2@gmail.com>
Message-ID: <1341600040-30993-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This adds a fixed virtual mapping for PCI i/o addresses. The mapping is
located at the last 2MB of vmalloc region (0xfee00000-0xff000000).

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
Acked-by: Nicolas Pitre <nico@linaro.org>
---
 Documentation/arm/memory.txt    |    3 +++
 arch/arm/include/asm/io.h       |    5 +++++
 arch/arm/include/asm/mach/pci.h |   18 ++++++++++++++++++
 arch/arm/kernel/bios32.c        |   20 ++++++++++++++++++++
 4 files changed, 46 insertions(+)

diff --git a/Documentation/arm/memory.txt b/Documentation/arm/memory.txt
index 208a2d4..4bfb9ff 100644
--- a/Documentation/arm/memory.txt
+++ b/Documentation/arm/memory.txt
@@ -51,6 +51,9 @@ ffc00000	ffefffff	DMA memory mapping region.  Memory returned
 ff000000	ffbfffff	Reserved for future expansion of DMA
 				mapping region.
 
+fee00000	feffffff	Mapping of PCI I/O space. This is a static
+				mapping within the vmalloc space.
+
 VMALLOC_START	VMALLOC_END-1	vmalloc() / ioremap() space.
 				Memory returned by vmalloc/ioremap will
 				be dynamically placed in this region.
diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 815c669..e8bb4d2 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -113,11 +113,16 @@ static inline void __iomem *__typesafe_io(unsigned long addr)
 #define __iowmb()		do { } while (0)
 #endif
 
+#define PCI_IO_VIRT_BASE	0xfee00000
+
 /*
  * Now, pick up the machine-defined IO definitions
  */
 #ifdef CONFIG_NEED_MACH_IO_H
 #include <mach/io.h>
+#elif defined(CONFIG_PCI)
+#define IO_SPACE_LIMIT	((resource_size_t)0x1fffff)
+#define __io(a)		__typesafe_io(PCI_IO_VIRT_BASE + ((a) & IO_SPACE_LIMIT))
 #else
 #define __io(a)		__typesafe_io((a) & IO_SPACE_LIMIT)
 #endif
diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index 26c511f..20a04af 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -55,6 +55,24 @@ struct pci_sys_data {
 void pci_common_init(struct hw_pci *);
 
 /*
+ * Setup fixed I/O mapping. Must be called from .map_io function.
+ */
+#ifdef CONFIG_PCI
+extern void pci_map_io_pfn(unsigned long pfn[], int nr, int size);
+#else
+static inline void pci_map_io_pfn(unsigned long pfn[], int nr, int size) {}
+#endif
+static inline void __init pci_map_io_single_pfn(unsigned long pfn)
+{
+	pci_map_io_pfn(&pfn, 1, SZ_1M);
+}
+
+static inline void __init pci_map_io_single(unsigned long paddr)
+{
+	pci_map_io_single_pfn(__phys_to_pfn(paddr));
+}
+
+/*
  * PCI controllers
  */
 extern struct pci_ops iop3xx_ops;
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 2555250..0ea0135 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -13,6 +13,7 @@
 #include <linux/io.h>
 
 #include <asm/mach-types.h>
+#include <asm/mach/map.h>
 #include <asm/mach/pci.h>
 
 static int debug_pci;
@@ -627,3 +628,22 @@ int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 
 	return 0;
 }
+
+static struct map_desc pci_io_desc __initdata = {
+	.virtual	= PCI_IO_VIRT_BASE,
+	.type		= MT_DEVICE,
+};
+
+void __init pci_map_io_pfn(unsigned long pfn[], int nr, int size)
+{
+	int i;
+
+	pci_io_desc.length = size;
+
+	for (i = 0; i < nr; i++) {
+		pci_io_desc.pfn = pfn[i];
+		iotable_init(&pci_io_desc, 1);
+
+		pci_io_desc.virtual += size;
+	}
+}
-- 
1.7.9.5
