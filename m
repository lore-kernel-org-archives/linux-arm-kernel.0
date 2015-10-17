From: vz@mleia.com (Vladimir Zapolskiy)
Date: Sun, 18 Oct 2015 00:35:57 +0300
Subject: [PATCH v2 8/8] arm: dts: lpc32xx: move USB controller subdevices into
 own device node
In-Reply-To: <1445117757-8073-1-git-send-email-vz@mleia.com>
References: <1445117757-8073-1-git-send-email-vz@mleia.com>
Message-ID: <1445117757-8073-9-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NXP LPC32xx SoC has one USB OTG controller, which is supposed to work
with an external phy (default is NXP ISP1301).

Practically the USB controller contains 5 subdevices:
- host controller   0x3102 0000 -- 0x3102 00FF
- OTG controller    0x3102 0100 -- 0x3102 01FF
- device controller 0x3102 0200 -- 0x3102 02FF
- I2C controller    0x3102 0300 -- 0x3102 03FF
- clock controller  0x3102 0F00 -- 0x3102 0FFF

The USB controller can be considered as a "bus", because the
subdevices above are relatively independent, for example I2C
controller is the same as other two general purpose I2C controllers
found on SoC.

The change is not intended to modify any logic, but it rearranges
existing device nodes, in future it is planned to add a USB clock
controller device node into the same group.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
Changes from v1 to v2:
- none, new change

 arch/arm/boot/dts/ea3250.dts   | 37 ++++++++++++-----------------
 arch/arm/boot/dts/lpc32xx.dtsi | 53 ++++++++++++++++++++++++------------------
 arch/arm/boot/dts/phy3250.dts  | 37 ++++++++++++-----------------
 3 files changed, 60 insertions(+), 67 deletions(-)

diff --git a/arch/arm/boot/dts/ea3250.dts b/arch/arm/boot/dts/ea3250.dts
index 392430b..a4a281f 100644
--- a/arch/arm/boot/dts/ea3250.dts
+++ b/arch/arm/boot/dts/ea3250.dts
@@ -31,19 +31,6 @@
 			use-iram;
 		};
 
-		/* Here, choose exactly one from: ohci, usbd */
-		ohci at 31020000 {
-			transceiver = <&isp1301>;
-			status = "okay";
-		};
-
-/*
-		usbd at 31020000 {
-			transceiver = <&isp1301>;
-			status = "okay";
-		};
-*/
-
 		/* 128MB Flash via SLC NAND controller */
 		slc: flash at 20020000 {
 			status = "okay";
@@ -130,15 +117,6 @@
 				clock-frequency = <100000>;
 			};
 
-			i2cusb: i2c at 31020300 {
-				clock-frequency = <100000>;
-
-				isp1301: usb-transceiver at 2d {
-					compatible = "nxp,isp1301";
-					reg = <0x2d>;
-				};
-			};
-
 			sd at 20098000 {
 				wp-gpios = <&pca9532 5 0>;
 				cd-gpios = <&pca9532 4 0>;
@@ -279,3 +257,18 @@
 		};
 	};
 };
+
+/* Here, choose exactly one from: ohci, usbd */
+&ohci /* &usbd */ {
+	transceiver = <&isp1301>;
+	status = "okay";
+};
+
+&i2cusb {
+	clock-frequency = <100000>;
+
+	isp1301: usb-transceiver at 2d {
+		compatible = "nxp,isp1301";
+		reg = <0x2d>;
+	};
+};
diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index ba91b20..c85cf97 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -57,21 +57,37 @@
 			interrupts = <0x1c 0>;
 		};
 
-		/*
-		 * Enable either ohci or usbd (gadget)!
-		 */
-		ohci: ohci at 31020000 {
-			compatible = "nxp,ohci-nxp", "usb-ohci";
-			reg = <0x31020000 0x300>;
-			interrupts = <0x3b 0>;
-			status = "disabled";
-		};
+		usb {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "simple-bus";
+			ranges = <0x0 0x31020000 0x00001000>;
 
-		usbd: usbd at 31020000 {
-			compatible = "nxp,lpc3220-udc";
-			reg = <0x31020000 0x300>;
-			interrupts = <0x3d 0>, <0x3e 0>, <0x3c 0>, <0x3a 0>;
-			status = "disabled";
+			/*
+			 * Enable either ohci or usbd (gadget)!
+			 */
+			ohci: ohci at 0 {
+				compatible = "nxp,ohci-nxp", "usb-ohci";
+				reg = <0x0 0x300>;
+				interrupts = <0x3b 0>;
+				status = "disabled";
+			};
+
+			usbd: usbd at 0 {
+				compatible = "nxp,lpc3220-udc";
+				reg = <0x0 0x300>;
+				interrupts = <0x3d 0>, <0x3e 0>, <0x3c 0>, <0x3a 0>;
+				status = "disabled";
+			};
+
+			i2cusb: i2c at 300 {
+				compatible = "nxp,pnx-i2c";
+				reg = <0x300 0x100>;
+				interrupts = <0x3f 0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pnx,timeout = <0x64>;
+			};
 		};
 
 		clcd: clcd at 31040000 {
@@ -207,15 +223,6 @@
 				status = "disabled";
 				#pwm-cells = <2>;
 			};
-
-			i2cusb: i2c at 31020300 {
-				compatible = "nxp,pnx-i2c";
-				reg = <0x31020300 0x100>;
-				interrupts = <0x3f 0>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				pnx,timeout = <0x64>;
-			};
 		};
 
 		fab {
diff --git a/arch/arm/boot/dts/phy3250.dts b/arch/arm/boot/dts/phy3250.dts
index 79a20f7..7d253bb 100644
--- a/arch/arm/boot/dts/phy3250.dts
+++ b/arch/arm/boot/dts/phy3250.dts
@@ -31,19 +31,6 @@
 			use-iram;
 		};
 
-		/* Here, choose exactly one from: ohci, usbd */
-		ohci at 31020000 {
-			transceiver = <&isp1301>;
-			status = "okay";
-		};
-
-/*
-		usbd at 31020000 {
-			transceiver = <&isp1301>;
-			status = "okay";
-		};
-*/
-
 		clcd at 31040000 {
 			status = "okay";
 		};
@@ -123,15 +110,6 @@
 				clock-frequency = <100000>;
 			};
 
-			i2cusb: i2c at 31020300 {
-				clock-frequency = <100000>;
-
-				isp1301: usb-transceiver at 2c {
-					compatible = "nxp,isp1301";
-					reg = <0x2c>;
-				};
-			};
-
 			ssp0: ssp at 20084000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -200,3 +178,18 @@
 		};
 	};
 };
+
+/* Here, choose exactly one from: ohci, usbd */
+&ohci /* &usbd */ {
+	transceiver = <&isp1301>;
+	status = "okay";
+};
+
+&i2cusb {
+	clock-frequency = <100000>;
+
+	isp1301: usb-transceiver at 2c {
+		compatible = "nxp,isp1301";
+		reg = <0x2c>;
+	};
+};
-- 
2.1.4
