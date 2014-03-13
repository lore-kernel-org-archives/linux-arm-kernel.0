From: tharvey@gateworks.com (Tim Harvey)
Date: Thu, 13 Mar 2014 14:44:24 -0700
Subject: [PATCH] ARM: dts: ventana: fix eth1 pci dev node
Message-ID: <1394747064-4106-1-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Properly add the PCI device node for the 2nd GigE port so that the device
driver can get its MAC from DT.  Note that the Ventana bootloader uses
the ethernet1 alias to populate the MAC address by adding the local-mac-address
property.  Also remove the unnecesssary 'sky2' alias.

This is based on Shawn's for-next branch

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6q-gw5400-a.dts  | 40 +++++++++++++++++++++++++++++++----
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 39 ++++++++++++++++++++++++++++++----
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 39 ++++++++++++++++++++++++++++++----
 3 files changed, 106 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-gw5400-a.dts b/arch/arm/boot/dts/imx6q-gw5400-a.dts
index 902f983..5d2b912 100644
--- a/arch/arm/boot/dts/imx6q-gw5400-a.dts
+++ b/arch/arm/boot/dts/imx6q-gw5400-a.dts
@@ -16,7 +16,7 @@
 	model = "Gateworks Ventana GW5400-A";
 	compatible = "gw,imx6q-gw5400-a", "gw,ventana", "fsl,imx6q";
 
-	/* these are used by bootloader for disabling nodes */
+	/* these are used by bootloader for configuring nodes */
 	aliases {
 		ethernet0 = &fec;
 		ethernet1 = &eth1;
@@ -26,7 +26,7 @@
 		led0 = &led0;
 		led1 = &led1;
 		led2 = &led2;
-		sky2 = &eth1;
+
 		ssi0 = &ssi1;
 		spi0 = &ecspi1;
 		usb0 = &usbh1;
@@ -496,8 +496,40 @@
 	reset-gpio = <&gpio1 29 0>;
 	status = "okay";
 
-	eth1: sky2 at 8 { /* MAC/PHY on bus 8 */
-		compatible = "marvell,sky2";
+	pcie at 0,0 {
+		/* 00:00.0 host-bridge */
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		reg = <0x0 0 0 0 0>;
+
+		/*
+		 * GigE PCI dev node needs to be defined so that enet driver
+		 * can use it to obtain its boot-loader specified MAC
+		 */
+		pcie at 0,0 {
+			/* 01:00.0 PCIe switch */
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			reg = <0x0 0 0 0 0>;
+
+			pcie at 8,0 {
+				/* 02:08.0 PCIe switch port */
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
+				reg = <0x4000 0 0 0 0>;
+				eth1: pcie at 0,0 {
+					/* 08:00.0 GigE */
+					#address-cells = <3>;
+					#size-cells = <2>;
+					device_type = "pci";
+					reg = <0x0 0 0 0 0>;
+					compatible = "marvell,sky2";
+				};
+			};
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index c8e5ae0..46a8582 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -10,7 +10,7 @@
  */
 
 / {
-	/* these are used by bootloader for disabling nodes */
+	/* these are used by bootloader for configuring nodes */
 	aliases {
 		can0 = &can1;
 		ethernet0 = &fec;
@@ -19,7 +19,6 @@
 		led1 = &led1;
 		led2 = &led2;
 		nand = &gpmi;
-		sky2 = &eth1;
 		ssi0 = &ssi1;
 		usb0 = &usbh1;
 		usb1 = &usbotg;
@@ -503,8 +502,40 @@
 	reset-gpio = <&gpio1 29 0>;
 	status = "okay";
 
-	eth1: sky2 at 8 { /* MAC/PHY on bus 8 */
-		compatible = "marvell,sky2";
+	/*
+	 * GigE PCI dev node needs to be defined so that enet driver
+	 * can use it to obtain its boot-loader specified MAC
+	 */
+	pcie at 0,0 {
+		/* 00:00.0 root host-bridge */
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		reg = <0x0 0 0 0 0>;
+
+		pcie at 0,0 {
+			/* 01:00.0 PCIe switch */
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			reg = <0x0 0 0 0 0>;
+
+			pcie at 4,0 {
+				/* 02:04.0 PCIe switch port */
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
+				reg = <0x2000 0 0 0 0>;
+				eth1: pcie at 0,0 {
+					/* 04:00.0 GigE */
+					#address-cells = <3>;
+					#size-cells = <2>;
+					device_type = "pci";
+					reg = <0x0 0 0 0 0>;
+					compatible = "marvell,sky2";
+				};
+			};
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index 2795dfc..697aa67 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -10,7 +10,7 @@
  */
 
 / {
-	/* these are used by bootloader for disabling nodes */
+	/* these are used by bootloader for configuring nodes */
 	aliases {
 		can0 = &can1;
 		ethernet0 = &fec;
@@ -19,7 +19,6 @@
 		led1 = &led1;
 		led2 = &led2;
 		nand = &gpmi;
-		sky2 = &eth1;
 		ssi0 = &ssi1;
 		usb0 = &usbh1;
 		usb1 = &usbotg;
@@ -525,8 +524,40 @@
 	reset-gpio = <&gpio1 29 0>;
 	status = "okay";
 
-	eth1: sky2 at 8 { /* MAC/PHY on bus 8 */
-		compatible = "marvell,sky2";
+	/*
+	 * GigE PCI dev node needs to be defined so that enet driver
+	 * can use it to obtain its boot-loader specified MAC
+	 */
+	pcie at 0,0 {
+		/* 00:00.0 root host-bridge */
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		reg = <0x0 0 0 0 0>;
+
+		pcie at 0,0 {
+			/* 01:00.0 PCIe switch */
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			reg = <0x0 0 0 0 0>;
+
+			pcie at 8,0 {
+				/* 02:08.0 PCIe switch port */
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
+				reg = <0x4000 0 0 0 0>;
+				eth1: pcie at 0,0 {
+					/* 08:00.0 GigE */
+					#address-cells = <3>;
+					#size-cells = <2>;
+					device_type = "pci";
+					reg = <0x0 0 0 0 0>;
+					compatible = "marvell,sky2";
+				};
+			};
+		};
 	};
 };
 
-- 
1.8.3.2
