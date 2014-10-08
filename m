From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 08 Oct 2014 23:55:59 +0400
Subject: [PATCH v4 2/2] ARM: shmobile: lager: enable HS-USB
In-Reply-To: <1674850.BZpGW9kEud@wasted.cogentembedded.com>
References: <1674850.BZpGW9kEud@wasted.cogentembedded.com>
Message-ID: <2455064.TG6DqQLVoV@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Enable HS-USB device for the Lager board, defining the GPIO that the driver
should check when probing. Since this board doesn't have the OTG ID pin, we
assume that GP5_18 (USB0_PWEN) is an ID pin because it is 1 when the SW5 is
in position 2-3 (meaning USB function) and 0 in other positions.

Note that there will be pinctrl-related error messages if both internal PCI
and HS-USB drivers are enabled but they should be just ignored.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
[Sergei: added pin node and prop, moved device node, fixed summary, supplemented
changelog]
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 4:
- fixed pin node name;
- moved pin node before USB0's one.

Changes in version 3:
- added pin function/group and the pinctrl-related prop;
- moved the HS-USB node to precede the USB PHY node;
- uppercased "arm" in the summary;
- supplemented changelog.

 arch/arm/boot/dts/r8a7790-lager.dts |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7790-lager.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7790-lager.dts
+++ renesas/arch/arm/boot/dts/r8a7790-lager.dts
@@ -221,6 +221,11 @@
 		renesas,function = "iic3";
 	};
 
+	hsusb_pins: hsusb {
+		renesas,groups = "usb0_ovc_vbus";
+		renesas,function = "usb0";
+	};
+
 	usb0_pins: usb0 {
 		renesas,groups = "usb0";
 		renesas,function = "usb0";
@@ -425,6 +430,13 @@
 	pinctrl-names = "default";
 };
 
+&hsusb {
+	status = "okay";
+	pinctrl-0 = <&hsusb_pins>;
+	pinctrl-names = "default";
+	renesas,enable-gpio = <&gpio5 18 GPIO_ACTIVE_HIGH>;
+};
+
 &usbphy {
 	status = "okay";
 };
