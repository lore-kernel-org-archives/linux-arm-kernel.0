From: sricharan@codeaurora.org (Sricharan R)
Date: Tue, 20 Mar 2018 09:28:54 +0530
Subject: [PATCH v3 11/13] ARM: dts: ipq8074: Add peripheral nodes
In-Reply-To: <1521518336-5467-1-git-send-email-sricharan@codeaurora.org>
References: <1521518336-5467-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1521518336-5467-12-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add serial, i2c, bam, spi, qpic peripheral nodes.

Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 105 ++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 2bc5dec..a8dbbf0 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -124,6 +124,111 @@
 			clock-names = "core", "iface";
 			status = "disabled";
 		};
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
+		serial_blsp0: serial at 78af000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x78af000 0x200>;
+			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART1_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
+
+		serial_blsp2: serial at 78b1000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x78b1000 0x200>;
+			interrupts = <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART3_APPS_CLK>,
+				<&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp_dma 4>,
+				<&blsp_dma 5>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		spi_0: spi at 78b5000 {
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
+			status = "disabled";
+		};
+
+		i2c_0: i2c at 78b6000 {
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
+			status = "disabled";
+		};
+
+		i2c_1: i2c at 78b7000 {
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
+			status = "disabled";
+		};
 	};
 
 	cpus {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
