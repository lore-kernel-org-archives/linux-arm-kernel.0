From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Mon,  4 Dec 2017 10:23:06 +0530
Subject: [PATCH v2 1/2] arm64: dts: a64-olinuxino: Enable RTL8723BS WiFi
Message-ID: <1512363187-8353-1-git-send-email-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable RTL8723BS WiFi chip on a64-olinuxino board:
- WiFi SDIO interface is connected to MMC1
- WiFi REG_ON pin connected to gpio PL2: attach to mmc-pwrseq
- WiFi HOST_WAKE pin connected to gpio PL3

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
Changes for v2:
- Remove wrong commit message

 .../boot/dts/allwinner/sun50i-a64-olinuxino.dts    | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
index 338e7861..8807664 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
@@ -57,6 +57,11 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
+	};
 };
 
 &mmc0 {
@@ -70,6 +75,24 @@
 	status = "okay";
 };
 
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+	vmmc-supply = <&reg_aldo2>;
+	vqmmc-supply = <&reg_dldo4>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+
+	rtl8723bs: wifi at 1 {
+		reg = <1>;
+		interrupt-parent = <&r_pio>;
+		interrupts = <0 3 IRQ_TYPE_LEVEL_LOW>; /* PL3 */
+		interrupt-names = "host-wake";
+	};
+};
+
 &r_rsb {
 	status = "okay";
 
-- 
2.7.4
