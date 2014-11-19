From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 19 Nov 2014 16:27:00 +0100
Subject: [PATCH 2/2] ARM: shmobile: sh73a0 dtsi: Add missing INTCA0 clock for
 irqpin module
In-Reply-To: <1416410820-30020-1-git-send-email-geert+renesas@glider.be>
References: <1416410820-30020-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1416410820-30020-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This clock drives the irqpin controller modules.
Before, it was assumed enabled by the bootloader or reset state.
By making it available to the driver, we make sure it gets enabled when
needed, and allow it to be managed by system or runtime PM.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: devicetree at vger.kernel.org
---
This depends on the series "[PATCH v5 0/6] sh73a0 common clock framework
implementation".
---
 arch/arm/boot/dts/sh73a0.dtsi            | 15 +++++++++++++++
 include/dt-bindings/clock/sh73a0-clock.h |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 0853a6fe2209a48a..c7ab55e55e23f8cb 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -78,6 +78,7 @@
 			      0 6 IRQ_TYPE_LEVEL_HIGH
 			      0 7 IRQ_TYPE_LEVEL_HIGH
 			      0 8 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp5_clks SH73A0_CLK_INTCA0>;
 	};
 
 	irqpin1: irqpin at e6900004 {
@@ -97,6 +98,7 @@
 			      0 14 IRQ_TYPE_LEVEL_HIGH
 			      0 15 IRQ_TYPE_LEVEL_HIGH
 			      0 16 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp5_clks SH73A0_CLK_INTCA0>;
 		control-parent;
 	};
 
@@ -117,6 +119,7 @@
 			      0 22 IRQ_TYPE_LEVEL_HIGH
 			      0 23 IRQ_TYPE_LEVEL_HIGH
 			      0 24 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp5_clks SH73A0_CLK_INTCA0>;
 	};
 
 	irqpin3: irqpin at e690000c {
@@ -136,6 +139,7 @@
 			      0 30 IRQ_TYPE_LEVEL_HIGH
 			      0 31 IRQ_TYPE_LEVEL_HIGH
 			      0 32 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp5_clks SH73A0_CLK_INTCA0>;
 	};
 
 	i2c0: i2c at e6820000 {
@@ -705,5 +709,16 @@
 			clock-output-names =
 				"iic3", "iic4", "keysc";
 		};
+		mstp5_clks: mstp5_clks at e6150144 {
+			compatible = "renesas,sh73a0-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xe6150144 4>, <0xe615003c 4>;
+			clocks = <&cpg_clocks SH73A0_CLK_HP>;
+			#clock-cells = <1>;
+			clock-indices = <
+				SH73A0_CLK_INTCA0
+			>;
+			clock-output-names =
+				"intca0";
+		};
 	};
 };
diff --git a/include/dt-bindings/clock/sh73a0-clock.h b/include/dt-bindings/clock/sh73a0-clock.h
index 1dd3eb2b7d902afd..53369568c24c5dc6 100644
--- a/include/dt-bindings/clock/sh73a0-clock.h
+++ b/include/dt-bindings/clock/sh73a0-clock.h
@@ -76,4 +76,7 @@
 #define SH73A0_CLK_IIC4		10
 #define SH73A0_CLK_KEYSC	3
 
+/* MSTP5 */
+#define SH73A0_CLK_INTCA0	8
+
 #endif
-- 
1.9.1
