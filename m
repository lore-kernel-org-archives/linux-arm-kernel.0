From: sricharan@codeaurora.org (Sricharan R)
Date: Wed, 16 May 2018 18:20:02 +0530
Subject: [PATCH V6 10/12] ARM: dts: ipq8074: Add peripheral nodes
In-Reply-To: <1526475004-10341-1-git-send-email-sricharan@codeaurora.org>
References: <1526475004-10341-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1526475004-10341-11-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add serial, i2c, bam, spi, qpic peripheral nodes.

While here, fix the PMU node's irq trigger to avoid
the boot warnings from GIC.

Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 156 +++++++++++++++++++++++++++++++++-
 1 file changed, 155 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 2bc5dec..bd58ab4 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -32,6 +32,45 @@
 			#gpio-cells = <0x2>;
 			interrupt-controller;
 			#interrupt-cells = <0x2>;
+
+			serial_4_pins: serial4-pinmux {
+				pins = "gpio23", "gpio24";
+				function = "blsp4_uart1";
+				drive-strength = <8>;
+				bias-disable;
+			};
+
+			i2c_0_pins: i2c-0-pinmux {
+				pins = "gpio42", "gpio43";
+				function = "blsp1_i2c";
+				drive-strength = <8>;
+				bias-disable;
+			};
+
+			spi_0_pins: spi-0-pins {
+				pins = "gpio38", "gpio39", "gpio40", "gpio41";
+				function = "blsp0_spi";
+				drive-strength = <8>;
+				bias-disable;
+			};
+
+			hsuart_pins: hsuart-pins {
+				pins = "gpio46", "gpio47", "gpio48", "gpio49";
+				function = "blsp2_uart";
+				drive-strength = <8>;
+				bias-disable;
+			};
+
+			qpic_pins: qpic-pins {
+				pins = "gpio1", "gpio3", "gpio4",
+				       "gpio5", "gpio6", "gpio7",
+				       "gpio8", "gpio10", "gpio11",
+				       "gpio12", "gpio13", "gpio14",
+				       "gpio15", "gpio16", "gpio17";
+				function = "qpic";
+				drive-strength = <8>;
+				bias-disable;
+			};
 		};
 
 		intc: interrupt-controller at b000000 {
@@ -122,6 +161,121 @@
 			clocks = <&gcc GCC_BLSP1_UART5_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
+			pinctrl-0 = <&serial_4_pins>;
+			pinctrl-names = "default";
+			status = "disabled";
+		};
+
+		blsp_dma: dma at 7884000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0x7884000 0x2b000>;
+			interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "bam_clk";
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+		};
+
+		blsp1_uart1: serial at 78af000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x78af000 0x200>;
+			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART1_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
+
+		blsp1_uart3: serial at 78b1000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x78b1000 0x200>;
+			interrupts = <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART3_APPS_CLK>,
+				<&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp_dma 4>,
+				<&blsp_dma 5>;
+			dma-names = "tx", "rx";
+			pinctrl-0 = <&hsuart_pins>;
+			pinctrl-names = "default";
+			status = "disabled";
+		};
+
+		blsp1_spi1: spi at 78b5000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x78b5000 0x600>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+			spi-max-frequency = <50000000>;
+			clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>,
+				<&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp_dma 12>, <&blsp_dma 13>;
+			dma-names = "tx", "rx";
+			pinctrl-0 = <&spi_0_pins>;
+			pinctrl-names = "default";
+			status = "disabled";
+		};
+
+		blsp1_i2c2: i2c at 78b6000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x78b6000 0x600>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
+				<&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>;
+			clock-names = "iface", "core";
+			clock-frequency = <400000>;
+			dmas = <&blsp_dma 15>, <&blsp_dma 14>;
+			dma-names = "rx", "tx";
+			pinctrl-0 = <&i2c_0_pins>;
+			pinctrl-names = "default";
+			status = "disabled";
+		};
+
+		blsp1_i2c3: i2c at 78b7000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x78b7000 0x600>;
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
+				<&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>;
+			clock-names = "iface", "core";
+			clock-frequency = <100000>;
+			dmas = <&blsp_dma 17>, <&blsp_dma 16>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		qpic_bam: dma at 7984000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0x7984000 0x1a000>;
+			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_QPIC_AHB_CLK>;
+			clock-names = "bam_clk";
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			status = "disabled";
+		};
+
+		qpic_nand: nand at 79b0000 {
+			compatible = "qcom,ipq8074-nand";
+			reg = <0x79b0000 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&gcc GCC_QPIC_CLK>,
+				 <&gcc GCC_QPIC_AHB_CLK>;
+			clock-names = "core", "aon";
+
+			dmas = <&qpic_bam 0>,
+			       <&qpic_bam 1>,
+			       <&qpic_bam 2>;
+			dma-names = "tx", "rx", "cmd";
+			pinctrl-0 = <&qpic_pins>;
+			pinctrl-names = "default";
 			status = "disabled";
 		};
 	};
@@ -175,7 +329,7 @@
 
 	pmu {
 		compatible = "arm,armv8-pmuv3";
-		interrupts = <GIC_PPI 7 GIC_CPU_MASK_SIMPLE(4)>;
+		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
 	clocks {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
