From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 1 Mar 2016 14:06:07 +0100
Subject: [PATCH 1/2] ARM: dts: at91: sama5d2: add classD node
Message-ID: <ce1de34a6c36c17ce46bc39b675749c151aafad0.1456837347.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Songjun Wu <songjun.wu@atmel.com>

Add Class D audio amplifier node to sama5d2 description. The binding
documentation is already accepted and included as
Documentation/devicetree/bindings/sound/atmel-classd.txt.

Signed-off-by: Songjun Wu <songjun.wu@atmel.com>
[nicolas.ferre at atmel.com: split and adapt to newer kernel]
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
Hi,

Note that this node needs the audio PLL clock which is not submitted yet. So,
this series can't be applied right now: we have to wait for the audio PLL
driver and binding to be accepted and included first.

I send it right now so that it's not forgotten and easyer to track. Moreover,
the binding won't certainly change.

Bye,

 arch/arm/boot/dts/sama5d2.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 11ec7bfa2d29..e7fa3fcde7b3 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -821,6 +821,12 @@
 						#clock-cells = <0>;
 						reg = <55>;
 					};
+
+					classd_gclk: classd_gclk {
+						#clock-cells = <0>;
+						reg = <59>;
+						atmel,clk-output-range = <0 100000000>;
+					};
 				};
 			};
 
@@ -1187,6 +1193,19 @@
 				clock-names = "tdes_clk";
 				status = "okay";
 			};
+
+			classd: classd at fc048000 {
+				compatible = "atmel,sama5d2-classd";
+				reg = <0xfc048000 0x100>;
+				interrupts = <59 IRQ_TYPE_LEVEL_HIGH 7>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+					| AT91_XDMAC_DT_PERID(47))>;
+				dma-names = "tx";
+				clocks = <&classd_clk>, <&classd_gclk>, <&audio_pll_pmc>;
+				clock-names = "pclk", "gclk", "aclk";
+				status = "disabled";
+			};
 		};
 	};
 };
-- 
2.1.3
