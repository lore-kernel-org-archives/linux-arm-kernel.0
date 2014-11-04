From: stefan@agner.ch (Stefan Agner)
Date: Tue,  4 Nov 2014 14:07:10 +0100
Subject: [PATCH 3/3] ARM: dts: vf-colibri: add USB regulators
In-Reply-To: <1415106430-6271-1-git-send-email-stefan@agner.ch>
References: <1415106430-6271-1-git-send-email-stefan@agner.ch>
Message-ID: <1415106430-6271-4-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add structure of USB supply logic. Especially, the USB hosts power
enable regulator is needed to control VBUS supply.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi | 45 ++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/vf-colibri.dtsi         | 12 +++++++++
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
index 80e8fbc..eb4ca50 100644
--- a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
@@ -11,6 +11,41 @@
 	chosen {
 		bootargs = "console=ttyLP0,115200";
 	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sys_5v0_reg: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "5v0";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			regulator-always-on;
+		};
+
+		usbc_vbus_reg: regulator at 2 {
+			compatible = "regulator-fixed";
+			reg = <2>;
+			regulator-name = "usbc_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			vin-supply = <&sys_5v0_reg>;
+		};
+
+		/* USBH_PEN */
+		usbh_vbus_reg: regulator at 3 {
+			compatible = "regulator-fixed";
+			reg = <3>;
+			regulator-name = "usbh_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio3 19 GPIO_ACTIVE_LOW>;
+			vin-supply = <&sys_5v0_reg>;
+		};
+	};
 };
 
 &bl {
@@ -51,4 +86,12 @@
 
 &uart2 {
 	status = "okay";
-};
\ No newline at end of file
+};
+
+&usbdev0 {
+	vbus-supply = <&usbc_vbus_reg>;
+};
+
+&usbh1 {
+	vbus-supply = <&usbh_vbus_reg>;
+};
diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colibri.dtsi
index 2371760..79ccfe2 100644
--- a/arch/arm/boot/dts/vf-colibri.dtsi
+++ b/arch/arm/boot/dts/vf-colibri.dtsi
@@ -163,5 +163,17 @@
 				VF610_PAD_PTD3__UART2_CTS		0x21a1
 			>;
 		};
+
+		pinctrl_usbh1_ext: gpio_usb_vbus {
+			fsl,pins = <
+				VF610_PAD_PTD4__GPIO_83			0x22ed
+			>;
+		};
+
+		pinctrl_usbdev0_ext: gpio_usb_cdet {
+			fsl,pins = <
+				VF610_PAD_PTC29__GPIO_102		0x22ed
+			>;
+		};
 	};
 };
-- 
2.1.3
