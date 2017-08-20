From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 20 Aug 2017 12:05:56 +0200
Subject: [PATCH 3/4 v2] ARM: dts: Add TVE200 to the Gemini SoC DTSI
In-Reply-To: <20170820100557.24991-1-linus.walleij@linaro.org>
References: <20170820100557.24991-1-linus.walleij@linaro.org>
Message-ID: <20170820100557.24991-3-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Faraday TVE200 is present in the Gemini SoC, sometimes
under the name "TVC". Add it to the SoC DTSI file along with
its resources.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Move the definition of cells to this file as it is part
  of the IP binding.
- Rename node from "tvc" to "display-controller"

DRM developers: I will merge this patch through the ARM SoC
tree. It is only included in this series for completion.
---
 arch/arm/boot/dts/gemini.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/gemini.dtsi b/arch/arm/boot/dts/gemini.dtsi
index c68e8d430234..53baba4d9392 100644
--- a/arch/arm/boot/dts/gemini.dtsi
+++ b/arch/arm/boot/dts/gemini.dtsi
@@ -141,6 +141,12 @@
 						groups = "idegrp";
 					};
 				};
+				tvc_default_pins: pinctrl-tvc {
+					mux {
+						function = "tvc";
+						groups = "tvcgrp";
+					};
+				};
 			};
 		};
 
@@ -346,5 +352,20 @@
 			memcpy-bus-width = <32>;
 			#dma-cells = <2>;
 		};
+
+		display-controller at 6a000000 {
+			compatible = "cortina,gemini-tvc", "faraday,tve200";
+			reg = <0x6a000000 0x1000>;
+			interrupts = <13 IRQ_TYPE_EDGE_RISING>;
+			resets = <&syscon GEMINI_RESET_TVC>;
+			clocks = <&syscon GEMINI_CLK_GATE_TVC>,
+				 <&syscon GEMINI_CLK_TVC>;
+			clock-names = "PCLK", "TVE";
+			pinctrl-names = "default";
+			pinctrl-0 = <&tvc_default_pins>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.13.5
