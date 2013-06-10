From: festevam@gmail.com (Fabio Estevam)
Date: Sun,  9 Jun 2013 22:07:47 -0300
Subject: [PATCH 2/2] ARM: dts: imx51-babbage: Pass a real clock to the codec
In-Reply-To: <1370826467-30399-1-git-send-email-festevam@gmail.com>
References: <1370826467-30399-1-git-send-email-festevam@gmail.com>
Message-ID: <1370826467-30399-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

On imx51_babbage the codec clock is activated via GPIO4_26.

Provide a real clock to the sgtl5000 codec via device tree.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx51-babbage.dts | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 6dd9486..27b4061 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -61,6 +61,16 @@
 		mux-int-port = <2>;
 		mux-ext-port = <3>;
 	};
+
+	clocks {
+		clk_26M: codec_clock {
+			compatible = "fixed-clock";
+			reg=<0>;
+			#clock-cells = <0>;
+			clock-frequency = <26000000>;
+			gpios = <&gpio4 26 1>;
+		};
+	};
 };
 
 &esdhc1 {
@@ -229,6 +239,7 @@
 				MX51_PAD_EIM_A27__GPIO2_21   0x5
 				MX51_PAD_CSPI1_SS0__GPIO4_24 0x85
 				MX51_PAD_CSPI1_SS1__GPIO4_25 0x85
+				MX51_PAD_CSPI1_RDY__GPIO4_26 0x80000000
 			>;
 		};
 	};
@@ -255,7 +266,7 @@
 	sgtl5000: codec at 0a {
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
-		clock-frequency = <26000000>;
+		clocks = <&clk_26M>;
 		VDDA-supply = <&vdig_reg>;
 		VDDIO-supply = <&vvideo_reg>;
 	};
-- 
1.8.1.2
