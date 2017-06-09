From: varada@codeaurora.org (Varadarajan Narayanan)
Date: Fri,  9 Jun 2017 15:03:02 +0530
Subject: [PATCH v5 5/6] arm64: dts: Add ipq8074 SoC and HK01 board support
In-Reply-To: <1497000783-27916-1-git-send-email-varada@codeaurora.org>
References: <1497000783-27916-1-git-send-email-varada@codeaurora.org>
Message-ID: <1497000783-27916-6-git-send-email-varada@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial device tree support for the Qualcomm IPQ8074 SoC and
HK01 evaluation board.

Signed-off-by: Manoharan Vijaya Raghavan <mraghava@codeaurora.org>
Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/Makefile         |   1 +
 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts |  53 ++++++++
 arch/arm64/boot/dts/qcom/ipq8074.dtsi     | 194 ++++++++++++++++++++++++++++++
 3 files changed, 248 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq8074.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index cc0f02d..ff81d7e 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -1,5 +1,6 @@
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk01.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-bullhead-rev-101.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8994-angler-rev-101.dtb
diff --git a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
new file mode 100644
index 0000000..7d44be9
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
@@ -0,0 +1,53 @@
+/dts-v1/;
+/* Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include "ipq8074.dtsi"
+
+/ {
+	#address-cells = <0x2>;
+	#size-cells = <0x2>;
+	model = "Qualcomm Technologies, Inc. IPQ8074-HK01";
+	compatible = "qcom,ipq8074-hk01", "qcom,ipq8074";
+	interrupt-parent = <&intc>;
+
+	aliases {
+		serial0 = &blsp1_uart5;
+	};
+
+	chosen {
+		bootargs = "root=/dev/ram0 rw init=/init";
+		stdout-path = "serial0";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x40000000 0x0 0x20000000>;
+	};
+
+	soc {
+		pinctrl at 1000000 {
+			serial_4_pins: serial4_pinmux {
+				mux {
+					pins = "gpio23", "gpio24";
+					function = "blsp4_uart1";
+					bias-disable;
+				};
+			};
+		};
+
+		serial at 78b3000 {
+			pinctrl-0 = <&serial_4_pins>;
+			pinctrl-names = "default";
+			status = "ok";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
new file mode 100644
index 0000000..2bc5dec
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -0,0 +1,194 @@
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/qcom,gcc-ipq8074.h>
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ8074";
+	compatible = "qcom,ipq8074";
+
+	soc: soc {
+		#address-cells = <0x1>;
+		#size-cells = <0x1>;
+		ranges = <0 0 0 0xffffffff>;
+		compatible = "simple-bus";
+
+		pinctrl at 1000000 {
+			compatible = "qcom,ipq8074-pinctrl";
+			reg = <0x1000000 0x300000>;
+			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <0x2>;
+			interrupt-controller;
+			#interrupt-cells = <0x2>;
+		};
+
+		intc: interrupt-controller at b000000 {
+			compatible = "qcom,msm-qgic2";
+			interrupt-controller;
+			#interrupt-cells = <0x3>;
+			reg = <0xb000000 0x1000>, <0xb002000 0x1000>;
+		};
+
+		timer {
+			compatible = "arm,armv8-timer";
+			interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		};
+
+		timer at b120000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			compatible = "arm,armv7-timer-mem";
+			reg = <0xb120000 0x1000>;
+			clock-frequency = <19200000>;
+
+			frame at b120000 {
+				frame-number = <0>;
+				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xb121000 0x1000>,
+				      <0xb122000 0x1000>;
+			};
+
+			frame at b123000 {
+				frame-number = <1>;
+				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xb123000 0x1000>;
+				status = "disabled";
+			};
+
+			frame at b124000 {
+				frame-number = <2>;
+				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xb124000 0x1000>;
+				status = "disabled";
+			};
+
+			frame at b125000 {
+				frame-number = <3>;
+				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xb125000 0x1000>;
+				status = "disabled";
+			};
+
+			frame at b126000 {
+				frame-number = <4>;
+				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xb126000 0x1000>;
+				status = "disabled";
+			};
+
+			frame at b127000 {
+				frame-number = <5>;
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xb127000 0x1000>;
+				status = "disabled";
+			};
+
+			frame at b128000 {
+				frame-number = <6>;
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xb128000 0x1000>;
+				status = "disabled";
+			};
+		};
+
+		gcc: gcc at 1800000 {
+			compatible = "qcom,gcc-ipq8074";
+			reg = <0x1800000 0x80000>;
+			#clock-cells = <0x1>;
+			#reset-cells = <0x1>;
+		};
+
+		blsp1_uart5: serial at 78b3000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x78b3000 0x200>;
+			interrupts = <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART5_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
+	};
+
+	cpus {
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+
+		CPU0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0>;
+			next-level-cache = <&L2_0>;
+			enable-method = "psci";
+		};
+
+		CPU1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			enable-method = "psci";
+			reg = <0x1>;
+			next-level-cache = <&L2_0>;
+		};
+
+		CPU2: cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			enable-method = "psci";
+			reg = <0x2>;
+			next-level-cache = <&L2_0>;
+		};
+
+		CPU3: cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			enable-method = "psci";
+			reg = <0x3>;
+			next-level-cache = <&L2_0>;
+		};
+
+		L2_0: l2-cache {
+			compatible = "cache";
+			cache-level = <0x2>;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_PPI 7 GIC_CPU_MASK_SIMPLE(4)>;
+	};
+
+	clocks {
+		sleep_clk: sleep_clk {
+			compatible = "fixed-clock";
+			clock-frequency = <32000>;
+			#clock-cells = <0>;
+		};
+
+		xo: xo {
+			compatible = "fixed-clock";
+			clock-frequency = <19200000>;
+			#clock-cells = <0>;
+		};
+	};
+};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
