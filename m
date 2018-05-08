From: djw@t-chip.com.cn (djw at t-chip.com.cn)
Date: Tue,  8 May 2018 10:48:24 +0800
Subject: [PATCH v0 2/2] arm64: dts: rockchip: Add sdmmc UHS support for
 roc-rk3328-cc
In-Reply-To: <1525747704-8537-1-git-send-email-djw@t-chip.com.cn>
References: <1525747704-8537-1-git-send-email-djw@t-chip.com.cn>
Message-ID: <1525747704-8537-3-git-send-email-djw@t-chip.com.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Levin Du <djw@t-chip.com.cn>

In roc-rk3328-cc board, the signal voltage of sdmmc is supplied by
the vcc_sdio regulator, which is a mux between 1.8V and 3.3V,
controlled by a special output only gpio pin.

However, this pin,  not being a normal gpio in the rockchip pinctrl,
is set by bit 1 of system register GRF_SOC_CON10. Therefore a new
gpio controller using gpio-syscon driver is defined in order to use
regulator-gpio.

If the signal voltage changes, the io domain needs to change
correspondingly.

To use this feature, the following options are required in kernel config:
 - CONFIG_GPIO_SYSCON=y
 - CONFIG_POWER_AVS=y
 - CONFIG_ROCKCHIP_IODOMAIN=y

Signed-off-by: Levin Du <djw@t-chip.com.cn>

---

 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts b/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
index 246c317..792cb04 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
@@ -14,6 +14,12 @@
 		stdout-path = "serial2:1500000n8";
 	};
 
+	gpio_syscon10: gpio-syscon10 {
+		compatible = "rockchip,rk3328-gpio-syscon10";
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	gmac_clkin: external-gmac-clock {
 		compatible = "fixed-clock";
 		clock-frequency = <125000000>;
@@ -41,6 +47,19 @@
 		vin-supply = <&vcc_io>;
 	};
 
+	vcc_sdio: sdmmcio-regulator {
+		compatible = "regulator-gpio";
+		gpios = <&gpio_syscon10 1 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x1
+			  3300000 0x0>;
+		regulator-name = "vcc_sdio";
+		regulator-type = "voltage";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		vin-supply = <&vcc_sys>;
+	};
+
 	vcc_host1_5v: vcc_otg_5v: vcc-host1-5v-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -208,6 +227,18 @@
 	};
 };
 
+&io_domains {
+	status = "okay";
+
+	vccio1-supply = <&vcc_io>;
+	vccio2-supply = <&vcc18_emmc>;
+	vccio3-supply = <&vcc_sdio>;
+	vccio4-supply = <&vcc_18>;
+	vccio5-supply = <&vcc_io>;
+	vccio6-supply = <&vcc_io>;
+	pmuio-supply = <&vcc_io>;
+};
+
 &pinctrl {
 	pmic {
 		pmic_int_l: pmic-int-l {
@@ -227,10 +258,15 @@
 	cap-mmc-highspeed;
 	cap-sd-highspeed;
 	disable-wp;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
 	max-frequency = <150000000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdmmc0_clk &sdmmc0_cmd &sdmmc0_dectn &sdmmc0_bus4>;
 	vmmc-supply = <&vcc_sd>;
+	vqmmc-supply = <&vcc_sdio>;
 	status = "okay";
 };
 
-- 
2.7.4
