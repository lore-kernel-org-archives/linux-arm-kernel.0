From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue,  6 Nov 2018 21:46:47 +0100
Subject: [PATCH V3] arm64: dts: r8a77990: ebisu: Add and enable SDHI device
 nodes
Message-ID: <20181106204647.18051-1-marek.vasut+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch adds SDHI{0,1,3} device nodes for the r8a77990 SoC
and enables SD card slot connected to SDHI0, micro SD card slot
connected to SDHI1 and eMMC connected to SDHI3 on the Ebisu board
using the R8A77990 SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-renesas-soc at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
V2: - Deduplicated regular and UHS pins
    - Added sdhi3_ds pin pinmux
V3: - Squash two patches, one adding SDHI nodes to R8A77990 E3 DTSI
      and another enabling them on E3 Ebisu, together.
---
 .../arm64/boot/dts/renesas/r8a77990-ebisu.dts | 130 ++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a77990.dtsi     |  36 +++++
 2 files changed, 166 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
index 0b5aead76077..306b35f0f541 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
@@ -129,6 +129,15 @@
 		};
 	};
 
+	reg_1p8v: regulator0 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
 	reg_3p3v: regulator1 {
 		compatible = "regulator-fixed";
 		regulator-name = "fixed-3.3V";
@@ -180,6 +189,54 @@
 		#clock-cells = <0>;
 		clock-frequency = <74250000>;
 	};
+
+	vcc_sdhi0: regulator-vcc-sdhi0 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "SDHI0 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&gpio5 17 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vccq_sdhi0: regulator-vccq-sdhi0 {
+		compatible = "regulator-gpio";
+
+		regulator-name = "SDHI0 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpios = <&gpio5 18 GPIO_ACTIVE_HIGH>;
+		gpios-states = <1>;
+		states = <3300000 1
+			  1800000 0>;
+	};
+
+	vcc_sdhi1: regulator-vcc-sdhi1 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "SDHI1 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&gpio0 4 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vccq_sdhi1: regulator-vccq-sdhi1 {
+		compatible = "regulator-gpio";
+
+		regulator-name = "SDHI1 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpios = <&gpio3 15 GPIO_ACTIVE_HIGH>;
+		gpios-states = <1>;
+		states = <3300000 1
+			  1800000 0>;
+	};
 };
 
 &audio_clk_a {
@@ -415,6 +472,36 @@
 		function = "scif2";
 	};
 
+	sdhi0_pins: sd0 {
+		groups = "sdhi0_data4", "sdhi0_ctrl";
+		function = "sdhi0";
+		power-source = <3300>;
+	};
+
+	sdhi0_pins_uhs: sd0_uhs {
+		groups = "sdhi0_data4", "sdhi0_ctrl";
+		function = "sdhi0";
+		power-source = <1800>;
+	};
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
+
+	sdhi3_pins: sd3 {
+		groups = "sdhi3_data8", "sdhi3_ctrl", "sdhi3_ds";
+		function = "sdhi3";
+		power-source = <1800>;
+	};
+
 	sound_pins: sound {
 		groups = "ssi01239_ctrl", "ssi0_data", "ssi1_data";
 		function = "ssi";
@@ -531,3 +618,46 @@
 
 	status = "okay";
 };
+
+&sdhi0 {
+	pinctrl-0 = <&sdhi0_pins>;
+	pinctrl-1 = <&sdhi0_pins_uhs>;
+	pinctrl-names = "default", "state_uhs";
+
+	vmmc-supply = <&vcc_sdhi0>;
+	vqmmc-supply = <&vccq_sdhi0>;
+	cd-gpios = <&gpio3 12 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio3 13 GPIO_ACTIVE_HIGH>;
+	bus-width = <4>;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	status = "okay";
+};
+
+&sdhi1 {
+	pinctrl-0 = <&sdhi1_pins>;
+	pinctrl-1 = <&sdhi1_pins_uhs>;
+	pinctrl-names = "default", "state_uhs";
+
+	vmmc-supply = <&vcc_sdhi1>;
+	vqmmc-supply = <&vccq_sdhi1>;
+	cd-gpios = <&gpio3 14 GPIO_ACTIVE_LOW>;
+	bus-width = <4>;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	status = "okay";
+};
+
+&sdhi3 {
+	/* used for on-board 8bit eMMC */
+	pinctrl-0 = <&sdhi3_pins>;
+	pinctrl-1 = <&sdhi3_pins>;
+	pinctrl-names = "default", "state_uhs";
+
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_1p8v>;
+	mmc-hs200-1_8v;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/renesas/r8a77990.dtsi b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
index beb53aaa9e2c..e0092fb27ec0 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
@@ -1351,6 +1351,42 @@
 			status = "disabled";
 		};
 
+		sdhi0: sd at ee100000 {
+			compatible = "renesas,sdhi-r8a77990",
+				     "renesas,rcar-gen3-sdhi";
+			reg = <0 0xee100000 0 0x2000>;
+			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 314>;
+			max-frequency = <200000000>;
+			power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
+			resets = <&cpg 314>;
+			status = "disabled";
+		};
+
+		sdhi1: sd at ee120000 {
+			compatible = "renesas,sdhi-r8a77990",
+				     "renesas,rcar-gen3-sdhi";
+			reg = <0 0xee120000 0 0x2000>;
+			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 313>;
+			max-frequency = <200000000>;
+			power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
+			resets = <&cpg 313>;
+			status = "disabled";
+		};
+
+		sdhi3: sd at ee160000 {
+			compatible = "renesas,sdhi-r8a77990",
+				     "renesas,rcar-gen3-sdhi";
+			reg = <0 0xee160000 0 0x2000>;
+			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 311>;
+			max-frequency = <200000000>;
+			power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
+			resets = <&cpg 311>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller at f1010000 {
 			compatible = "arm,gic-400";
 			#interrupt-cells = <3>;
-- 
2.18.0
