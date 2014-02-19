From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 19 Feb 2014 15:12:52 +0100
Subject: [Patch v3 21/23] ARM: MVEBU: Simplifiy headers and make local
In-Reply-To: <1392819174-11634-1-git-send-email-andrew@lunn.ch>
References: <1392819174-11634-1-git-send-email-andrew@lunn.ch>
Message-ID: <1392819174-11634-22-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kirkwood is very nearly fully DT. Remove most of the address
definitions from the header files and make it a local header file.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Arnd Bergmann <arnd@arndb.de>
v2
Squash in the patch which removed unneeded includes.
---
 arch/arm/mach-mvebu/include/mach/bridge-regs.h |  85 ---------------
 arch/arm/mach-mvebu/include/mach/kirkwood.h    | 142 -------------------------
 arch/arm/mach-mvebu/kirkwood-pm.c              |   2 +-
 arch/arm/mach-mvebu/kirkwood.c                 |   9 +-
 arch/arm/mach-mvebu/kirkwood.h                 |  22 ++++
 5 files changed, 26 insertions(+), 234 deletions(-)
 delete mode 100644 arch/arm/mach-mvebu/include/mach/bridge-regs.h
 delete mode 100644 arch/arm/mach-mvebu/include/mach/kirkwood.h
 create mode 100644 arch/arm/mach-mvebu/kirkwood.h

diff --git a/arch/arm/mach-mvebu/include/mach/bridge-regs.h b/arch/arm/mach-mvebu/include/mach/bridge-regs.h
deleted file mode 100644
index 6eb8fea1f76f..000000000000
--- a/arch/arm/mach-mvebu/include/mach/bridge-regs.h
+++ /dev/null
@@ -1,85 +0,0 @@
-/*
- * arch/arm/mach-mvebu/include/mach/bridge-regs.h
- *
- * Mbus-L to Mbus Bridge Registers
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __ASM_ARCH_BRIDGE_REGS_H
-#define __ASM_ARCH_BRIDGE_REGS_H
-
-#include <mach/kirkwood.h>
-
-#define CPU_CONFIG		(BRIDGE_VIRT_BASE + 0x0100)
-#define CPU_CONFIG_PHYS		(BRIDGE_PHYS_BASE + 0x0100)
-#define CPU_CONFIG_ERROR_PROP	0x00000004
-
-#define CPU_CONTROL		(BRIDGE_VIRT_BASE + 0x0104)
-#define CPU_CONTROL_PHYS	(BRIDGE_PHYS_BASE + 0x0104)
-#define CPU_RESET		0x00000002
-
-#define RSTOUTn_MASK		(BRIDGE_VIRT_BASE + 0x0108)
-#define SOFT_RESET_OUT_EN	0x00000004
-
-#define SYSTEM_SOFT_RESET	(BRIDGE_VIRT_BASE + 0x010c)
-#define SOFT_RESET		0x00000001
-
-#define BRIDGE_CAUSE		(BRIDGE_VIRT_BASE + 0x0110)
-
-#define BRIDGE_INT_TIMER1_CLR	(~0x0004)
-
-#define IRQ_VIRT_BASE		(BRIDGE_VIRT_BASE + 0x0200)
-#define IRQ_CAUSE_LOW_OFF	0x0000
-#define IRQ_MASK_LOW_OFF	0x0004
-#define IRQ_CAUSE_HIGH_OFF	0x0010
-#define IRQ_MASK_HIGH_OFF	0x0014
-
-#define TIMER_VIRT_BASE		(BRIDGE_VIRT_BASE + 0x0300)
-#define TIMER_PHYS_BASE		(BRIDGE_PHYS_BASE + 0x0300)
-
-#define L2_CONFIG_REG		(BRIDGE_VIRT_BASE + 0x0128)
-#define L2_WRITETHROUGH		0x00000010
-
-#define CLOCK_GATING_CTRL	(BRIDGE_VIRT_BASE + 0x11c)
-#define CGC_BIT_GE0		(0)
-#define CGC_BIT_PEX0		(2)
-#define CGC_BIT_USB0		(3)
-#define CGC_BIT_SDIO		(4)
-#define CGC_BIT_TSU		(5)
-#define CGC_BIT_DUNIT		(6)
-#define CGC_BIT_RUNIT		(7)
-#define CGC_BIT_XOR0		(8)
-#define CGC_BIT_AUDIO		(9)
-#define CGC_BIT_SATA0		(14)
-#define CGC_BIT_SATA1		(15)
-#define CGC_BIT_XOR1		(16)
-#define CGC_BIT_CRYPTO		(17)
-#define CGC_BIT_PEX1		(18)
-#define CGC_BIT_GE1		(19)
-#define CGC_BIT_TDM		(20)
-#define CGC_GE0			(1 << 0)
-#define CGC_PEX0		(1 << 2)
-#define CGC_USB0		(1 << 3)
-#define CGC_SDIO		(1 << 4)
-#define CGC_TSU			(1 << 5)
-#define CGC_DUNIT		(1 << 6)
-#define CGC_RUNIT		(1 << 7)
-#define CGC_XOR0		(1 << 8)
-#define CGC_AUDIO		(1 << 9)
-#define CGC_POWERSAVE           (1 << 11)
-#define CGC_SATA0		(1 << 14)
-#define CGC_SATA1		(1 << 15)
-#define CGC_XOR1		(1 << 16)
-#define CGC_CRYPTO		(1 << 17)
-#define CGC_PEX1		(1 << 18)
-#define CGC_GE1			(1 << 19)
-#define CGC_TDM			(1 << 20)
-#define CGC_RESERVED		(0x6 << 21)
-
-#define MEMORY_PM_CTRL		(BRIDGE_VIRT_BASE + 0x118)
-#define MEMORY_PM_CTRL_PHYS	(BRIDGE_PHYS_BASE + 0x118)
-
-#endif
diff --git a/arch/arm/mach-mvebu/include/mach/kirkwood.h b/arch/arm/mach-mvebu/include/mach/kirkwood.h
deleted file mode 100644
index 9d966dc78d67..000000000000
--- a/arch/arm/mach-mvebu/include/mach/kirkwood.h
+++ /dev/null
@@ -1,142 +0,0 @@
-/*
- * arch/arm/mach-mvebu/include/mach/kirkwood.h
- *
- * Generic definitions for Marvell Kirkwood SoC flavors:
- *  88F6180, 88F6192 and 88F6281.
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __ASM_ARCH_KIRKWOOD_H
-#define __ASM_ARCH_KIRKWOOD_H
-
-/*
- * Marvell Kirkwood address maps.
- *
- * phys
- * e0000000	PCIe #0 Memory space
- * e8000000	PCIe #1 Memory space
- * f1000000	on-chip peripheral registers
- * f2000000	PCIe #0 I/O space
- * f3000000	PCIe #1 I/O space
- * f4000000	NAND controller address window
- * f5000000	Security Accelerator SRAM
- *
- * virt		phys		size
- * fed00000	f1000000	1M	on-chip peripheral registers
- * fee00000	f2000000	1M	PCIe #0 I/O space
- * fef00000	f3000000	1M	PCIe #1 I/O space
- */
-
-#define KIRKWOOD_SRAM_PHYS_BASE		0xf5000000
-#define KIRKWOOD_SRAM_SIZE		SZ_2K
-
-#define KIRKWOOD_NAND_MEM_PHYS_BASE	0xf4000000
-#define KIRKWOOD_NAND_MEM_SIZE		SZ_1K
-
-#define KIRKWOOD_PCIE1_IO_PHYS_BASE	0xf3000000
-#define KIRKWOOD_PCIE1_IO_BUS_BASE	0x00010000
-#define KIRKWOOD_PCIE1_IO_SIZE		SZ_64K
-
-#define KIRKWOOD_PCIE_IO_PHYS_BASE	0xf2000000
-#define KIRKWOOD_PCIE_IO_BUS_BASE	0x00000000
-#define KIRKWOOD_PCIE_IO_SIZE		SZ_64K
-
-#define KIRKWOOD_REGS_PHYS_BASE		0xf1000000
-#define KIRKWOOD_REGS_VIRT_BASE		IOMEM(0xfed00000)
-#define KIRKWOOD_REGS_SIZE		SZ_1M
-
-#define KIRKWOOD_PCIE_MEM_PHYS_BASE	0xe0000000
-#define KIRKWOOD_PCIE_MEM_BUS_BASE	0xe0000000
-#define KIRKWOOD_PCIE_MEM_SIZE		SZ_128M
-
-#define KIRKWOOD_PCIE1_MEM_PHYS_BASE	0xe8000000
-#define KIRKWOOD_PCIE1_MEM_BUS_BASE	0xe8000000
-#define KIRKWOOD_PCIE1_MEM_SIZE		SZ_128M
-
-/*
- * Register Map
- */
-#define DDR_VIRT_BASE		(KIRKWOOD_REGS_VIRT_BASE + 0x00000)
-#define DDR_PHYS_BASE           (KIRKWOOD_REGS_PHYS_BASE + 0x00000)
-#define  DDR_WINDOW_CPU_BASE    (DDR_PHYS_BASE + 0x1500)
-#define  DDR_WINDOW_CPU_SZ      (0x20)
-#define DDR_OPERATION_BASE	(DDR_PHYS_BASE + 0x1418)
-
-#define DEV_BUS_PHYS_BASE	(KIRKWOOD_REGS_PHYS_BASE + 0x10000)
-#define DEV_BUS_VIRT_BASE	(KIRKWOOD_REGS_VIRT_BASE + 0x10000)
-#define  SAMPLE_AT_RESET	(DEV_BUS_VIRT_BASE + 0x0030)
-#define  DEVICE_ID		(DEV_BUS_VIRT_BASE + 0x0034)
-#define  GPIO_LOW_VIRT_BASE	(DEV_BUS_VIRT_BASE + 0x0100)
-#define  GPIO_HIGH_VIRT_BASE	(DEV_BUS_VIRT_BASE + 0x0140)
-#define  RTC_PHYS_BASE		(DEV_BUS_PHYS_BASE + 0x0300)
-#define  SPI_PHYS_BASE		(DEV_BUS_PHYS_BASE + 0x0600)
-#define  I2C_PHYS_BASE		(DEV_BUS_PHYS_BASE + 0x1000)
-#define  UART0_PHYS_BASE	(DEV_BUS_PHYS_BASE + 0x2000)
-#define  UART0_VIRT_BASE	(DEV_BUS_VIRT_BASE + 0x2000)
-#define  UART1_PHYS_BASE	(DEV_BUS_PHYS_BASE + 0x2100)
-#define  UART1_VIRT_BASE	(DEV_BUS_VIRT_BASE + 0x2100)
-
-#define BRIDGE_VIRT_BASE	(KIRKWOOD_REGS_VIRT_BASE + 0x20000)
-#define BRIDGE_PHYS_BASE	(KIRKWOOD_REGS_PHYS_BASE + 0x20000)
-#define  BRIDGE_WINS_BASE       (BRIDGE_PHYS_BASE)
-#define  BRIDGE_WINS_SZ         (0x80)
-
-#define CRYPTO_PHYS_BASE	(KIRKWOOD_REGS_PHYS_BASE + 0x30000)
-
-#define PCIE_VIRT_BASE		(KIRKWOOD_REGS_VIRT_BASE + 0x40000)
-#define PCIE_LINK_CTRL		(PCIE_VIRT_BASE + 0x70)
-#define PCIE_STATUS		(PCIE_VIRT_BASE + 0x1a04)
-#define PCIE1_VIRT_BASE		(KIRKWOOD_REGS_VIRT_BASE + 0x44000)
-#define PCIE1_LINK_CTRL		(PCIE1_VIRT_BASE + 0x70)
-#define PCIE1_STATUS		(PCIE1_VIRT_BASE + 0x1a04)
-
-#define USB_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE + 0x50000)
-
-#define XOR0_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE + 0x60800)
-#define XOR0_VIRT_BASE		(KIRKWOOD_REGS_VIRT_BASE + 0x60800)
-#define XOR1_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE + 0x60900)
-#define XOR1_VIRT_BASE		(KIRKWOOD_REGS_VIRT_BASE + 0x60900)
-#define XOR0_HIGH_PHYS_BASE	(KIRKWOOD_REGS_PHYS_BASE + 0x60A00)
-#define XOR0_HIGH_VIRT_BASE	(KIRKWOOD_REGS_VIRT_BASE + 0x60A00)
-#define XOR1_HIGH_PHYS_BASE	(KIRKWOOD_REGS_PHYS_BASE + 0x60B00)
-#define XOR1_HIGH_VIRT_BASE	(KIRKWOOD_REGS_VIRT_BASE + 0x60B00)
-
-#define GE00_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE + 0x70000)
-#define GE01_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE + 0x74000)
-
-#define SATA_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE + 0x80000)
-#define SATA_VIRT_BASE		(KIRKWOOD_REGS_VIRT_BASE + 0x80000)
-#define SATA0_IF_CTRL		(SATA_VIRT_BASE + 0x2050)
-#define SATA0_PHY_MODE_2	(SATA_VIRT_BASE + 0x2330)
-#define SATA1_IF_CTRL		(SATA_VIRT_BASE + 0x4050)
-#define SATA1_PHY_MODE_2	(SATA_VIRT_BASE + 0x4330)
-
-#define SDIO_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE + 0x90000)
-
-#define AUDIO_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE + 0xA0000)
-#define AUDIO_VIRT_BASE		(KIRKWOOD_REGS_VIRT_BASE + 0xA0000)
-
-/*
- * Supported devices and revisions.
- */
-#define MV88F6281_DEV_ID	0x6281
-#define MV88F6281_REV_Z0	0
-#define MV88F6281_REV_A0	2
-#define MV88F6281_REV_A1	3
-
-#define MV88F6192_DEV_ID	0x6192
-#define MV88F6192_REV_Z0	0
-#define MV88F6192_REV_A0	2
-#define MV88F6192_REV_A1	3
-
-#define MV88F6180_DEV_ID	0x6180
-#define MV88F6180_REV_A0	2
-#define MV88F6180_REV_A1	3
-
-#define MV88F6282_DEV_ID	0x6282
-#define MV88F6282_REV_A0	0
-#define MV88F6282_REV_A1	1
-#endif
diff --git a/arch/arm/mach-mvebu/kirkwood-pm.c b/arch/arm/mach-mvebu/kirkwood-pm.c
index b8c8365b84d8..cbb816f2120c 100644
--- a/arch/arm/mach-mvebu/kirkwood-pm.c
+++ b/arch/arm/mach-mvebu/kirkwood-pm.c
@@ -17,7 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/suspend.h>
 #include <linux/io.h>
-#include <mach/bridge-regs.h>
+#include "kirkwood.h"
 
 static void __iomem *ddr_operation_base;
 static void __iomem *memory_pm_ctrl;
diff --git a/arch/arm/mach-mvebu/kirkwood.c b/arch/arm/mach-mvebu/kirkwood.c
index 4c7bbec11b1a..8a38b10532e5 100644
--- a/arch/arm/mach-mvebu/kirkwood.c
+++ b/arch/arm/mach-mvebu/kirkwood.c
@@ -13,19 +13,16 @@
 #include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/mbus.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_net.h>
 #include <linux/of_platform.h>
-#include <linux/dma-mapping.h>
-#include <linux/irqchip.h>
-#include <linux/kexec.h>
+#include <linux/slab.h>
 #include <asm/hardware/cache-feroceon-l2.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <mach/bridge-regs.h>
-#include <plat/common.h>
-#include <plat/pcie.h>
+#include "kirkwood.h"
 #include "kirkwood-pm.h"
 #include "common.h"
 
diff --git a/arch/arm/mach-mvebu/kirkwood.h b/arch/arm/mach-mvebu/kirkwood.h
new file mode 100644
index 000000000000..89f3d1f51643
--- /dev/null
+++ b/arch/arm/mach-mvebu/kirkwood.h
@@ -0,0 +1,22 @@
+/*
+ * arch/arm/mach-mvebu/kirkwood.h
+ *
+ * Generic definitions for Marvell Kirkwood SoC flavors:
+ * 88F6180, 88F6192 and 88F6281.
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#define KIRKWOOD_REGS_PHYS_BASE	0xf1000000
+#define DDR_PHYS_BASE           (KIRKWOOD_REGS_PHYS_BASE + 0x00000)
+#define BRIDGE_PHYS_BASE	(KIRKWOOD_REGS_PHYS_BASE + 0x20000)
+
+#define DDR_OPERATION_BASE	(DDR_PHYS_BASE + 0x1418)
+
+#define CPU_CONFIG_PHYS		(BRIDGE_PHYS_BASE + 0x0100)
+#define CPU_CONFIG_ERROR_PROP	0x00000004
+
+#define CPU_CONTROL_PHYS	(BRIDGE_PHYS_BASE + 0x0104)
+#define MEMORY_PM_CTRL_PHYS	(BRIDGE_PHYS_BASE + 0x0118)
-- 
1.8.5.3
