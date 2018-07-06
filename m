From: andre.przywara@arm.com (Andre Przywara)
Date: Fri,  6 Jul 2018 09:52:09 +0100
Subject: [PATCH 09/10] arm64: dts: allwinner: a64: NanoPi-A64: Add
 Wifi/Bluetooth chip
In-Reply-To: <20180706085210.17952-1-andre.przywara@arm.com>
References: <20180706085210.17952-1-andre.przywara@arm.com>
Message-ID: <20180706085210.17952-10-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NanoPi-A64 has an on-board WiFi/Bluetooth combo chip, connected
to the usual MMC1 and UART1. The power is provided by the always-on
VCC_SYS_3.3V, but it uses pin L2 to enable the regulator.

Add the respective nodes to the DT to make it usable.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../boot/dts/allwinner/sun50i-a64-nanopi-a64.dts   | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
index 0439cff685d6..bb3ba7709dee 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
@@ -53,11 +53,18 @@
 	aliases {
 		ethernet0 = &emac;
 		serial0 = &uart0;
+		serial1 = &uart1;
 	};
 
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+        wifi_pwrseq: wifi_pwrseq {
+                compatible = "mmc-pwrseq-simple";
+                reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
+        };
+
 };
 
 &ehci0 {
@@ -105,6 +112,25 @@
 	status = "okay";
 };
 
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+	vmmc-supply = <&reg_dcdc1>;
+	vqmmc-supply = <&reg_dldo4>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+
+	brcmf: wifi at 1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+		interrupt-parent = <&r_pio>;
+		interrupts = <0 3 IRQ_TYPE_LEVEL_LOW>; /* PL3 */
+		interrupt-names = "host-wake";
+	};
+};
+
 &ohci0 {
 	status = "okay";
 };
@@ -229,6 +255,13 @@
 	status = "okay";
 };
 
+/* Connected to the Bluetooth UART, with hardware handshake pins */
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
+	status = "okay";
+};
+
 &usbphy {
 	status = "okay";
 };
-- 
2.14.4
