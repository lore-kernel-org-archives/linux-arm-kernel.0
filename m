From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 15 Dec 2010 03:03:09 +0100
Subject: [PATCH 05/16] ARM: Always reassign PCI bus numbers.
In-Reply-To: <cover.1292377339.git.buytenh@wantstofly.org>
References: <cover.1292377339.git.buytenh@wantstofly.org>
Message-ID: <20101215020309.GX15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Out of all ARM platforms that implement pcibios_assign_all_busses(),
only three currently define it to zero:

- ep93xx, but this platform doesn't even support PCI.

- ixp2000 and ixp23xx, but while these platforms have restrictions
  on Linux reallocating BARs (which is problematic as there are
  several very large BARs in the PCI domain), there aren't really
  any restrictions on Linux reassigning bus numbers.

Therefore, this commit moves the definition of
pcibios_assign_all_busses() from the per-mach include directories
to <asm/pci.h>, and makes it always return 1.

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/include/asm/pci.h                       |    5 +++++
 arch/arm/mach-bcmring/include/mach/hardware.h    |    2 --
 arch/arm/mach-cns3xxx/include/mach/hardware.h    |    1 -
 arch/arm/mach-dove/include/mach/hardware.h       |    2 --
 arch/arm/mach-ep93xx/include/mach/hardware.h     |    2 --
 arch/arm/mach-footbridge/include/mach/hardware.h |    2 --
 arch/arm/mach-integrator/include/mach/hardware.h |    2 --
 arch/arm/mach-iop13xx/include/mach/hardware.h    |    2 --
 arch/arm/mach-iop32x/include/mach/hardware.h     |    1 -
 arch/arm/mach-iop33x/include/mach/hardware.h     |    1 -
 arch/arm/mach-ixp2000/include/mach/hardware.h    |    2 --
 arch/arm/mach-ixp23xx/include/mach/hardware.h    |    2 --
 arch/arm/mach-ixp4xx/include/mach/hardware.h     |    2 --
 arch/arm/mach-kirkwood/include/mach/hardware.h   |    2 --
 arch/arm/mach-ks8695/include/mach/hardware.h     |    2 --
 arch/arm/mach-mv78xx0/include/mach/hardware.h    |    2 --
 arch/arm/mach-orion5x/include/mach/hardware.h    |    2 --
 arch/arm/mach-pxa/include/mach/hardware.h        |    1 -
 arch/arm/mach-shark/include/mach/hardware.h      |    2 --
 arch/arm/mach-tegra/include/mach/hardware.h      |    1 -
 arch/arm/mach-versatile/include/mach/hardware.h  |    2 --
 21 files changed, 5 insertions(+), 35 deletions(-)

diff --git a/arch/arm/include/asm/pci.h b/arch/arm/include/asm/pci.h
index 92e2a83..038da6e 100644
--- a/arch/arm/include/asm/pci.h
+++ b/arch/arm/include/asm/pci.h
@@ -33,6 +33,11 @@ static inline void pcibios_set_master(struct pci_dev *dev)
 }
 #endif
 
+static inline int pcibios_assign_all_busses(void)
+{
+	return 1;
+}
+
 static inline void pcibios_penalize_isa_irq(int irq, int active)
 {
 	/* We don't do dynamic PCI IRQ allocation */
diff --git a/arch/arm/mach-bcmring/include/mach/hardware.h b/arch/arm/mach-bcmring/include/mach/hardware.h
index 447eb34..70b9f6f 100644
--- a/arch/arm/mach-bcmring/include/mach/hardware.h
+++ b/arch/arm/mach-bcmring/include/mach/hardware.h
@@ -36,8 +36,6 @@
 #define RAM_SIZE                (CFG_GLOBAL_RAM_SIZE-CFG_GLOBAL_RAM_SIZE_RESERVED)
 #define RAM_BASE                PAGE_OFFSET
 
-#define pcibios_assign_all_busses()	1
-
 /* Macros to make managing spinlocks a bit more controlled in terms of naming. */
 /* See reg_gpio.h, reg_irq.h, arch.c, gpio.c for example usage. */
 #if defined(__KERNEL__)
diff --git a/arch/arm/mach-cns3xxx/include/mach/hardware.h b/arch/arm/mach-cns3xxx/include/mach/hardware.h
index 57e0983..82a0d4e 100644
--- a/arch/arm/mach-cns3xxx/include/mach/hardware.h
+++ b/arch/arm/mach-cns3xxx/include/mach/hardware.h
@@ -17,6 +17,5 @@
 /* macro to get at IO space when running virtually */
 #define PCIBIOS_MIN_IO		0x00000000
 #define PCIBIOS_MIN_MEM		0x00000000
-#define pcibios_assign_all_busses()	1
 
 #endif
diff --git a/arch/arm/mach-dove/include/mach/hardware.h b/arch/arm/mach-dove/include/mach/hardware.h
index 32b0826..f619fb9 100644
--- a/arch/arm/mach-dove/include/mach/hardware.h
+++ b/arch/arm/mach-dove/include/mach/hardware.h
@@ -11,8 +11,6 @@
 
 #include "dove.h"
 
-#define pcibios_assign_all_busses()	1
-
 #define PCIBIOS_MIN_IO			0x1000
 #define PCIBIOS_MIN_MEM			0x01000000
 #define PCIMEM_BASE			DOVE_PCIE0_MEM_PHYS_BASE
diff --git a/arch/arm/mach-ep93xx/include/mach/hardware.h b/arch/arm/mach-ep93xx/include/mach/hardware.h
index 5a3ce02..4df8428 100644
--- a/arch/arm/mach-ep93xx/include/mach/hardware.h
+++ b/arch/arm/mach-ep93xx/include/mach/hardware.h
@@ -8,8 +8,6 @@
 #include <mach/ep93xx-regs.h>
 #include <mach/platform.h>
 
-#define pcibios_assign_all_busses()	0
-
 /*
  * The EP93xx has two external crystal oscillators.  To generate the
  * required high-frequency clocks, the processor uses two phase-locked-
diff --git a/arch/arm/mach-footbridge/include/mach/hardware.h b/arch/arm/mach-footbridge/include/mach/hardware.h
index 51dd902..541aa70 100644
--- a/arch/arm/mach-footbridge/include/mach/hardware.h
+++ b/arch/arm/mach-footbridge/include/mach/hardware.h
@@ -93,8 +93,6 @@ extern unsigned int nw_gpio_read(void);
 extern void nw_cpld_modify(unsigned int mask, unsigned int set);
 #endif
 
-#define pcibios_assign_all_busses()	1
-
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM 	0x81000000
 
diff --git a/arch/arm/mach-integrator/include/mach/hardware.h b/arch/arm/mach-integrator/include/mach/hardware.h
index 57f51ba..37323ea 100644
--- a/arch/arm/mach-integrator/include/mach/hardware.h
+++ b/arch/arm/mach-integrator/include/mach/hardware.h
@@ -34,8 +34,6 @@
 
 #define PCIMEM_BASE		PCI_MEMORY_VADDR
 
-#define pcibios_assign_all_busses()	1
-
 #define PCIBIOS_MIN_IO		0x6000
 #define PCIBIOS_MIN_MEM 	0x00100000
 
diff --git a/arch/arm/mach-iop13xx/include/mach/hardware.h b/arch/arm/mach-iop13xx/include/mach/hardware.h
index 8e1d562..ba81e50 100644
--- a/arch/arm/mach-iop13xx/include/mach/hardware.h
+++ b/arch/arm/mach-iop13xx/include/mach/hardware.h
@@ -2,8 +2,6 @@
 #define __ASM_ARCH_HARDWARE_H
 #include <asm/types.h>
 
-#define pcibios_assign_all_busses() 1
-
 #ifndef __ASSEMBLY__
 extern unsigned long iop13xx_pcibios_min_io;
 extern unsigned long iop13xx_pcibios_min_mem;
diff --git a/arch/arm/mach-iop32x/include/mach/hardware.h b/arch/arm/mach-iop32x/include/mach/hardware.h
index d559c4e..e68bf97 100644
--- a/arch/arm/mach-iop32x/include/mach/hardware.h
+++ b/arch/arm/mach-iop32x/include/mach/hardware.h
@@ -18,7 +18,6 @@
  * but when we read them, we convert them to virtual addresses. See
  * arch/arm/plat-iop/pci.c.
  */
-#define pcibios_assign_all_busses() 1
 #define PCIBIOS_MIN_IO		0x00000000
 #define PCIBIOS_MIN_MEM		0x00000000
 
diff --git a/arch/arm/mach-iop33x/include/mach/hardware.h b/arch/arm/mach-iop33x/include/mach/hardware.h
index 8c10e43..215065b 100644
--- a/arch/arm/mach-iop33x/include/mach/hardware.h
+++ b/arch/arm/mach-iop33x/include/mach/hardware.h
@@ -18,7 +18,6 @@
  * but when we read them, we convert them to virtual addresses.  See
  * arch/arm/mach-iop3xx/iop3xx-pci.c
  */
-#define pcibios_assign_all_busses()	1
 #define PCIBIOS_MIN_IO		0x00000000
 #define PCIBIOS_MIN_MEM		0x00000000
 
diff --git a/arch/arm/mach-ixp2000/include/mach/hardware.h b/arch/arm/mach-ixp2000/include/mach/hardware.h
index f033de4..6c92008 100644
--- a/arch/arm/mach-ixp2000/include/mach/hardware.h
+++ b/arch/arm/mach-ixp2000/include/mach/hardware.h
@@ -27,8 +27,6 @@
 
 #include "ixp2000-regs.h"	/* Chipset Registers */
 
-#define pcibios_assign_all_busses() 0
-
 /*
  * Platform helper functions
  */
diff --git a/arch/arm/mach-ixp23xx/include/mach/hardware.h b/arch/arm/mach-ixp23xx/include/mach/hardware.h
index 57b508b..b8bb781 100644
--- a/arch/arm/mach-ixp23xx/include/mach/hardware.h
+++ b/arch/arm/mach-ixp23xx/include/mach/hardware.h
@@ -20,8 +20,6 @@
 
 #include "ixp23xx.h"
 
-#define pcibios_assign_all_busses()	0
-
 /*
  * Platform helper functions
  */
diff --git a/arch/arm/mach-ixp4xx/include/mach/hardware.h b/arch/arm/mach-ixp4xx/include/mach/hardware.h
index 8138371..163e506 100644
--- a/arch/arm/mach-ixp4xx/include/mach/hardware.h
+++ b/arch/arm/mach-ixp4xx/include/mach/hardware.h
@@ -28,8 +28,6 @@
 
 #define ARCH_HAS_DMA_SET_COHERENT_MASK
 
-#define pcibios_assign_all_busses()	1
-
 /* Register locations and bits */
 #include "ixp4xx-regs.h"
 
diff --git a/arch/arm/mach-kirkwood/include/mach/hardware.h b/arch/arm/mach-kirkwood/include/mach/hardware.h
index cde8528..79f0641 100644
--- a/arch/arm/mach-kirkwood/include/mach/hardware.h
+++ b/arch/arm/mach-kirkwood/include/mach/hardware.h
@@ -11,8 +11,6 @@
 
 #include "kirkwood.h"
 
-#define pcibios_assign_all_busses()	1
-
 #define PCIBIOS_MIN_IO			0x00001000
 #define PCIBIOS_MIN_MEM			0x01000000
 #define PCIMEM_BASE			KIRKWOOD_PCIE_MEM_PHYS_BASE /* mem base for VGA */
diff --git a/arch/arm/mach-ks8695/include/mach/hardware.h b/arch/arm/mach-ks8695/include/mach/hardware.h
index e0f911d..a46be88 100644
--- a/arch/arm/mach-ks8695/include/mach/hardware.h
+++ b/arch/arm/mach-ks8695/include/mach/hardware.h
@@ -46,8 +46,6 @@
 /*
  * PCI support
  */
-#define pcibios_assign_all_busses()	1
-
 #define PCIBIOS_MIN_IO		0
 #define PCIBIOS_MIN_MEM		0
 
diff --git a/arch/arm/mach-mv78xx0/include/mach/hardware.h b/arch/arm/mach-mv78xx0/include/mach/hardware.h
index 5d88755..c76b93f 100644
--- a/arch/arm/mach-mv78xx0/include/mach/hardware.h
+++ b/arch/arm/mach-mv78xx0/include/mach/hardware.h
@@ -11,8 +11,6 @@
 
 #include "mv78xx0.h"
 
-#define pcibios_assign_all_busses()	1
-
 #define PCIBIOS_MIN_IO			0x00001000
 #define PCIBIOS_MIN_MEM			0x01000000
 #define PCIMEM_BASE			MV78XX0_PCIE_MEM_PHYS_BASE /* mem base for VGA */
diff --git a/arch/arm/mach-orion5x/include/mach/hardware.h b/arch/arm/mach-orion5x/include/mach/hardware.h
index e51aaf4..a42b743 100644
--- a/arch/arm/mach-orion5x/include/mach/hardware.h
+++ b/arch/arm/mach-orion5x/include/mach/hardware.h
@@ -11,8 +11,6 @@
 
 #include "orion5x.h"
 
-#define pcibios_assign_all_busses()	1
-
 #define PCIBIOS_MIN_IO		0x00001000
 #define PCIBIOS_MIN_MEM		0x01000000
 #define PCIMEM_BASE		ORION5X_PCIE_MEM_PHYS_BASE
diff --git a/arch/arm/mach-pxa/include/mach/hardware.h b/arch/arm/mach-pxa/include/mach/hardware.h
index 814f145..ad448af 100644
--- a/arch/arm/mach-pxa/include/mach/hardware.h
+++ b/arch/arm/mach-pxa/include/mach/hardware.h
@@ -320,7 +320,6 @@ extern unsigned long get_clock_tick_rate(void);
 #if defined(CONFIG_MACH_ARMCORE) && defined(CONFIG_PCI)
 #define PCIBIOS_MIN_IO		0
 #define PCIBIOS_MIN_MEM		0
-#define pcibios_assign_all_busses()	1
 #define ARCH_HAS_DMA_SET_COHERENT_MASK
 #endif
 
diff --git a/arch/arm/mach-shark/include/mach/hardware.h b/arch/arm/mach-shark/include/mach/hardware.h
index 94d84b2..24639ce 100644
--- a/arch/arm/mach-shark/include/mach/hardware.h
+++ b/arch/arm/mach-shark/include/mach/hardware.h
@@ -12,8 +12,6 @@
 
 #define UNCACHEABLE_ADDR        0xdf010000
 
-#define pcibios_assign_all_busses()     1
-
 #define PCIBIOS_MIN_IO          0x6000
 #define PCIBIOS_MIN_MEM         0x50000000
 #define PCIMEM_BASE		0xe8000000
diff --git a/arch/arm/mach-tegra/include/mach/hardware.h b/arch/arm/mach-tegra/include/mach/hardware.h
index 56e43b3..84c2658 100644
--- a/arch/arm/mach-tegra/include/mach/hardware.h
+++ b/arch/arm/mach-tegra/include/mach/hardware.h
@@ -23,6 +23,5 @@
 
 #define PCIBIOS_MIN_IO			0x1000
 #define PCIBIOS_MIN_MEM			0
-#define pcibios_assign_all_busses()	1
 
 #endif
diff --git a/arch/arm/mach-versatile/include/mach/hardware.h b/arch/arm/mach-versatile/include/mach/hardware.h
index b5e75bb..74e0ea8 100644
--- a/arch/arm/mach-versatile/include/mach/hardware.h
+++ b/arch/arm/mach-versatile/include/mach/hardware.h
@@ -34,8 +34,6 @@
 #define PCIBIOS_MIN_IO			0x44000000
 #define PCIBIOS_MIN_MEM			0x50000000
 
-#define pcibios_assign_all_busses()     1
-
 /* macro to get at IO space when running virtually */
 #define IO_ADDRESS(x)		(((x) & 0x0fffffff) + (((x) >> 4) & 0x0f000000) + 0xf0000000)
 
-- 
1.7.1
