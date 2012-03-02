From: robherring2@gmail.com (Rob Herring)
Date: Thu,  1 Mar 2012 21:13:32 -0600
Subject: [PATCH v3 20/30] iop13xx: use more regular PCI I/O space handling
In-Reply-To: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
References: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
Message-ID: <1330658022-14559-21-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

iop13xx confuses I/O port numbers with physical addresses, which breaks
legacy ISA I/O access behind PCI bridges and makes it unnecessarily hard
to unify the inb/outb accessors with other platforms. This removes the
special-casing and just puts all I/O ports into a single 128KB virtually
mapped I/O port range starting at port zero.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-iop13xx/include/mach/io.h      |    6 ++--
 arch/arm/mach-iop13xx/include/mach/iop13xx.h |   12 ++--------
 arch/arm/mach-iop13xx/io.c                   |   27 --------------------------
 arch/arm/mach-iop13xx/pci.c                  |   12 +++++-----
 4 files changed, 12 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mach-iop13xx/include/mach/io.h b/arch/arm/mach-iop13xx/include/mach/io.h
index f131885..e197cb8 100644
--- a/arch/arm/mach-iop13xx/include/mach/io.h
+++ b/arch/arm/mach-iop13xx/include/mach/io.h
@@ -19,10 +19,10 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT 0xffffffff
+#include <mach/iop13xx.h>
 
-#define __io(a) __iop13xx_io(a)
+#define IO_SPACE_LIMIT (IOP13XX_PCIE_IO_WINDOW_SIZE + IOP13XX_PCIX_IO_WINDOW_SIZE - 1)
 
-extern void __iomem * __iop13xx_io(unsigned long io_addr);
+#define __io(a) (IOP13XX_PCIX_LOWER_IO_VA + ((a) & IO_SPACE_LIMIT))
 
 #endif
diff --git a/arch/arm/mach-iop13xx/include/mach/iop13xx.h b/arch/arm/mach-iop13xx/include/mach/iop13xx.h
index 07e9ff7..ee1dfd2 100644
--- a/arch/arm/mach-iop13xx/include/mach/iop13xx.h
+++ b/arch/arm/mach-iop13xx/include/mach/iop13xx.h
@@ -68,17 +68,15 @@ extern unsigned long get_iop_tick_rate(void);
  * 0x8000.0000 + 928M	0x2.8000.0000   (ioremap)	PCIE outbound memory window
  *
  * IO MAP
- * 0x1000 + 64K	0x0.fffb.1000	0xfec6.1000	PCIX outbound i/o window
+ * 0x1000 + 64K	0x0.fffb.1000	0xfed6.1000	PCIX outbound i/o window
  * 0x1000 + 64K	0x0.fffd.1000	0xfed7.1000	PCIE outbound i/o window
  */
 #define IOP13XX_PCIX_IO_WINDOW_SIZE   0x10000UL
 #define IOP13XX_PCIX_LOWER_IO_PA      0xfffb0000UL
-#define IOP13XX_PCIX_LOWER_IO_VA      0xfec60000UL
+#define IOP13XX_PCIX_LOWER_IO_VA      0xfed60000UL
 #define IOP13XX_PCIX_LOWER_IO_BA      0x0UL /* OIOTVR */
 #define IOP13XX_PCIX_IO_BUS_OFFSET    0x1000UL
-#define IOP13XX_PCIX_UPPER_IO_PA      (IOP13XX_PCIX_LOWER_IO_PA +\
-				       IOP13XX_PCIX_IO_WINDOW_SIZE - 1)
-#define IOP13XX_PCIX_UPPER_IO_VA      (IOP13XX_PCIX_LOWER_IO_VA +\
+#define IOP13XX_PCIX_UPPER_IO_BA      (IOP13XX_PCIX_LOWER_IO_BA +\
 				       IOP13XX_PCIX_IO_WINDOW_SIZE - 1)
 #define IOP13XX_PCIX_IO_PHYS_TO_VIRT(addr) (u32) ((u32) addr -\
 					   (IOP13XX_PCIX_LOWER_IO_PA\
@@ -107,10 +105,6 @@ extern unsigned long get_iop_tick_rate(void);
 #define IOP13XX_PCIE_LOWER_IO_VA      	 0xfed70000UL
 #define IOP13XX_PCIE_LOWER_IO_BA      	 0x0UL  /* OIOTVR */
 #define IOP13XX_PCIE_IO_BUS_OFFSET	 0x1000UL
-#define IOP13XX_PCIE_UPPER_IO_PA      	 (IOP13XX_PCIE_LOWER_IO_PA +\
-					 IOP13XX_PCIE_IO_WINDOW_SIZE - 1)
-#define IOP13XX_PCIE_UPPER_IO_VA      	 (IOP13XX_PCIE_LOWER_IO_VA +\
-					 IOP13XX_PCIE_IO_WINDOW_SIZE - 1)
 #define IOP13XX_PCIE_UPPER_IO_BA      	 (IOP13XX_PCIE_LOWER_IO_BA +\
 					 IOP13XX_PCIE_IO_WINDOW_SIZE - 1)
 #define IOP13XX_PCIE_IO_PHYS_TO_VIRT(addr) (u32) ((u32) addr -\
diff --git a/arch/arm/mach-iop13xx/io.c b/arch/arm/mach-iop13xx/io.c
index 70f716f..e0ecb38 100644
--- a/arch/arm/mach-iop13xx/io.c
+++ b/arch/arm/mach-iop13xx/io.c
@@ -23,25 +23,6 @@
 
 #include "pci.h"
 
-void * __iomem __iop13xx_io(unsigned long io_addr)
-{
-	void __iomem * io_virt;
-
-	switch (io_addr) {
-	case IOP13XX_PCIE_LOWER_IO_PA ... IOP13XX_PCIE_UPPER_IO_PA:
-		io_virt = (void *) IOP13XX_PCIE_IO_PHYS_TO_VIRT(io_addr);
-		break;
-	case IOP13XX_PCIX_LOWER_IO_PA ... IOP13XX_PCIX_UPPER_IO_PA:
-		io_virt = (void *) IOP13XX_PCIX_IO_PHYS_TO_VIRT(io_addr);
-		break;
-	default:
-		BUG();
-	}
-
-	return io_virt;
-}
-EXPORT_SYMBOL(__iop13xx_io);
-
 void __iomem * __iop13xx_ioremap(unsigned long cookie, size_t size,
 	unsigned int mtype)
 {
@@ -67,12 +48,6 @@ void __iomem * __iop13xx_ioremap(unsigned long cookie, size_t size,
 				       (cookie - IOP13XX_PBI_LOWER_MEM_RA),
 				       size, mtype, __builtin_return_address(0));
 		break;
-	case IOP13XX_PCIE_LOWER_IO_PA ... IOP13XX_PCIE_UPPER_IO_PA:
-		retval = (void *) IOP13XX_PCIE_IO_PHYS_TO_VIRT(cookie);
-		break;
-	case IOP13XX_PCIX_LOWER_IO_PA ... IOP13XX_PCIX_UPPER_IO_PA:
-		retval = (void *) IOP13XX_PCIX_IO_PHYS_TO_VIRT(cookie);
-		break;
 	case IOP13XX_PMMR_PHYS_MEM_BASE ... IOP13XX_PMMR_UPPER_MEM_PA:
 		retval = (void *) IOP13XX_PMMR_PHYS_TO_VIRT(cookie);
 		break;
@@ -102,8 +77,6 @@ void __iop13xx_iounmap(volatile void __iomem *addr)
 		    goto skip;
 
 	switch ((u32) addr) {
-	case IOP13XX_PCIE_LOWER_IO_VA ... IOP13XX_PCIE_UPPER_IO_VA:
-	case IOP13XX_PCIX_LOWER_IO_VA ... IOP13XX_PCIX_UPPER_IO_VA:
 	case IOP13XX_PMMR_VIRT_MEM_BASE ... IOP13XX_PMMR_UPPER_MEM_VA:
 		goto skip;
 	}
diff --git a/arch/arm/mach-iop13xx/pci.c b/arch/arm/mach-iop13xx/pci.c
index b8f5a87..d72eddf 100644
--- a/arch/arm/mach-iop13xx/pci.c
+++ b/arch/arm/mach-iop13xx/pci.c
@@ -1042,8 +1042,8 @@ int iop13xx_pci_setup(int nr, struct pci_sys_data *sys)
 				  << IOP13XX_ATUX_PCIXSR_FUNC_NUM;
 		__raw_writel(pcixsr, IOP13XX_ATUX_PCIXSR);
 
-		res[0].start = IOP13XX_PCIX_LOWER_IO_PA + IOP13XX_PCIX_IO_BUS_OFFSET;
-		res[0].end   = IOP13XX_PCIX_UPPER_IO_PA;
+		res[0].start = IOP13XX_PCIX_LOWER_IO_BA + IOP13XX_PCIX_IO_BUS_OFFSET;
+		res[0].end   = IOP13XX_PCIX_UPPER_IO_BA;
 		res[0].name  = "IQ81340 ATUX PCI I/O Space";
 		res[0].flags = IORESOURCE_IO;
 
@@ -1052,7 +1052,7 @@ int iop13xx_pci_setup(int nr, struct pci_sys_data *sys)
 		res[1].name  = "IQ81340 ATUX PCI Memory Space";
 		res[1].flags = IORESOURCE_MEM;
 		sys->mem_offset = IOP13XX_PCIX_MEM_OFFSET;
-		sys->io_offset = IOP13XX_PCIX_LOWER_IO_PA;
+		sys->io_offset = IOP13XX_PCIX_LOWER_IO_BA;
 		break;
 	case IOP13XX_INIT_ATU_ATUE:
 		/* Note: the function number field in the PCSR is ro */
@@ -1063,8 +1063,8 @@ int iop13xx_pci_setup(int nr, struct pci_sys_data *sys)
 
 		__raw_writel(pcsr, IOP13XX_ATUE_PCSR);
 
-		res[0].start = IOP13XX_PCIE_LOWER_IO_PA + IOP13XX_PCIE_IO_BUS_OFFSET;
-		res[0].end   = IOP13XX_PCIE_UPPER_IO_PA;
+		res[0].start = IOP13XX_PCIE_LOWER_IO_BA + IOP13XX_PCIE_IO_BUS_OFFSET;
+		res[0].end   = IOP13XX_PCIE_UPPER_IO_BA;
 		res[0].name  = "IQ81340 ATUE PCI I/O Space";
 		res[0].flags = IORESOURCE_IO;
 
@@ -1073,7 +1073,7 @@ int iop13xx_pci_setup(int nr, struct pci_sys_data *sys)
 		res[1].name  = "IQ81340 ATUE PCI Memory Space";
 		res[1].flags = IORESOURCE_MEM;
 		sys->mem_offset = IOP13XX_PCIE_MEM_OFFSET;
-		sys->io_offset = IOP13XX_PCIE_LOWER_IO_PA;
+		sys->io_offset = IOP13XX_PCIE_LOWER_IO_BA;
 		sys->map_irq = iop13xx_pcie_map_irq;
 		break;
 	default:
-- 
1.7.5.4
