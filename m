From: djw@t-chip.com.cn (djw at t-chip.com.cn)
Date: Fri, 18 May 2018 11:52:08 +0800
Subject: [PATCH v2 5/5] arm64: dts: rockchip: Add sdmmc UHS support for
 roc-rk3328-cc
In-Reply-To: <1526615528-9707-1-git-send-email-djw@t-chip.com.cn>
References: <1526614328-6869-1-git-send-email-djw@t-chip.com.cn>
 <1526615528-9707-1-git-send-email-djw@t-chip.com.cn>
Message-ID: <1526615528-9707-5-git-send-email-djw@t-chip.com.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Levin Du <djw@t-chip.com.cn>

In roc-rk3328-cc board, the signal voltage of sdmmc is supplied by
the vcc_sdio regulator, which is a mux between 1.8V and 3.3V,
controlled by a special output only gpio pin labeled
"gpiomut_pmuio_iout", corresponding bit 1 of the syscon GRF_SOC_CON10.

This special pin can now be reference as <&gpio_mute 1>, thanks
to the gpio-syscon driver, which makes writing regulator-gpio possible.

If the signal voltage changes, the io domain needs to change
correspondingly.

To use this feature, the following options are required in kernel config:
 - CONFIG_GPIO_SYSCON=y
 - CONFIG_POWER_AVS=y
 - CONFIG_ROCKCHIP_IODOMAIN=y

Signed-off-by: Levin Du <djw@t-chip.com.cn>

---

Changes in v2:
- Rename gpio_syscon10 to gpio_mute in rk3328-roc-cc.dts

Changes in v1:
- Split into small patches
- Sort dts properties in sdmmc node

 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts b/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
index b983abd..e3162bb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
@@ -41,6 +41,19 @@
 		vin-supply = <&vcc_io>;
 	};
 
+	vcc_sdio: sdmmcio-regulator {
+		compatible = "regulator-gpio";
+		gpios = <&gpio_mute 1 GPIO_ACTIVE_HIGH>;
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
@@ -213,7 +226,7 @@
 
 	vccio1-supply = <&vcc_io>;
 	vccio2-supply = <&vcc18_emmc>;
-	vccio3-supply = <&vcc_io>;
+	vccio3-supply = <&vcc_sdio>;
 	vccio4-supply = <&vcc_18>;
 	vccio5-supply = <&vcc_io>;
 	vccio6-supply = <&vcc_io>;
@@ -242,7 +255,12 @@
 	max-frequency = <150000000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdmmc0_clk &sdmmc0_cmd &sdmmc0_dectn &sdmmc0_bus4>;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
 	vmmc-supply = <&vcc_sd>;
+	vqmmc-supply = <&vcc_sdio>;
 	status = "okay";
 };
 
-- 
2.7.4
