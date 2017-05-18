From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 18 May 2017 15:16:53 +0800
Subject: [PATCH v6 9/9] arm64: allwinner: a64: enable Wi-Fi for Pine64
In-Reply-To: <20170518071653.36561-1-icenowy@aosc.io>
References: <20170518071653.36561-1-icenowy@aosc.io>
Message-ID: <20170518071653.36561-10-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Wi-Fi module of Pine64 is powered via DLDO4 and ELDO1 (the latter
one provides I/O voltage).

Add device node for it.

Although the Wi-Fi module is an external module which should be inserted
to a header, according to my personal talk with TL Lim, he does not want
this header to be used as GPIO (so it's with 2.0mm pitch, not 2.54mm as
other GPIO headers).

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index 40921bacb39c..6e43e2c07025 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -68,6 +68,11 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
+	};
 };
 
 &ehci0 {
@@ -99,6 +104,17 @@
 	status = "okay";
 };
 
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+	vmmc-supply = <&reg_dldo4>;
+	vqmmc-supply = <&reg_eldo1>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	non-removable;
+	bus-width = <4>;
+	status = "okay";
+};
+
 &ohci0 {
 	status = "okay";
 };
-- 
2.12.2
