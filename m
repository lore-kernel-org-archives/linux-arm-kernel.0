From: dianders@chromium.org (Doug Anderson)
Date: Wed, 11 Mar 2015 15:15:17 -0700
Subject: [PATCH v4 4/4] ARM: dts: Specify VMMC and VQMMC on rk3288-evb
In-Reply-To: <1426112117-18220-1-git-send-email-dianders@chromium.org>
References: <1426112117-18220-1-git-send-email-dianders@chromium.org>
Message-ID: <1426112117-18220-4-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Specifying these rails should eventually let us do UHS.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
Changes in v4:
- Add vcc_sd regulator which is present on EVB 2.0 boards

Changes in v3: None
Changes in v2:
- Fix subject line

 arch/arm/boot/dts/rk3288-evb.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index 5e895a5..6d4ae9f 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -103,6 +103,23 @@
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	/*
+	 * NOTE: vcc_sd isn't hooked up on v1.0 boards where power comes from
+	 * vcc_io directly.  Those boards won't be able to power cycle SD cards
+	 * but it shouldn't hurt to toggle this pin there anyway.
+	 */
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
 };
 
 &emmc {
@@ -132,6 +149,8 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
 	status = "okay";
+	vmmc-supply = <&vcc_sd>;
+	vqmmc-supply = <&vccio_sd>;
 };
 
 &i2c0 {
@@ -223,6 +242,10 @@
 		sdmmc_cmd: sdmmc-cmd {
 			rockchip,pins = <6 21 RK_FUNC_1 &pcfg_pull_up_drv_8ma>;
 		};
+
+		sdmmc_pwr: sdmmc-pwr {
+			rockchip,pins = <7 11 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
 	};
 
 	usb {
-- 
2.2.0.rc0.207.ga3a616c
