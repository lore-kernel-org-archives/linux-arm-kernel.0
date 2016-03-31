From: xuejiancheng@hisilicon.com (Jiancheng Xue)
Date: Thu, 31 Mar 2016 16:10:11 +0800
Subject: [RESEND PATCH v10 6/6] ARM: dts: add dts files for Hi3519
In-Reply-To: <1459411811-12390-1-git-send-email-xuejiancheng@hisilicon.com>
References: <1459411811-12390-1-git-send-email-xuejiancheng@hisilicon.com>
Message-ID: <1459411811-12390-7-git-send-email-xuejiancheng@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiancheng Xue <xuejiancheng@huawei.com>

add dts files for Hi3519

Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
---
 arch/arm/boot/dts/Makefile        |   2 +
 arch/arm/boot/dts/hi3519-demb.dts |  42 +++++++++
 arch/arm/boot/dts/hi3519.dtsi     | 187 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 231 insertions(+)
 create mode 100644 arch/arm/boot/dts/hi3519-demb.dts
 create mode 100644 arch/arm/boot/dts/hi3519.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a4a6d70..3ce36ff 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -141,6 +141,8 @@ dtb-$(CONFIG_ARCH_EXYNOS5) += \
 	exynos5800-peach-pi.dtb
 dtb-$(CONFIG_ARCH_HI3xxx) += \
 	hi3620-hi4511.dtb
+dtb-$(CONFIG_ARCH_HISI) += \
+	hi3519-demb.dtb
 dtb-$(CONFIG_ARCH_HIX5HD2) += \
 	hisi-x5hd2-dkb.dtb
 dtb-$(CONFIG_ARCH_HIGHBANK) += \
diff --git a/arch/arm/boot/dts/hi3519-demb.dts b/arch/arm/boot/dts/hi3519-demb.dts
new file mode 100644
index 0000000..6991ab6
--- /dev/null
+++ b/arch/arm/boot/dts/hi3519-demb.dts
@@ -0,0 +1,42 @@
+/*
+ * Copyright (c) 2015 HiSilicon Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+/dts-v1/;
+#include "hi3519.dtsi"
+
+/ {
+	model = "HiSilicon HI3519 DEMO Board";
+	compatible = "hisilicon,hi3519";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&dual_timer0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/hi3519.dtsi b/arch/arm/boot/dts/hi3519.dtsi
new file mode 100644
index 0000000..5729ecf
--- /dev/null
+++ b/arch/arm/boot/dts/hi3519.dtsi
@@ -0,0 +1,187 @@
+/*
+ * Copyright (c) 2015 HiSilicon Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <dt-bindings/clock/hi3519-clock.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	chosen { };
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0>;
+		};
+	};
+
+	gic: interrupt-controller at 10300000 {
+		compatible = "arm,cortex-a7-gic";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0x10301000 0x1000>, <0x10302000 0x1000>;
+	};
+
+	clk_3m: clk_3m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <3000000>;
+	};
+
+	crg: clock-reset-controller at 12010000 {
+		compatible = "hisilicon,hi3519-crg";
+		#clock-cells = <1>;
+		#reset-cells = <2>;
+		reg = <0x12010000 0x10000>;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&gic>;
+		ranges;
+
+		uart0: serial at 12100000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x12100000 0x1000>;
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg HI3519_UART0_CLK>;
+			clock-names = "apb_pclk";
+			status = "disable";
+		};
+
+		uart1: serial at 12101000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x12101000 0x1000>;
+			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg HI3519_UART1_CLK>;
+			clock-names = "apb_pclk";
+			status = "disable";
+		};
+
+		uart2: serial at 12102000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x12102000 0x1000>;
+			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg HI3519_UART2_CLK>;
+			clock-names = "apb_pclk";
+			status = "disable";
+		};
+
+		uart3: serial at 12103000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x12103000 0x1000>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg HI3519_UART3_CLK>;
+			clock-names = "apb_pclk";
+			status = "disable";
+		};
+
+		uart4: serial at 12104000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x12104000 0x1000>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg HI3519_UART4_CLK>;
+			clock-names = "apb_pclk";
+			status = "disable";
+		};
+
+		dual_timer0: timer at 12000000 {
+			compatible = "arm,sp804", "arm,primecell";
+			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x12000000 0x1000>;
+			clocks = <&clk_3m>;
+			clock-names = "apb_pclk";
+			status = "disable";
+		};
+
+		dual_timer1: timer at 12001000 {
+			compatible = "arm,sp804", "arm,primecell";
+			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x12001000 0x1000>;
+			clocks = <&clk_3m>;
+			clock-names = "apb_pclk";
+			status = "disable";
+		};
+
+		dual_timer2: timer at 12002000 {
+			compatible = "arm,sp804", "arm,primecell";
+			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x12002000 0x1000>;
+			clocks = <&clk_3m>;
+			clock-names = "apb_pclk";
+			status = "disable";
+		};
+
+		spi_bus0: spi at 12120000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x12120000 0x1000>;
+			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg HI3519_SPI0_CLK>;
+			clock-names = "apb_pclk";
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disable";
+		};
+
+		spi_bus1: spi at 12121000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x12121000 0x1000>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg HI3519_SPI1_CLK>;
+			clock-names = "apb_pclk";
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disable";
+		};
+
+		spi_bus2: spi at 12122000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x12122000 0x1000>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg HI3519_SPI2_CLK>;
+			clock-names = "apb_pclk";
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disable";
+		};
+
+		sysctrl: system-controller at 12020000 {
+			compatible = "hisilicon,hi3519-sysctrl", "syscon";
+			reg = <0x12020000 0x1000>;
+		};
+
+		reboot {
+			compatible = "syscon-reboot";
+			regmap = <&sysctrl>;
+			offset = <0x4>;
+			mask = <0xdeadbeef>;
+		};
+	};
+};
-- 
1.9.1
