From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 31 May 2013 15:45:56 -0700
Subject: [PATCH 2/3] ARM: DTS: OMAP3: beagle: enable user button via gpio_keys,
 enable wakeup
In-Reply-To: <1370040357-25794-1-git-send-email-khilman@linaro.org>
References: <1370040357-25794-1-git-send-email-khilman@linaro.org>
Message-ID: <1370040357-25794-3-git-send-email-khilman@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using the gpio-keys bindings, configure the user button on Beagle
boards.  Since the user button is enabled as a wakeup source, also
ensure the GPIO pin is mux'd correctly and has IO ring wakeups enabled,
so it can also wakeup from off mode.

Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
 arch/arm/boot/dts/omap3-beagle-xm.dts | 25 +++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-beagle.dts    | 25 +++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index ca067b0..c93c36f 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -57,6 +57,26 @@
 		ti,mcbsp = <&mcbsp2>;
 		ti,codec = <&twl_audio>;
 	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+
+		user {
+			label = "user";
+			gpios = <&gpio1 4 0>;
+			linux,code = <0x114>;
+			gpio-key,wakeup;
+		};
+
+	};
+};
+
+&omap3_pmx_wkup {
+	gpio1_pins: pinmux_gpio1_pins {
+		pinctrl-single,pins = <
+			0x0e 0x4104	/* sys_boot2.gpio_4 WAKEUP | INPUT | MODE4 */
+		>;
+	};
 };
 
 &i2c1 {
@@ -140,3 +160,8 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart3_pins>;
 };
+
+&gpio1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gpio1_pins>;
+};
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index b004372..c9794cb 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -71,6 +71,26 @@
 		reset-supply = <&hsusb2_reset>;
 		vcc-supply = <&hsusb2_power>;
 	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+
+		user {
+			label = "user";
+			gpios = <&gpio1 7 0>;
+			linux,code = <0x114>;
+			gpio-key,wakeup;
+		};
+
+	};
+};
+
+&omap3_pmx_wkup {
+	gpio1_pins: pinmux_gpio1_pins {
+		pinctrl-single,pins = <
+			0x14 0x4104	/* sys_boot5.gpio_7 WAKEUP | INPUT | MODE4 */
+		>;
+	};
 };
 
 &omap3_pmx_core {
@@ -154,3 +174,8 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart3_pins>;
 };
+
+&gpio1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gpio1_pins>;
+};
-- 
1.8.2
