From: simon@lineageos.org (Simon Shields)
Date: Thu, 9 Nov 2017 19:37:03 +1100
Subject: [PATCH v3] arm/dts/trats2: add bcm4334 device node
Message-ID: <20171109083657.GA27597@lineageos.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allows the bcm4334 to power on and enables
wifi functionality on trats2.

Signed-off-by: Simon Shields <simon@lineageos.org>
---
 arch/arm/boot/dts/exynos4412-trats2.dts | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 2da6ced64ee0..f34fdc9c57ad 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -240,6 +240,13 @@
 
 	};
 
+	wlan_pwrseq: sdhci3-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpj0 0 GPIO_ACTIVE_LOW>;
+		clocks = <&max77686 MAX77686_CLK_PMIC>;
+		clock-names = "ext_clock";
+	};
+
 	sound {
 		compatible = "samsung,trats2-audio";
 		samsung,i2s-controller = <&i2s0>;
@@ -1238,6 +1245,27 @@
 	status = "okay";
 };
 
+&sdhci_3 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	non-removable;
+	bus-width = <4>;
+
+	mmc-pwrseq = <&wlan_pwrseq>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sd3_clk &sd3_cmd &sd3_bus4>;
+	vmmc-supply = <&ldo21_reg>;
+	status = "okay";
+
+	brcmf: brcmf at 1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+		interrupt-parent = <&gpx2>;
+		interrupts = <5 IRQ_TYPE_NONE>;
+		interrupt-names = "host-wake";
+	};
+};
+
 &serial_0 {
 	status = "okay";
 };
-- 
2.15.0
