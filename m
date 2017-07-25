From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue, 25 Jul 2017 20:45:04 +0800
Subject: [PATCH v2 3/3] arm64: allwinner: a64: add proper support for the
 Wi-Fi on BPi M64
In-Reply-To: <20170725124504.40242-1-icenowy@aosc.io>
References: <20170725124504.40242-1-icenowy@aosc.io>
Message-ID: <20170725124504.40242-3-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

BPi M64 has an AP6212 Wi-Fi/Bluetooth combo module, and the Wi-Fi SDIO
card is connected to the mmc1 controller.

The pwrseq of the mmc1 (used to reset the card) used to missing, and the
out-of-band interrupt line of the card is not specified.

Fix these issues for proper Wi-Fi support of BPi M64.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index ec72ca8c8b30..4a8d3f83a36e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -59,6 +59,11 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
+	};
 };
 
 &ehci1 {
@@ -107,9 +112,18 @@
 	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&reg_dldo2>;
 	vqmmc-supply = <&reg_dldo4>;
+	mmc-pwrseq = <&wifi_pwrseq>;
 	bus-width = <4>;
 	non-removable;
 	status = "okay";
+
+	brcmf: wifi at 1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+		interrupt-parent = <&r_pio>;
+		interrupts = <0 3 IRQ_TYPE_LEVEL_LOW>; /* PL3 */
+		interrupt-names = "host-wake";
+	};
 };
 
 &mmc2 {
-- 
2.13.0
