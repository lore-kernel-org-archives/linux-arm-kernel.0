From: dinguyen@altera.com (dinguyen at altera.com)
Date: Thu, 12 Jul 2012 12:26:16 -0500
Subject: [RFC PATCHv2 2/2] ARM: socfpga: Add board support for Altera's
 SOCFPGA Cyclone 5 HW
In-Reply-To: <1342113976-27140-1-git-send-email-dinguyen@altera.com>
References: <1342113976-27140-1-git-send-email-dinguyen@altera.com>
Message-ID: <1342113976-27140-3-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

- Mininum support for Altera's SOCFPGA Cyclone 5 hardware.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Reviewed-by: Pavel Machek <pavel@denx.de>
---
 arch/arm/boot/dts/socfpga.dtsi           |   73 ++++++++++++++++++
 arch/arm/boot/dts/socfpga_cyclone5.dts   |  118 ++++++++++++++++++++++++++++++
 arch/arm/configs/socfpga_defconfig       |   83 +++++++++++++++++++++
 arch/arm/mach-socfpga/Kconfig            |    7 ++
 arch/arm/mach-socfpga/Makefile           |    6 ++
 arch/arm/mach-socfpga/Makefile.boot      |    1 +
 arch/arm/mach-socfpga/common.h           |    2 +-
 arch/arm/mach-socfpga/socfpga_cyclone5.c |   60 +++++++++++++++
 8 files changed, 349 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/socfpga.dtsi
 create mode 100644 arch/arm/boot/dts/socfpga_cyclone5.dts
 create mode 100644 arch/arm/configs/socfpga_defconfig
 create mode 100644 arch/arm/mach-socfpga/Kconfig
 create mode 100644 arch/arm/mach-socfpga/Makefile
 create mode 100644 arch/arm/mach-socfpga/Makefile.boot
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
index 0000000..710c773
--- /dev/null
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dts
@@ -0,0 +1,118 @@
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
+		timer0: timer at ffc08000 {
+				compatible = "snps,dw-apb-timer-sp";
+				interrupts = <0 167 4>;
+				clock-frequency = <200000000>;
+				reg = <0xffc08000 0x1000>;
+			};
+
+		timer1: timer at ffc09000 {
+				compatible = "snps,dw-apb-timer-sp";
+				interrupts = <0 168 4>;
+				clock-frequency = <200000000>;
+				reg = <0xffc09000 0x1000>;
+			};
+
+		timer2: timer at ffd00000 {
+				compatible = "snps,dw-apb-timer-osc";
+				interrupts = <0 169 4>;
+				clock-frequency = <200000000>;
+				reg = <0xffd00000 0x1000>;
+			};
+
+		timer3: timer at ffd01000 {
+				compatible = "snps,dw-apb-timer-osc";
+				interrupts = <0 170 4>;
+				clock-frequency = <200000000>;
+				reg = <0xffd01000 0x1000>;
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
index 0000000..0ac1293
--- /dev/null
+++ b/arch/arm/configs/socfpga_defconfig
@@ -0,0 +1,83 @@
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
+CONFIG_VMSPLIT_2G=y
+CONFIG_NR_CPUS=2
+CONFIG_AEABI=y
+CONFIG_ZBOOT_ROM_TEXT=0x0
+CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_CMDLINE=""
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
diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
new file mode 100644
index 0000000..133fc89
--- /dev/null
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -0,0 +1,7 @@
+config MACH_SOCFPGA_CYCLONE5
+       bool "SOCFPGA Cyclone5 platform"
+       select COMMON_CLK
+       select HAVE_SMP
+       select PLAT_SOCFPGA_ETH
+       help
+         Include support for the Altera(R) Cyclone5 development platform.
diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
new file mode 100644
index 0000000..c994b40
--- /dev/null
+++ b/arch/arm/mach-socfpga/Makefile
@@ -0,0 +1,6 @@
+#
+# Makefile for the linux kernel.
+#
+
+obj-y					:= clock.o
+obj-$(CONFIG_MACH_SOCFPGA_CYCLONE5)	+= socfpga_cyclone5.o
diff --git a/arch/arm/mach-socfpga/Makefile.boot b/arch/arm/mach-socfpga/Makefile.boot
new file mode 100644
index 0000000..dae9661
--- /dev/null
+++ b/arch/arm/mach-socfpga/Makefile.boot
@@ -0,0 +1 @@
+zreladdr-y	:= 0x00008000
diff --git a/arch/arm/mach-socfpga/common.h b/arch/arm/mach-socfpga/common.h
index e66587f..ba90e7a 100644
--- a/arch/arm/mach-socfpga/common.h
+++ b/arch/arm/mach-socfpga/common.h
@@ -18,6 +18,6 @@
 #ifndef __MACH_SOCFPGA_COMMON_H
 #define __MACH_SOCFPGA_COMMON_H
 
-extern struct sys_timer socfpga_timer;
+extern struct sys_timer dw_apb_timer;
 
 #endif
diff --git a/arch/arm/mach-socfpga/socfpga_cyclone5.c b/arch/arm/mach-socfpga/socfpga_cyclone5.c
new file mode 100644
index 0000000..e2748c7
--- /dev/null
+++ b/arch/arm/mach-socfpga/socfpga_cyclone5.c
@@ -0,0 +1,60 @@
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
+#include <linux/dw_apb_timer.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+
+#include <asm/hardware/cache-l2x0.h>
+#include <asm/hardware/gic.h>
+#include <asm/mach/arch.h>
+
+#include "common.h"
+
+const static struct of_device_id irq_match[] = {
+	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
+	{}
+};
+
+static void __init gic_init_irq(void)
+{
+	of_irq_init(irq_match);
+}
+
+static void socfpga_cyclone5_restart(char mode, const char *cmd)
+{
+	/* TODO: */
+}
+
+static void __init socfpga_cyclone5_init(void)
+{
+	l2x0_of_init(0, ~0UL);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static const char *altera_dt_match[] = {
+	"altr,socfpga-cyclone5",
+	NULL
+};
+
+DT_MACHINE_START(SOCFPGA_CYCLONE5, "Altera SOCFPGA Cyclone V")
+	.init_irq	= gic_init_irq,
+	.handle_irq     = gic_handle_irq,
+	.timer		= &dw_apb_timer,
+	.init_machine	= socfpga_cyclone5_init,
+	.restart	= socfpga_cyclone5_restart,
+	.dt_compat	= altera_dt_match,
+MACHINE_END
-- 
1.7.9.5
