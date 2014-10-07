From: linux@rempel-privat.de (Oleksij Rempel)
Date: Tue,  7 Oct 2014 10:55:17 +0200
Subject: [PATCH v3 3/9] ARM: dts: add DT for Alphascale ASM9260 SoC
In-Reply-To: <1412672123-16694-1-git-send-email-linux@rempel-privat.de>
References: <1411324904-14881-1-git-send-email-linux@rempel-privat.de>
 <1412672123-16694-1-git-send-email-linux@rempel-privat.de>
Message-ID: <1412672123-16694-4-git-send-email-linux@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

for now it is wary basic SoC description with most important IPs needed
to make this device work

Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
---
 arch/arm/boot/dts/Makefile                      |   2 +
 arch/arm/boot/dts/alphascale-asm9260-devkit.dts |  21 ++++
 arch/arm/boot/dts/alphascale-asm9260.dtsi       | 134 ++++++++++++++++++++++++
 include/dt-bindings/clock/alphascale,asm9260.h  |  97 +++++++++++++++++
 4 files changed, 254 insertions(+)
 create mode 100644 arch/arm/boot/dts/alphascale-asm9260-devkit.dts
 create mode 100644 arch/arm/boot/dts/alphascale-asm9260.dtsi
 create mode 100644 include/dt-bindings/clock/alphascale,asm9260.h

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
index 0000000..bf63dd2
--- /dev/null
+++ b/arch/arm/boot/dts/alphascale-asm9260-devkit.dts
@@ -0,0 +1,21 @@
+/*
+ * Copyright 2014 Oleksij Rempel <linux@rempel-privat.de>
+ *
+ * Licensed under the X11 license or the GPL v2 (or later)
+ */
+
+/dts-v1/;
+#include "alphascale-asm9260.dtsi"
+
+/ {
+	model = "Alphascale asm9260 Development Kit";
+	compatible = "alphascale,asm9260devkit", "alphascale,asm9260";
+
+	aliases {
+		serial0 = &uart4;
+	};
+};
+
+&uart4 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/alphascale-asm9260.dtsi b/arch/arm/boot/dts/alphascale-asm9260.dtsi
new file mode 100644
index 0000000..d147612
--- /dev/null
+++ b/arch/arm/boot/dts/alphascale-asm9260.dtsi
@@ -0,0 +1,134 @@
+/*
+ * Copyright 2014 Oleksij Rempel <linux@rempel-privat.de>
+ *
+ * Licensed under the X11 license or the GPL v2 (or later)
+ */
+
+#include "skeleton.dtsi"
+#include <dt-bindings/clock/alphascale,asm9260.h>
+
+/ {
+	interrupt-parent = <&icoll>;
+
+	memory {
+		device_type = "memory";
+		reg = <0x20000000 0x2000000>;
+	};
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
+	osc24m: oscillator {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-accuracy = <30000>;
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
+			reg = <0x80040000 0x204>;
+		};
+
+		icoll: interrupt-controller at 80054000 {
+			compatible = "alphascale,asm9260-icoll";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			reg = <0x80054000 0x200>;
+		};
+
+		uart0: serial at 80000000 {
+			compatible = "alphascale,asm9260-auart";
+			reg = <0x80000000 0x4000>;
+			clocks = <&acc CLKID_SYS_UART0>, <&acc CLKID_AHB_UART0>;
+			interrupts = <15>;
+			status = "disabled";
+		};
+		uart1: serial at 80004000 {
+			compatible = "alphascale,asm9260-auart";
+			reg = <0x80004000 0x4000>;
+			clocks = <&acc CLKID_SYS_UART1>, <&acc CLKID_AHB_UART1>;
+			interrupts = <16>;
+			status = "disabled";
+		};
+		uart2: serial at 80008000 {
+			compatible = "alphascale,asm9260-auart";
+			reg = <0x80008000 0x4000>;
+			clocks = <&acc CLKID_SYS_UART2>, <&acc CLKID_AHB_UART2>;
+			interrupts = <17>;
+			status = "disabled";
+		};
+		uart3: serial at 8000c000 {
+			compatible = "alphascale,asm9260-auart";
+			reg = <0x8000c000 0x4000>;
+			clocks = <&acc CLKID_SYS_UART3>, <&acc CLKID_AHB_UART3>;
+			interrupts = <18>;
+			status = "disabled";
+		};
+		uart4: serial at 80010000 {
+			compatible = "alphascale,asm9260-auart";
+			reg = <0x80010000 0x4000>;
+			clocks = <&acc CLKID_SYS_UART4>, <&acc CLKID_AHB_UART4>;
+			interrupts = <19>;
+			status = "disabled";
+		};
+		uart5: serial at 80014000 {
+			compatible = "alphascale,asm9260-auart";
+			reg = <0x80014000 0x4000>;
+			clocks = <&acc CLKID_SYS_UART5>, <&acc CLKID_AHB_UART5>;
+			interrupts = <20>;
+			status = "disabled";
+		};
+		uart6: serial at 80018000 {
+			compatible = "alphascale,asm9260-auart";
+			reg = <0x80018000 0x4000>;
+			clocks = <&acc CLKID_SYS_UART6>, <&acc CLKID_AHB_UART6>;
+			interrupts = <21>;
+			status = "disabled";
+		};
+		uart7: serial at 8001c000 {
+			compatible = "alphascale,asm9260-auart";
+			reg = <0x8001c000 0x4000>;
+			clocks = <&acc CLKID_SYS_UART7>, <&acc CLKID_AHB_UART7>;
+			interrupts = <22>;
+			status = "disabled";
+		};
+		uart8: serial at 80020000 {
+			compatible = "alphascale,asm9260-auart";
+			reg = <0x80020000 0x4000>;
+			clocks = <&acc CLKID_SYS_UART8>, <&acc CLKID_AHB_UART8>;
+			interrupts = <23>;
+			status = "disabled";
+		};
+		uart9: serial at 80024000 {
+			compatible = "alphascale,asm9260-auart";
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
diff --git a/include/dt-bindings/clock/alphascale,asm9260.h b/include/dt-bindings/clock/alphascale,asm9260.h
new file mode 100644
index 0000000..04e8db2
--- /dev/null
+++ b/include/dt-bindings/clock/alphascale,asm9260.h
@@ -0,0 +1,97 @@
+/*
+ * Copyright 2014 Oleksij Rempel <linux@rempel-privat.de>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _DT_BINDINGS_CLK_ASM9260_H
+#define _DT_BINDINGS_CLK_ASM9260_H
+
+/* ahb gate */
+#define CLKID_AHB_ROM		0
+#define CLKID_AHB_RAM		1
+#define CLKID_AHB_GPIO		2
+#define CLKID_AHB_MAC		3
+#define CLKID_AHB_EMI		4
+#define CLKID_AHB_USB0		5
+#define CLKID_AHB_USB1		6
+#define CLKID_AHB_DMA0		7
+#define CLKID_AHB_DMA1		8
+#define CLKID_AHB_UART0		9
+#define CLKID_AHB_UART1		10
+#define CLKID_AHB_UART2		11
+#define CLKID_AHB_UART3		12
+#define CLKID_AHB_UART4		13
+#define CLKID_AHB_UART5		14
+#define CLKID_AHB_UART6		15
+#define CLKID_AHB_UART7		16
+#define CLKID_AHB_UART8		17
+#define CLKID_AHB_UART9		18
+#define CLKID_AHB_I2S0		19
+#define CLKID_AHB_I2C0		20
+#define CLKID_AHB_I2C1		21
+#define CLKID_AHB_SSP0		22
+#define CLKID_AHB_IOCONFIG	23
+#define CLKID_AHB_WDT		24
+#define CLKID_AHB_CAN0		25
+#define CLKID_AHB_CAN1		26
+#define CLKID_AHB_MPWM		27
+#define CLKID_AHB_SPI0		28
+#define CLKID_AHB_SPI1		29
+#define CLKID_AHB_QEI		30
+#define CLKID_AHB_QUADSPI0	31
+#define CLKID_AHB_CAMIF		32
+#define CLKID_AHB_LCDIF		33
+#define CLKID_AHB_TIMER0	34
+#define CLKID_AHB_TIMER1	35
+#define CLKID_AHB_TIMER2	36
+#define CLKID_AHB_TIMER3	37
+#define CLKID_AHB_IRQ		38
+#define CLKID_AHB_RTC		39
+#define CLKID_AHB_NAND		40
+#define CLKID_AHB_ADC0		41
+#define CLKID_AHB_LED		42
+#define CLKID_AHB_DAC0		43
+#define CLKID_AHB_LCD		44
+#define CLKID_AHB_I2S1		45
+#define CLKID_AHB_MAC1		46
+
+/* devider */
+#define CLKID_SYS_CPU		47
+#define CLKID_SYS_AHB		48
+#define CLKID_SYS_I2S0M		49
+#define CLKID_SYS_I2S0S		50
+#define CLKID_SYS_I2S1M		51
+#define CLKID_SYS_I2S1S		52
+#define CLKID_SYS_UART0		53
+#define CLKID_SYS_UART1		54
+#define CLKID_SYS_UART2		55
+#define CLKID_SYS_UART3		56
+#define CLKID_SYS_UART4		56
+#define CLKID_SYS_UART5		57
+#define CLKID_SYS_UART6		58
+#define CLKID_SYS_UART7		59
+#define CLKID_SYS_UART8		60
+#define CLKID_SYS_UART9		61
+#define CLKID_SYS_SPI0		62
+#define CLKID_SYS_SPI1		63
+#define CLKID_SYS_QUADSPI	64
+#define CLKID_SYS_SSP0		65
+#define CLKID_SYS_NAND		66
+#define CLKID_SYS_TRACE		67
+#define CLKID_SYS_CAMM		68
+#define CLKID_SYS_WDT		69
+#define CLKID_SYS_CLKOUT	70
+#define CLKID_SYS_MAC		71
+#define CLKID_SYS_LCD		72
+#define CLKID_SYS_ADCANA	73
+
+#define MAX_CLKS		74
+#endif
-- 
1.9.1
