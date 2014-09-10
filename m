From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 10 Sep 2014 13:31:30 +0200
Subject: [PATCH v4 2/3] ARM: dts: Add Peach Pi dts entry for Atmel touchpad
In-Reply-To: <1410348691-18317-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1410348691-18317-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1410348691-18317-3-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Peach Pi board has an Atmel maXTouch trackpad device.
Add the needed Device Tree nodes to support it.

This Device Tree change is based on the Chrome OS 3.8 tree
but adapted to use the mainline Atmel maXTouch DT binding.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---

Changes since v3: None, new patch.

 arch/arm/boot/dts/exynos5800-peach-pi.dts | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 88b3544..025a095 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -505,6 +505,27 @@
 	};
 };
 
+&hsi2c_8 {
+	status = "okay";
+	clock-frequency = <333000>;
+	/* Atmel mXT540S */
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
+				     KEY_RESERVED	/* GPIO 0 */
+				     KEY_RESERVED	/* GPIO 1 */
+				     BTN_LEFT		/* GPIO 2 */
+				     KEY_RESERVED>;	/* GPIO 3 */
+	};
+};
+
 &hsi2c_9 {
 	status = "okay";
 	clock-frequency = <400000>;
@@ -589,6 +610,13 @@
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
