From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 15 Aug 2016 14:51:04 +0000
Subject: [PATCH] DT: kirkwood: Fix Openblock A6 external GPIO pins
In-Reply-To: <20160815013538.8056-1-jason@lakedaemon.net>
References: <20160815013538.8056-1-jason@lakedaemon.net>
Message-ID: <20160815145104.14135-1-jason@lakedaemon.net>
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
After sleeping on it a night, I decided to leave the dip switches alone.

 arch/arm/boot/dts/kirkwood-openblocks_a6.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
index 0db0e3edc88f..94e49f32d5f9 100644
--- a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
+++ b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
@@ -41,7 +41,7 @@
 		};
 
 		pinctrl: pin-controller at 10000 {
-			pinctrl-0 = <&pmx_dip_switches &pmx_gpio_header>;
+			pinctrl-0 = <&pmx_dip_switches>;
 			pinctrl-names = "default";
 
 			pmx_uart0: pmx-uart0 {
@@ -174,3 +174,10 @@
 		phy-handle = <&ethphy0>;
 	};
 };
+
+&gpio0 {
+	status = "okay";
+
+	pinctrl-0 = <&pmx_gpio_header>;
+	pinctrl-names = "default";
+};
-- 
2.9.2
