From: mkelly@xevo.com (Martin Kelly)
Date: Tue, 23 Jan 2018 15:58:44 -0800
Subject: [PATCH v3] ARM: dts: sun8i: NanoPi NEO Air add WiFi / eMMC
Message-ID: <20180123235844.5511-1-mkelly@xevo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jelle van der Waa <jelle@vdwaa.nl>

Enable the WiFi (AP6212) chip and eMMC support for the NanoPi NEO Air.

This patch was originally submitted by Jelle van der Waa. Martin Kelly
modified it to compile on the latest kernel, fixed up some review
comments from Maxime Ripard, and re-tested the patch.

These are the original patch submissions:

https://patchwork.kernel.org/patch/9581613/
https://patchwork.kernel.org/patch/9642071/

Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-sunxi at googlegroups.com
Cc: devicetree at vger.kernel.org
Signed-off-by: Jelle van der Waa <jelle@vdwaa.nl>
Signed-off-by: Martin Kelly <mkelly@xevo.com>
---
 arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
index 03ff6f8b93ff..920849092cc8 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
@@ -72,6 +72,11 @@
 			gpios = <&pio 0 10 GPIO_ACTIVE_HIGH>; /* PA10 */
 		};
 	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
+	};
 };
 
 &mmc0 {
@@ -84,6 +89,25 @@
 	status = "okay";
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
+	brcmf: bcrmf at 1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+		interrupt-parent = <&pio>;
+		interrupts = <6 10 IRQ_TYPE_LEVEL_LOW>; /* PG10 / EINT10 */
+		interrupt-names = "host-wake";
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.11.0
