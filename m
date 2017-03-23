From: jelle@vdwaa.nl (Jelle van der Waa)
Date: Thu, 23 Mar 2017 22:24:44 +0100
Subject: [PATCH v2 1/1] ARM: dts: sun8i: NanoPi NEO Air add WiFi / eMMC
In-Reply-To: <20170323212444.20685-1-jelle@vdwaa.nl>
References: <20170323212444.20685-1-jelle@vdwaa.nl>
Message-ID: <20170323212444.20685-2-jelle@vdwaa.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the WiFi (AP6212) chip and eMMC support for the NanoPi NEO Air.

Signed-off-by: Jelle van der Waa <jelle@vdwaa.nl>
---
 arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts | 45 +++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
index 3ba081c1f555..457a28e56514 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
@@ -73,6 +73,13 @@
 			gpios = <&pio 0 10 GPIO_ACTIVE_HIGH>; /* PA10 */
 		};
 	};
+
+	wifi-pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi-en-nanopi-neo-air>;
+		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
+	};
 };
 
 &mmc0 {
@@ -85,6 +92,44 @@
 	status = "okay";
 };
 
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins_a>;
+	vmmc-supply = <&reg_vcc3v3>;
+	vqmmc-supply = <&reg_vcc3v3>;
+	mmc-pwrseq = <&wifi-pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+
+	brcmf: bcrmf at 1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+		interrupt-parent = <&pio>;
+		interrupts = <6 10 IRQ_TYPE_LEVEL_LOW>; /* PG10 / EINT10 */
+		interrupt-names = "host-wake";
+	};
+};
+
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_8bit_pins>;
+	vmmc-supply = <&reg_vcc3v3>;
+	vqmmc-supply = <&reg_vcc3v3>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&r_pio {
+	wifi-en-nanopi-neo-air: wifi_en_pin {
+		pins = "PL7";
+		function = "gpio_out";
+		drive-strength = <10>;
+		bias-disable;
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.12.1
