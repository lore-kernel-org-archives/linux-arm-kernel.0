From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed,  5 Apr 2017 02:01:35 +0800
Subject: [PATCH 01/11] arm64: allwinner: a64: enable RSB on A64
In-Reply-To: <20170404180145.12897-1-icenowy@aosc.io>
References: <20170404180145.12897-1-icenowy@aosc.io>
Message-ID: <20170404180145.12897-2-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A64 have a RSB controller like the one on A23/A33 SoCs.

Add it and its pinmux.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 6bc606b4d74d..9a75b1c7c91a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -420,6 +420,27 @@
 			#gpio-cells = <3>;
 			interrupt-controller;
 			#interrupt-cells = <3>;
+
+			r_rsb_pins: rsb at 0 {
+				pins = "PL0", "PL1";
+				function = "s_rsb";
+				drive-strength = <20>;
+				bias-pull-up;
+			};
+		};
+
+		r_rsb: rsb at 1f03400 {
+			compatible = "allwinner,sun8i-a23-rsb";
+			reg = <0x01f03400 0x400>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&r_ccu 6>;
+			clock-frequency = <3000000>;
+			resets = <&r_ccu 2>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&r_rsb_pins>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 	};
 };
-- 
2.12.2
