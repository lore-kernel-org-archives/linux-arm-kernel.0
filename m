From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 30 May 2017 10:08:57 +0200
Subject: [PATCH] ARM: dts: Add Gemini DMA controller
Message-ID: <20170530080857.13806-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the Faraday Technology FTDMAC020 DMA controller to
the Gemini SoC DTSI file. It is only used for memcpy work so
we can activate it for all users of the chipset.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
The driver has been merged to the DMA tree. The clock and reset
lines are added with numerical values as we do not want to
depend on <dt-bindings/*> headers in the merge window. Will
be fixed post-rc1.
---
 arch/arm/boot/dts/gemini.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/gemini.dtsi b/arch/arm/boot/dts/gemini.dtsi
index 80abf84f8a80..0beaa4ef757e 100644
--- a/arch/arm/boot/dts/gemini.dtsi
+++ b/arch/arm/boot/dts/gemini.dtsi
@@ -175,5 +175,22 @@
 				#interrupt-cells = <1>;
 			};
 		};
+
+		dma-controller at 67000000 {
+			compatible = "faraday,ftdma020", "arm,pl080", "arm,primecell";
+			/* Faraday Technology FTDMAC020 variant */
+			arm,primecell-periphid = <0x0003b080>;
+			reg = <0x67000000 0x1000>;
+			interrupts = <9 IRQ_TYPE_EDGE_RISING>;
+			resets = <&syscon 10>;
+			clocks = <&syscon 1>;
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
2.9.4
