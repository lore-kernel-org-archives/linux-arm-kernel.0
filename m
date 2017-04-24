From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue, 25 Apr 2017 00:01:03 +0800
Subject: [PATCH v4 10/10] arm64: allwinner: a64: enable Wi-Fi for Pine64
In-Reply-To: <20170424160103.9447-1-icenowy@aosc.io>
References: <20170424160103.9447-1-icenowy@aosc.io>
Message-ID: <20170424160103.9447-11-icenowy@aosc.io>
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
index abc1879e91f2..2e4f44800162 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -64,6 +64,11 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
+	};
 };
 
 &ehci1 {
@@ -91,6 +96,17 @@
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
 &ohci1 {
 	status = "okay";
 };
-- 
2.12.2
