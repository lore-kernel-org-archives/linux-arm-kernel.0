From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Tue,  1 Dec 2015 20:03:20 +0200
Subject: [PATCH V2 18/19] ARM: dts: am57xx: sbc-am57x: add HDMI support
In-Reply-To: <1448993001-19495-1-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
 <1448993001-19495-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1448993001-19495-19-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add HDMI video output support.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
---

  v2:

   * Fix HDMI lanes polarity
   * Reformat subject

 arch/arm/boot/dts/am57xx-sbc-am57x.dts | 42 ++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-sbc-am57x.dts b/arch/arm/boot/dts/am57xx-sbc-am57x.dts
index 8e4c0fd..77bb8e1 100644
--- a/arch/arm/boot/dts/am57xx-sbc-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-sbc-am57x.dts
@@ -18,6 +18,7 @@
 
 	aliases {
 		display0 = &lcd0;
+		display1 = &hdmi;
 	};
 };
 
@@ -60,6 +61,19 @@
 			DRA7XX_CORE_IOPAD(0x3564, PIN_OUTPUT | MUX_MODE14)      /* vin2a_vsync0.gpio4_0 */
 		>;
 	};
+
+	hdmi_pins: pinmux_hdmi_pins {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x3808, PIN_INPUT | MUX_MODE1)	/* i2c2_sda.hdmi1_ddc_scl */
+			DRA7XX_CORE_IOPAD(0x380c, PIN_INPUT | MUX_MODE1)	/* i2c2_scl.hdmi1_ddc_sda */
+		>;
+	};
+
+	hdmi_conn_pins: pinmux_hdmi_conn_pins {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x37b8, PIN_INPUT | MUX_MODE14)	/* spi1_cs2.gpio7_12 */
+		>;
+	};
 };
 
 &uart3 {
@@ -135,3 +149,31 @@
 		};
 	};
 };
+
+&hdmi {
+	status = "ok";
+	vdda-supply = <&ldo4_reg>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdmi_pins>;
+
+	port {
+		hdmi_out: endpoint {
+			remote-endpoint = <&hdmi_connector_in>;
+			lanes = <1 0 3 2 5 4 7 6>;
+		};
+	};
+};
+
+&hdmi_conn {
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdmi_conn_pins>;
+
+	hpd-gpios = <&gpio7 12 GPIO_ACTIVE_HIGH>;
+
+	port {
+		hdmi_connector_in: endpoint {
+			remote-endpoint = <&hdmi_out>;
+		};
+	};
+};
-- 
1.9.1
