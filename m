From: dinguyen@altera.com (dinguyen at altera.com)
Date: Tue, 17 Jul 2012 18:50:56 -0600
Subject: [RFC PATCHv3 2/2] ARM: socfpga: Add DTS bindings for Altera's SOCFPGA
In-Reply-To: <1342572656-5205-1-git-send-email-dinguyen@altera.com>
References: <1342572656-5205-1-git-send-email-dinguyen@altera.com>
Message-ID: <1342572656-5205-3-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Add the dts, dtsi, and socfpga_defconfig for Altera's SOCFPGA
platform. Mininum support for Altera's SOCFPGA Cyclone 5 hardware.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Reviewed-by: Pavel Machek <pavel@denx.de>
Reviewed-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/boot/dts/socfpga.dtsi         |  119 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/socfpga_cyclone5.dts |   71 +++++++++++++++++++
 arch/arm/configs/socfpga_defconfig     |   83 ++++++++++++++++++++++
 3 files changed, 273 insertions(+)
 create mode 100644 arch/arm/boot/dts/socfpga.dtsi
 create mode 100644 arch/arm/boot/dts/socfpga_cyclone5.dts
 create mode 100644 arch/arm/configs/socfpga_defconfig

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
new file mode 100644
index 0000000..903d4bb
--- /dev/null
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -0,0 +1,119 @@
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
+		L2: l2-cache at fffef000 {
+			compatible = "arm,pl310-cache";
+			reg = <0xfffef000 0x1000>;
+			interrupts = <0 38 0x04>;
+			cache-unified;
+			cache-level = <2>;
+		};
+
+		/* Local timer */
+		timer at fffec600 {
+			compatible = "arm,cortex-a9-twd-timer";
+			reg = <0xfffec600 0x100>;
+			interrupts = <1 13 0xf04>;
+		};
+
+		timer0: timer at ffc08000 {
+			compatible = "snps,dw-apb-timer-sp";
+			interrupts = <0 167 4>;
+			clock-frequency = <200000000>;
+			reg = <0xffc08000 0x1000>;
+		};
+
+		timer1: timer at ffc09000 {
+			compatible = "snps,dw-apb-timer-sp";
+			interrupts = <0 168 4>;
+			clock-frequency = <200000000>;
+			reg = <0xffc09000 0x1000>;
+		};
+
+		timer2: timer at ffd00000 {
+			compatible = "snps,dw-apb-timer-osc";
+			interrupts = <0 169 4>;
+			clock-frequency = <200000000>;
+			reg = <0xffd00000 0x1000>;
+		};
+
+		timer3: timer at ffd01000 {
+			compatible = "snps,dw-apb-timer-osc";
+			interrupts = <0 170 4>;
+			clock-frequency = <200000000>;
+			reg = <0xffd01000 0x1000>;
+		};
+
+		uart0: uart at ffc02000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0xffc02000 0x1000>;
+			clock-frequency = <7372800>;
+			interrupts = <0 162 4>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+		};
+
+		uart1: uart at ffc03000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0xffc03000 0x1000>;
+			clock-frequency = <7372800>;
+			interrupts = <0 163 4>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dts b/arch/arm/boot/dts/socfpga_cyclone5.dts
new file mode 100644
index 0000000..3433ee3
--- /dev/null
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dts
@@ -0,0 +1,71 @@
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
+			gmac0: stmmac at ff700000 {
+				compatible = "st,spear600-gmac";
+				reg = <0xff700000 0x2000>;
+				interrupts = <0 115 4>;
+				interrupt-names = "macirq";
+				mac-address = [00 00 00 00 00 00];/* Filled in by U-Boot */
+				phy-mode = "gmii";
+			};
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
-- 
1.7.9.5
