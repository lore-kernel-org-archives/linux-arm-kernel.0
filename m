From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 4 May 2018 09:45:33 +0000
Subject: [PATCH v2 2/2] ARM64: dts: meson-axg: enable AP6255 wifi module
In-Reply-To: <20180504094533.15588-1-yixun.lan@amlogic.com>
References: <20180504094533.15588-1-yixun.lan@amlogic.com>
Message-ID: <20180504094533.15588-3-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Meson-AXG S400 board is shipped with AP6255 wifi module,
which is actually using the brcmfmac 43455 driver.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 .../arm64/boot/dts/amlogic/meson-axg-s400.dts | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 6b6581c513a8..b3e1bdca32bb 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -48,6 +48,20 @@
 		compatible = "mmc-pwrseq-emmc";
 		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
 	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpio GPIOX_7 GPIO_ACTIVE_LOW>;
+		clocks = <&wifi32k>;
+		clock-names = "ext_clock";
+	};
+
+	wifi32k: wifi32k {
+		compatible = "pwm-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		pwms = <&pwm_ab 0 30518 0>; /* PWM_A at 32.768KHz */
+	};
 };
 
 &ethmac {
@@ -81,6 +95,12 @@
 	pinctrl-names = "default";
 };
 
+&pwm_ab {
+	status = "okay";
+	pinctrl-0 = <&pwm_a_x20_pins>;
+	pinctrl-names = "default";
+};
+
 /* emmc storage */
 &sd_emmc_c {
 	status = "okay";
@@ -100,3 +120,30 @@
 	vmmc-supply = <&vcc_3v3>;
 	vqmmc-supply = <&vddio_boot>;
 };
+
+/* wifi module */
+&sd_emmc_b {
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	pinctrl-0 = <&sdio_pins>;
+	pinctrl-1 = <&sdio_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
+
+	bus-width = <4>;
+	cap-sd-highspeed;
+	max-frequency = <100000000>;
+	non-removable;
+	disable-wp;
+
+	mmc-pwrseq = <&sdio_pwrseq>;
+
+	vmmc-supply = <&vddao_3v3>;
+	vqmmc-supply = <&vddio_boot>;
+
+	brcmf: wifi at 1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+	};
+};
-- 
2.17.0
