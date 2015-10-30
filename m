From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 30 Oct 2015 15:21:03 +0100
Subject: [PATCH 17/19] ARM: sun5i: dt: Add display blocks to the DTSI
In-Reply-To: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1446214865-3972-18-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The TCON and Display Engines are the two most important members of the
display pipeline.

With this alone, we can already use the display to an RGB interface.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i.dtsi | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 426db76c0fe6..a67f4bdf5bcc 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -481,6 +481,20 @@
 			#size-cells = <0>;
 		};
 
+		tcon: lcd-controller at 01c0c000 {
+			compatible = "allwinner,sun4i-a10-tcon";
+			reg = <0x01c0c000 0x1000>;
+			interrupts = <44>;
+			clocks = <&ahb_gates 36>,
+				 <&tcon_ch0_clk>,
+				 <&tcon_ch1_clk>;
+			clock-names = "ahb",
+				      "tcon-ch0",
+				      "tcon-ch1";
+			clock-output-names = "tcon-pixel-clock";
+			status = "disabled";
+		};
+
 		mmc0: mmc at 01c0f000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c0f000 0x1000>;
@@ -767,5 +781,31 @@
 			interrupts = <82>, <83>;
 			clocks = <&ahb_gates 28>;
 		};
+
+		de: display-engine at 01e00000 {
+			compatible = "allwinner,sun5i-a13-display-engine";
+			reg = <0x01e00000 0x20000>,
+			      <0x01e60000 0x10000>;
+			reg-names = "frontend0",
+				    "backend0";
+			interrupts = <47>;
+			interrupt-names = "engine0";
+			clocks = <&ahb_gates 46>, <&de_fe_clk>,
+				 <&dram_gates 25>, <&ahb_gates 44>,
+				 <&de_be_clk>, <&dram_gates 26>;
+			clock-names = "frontend0-bus", "frontend0-mod",
+				      "frontend0-ram", "backend0-bus",
+				      "backend0-mod", "backend0-ram";
+			resets = <&de_fe_clk>,
+				 <&de_be_clk>;
+			reset-names = "frontend0",
+				      "backend0";
+
+			allwinner,tcon = <&tcon>;
+
+			assigned-clocks = <&de_be_clk>;
+			assigned-clock-rates = <300000000>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.6.2
