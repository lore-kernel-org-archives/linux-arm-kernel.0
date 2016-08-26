From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 26 Aug 2016 16:52:34 +0200
Subject: [PATCH 1/3] ARM: dts: sun8i: Add dt node for esp8089 wifi chip on
 polaroid-mid2407
In-Reply-To: <20160826145236.30210-1-hdegoede@redhat.com>
References: <20160826145236.30210-1-hdegoede@redhat.com>
Message-ID: <20160826145236.30210-2-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The polaroid-mid2407 tablet has an esp8089 wifi chip,
add a dt node describing it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts   | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts b/arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts
index e300442..4789aac 100644
--- a/arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts
+++ b/arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts
@@ -47,4 +47,46 @@
 / {
 	model = "Polaroid MID2407PXE03 tablet";
 	compatible = "polaroid,mid2407pxe03", "allwinner,sun8i-a23";
+
+	aliases {
+		ethernet0 = &esp8089;
+	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_pwrseq_pin_mid2407>;
+		reset-gpios = <&r_pio 0 6 GPIO_ACTIVE_LOW>; /* PL6 */
+		/* The esp8089 needs 200 ms after driving wifi-en high */
+		post-power-on-delay-ms = <200>;
+	};
+};
+
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins_a>;
+	vmmc-supply = <&reg_dldo1>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+
+	esp8089: sdio_wifi at 1 {
+		compatible = "esp,esp8089";
+		reg = <1>;
+		esp,crystal-26M-en = <2>;
+	};
+};
+
+&mmc1_pins_a {
+	allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+};
+
+&r_pio {
+	wifi_pwrseq_pin_mid2407: wifi_pwrseq_pin at 0 {
+		allwinner,pins = "PL6";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
 };
-- 
2.9.3
