From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 10 Jul 2014 14:24:03 +0300
Subject: [PATCH 3/3] ARM: DTS: omap5-uevm: Enable basic audio (McPDM <->
 twl6040)
In-Reply-To: <1404991443-14239-1-git-send-email-peter.ujfalusi@ti.com>
References: <1404991443-14239-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1404991443-14239-4-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The board uses twl6040 codec connected via McPDM link. McBSP1 and McBSP2 can
be used for FM/BT.
At the same time move the pinctrl handling to the correct place - under the
corresponding nodes.
Audio connectors on the board:
Headset in/out
Stereo Line out
Stereo Line in.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap5-uevm.dts | 43 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index c9286166fad5..159720d6c956 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -100,14 +100,33 @@
 			};
 		};
 	};
+
+	sound: sound {
+		compatible = "ti,abe-twl6040";
+		ti,model = "omap5-uevm";
+
+		ti,mclk-freq = <19200000>;
+
+		ti,mcpdm = <&mcpdm>;
+
+		ti,twl6040 = <&twl6040>;
+
+		/* Audio routing */
+		ti,audio-routing =
+			"Headset Stereophone", "HSOL",
+			"Headset Stereophone", "HSOR",
+			"Line Out", "AUXL",
+			"Line Out", "AUXR",
+			"HSMIC", "Headset Mic",
+			"Headset Mic", "Headset Mic Bias",
+			"AFML", "Line In",
+			"AFMR", "Line In";
+	};
 };
 
 &omap5_pmx_core {
 	pinctrl-names = "default";
 	pinctrl-0 = <
-			&mcpdm_pins
-			&mcbsp1_pins
-			&mcbsp2_pins
 			&usbhost_pins
 			&led_gpio_pins
 	>;
@@ -528,8 +547,22 @@
 	};
 };
 
-&mcbsp3 {
-	status = "disabled";
+&mcpdm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcpdm_pins>;
+	status = "okay";
+};
+
+&mcbsp1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcbsp1_pins>;
+	status = "okay";
+};
+
+&mcbsp2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcbsp2_pins>;
+	status = "okay";
 };
 
 &usbhshost {
-- 
2.0.0
