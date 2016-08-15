From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 15 Aug 2016 01:35:38 +0000
Subject: [RFC PATCH] DT: kirkwood: Fix Openblock A6 external GPIO pins
Message-ID: <20160815013538.8056-1-jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By assigning the pin hog to the pinctrl node, we correctly configure the
MPPs.  However, they are not available to userspace.

Fix this by assigning the hogs to the gpio node.

After this, the following works as expected:

  # echo 28 >/sys/class/gpio/export
  # echo low >/sys/class/gpio/gpio28/direction

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
I'm submitting this as RFC because it's clear no one is using this, so I'm not
sure how far we need to take this.  The dip switches should probably be under
gpio-keys to make them input only.  Thoughts?

thx,

Jason.

 arch/arm/boot/dts/kirkwood-openblocks_a6.dts | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
index 0db0e3edc88f..ddb17b1cdfe0 100644
--- a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
+++ b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
@@ -41,9 +41,6 @@
 		};
 
 		pinctrl: pin-controller at 10000 {
-			pinctrl-0 = <&pmx_dip_switches &pmx_gpio_header>;
-			pinctrl-names = "default";
-
 			pmx_uart0: pmx-uart0 {
 				marvell,pins = "mpp10", "mpp11", "mpp15",
 					"mpp16";
@@ -174,3 +171,10 @@
 		phy-handle = <&ethphy0>;
 	};
 };
+
+&gpio0 {
+	status = "okay";
+
+	pinctrl-0 = <&pmx_dip_switches &pmx_gpio_header>;
+	pinctrl-names = "default";
+};
-- 
2.9.2
