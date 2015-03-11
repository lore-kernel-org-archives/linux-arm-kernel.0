From: galak@codeaurora.org (Kumar Gala)
Date: Wed, 11 Mar 2015 15:51:18 -0500
Subject: [PATCH v3 2/4] arm64: dts: Add Qualcomm MSM8916 SoC and evaluation
 board dts
In-Reply-To: <1426107080-29079-1-git-send-email-galak@codeaurora.org>
References: <1426107080-29079-1-git-send-email-galak@codeaurora.org>
Message-ID: <1426107080-29079-2-git-send-email-galak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial device tree support for Qualcomm MSM8916 SoC and MTP8916
evaluation board.  At the current time we only boot up a single processor.

Signed-off-by: Kumar Gala <galak@codeaurora.org>
---
v3:
* Removed qcom,msm-id and qcom,board-id
* Added top level compat for "qcom,msm8916-mtp-smb1360"

v2:
* Updated to dropping CONFIG_ARCH_QCOM_MSM8916
* Updated to use qcom-ids.h
 arch/arm64/boot/dts/Makefile              |   1 +
 arch/arm64/boot/dts/qcom/Makefile         |   5 +
 arch/arm64/boot/dts/qcom/msm8916-mtp.dts  |  21 ++++
 arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi |  24 ++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi     | 184 ++++++++++++++++++++++++++++++
 5 files changed, 235 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/Makefile
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-mtp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916.dtsi

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index e0350ca..8517f15 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -5,5 +5,6 @@ dts-dirs += cavium
 dts-dirs += exynos
 dts-dirs += freescale
 dts-dirs += mediatek
+dts-dirs += qcom
 
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
new file mode 100644
index 0000000..360ec4c
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -0,0 +1,5 @@
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-mtp.dtb
+
+always		:= $(dtb-y)
+subdir-y	:= $(dts-dirs)
+clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8916-mtp.dts b/arch/arm64/boot/dts/qcom/msm8916-mtp.dts
new file mode 100644
index 0000000..784ad92
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-mtp.dts
@@ -0,0 +1,21 @@
+/* Copyright (c) 2014-2015, The Linux Foundation. All rights reserved.
+*
+* This program is free software; you can redistribute it and/or modify
+* it under the terms of the GNU General Public License version 2 and
+* only version 2 as published by the Free Software Foundation.
+*
+* This program is distributed in the hope that it will be useful,
+* but WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+* GNU General Public License for more details.
+*/
+
+/dts-v1/;
+
+#include "msm8916-mtp.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. MSM 8916 MTP";
+	compatible = "qcom,msm8916-mtp", "qcom,msm8916-mtp-smb1360",
+			"qcom,msm8916", "qcom,mtp";
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi
new file mode 100644
index 0000000..4d2f073
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi
@@ -0,0 +1,24 @@
+/* Copyright (c) 2014-2014, The Linux Foundation. All rights reserved.
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
+#include "msm8916.dtsi"
+
+/ {
+	soc {
+		serial at 78b0000 {
+			status = "okay";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp1_uart2_default>;
+			pinctrl-1 = <&blsp1_uart2_sleep>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
new file mode 100644
index 0000000..957486f
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -0,0 +1,184 @@
+/* Copyright (c) 2013-2015, The Linux Foundation. All rights reserved.
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
+#include "skeleton.dtsi"
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/qcom,gcc-msm8916.h>
+#include <dt-bindings/reset/qcom,gcc-msm8916.h>
+
+/ {
+	model = "Qualcomm Technologies, Inc. MSM8916";
+	compatible = "qcom,msm8916";
+
+	interrupt-parent = <&intc>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		CPU0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0>;
+		};
+
+		CPU1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x1>;
+		};
+
+		CPU2: cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x2>;
+		};
+
+		CPU3: cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x3>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		clock-frequency = <19200000>;
+	};
+
+	soc: soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0 0xffffffff>;
+		compatible = "simple-bus";
+
+		pinctrl at 1000000 {
+			compatible = "qcom,msm8916-pinctrl";
+			reg = <0x1000000 0x300000>;
+			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			blsp1_uart2_default: blsp1_uart2_default {
+				pinmux {
+					function = "blsp_uart2";
+					pins = "gpio4", "gpio5";
+				};
+				pinconf {
+					pins = "gpio4", "gpio5";
+					drive-strength = <16>;
+					bias-disable;
+				};
+			};
+
+			blsp1_uart2_sleep: blsp1_uart2_sleep {
+				pinmux {
+					function = "blsp_uart2";
+					pins = "gpio4", "gpio5";
+				};
+				pinconf {
+					pins = "gpio4", "gpio5";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+			};
+		};
+
+		gcc: qcom,gcc at 1800000 {
+			compatible = "qcom,gcc-msm8916";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			reg = <0x1800000 0x80000>;
+		};
+
+		blsp1_uart2: serial at 78b0000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x78b0000 0x200>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
+
+		intc: interrupt-controller at b000000 {
+			compatible = "qcom,msm-qgic2";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			reg = <0x0b000000 0x1000>, <0x0b002000 0x1000>;
+		};
+
+		timer at b020000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			compatible = "arm,armv7-timer-mem";
+			reg = <0xb020000 0x1000>;
+			clock-frequency = <19200000>;
+
+			frame at b021000 {
+				frame-number = <0>;
+				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xb021000 0x1000>,
+				      <0xb022000 0x1000>;
+			};
+
+			frame at b023000 {
+				frame-number = <1>;
+				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xb023000 0x1000>;
+				status = "disabled";
+			};
+
+			frame at b024000 {
+				frame-number = <2>;
+				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xb024000 0x1000>;
+				status = "disabled";
+			};
+
+			frame at b025000 {
+				frame-number = <3>;
+				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xb025000 0x1000>;
+				status = "disabled";
+			};
+
+			frame at b026000 {
+				frame-number = <4>;
+				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xb026000 0x1000>;
+				status = "disabled";
+			};
+
+			frame at b027000 {
+				frame-number = <5>;
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xb027000 0x1000>;
+				status = "disabled";
+			};
+
+			frame at b028000 {
+				frame-number = <6>;
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xb028000 0x1000>;
+				status = "disabled";
+			};
+		};
+	};
+};
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
