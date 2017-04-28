From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 28 Apr 2017 14:58:43 +0200
Subject: [PATCH v2 4/5] arm64: dts: renesas: Extract common Salvator-X board
 support
In-Reply-To: <1493384324-29344-1-git-send-email-geert+renesas@glider.be>
References: <1493384324-29344-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1493384324-29344-5-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Renesas Salvator-X development board can be equipped with either an
R-Car H3 or M3-W SiP, which are pin-compatible.  Both boards use
different DTBs.

Reduce duplication by extracting common Salvator-X board support into
its own .dtsi file.  References to SoC-specific clocks are handled
through cpp definitions.  Sort device nodes while at it.

For boards with an R-Car H3 SiP, there are no functional changes.

For boards with an R-Car M3-W SiP, the following new devices are now
described in DT:
  - External audio, CAN, and PCIe clocks,
  - USB Vbus regulator,
  - CS2000 clock generator,
  - AK4613 Audio Codec,
  - VGA.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Drop RFC state,
  - Remove forgotten amixer help from r8a7795-salvator-x.dts,
  - Rebased.
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 543 +--------------------
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts | 259 +---------
 .../{r8a7795-salvator-x.dts => salvator-x.dtsi}    | 393 +++++++--------
 3 files changed, 182 insertions(+), 1013 deletions(-)
 copy arch/arm64/boot/dts/renesas/{r8a7795-salvator-x.dts => salvator-x.dtsi} (91%)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index ff68bac4cd7ed2f5..52fce67df3413f1f 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -8,48 +8,16 @@
  * kind, whether express or implied.
  */
 
-/*
- * SSI-AK4613
- *
- * This command is required when Playback/Capture
- *
- *	amixer set "DVC Out" 100%
- *	amixer set "DVC In" 100%
- *
- * You can use Mute
- *
- *	amixer set "DVC Out Mute" on
- *	amixer set "DVC In Mute" on
- *
- * You can use Volume Ramp
- *
- *	amixer set "DVC Out Ramp Up Rate"   "0.125 dB/64 steps"
- *	amixer set "DVC Out Ramp Down Rate" "0.125 dB/512 steps"
- *	amixer set "DVC Out Ramp" on
- *	aplay xxx.wav &
- *	amixer set "DVC Out"  80%  // Volume Down
- *	amixer set "DVC Out" 100%  // Volume Up
- */
+#define CPG_AUDIO_CLK_I		R8A7795_CLK_S0D4
 
 /dts-v1/;
 #include "r8a7795.dtsi"
-#include <dt-bindings/gpio/gpio.h>
+#include "salvator-x.dtsi"
 
 / {
 	model = "Renesas Salvator-X board based on r8a7795";
 	compatible = "renesas,salvator-x", "renesas,r8a7795";
 
-	aliases {
-		serial0 = &scif2;
-		serial1 = &scif1;
-		ethernet0 = &avb;
-	};
-
-	chosen {
-		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
-		stdout-path = "serial0:115200n8";
-	};
-
 	memory at 48000000 {
 		device_type = "memory";
 		/* first 128MB is reserved for secure area. */
@@ -70,531 +38,30 @@
 		device_type = "memory";
 		reg = <0x7 0x00000000 0x0 0x40000000>;
 	};
-
-	x12_clk: x12 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <24576000>;
-	};
-
-	reg_1p8v: regulator0 {
-		compatible = "regulator-fixed";
-		regulator-name = "fixed-1.8V";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-boot-on;
-		regulator-always-on;
-	};
-
-	reg_3p3v: regulator1 {
-		compatible = "regulator-fixed";
-		regulator-name = "fixed-3.3V";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-boot-on;
-		regulator-always-on;
-	};
-
-	vcc_sdhi0: regulator-vcc-sdhi0 {
-		compatible = "regulator-fixed";
-
-		regulator-name = "SDHI0 Vcc";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-
-		gpio = <&gpio5 2 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	vccq_sdhi0: regulator-vccq-sdhi0 {
-		compatible = "regulator-gpio";
-
-		regulator-name = "SDHI0 VccQ";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-
-		gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
-		gpios-states = <1>;
-		states = <3300000 1
-			  1800000 0>;
-	};
-
-	vcc_sdhi3: regulator-vcc-sdhi3 {
-		compatible = "regulator-fixed";
-
-		regulator-name = "SDHI3 Vcc";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-
-		gpio = <&gpio3 15 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	vccq_sdhi3: regulator-vccq-sdhi3 {
-		compatible = "regulator-gpio";
-
-		regulator-name = "SDHI3 VccQ";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-
-		gpios = <&gpio3 14 GPIO_ACTIVE_HIGH>;
-		gpios-states = <1>;
-		states = <3300000 1
-			  1800000 0>;
-	};
-
-	vbus0_usb2: regulator-vbus0-usb2 {
-		compatible = "regulator-fixed";
-
-		regulator-name = "USB20_VBUS0";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-
-		gpio = <&gpio6 16 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	audio_clkout: audio_clkout {
-		/*
-		 * This is same as <&rcar_sound 0>
-		 * but needed to avoid cs2000/rcar_sound probe dead-lock
-		 */
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <11289600>;
-	};
-
-	rsnd_ak4613: sound {
-		compatible = "simple-audio-card";
-
-		simple-audio-card,format = "left_j";
-		simple-audio-card,bitclock-master = <&sndcpu>;
-		simple-audio-card,frame-master = <&sndcpu>;
-
-		sndcpu: simple-audio-card,cpu {
-			sound-dai = <&rcar_sound>;
-		};
-
-		sndcodec: simple-audio-card,codec {
-			sound-dai = <&ak4613>;
-		};
-	};
-
-	vga-encoder {
-		compatible = "adi,adv7123";
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port at 0 {
-				reg = <0>;
-				adv7123_in: endpoint {
-					remote-endpoint = <&du_out_rgb>;
-				};
-			};
-			port at 1 {
-				reg = <1>;
-				adv7123_out: endpoint {
-					remote-endpoint = <&vga_in>;
-				};
-			};
-		};
-	};
-
-	vga {
-		compatible = "vga-connector";
-
-		port {
-			vga_in: endpoint {
-				remote-endpoint = <&adv7123_out>;
-			};
-		};
-	};
 };
 
-&du {
-	pinctrl-0 = <&du_pins>;
-	pinctrl-names = "default";
+&ehci2 {
 	status = "okay";
-
-	ports {
-		port at 0 {
-			endpoint {
-				remote-endpoint = <&adv7123_in>;
-			};
-		};
-		port at 3 {
-			lvds_connector: endpoint {
-			};
-		};
-	};
-};
-
-&extal_clk {
-	clock-frequency = <16666666>;
 };
 
-&extalr_clk {
-	clock-frequency = <32768>;
+&ohci2 {
+	status = "okay";
 };
 
 &pfc {
-	pinctrl-0 = <&scif_clk_pins>;
-	pinctrl-names = "default";
-
-	scif1_pins: scif1 {
-		groups = "scif1_data_a", "scif1_ctrl";
-		function = "scif1";
-	};
-	scif2_pins: scif2 {
-		groups = "scif2_data_a";
-		function = "scif2";
-	};
-	scif_clk_pins: scif_clk {
-		groups = "scif_clk_a";
-		function = "scif_clk";
-	};
-
-	i2c2_pins: i2c2 {
-		groups = "i2c2_a";
-		function = "i2c2";
-	};
-
-	avb_pins: avb {
-		mux {
-			groups = "avb_link", "avb_phy_int", "avb_mdc",
-				 "avb_mii";
-			function = "avb";
-		};
-
-		pins_mdc {
-			groups = "avb_mdc";
-			drive-strength = <24>;
-		};
-
-		pins_mii_tx {
-			pins = "PIN_AVB_TX_CTL", "PIN_AVB_TXC", "PIN_AVB_TD0",
-			       "PIN_AVB_TD1", "PIN_AVB_TD2", "PIN_AVB_TD3";
-			drive-strength = <12>;
-		};
-	};
-
-	du_pins: du {
-		groups = "du_rgb888", "du_sync", "du_oddf", "du_clk_out_0";
-		function = "du";
-	};
-
-	sdhi0_pins: sd0 {
-		groups = "sdhi0_data4", "sdhi0_ctrl";
-		function = "sdhi0";
-		power-source = <3300>;
-	};
-
-	sdhi0_pins_uhs: sd0_uhs {
-		groups = "sdhi0_data4", "sdhi0_ctrl";
-		function = "sdhi0";
-		power-source = <1800>;
-	};
-
-	sdhi2_pins: sd2 {
-		groups = "sdhi2_data8", "sdhi2_ctrl";
-		function = "sdhi2";
-		power-source = <3300>;
-	};
-
-	sdhi2_pins_uhs: sd2_uhs {
-		groups = "sdhi2_data8", "sdhi2_ctrl";
-		function = "sdhi2";
-		power-source = <1800>;
-	};
-
-	sdhi3_pins: sd3 {
-		groups = "sdhi3_data4", "sdhi3_ctrl";
-		function = "sdhi3";
-		power-source = <3300>;
-	};
-
-	sdhi3_pins_uhs: sd3_uhs {
-		groups = "sdhi3_data4", "sdhi3_ctrl";
-		function = "sdhi3";
-		power-source = <1800>;
-	};
-
-	sound_pins: sound {
-		groups = "ssi01239_ctrl", "ssi0_data", "ssi1_data_a";
-		function = "ssi";
-	};
-
-	sound_clk_pins: sound_clk {
-		groups = "audio_clk_a_a", "audio_clk_b_a", "audio_clk_c_a",
-			 "audio_clkout_a", "audio_clkout3_a";
-		function = "audio_clk";
-	};
-
-	usb0_pins: usb0 {
-		groups = "usb0";
-		function = "usb0";
-	};
-
-	usb1_pins: usb1 {
-		mux {
-			groups = "usb1";
-			function = "usb1";
-		};
-
-		ovc {
-			pins = "GP_6_27";
-			bias-pull-up;
-		};
-
-		pwen {
-			pins = "GP_6_26";
-			bias-pull-down;
-		};
-	};
-
 	usb2_pins: usb2 {
 		groups = "usb2";
 		function = "usb2";
 	};
 };
 
-&scif1 {
-	pinctrl-0 = <&scif1_pins>;
-	pinctrl-names = "default";
-
-	uart-has-rtscts;
-	status = "okay";
-};
-
-&scif2 {
-	pinctrl-0 = <&scif2_pins>;
-	pinctrl-names = "default";
-
-	status = "okay";
-};
-
-&scif_clk {
-	clock-frequency = <14745600>;
-};
-
-&i2c2 {
-	pinctrl-0 = <&i2c2_pins>;
-	pinctrl-names = "default";
-
-	status = "okay";
-
-	clock-frequency = <100000>;
-
-	ak4613: codec at 10 {
-		compatible = "asahi-kasei,ak4613";
-		#sound-dai-cells = <0>;
-		reg = <0x10>;
-		clocks = <&rcar_sound 3>;
-
-		asahi-kasei,in1-single-end;
-		asahi-kasei,in2-single-end;
-		asahi-kasei,out1-single-end;
-		asahi-kasei,out2-single-end;
-		asahi-kasei,out3-single-end;
-		asahi-kasei,out4-single-end;
-		asahi-kasei,out5-single-end;
-		asahi-kasei,out6-single-end;
-	};
-
-	cs2000: clk_multiplier at 4f {
-		#clock-cells = <0>;
-		compatible = "cirrus,cs2000-cp";
-		reg = <0x4f>;
-		clocks = <&audio_clkout>, <&x12_clk>;
-		clock-names = "clk_in", "ref_clk";
-
-		assigned-clocks = <&cs2000>;
-		assigned-clock-rates = <24576000>; /* 1/1 divide */
-	};
-};
-
-&rcar_sound {
-	pinctrl-0 = <&sound_pins &sound_clk_pins>;
-	pinctrl-names = "default";
-
-	/* Single DAI */
-	#sound-dai-cells = <0>;
-
-	/* audio_clkout0/1/2/3 */
-	#clock-cells = <1>;
-	clock-frequency = <11289600>;
-
-	status = "okay";
-
-	/* update <audio_clk_b> to <cs2000> */
-	clocks = <&cpg CPG_MOD 1005>,
-		 <&cpg CPG_MOD 1006>, <&cpg CPG_MOD 1007>,
-		 <&cpg CPG_MOD 1008>, <&cpg CPG_MOD 1009>,
-		 <&cpg CPG_MOD 1010>, <&cpg CPG_MOD 1011>,
-		 <&cpg CPG_MOD 1012>, <&cpg CPG_MOD 1013>,
-		 <&cpg CPG_MOD 1014>, <&cpg CPG_MOD 1015>,
-		 <&cpg CPG_MOD 1022>, <&cpg CPG_MOD 1023>,
-		 <&cpg CPG_MOD 1024>, <&cpg CPG_MOD 1025>,
-		 <&cpg CPG_MOD 1026>, <&cpg CPG_MOD 1027>,
-		 <&cpg CPG_MOD 1028>, <&cpg CPG_MOD 1029>,
-		 <&cpg CPG_MOD 1030>, <&cpg CPG_MOD 1031>,
-		 <&cpg CPG_MOD 1020>, <&cpg CPG_MOD 1021>,
-		 <&cpg CPG_MOD 1020>, <&cpg CPG_MOD 1021>,
-		 <&cpg CPG_MOD 1019>, <&cpg CPG_MOD 1018>,
-		 <&audio_clk_a>, <&cs2000>,
-		 <&audio_clk_c>,
-		 <&cpg CPG_CORE R8A7795_CLK_S0D4>;
-
-	rcar_sound,dai {
-		dai0 {
-			playback = <&ssi0 &src0 &dvc0>;
-			capture  = <&ssi1 &src1 &dvc1>;
-		};
-	};
-};
-
 &sata {
 	status = "okay";
 };
 
-&sdhi0 {
-	pinctrl-0 = <&sdhi0_pins>;
-	pinctrl-1 = <&sdhi0_pins_uhs>;
-	pinctrl-names = "default", "state_uhs";
-
-	vmmc-supply = <&vcc_sdhi0>;
-	vqmmc-supply = <&vccq_sdhi0>;
-	cd-gpios = <&gpio3 12 GPIO_ACTIVE_LOW>;
-	wp-gpios = <&gpio3 13 GPIO_ACTIVE_HIGH>;
-	bus-width = <4>;
-	sd-uhs-sdr50;
-	status = "okay";
-};
-
-&sdhi2 {
-	/* used for on-board 8bit eMMC */
-	pinctrl-0 = <&sdhi2_pins>;
-	pinctrl-1 = <&sdhi2_pins_uhs>;
-	pinctrl-names = "default", "state_uhs";
-
-	vmmc-supply = <&reg_3p3v>;
-	vqmmc-supply = <&reg_1p8v>;
-	bus-width = <8>;
-	mmc-hs200-1_8v;
-	non-removable;
-	status = "okay";
-};
-
-&sdhi3 {
-	pinctrl-0 = <&sdhi3_pins>;
-	pinctrl-1 = <&sdhi3_pins_uhs>;
-	pinctrl-names = "default", "state_uhs";
-
-	vmmc-supply = <&vcc_sdhi3>;
-	vqmmc-supply = <&vccq_sdhi3>;
-	cd-gpios = <&gpio4 15 GPIO_ACTIVE_LOW>;
-	wp-gpios = <&gpio4 16 GPIO_ACTIVE_HIGH>;
-	bus-width = <4>;
-	sd-uhs-sdr50;
-	status = "okay";
-};
-
-&ssi1 {
-	shared-pin;
-};
-
-&wdt0 {
-	timeout-sec = <60>;
-	status = "okay";
-};
-
-&audio_clk_a {
-	clock-frequency = <22579200>;
-};
-
-&i2c_dvfs {
-	status = "okay";
-};
-
-&avb {
-	pinctrl-0 = <&avb_pins>;
-	pinctrl-names = "default";
-	renesas,no-ether-link;
-	phy-handle = <&phy0>;
-	status = "okay";
-
-	phy0: ethernet-phy at 0 {
-		rxc-skew-ps = <1500>;
-		reg = <0>;
-		interrupt-parent = <&gpio2>;
-		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
-	};
-};
-
-&xhci0 {
-	status = "okay";
-};
-
-&usb2_phy0 {
-	pinctrl-0 = <&usb0_pins>;
-	pinctrl-names = "default";
-
-	vbus-supply = <&vbus0_usb2>;
-	status = "okay";
-};
-
-&usb2_phy1 {
-	pinctrl-0 = <&usb1_pins>;
-	pinctrl-names = "default";
-
-	status = "okay";
-};
-
 &usb2_phy2 {
 	pinctrl-0 = <&usb2_pins>;
 	pinctrl-names = "default";
 
 	status = "okay";
 };
-
-&ehci0 {
-	status = "okay";
-};
-
-&ehci1 {
-	status = "okay";
-};
-
-&ehci2 {
-	status = "okay";
-};
-
-&ohci0 {
-	status = "okay";
-};
-
-&ohci1 {
-	status = "okay";
-};
-
-&ohci2 {
-	status = "okay";
-};
-
-&hsusb {
-	status = "okay";
-};
-
-&pcie_bus_clk {
-	clock-frequency = <100000000>;
-};
-
-&pciec0 {
-	status = "okay";
-};
-
-&pciec1 {
-	status = "okay";
-};
diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
index 31f02219ed2fb18a..db4f162d6bdd2c42 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
@@ -8,25 +8,16 @@
  * kind, whether express or implied.
  */
 
+#define CPG_AUDIO_CLK_I		R8A7796_CLK_S0D4
+
 /dts-v1/;
 #include "r8a7796.dtsi"
-#include <dt-bindings/gpio/gpio.h>
+#include "salvator-x.dtsi"
 
 / {
 	model = "Renesas Salvator-X board based on r8a7796";
 	compatible = "renesas,salvator-x", "renesas,r8a7796";
 
-	aliases {
-		serial0 = &scif2;
-		serial1 = &scif1;
-		ethernet0 = &avb;
-	};
-
-	chosen {
-		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
-		stdout-path = "serial0:115200n8";
-	};
-
 	memory at 48000000 {
 		device_type = "memory";
 		/* first 128MB is reserved for secure area. */
@@ -37,248 +28,4 @@
 		device_type = "memory";
 		reg = <0x6 0x00000000 0x0 0x80000000>;
 	};
-
-	reg_1p8v: regulator0 {
-		compatible = "regulator-fixed";
-		regulator-name = "fixed-1.8V";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-boot-on;
-		regulator-always-on;
-	};
-
-	reg_3p3v: regulator1 {
-		compatible = "regulator-fixed";
-		regulator-name = "fixed-3.3V";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-boot-on;
-		regulator-always-on;
-	};
-
-	vcc_sdhi0: regulator-vcc-sdhi0 {
-		compatible = "regulator-fixed";
-
-		regulator-name = "SDHI0 Vcc";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-
-		gpio = <&gpio5 2 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	vccq_sdhi0: regulator-vccq-sdhi0 {
-		compatible = "regulator-gpio";
-
-		regulator-name = "SDHI0 VccQ";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-
-		gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
-		gpios-states = <1>;
-		states = <3300000 1
-			  1800000 0>;
-	};
-
-	vcc_sdhi3: regulator-vcc-sdhi3 {
-		compatible = "regulator-fixed";
-
-		regulator-name = "SDHI3 Vcc";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-
-		gpio = <&gpio3 15 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	vccq_sdhi3: regulator-vccq-sdhi3 {
-		compatible = "regulator-gpio";
-
-		regulator-name = "SDHI3 VccQ";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-
-		gpios = <&gpio3 14 GPIO_ACTIVE_HIGH>;
-		gpios-states = <1>;
-		states = <3300000 1
-			  1800000 0>;
-	};
-};
-
-&pfc {
-	pinctrl-0 = <&scif_clk_pins>;
-	pinctrl-names = "default";
-
-	avb_pins: avb {
-		mux {
-			groups = "avb_link", "avb_phy_int", "avb_mdc",
-				 "avb_mii";
-			function = "avb";
-		};
-
-		pins_mdc {
-			groups = "avb_mdc";
-			drive-strength = <24>;
-		};
-
-		pins_mii_tx {
-			pins = "PIN_AVB_TX_CTL", "PIN_AVB_TXC", "PIN_AVB_TD0",
-			       "PIN_AVB_TD1", "PIN_AVB_TD2", "PIN_AVB_TD3";
-			drive-strength = <12>;
-		};
-	};
-
-	scif1_pins: scif1 {
-		groups = "scif1_data_a", "scif1_ctrl";
-		function = "scif1";
-	};
-
-	scif2_pins: scif2 {
-		groups = "scif2_data_a";
-		function = "scif2";
-	};
-	scif_clk_pins: scif_clk {
-		groups = "scif_clk_a";
-		function = "scif_clk";
-	};
-
-	i2c2_pins: i2c2 {
-		groups = "i2c2_a";
-		function = "i2c2";
-	};
-
-	sdhi0_pins: sd0 {
-		groups = "sdhi0_data4", "sdhi0_ctrl";
-		function = "sdhi0";
-		power-source = <3300>;
-	};
-
-	sdhi0_pins_uhs: sd0_uhs {
-		groups = "sdhi0_data4", "sdhi0_ctrl";
-		function = "sdhi0";
-		power-source = <1800>;
-	};
-
-	sdhi2_pins: sd2 {
-		groups = "sdhi2_data8", "sdhi2_ctrl";
-		function = "sdhi2";
-		power-source = <3300>;
-	};
-
-	sdhi2_pins_uhs: sd2_uhs {
-		groups = "sdhi2_data8", "sdhi2_ctrl";
-		function = "sdhi2";
-		power-source = <1800>;
-	};
-
-	sdhi3_pins: sd3 {
-		groups = "sdhi3_data4", "sdhi3_ctrl";
-		function = "sdhi3";
-		power-source = <3300>;
-	};
-
-	sdhi3_pins_uhs: sd3_uhs {
-		groups = "sdhi3_data4", "sdhi3_ctrl";
-		function = "sdhi3";
-		power-source = <1800>;
-	};
-};
-
-&avb {
-	pinctrl-0 = <&avb_pins>;
-	pinctrl-names = "default";
-	renesas,no-ether-link;
-	phy-handle = <&phy0>;
-	status = "okay";
-
-	phy0: ethernet-phy at 0 {
-		rxc-skew-ps = <1500>;
-		reg = <0>;
-		interrupt-parent = <&gpio2>;
-		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
-	};
-};
-
-&extal_clk {
-	clock-frequency = <16666666>;
-};
-
-&extalr_clk {
-	clock-frequency = <32768>;
-};
-
-&sdhi0 {
-	pinctrl-0 = <&sdhi0_pins>;
-	pinctrl-1 = <&sdhi0_pins_uhs>;
-	pinctrl-names = "default", "state_uhs";
-
-	vmmc-supply = <&vcc_sdhi0>;
-	vqmmc-supply = <&vccq_sdhi0>;
-	cd-gpios = <&gpio3 12 GPIO_ACTIVE_LOW>;
-	wp-gpios = <&gpio3 13 GPIO_ACTIVE_HIGH>;
-	bus-width = <4>;
-	sd-uhs-sdr50;
-	status = "okay";
-};
-
-&sdhi2 {
-	/* used for on-board 8bit eMMC */
-	pinctrl-0 = <&sdhi2_pins>;
-	pinctrl-1 = <&sdhi2_pins_uhs>;
-	pinctrl-names = "default", "state_uhs";
-
-	vmmc-supply = <&reg_3p3v>;
-	vqmmc-supply = <&reg_1p8v>;
-	bus-width = <8>;
-	mmc-hs200-1_8v;
-	non-removable;
-	status = "okay";
-};
-
-&sdhi3 {
-	pinctrl-0 = <&sdhi3_pins>;
-	pinctrl-1 = <&sdhi3_pins_uhs>;
-	pinctrl-names = "default", "state_uhs";
-
-	vmmc-supply = <&vcc_sdhi3>;
-	vqmmc-supply = <&vccq_sdhi3>;
-	cd-gpios = <&gpio4 15 GPIO_ACTIVE_LOW>;
-	wp-gpios = <&gpio4 16 GPIO_ACTIVE_HIGH>;
-	bus-width = <4>;
-	sd-uhs-sdr50;
-	status = "okay";
-};
-
-&scif1 {
-	pinctrl-0 = <&scif1_pins>;
-	pinctrl-names = "default";
-
-	uart-has-rtscts;
-	status = "okay";
-};
-
-&scif2 {
-	pinctrl-0 = <&scif2_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&scif_clk {
-	clock-frequency = <14745600>;
-};
-
-&i2c2 {
-	pinctrl-0 = <&i2c2_pins>;
-	pinctrl-names = "default";
-
-	status = "okay";
-};
-
-&wdt0 {
-	timeout-sec = <60>;
-	status = "okay";
-};
-
-&i2c_dvfs {
-	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/salvator-x.dtsi
similarity index 91%
copy from arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
copy to arch/arm64/boot/dts/renesas/salvator-x.dtsi
index ff68bac4cd7ed2f5..47a482f20c9d511f 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/salvator-x.dtsi
@@ -1,7 +1,7 @@
 /*
  * Device Tree Source for the Salvator-X board
  *
- * Copyright (C) 2015 Renesas Electronics Corp.
+ * Copyright (C) 2015-2016 Renesas Electronics Corp.
  *
  * This file is licensed under the terms of the GNU General Public License
  * version 2.  This program is licensed "as is" without any warranty of any
@@ -31,13 +31,11 @@
  *	amixer set "DVC Out" 100%  // Volume Up
  */
 
-/dts-v1/;
-#include "r8a7795.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 
 / {
-	model = "Renesas Salvator-X board based on r8a7795";
-	compatible = "renesas,salvator-x", "renesas,r8a7795";
+	model = "Renesas Salvator-X board";
+	compatible = "renesas,salvator-x";
 
 	aliases {
 		serial0 = &scif2;
@@ -50,31 +48,14 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory at 48000000 {
-		device_type = "memory";
-		/* first 128MB is reserved for secure area. */
-		reg = <0x0 0x48000000 0x0 0x38000000>;
-	};
-
-	memory at 500000000 {
-		device_type = "memory";
-		reg = <0x5 0x00000000 0x0 0x40000000>;
-	};
-
-	memory at 600000000 {
-		device_type = "memory";
-		reg = <0x6 0x00000000 0x0 0x40000000>;
-	};
-
-	memory at 700000000 {
-		device_type = "memory";
-		reg = <0x7 0x00000000 0x0 0x40000000>;
-	};
-
-	x12_clk: x12 {
+	audio_clkout: audio_clkout {
+		/*
+		 * This is same as <&rcar_sound 0>
+		 * but needed to avoid cs2000/rcar_sound probe dead-lock
+		 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-		clock-frequency = <24576000>;
+		clock-frequency = <11289600>;
 	};
 
 	reg_1p8v: regulator0 {
@@ -95,6 +76,33 @@
 		regulator-always-on;
 	};
 
+	rsnd_ak4613: sound {
+		compatible = "simple-audio-card";
+
+		simple-audio-card,format = "left_j";
+		simple-audio-card,bitclock-master = <&sndcpu>;
+		simple-audio-card,frame-master = <&sndcpu>;
+
+		sndcpu: simple-audio-card,cpu {
+			sound-dai = <&rcar_sound>;
+		};
+
+		sndcodec: simple-audio-card,codec {
+			sound-dai = <&ak4613>;
+		};
+	};
+
+	vbus0_usb2: regulator-vbus0-usb2 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "USB20_VBUS0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+
+		gpio = <&gpio6 16 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	vcc_sdhi0: regulator-vcc-sdhi0 {
 		compatible = "regulator-fixed";
 
@@ -143,40 +151,13 @@
 			  1800000 0>;
 	};
 
-	vbus0_usb2: regulator-vbus0-usb2 {
-		compatible = "regulator-fixed";
-
-		regulator-name = "USB20_VBUS0";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-
-		gpio = <&gpio6 16 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	audio_clkout: audio_clkout {
-		/*
-		 * This is same as <&rcar_sound 0>
-		 * but needed to avoid cs2000/rcar_sound probe dead-lock
-		 */
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <11289600>;
-	};
-
-	rsnd_ak4613: sound {
-		compatible = "simple-audio-card";
-
-		simple-audio-card,format = "left_j";
-		simple-audio-card,bitclock-master = <&sndcpu>;
-		simple-audio-card,frame-master = <&sndcpu>;
-
-		sndcpu: simple-audio-card,cpu {
-			sound-dai = <&rcar_sound>;
-		};
+	vga {
+		compatible = "vga-connector";
 
-		sndcodec: simple-audio-card,codec {
-			sound-dai = <&ak4613>;
+		port {
+			vga_in: endpoint {
+				remote-endpoint = <&adv7123_out>;
+			};
 		};
 	};
 
@@ -202,14 +183,29 @@
 		};
 	};
 
-	vga {
-		compatible = "vga-connector";
+	x12_clk: x12 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24576000>;
+	};
+};
 
-		port {
-			vga_in: endpoint {
-				remote-endpoint = <&adv7123_out>;
-			};
-		};
+&audio_clk_a {
+	clock-frequency = <22579200>;
+};
+
+&avb {
+	pinctrl-0 = <&avb_pins>;
+	pinctrl-names = "default";
+	renesas,no-ether-link;
+	phy-handle = <&phy0>;
+	status = "okay";
+
+	phy0: ethernet-phy at 0 {
+		rxc-skew-ps = <1500>;
+		reg = <0>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
@@ -231,6 +227,14 @@
 	};
 };
 
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
 &extal_clk {
 	clock-frequency = <16666666>;
 };
@@ -239,27 +243,73 @@
 	clock-frequency = <32768>;
 };
 
-&pfc {
-	pinctrl-0 = <&scif_clk_pins>;
+&hsusb {
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-0 = <&i2c2_pins>;
 	pinctrl-names = "default";
 
-	scif1_pins: scif1 {
-		groups = "scif1_data_a", "scif1_ctrl";
-		function = "scif1";
-	};
-	scif2_pins: scif2 {
-		groups = "scif2_data_a";
-		function = "scif2";
-	};
-	scif_clk_pins: scif_clk {
-		groups = "scif_clk_a";
-		function = "scif_clk";
+	status = "okay";
+
+	clock-frequency = <100000>;
+
+	ak4613: codec at 10 {
+		compatible = "asahi-kasei,ak4613";
+		#sound-dai-cells = <0>;
+		reg = <0x10>;
+		clocks = <&rcar_sound 3>;
+
+		asahi-kasei,in1-single-end;
+		asahi-kasei,in2-single-end;
+		asahi-kasei,out1-single-end;
+		asahi-kasei,out2-single-end;
+		asahi-kasei,out3-single-end;
+		asahi-kasei,out4-single-end;
+		asahi-kasei,out5-single-end;
+		asahi-kasei,out6-single-end;
 	};
 
-	i2c2_pins: i2c2 {
-		groups = "i2c2_a";
-		function = "i2c2";
+	cs2000: clk_multiplier at 4f {
+		#clock-cells = <0>;
+		compatible = "cirrus,cs2000-cp";
+		reg = <0x4f>;
+		clocks = <&audio_clkout>, <&x12_clk>;
+		clock-names = "clk_in", "ref_clk";
+
+		assigned-clocks = <&cs2000>;
+		assigned-clock-rates = <24576000>; /* 1/1 divide */
 	};
+};
+
+&i2c_dvfs {
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&pcie_bus_clk {
+	clock-frequency = <100000000>;
+};
+
+&pciec0 {
+	status = "okay";
+};
+
+&pciec1 {
+	status = "okay";
+};
+
+&pfc {
+	pinctrl-0 = <&scif_clk_pins>;
+	pinctrl-names = "default";
 
 	avb_pins: avb {
 		mux {
@@ -285,6 +335,26 @@
 		function = "du";
 	};
 
+	i2c2_pins: i2c2 {
+		groups = "i2c2_a";
+		function = "i2c2";
+	};
+
+	scif1_pins: scif1 {
+		groups = "scif1_data_a", "scif1_ctrl";
+		function = "scif1";
+	};
+
+	scif2_pins: scif2 {
+		groups = "scif2_data_a";
+		function = "scif2";
+	};
+
+	scif_clk_pins: scif_clk {
+		groups = "scif_clk_a";
+		function = "scif_clk";
+	};
+
 	sdhi0_pins: sd0 {
 		groups = "sdhi0_data4", "sdhi0_ctrl";
 		function = "sdhi0";
@@ -353,66 +423,6 @@
 			bias-pull-down;
 		};
 	};
-
-	usb2_pins: usb2 {
-		groups = "usb2";
-		function = "usb2";
-	};
-};
-
-&scif1 {
-	pinctrl-0 = <&scif1_pins>;
-	pinctrl-names = "default";
-
-	uart-has-rtscts;
-	status = "okay";
-};
-
-&scif2 {
-	pinctrl-0 = <&scif2_pins>;
-	pinctrl-names = "default";
-
-	status = "okay";
-};
-
-&scif_clk {
-	clock-frequency = <14745600>;
-};
-
-&i2c2 {
-	pinctrl-0 = <&i2c2_pins>;
-	pinctrl-names = "default";
-
-	status = "okay";
-
-	clock-frequency = <100000>;
-
-	ak4613: codec at 10 {
-		compatible = "asahi-kasei,ak4613";
-		#sound-dai-cells = <0>;
-		reg = <0x10>;
-		clocks = <&rcar_sound 3>;
-
-		asahi-kasei,in1-single-end;
-		asahi-kasei,in2-single-end;
-		asahi-kasei,out1-single-end;
-		asahi-kasei,out2-single-end;
-		asahi-kasei,out3-single-end;
-		asahi-kasei,out4-single-end;
-		asahi-kasei,out5-single-end;
-		asahi-kasei,out6-single-end;
-	};
-
-	cs2000: clk_multiplier at 4f {
-		#clock-cells = <0>;
-		compatible = "cirrus,cs2000-cp";
-		reg = <0x4f>;
-		clocks = <&audio_clkout>, <&x12_clk>;
-		clock-names = "clk_in", "ref_clk";
-
-		assigned-clocks = <&cs2000>;
-		assigned-clock-rates = <24576000>; /* 1/1 divide */
-	};
 };
 
 &rcar_sound {
@@ -445,7 +455,7 @@
 		 <&cpg CPG_MOD 1019>, <&cpg CPG_MOD 1018>,
 		 <&audio_clk_a>, <&cs2000>,
 		 <&audio_clk_c>,
-		 <&cpg CPG_CORE R8A7795_CLK_S0D4>;
+		 <&cpg CPG_CORE CPG_AUDIO_CLK_I>;
 
 	rcar_sound,dai {
 		dai0 {
@@ -455,10 +465,25 @@
 	};
 };
 
-&sata {
+&scif1 {
+	pinctrl-0 = <&scif1_pins>;
+	pinctrl-names = "default";
+
+	uart-has-rtscts;
 	status = "okay";
 };
 
+&scif2 {
+	pinctrl-0 = <&scif2_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&scif_clk {
+	clock-frequency = <14745600>;
+};
+
 &sdhi0 {
 	pinctrl-0 = <&sdhi0_pins>;
 	pinctrl-1 = <&sdhi0_pins_uhs>;
@@ -505,38 +530,6 @@
 	shared-pin;
 };
 
-&wdt0 {
-	timeout-sec = <60>;
-	status = "okay";
-};
-
-&audio_clk_a {
-	clock-frequency = <22579200>;
-};
-
-&i2c_dvfs {
-	status = "okay";
-};
-
-&avb {
-	pinctrl-0 = <&avb_pins>;
-	pinctrl-names = "default";
-	renesas,no-ether-link;
-	phy-handle = <&phy0>;
-	status = "okay";
-
-	phy0: ethernet-phy at 0 {
-		rxc-skew-ps = <1500>;
-		reg = <0>;
-		interrupt-parent = <&gpio2>;
-		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
-	};
-};
-
-&xhci0 {
-	status = "okay";
-};
-
 &usb2_phy0 {
 	pinctrl-0 = <&usb0_pins>;
 	pinctrl-names = "default";
@@ -552,49 +545,11 @@
 	status = "okay";
 };
 
-&usb2_phy2 {
-	pinctrl-0 = <&usb2_pins>;
-	pinctrl-names = "default";
-
-	status = "okay";
-};
-
-&ehci0 {
-	status = "okay";
-};
-
-&ehci1 {
-	status = "okay";
-};
-
-&ehci2 {
-	status = "okay";
-};
-
-&ohci0 {
-	status = "okay";
-};
-
-&ohci1 {
-	status = "okay";
-};
-
-&ohci2 {
-	status = "okay";
-};
-
-&hsusb {
-	status = "okay";
-};
-
-&pcie_bus_clk {
-	clock-frequency = <100000000>;
-};
-
-&pciec0 {
+&wdt0 {
+	timeout-sec = <60>;
 	status = "okay";
 };
 
-&pciec1 {
+&xhci0 {
 	status = "okay";
 };
-- 
2.7.4
