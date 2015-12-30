From: uri.mashiach@compulab.co.il (Uri Mashiach)
Date: Wed, 30 Dec 2015 13:41:33 +0200
Subject: [PATCH 1/3] ARM: dts: cm-t335: Add support for CAN bus
In-Reply-To: <1451475695-26921-1-git-send-email-uri.mashiach@compulab.co.il>
References: <1451475695-26921-1-git-send-email-uri.mashiach@compulab.co.il>
Message-ID: <1451475695-26921-2-git-send-email-uri.mashiach@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CAN bus pinmux.
Enable D_CAN bus controllers 0 and 1

The pinmux of uart1 node contradicts the pinmux of dcan0 and dcan1 nodes.
U-Boot should delete the uart1 or dcan0/1 nodes.

Signed-off-by: Uri Mashiach <uri.mashiach@compulab.co.il>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/boot/dts/am335x-cm-t335.dts | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
index b700940..f3d7845 100644
--- a/arch/arm/boot/dts/am335x-cm-t335.dts
+++ b/arch/arm/boot/dts/am335x-cm-t335.dts
@@ -144,6 +144,24 @@
 		>;
 	};
 
+	dcan0_pins: pinmux_dcan0_pins {
+		pinctrl-single,pins = <
+			/* uart1_ctsn.dcan0_tx */
+			AM33XX_IOPAD(0x978, PIN_OUTPUT | MUX_MODE2)
+			/* uart1_rtsn.dcan0_rx */
+			AM33XX_IOPAD(0x97C, PIN_INPUT | MUX_MODE2)
+		>;
+	};
+
+	dcan1_pins: pinmux_dcan1_pins {
+		pinctrl-single,pins = <
+			/* uart1_rxd.dcan1_tx */
+			AM33XX_IOPAD(0x980, PIN_OUTPUT | MUX_MODE2)
+			/* uart1_txd.dcan1_rx */
+			AM33XX_IOPAD(0x984, PIN_INPUT | MUX_MODE2)
+		>;
+	};
+
 	ecap0_pins: pinmux_ecap0_pins {
 		pinctrl-single,pins = <
 			/* eCAP0_in_PWM0_out.eCAP0_in_PWM0_out MODE0 */
@@ -448,3 +466,15 @@ status = "okay";
 		vwlan-supply = <&vwlan_fixed>;
 	};
 };
+
+&dcan0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&dcan0_pins>;
+};
+
+&dcan1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&dcan1_pins>;
+};
-- 
2.5.0
