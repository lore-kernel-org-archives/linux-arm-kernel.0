From: stefan@agner.ch (Stefan Agner)
Date: Sun, 16 Nov 2014 19:00:28 +0100
Subject: [PATCH v2] ARM: dts: vf-colibri: add USB regulators
Message-ID: <1416160828-18168-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add structure of USB supply logic. The USB hosts power enable
regulator is needed to control VBUS supply on the Colibri carrier
board.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
This is the second version of a leftover of the "ARM: dts: vf610:
USB/GPIO fixes" patchset. The rest is already applied.

Changes in v2:
- Assign pinctrl to usbh_vbus_reg explicitly
- Remove USB client/host VBUS supply (not yet implemented in
  driver)

 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi | 34 ++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/vf-colibri.dtsi         |  6 ++++++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
index 80e8fbc..2d3e966 100644
--- a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
@@ -11,6 +11,34 @@
 	chosen {
 		bootargs = "console=ttyLP0,115200";
 	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sys_5v0_reg: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "5v0";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			regulator-always-on;
+		};
+
+		/* USBH_PEN */
+		usbh_vbus_reg: regulator at 1 {
+			compatible = "regulator-fixed";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usbh1_reg>;
+			reg = <1>;
+			regulator-name = "usbh_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio3 19 GPIO_ACTIVE_LOW>;
+			vin-supply = <&sys_5v0_reg>;
+		};
+	};
 };
 
 &bl {
@@ -51,4 +79,8 @@
 
 &uart2 {
 	status = "okay";
-};
\ No newline at end of file
+};
+
+&usbh1 {
+	vbus-supply = <&usbh_vbus_reg>;
+};
diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colibri.dtsi
index 2371760..27bcf5f 100644
--- a/arch/arm/boot/dts/vf-colibri.dtsi
+++ b/arch/arm/boot/dts/vf-colibri.dtsi
@@ -163,5 +163,11 @@
 				VF610_PAD_PTD3__UART2_CTS		0x21a1
 			>;
 		};
+
+		pinctrl_usbh1_reg: gpio_usb_vbus {
+			fsl,pins = <
+				VF610_PAD_PTD4__GPIO_83			0x22ed
+			>;
+		};
 	};
 };
-- 
2.1.3
