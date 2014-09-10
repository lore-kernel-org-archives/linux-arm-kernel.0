From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 10 Sep 2014 13:31:29 +0200
Subject: [PATCH v4 1/3] ARM: dts: Add Peach Pit dts entry for Atmel touchpad
In-Reply-To: <1410348691-18317-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1410348691-18317-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1410348691-18317-2-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

The Peach Pit board has an Atmel maXTouch trackpad device.
Add the needed Device Tree nodes to support it.

This Device Tree change is based on the Chrome OS 3.8 tree
but adapted to use the mainline Atmel maXTouch DT binding.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---

Changes since v3:
 - Use KEY_RESERVED even for not reserved pins with a GPIO not hooked.
   Suggested by Nick Dyer.
 - Add a comment to specify the maXTouch chip version so is more clear.
   Suggested by Nick Dyer.
 - Omit trailing omit KEY_RESERVED after the GPIO pins. Suggested by Nick Dyer.

Changes since v2:
 - Add spaces around '=' on properties. Suggested by Andreas Faerber.

Changes since v1:
 - Change trackpad IRQ pad function from 0x0 (GPIO input) to 0xf (GPIO IRQ).
   suggested by Tomasz Figa.
 - Remove BTN_TOOL_* from "linux,gpio-keymap" property since those are set
   by input mt core if INPUT_MT_POINTER is set. Suggested by Nick Dyer.
 - Use correct values for "linux,gpio-keymap" property. Suggested by Nick Dyer.
 - Remove support for Peach Pi board since it uses a different Atmel touchpad
   that requires an Atmel object protocol  (T100) not supported by the driver.
 - Use IRQ type constants from <dt-bindings/interrupt-controller/irq.h> instead
   of magic numbers. Suggested by Andreas Faerber.

 arch/arm/boot/dts/exynos5420-peach-pit.dts | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index f247709..ad56d4c 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -507,6 +507,28 @@
 	};
 };
 
+&hsi2c_8 {
+	status = "okay";
+	clock-frequency = <333000>;
+
+	/* Atmel mXT336S */
+	trackpad at 4b {
+		compatible = "atmel,maxtouch";
+		reg = <0x4b>;
+		interrupt-parent = <&gpx1>;
+		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+		wakeup-source;
+		pinctrl-names = "default";
+		pinctrl-0 = <&trackpad_irq>;
+		linux,gpio-keymap = <KEY_RESERVED
+				     KEY_RESERVED
+				     KEY_RESERVED	/* GPIO0 */
+				     KEY_RESERVED	/* GPIO1 */
+				     KEY_RESERVED	/* GPIO2 */
+				     BTN_LEFT>; 	/* GPIO3 */
+	};
+};
+
 &hsi2c_9 {
 	status = "okay";
 	clock-frequency = <400000>;
@@ -591,6 +613,13 @@
 		samsung,pin-drv = <0>;
 	};
 
+	trackpad_irq: trackpad-irq {
+		samsung,pins = "gpx1-1";
+		samsung,pin-function = <0xf>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
 	power_key_irq: power-key-irq {
 		samsung,pins = "gpx1-2";
 		samsung,pin-function = <0>;
-- 
2.1.0
