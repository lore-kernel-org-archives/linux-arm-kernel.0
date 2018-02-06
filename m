From: baolin.wang@linaro.org (Baolin Wang)
Date: Tue,  6 Feb 2018 17:28:25 +0800
Subject: [PATCH 6/7] arm64: dts: Add DMA device node for Spreadtrum SC9860
In-Reply-To: <410b2f2d3f3f019c96ec31213647c41cd7f1174d.1517908478.git.baolin.wang@linaro.org>
References: <410b2f2d3f3f019c96ec31213647c41cd7f1174d.1517908478.git.baolin.wang@linaro.org>
Message-ID: <ec74e9b83ec9b1c83f7ad54d0a80be68ce7bb2e0.1517908478.git.baolin.wang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Spreadtrum SC9860 platform has two DMA controllers, one is located
on the ap-ahb system, and another one is located on the agcp system.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/whale2.dtsi |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
index f2cdf4d..66a881e 100644
--- a/arch/arm64/boot/dts/sprd/whale2.dtsi
+++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
@@ -107,6 +107,23 @@
 			};
 		};
 
+		ap-ahb {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			ap_dma: dma-controller at 20100000 {
+				compatible = "sprd,sc9860-dma";
+				reg = <0 0x20100000 0 0x4000>;
+				interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+				#dma-cells = <1>;
+				#dma-channels = <32>;
+				clock-names = "enable";
+				clocks = <&apahb_gate CLK_DMA_EB>;
+			};
+		};
+
 		aon {
 			compatible = "simple-bus";
 			#address-cells = <2>;
@@ -151,6 +168,23 @@
 				clocks = <&aon_gate CLK_APCPU_WDG_EB>;
 			};
 		};
+
+		agcp {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			agcp_dma: dma-controller at 41580000 {
+				compatible = "sprd,sc9860-dma";
+				reg = <0 0x41580000 0 0x4000>;
+				#dma-cells = <1>;
+				#dma-channels = <32>;
+				clock-names = "enable", "ashb_eb";
+				clocks = <&agcp_gate CLK_AGCP_DMAAP_EB>,
+				       <&agcp_gate CLK_AGCP_AP_ASHB_EB>;
+			};
+		};
 	};
 
 	ext_32k: ext_32k {
-- 
1.7.9.5
