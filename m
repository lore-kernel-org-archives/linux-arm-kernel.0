From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 11 Sep 2012 14:27:17 +0200
Subject: [PATCH v4 04/17] arm: mach-orion5x: use plus instead of or for
 address definitions
In-Reply-To: <1347366450-26644-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1347366450-26644-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1347366450-26644-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we are going to use IOMEM() to define many base virtual
addresses, we can no longer use binary or to define the individual
register addresses ("binary or" arithmetic on pointers is not
allowed). Instead, use the more conventional plus operator to do so.

The binary or operators were actually not useful because the low-order
bits of the base address were always zero, so the usage of the binary
or operators was effectively identical to a plus operator.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-orion5x/include/mach/bridge-regs.h |   20 ++++-----
 arch/arm/mach-orion5x/include/mach/orion5x.h     |   52 +++++++++++-----------
 arch/arm/mach-orion5x/pci.c                      |    2 +-
 3 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-orion5x/include/mach/bridge-regs.h b/arch/arm/mach-orion5x/include/mach/bridge-regs.h
index 11a3c1e..461fd69 100644
--- a/arch/arm/mach-orion5x/include/mach/bridge-regs.h
+++ b/arch/arm/mach-orion5x/include/mach/bridge-regs.h
@@ -13,27 +13,27 @@
 
 #include <mach/orion5x.h>
 
-#define CPU_CONF		(ORION5X_BRIDGE_VIRT_BASE | 0x100)
+#define CPU_CONF		(ORION5X_BRIDGE_VIRT_BASE + 0x100)
 
-#define CPU_CTRL		(ORION5X_BRIDGE_VIRT_BASE | 0x104)
+#define CPU_CTRL		(ORION5X_BRIDGE_VIRT_BASE + 0x104)
 
-#define RSTOUTn_MASK		(ORION5X_BRIDGE_VIRT_BASE | 0x108)
+#define RSTOUTn_MASK		(ORION5X_BRIDGE_VIRT_BASE + 0x108)
 #define WDT_RESET_OUT_EN	0x0002
 
-#define CPU_SOFT_RESET		(ORION5X_BRIDGE_VIRT_BASE | 0x10c)
+#define CPU_SOFT_RESET		(ORION5X_BRIDGE_VIRT_BASE + 0x10c)
 
-#define BRIDGE_CAUSE		(ORION5X_BRIDGE_VIRT_BASE | 0x110)
+#define BRIDGE_CAUSE		(ORION5X_BRIDGE_VIRT_BASE + 0x110)
 
-#define POWER_MNG_CTRL_REG	(ORION5X_BRIDGE_VIRT_BASE | 0x11C)
+#define POWER_MNG_CTRL_REG	(ORION5X_BRIDGE_VIRT_BASE + 0x11C)
 
 #define WDT_INT_REQ		0x0008
 
 #define BRIDGE_INT_TIMER1_CLR	(~0x0004)
 
-#define MAIN_IRQ_CAUSE		(ORION5X_BRIDGE_VIRT_BASE | 0x200)
+#define MAIN_IRQ_CAUSE		(ORION5X_BRIDGE_VIRT_BASE + 0x200)
 
-#define MAIN_IRQ_MASK		(ORION5X_BRIDGE_VIRT_BASE | 0x204)
+#define MAIN_IRQ_MASK		(ORION5X_BRIDGE_VIRT_BASE + 0x204)
 
-#define TIMER_VIRT_BASE		(ORION5X_BRIDGE_VIRT_BASE | 0x300)
-#define TIMER_PHYS_BASE		(ORION5X_BRIDGE_PHYS_BASE | 0x300)
+#define TIMER_VIRT_BASE		(ORION5X_BRIDGE_VIRT_BASE + 0x300)
+#define TIMER_PHYS_BASE		(ORION5X_BRIDGE_PHYS_BASE + 0x300)
 #endif
diff --git a/arch/arm/mach-orion5x/include/mach/orion5x.h b/arch/arm/mach-orion5x/include/mach/orion5x.h
index 683e085..87bd378 100644
--- a/arch/arm/mach-orion5x/include/mach/orion5x.h
+++ b/arch/arm/mach-orion5x/include/mach/orion5x.h
@@ -68,42 +68,42 @@
  * Orion Registers Map
  ******************************************************************************/
 
-#define ORION5X_DDR_VIRT_BASE		(ORION5X_REGS_VIRT_BASE | 0x00000)
-#define  ORION5X_DDR_WINDOW_CPU_BASE    (ORION5X_DDR_VIRT_BASE | 0x1500)
-#define ORION5X_DEV_BUS_PHYS_BASE	(ORION5X_REGS_PHYS_BASE | 0x10000)
-#define ORION5X_DEV_BUS_VIRT_BASE	(ORION5X_REGS_VIRT_BASE | 0x10000)
-#define ORION5X_DEV_BUS_REG(x)		(ORION5X_DEV_BUS_VIRT_BASE | (x))
+#define ORION5X_DDR_VIRT_BASE		(ORION5X_REGS_VIRT_BASE + 0x00000)
+#define  ORION5X_DDR_WINDOW_CPU_BASE    (ORION5X_DDR_VIRT_BASE + 0x1500)
+#define ORION5X_DEV_BUS_PHYS_BASE	(ORION5X_REGS_PHYS_BASE + 0x10000)
+#define ORION5X_DEV_BUS_VIRT_BASE	(ORION5X_REGS_VIRT_BASE + 0x10000)
+#define ORION5X_DEV_BUS_REG(x)		(ORION5X_DEV_BUS_VIRT_BASE + (x))
 #define  GPIO_VIRT_BASE			ORION5X_DEV_BUS_REG(0x0100)
-#define  SPI_PHYS_BASE			(ORION5X_DEV_BUS_PHYS_BASE | 0x0600)
-#define  I2C_PHYS_BASE			(ORION5X_DEV_BUS_PHYS_BASE | 0x1000)
-#define  UART0_PHYS_BASE		(ORION5X_DEV_BUS_PHYS_BASE | 0x2000)
-#define  UART0_VIRT_BASE		(ORION5X_DEV_BUS_VIRT_BASE | 0x2000)
-#define  UART1_PHYS_BASE		(ORION5X_DEV_BUS_PHYS_BASE | 0x2100)
-#define  UART1_VIRT_BASE		(ORION5X_DEV_BUS_VIRT_BASE | 0x2100)
+#define  SPI_PHYS_BASE			(ORION5X_DEV_BUS_PHYS_BASE + 0x0600)
+#define  I2C_PHYS_BASE			(ORION5X_DEV_BUS_PHYS_BASE + 0x1000)
+#define  UART0_PHYS_BASE		(ORION5X_DEV_BUS_PHYS_BASE + 0x2000)
+#define  UART0_VIRT_BASE		(ORION5X_DEV_BUS_VIRT_BASE + 0x2000)
+#define  UART1_PHYS_BASE		(ORION5X_DEV_BUS_PHYS_BASE + 0x2100)
+#define  UART1_VIRT_BASE		(ORION5X_DEV_BUS_VIRT_BASE + 0x2100)
 
-#define ORION5X_BRIDGE_VIRT_BASE	(ORION5X_REGS_VIRT_BASE | 0x20000)
-#define ORION5X_BRIDGE_PHYS_BASE	(ORION5X_REGS_PHYS_BASE | 0x20000)
+#define ORION5X_BRIDGE_VIRT_BASE	(ORION5X_REGS_VIRT_BASE + 0x20000)
+#define ORION5X_BRIDGE_PHYS_BASE	(ORION5X_REGS_PHYS_BASE + 0x20000)
 
-#define ORION5X_PCI_VIRT_BASE		(ORION5X_REGS_VIRT_BASE | 0x30000)
+#define ORION5X_PCI_VIRT_BASE		(ORION5X_REGS_VIRT_BASE + 0x30000)
 
-#define ORION5X_PCIE_VIRT_BASE		(ORION5X_REGS_VIRT_BASE | 0x40000)
+#define ORION5X_PCIE_VIRT_BASE		(ORION5X_REGS_VIRT_BASE + 0x40000)
 
-#define ORION5X_USB0_PHYS_BASE		(ORION5X_REGS_PHYS_BASE | 0x50000)
-#define ORION5X_USB0_VIRT_BASE		(ORION5X_REGS_VIRT_BASE | 0x50000)
+#define ORION5X_USB0_PHYS_BASE		(ORION5X_REGS_PHYS_BASE + 0x50000)
+#define ORION5X_USB0_VIRT_BASE		(ORION5X_REGS_VIRT_BASE + 0x50000)
 
-#define ORION5X_XOR_PHYS_BASE		(ORION5X_REGS_PHYS_BASE | 0x60900)
-#define ORION5X_XOR_VIRT_BASE		(ORION5X_REGS_VIRT_BASE | 0x60900)
+#define ORION5X_XOR_PHYS_BASE		(ORION5X_REGS_PHYS_BASE + 0x60900)
+#define ORION5X_XOR_VIRT_BASE		(ORION5X_REGS_VIRT_BASE + 0x60900)
 
-#define ORION5X_ETH_PHYS_BASE		(ORION5X_REGS_PHYS_BASE | 0x70000)
-#define ORION5X_ETH_VIRT_BASE		(ORION5X_REGS_VIRT_BASE | 0x70000)
+#define ORION5X_ETH_PHYS_BASE		(ORION5X_REGS_PHYS_BASE + 0x70000)
+#define ORION5X_ETH_VIRT_BASE		(ORION5X_REGS_VIRT_BASE + 0x70000)
 
-#define ORION5X_SATA_PHYS_BASE		(ORION5X_REGS_PHYS_BASE | 0x80000)
-#define ORION5X_SATA_VIRT_BASE		(ORION5X_REGS_VIRT_BASE | 0x80000)
+#define ORION5X_SATA_PHYS_BASE		(ORION5X_REGS_PHYS_BASE + 0x80000)
+#define ORION5X_SATA_VIRT_BASE		(ORION5X_REGS_VIRT_BASE + 0x80000)
 
-#define ORION5X_CRYPTO_PHYS_BASE	(ORION5X_REGS_PHYS_BASE | 0x90000)
+#define ORION5X_CRYPTO_PHYS_BASE	(ORION5X_REGS_PHYS_BASE + 0x90000)
 
-#define ORION5X_USB1_PHYS_BASE		(ORION5X_REGS_PHYS_BASE | 0xa0000)
-#define ORION5X_USB1_VIRT_BASE		(ORION5X_REGS_VIRT_BASE | 0xa0000)
+#define ORION5X_USB1_PHYS_BASE		(ORION5X_REGS_PHYS_BASE + 0xa0000)
+#define ORION5X_USB1_VIRT_BASE		(ORION5X_REGS_VIRT_BASE + 0xa0000)
 
 /*******************************************************************************
  * Device Bus Registers
diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
index cb19e16..b36f928 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion5x/pci.c
@@ -198,7 +198,7 @@ static int __init pcie_setup(struct pci_sys_data *sys)
 /*****************************************************************************
  * PCI controller
  ****************************************************************************/
-#define ORION5X_PCI_REG(x)	(ORION5X_PCI_VIRT_BASE | (x))
+#define ORION5X_PCI_REG(x)	(ORION5X_PCI_VIRT_BASE + (x))
 #define PCI_MODE		ORION5X_PCI_REG(0xd00)
 #define PCI_CMD			ORION5X_PCI_REG(0xc00)
 #define PCI_P2P_CONF		ORION5X_PCI_REG(0x1d14)
-- 
1.7.9.5
