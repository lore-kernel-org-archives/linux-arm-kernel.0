From: dinguyen@altera.com (dinguyen at altera.com)
Date: Wed, 27 Jun 2012 08:50:07 -0500
Subject: [RFC PATCHv1 2/2] ARM: socfpga: Add board support for Altera's
 SOCFPGA Cyclone 5 HW
In-Reply-To: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
References: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
Message-ID: <1340805007-3313-3-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

- Mininum support for Altera's SOCFPGA Cyclone 5 hardware.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Reviewed-by: Pavel Machek <pavel@denx.de>
---
 arch/arm/boot/dts/socfpga.dtsi                     |   73 +++++++++
 arch/arm/boot/dts/socfpga_cyclone5.dts             |   90 +++++++++++
 arch/arm/configs/socfpga_defconfig                 |   84 ++++++++++
 arch/arm/mach-socfpga/include/mach/clkdev.h        |   16 ++
 .../mach-socfpga/include/mach/socfpga_cyclone5.h   |   83 ++++++++++
 arch/arm/mach-socfpga/socfpga_cyclone5.c           |  161 ++++++++++++++++++++
 arch/arm/tools/mach-types                          |    1 +
 7 files changed, 508 insertions(+)
 create mode 100644 arch/arm/boot/dts/socfpga.dtsi
 create mode 100644 arch/arm/boot/dts/socfpga_cyclone5.dts
 create mode 100644 arch/arm/configs/socfpga_defconfig
 create mode 100644 arch/arm/mach-socfpga/include/mach/clkdev.h
 create mode 100644 arch/arm/mach-socfpga/include/mach/socfpga_cyclone5.h
 create mode 100644 arch/arm/mach-socfpga/socfpga_cyclone5.c

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
new file mode 100644
index 0000000..54489b5
--- /dev/null
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -0,0 +1,73 @@
+/*
+ *  Copyright (C) 2012 Altera <www.altera.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+			reg = <0>;
+			next-level-cache = <&L2>;
+		};
+		cpu at 1 {
+			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+			reg = <1>;
+			next-level-cache = <&L2>;
+		};
+	};
+
+	intc: intc at fffed000 {
+		compatible = "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0xfffed000 0x1000>,
+		      <0xfffec100 0x100>;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		device_type = "soc";
+		interrupt-parent = <&intc>;
+		ranges;
+
+		/* Local timer */
+		timer at fffec600 {
+			compatible = "arm,cortex-a9-twd-timer";
+			reg = <0xfffec600 0x100>;
+			interrupts = <1 13 0xf04>;
+		};
+
+		L2: l2-cache at fffef000 {
+			compatible = "arm,pl310-cache";
+			reg = <0xfffef000 0x1000>;
+			interrupts = <0 38 0x04>;
+			cache-unified;
+			cache-level = <2>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dts b/arch/arm/boot/dts/socfpga_cyclone5.dts
new file mode 100644
index 0000000..453a7e2
--- /dev/null
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dts
@@ -0,0 +1,90 @@
+/*
+ *  Copyright (C) 2012 Altera Corporation <www.altera.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/dts-v1/;
+/include/ "socfpga.dtsi"
+
+/ {
+	model = "Altera SOCFPGA Cyclone V";
+	compatible = "altr,socfpga-cyclone5";
+
+	aliases {
+		ethernet0 = &gmac0;
+		serial0 = &uart0;
+		serial1 = &uart1;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,57600";
+	};
+
+	memory {
+		name = "memory";
+		device_type = "memory";
+		reg = <0x0 0x10000000>; /* 256MB */
+	};
+
+	soc {
+		amba {
+			compatible = "arm,amba-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			pdma: pdma at ffe01000 {
+				compatible = "arm,pl330", "arm,primecell";
+				reg = <0xffe01000 0x1000>;
+				interrupts = <0 180 4>;
+			};
+		};
+
+		apb_periphs {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			uart0: uart at ffc02000 {
+				compatible = "snps,dw-apb-uart";
+				reg = <0xffc02000 0x1000>;
+				clock-frequency = <7372800>;
+				interrupts = <0 162 4>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+			};
+
+			uart1: uart at ffc03000 {
+				compatible = "snps,dw-apb-uart";
+				reg = <0xffc03000 0x1000>;
+				clock-frequency = <7372800>;
+				interrupts = <0 163 4>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+			};
+
+         gmac0: stmmac at ff700000 {
+            compatible = "st,spear600-gmac";
+            reg = <0xff700000 0x2000>;
+            interrupts = <0 115 4>;
+            interrupt-names = "macirq";
+            mac-address = [00 00 00 00 00 00];/* Filled in by U-Boot */
+            phy-mode = "gmii";
+            };
+
+		};
+	};
+};
diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
new file mode 100644
index 0000000..aac8731
--- /dev/null
+++ b/arch/arm/configs/socfpga_defconfig
@@ -0,0 +1,84 @@
+CONFIG_EXPERIMENTAL=y
+CONFIG_SYSVIPC=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_CGROUPS=y
+CONFIG_CPUSETS=y
+CONFIG_NAMESPACES=y
+CONFIG_EMBEDDED=y
+CONFIG_PROFILING=y
+CONFIG_OPROFILE=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_LBDAF is not set
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+CONFIG_ARCH_SOCFPGA=y
+CONFIG_MACH_SOCFPGA_CYCLONE5=y
+CONFIG_ARM_THUMBEE=y
+# CONFIG_CACHE_L2X0 is not set
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_SMP=y
+CONFIG_VMSPLIT_2G=y
+CONFIG_NR_CPUS=2
+CONFIG_AEABI=y
+CONFIG_ZBOOT_ROM_TEXT=0x0
+CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_CMDLINE="console=ttyS0,57600 mem=256M at 0x0"
+CONFIG_VFP=y
+CONFIG_NEON=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_NET_KEY=y
+CONFIG_NET_KEY_MIGRATE=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_PROC_DEVICETREE=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=2
+CONFIG_BLK_DEV_RAM_SIZE=8192
+CONFIG_SCSI=y
+# CONFIG_SCSI_PROC_FS is not set
+CONFIG_BLK_DEV_SD=y
+# CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_NETDEVICES=y
+CONFIG_STMMAC_ETH=y
+# CONFIG_STMMAC_PHY_ID_ZERO_WORKAROUND is not set
+CONFIG_INPUT_EVDEV=y
+# CONFIG_SERIO_SERPORT is not set
+CONFIG_SERIO_AMBAKMI=y
+CONFIG_LEGACY_PTY_COUNT=16
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=2
+CONFIG_SERIAL_8250_RUNTIME_UARTS=2
+CONFIG_SERIAL_8250_DW=y
+# CONFIG_RTC_HCTOSYS is not set
+CONFIG_EXT2_FS=y
+CONFIG_EXT2_FS_XATTR=y
+CONFIG_EXT2_FS_POSIX_ACL=y
+# CONFIG_DNOTIFY is not set
+# CONFIG_INOTIFY_USER is not set
+CONFIG_VFAT_FS=y
+CONFIG_NTFS_FS=y
+CONFIG_NTFS_RW=y
+CONFIG_TMPFS=y
+CONFIG_JFFS2_FS=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DETECT_HUNG_TASK=y
+# CONFIG_SCHED_DEBUG is not set
+CONFIG_DEBUG_INFO=y
+CONFIG_ENABLE_DEFAULT_TRACERS=y
+CONFIG_DEBUG_USER=y
+CONFIG_XZ_DEC=y
diff --git a/arch/arm/mach-socfpga/include/mach/clkdev.h b/arch/arm/mach-socfpga/include/mach/clkdev.h
new file mode 100644
index 0000000..1eeecc4
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/clkdev.h
@@ -0,0 +1,16 @@
+#ifndef __ASM_MACH_CLKDEV_H
+#define __ASM_MACH_CLKDEV_H
+
+#include <mach/clock.h>
+
+struct clk {
+	unsigned long		rate;
+	const struct clk_ops	*ops;
+	const struct icst_params *params;
+	void __iomem		*vcoreg;
+};
+
+#define __clk_get(clk) ({ 1; })
+#define __clk_put(clk) do { } while (0)
+
+#endif
diff --git a/arch/arm/mach-socfpga/include/mach/socfpga_cyclone5.h b/arch/arm/mach-socfpga/include/mach/socfpga_cyclone5.h
new file mode 100644
index 0000000..7787f9d
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/socfpga_cyclone5.h
@@ -0,0 +1,83 @@
+/*
+ * Copyright (C) 2012 Altera Corporation <www.altera.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+*/
+
+#ifndef __ASM_ARCH_BOARD_SOCFPGA_CYCLONE5_H
+#define __ASM_ARCH_BOARD_SOCFPGA_CYCLONE5_H
+
+#undef __ASM_ARCH_BOARD_SOCFPGA_CYCLONE5_H
+
+#define SOCFPGA_LWFPGASLAVES_BASE 	(0xff200000)
+#define SOCFPGA_LWHPS2FPGAREGS_BASE (0xff400000)
+#define SOCFPGA_HPS2FPGAREGS_BASE	(0xff500000)
+#define SOCFPGA_FPGA2HPSREGS_BASE 	(0xff600000)
+#define SOCFPGA_EMAC0_BASE 		(0xff700000)
+#define SOCFPGA_EMAC1_BASE 		(0xff702000)
+#define SOCFPGA_SDMMC_BASE 		(0xff704000)
+#define SOCFPGA_QSPIREGS_BASE 	(0xff705000)
+#define SOCFPGA_FPGAMGRREGS_BASE 	(0xff706000)
+#define SOCFPGA_ACPIDMAP_BASE 	(0xff707000)
+#define SOCFPGA_GPIO0_BASE 		(0xff708000)
+#define SOCFPGA_GPIO1_BASE 		(0xff709000)
+#define SOCFPGA_GPIO2_BASE 		(0xff70a000)
+#define SOCFPGA_L3REGS_BASE 	(0xff800000)
+#define SOCFPGA_NANDDATA_BASE 	(0xff900000)
+#define SOCFPGA_QSPIDATA_BASE 	(0xffa00000)
+#define SOCFPGA_USB0_BASE 		(0xffb00000)
+#define SOCFPGA_USB1_BASE 		(0xffb40000)
+#define SOCFPGA_NANDREGS_BASE 	(0xffb80000)
+#define SOCFPGA_FPGAMGRDATA_BASE 	(0xffb90000)
+#define SOCFPGA_CAN0_BASE 		(0xffc00000)
+#define SOCFPGA_CAN1_BASE 		(0xffc01000)
+#define SOCFPGA_UART0_BASE 		(0xffc02000)
+#define SOCFPGA_UART1_BASE 		(0xffc03000)
+#define SOCFPGA_I2C0_BASE 		(0xffc04000)
+#define SOCFPGA_I2C1_BASE 		(0xffc05000)
+#define SOCFPGA_I2C2MDIO0_BASE 	(0xffc06000)
+#define SOCFPGA_I2C3MDIO1_BASE 	(0xffc07000)
+#define SOCFPGA_SPTIMER0_BASE 	(0xffc08000)
+#define SOCFPGA_SPTIMER1_BASE 	(0xffc09000)
+#define SOCFPGA_SDR_BASE 		(0xffc20000)
+#define SOCFPGA_OSC1TIMER0_BASE 	(0xffd00000)
+#define SOCFPGA_OSC1TIMER1_BASE 	(0xffd01000)
+#define SOCFPGA_L4WD0_BASE 		(0xffd02000)
+#define SOCFPGA_L4WD1_BASE 		(0xffd03000)
+#define SOCFPGA_CLKMGR_BASE 	(0xffd04000)
+#define SOCFPGA_RSTMGR_BASE 	(0xffd05000)
+#define SOCFPGA_SYSMGR_BASE 	(0xffd08000)
+#define SOCFPGA_DMANONSECURE_BASE 	(0xffe00000)
+#define SOCFPGA_DMASECURE_BASE 	(0xffe01000)
+#define SOCFPGA_SPIS0_BASE 		(0xffe02000)
+#define SOCFPGA_SPIS1_BASE 		(0xffe03000)
+#define SOCFPGA_SPIM0_BASE 		(0xfff00000)
+#define SOCFPGA_SPIM1_BASE 		(0xfff01000)
+#define SOCFPGA_SCANMGR_BASE 	(0xfff02000)
+#define SOCFPGA_ROM_BASE 		(0xfffd0000)
+#define SOCFPGA_MPUSCU_BASE 	(0xfffec000)
+#define SOCFPGA_MPUL2_BASE 		(0xfffef000)
+#define SOCFPGA_OCRAM_BASE 		(0xffff0000)
+
+#define SOCFPGA_GIC_CPU_BASE	(SOCFPGA_MPUSCU_BASE + 0x100)
+#define SOCFPGA_TWD_BASE		(SOCFPGA_MPUSCU_BASE + 0x600)
+#define SOCFPGA_GIC_DIST_BASE	(SOCFPGA_MPUSCU_BASE + 0x1000)
+
+/* System Manager */
+#define SOCFPGA_SMP_FLAG		(SOCFPGA_SYSMGR_BASE + 0x10)
+#define SOCFPGA_SYSMGR_SDMMCGRP_CTR	(SOCFPGA_SYSMGR_BASE + 0x108)
+
+/* Clock Manager */
+#define SOCFPGA_CLKMGR_PERPLLGRP_EN	(SOCFPGA_CLKMGR_BASE + 0xA0)
+
+#endif /* __ASM_ARCH_BOARD_SOCFPGA_CYCLONE5_H */
diff --git a/arch/arm/mach-socfpga/socfpga_cyclone5.c b/arch/arm/mach-socfpga/socfpga_cyclone5.c
new file mode 100644
index 0000000..76429b5
--- /dev/null
+++ b/arch/arm/mach-socfpga/socfpga_cyclone5.c
@@ -0,0 +1,161 @@
+/*
+ *  Copyright (C) 2012 Altera Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/device.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <mach/iomap.h>
+#include <mach/socfpga-timer.h>
+#include <mach/dw_apb_timer.h>
+#include <mach/socfpga_cyclone5.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/time.h>
+#include <asm/hardware/gic.h>
+#include <asm/smp_twd.h>
+
+#include "common.h"
+
+/*
+ * Lookup table for attaching a specific name and platform_data pointer to
+ * devices as they get created by of_platform_populate().  Ideally this table
+ * would not exist, but the current clock implementation depends on some devices
+ * having a specific name.
+ */
+static const struct of_dev_auxdata cyclone5_auxdata_lookup[] __initconst = {
+	OF_DEV_AUXDATA("snps,dw-spi-mmio", SOCFPGA_SPIM0_BASE, "dw-spi-mmio.0", NULL),
+	OF_DEV_AUXDATA("snps,dw-spi-mmio", SOCFPGA_SPIM1_BASE, "dw-spi-mmio.1", NULL),
+	OF_DEV_AUXDATA("arm,pl330", SOCFPGA_DMASECURE_BASE, "dma-pl330", NULL),
+	{ /* sentinel */ }
+};
+
+const static struct of_device_id irq_match[] = {
+	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
+	{}
+};
+
+static struct map_desc cyclone5_io_desc[] __initdata = {
+	{
+		.virtual	= IO_ADDRESS(SOCFPGA_SPTIMER0_BASE),
+		.pfn		= __phys_to_pfn(SOCFPGA_SPTIMER0_BASE),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= IO_ADDRESS(SOCFPGA_SPTIMER1_BASE),
+		.pfn		= __phys_to_pfn(SOCFPGA_SPTIMER1_BASE),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= IO_ADDRESS(SOCFPGA_OSC1TIMER0_BASE),
+		.pfn		= __phys_to_pfn(SOCFPGA_OSC1TIMER0_BASE),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= IO_ADDRESS(SOCFPGA_OSC1TIMER1_BASE),
+		.pfn		= __phys_to_pfn(SOCFPGA_OSC1TIMER1_BASE),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= IO_ADDRESS(SOCFPGA_MPUSCU_BASE),
+		.pfn		= __phys_to_pfn(SOCFPGA_MPUSCU_BASE),
+		.length		= SZ_8K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= IO_ADDRESS(SOCFPGA_SYSMGR_BASE),
+		.pfn		= __phys_to_pfn(SOCFPGA_SYSMGR_BASE),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= IO_ADDRESS(SOCFPGA_MPUL2_BASE),
+		.pfn		= __phys_to_pfn(SOCFPGA_MPUL2_BASE),
+		.length		= SZ_8K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= IO_ADDRESS(SOCFPGA_CLKMGR_BASE),
+		.pfn		= __phys_to_pfn(SOCFPGA_CLKMGR_BASE),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	},
+};
+
+static void __init cyclone5_map_io(void)
+{
+	iotable_init(cyclone5_io_desc, ARRAY_SIZE(cyclone5_io_desc));
+}
+
+static void __init gic_init_irq(void)
+{
+	of_irq_init(irq_match);
+}
+
+/*
+ * Set up the clock source and clock events devices
+ */
+static void __init socfpga_cyclone5_timer_init(void)
+{
+	sp_timer0_va_base = __io_address(SOCFPGA_SPTIMER0_BASE);
+	sp_timer1_va_base = __io_address(SOCFPGA_SPTIMER1_BASE);
+	osc_timer0_va_base = __io_address(SOCFPGA_OSC1TIMER0_BASE);
+	osc_timer1_va_base = __io_address(SOCFPGA_OSC1TIMER1_BASE);
+
+	socfpga_timer_init(sp_timer0_va_base, osc_timer0_va_base,
+				IRQ_SOCFPGA_L4_OSC1_TIMER0);
+#ifdef CONFIG_OF
+	twd_local_timer_of_register();
+#endif
+}
+
+static struct sys_timer socfpga_cyclone5_timer = {
+	.init		= socfpga_cyclone5_timer_init,
+};
+
+static void socfpga_cyclone5_restart(char mode, const char *cmd)
+{
+	/* TODO: */
+}
+
+static void __init socfpga_cyclone5_init(void)
+{
+#ifdef CONFIG_CACHE_L2X0
+	/* 8-way, 64K/way, evmon/parity/share */
+	l2x0_of_init(0x00760000, 0xfe000fff);
+#endif
+	platform_notify =  socfpga_notifier;
+	of_platform_populate(NULL, of_default_bus_match_table,
+		cyclone5_auxdata_lookup, NULL);
+}
+
+static const char *altera_dt_match[] = {
+	"altr,socfpga-cyclone5",
+	NULL
+};
+
+MACHINE_START(SOCFPGA_CYCLONE5, "Altera SOCFPGA Cyclone V")
+	.atag_offset    = 0x100,
+	.fixup		= socfpga_fixup,
+	.map_io		= cyclone5_map_io,
+	.init_early	= socfpga_init_early,
+	.init_irq	= gic_init_irq,
+	.handle_irq     = gic_handle_irq,
+	.timer		= &socfpga_cyclone5_timer,
+	.init_machine	= socfpga_cyclone5_init,
+	.restart	= socfpga_cyclone5_restart,
+	.dt_compat	= altera_dt_match,
+MACHINE_END
diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index 2997e56..c6ed4b1 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -1206,3 +1206,4 @@ baileys			MACH_BAILEYS		BAILEYS			4169
 familybox		MACH_FAMILYBOX		FAMILYBOX		4170
 ensemble_mx35		MACH_ENSEMBLE_MX35	ENSEMBLE_MX35		4171
 sc_sps_1		MACH_SC_SPS_1		SC_SPS_1		4172
+socfpga_cyclone5	MACH_SOCFPGA_CYCLONE5	SOCFPGA_CYCLONE5	4251
-- 
1.7.9.5
