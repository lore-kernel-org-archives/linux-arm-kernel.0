From: mmcclint@qca.qualcomm.com (Matthew McClintock)
Date: Mon, 16 Nov 2015 15:02:04 -0600
Subject: [PATCH v2 4/5] qcom: ipq4019: Add basic board/dts support for IPQ4019
 SoC
In-Reply-To: <1447707725-19449-1-git-send-email-mmcclint@qca.qualcomm.com>
References: <1446758697-31198-1-git-send-email-mmcclint@codeaurora.org>
 <1447707725-19449-1-git-send-email-mmcclint@qca.qualcomm.com>
Message-ID: <1447707725-19449-4-git-send-email-mmcclint@qca.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthew McClintock <mmcclint@codeaurora.org>

Add initial dts files and SoC support for IPQ4019

Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---

v2 - add sleep_clk

 arch/arm/boot/dts/qcom-ipq4019.dtsi | 115 ++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019.dtsi

diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
new file mode 100644
index 0000000..fc73822
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -0,0 +1,115 @@
+/*
+ * Copyright (c) 2015, The Linux Foundation. All rights reserved.
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
+#include "skeleton.dtsi"
+#include <dt-bindings/clock/qcom,gcc-ipq4019.h>
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ4019";
+	compatible = "qcom,ipq4019";
+	interrupt-parent = <&intc>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x0>;
+			clocks = <&gcc GCC_APPS_CLK_SRC>;
+		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x1>;
+			clocks = <&gcc GCC_APPS_CLK_SRC>;
+		};
+
+		cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x2>;
+			clocks = <&gcc GCC_APPS_CLK_SRC>;
+		};
+
+		cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x3>;
+			clocks = <&gcc GCC_APPS_CLK_SRC>;
+		};
+	};
+
+	clocks {
+		sleep_clk: sleep_clk {
+			compatible = "fixed-clock";
+			clock-frequency = <32768>;
+			#clock-cells = <0>;
+		};
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		compatible = "simple-bus";
+
+		intc: interrupt-controller at b000000 {
+			compatible = "qcom,msm-qgic2";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			reg = <0x0b000000 0x1000>,
+			<0x0b002000 0x1000>;
+		};
+
+		gcc: clock-controller at 1800000 {
+			compatible = "qcom,gcc-ipq4019";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			reg = <0x1800000 0x60000>;
+		};
+
+		tlmm: pinctrl at 0x01000000 {
+			compatible = "qcom,ipq4019-pinctrl";
+			reg = <0x01000000 0x300000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupts = <0 208 0>;
+		};
+
+		serial at 78af000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x78af000 0x200>;
+			interrupts = <0 107 0>;
+			status = "disabled";
+			clocks = <&gcc GCC_BLSP1_UART1_APPS_CLK>,
+				<&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+		};
+
+		serial at 78b0000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x78b0000 0x200>;
+			interrupts = <0 108 0>;
+			status = "disabled";
+			clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>,
+				<&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+		};
+	};
+};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
