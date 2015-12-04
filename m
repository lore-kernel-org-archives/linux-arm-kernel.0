From: arnd@arndb.de (Arnd Bergmann)
Date: Fri,  4 Dec 2015 23:30:42 +0100
Subject: [PATCH 10/10] ARM: orion/mvebu: unify debug-ll virtual addresses
In-Reply-To: <1449268242-808553-1-git-send-email-arnd@arndb.de>
References: <1449268242-808553-1-git-send-email-arnd@arndb.de>
Message-ID: <1449268242-808553-11-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In a multiplatform configuration, enabling DEBUG_LL breaks booting
on all platforms with incompatible settings. In case of the Marvell
platforms of the Orion/MVEBU family, the physical addresses are
all the same, we just map them at different virtual addresses,
which makes it impossible to run a kernel with DEBUG_LL enabled on
a combination of the merged mvebu and the legacy boardfile based
platforms.

This is easily solved by using the same virtual address everywhere.
I picked the address that is already used by mach-mvebu for UART0:
0xfec12000. All these platforms have a 1MB region with their internal
registers, almost always at physical address 0xf1000000, so I'm
updating the iotable for that entry.

In case of mach-dove, this is slightly trickier, as the existing
mapping is 8MB and a second 8MB mapping is already at the 0xfec00000
address. I have verified from the datasheet that the last 7MB of the
physical mapping are "reserved" and nothing in Linux tries to use
it either. I'm putting this 1MB mapping at the same address as the
others, and the second 8MB register area immediately before that.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig.debug                 |  5 +----
 arch/arm/mach-dove/include/mach/dove.h | 10 +++++-----
 arch/arm/mach-mv78xx0/mv78xx0.h        |  4 ++--
 arch/arm/mach-orion5x/orion5x.h        |  4 ++--
 4 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 974cf51b5182..fe699fba10b3 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1599,10 +1599,7 @@ config DEBUG_UART_VIRT
 	default 0xfc705000 if DEBUG_ZTE_ZX
 	default 0xfcfe8600 if DEBUG_UART_BCM63XX
 	default 0xfd000000 if DEBUG_SPEAR3XX || DEBUG_SPEAR13XX
-	default 0xfd012000 if DEBUG_MVEBU_UART0_ALTERNATE && ARCH_MV78XX0
 	default 0xfd883000 if DEBUG_ALPINE_UART0
-	default 0xfde12000 if DEBUG_MVEBU_UART0_ALTERNATE && ARCH_DOVE
-	default 0xfe012000 if DEBUG_MVEBU_UART0_ALTERNATE && ARCH_ORION5X
 	default 0xfe017000 if DEBUG_MMP_UART2
 	default 0xfe018000 if DEBUG_MMP_UART3
 	default 0xfe100000 if DEBUG_IMX23_UART || DEBUG_IMX28_UART
@@ -1616,7 +1613,7 @@ config DEBUG_UART_VIRT
 	default 0xfeb31000 if DEBUG_KEYSTONE_UART1
 	default 0xfec02000 if DEBUG_SOCFPGA_UART0
 	default 0xfec02100 if DEBUG_SOCFPGA_UART1
-	default 0xfec12000 if (DEBUG_MVEBU_UART0 || DEBUG_MVEBU_UART0_ALTERNATE) && ARCH_MVEBU
+	default 0xfec12000 if (DEBUG_MVEBU_UART0 || DEBUG_MVEBU_UART0_ALTERNATE)
 	default 0xfec12100 if DEBUG_MVEBU_UART1_ALTERNATE
 	default 0xfec10000 if DEBUG_SIRFATLAS7_UART0
 	default 0xfec20000 if DEBUG_DAVINCI_DMx_UART0
diff --git a/arch/arm/mach-dove/include/mach/dove.h b/arch/arm/mach-dove/include/mach/dove.h
index 00f45458b3ec..89af5ea7469d 100644
--- a/arch/arm/mach-dove/include/mach/dove.h
+++ b/arch/arm/mach-dove/include/mach/dove.h
@@ -20,8 +20,8 @@
  * c8000000	fdb00000	1M	Cryptographic SRAM
  * e0000000	@runtime	128M	PCIe-0 Memory space
  * e8000000	@runtime	128M	PCIe-1 Memory space
- * f1000000	fde00000	8M	on-chip south-bridge registers
- * f1800000	fe600000	8M	on-chip north-bridge registers
+ * f1000000	fec00000	1M	on-chip south-bridge registers
+ * f1800000	fe400000	8M	on-chip north-bridge registers
  * f2000000	fee00000	1M	PCIe-0 I/O space
  * f2100000	fef00000	1M	PCIe-1 I/O space
  */
@@ -44,11 +44,11 @@
 #define DOVE_SCRATCHPAD_SIZE		SZ_1M
 
 #define DOVE_SB_REGS_PHYS_BASE		0xf1000000
-#define DOVE_SB_REGS_VIRT_BASE		IOMEM(0xfde00000)
-#define DOVE_SB_REGS_SIZE		SZ_8M
+#define DOVE_SB_REGS_VIRT_BASE		IOMEM(0xfec00000)
+#define DOVE_SB_REGS_SIZE		SZ_1M
 
 #define DOVE_NB_REGS_PHYS_BASE		0xf1800000
-#define DOVE_NB_REGS_VIRT_BASE		IOMEM(0xfe600000)
+#define DOVE_NB_REGS_VIRT_BASE		IOMEM(0xfe400000)
 #define DOVE_NB_REGS_SIZE		SZ_8M
 
 #define DOVE_PCIE0_IO_PHYS_BASE		0xf2000000
diff --git a/arch/arm/mach-mv78xx0/mv78xx0.h b/arch/arm/mach-mv78xx0/mv78xx0.h
index 2db1265ec121..c1a9a1d1b295 100644
--- a/arch/arm/mach-mv78xx0/mv78xx0.h
+++ b/arch/arm/mach-mv78xx0/mv78xx0.h
@@ -37,7 +37,7 @@
  * fee50000	f0d00000	64K	PCIe #5 I/O space
  * fee60000	f0e00000	64K	PCIe #6 I/O space
  * fee70000	f0f00000	64K	PCIe #7 I/O space
- * fd000000	f1000000	1M	on-chip peripheral registers
+ * fec00000	f1000000	1M	on-chip peripheral registers
  */
 #define MV78XX0_CORE0_REGS_PHYS_BASE	0xf1020000
 #define MV78XX0_CORE1_REGS_PHYS_BASE	0xf1024000
@@ -49,7 +49,7 @@
 #define MV78XX0_PCIE_IO_SIZE		SZ_1M
 
 #define MV78XX0_REGS_PHYS_BASE		0xf1000000
-#define MV78XX0_REGS_VIRT_BASE		IOMEM(0xfd000000)
+#define MV78XX0_REGS_VIRT_BASE		IOMEM(0xfec00000)
 #define MV78XX0_REGS_SIZE		SZ_1M
 
 #define MV78XX0_PCIE_MEM_PHYS_BASE	0xc0000000
diff --git a/arch/arm/mach-orion5x/orion5x.h b/arch/arm/mach-orion5x/orion5x.h
index 3364df331f01..2b66120fba86 100644
--- a/arch/arm/mach-orion5x/orion5x.h
+++ b/arch/arm/mach-orion5x/orion5x.h
@@ -31,13 +31,13 @@
  * fc000000	device bus mappings (cs0/cs1)
  *
  * virt		phys		size
- * fe000000	f1000000	1M	on-chip peripheral registers
+ * fec00000	f1000000	1M	on-chip peripheral registers
  * fee00000	f2000000	64K	PCIe I/O space
  * fee10000	f2100000	64K	PCI I/O space
  * fd000000	f0000000	16M	PCIe WA space (Orion-1/Orion-NAS only)
  ****************************************************************************/
 #define ORION5X_REGS_PHYS_BASE		0xf1000000
-#define ORION5X_REGS_VIRT_BASE		IOMEM(0xfe000000)
+#define ORION5X_REGS_VIRT_BASE		IOMEM(0xfec00000)
 #define ORION5X_REGS_SIZE		SZ_1M
 
 #define ORION5X_PCIE_IO_PHYS_BASE	0xf2000000
-- 
2.1.0.rc2
