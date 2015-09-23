From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 24 Sep 2015 00:05:19 +0800
Subject: [PATCH v4 3/5] ARM: dts: sun8i: Add Reduced Serial Bus controller
 device node to A23/A33 dtsi
In-Reply-To: <1443024323-9115-1-git-send-email-wens@csie.org>
References: <1443024323-9115-1-git-send-email-wens@csie.org>
Message-ID: <1443024323-9115-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a device node for the Reduced Serial Bus (RSB)
controller and the defacto pinmux setting to the A23/A33 dtsi.

Since there is only one possible pinmux setting for RSB, just
set it in the dtsi.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Changes since v3:

  - Changed #address-cells to 1

---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 04bccad977ee..828aaf52c342 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -651,6 +651,13 @@
 			#size-cells = <0>;
 			#gpio-cells = <3>;
 
+			r_rsb_pins: r_rsb {
+				allwinner,pins = "PL0", "PL1";
+				allwinner,function = "s_rsb";
+				allwinner,drive = <SUN4I_PINCTRL_20_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+			};
+
 			r_uart_pins_a: r_uart at 0 {
 				allwinner,pins = "PL2", "PL3";
 				allwinner,function = "s_uart";
@@ -658,5 +665,19 @@
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 		};
+
+		r_rsb: rsb at 01f03400 {
+			compatible = "allwinner,sun8i-a23-rsb";
+			reg = <0x01f03400 0x400>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&apb0_gates 3>;
+			clock-frequency = <3000000>;
+			resets = <&apb0_rst 3>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&r_rsb_pins>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
 	};
 };
-- 
2.5.3
