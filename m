From: robherring2@gmail.com (Rob Herring)
Date: Thu,  1 Mar 2012 21:13:33 -0600
Subject: [PATCH v3 21/30] ARM: Add fixed PCI i/o mapping
In-Reply-To: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
References: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
Message-ID: <1330658022-14559-22-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This adds a fixed virtual mapping for PCI i/o addresses. The mapping is
located at the last 1MB of vmalloc region (0xfef00000).

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/include/asm/io.h       |    5 +++++
 arch/arm/include/asm/mach/pci.h |   18 ++++++++++++++++++
 arch/arm/kernel/bios32.c        |   23 +++++++++++++++++++++++
 3 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index d7861b9..5a01930 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -106,11 +106,16 @@ static inline void __iomem *__typesafe_io(unsigned long addr)
 #define __iowmb()		do { } while (0)
 #endif
 
+#define PCI_IO_VIRT_BASE	0xfef00000
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
 #define __io(a)		({ (void)(a); __typesafe_io(0); })
 #endif
diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index d943b7d..6d326d7 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -60,6 +60,24 @@ struct pci_sys_data {
 void pci_common_init(struct hw_pci *);
 
 /*
+ * Setup fixed I/O mapping. Must be called from .map_io function.
+ */
+#ifdef CONFIG_PCI
+extern void pci_map_io_pfn(unsigned long pfn[], int nr);
+#else
+static inline void pci_map_io_pfn(unsigned long pfn[], int nr) {}
+#endif
+static inline void __init pci_map_io_single_pfn(unsigned long pfn)
+{
+	pci_map_io_pfn(&pfn, 1);
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
 extern int iop3xx_pci_setup(int nr, struct pci_sys_data *);
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index f58ba35..199f383 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -13,6 +13,7 @@
 #include <linux/io.h>
 
 #include <asm/mach-types.h>
+#include <asm/mach/map.h>
 #include <asm/mach/pci.h>
 
 static int debug_pci;
@@ -674,3 +675,25 @@ int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 
 	return 0;
 }
+
+static struct map_desc pci_io_desc __initdata = {
+	.virtual	= PCI_IO_VIRT_BASE,
+	.length		= SZ_1M,
+	.type		= MT_DEVICE,
+};
+
+void __init pci_map_io_pfn(unsigned long pfn[], int nr)
+{
+	int i;
+
+	if (nr > 1)
+		pci_io_desc.length = SZ_64K;
+
+	for (i = 0; i < nr; i++) {
+		pci_io_desc.pfn = pfn[i];
+		iotable_init(&pci_io_desc, 1);
+
+		pci_io_desc.virtual += SZ_64K;
+	}
+}
+
-- 
1.7.5.4
