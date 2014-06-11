From: tushar.b@samsung.com (Tushar Behera)
Date: Wed, 11 Jun 2014 11:02:19 +0530
Subject: [PATCH 3/3] ARM: dts: Enable audio support for Peach-pi board
In-Reply-To: <1402464739-19044-1-git-send-email-tushar.b@samsung.com>
References: <1402464739-19044-1-git-send-email-tushar.b@samsung.com>
Message-ID: <1402464739-19044-4-git-send-email-tushar.b@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peach-pi board has MAX98090 audio codec connected on HSI2C-7 bus.

Signed-off-by: Tushar Behera <tushar.b@samsung.com>
---
 arch/arm/boot/dts/exynos5800-peach-pi.dts |   31 +++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index f3af207..76f5966 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -78,9 +78,27 @@
 		pinctrl-0 = <&usb301_vbus_en>;
 		enable-active-high;
 	};
+
+	sound {
+		compatible = "google,snow-audio-max98090";
+
+		samsung,i2s-controller = <&i2s0>;
+		samsung,audio-codec = <&max98090>;
+	};
+};
+
+&i2s0 {
+	status = "okay";
 };
 
 &pinctrl_0 {
+	max98090_irq: max98090-irq {
+		samsung,pins = "gpx0-2";
+		samsung,pin-function = <0>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
 	tpm_irq: tpm-irq {
 		samsung,pins = "gpx1-0";
 		samsung,pin-function = <0>;
@@ -207,6 +225,19 @@
 	samsung,invert-vclk;
 };
 
+&hsi2c_7 {
+	status = "okay";
+
+	max98090: codec at 10 {
+		compatible = "maxim,max98090";
+		reg = <0x10>;
+		interrupts = <2 0>;
+		interrupt-parent = <&gpx0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&max98090_irq>;
+	};
+};
+
 &hsi2c_9 {
 	status = "okay";
 	clock-frequency = <400000>;
-- 
1.7.9.5
