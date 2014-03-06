From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Mar 2014 13:44:35 +0900
Subject: [PATCH 7/7] ARM: shmobile: Add SDHI devices for Koelsch DTS
In-Reply-To: <cover.1394080829.git.horms+renesas@verge.net.au>
References: <cover.1394080829.git.horms+renesas@verge.net.au>
Message-ID: <2c60a7df72711fb8b4be1e6aa651ab166a8931bc.1394080829.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add DT support for SDHI0, SDHI1 and SDHI2 on Koelsch.

The board specific handling of CD and WP pins are
using GPIOs. SDHI0 and SDHI1 are hooked up to regular
SD connectors while SDHI2 is using micro-SD which
is lacking WP signal.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 119 ++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 603af8c..bdd73e6 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -103,6 +103,78 @@
 			gpios = <&gpio2 21 GPIO_ACTIVE_HIGH>;
 		};
 	};
+
+	vcc_sdhi0: regulator at 0 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "SDHI0 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&gpio7 17 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vccq_sdhi0: regulator at 1 {
+		compatible = "regulator-gpio";
+
+		regulator-name = "SDHI0 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpios = <&gpio2 12 GPIO_ACTIVE_HIGH>;
+		gpios-states = <1>;
+		states = <3300000 1
+			  1800000 0>;
+	};
+
+	vcc_sdhi1: regulator at 2 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "SDHI1 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&gpio7 18 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vccq_sdhi1: regulator at 3 {
+		compatible = "regulator-gpio";
+
+		regulator-name = "SDHI1 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpios = <&gpio2 13 GPIO_ACTIVE_HIGH>;
+		gpios-states = <1>;
+		states = <3300000 1
+			  1800000 0>;
+	};
+
+	vcc_sdhi2: regulator at 4 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "SDHI2 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&gpio7 19 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vccq_sdhi2: regulator at 5 {
+		compatible = "regulator-gpio";
+
+		regulator-name = "SDHI2 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpios = <&gpio2 26 GPIO_ACTIVE_HIGH>;
+		gpios-states = <1>;
+		states = <3300000 1
+			  1800000 0>;
+	};
 };
 
 &extal_clk {
@@ -157,6 +229,21 @@
 		renesas,function = "intc";
 	};
 
+	sdhi0_pins: sd0 {
+		renesas,gpios = "sdhi0_data4", "sdhi0_ctrl";
+		renesas,function = "sdhi0";
+	};
+
+	sdhi1_pins: sd1 {
+		renesas,gpios = "sdhi1_data4", "sdhi1_ctrl";
+		renesas,function = "sdhi1";
+	};
+
+	sdhi2_pins: sd2 {
+		renesas,gpios = "sdhi2_data4", "sdhi2_ctrl";
+		renesas,function = "sdhi2";
+	};
+
 	qspi_pins: spi {
 		renesas,groups = "qspi_ctrl", "qspi_data4";
 		renesas,function = "qspi";
@@ -182,6 +269,38 @@
 	status = "okay";
 };
 
+&sdhi0 {
+	pinctrl-0 = <&sdhi0_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&vcc_sdhi0>;
+	vqmmc-supply = <&vccq_sdhi0>;
+	cd-gpios = <&gpio6 6 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio6 7 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&sdhi1 {
+	pinctrl-0 = <&sdhi1_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&vcc_sdhi1>;
+	vqmmc-supply = <&vccq_sdhi1>;
+	cd-gpios = <&gpio6 14 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio6 15 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&sdhi2 {
+	pinctrl-0 = <&sdhi2_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&vcc_sdhi2>;
+	vqmmc-supply = <&vccq_sdhi2>;
+	cd-gpios = <&gpio6 22 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
 &spi {
 	pinctrl-0 = <&qspi_pins>;
 	pinctrl-names = "default";
-- 
1.8.5.2
