From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 27 Jan 2016 01:14:21 +0300
Subject: [PATCH] ARM: dts: porter: add MAX3355 support
In-Reply-To: <1674850.BZpGW9kEud@wasted.cogentembedded.com>
References: <1674850.BZpGW9kEud@wasted.cogentembedded.com>
Message-ID: <4506196.xOgpYRO52t@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that Maxim Integrated MAX3355 'extcon' driver and device tree bindings
are upstream along with the 'extcon' hook  in the Renesas USBHS driver, we
can add  MAX3355 device node to  the Porter device tree and properly refer
to it from the USBHS node instead of using  "renesas,enable-gpio" property
which only allowed checking the USB ID pin  at the driver probe time;  now
this  pin's  state can be monitored dynamically!

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against 'renesas-devel-20160126-v4.5-rc1' tag of Simon Horman's
'renesas.git' repo.

 arch/arm/boot/dts/r8a7791-porter.dts |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: renesas/arch/arm/boot/dts/r8a7791-porter.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7791-porter.dts
+++ renesas/arch/arm/boot/dts/r8a7791-porter.dts
@@ -90,6 +90,12 @@
 			  1800000 0>;
 	};
 
+	max3355: usb-otg {
+		compatible = "maxim,max3355";
+		maxim,shdn-gpios = <&gpio2 4 GPIO_ACTIVE_HIGH>;
+		id-gpios = <&gpio5 31 GPIO_ACTIVE_HIGH>;
+	};
+
 	hdmi-out {
 		compatible = "hdmi-connector";
 		type = "a";
@@ -394,7 +400,7 @@
 	pinctrl-names = "default";
 
 	status = "okay";
-	renesas,enable-gpio = <&gpio5 31 GPIO_ACTIVE_HIGH>;
+	extcon = <&max3355>;
 };
 
 &usbphy {
