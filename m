From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 15 Feb 2014 11:20:13 +0100
Subject: [PATCH v2 15/23] ARM: Move kirkwood DT boards into mach-mvebu
In-Reply-To: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
References: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
Message-ID: <1392459621-24003-16-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the kirkwood DT support into mach-mvebu, and make them part of
ARCH_MULTI_V5. Minimal changes have been made in order to make it
boot. Cleanup of the header files and intergration with mvebu will
take place in following patches.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/Makefile                     |  34 ++--
 arch/arm/mach-mvebu/Kconfig                    |  24 ++-
 arch/arm/mach-mvebu/Makefile                   |   1 +
 arch/arm/mach-mvebu/include/mach/bridge-regs.h |  85 ++++++++++
 arch/arm/mach-mvebu/include/mach/kirkwood.h    | 142 +++++++++++++++++
 arch/arm/mach-mvebu/kirkwood-pm.c              |  76 +++++++++
 arch/arm/mach-mvebu/kirkwood-pm.h              |  26 ++++
 arch/arm/mach-mvebu/kirkwood.c                 | 208 +++++++++++++++++++++++++
 8 files changed, 578 insertions(+), 18 deletions(-)
 create mode 100644 arch/arm/mach-mvebu/include/mach/bridge-regs.h
 create mode 100644 arch/arm/mach-mvebu/include/mach/kirkwood.h
 create mode 100644 arch/arm/mach-mvebu/kirkwood-pm.c
 create mode 100644 arch/arm/mach-mvebu/kirkwood-pm.h
 create mode 100644 arch/arm/mach-mvebu/kirkwood.c

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b9d6a8b485e0..c0253830c7db 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -82,7 +82,23 @@ dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb \
 dtb-$(CONFIG_ARCH_INTEGRATOR) += integratorap.dtb \
 	integratorcp.dtb
 dtb-$(CONFIG_ARCH_LPC32XX) += ea3250.dtb phy3250.dtb
-dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-cloudbox.dtb \
+dtb-$(CONFIG_ARCH_MARCO) += marco-evb.dtb
+dtb-$(CONFIG_ARCH_MOXART) += moxart-uc7112lx.dtb
+dtb-$(CONFIG_ARCH_MSM) += qcom-msm8660-surf.dtb \
+	qcom-msm8960-cdp.dtb \
+	qcom-apq8074-dragonboard.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
+	armada-370-mirabox.dtb \
+	armada-370-netgear-rn102.dtb \
+	armada-370-netgear-rn104.dtb \
+	armada-370-rd.dtb \
+	armada-xp-axpwifiap.dtb \
+	armada-xp-db.dtb \
+	armada-xp-gp.dtb \
+	armada-xp-netgear-rn2120.dtb \
+	armada-xp-matrix.dtb \
+	armada-xp-openblocks-ax3-4.dtb \
+	kirkwood-cloudbox.dtb \
 	kirkwood-db-88f6281.dtb \
 	kirkwood-db-88f6282.dtb \
 	kirkwood-dns320.dtb \
@@ -116,22 +132,6 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-cloudbox.dtb \
 	kirkwood-topkick.dtb \
 	kirkwood-ts219-6281.dtb \
 	kirkwood-ts219-6282.dtb
-dtb-$(CONFIG_ARCH_MARCO) += marco-evb.dtb
-dtb-$(CONFIG_ARCH_MOXART) += moxart-uc7112lx.dtb
-dtb-$(CONFIG_ARCH_MSM) += qcom-msm8660-surf.dtb \
-	qcom-msm8960-cdp.dtb \
-	qcom-apq8074-dragonboard.dtb
-dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
-	armada-370-mirabox.dtb \
-	armada-370-netgear-rn102.dtb \
-	armada-370-netgear-rn104.dtb \
-	armada-370-rd.dtb \
-	armada-xp-axpwifiap.dtb \
-	armada-xp-db.dtb \
-	armada-xp-gp.dtb \
-	armada-xp-netgear-rn2120.dtb \
-	armada-xp-matrix.dtb \
-	armada-xp-openblocks-ax3-4.dtb
 dtb-$(CONFIG_ARCH_MXC) += \
 	imx25-karo-tx25.dtb \
 	imx25-pdk.dtb \
diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 9ab22e1b26cd..2afbd59cad5e 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -1,5 +1,5 @@
 config ARCH_MVEBU
-	bool "Marvell SOCs with Device Tree support" if ARCH_MULTI_V7
+	bool "Marvell SOCs with Device Tree support" if (ARCH_MULTI_V7 || ARCH_MULTI_V5)
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select CLKSRC_MMIO
 	select COMMON_CLK
@@ -46,6 +46,28 @@ config MACH_ARMADA_XP
 	  Say 'Y' here if you want your kernel to support boards based
 	  on the Marvell Armada XP SoC with device tree.
 
+config MACH_KIRKWOOD
+	bool "Marvell Kirkwood boards" if ARCH_MULTI_V5
+	select ARCH_HAS_CPUFREQ
+	select ARCH_REQUIRE_GPIOLIB
+	select CPU_FEROCEON
+	select KIRKWOOD_CLK
+	select OF_IRQ
+	select ORION_IRQCHIP
+	select ORION_TIMER
+	select PCI
+	select PCI_QUIRKS
+	select PINCTRL_KIRKWOOD
+	select POWER_SUPPLY
+	select POWER_RESET
+	select POWER_RESET_GPIO
+	select REGULATOR
+	select REGULATOR_FIXED_VOLTAGE
+	select USE_OF
+	help
+	  Say 'Y' here if you want your kernel to support boards based
+	  on the Marvell Kirkwood device tree.
+
 endmenu
 
 endif
diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index 878aebe98dcc..c44976470ccf 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_MACH_ARMADA_370_XP) += armada-370-xp.o
 obj-$(CONFIG_ARCH_MVEBU)	 += coherency.o coherency_ll.o pmsu.o
 obj-$(CONFIG_SMP)                += platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)        += hotplug.o
+obj-$(CONFIG_MACH_KIRKWOOD)	 += kirkwood.o kirkwood-pm.o
\ No newline at end of file
diff --git a/arch/arm/mach-mvebu/include/mach/bridge-regs.h b/arch/arm/mach-mvebu/include/mach/bridge-regs.h
new file mode 100644
index 000000000000..6eb8fea1f76f
--- /dev/null
+++ b/arch/arm/mach-mvebu/include/mach/bridge-regs.h
@@ -0,0 +1,85 @@
+/*
+ * arch/arm/mach-mvebu/include/mach/bridge-regs.h
+ *
+ * Mbus-L to Mbus Bridge Registers
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __ASM_ARCH_BRIDGE_REGS_H
+#define __ASM_ARCH_BRIDGE_REGS_H
+
+#include <mach/kirkwood.h>
+
+#define CPU_CONFIG		(BRIDGE_VIRT_BASE + 0x0100)
+#define CPU_CONFIG_PHYS		(BRIDGE_PHYS_BASE + 0x0100)
+#define CPU_CONFIG_ERROR_PROP	0x00000004
+
+#define CPU_CONTROL		(BRIDGE_VIRT_BASE + 0x0104)
+#define CPU_CONTROL_PHYS	(BRIDGE_PHYS_BASE + 0x0104)
+#define CPU_RESET		0x00000002
+
+#define RSTOUTn_MASK		(BRIDGE_VIRT_BASE + 0x0108)
+#define SOFT_RESET_OUT_EN	0x00000004
+
+#define SYSTEM_SOFT_RESET	(BRIDGE_VIRT_BASE + 0x010c)
+#define SOFT_RESET		0x00000001
+
+#define BRIDGE_CAUSE		(BRIDGE_VIRT_BASE + 0x0110)
+
+#define BRIDGE_INT_TIMER1_CLR	(~0x0004)
+
+#define IRQ_VIRT_BASE		(BRIDGE_VIRT_BASE + 0x0200)
+#define IRQ_CAUSE_LOW_OFF	0x0000
+#define IRQ_MASK_LOW_OFF	0x0004
+#define IRQ_CAUSE_HIGH_OFF	0x0010
+#define IRQ_MASK_HIGH_OFF	0x0014
+
+#define TIMER_VIRT_BASE		(BRIDGE_VIRT_BASE + 0x0300)
+#define TIMER_PHYS_BASE		(BRIDGE_PHYS_BASE + 0x0300)
+
+#define L2_CONFIG_REG		(BRIDGE_VIRT_BASE + 0x0128)
+#define L2_WRITETHROUGH		0x00000010
+
+#define CLOCK_GATING_CTRL	(BRIDGE_VIRT_BASE + 0x11c)
+#define CGC_BIT_GE0		(0)
+#define CGC_BIT_PEX0		(2)
+#define CGC_BIT_USB0		(3)
+#define CGC_BIT_SDIO		(4)
+#define CGC_BIT_TSU		(5)
+#define CGC_BIT_DUNIT		(6)
+#define CGC_BIT_RUNIT		(7)
+#define CGC_BIT_XOR0		(8)
+#define CGC_BIT_AUDIO		(9)
+#define CGC_BIT_SATA0		(14)
+#define CGC_BIT_SATA1		(15)
+#define CGC_BIT_XOR1		(16)
+#define CGC_BIT_CRYPTO		(17)
+#define CGC_BIT_PEX1		(18)
+#define CGC_BIT_GE1		(19)
+#define CGC_BIT_TDM		(20)
+#define CGC_GE0			(1 << 0)
+#define CGC_PEX0		(1 << 2)
+#define CGC_USB0		(1 << 3)
+#define CGC_SDIO		(1 << 4)
+#define CGC_TSU			(1 << 5)
+#define CGC_DUNIT		(1 << 6)
+#define CGC_RUNIT		(1 << 7)
+#define CGC_XOR0		(1 << 8)
+#define CGC_AUDIO		(1 << 9)
+#define CGC_POWERSAVE           (1 << 11)
+#define CGC_SATA0		(1 << 14)
+#define CGC_SATA1		(1 << 15)
+#define CGC_XOR1		(1 << 16)
+#define CGC_CRYPTO		(1 << 17)
+#define CGC_PEX1		(1 << 18)
+#define CGC_GE1			(1 << 19)
+#define CGC_TDM			(1 << 20)
+#define CGC_RESERVED		(0x6 << 21)
+
+#define MEMORY_PM_CTRL		(BRIDGE_VIRT_BASE + 0x118)
+#define MEMORY_PM_CTRL_PHYS	(BRIDGE_PHYS_BASE + 0x118)
+
+#endif
diff --git a/arch/arm/mach-mvebu/include/mach/kirkwood.h b/arch/arm/mach-mvebu/include/mach/kirkwood.h
new file mode 100644
index 000000000000..9d966dc78d67
--- /dev/null
+++ b/arch/arm/mach-mvebu/include/mach/kirkwood.h
@@ -0,0 +1,142 @@
+/*
+ * arch/arm/mach-mvebu/include/mach/kirkwood.h
+ *
+ * Generic definitions for Marvell Kirkwood SoC flavors:
+ *  88F6180, 88F6192 and 88F6281.
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __ASM_ARCH_KIRKWOOD_H
+#define __ASM_ARCH_KIRKWOOD_H
+
+/*
+ * Marvell Kirkwood address maps.
+ *
+ * phys
+ * e0000000	PCIe #0 Memory space
+ * e8000000	PCIe #1 Memory space
+ * f1000000	on-chip peripheral registers
+ * f2000000	PCIe #0 I/O space
+ * f3000000	PCIe #1 I/O space
+ * f4000000	NAND controller address window
+ * f5000000	Security Accelerator SRAM
+ *
+ * virt		phys		size
+ * fed00000	f1000000	1M	on-chip peripheral registers
+ * fee00000	f2000000	1M	PCIe #0 I/O space
+ * fef00000	f3000000	1M	PCIe #1 I/O space
+ */
+
+#define KIRKWOOD_SRAM_PHYS_BASE		0xf5000000
+#define KIRKWOOD_SRAM_SIZE		SZ_2K
+
+#define KIRKWOOD_NAND_MEM_PHYS_BASE	0xf4000000
+#define KIRKWOOD_NAND_MEM_SIZE		SZ_1K
+
+#define KIRKWOOD_PCIE1_IO_PHYS_BASE	0xf3000000
+#define KIRKWOOD_PCIE1_IO_BUS_BASE	0x00010000
+#define KIRKWOOD_PCIE1_IO_SIZE		SZ_64K
+
+#define KIRKWOOD_PCIE_IO_PHYS_BASE	0xf2000000
+#define KIRKWOOD_PCIE_IO_BUS_BASE	0x00000000
+#define KIRKWOOD_PCIE_IO_SIZE		SZ_64K
+
+#define KIRKWOOD_REGS_PHYS_BASE		0xf1000000
+#define KIRKWOOD_REGS_VIRT_BASE		IOMEM(0xfed00000)
+#define KIRKWOOD_REGS_SIZE		SZ_1M
+
+#define KIRKWOOD_PCIE_MEM_PHYS_BASE	0xe0000000
+#define KIRKWOOD_PCIE_MEM_BUS_BASE	0xe0000000
+#define KIRKWOOD_PCIE_MEM_SIZE		SZ_128M
+
+#define KIRKWOOD_PCIE1_MEM_PHYS_BASE	0xe8000000
+#define KIRKWOOD_PCIE1_MEM_BUS_BASE	0xe8000000
+#define KIRKWOOD_PCIE1_MEM_SIZE		SZ_128M
+
+/*
+ * Register Map
+ */
+#define DDR_VIRT_BASE		(KIRKWOOD_REGS_VIRT_BASE + 0x00000)
+#define DDR_PHYS_BASE           (KIRKWOOD_REGS_PHYS_BASE + 0x00000)
+#define  DDR_WINDOW_CPU_BASE    (DDR_PHYS_BASE + 0x1500)
+#define  DDR_WINDOW_CPU_SZ      (0x20)
+#define DDR_OPERATION_BASE	(DDR_PHYS_BASE + 0x1418)
+
+#define DEV_BUS_PHYS_BASE	(KIRKWOOD_REGS_PHYS_BASE + 0x10000)
+#define DEV_BUS_VIRT_BASE	(KIRKWOOD_REGS_VIRT_BASE + 0x10000)
+#define  SAMPLE_AT_RESET	(DEV_BUS_VIRT_BASE + 0x0030)
+#define  DEVICE_ID		(DEV_BUS_VIRT_BASE + 0x0034)
+#define  GPIO_LOW_VIRT_BASE	(DEV_BUS_VIRT_BASE + 0x0100)
+#define  GPIO_HIGH_VIRT_BASE	(DEV_BUS_VIRT_BASE + 0x0140)
+#define  RTC_PHYS_BASE		(DEV_BUS_PHYS_BASE + 0x0300)
+#define  SPI_PHYS_BASE		(DEV_BUS_PHYS_BASE + 0x0600)
+#define  I2C_PHYS_BASE		(DEV_BUS_PHYS_BASE + 0x1000)
+#define  UART0_PHYS_BASE	(DEV_BUS_PHYS_BASE + 0x2000)
+#define  UART0_VIRT_BASE	(DEV_BUS_VIRT_BASE + 0x2000)
+#define  UART1_PHYS_BASE	(DEV_BUS_PHYS_BASE + 0x2100)
+#define  UART1_VIRT_BASE	(DEV_BUS_VIRT_BASE + 0x2100)
+
+#define BRIDGE_VIRT_BASE	(KIRKWOOD_REGS_VIRT_BASE + 0x20000)
+#define BRIDGE_PHYS_BASE	(KIRKWOOD_REGS_PHYS_BASE + 0x20000)
+#define  BRIDGE_WINS_BASE       (BRIDGE_PHYS_BASE)
+#define  BRIDGE_WINS_SZ         (0x80)
+
+#define CRYPTO_PHYS_BASE	(KIRKWOOD_REGS_PHYS_BASE + 0x30000)
+
+#define PCIE_VIRT_BASE		(KIRKWOOD_REGS_VIRT_BASE + 0x40000)
+#define PCIE_LINK_CTRL		(PCIE_VIRT_BASE + 0x70)
+#define PCIE_STATUS		(PCIE_VIRT_BASE + 0x1a04)
+#define PCIE1_VIRT_BASE		(KIRKWOOD_REGS_VIRT_BASE + 0x44000)
+#define PCIE1_LINK_CTRL		(PCIE1_VIRT_BASE + 0x70)
+#define PCIE1_STATUS		(PCIE1_VIRT_BASE + 0x1a04)
+
+#define USB_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE + 0x50000)
+
+#define XOR0_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE + 0x60800)
+#define XOR0_VIRT_BASE		(KIRKWOOD_REGS_VIRT_BASE + 0x60800)
+#define XOR1_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE + 0x60900)
+#define XOR1_VIRT_BASE		(KIRKWOOD_REGS_VIRT_BASE + 0x60900)
+#define XOR0_HIGH_PHYS_BASE	(KIRKWOOD_REGS_PHYS_BASE + 0x60A00)
+#define XOR0_HIGH_VIRT_BASE	(KIRKWOOD_REGS_VIRT_BASE + 0x60A00)
+#define XOR1_HIGH_PHYS_BASE	(KIRKWOOD_REGS_PHYS_BASE + 0x60B00)
+#define XOR1_HIGH_VIRT_BASE	(KIRKWOOD_REGS_VIRT_BASE + 0x60B00)
+
+#define GE00_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE + 0x70000)
+#define GE01_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE + 0x74000)
+
+#define SATA_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE + 0x80000)
+#define SATA_VIRT_BASE		(KIRKWOOD_REGS_VIRT_BASE + 0x80000)
+#define SATA0_IF_CTRL		(SATA_VIRT_BASE + 0x2050)
+#define SATA0_PHY_MODE_2	(SATA_VIRT_BASE + 0x2330)
+#define SATA1_IF_CTRL		(SATA_VIRT_BASE + 0x4050)
+#define SATA1_PHY_MODE_2	(SATA_VIRT_BASE + 0x4330)
+
+#define SDIO_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE + 0x90000)
+
+#define AUDIO_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE + 0xA0000)
+#define AUDIO_VIRT_BASE		(KIRKWOOD_REGS_VIRT_BASE + 0xA0000)
+
+/*
+ * Supported devices and revisions.
+ */
+#define MV88F6281_DEV_ID	0x6281
+#define MV88F6281_REV_Z0	0
+#define MV88F6281_REV_A0	2
+#define MV88F6281_REV_A1	3
+
+#define MV88F6192_DEV_ID	0x6192
+#define MV88F6192_REV_Z0	0
+#define MV88F6192_REV_A0	2
+#define MV88F6192_REV_A1	3
+
+#define MV88F6180_DEV_ID	0x6180
+#define MV88F6180_REV_A0	2
+#define MV88F6180_REV_A1	3
+
+#define MV88F6282_DEV_ID	0x6282
+#define MV88F6282_REV_A0	0
+#define MV88F6282_REV_A1	1
+#endif
diff --git a/arch/arm/mach-mvebu/kirkwood-pm.c b/arch/arm/mach-mvebu/kirkwood-pm.c
new file mode 100644
index 000000000000..b8c8365b84d8
--- /dev/null
+++ b/arch/arm/mach-mvebu/kirkwood-pm.c
@@ -0,0 +1,76 @@
+/*
+ * Power Management driver for Marvell Kirkwood SoCs
+ *
+ * Copyright (C) 2013 Ezequiel Garcia <ezequiel@free-electrons.com>
+ * Copyright (C) 2010 Simon Guinot <sguinot@lacie.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License,
+ * version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/suspend.h>
+#include <linux/io.h>
+#include <mach/bridge-regs.h>
+
+static void __iomem *ddr_operation_base;
+static void __iomem *memory_pm_ctrl;
+
+static void kirkwood_low_power(void)
+{
+	u32 mem_pm_ctrl;
+
+	mem_pm_ctrl = readl(memory_pm_ctrl);
+
+	/* Set peripherals to low-power mode */
+	writel_relaxed(~0, memory_pm_ctrl);
+
+	/* Set DDR in self-refresh */
+	writel_relaxed(0x7, ddr_operation_base);
+
+	/*
+	 * Set CPU in wait-for-interrupt state.
+	 * This disables the CPU core clocks,
+	 * the array clocks, and also the L2 controller.
+	 */
+	cpu_do_idle();
+
+	writel_relaxed(mem_pm_ctrl, memory_pm_ctrl);
+}
+
+static int kirkwood_suspend_enter(suspend_state_t state)
+{
+	switch (state) {
+	case PM_SUSPEND_STANDBY:
+		kirkwood_low_power();
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int kirkwood_pm_valid_standby(suspend_state_t state)
+{
+	return state == PM_SUSPEND_STANDBY;
+}
+
+static const struct platform_suspend_ops kirkwood_suspend_ops = {
+	.enter = kirkwood_suspend_enter,
+	.valid = kirkwood_pm_valid_standby,
+};
+
+int __init kirkwood_pm_init(void)
+{
+	ddr_operation_base = ioremap(DDR_OPERATION_BASE, 4);
+	memory_pm_ctrl = ioremap(MEMORY_PM_CTRL_PHYS, 4);
+
+	suspend_set_ops(&kirkwood_suspend_ops);
+	return 0;
+}
diff --git a/arch/arm/mach-mvebu/kirkwood-pm.h b/arch/arm/mach-mvebu/kirkwood-pm.h
new file mode 100644
index 000000000000..21e7530f368b
--- /dev/null
+++ b/arch/arm/mach-mvebu/kirkwood-pm.h
@@ -0,0 +1,26 @@
+/*
+ * Power Management driver for Marvell Kirkwood SoCs
+ *
+ * Copyright (C) 2013 Ezequiel Garcia <ezequiel@free-electrons.com>
+ * Copyright (C) 2010 Simon Guinot <sguinot@lacie.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License,
+ * version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __ARCH_KIRKWOOD_PM_H
+#define __ARCH_KIRKWOOD_PM_H
+
+#ifdef CONFIG_PM
+void kirkwood_pm_init(void);
+#else
+static inline void kirkwood_pm_init(void) {};
+#endif
+
+#endif
diff --git a/arch/arm/mach-mvebu/kirkwood.c b/arch/arm/mach-mvebu/kirkwood.c
new file mode 100644
index 000000000000..56e83035bc97
--- /dev/null
+++ b/arch/arm/mach-mvebu/kirkwood.c
@@ -0,0 +1,208 @@
+/*
+ * Copyright 2012 (C), Jason Cooper <jason@lakedaemon.net>
+ *
+ * arch/arm/mach-mvebu/kirkwood.c
+ *
+ * Flattened Device Tree board initialization
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/clk.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_net.h>
+#include <linux/of_platform.h>
+#include <linux/dma-mapping.h>
+#include <linux/irqchip.h>
+#include <linux/kexec.h>
+#include <asm/hardware/cache-feroceon-l2.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <mach/bridge-regs.h>
+#include <plat/common.h>
+#include <plat/pcie.h>
+#include "kirkwood-pm.h"
+
+static struct resource kirkwood_cpufreq_resources[] = {
+	[0] = {
+		.start  = CPU_CONTROL_PHYS,
+		.end    = CPU_CONTROL_PHYS + 3,
+		.flags  = IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device kirkwood_cpufreq_device = {
+	.name		= "kirkwood-cpufreq",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(kirkwood_cpufreq_resources),
+	.resource	= kirkwood_cpufreq_resources,
+};
+
+static void __init kirkwood_cpufreq_init(void)
+{
+	platform_device_register(&kirkwood_cpufreq_device);
+}
+
+static struct resource kirkwood_cpuidle_resource[] = {
+	{
+		.flags	= IORESOURCE_MEM,
+		.start	= DDR_OPERATION_BASE,
+		.end	= DDR_OPERATION_BASE + 3,
+	},
+};
+
+static struct platform_device kirkwood_cpuidle = {
+	.name		= "kirkwood_cpuidle",
+	.id		= -1,
+	.resource	= kirkwood_cpuidle_resource,
+	.num_resources	= 1,
+};
+
+static void __init kirkwood_cpuidle_init(void)
+{
+	platform_device_register(&kirkwood_cpuidle);
+}
+
+/* Temporary here since mach-mvebu has a function we can use */
+static void kirkwood_restart(enum reboot_mode mode, const char *cmd)
+{
+	/*
+	 * Enable soft reset to assert RSTOUTn.
+	 */
+	writel(SOFT_RESET_OUT_EN, RSTOUTn_MASK);
+
+	/*
+	 * Assert soft reset.
+	 */
+	writel(SOFT_RESET, SYSTEM_SOFT_RESET);
+
+	while (1)
+		;
+}
+
+#define MV643XX_ETH_MAC_ADDR_LOW	0x0414
+#define MV643XX_ETH_MAC_ADDR_HIGH	0x0418
+
+static void __init kirkwood_dt_eth_fixup(void)
+{
+	struct device_node *np;
+
+	/*
+	 * The ethernet interfaces forget the MAC address assigned by u-boot
+	 * if the clocks are turned off. Usually, u-boot on kirkwood boards
+	 * has no DT support to properly set local-mac-address property.
+	 * As a workaround, we get the MAC address from mv643xx_eth registers
+	 * and update the port device node if no valid MAC address is set.
+	 */
+	for_each_compatible_node(np, NULL, "marvell,kirkwood-eth-port") {
+		struct device_node *pnp = of_get_parent(np);
+		struct clk *clk;
+		struct property *pmac;
+		void __iomem *io;
+		u8 *macaddr;
+		u32 reg;
+
+		if (!pnp)
+			continue;
+
+		/* skip disabled nodes or nodes with valid MAC address*/
+		if (!of_device_is_available(pnp) || of_get_mac_address(np))
+			goto eth_fixup_skip;
+
+		clk = of_clk_get(pnp, 0);
+		if (IS_ERR(clk))
+			goto eth_fixup_skip;
+
+		io = of_iomap(pnp, 0);
+		if (!io)
+			goto eth_fixup_no_map;
+
+		/* ensure port clock is not gated to not hang CPU */
+		clk_prepare_enable(clk);
+
+		/* store MAC address register contents in local-mac-address */
+		pr_err(FW_INFO "%s: local-mac-address is not set\n",
+		       np->full_name);
+
+		pmac = kzalloc(sizeof(*pmac) + 6, GFP_KERNEL);
+		if (!pmac)
+			goto eth_fixup_no_mem;
+
+		pmac->value = pmac + 1;
+		pmac->length = 6;
+		pmac->name = kstrdup("local-mac-address", GFP_KERNEL);
+		if (!pmac->name) {
+			kfree(pmac);
+			goto eth_fixup_no_mem;
+		}
+
+		macaddr = pmac->value;
+		reg = readl(io + MV643XX_ETH_MAC_ADDR_HIGH);
+		macaddr[0] = (reg >> 24) & 0xff;
+		macaddr[1] = (reg >> 16) & 0xff;
+		macaddr[2] = (reg >> 8) & 0xff;
+		macaddr[3] = reg & 0xff;
+
+		reg = readl(io + MV643XX_ETH_MAC_ADDR_LOW);
+		macaddr[4] = (reg >> 8) & 0xff;
+		macaddr[5] = reg & 0xff;
+
+		of_update_property(np, pmac);
+
+eth_fixup_no_mem:
+		iounmap(io);
+		clk_disable_unprepare(clk);
+eth_fixup_no_map:
+		clk_put(clk);
+eth_fixup_skip:
+		of_node_put(pnp);
+	}
+}
+
+/*
+ * Disable propagation of mbus errors to the CPU local bus, as this
+ * causes mbus errors (which can occur for example for PCI aborts) to
+ * throw CPU aborts, which we're not set up to deal with.
+ */
+void kirkwood_disable_mbus_error_propagation(void)
+{
+	void __iomem *cpu_config;
+
+	cpu_config = ioremap(CPU_CONFIG_PHYS, 4);
+	writel(readl(cpu_config) & ~CPU_CONFIG_ERROR_PROP, cpu_config);
+}
+
+
+static void __init kirkwood_dt_init(void)
+{
+	kirkwood_disable_mbus_error_propagation();
+
+	BUG_ON(mvebu_mbus_dt_init());
+
+	feroceon_of_init();
+
+	kirkwood_cpufreq_init();
+	kirkwood_cpuidle_init();
+
+	kirkwood_pm_init();
+	kirkwood_dt_eth_fixup();
+
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static const char * const kirkwood_dt_board_compat[] = {
+	"marvell,kirkwood",
+	NULL
+};
+
+DT_MACHINE_START(KIRKWOOD_DT, "Marvell Kirkwood (Flattened Device Tree)")
+	/* Maintainer: Jason Cooper <jason@lakedaemon.net> */
+	.init_machine	= kirkwood_dt_init,
+	.restart	= kirkwood_restart,
+	.dt_compat	= kirkwood_dt_board_compat,
+MACHINE_END
-- 
1.8.5.3
