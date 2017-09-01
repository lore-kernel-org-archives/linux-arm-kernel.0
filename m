From: embed3d@gmail.com (Philipp Rossak)
Date: Fri,  1 Sep 2017 18:30:00 +0200
Subject: [PATCH v2 1/2] ARM: dts: sun8i: h3: Enable AP6212 WiFi on mmc1 on
 Nanopi M1 Plus
In-Reply-To: <1504283401-4263-1-git-send-email-embed3d@gmail.com>
References: <1504283401-4263-1-git-send-email-embed3d@gmail.com>
Message-ID: <1504283401-4263-2-git-send-email-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Rossak <embed3d@gmail.com>

The WiFi side of the AP6212 WiFi/BT combo module is connected to
mmc1. There are also GPIOs for enable and interrupts.

Enable WiFi on this board by enabling mmc1 and adding the power
sequencing clocks and GPIO, as well as the chip's interrupt line.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
index 6256f55..7d18c35 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
@@ -48,6 +48,13 @@
 
 	aliases {
 		serial1 = &uart3;
+		ethernet1 = &sdio_wifi;
+	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
 	};
 };
 
@@ -65,6 +72,24 @@
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
+
+	sdio_wifi: sdio_wifi at 1 {
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
-- 
2.7.4
