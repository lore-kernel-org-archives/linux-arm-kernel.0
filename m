From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Thu, 12 Feb 2015 01:55:10 +0100
Subject: [PATCH 2/5] ARM: dts: zynq: Add pinctrl to Parallella
In-Reply-To: <1423702513-4032-1-git-send-email-afaerber@suse.de>
References: <1423702513-4032-1-git-send-email-afaerber@suse.de>
Message-ID: <1423702513-4032-3-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/zynq-parallella1.dtsi | 118 ++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-parallella1.dtsi b/arch/arm/boot/dts/zynq-parallella1.dtsi
index 7c1206f928bc..e77a4968fe17 100644
--- a/arch/arm/boot/dts/zynq-parallella1.dtsi
+++ b/arch/arm/boot/dts/zynq-parallella1.dtsi
@@ -47,6 +47,8 @@
 	status = "okay";
 	phy-mode = "rgmii-id";
 	phy-handle = <&ethernet_phy>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gem0_default>;
 
 	ethernet_phy: ethernet-phy at 0 {
 		/* Marvell 88E1318 */
@@ -58,6 +60,11 @@
 	};
 };
 
+&gpio0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio0_default>;
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -85,10 +92,121 @@
 	};
 };
 
+&pinctrl0 {
+	pinctrl_gem0_default: gem0-default {
+		mux {
+			function = "ethernet0";
+			groups = "ethernet0_0_grp";
+		};
+
+		conf {
+			groups = "ethernet0_0_grp";
+			slew-rate = <0>;
+			io-standard = <1>;
+		};
+
+		conf-rx {
+			pins = "MIO22", "MIO23", "MIO24", "MIO25", "MIO26", "MIO27";
+			bias-high-impedance;
+			low-power-disable;
+		};
+
+		conf-tx {
+			pins = "MIO16", "MIO17", "MIO18", "MIO19", "MIO20", "MIO21";
+			bias-disable;
+			low-power-enable;
+		};
+
+		mux-mdio {
+			function = "mdio0";
+			groups = "mdio0_0_grp";
+		};
+
+		conf-mdio {
+			groups = "mdio0_0_grp";
+			slew-rate = <0>;
+			io-standard = <1>;
+			bias-disable;
+		};
+	};
+
+	pinctrl_gpio0_default: gpio0-default {
+		mux {
+			function = "gpio0";
+			groups = "gpio0_7_grp";
+		};
+
+		conf {
+			groups = "gpio0_7_grp";
+			slew-rate = <0>;
+			io-standard = <3>;
+		};
+
+		conf-pull-up {
+			pins = "MIO7";
+			bias-pull-up;
+		};
+	};
+
+	pinctrl_sdhci1_default: sdhci1-default {
+		mux {
+			function = "sdio1";
+			groups = "sdio1_0_grp";
+		};
+
+		conf {
+			groups = "sdio1_0_grp";
+			slew-rate = <0>;
+			io-standard = <1>;
+			bias-disable;
+		};
+
+		mux-cd {
+			function = "sdio1_cd";
+			groups = "gpio0_0_grp";
+		};
+
+		conf-cd {
+			groups = "gpio0_0_grp";
+			bias-high-impedance;
+			bias-pull-up;
+			slew-rate = <0>;
+			io-standard = <3>;
+		};
+	};
+
+	pinctrl_uart1_default: uart1-default {
+		mux {
+			function = "uart1";
+			groups = "uart1_0_grp";
+		};
+
+		conf {
+			groups = "uart1_0_grp";
+			slew-rate = <0>;
+			io-standard = <3>;
+		};
+
+		conf-rx {
+			pins = "MIO9";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO8";
+			bias-disable = <0>;
+		};
+	};
+};
+
 &sdhci1 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdhci1_default>;
 };
 
 &uart1 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1_default>;
 };
-- 
2.2.2
