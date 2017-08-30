From: embed3d@gmail.com (Philipp Rossak)
Date: Wed, 30 Aug 2017 05:01:07 +0200
Subject: [PATCH 4/7] ARM: dts: sun8i: h3: Enable AP6212 WiFi on mmc1 on Nanopi
 M1 Plus
In-Reply-To: <1504062070-13523-1-git-send-email-embed3d@gmail.com>
References: <1504062070-13523-1-git-send-email-embed3d@gmail.com>
Message-ID: <1504062070-13523-5-git-send-email-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Rossak <embed3d@gmail.com>

The WiFi side of the AP6212 WiFi/BT combo module is connected to
mmc1. There are also GPIOs for enable and interrupts.

Enable WiFi on this board by enabling mmc1 and adding the power
sequencing clocks and GPIO, as well as the chip's interrupt line.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts | 35 +++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
index b9c6c27..3054308 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
@@ -48,6 +48,7 @@
 
 	aliases {
 		ethernet0 = &emac;
+		ethernet1 = &ap6212;
 	};
 
 	reg_gmac_3v3: gmac-3v3 {
@@ -59,6 +60,14 @@
 		enable-active-high;
 		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>;
 	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_en_npi_m1p>;
+		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
+	};
+
 };
 
 &ehci1 {
@@ -93,6 +102,25 @@
 	};
 };
 
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins_a>;
+	vmmc-supply = <&reg_vcc3v3>;
+	vqmmc-supply = <&reg_vcc3v3>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+
+	ap6212: sdio_wifi at 1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+		interrupt-parent = <&pio>;
+		interrupts = <6 10 IRQ_TYPE_LEVEL_LOW>; /* PG10 / EINT10 */
+		interrupt-names = "host-wake";
+	};
+};
+
 &ohci1 {
 	status = "okay";
 };
@@ -100,3 +128,10 @@
 &ohci2 {
 	status = "okay";
 };
+
+&r_pio {
+	wifi_en_npi_m1p: wifi_en_pin {
+		pins = "PL7";
+		function = "gpio_out";
+	};
+};
-- 
2.7.4
