From: jagan@amarulasolutions.com (Jagan Teki)
Date: Wed, 25 Apr 2018 23:09:31 +0530
Subject: [PATCH 3/4] ARM: dts: i.MX6: imx6dl-mamoj: Add Wifi support
In-Reply-To: <20180425173932.7213-1-jagan@amarulasolutions.com>
References: <20180425173932.7213-1-jagan@amarulasolutions.com>
Message-ID: <20180425173932.7213-3-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add TI WL18XX Wifi for BTicino i.MX6DL board.

Signed-off-by: Simone CIANNI <simone.cianni@bticino.it>
Signed-off-by: Raffaele RECALCATI <raffaele.recalcati@bticino.it>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/imx6dl-mamoj.dts | 53 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-mamoj.dts b/arch/arm/boot/dts/imx6dl-mamoj.dts
index ed9050c5dbcc..5034b086035f 100644
--- a/arch/arm/boot/dts/imx6dl-mamoj.dts
+++ b/arch/arm/boot/dts/imx6dl-mamoj.dts
@@ -133,6 +133,18 @@
 		enable-active-high;
 		vin-supply = <&reg_lcd_vgl>;
 	};
+
+	reg_wl18xx_vmmc:  regulator-wl18xx-vmcc {
+		compatible = "regulator-fixed";
+		regulator-name = "vwl1807";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_wlan>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&gpio6 21 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <70000>;
+		enable-active-high;
+	};
 };
 
 &fec {
@@ -285,6 +297,30 @@
 	status = "okay";
 };
 
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	bus-width = <4>;
+	vmmc-supply = <&reg_wl18xx_vmmc>;
+	no-1-8-v;
+	non-removable;
+	wakeup-source;
+	keep-power-in-suspend;
+	cap-power-off-card;
+	max-frequency = <25000000>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	wlcore: wlcore at 2 {
+		compatible = "ti,wl1837";
+		reg = <2>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <23 IRQ_TYPE_LEVEL_HIGH>;
+		tcxo-clock-frequency = <26000000>;
+	};
+};
+
 &usdhc3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc3>;
@@ -392,6 +428,17 @@
 		>;
 	};
 
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD1_CMD__SD1_CMD    0x17069
+			MX6QDL_PAD_SD1_CLK__SD1_CLK    0x10079
+			MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x17069
+			MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x17069
+			MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x17069
+			MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17069
+		>;
+	};
+
 	pinctrl_usdhc3: usdhc3grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD3_CMD__SD3_CMD	0x17059
@@ -406,4 +453,10 @@
 			MX6QDL_PAD_SD3_DAT7__SD3_DATA7	0x17059
 		>;
 	};
+
+	pinctrl_wlan: wlan {
+		fsl,pins = <
+			MX6QDL_PAD_RGMII_TD1__GPIO6_IO21	0x4001b0b0
+		>;
+	};
 };
-- 
2.14.3
