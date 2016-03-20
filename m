From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 20 Mar 2016 17:00:35 +0100
Subject: [PATCH 7/8] ARM: dts: sun8i: Add wifi dt node on Orangepi Plus boards
In-Reply-To: <1458489636-2825-1-git-send-email-hdegoede@redhat.com>
References: <1458489636-2825-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1458489636-2825-8-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Orangepi Plus and Orangepi Plus 2 have a realtek rtl8189etv sdio
wifi chip. This commit adds a device-tree node to power it up, so
that the mmc subsys can scan it, and enables the mmc controller which
is connected to it.

Note that this just makes the wifi controller show up as a sdio device.
In order for it to work a compatible sdio driver is necessary, an out
of tree driver is available here:
https://github.com/jwrdegoede/rtl8189ES_linux/

Binding the driver is not done through device tree, but through sdio
vendor- and device-id, so it can safely be enabled in devicetree
without having a driver upstream yet.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
index a7cdfd0..f5aa694 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
@@ -108,6 +108,13 @@
 		enable-active-high;
 		gpio = <&pio 6 11 GPIO_ACTIVE_HIGH>;
 	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_pwrseq_pin_orangepi>;
+		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 WIFI_EN */
+	};
 };
 
 &pio {
@@ -156,6 +163,13 @@
 		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
+
+	wifi_pwrseq_pin_orangepi: wifi_pwrseq_pin at 0 {
+		allwinner,pins = "PL7";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
 };
 
 &mmc0 {
@@ -168,6 +182,16 @@
 	status = "okay";
 };
 
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins_a>;
+	vmmc-supply = <&reg_vcc3v3>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+};
+
 &reg_usb1_vbus {
 	gpio = <&pio 6 13 GPIO_ACTIVE_HIGH>;
 	status = "okay";
-- 
2.7.3
