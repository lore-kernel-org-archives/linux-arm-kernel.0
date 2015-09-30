From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 30 Sep 2015 21:17:47 +0200
Subject: [PATCH 2/5] ARM: dts: rockchip: add rk3288-popmemtal mmc supplies
In-Reply-To: <1443640670-21104-1-git-send-email-heiko@sntech.de>
References: <1443640670-21104-1-git-send-email-heiko@sntech.de>
Message-ID: <1443640670-21104-3-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing regulators and supply properties to emmc and sdmmc nodes.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288-popmetal.dts | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-popmetal.dts b/arch/arm/boot/dts/rk3288-popmetal.dts
index f82b956..b677611 100644
--- a/arch/arm/boot/dts/rk3288-popmetal.dts
+++ b/arch/arm/boot/dts/rk3288-popmetal.dts
@@ -86,6 +86,26 @@
 		pinctrl-0 = <&ir_int>;
 	};
 
+	vcc_flash: flash-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_flash";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_io>;
+	};
+
+	vcc_sd: sdmmc-regulator {
+		compatible = "regulator-fixed";
+		gpio = <&gpio7 11 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdmmc_pwr>;
+		regulator-name = "vcc_sd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <100000>;
+		vin-supply = <&vcc_io>;
+	};
+
 	vcc_sys: vsys-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
@@ -109,6 +129,8 @@
 	num-slots = <1>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_pwr &emmc_bus8>;
+	vmmc-supply = <&vcc_io>;
+	vqmmc-supply = <&vcc_flash>;
 	status = "okay";
 };
 
@@ -121,6 +143,8 @@
 	num-slots = <1>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
+	vmmc-supply = <&vcc_sd>;
+	vqmmc-supply = <&vccio_sd>;
 	status = "okay";
 };
 
@@ -405,6 +429,12 @@
 			rockchip,pins = <RK_GPIO0 4 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
+
+	sdmmc {
+		sdmmc_pwr: sdmmc-pwr {
+			rockchip,pins = <7 11 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
 
 &tsadc {
-- 
2.5.3
