From: linux@rempel-privat.de (Oleksij Rempel)
Date: Sun, 21 Sep 2014 20:45:47 +0200
Subject: [PATCH v2 4/8] ARM: dts: add DT for Alphascale ASM9260 SoC
In-Reply-To: <1411325151-15107-1-git-send-email-linux@rempel-privat.de>
References: <1411324904-14881-1-git-send-email-linux@rempel-privat.de>
 <1411325151-15107-1-git-send-email-linux@rempel-privat.de>
Message-ID: <1411325151-15107-3-git-send-email-linux@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
---
 arch/arm/boot/dts/Makefile                      |   2 +
 arch/arm/boot/dts/alphascale-asm9260-devkit.dts |  15 +++
 arch/arm/boot/dts/alphascale-asm9260.dtsi       | 166 ++++++++++++++++++++++++
 3 files changed, 183 insertions(+)
 create mode 100644 arch/arm/boot/dts/alphascale-asm9260-devkit.dts
 create mode 100644 arch/arm/boot/dts/alphascale-asm9260.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b8c5cd3..8943d72 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -492,6 +492,8 @@ dtb-$(CONFIG_MACH_DOVE) += dove-cm-a510.dtb \
 	dove-d3plug.dtb \
 	dove-dove-db.dtb
 
+dtb-$(CONFIG_MACH_ASM9260) += alphascale-asm9260-devkit.dtb
+
 targets += dtbs dtbs_install
 targets += $(dtb-y)
 endif
diff --git a/arch/arm/boot/dts/alphascale-asm9260-devkit.dts b/arch/arm/boot/dts/alphascale-asm9260-devkit.dts
new file mode 100644
index 0000000..5d178f2
--- /dev/null
+++ b/arch/arm/boot/dts/alphascale-asm9260-devkit.dts
@@ -0,0 +1,15 @@
+/dts-v1/;
+#include "alphascale-asm9260.dtsi"
+
+/ {
+	model = "Alphascale asm9260 Development Kit";
+	compatible = "alphascale,asm9260devkit", "alphascale,asm9260";
+
+	chosen {
+		bootargs = "mem=32M earlyprintk=serial console=ttyS4,115200n8 root=/dev/mtdblock1 init=/linuxrc mtdparts=NAND:4M at 10M(logo)ro,60M at 14M(root)ro";
+	};
+
+};
+&uart4 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/alphascale-asm9260.dtsi b/arch/arm/boot/dts/alphascale-asm9260.dtsi
new file mode 100644
index 0000000..3ea4e03
--- /dev/null
+++ b/arch/arm/boot/dts/alphascale-asm9260.dtsi
@@ -0,0 +1,166 @@
+/*
+ * Copyright 2014 Oleksij Rempel <linux@rempel-privat.de>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include "skeleton.dtsi"
+#include <dt-bindings/clock/alphascale,asm9260.h>
+
+/ {
+	interrupt-parent = <&icoll>;
+
+        aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		serial5 = &uart5;
+		serial6 = &uart6;
+		serial7 = &uart7;
+		serial8 = &uart8;
+		serial9 = &uart9;
+        };
+
+	cpus {
+		#address-cells = <0>;
+		#size-cells = <0>;
+
+		cpu {
+			compatible = "arm,arm926ej-s";
+			device_type = "cpu";
+			clocks = <&acc CLKID_SYS_CPU>;
+		};
+	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		osc24m: oscillator {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <24000000>;
+			clock-accuracy = <30000>;
+		};
+
+		i2s0_mclk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <24000000>;
+			clock-accuracy = <30000>;
+		};
+
+		i2s1_mclk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <24000000>;
+			clock-accuracy = <30000>;
+		};
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+                ranges;
+
+		acc: clock-controller at 80040000 {
+			compatible = "alphascale,asm9260-clock-controller";
+			#clock-cells = <1>;
+			clocks = <&osc24m>;
+			reg = <0x80040000 0x500>;
+		};
+
+		icoll: interrupt-controller at 80054000 {
+			compatible = "alphascale,asm9260-icall";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			reg = <0x80054000 0x200>;
+		};
+
+		uart0: serial at 80000000 {
+			compatible = "alphascale,asm9260-uart";
+			reg = <0x80000000 0x4000>;
+			clocks = <&acc CLKID_SYS_UART0>, <&acc CLKID_AHB_UART0>;
+			interrupts = <15>;
+			status = "disabled";
+		};
+		uart1: serial at 80004000 {
+			compatible = "alphascale,asm9260-uart";
+			reg = <0x80004000 0x4000>;
+			clocks = <&acc CLKID_SYS_UART1>, <&acc CLKID_AHB_UART1>;
+			interrupts = <16>;
+			status = "disabled";
+		};
+		uart2: serial at 80008000 {
+			compatible = "alphascale,asm9260-uart";
+			reg = <0x80008000 0x4000>;
+			clocks = <&acc CLKID_SYS_UART2>, <&acc CLKID_AHB_UART2>;
+			interrupts = <17>;
+			status = "disabled";
+		};
+		uart3: serial at 8000c000 {
+			compatible = "alphascale,asm9260-uart";
+			reg = <0x8000c000 0x4000>;
+			clocks = <&acc CLKID_SYS_UART3>, <&acc CLKID_AHB_UART3>;
+			interrupts = <18>;
+			status = "disabled";
+		};
+		uart4: serial at 80010000 {
+			compatible = "alphascale,asm9260-uart";
+			reg = <0x80010000 0x4000>;
+			clocks = <&acc CLKID_SYS_UART4>, <&acc CLKID_AHB_UART4>;
+			interrupts = <19>;
+			status = "disabled";
+		};
+		uart5: serial at 80014000 {
+			compatible = "alphascale,asm9260-uart";
+			reg = <0x80014000 0x4000>;
+			clocks = <&acc CLKID_SYS_UART5>, <&acc CLKID_AHB_UART5>;
+			interrupts = <20>;
+			status = "disabled";
+		};
+		uart6: serial at 80018000 {
+			compatible = "alphascale,asm9260-uart";
+			reg = <0x80018000 0x4000>;
+			clocks = <&acc CLKID_SYS_UART6>, <&acc CLKID_AHB_UART6>;
+			interrupts = <21>;
+			status = "disabled";
+		};
+		uart7: serial at 8001c000 {
+			compatible = "alphascale,asm9260-uart";
+			reg = <0x8001c000 0x4000>;
+			clocks = <&acc CLKID_SYS_UART7>, <&acc CLKID_AHB_UART7>;
+			interrupts = <22>;
+			status = "disabled";
+		};
+		uart8: serial at 80020000 {
+			compatible = "alphascale,asm9260-uart";
+			reg = <0x80020000 0x4000>;
+			clocks = <&acc CLKID_SYS_UART8>, <&acc CLKID_AHB_UART8>;
+			interrupts = <23>;
+			status = "disabled";
+		};
+		uart9: serial at 80024000 {
+			compatible = "alphascale,asm9260-uart";
+			reg = <0x80024000 0x4000>;
+			clocks = <&acc CLKID_SYS_UART9>, <&acc CLKID_AHB_UART9>;
+			interrupts = <24>;
+			status = "disabled";
+		};
+
+		timer0: timer at 80088000 {
+			compatible = "alphascale,asm9260-timer";
+			reg = <0x80088000 0x4000>;
+			clocks = <&acc CLKID_AHB_TIMER0>;
+			interrupts = <29>;
+		};
+	};
+};
-- 
1.9.1
