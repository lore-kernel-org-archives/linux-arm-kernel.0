From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 14 Jul 2015 15:39:47 +0200
Subject: [PATCH 12/17] ARM: dts: lpc4357-ea4357: add mmcsd
In-Reply-To: <1436881192-23930-1-git-send-email-manabian@gmail.com>
References: <1436881192-23930-1-git-send-email-manabian@gmail.com>
Message-ID: <1436881192-23930-13-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the MMC/SD controller on EA4357 devkit and add pin
muxing plus a regulator.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts | 47 +++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts b/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
index 06ba998d544f..d02f93f19bf5 100644
--- a/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
+++ b/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
@@ -34,9 +34,48 @@
 		device_type = "memory";
 		reg = <0x28000000 0x2000000>; /* 32 MB */
 	};
+
+	/* vmmc is controlled by sdmmc host internally */
+	vmmc: vmmc_fixed {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmc-supply";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
 };
 
 &pinctrl {
+	sdmmc_pins: sdmmc-pins {
+		sdmmc_clk_cfg {
+			pins = "pc_0";
+			function = "sdmmc";
+			slew-rate = <1>;
+			bias-pull-down;
+		};
+
+		sdmmc_cmd_dat0_3_cfg {
+			pins = "pc_4", "pc_5", "pc_6", "pc_7", "pc_10";
+			function = "sdmmc";
+			slew-rate = <1>;
+			bias-disable;
+			input-enable;
+			input-schmitt-disable;
+		};
+
+		sdmmc_cd_cfg {
+			pins = "pc_8";
+			function = "sdmmc";
+			bias-pull-down;
+			input-enable;
+		};
+
+		sdmmc_pow_cfg {
+			pins = "pc_9";
+			function = "sdmmc";
+			bias-pull-down;
+		};
+	};
+
 	uart0_pins: uart0-pins {
 		uart0_rx_cfg {
 			pins = "pf_11";
@@ -54,6 +93,14 @@
 	};
 };
 
+&mmcsd {
+	status = "okay";
+	bus-width = <4>;
+	vmmc-supply = <&vmmc>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc_pins>;
+};
+
 &uart0 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
1.8.0
