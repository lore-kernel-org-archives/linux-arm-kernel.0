From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 23 Mar 2017 17:27:29 +0100
Subject: [RFT PATCH 6/6] ARM64: dts: meson-gxbb: Add USB Hub GPIO hog
In-Reply-To: <1490286449-19448-1-git-send-email-narmstrong@baylibre.com>
References: <1490286449-19448-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1490286449-19448-7-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ODroid-C2 on-board USB Hub needs to to have it's reset signal set to
high level in order to be enumerated by the USB Host Controller.

But this management must be part of the currently in-development Generic
Power Sequence patch that will allow a USB Controller driver to start and stop
a power sequence associated to the USB Bus.

In the meantime, a simple USB Hog will work to enable the USB Hub.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index c59403a..6288538 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -177,6 +177,21 @@
 	pinctrl-names = "default";
 };
 
+&gpio_ao {
+	/*
+	 * WARNING: The USB Hub on the Odroid-C2 needs a reset signal
+	 * to be turned high in order to be detected by the USB Controller
+	 * This signal should be handled by a USB specific power sequence
+	 * in order to reset the Hub when USB bus is powered down.
+	 */
+	usb-hub {
+		gpio-hog;
+		gpios = <GPIOAO_4 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "usb-hub-reset";
+	};
+};
+
 &usb0_phy {
 	status = "okay";
 	phy-supply = <&usb_otg_pwr>;
-- 
1.9.1
