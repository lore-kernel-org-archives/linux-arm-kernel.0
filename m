From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 17 Nov 2015 17:12:27 -0800
Subject: [PATCH 2/4] arm64: dts: Add msm8996 SoC and MTP board support
In-Reply-To: <1447809149-29724-1-git-send-email-sboyd@codeaurora.org>
References: <1447809149-29724-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1447809149-29724-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial device tree support for the Qualcomm MSM8996 SoC and
MTP8996 evaluation board.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/Makefile         |   1 +
 arch/arm64/boot/dts/qcom/msm8996-mtp.dts  |  21 +++
 arch/arm64/boot/dts/qcom/msm8996-mtp.dtsi |  30 ++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi     | 267 ++++++++++++++++++++++++++++++
 4 files changed, 319 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996-mtp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996-mtp.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 8e94af64ee94..fa1f661ccccf 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -1,4 +1,5 @@
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb msm8916-mtp.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-mtp.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/qcom/msm8996-mtp.dts b/arch/arm64/boot/dts/qcom/msm8996-mtp.dts
new file mode 100644
index 000000000000..619af44a595d
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8996-mtp.dts
@@ -0,0 +1,21 @@
+/*
+ * Copyright (c) 2014-2015, The Linux Foundation. All rights reserved.
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
+/dts-v1/;
+
+#include "msm8996-mtp.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. MSM 8996 MTP";
+	compatible = "qcom,msm8996-mtp";
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8996-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8996-mtp.dtsi
new file mode 100644
index 000000000000..9bab5c011c07
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8996-mtp.dtsi
@@ -0,0 +1,30 @@
+/*
+ * Copyright (c) 2014-2015, The Linux Foundation. All rights reserved.
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
+#include "msm8996.dtsi"
+
+/ {
+	aliases {
+		serial0 = &blsp2_uart1;
+	};
+
+	chosen {
+		stdout-path = "serial0";
+	};
+
+	soc {
+		serial at 75b0000 {
+			status = "okay";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
new file mode 100644
index 000000000000..cf5d361283de
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -0,0 +1,267 @@
+/* Copyright (c) 2014-2015, The Linux Foundation. All rights reserved.
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
+#include <dt-bindings/clock/qcom,gcc-msm8996.h>
+#include <dt-bindings/clock/qcom,mmcc-msm8996.h>
+
+/ {
+	model = "Qualcomm Technologies, Inc. MSM8996";
+
+	interrupt-parent = <&intc>;
+
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	chosen { };
+
+	memory {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the reg */
+		reg = <0 0 0 0>;
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		CPU0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "qcom,kryo";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+			next-level-cache = <&L2_0>;
+			L2_0: l2-cache {
+			      compatible = "cache";
+			      cache-level = <2>;
+			};
+		};
+
+		CPU1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "qcom,kryo";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+			next-level-cache = <&L2_0>;
+		};
+
+		CPU2: cpu at 100 {
+			device_type = "cpu";
+			compatible = "qcom,kryo";
+			reg = <0x0 0x100>;
+			enable-method = "psci";
+			next-level-cache = <&L2_1>;
+			L2_1: l2-cache {
+			      compatible = "cache";
+			      cache-level = <2>;
+			};
+		};
+
+		CPU3: cpu at 101 {
+			device_type = "cpu";
+			compatible = "qcom,kryo";
+			reg = <0x0 0x101>;
+			enable-method = "psci";
+			next-level-cache = <&L2_1>;
+		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&CPU0>;
+				};
+
+				core1 {
+					cpu = <&CPU1>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&CPU2>;
+				};
+
+				core1 {
+					cpu = <&CPU3>;
+				};
+			};
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	clocks {
+		xo_board {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <19200000>;
+			clock-output-names = "xo_board";
+		};
+
+		sleep_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32764>;
+			clock-output-names = "sleep_clk";
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	soc: soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0 0xffffffff>;
+		compatible = "simple-bus";
+
+		intc: interrupt-controller at 9bc0000 {
+			compatible = "arm,gic-v3";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			#redistributor-regions = <1>;
+			redistributor-stride = <0x0 0x40000>;
+			reg = <0x09bc0000 0x10000>,
+			      <0x09c00000 0x100000>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		gcc: clock-controller at 300000 {
+			compatible = "qcom,gcc-msm8996";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			reg = <0x300000 0x90000>;
+		};
+
+		blsp2_uart1: serial at 75b0000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x75b0000 0x1000>;
+			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_UART2_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
+
+		pinctrl at 1010000 {
+			compatible = "qcom,msm8996-pinctrl";
+			reg = <0x01010000 0x300000>;
+			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		timer at 09840000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			compatible = "arm,armv7-timer-mem";
+			reg = <0x09840000 0x1000>;
+			clock-frequency = <19200000>;
+
+			frame at 9850000 {
+				frame-number = <0>;
+				interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x09850000 0x1000>,
+				      <0x09860000 0x1000>;
+			};
+
+			frame at 9870000 {
+				frame-number = <1>;
+				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x09870000 0x1000>;
+				status = "disabled";
+			};
+
+			frame at 9880000 {
+				frame-number = <2>;
+				interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x09880000 0x1000>;
+				status = "disabled";
+			};
+
+			frame at 9890000 {
+				frame-number = <3>;
+				interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x09890000 0x1000>;
+				status = "disabled";
+			};
+
+			frame at 98a0000 {
+				frame-number = <4>;
+				interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x098a0000 0x1000>;
+				status = "disabled";
+			};
+
+			frame at 98b0000 {
+				frame-number = <5>;
+				interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x098b0000 0x1000>;
+				status = "disabled";
+			};
+
+			frame at 98c0000 {
+				frame-number = <6>;
+				interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x098c0000 0x1000>;
+				status = "disabled";
+			};
+		};
+
+		spmi_bus: qcom,spmi at 400f000 {
+			compatible = "qcom,spmi-pmic-arb";
+			reg = <0x400f000 0x1000>,
+			      <0x4400000 0x800000>,
+			      <0x4c00000 0x800000>,
+			      <0x5800000 0x200000>,
+			      <0x400a000 0x002100>;
+			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
+			interrupt-names = "periph_irq";
+			interrupts = <GIC_SPI 326 IRQ_TYPE_NONE>;
+			qcom,ee = <0>;
+			qcom,channel = <0>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+			interrupt-controller;
+			#interrupt-cells = <4>;
+		};
+
+		mmcc: clock-controller at 8c0000 {
+			compatible = "qcom,mmcc-msm8996";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			reg = <0x8c0000 0xc0000>;
+			assigned-clocks = <&mmcc MMPLL9_PLL>,
+					  <&mmcc MMPLL1_PLL>,
+					  <&mmcc MMPLL3_PLL>,
+					  <&mmcc MMPLL4_PLL>,
+					  <&mmcc MMPLL5_PLL>;
+			assigned-clock-rates = <624000000>,
+					       <810000000>,
+					       <980000000>,
+					       <960000000>,
+					       <825000000>;
+		};
+	};
+};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
