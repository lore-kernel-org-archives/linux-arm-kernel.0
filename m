From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 18 Oct 2017 16:31:37 +0800
Subject: [PATCH v2 7/8] ARM: dts: sun8i: a83t: cubietruck-plus: Enable AP6330
 WiFi on mmc1
In-Reply-To: <20171018083138.14517-1-wens@csie.org>
References: <20171018083138.14517-1-wens@csie.org>
Message-ID: <20171018083138.14517-8-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The WiFi side of the AP6330 WiFi/BT combo module is connected to
mmc1. There are also GPIOs for enable and interrupts. An external
clock from the AC100 RTC is also used.

Enable WiFi on this board by enabling mmc1 and adding the power
sequencing clocks and GPIO, as well as the chip's interrupt line.

For the WiFi module to correctly detect the frequency of its main
oscillator, the external low power clock must be set to 32768 Hz.

Their does not seem to be proper out-of-band interrupt support
for the BCM4330 chip within the AP6330 module. This part is left
out for now.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
index bd53e5748991..7f0a3f6d0cf2 100644
--- a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
@@ -131,6 +131,17 @@
 		#sound-dai-cells = <0>;
 		compatible = "linux,spdif-dit";
 	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&ac100_rtc 1>;
+		clock-names = "ext_clock";
+		/* The WiFi low power clock must be 32768 Hz */
+		assigned-clocks = <&ac100_rtc 1>;
+		assigned-clock-rates = <32768>;
+		/* enables internal regulator and de-asserts reset */
+		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 WL-PMU-EN */
+	};
 };
 
 &ehci0 {
@@ -153,6 +164,15 @@
 	status = "okay";
 };
 
+&mmc1 {
+	vmmc-supply = <&reg_dcdc1>;
+	vqmmc-supply = <&reg_sw>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+};
+
 &mmc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_8bit_emmc_pins>;
-- 
2.14.2
