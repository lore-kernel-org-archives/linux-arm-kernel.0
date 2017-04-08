From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat,  8 Apr 2017 14:04:57 +0200
Subject: [PATCH 6/6] ARM: dts: Add Gemini DMA controller
In-Reply-To: <20170408120457.22750-1-linus.walleij@linaro.org>
References: <20170408120457.22750-1-linus.walleij@linaro.org>
Message-ID: <20170408120457.22750-6-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the Faraday Technology FTDMAC020 DMA controller to
the Gemini SoC DTSI file. It is only used for memcpy work so
we can activate it for all users of the chipset.

To make the PrimeCell bus work properly we need to add a summy
PCLK clock, as the generic clock framework always gets compiled
in on multiplatform builds.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Vinod: this is just for context, this patch will be directed through
the ARM SoC tree once the rest is done.
---
 arch/arm/boot/dts/gemini.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/gemini.dtsi b/arch/arm/boot/dts/gemini.dtsi
index e3fedcb69e2f..468ebdf9e594 100644
--- a/arch/arm/boot/dts/gemini.dtsi
+++ b/arch/arm/boot/dts/gemini.dtsi
@@ -8,6 +8,12 @@
 #include <dt-bindings/gpio/gpio.h>
 
 / {
+	pclk: pclk at 0 {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <0>;
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -186,5 +192,21 @@
 			syscon = <&syscon>;
 			status = "disabled";
 		};
+
+		dma-controller at 67000000 {
+			compatible = "faraday,ftdma020", "arm,pl080", "arm,primecell";
+			/* Faraday Technology FTDMAC020 variant */
+			arm,primecell-periphid = <0x0003b080>;
+			reg = <0x67000000 0x1000>;
+			interrupts = <9 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+			/* Bus interface AHB1 (AHB0) is totally tilted */
+			lli-bus-interface-ahb2;
+			mem-bus-interface-ahb2;
+			memcpy-burst-size = <256>;
+			memcpy-bus-width = <32>;
+			#dma-cells = <2>;
+		};
 	};
 };
-- 
2.9.3
