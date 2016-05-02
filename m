From: lkundrak@v3.sk (Lubomir Rintel)
Date: Mon,  2 May 2016 09:06:51 +0200
Subject: [PATCH v5] ARM: bcm2835: dt: Add the ethernet to the device trees
Message-ID: <1462172811-24206-1-git-send-email-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The hub and the ethernet in its port 1 are hardwired on the board.

Compared to the adapters that can be plugged into the USB ports, this
one has no serial EEPROM to store its MAC. Nevertheless, the Raspberry Pi
has the MAC address for this adapter in its ROM, accessible from its
firmware.

U-Boot can read out the address and set the local-mac-address property of the
node with "ethernet" alias. Let's add the node so that U-Boot can do its
business.

Model B rev2 and Model B+ entries were verified by me, the hierarchy and
pid/vid pair for the Version 2 was provided by Peter Chen. Original
Model B is a blind shot, though very likely correct.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Stephen Warren <swarren@wwwdotorg.org>
---
Changes since v4:
  - A whitespace fix

Changes since v3:
  - Include the ethernet alias in 9514 dtsi too

Changes since v2:
  - Removed leading zeroes in vendor name and reg
  - Split the common files in separate includes per model

Changes since v1:
  - s/@01/@1/ for ethernet and the hub
  - Corrected the vid/pid pairs for hub and ethernet
  - Added Model B rev2 and version 2 board changes
  - Fixed a missing semicolon typo

 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts    |  1 +
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts    |  1 +
 arch/arm/boot/dts/bcm2835-rpi-b.dts         |  1 +
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts       |  1 +
 arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi | 19 +++++++++++++++++++
 arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi | 19 +++++++++++++++++++
 arch/arm/boot/dts/bcm283x.dtsi              |  2 ++
 7 files changed, 44 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi

diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
index ef54050..c3e01ce 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
@@ -1,6 +1,7 @@
 /dts-v1/;
 #include "bcm2835.dtsi"
 #include "bcm2835-rpi.dtsi"
+#include "bcm283x-rpi-smsc9514.dtsi"
 
 / {
 	compatible = "raspberrypi,model-b-plus", "brcm,bcm2835";
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
index 86f1f2f..364086a 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
@@ -1,6 +1,7 @@
 /dts-v1/;
 #include "bcm2835.dtsi"
 #include "bcm2835-rpi.dtsi"
+#include "bcm283x-rpi-smsc9512.dtsi"
 
 / {
 	compatible = "raspberrypi,model-b-rev2", "brcm,bcm2835";
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b.dts b/arch/arm/boot/dts/bcm2835-rpi-b.dts
index 4859e9d..4420b09 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b.dts
@@ -1,6 +1,7 @@
 /dts-v1/;
 #include "bcm2835.dtsi"
 #include "bcm2835-rpi.dtsi"
+#include "bcm283x-rpi-smsc9512.dtsi"
 
 / {
 	compatible = "raspberrypi,model-b", "brcm,bcm2835";
diff --git a/arch/arm/boot/dts/bcm2836-rpi-2-b.dts b/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
index ff94666..b975f29 100644
--- a/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
+++ b/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
@@ -1,6 +1,7 @@
 /dts-v1/;
 #include "bcm2836.dtsi"
 #include "bcm2835-rpi.dtsi"
+#include "bcm283x-rpi-smsc9514.dtsi"
 
 / {
 	compatible = "raspberrypi,2-model-b", "brcm,bcm2836";
diff --git a/arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi b/arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi
new file mode 100644
index 0000000..12c981e
--- /dev/null
+++ b/arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi
@@ -0,0 +1,19 @@
+/ {
+	aliases {
+		ethernet = &ethernet;
+	};
+};
+
+&usb {
+	usb1 at 1 {
+		compatible = "usb424,9512";
+		reg = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethernet: usbether at 1 {
+			compatible = "usb424,ec00";
+			reg = <1>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi b/arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi
new file mode 100644
index 0000000..3f0a56e
--- /dev/null
+++ b/arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi
@@ -0,0 +1,19 @@
+/ {
+	aliases {
+		ethernet = &ethernet;
+	};
+};
+
+&usb {
+	usb1 at 1 {
+		compatible = "usb424,9514";
+		reg = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethernet: usbether at 1 {
+			compatible = "usb424,ec00";
+			reg = <1>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 8aaf193..04504b7 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -230,6 +230,8 @@
 			compatible = "brcm,bcm2835-usb";
 			reg = <0x7e980000 0x10000>;
 			interrupts = <1 9>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 	};
 
-- 
2.7.4
