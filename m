From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Feb 2012 17:16:26 +0000
Subject: [PATCH 13/15] ARM: make mach/io.h include optional
In-Reply-To: <4F3A7158.2080702@gmail.com>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
 <201202140804.49026.arnd@arndb.de> <4F3A7158.2080702@gmail.com>
Message-ID: <201202141716.26930.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 February 2012, Rob Herring wrote:
> On 02/14/2012 02:04 AM, Arnd Bergmann wrote:
> > On Tuesday 14 February 2012, Rob Herring wrote:
> > 
> >> If we use CONFIG_PCI, then we have to move over all PCI enabled
> >> platforms at once. With a separate kconfig option, then we can move
> >> platforms one by one. Some are legacy and we may not want to move. This
> >> also helped with omap, but Tony has now fixed it.
> > 
> > We could also generalize the implementation from tegra, which seems
> > reasonable as a start:
> > 
> > 
> > #define IO_SPACE_LIMIT 0xffff
> > 
> > #if defined(CONFIG_ISA) || defined(CONFIG_PCCARD)
> > #include <mach/io.h>
> > #elif defined(CONFIG_PCI)
> > extern void __iomem *pci_io_base;
> > 
> > static inline void __iomem *__io(unsigned long addr)
> > {
> >         return pci_io_base + (addr & IO_SPACE_LIMIT);
> 
> But don't we want a constant pci_io_base? This would certainly be a
> quicker conversion, but I don't think we want to do it twice.

Yes, at least in the long run. Note that this should make no difference
at all from a performance point of view, but it does impact code size a bit.

> > }
> > #else
> > static inline void __iomem *__io(unsigned long addr)
> > {
> >         return NULL;
> > }
> > #endif
> > #define __io(a) __io(a)
> > 
> > Out of the platforms supporting PCI right now, we currently have these three classes:
> > 
> > 1. portable, but using different virtual addresses:
> > arch/arm/mach-integrator/include/mach/io.h:#define __io(a)                      ((void __iomem *)(PCI_IO_VADDR + (a)))
> > arch/arm/mach-ixp23xx/include/mach/io.h:#define __io(p)         ((void __iomem*)((p) + IXP23XX_PCI_IO_VIRT))
> > arch/arm/mach-ixp2000/include/mach/io.h:#define __io(p)                 ((void __iomem *)((p)+IXP2000_PCI_IO_VIRT_BASE))
> > arch/arm/mach-shark/include/mach/io.h:#define __io(a)                 ((void __iomem *)(0xe0000000 + (a)))
> > arch/arm/mach-footbridge/include/mach/io.h:#define __io(a)                      ((void __iomem *)(PCIO_BASE + (a)))
> > arch/arm/mach-tegra/include/mach/io.h:static inline void __iomem *__io(unsigned long addr)
> > arch/arm/mach-kirkwood/include/mach/io.h:static inline void __iomem *__io(unsigned long addr)
> > arch/arm/mach-dove/include/mach/io.h:#define __io(a)    ((void __iomem *)(((a) - DOVE_PCIE0_IO_BUS_BASE) + \
> > 
> > 2. Does not map the I/O space, or does not use it -- I cannot see how
> >    any of these use PIO based PCI devices at all, probably broken already:
> > arch/arm/mach-cns3xxx/include/mach/io.h:#define __io(a)                 __typesafe_io(a)
> > arch/arm/mach-ixp4xx/include/mach/io.h:#define  __io(v)         __typesafe_io(v)
> > arch/arm/mach-ks8695/include/mach/io.h:#define __io(a)          __typesafe_io(a)
> > arch/arm/mach-orion5x/include/mach/io.h:#define __io(a)                 __typesafe_io(a)
> > arch/arm/mach-sa1100/include/mach/io.h:#define __io(a)          __typesafe_io(a)
> > arch/arm/mach-pxa/include/mach/io.h:#define __io(a)             __typesafe_io(a)
> > arch/arm/mach-versatile/include/mach/io.h:#define __io(a)               __typesafe_io(a)
> > 
> > 3. scary multi-way translation, needs someone to really understand (Nico?, Lennert?)
> > arch/arm/mach-iop32x/include/mach/io.h:#define __io(p)          ((void __iomem *)IOP3XX_PCI_IO_PHYS_TO_VIRT(p))
> > arch/arm/mach-iop33x/include/mach/io.h:#define __io(p)          ((void __iomem *)IOP3XX_PCI_IO_PHYS_TO_VIRT(p))
> > arch/arm/mach-iop13xx/include/mach/io.h:#define __io(a) __iop13xx_io(a)
> > arch/arm/mach-mv78xx0/include/mach/io.h:static inline void __iomem *__io(unsigned long addr)
> > 
> > I think if we can figure out the third category, this should all become
> > fairly easy for PCI based platforms.
> > 
> 
> This looks correct AFAICT.
> 
> We could just call the 3rd category legacy and move on.

I'm not ready to give up that fast. The platforms seem to be implemented
reasonably well compared to category 2, but they can't be converted in
a completely mechanical way. The patch below should put iop13xx it into
category 1, but it really needs testing and review by a person who
understands that platform. I can also take a look at the others if we
agree that this is the right approach.

When we have all platforms done in that way, we can move the virtual
mapping base to a fixed location.

8<--------------
[PATCH] iop13xx: use more regular PCI I/O space handling

iop13xx confuses I/O port numbers with physical addresses, which breaks
legacy ISA I/O access behind PCI bridges and makes it unnecessarily hard
to unify the inb/outb accessors with other platforms. This removes the
special-casing and just puts all I/O ports into a single 128KB virtually
mapped I/O port range starting at port zero.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-iop13xx/include/mach/io.h      |    6 +++-
 arch/arm/mach-iop13xx/include/mach/iop13xx.h |   12 ++--------
 arch/arm/mach-iop13xx/io.c                   |   27 --------------------------
 arch/arm/mach-iop13xx/pci.c                  |   12 +++++-----
 4 files changed, 13 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-iop13xx/include/mach/io.h b/arch/arm/mach-iop13xx/include/mach/io.h
index dffb234..90bb7df 100644
--- a/arch/arm/mach-iop13xx/include/mach/io.h
+++ b/arch/arm/mach-iop13xx/include/mach/io.h
@@ -19,9 +19,11 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT 0xffffffff
+#include <mach/iop13xx.h>
 
-#define __io(a) __iop13xx_io(a)
+#define IO_SPACE_LIMIT (IOP13XX_PCIE_IO_WINDOW_SIZE + IOP13XX_PCIX_IO_WINDOW_SIZE - 1)
+
+#define __io(a) (IOP13XX_PCIX_LOWER_IO_VA + ((a) & IO_SPACE_LIMIT))
 #define __mem_pci(a) (a)
 #define __mem_isa(a) (a)
 
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
index 48642e6..7a1ab4d 100644
--- a/arch/arm/mach-iop13xx/io.c
+++ b/arch/arm/mach-iop13xx/io.c
@@ -21,25 +21,6 @@
 #include <linux/io.h>
 #include <mach/hardware.h>
 
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
 void * __iomem __iop13xx_ioremap(unsigned long cookie, size_t size,
 	unsigned int mtype)
 {
@@ -65,12 +46,6 @@ void * __iomem __iop13xx_ioremap(unsigned long cookie, size_t size,
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
@@ -100,8 +75,6 @@ void __iop13xx_iounmap(void __iomem *addr)
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
