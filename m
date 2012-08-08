From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 8 Aug 2012 18:30:51 -0300
Subject: USB host on mx23-olinuxino
Message-ID: <CAOMZO5BS_f1cJk=15gpYV3q-hza+ehST_DkTdUa27N-w5KCCOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am trying to add USB support for mx23olinuxino board (running
3.6-rc1), but I am getting:

[    0.890000] usbcore: registered new interface driver asix
[    0.890000] usbcore: registered new interface driver cdc_ether
[    0.900000] usbcore: registered new interface driver smsc95xx
[    0.900000] usbcore: registered new interface driver net1080
[    0.910000] usbcore: registered new interface driver cdc_subset
[    0.920000] usbcore: registered new interface driver zaurus
[    0.920000] usbcore: registered new interface driver cdc_ncm
[    0.930000] Initializing USB Mass Storage driver...
[    0.930000] usbcore: registered new interface driver usb-storage
[    0.940000] USB Mass Storage support registered.
[    0.950000] ci_hdrc ci_hdrc.0: doesn't support gadget
[    0.960000] ci_hdrc ci_hdrc.0: ChipIdea HDRC EHCI
[    0.960000] ci_hdrc ci_hdrc.0: new USB bus registered, assigned bus number 1
[    1.020000] ci_hdrc ci_hdrc.0: USB 2.0 started, EHCI 1.00
[    1.030000] hub 1-0:1.0: USB hub found
[    1.040000] hub 1-0:1.0: 1 port detected

....

[    1.300000] hub 1-0:1.0: unable to enumerate USB device on port 1
[    1.520000] hub 1-0:1.0: unable to enumerate USB device on port 1
[    1.740000] hub 1-0:1.0: unable to enumerate USB device on port 1
[    1.960000] hub 1-0:1.0: unable to enumerate USB device on port 1
[    2.180000] hub 1-0:1.0: unable to enumerate USB device on port 1
... and keeps forever

My changes are below. Hardware is fine as I can use USB host running
the FSL 2.6.35 kernel.

Schematics:
https://github.com/OLIMEX/OLINUXINO/blob/master/HARDWARE/iMX233-OLinuXino-Maxi/iMX233-OLINUXINO-MAXI_Rev_B1.sch.pdf

If anyone has any suggestions, I will be glad to hear.

Thanks,

Fabio Estevam

---
 arch/arm/boot/dts/imx23-olinuxino.dts |   41 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx23.dtsi          |    8 +++++-
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx23-olinuxino.dts
b/arch/arm/boot/dts/imx23-olinuxino.dts
index 20912b1..3ab18c3 100644
--- a/arch/arm/boot/dts/imx23-olinuxino.dts
+++ b/arch/arm/boot/dts/imx23-olinuxino.dts
@@ -31,6 +31,21 @@
 				bus-width = <4>;
 				status = "okay";
 			};
+
+			pinctrl at 80018000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&hog_pins_a>;
+
+				hog_pins_a: hog-gpios at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x0113 /* MX23_PAD_GPMI_ALE__GPIO_0_17 */
+					>;
+					fsl,drive-strength = <2>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <1>;
+				};
+			};
 		};

 		apbx at 80040000 {
@@ -39,6 +54,32 @@
 				pinctrl-0 = <&duart_pins_a>;
 				status = "okay";
 			};
+
+			usbphy0: usbphy at 8007c000 {
+				status = "okay";
+			};
+		};
+
+	};
+
+	ahb at 80080000 {
+		usb0: usb at 80080000 {
+			vbus-supply = <&reg_usb0_vbus>;
+			status = "okay";
+		};
+	};
+
+	regulators {
+		compatible = "simple-bus";
+
+		reg_usb0_vbus: usb0_vbus {
+			compatible = "regulator-fixed";
+			regulator-name = "usb0_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			startup-delay-us = <300>; /* LAN9215 requires a POR of 200us minimum */
+			gpio = <&gpio0 17 0>;
+			enable-active-high;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index e613831..83a8152 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -414,7 +414,8 @@
 				status = "disabled";
 			};

-			usbphy at 8007c000 {
+			usbphy0: usbphy at 8007c000 {
+				compatible = "fsl,imx23-usbphy";
 				reg = <0x8007c000 0x2000>;
 				status = "disabled";
 			};
@@ -428,8 +429,11 @@
 		reg = <0x80080000 0x80000>;
 		ranges;

-		usbctrl at 80080000 {
+		usb0: usb at 80080000 {
+			compatible = "fsl,imx23-usb", "fsl,imx27-usb";
 			reg = <0x80080000 0x40000>;
+			interrupts = <11>;
+			fsl,usbphy = <&usbphy0>;
 			status = "disabled";
 		};
 	};
--
