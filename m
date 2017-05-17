From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 17 May 2017 09:40:49 +0200
Subject: [PATCH v3 20/21] ARM: sun5i: a10s: Add the HDMI controller node
In-Reply-To: <cover.463df61c38224ecbfb5bf1cf192deeb63718b693.1495006350.git-series.maxime.ripard@free-electrons.com>
References: <cover.463df61c38224ecbfb5bf1cf192deeb63718b693.1495006350.git-series.maxime.ripard@free-electrons.com>
Message-ID: <204084676333bcb0c1bcae42eef6daa49d63bd82.1495006350.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A10s has an HDMI controller connected to the second TCON channel. Add
it to our DT.

Since the TV Encoder was the only channel 1 user so far, also add the
property now that we have several users.

Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 47 ++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/sun5i.dtsi      |  1 +-
 2 files changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 1e38ff80366c..567cce46486b 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -71,7 +71,46 @@
 		};
 	};
 
+	display-engine {
+		compatible = "allwinner,sun5i-a10s-display-engine";
+		allwinner,pipelines = <&fe0>;
+	};
+
 	soc at 01c00000 {
+		hdmi: hdmi at 01c16000 {
+			compatible = "allwinner,sun5i-a10s-hdmi";
+			reg = <0x01c16000 0x1000>;
+			interrupts = <58>;
+			clocks = <&ccu CLK_AHB_HDMI>, <&ccu CLK_HDMI>,
+				 <&ccu CLK_PLL_VIDEO0_2X>,
+				 <&ccu CLK_PLL_VIDEO1_2X>;
+			clock-names = "ahb", "mod", "pll-0", "pll-1";
+			dmas = <&dma SUN4I_DMA_NORMAL 16>,
+			       <&dma SUN4I_DMA_NORMAL 16>,
+			       <&dma SUN4I_DMA_DEDICATED 24>;
+			dma-names = "ddc-tx", "ddc-rx", "audio-tx";
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				hdmi_in: port at 0 {
+					reg = <0>;
+
+					hdmi_in_tcon0: endpoint {
+						remote-endpoint = <&tcon0_out_hdmi>;
+					};
+				};
+
+				hdmi_out: port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+			};
+		};
+
 		pwm: pwm at 01c20e00 {
 			compatible = "allwinner,sun5i-a10s-pwm";
 			reg = <0x01c20e00 0xc>;
@@ -128,3 +167,11 @@
 
 &sram_a {
 };
+
+&tcon0_out {
+	tcon0_out_hdmi: endpoint at 2 {
+		reg = <2>;
+		remote-endpoint = <&hdmi_in_tcon0>;
+		allwinner,tcon-channel = <1>;
+	};
+};
diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 5175f9cc9bed..0e29f1d98a9e 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -272,6 +272,7 @@
 					tcon0_out_tve0: endpoint at 1 {
 						reg = <1>;
 						remote-endpoint = <&tve0_in_tcon0>;
+						allwinner,tcon-channel = <1>;
 					};
 				};
 			};
-- 
git-series 0.9.1
