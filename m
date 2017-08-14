From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 14 Aug 2017 12:49:49 +0100
Subject: [PATCH  3/3] ARM: dts: iwg20d-q7: Add SDHI1 support
In-Reply-To: <1502711389-16040-1-git-send-email-biju.das@bp.renesas.com>
References: <1502711389-16040-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1502711389-16040-4-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the iWave RainboW-G20D-Qseven board dependent part of the
SDHI1 device node.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7743-iwg20d-q7.dts | 48 +++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts b/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
index b3a1efa..b5ac0ff 100644
--- a/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
+++ b/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
@@ -19,6 +19,29 @@
 		serial0 = &scif0;
 		ethernet0 = &avb;
 	};
+
+	vcc_sdhi1: regulator-vcc-sdhi1 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "SDHI1 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&gpio1 16 GPIO_ACTIVE_LOW>;
+	};
+
+	vccq_sdhi1: regulator-vccq-sdhi1 {
+		compatible = "regulator-gpio";
+
+		regulator-name = "SDHI1 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpios = <&gpio2 30 GPIO_ACTIVE_LOW>;
+		gpios-states = <1>;
+		states = <3300000 1
+			  1800000 0>;
+	};
 };
 
 &pfc {
@@ -36,6 +59,18 @@
 		groups = "i2c2";
 		function = "i2c2";
 	};
+
+	sdhi1_pins: sd1 {
+		groups = "sdhi1_data4", "sdhi1_ctrl";
+		function = "sdhi1";
+		power-source = <3300>;
+	};
+
+	sdhi1_pins_uhs: sd1_uhs {
+		groups = "sdhi1_data4", "sdhi1_ctrl";
+		function = "sdhi1";
+		power-source = <1800>;
+	};
 };
 
 &scif0 {
@@ -72,3 +107,16 @@
 		reg = <0x68>;
 	};
 };
+
+&sdhi1 {
+	pinctrl-0 = <&sdhi1_pins>;
+	pinctrl-1 = <&sdhi1_pins_uhs>;
+	pinctrl-names = "default", "state_uhs";
+
+	vmmc-supply = <&vcc_sdhi1>;
+	vqmmc-supply = <&vccq_sdhi1>;
+	cd-gpios = <&gpio6 14 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio6 15 GPIO_ACTIVE_HIGH>;
+	sd-uhs-sdr50;
+	status = "okay";
+};
-- 
1.9.1
