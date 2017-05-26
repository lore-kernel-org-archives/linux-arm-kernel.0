From: eddie.cai.linux@gmail.com (Eddie Cai)
Date: Fri, 26 May 2017 13:52:46 +0800
Subject: [PATCH] ARM: dts: rockchip:add sd card support
Message-ID: <1495777966-26212-1-git-send-email-eddie.cai.linux@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

firefly reload board not support sd card yet. so support it.

Signed-off-by: Eddie Cai <eddie.cai.linux@gmail.com>
---
 arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi | 31 +++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi b/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
index 413b61f..2f41209 100644
--- a/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
@@ -57,6 +57,17 @@
 		clock-output-names = "ext_gmac";
 	};
 
+	vcc_sd: sdmmc-regulator {
+		compatible = "regulator-fixed";
+		gpio = <&gpio7 RK_PB3 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdmmc_pwr>;
+		regulator-name = "vcc_sd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <100000>;
+		vin-supply = <&vcc_io>;
+	};
 
 	vcc_flash: flash-regulator {
 		compatible = "regulator-fixed";
@@ -281,6 +292,26 @@
 			rockchip,pins = <4 8 RK_FUNC_GPIO &pcfg_output_high>;
 		};
 	};
+
+	sdmmc {
+		sdmmc_pwr: sdmmc-pwr {
+			rockchip,pins = <7 11 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&sdmmc {
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	card-detect-delay = <200>;
+	disable-wp;
+	num-slots = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc_clk>, <&sdmmc_cmd>, <&sdmmc_cd>, <&sdmmc_bus4>;
+	vmmc-supply = <&vcc_sd>;
+	vqmmc-supply = <&vccio_sd>;
+	status = "okay";
 };
 
 &tsadc {
-- 
1.9.1
