From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 10 Mar 2015 19:59:23 +0800
Subject: [PATCH v5 12/12] ARM: dts: sun6i: hummingbird: Add basic support for
 the WiFi module
In-Reply-To: <1425988764-23618-1-git-send-email-wens@csie.org>
References: <1425988764-23618-1-git-send-email-wens@csie.org>
Message-ID: <1425988764-23618-13-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Hummingbird A31 has an AMPAK AP6210 WiFi+Bluetooth module. The
WiFi part is a BCM43362 IC connected to MMC1 in the A31 SoC via SDIO.
The IC also takes a power enable signal via GPIO.

The WiFi module supports out-of-band interrupt signaling via GPIO,
but this is not supported in this patch.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index d13c88c6509a..25a3ef49bb71 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -61,6 +61,11 @@
 	chosen {
 		bootargs = "earlyprintk console=ttyS0,115200";
 	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&pio 6 10 GPIO_ACTIVE_LOW>; /* PG10 */
+	};
 };
 
 &ehci0 {
@@ -127,6 +132,16 @@
 	allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
 };
 
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins_a>, <&wifi_reset_pin_hummingbird>;
+	vmmc-supply = <&vcc_wifi>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+};
+
 &ohci0 {
 	status = "okay";
 };
@@ -138,6 +153,13 @@
 		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
 	};
+
+	wifi_reset_pin_hummingbird: wifi_reset_pin at 0 {
+		allwinner,pins = "PG10";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
 };
 
 &p2wi {
-- 
2.1.4
