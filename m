From: mmcclint@codeaurora.org (Matthew McClintock)
Date: Wed, 23 Mar 2016 17:05:12 -0500
Subject: [PATCH 17/17] qcom: ipq4019: add DMA nodes to ipq4019 SoC and DK01
 device tree
In-Reply-To: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org>
References: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org>
Message-ID: <1458770712-10880-18-git-send-email-mmcclint@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the blsp_dma node to the device tree and the required
properties for using DMA with serial

Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi |  4 ++++
 arch/arm/boot/dts/qcom-ipq4019.dtsi           | 15 +++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
index 2c347ad..b9457dd2 100644
--- a/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
@@ -72,6 +72,10 @@
 			};
 		};
 
+		blsp_dma: dma at 7884000 {
+			status = "ok";
+		};
+
 		spi_0: spi at 78b5000 {
 			pinctrl-0 = <&spi_0_pins>;
 			pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index 3cd42c0..5c08d19 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -123,6 +123,17 @@
 			interrupts = <0 208 0>;
 		};
 
+		blsp_dma: dma at 7884000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0x07884000 0x23000>;
+			interrupts = <GIC_SPI 238 IRQ_TYPE_NONE>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "bam_clk";
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			status = "disabled";
+		};
+
 		spi_0: spi at 78b5000 {
 			compatible = "qcom,spi-qup-v2.2.1";
 			reg = <0x78b5000 0x600>;
@@ -224,6 +235,8 @@
 			clocks = <&gcc GCC_BLSP1_UART1_APPS_CLK>,
 				<&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
+			dmas = <&blsp_dma 1>, <&blsp_dma 0>;
+			dma-names = "rx", "tx";
 		};
 
 		serial at 78b0000 {
@@ -234,6 +247,8 @@
 			clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>,
 				<&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
+			dmas = <&blsp_dma 3>, <&blsp_dma 2>;
+			dma-names = "rx", "tx";
 		};
 
 		watchdog at b017000 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
