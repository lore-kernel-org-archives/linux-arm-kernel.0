From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Wed, 17 Jul 2013 18:45:53 +0200
Subject: [PATCH v2 34/42] ARM: at91/dt: move at91sam9g20 SoC to new at91 clk
 implem
In-Reply-To: <1374068069-13496-1-git-send-email-b.brezillon@overkiz.com>
References: <1374068069-13496-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1374079553-20942-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define at91sam9g20 clocks in at91sam9g20 device tree.
Add references to the appropriate clocks in each peripheral.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 arch/arm/boot/dts/at91sam9g20.dtsi |   37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
index b8e7946..60a20ec 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -25,6 +25,43 @@
 			adc0: adc at fffe0000 {
 				atmel,adc-startup-time = <40>;
 			};
+
+			pmc: pmc at fffffc00 {
+				plla: pllack {
+					compatible = "atmel,at91sam9g45-clk-pll";
+					#clock-cells = <0>;
+					clocks = <&main>;
+					id = <0>;
+					input = <2000000 32000000>;
+					output = <74500000 800000000
+							  69500000 750000000
+							  64500000 700000000
+							  59500000 650000000
+							  54500000 600000000
+							  49500000 550000000
+							  44500000 500000000
+							  40000000 450000000>;
+					out = <0 1 2 3 0 1 2 3>;
+					icpll = <0 0 0 0 1 1 1 1>;
+				};
+
+				pllb: pllbck {
+					compatible = "atmel,at91sam9g20-clk-pllb";
+					#clock-cells = <0>;
+					clocks = <&main>;
+					id = <1>;
+					input = <2000000 32000000>;
+					output = <30000000 100000000>;
+					out = <0>;
+				};
+
+				mck: masterck {
+					#clock-cells = <0>;
+					clocks = <&clk32k>, <&main>, <&plla>, <&pllb>;
+					output = <0 133000000>;
+					divisors = <1 2 4 6>;
+				};
+			};
 		};
 	};
 };
-- 
1.7.9.5
