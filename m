From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 14 Jun 2018 13:30:36 +0200
Subject: [PATCH 1/4] arm64: dts: rockchip: move Chromebook-specific Gru-parts
 to a separate file
In-Reply-To: <20180614113039.29117-1-heiko@sntech.de>
References: <20180614113039.29117-1-heiko@sntech.de>
Message-ID: <20180614113039.29117-2-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Similar to rk3288-Veyron before, the Gru-series does contain Chromebook
(aka clamshell laptops) and non-Chromebook devices. And while the two
Chromebook devices Kevin and Bob are quite similar, Scarlet the tablet-
device is quite different in its design.

Therefore move the Chromebook parts into a gru-chromebook dtsi file
to make sharing easier.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../dts/rockchip/rk3399-gru-chromebook.dtsi   | 365 ++++++++++++++++++
 .../boot/dts/rockchip/rk3399-gru-kevin.dts    |   8 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  | 322 ---------------
 3 files changed, 366 insertions(+), 329 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
new file mode 100644
index 000000000000..32139e6910a3
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Gru-Chromebook shared properties
+ *
+ * Copyright 2018 Google, Inc
+ */
+
+#include "rk3399-gru.dtsi"
+
+/ {
+	pp900_ap: pp900-ap {
+		compatible = "regulator-fixed";
+		regulator-name = "pp900_ap";
+
+		/* EC turns on w/ pp900_ap_en; always on for AP */
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <900000>;
+
+		vin-supply = <&ppvar_sys>;
+	};
+
+	/* EC turns on w/ pp900_usb_en */
+	pp900_usb: pp900-ap {
+	};
+
+	/* EC turns on w/ pp900_pcie_en */
+	pp900_pcie: pp900-ap {
+	};
+
+	pp3000: pp3000 {
+		compatible = "regulator-fixed";
+		regulator-name = "pp3000";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pp3000_en>;
+
+		enable-active-high;
+		gpio = <&gpio0 12 GPIO_ACTIVE_HIGH>;
+
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+
+		vin-supply = <&ppvar_sys>;
+	};
+
+	ppvar_centerlogic_pwm: ppvar-centerlogic-pwm {
+		compatible = "pwm-regulator";
+		regulator-name = "ppvar_centerlogic_pwm";
+
+		pwms = <&pwm3 0 3337 0>;
+		pwm-supply = <&ppvar_sys>;
+		pwm-dutycycle-range = <100 0>;
+		pwm-dutycycle-unit = <100>;
+
+		/* EC turns on w/ ppvar_centerlogic_en; always on for AP */
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <799434>;
+		regulator-max-microvolt = <1049925>;
+	};
+
+	ppvar_centerlogic: ppvar-centerlogic {
+		compatible = "vctrl-regulator";
+		regulator-name = "ppvar_centerlogic";
+
+		regulator-min-microvolt = <799434>;
+		regulator-max-microvolt = <1049925>;
+
+		ctrl-supply = <&ppvar_centerlogic_pwm>;
+		ctrl-voltage-range = <799434 1049925>;
+
+		regulator-settling-time-up-us = <378>;
+		min-slew-down-rate = <225>;
+		ovp-threshold-percent = <16>;
+	};
+
+	/* Schematics call this PPVAR even though it's fixed */
+	ppvar_logic: ppvar-logic {
+		compatible = "regulator-fixed";
+		regulator-name = "ppvar_logic";
+
+		/* EC turns on w/ ppvar_logic_en; always on for AP */
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <900000>;
+
+		vin-supply = <&ppvar_sys>;
+	};
+
+	pp1800_audio: pp1800-audio {
+		compatible = "regulator-fixed";
+		regulator-name = "pp1800_audio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pp1800_audio_en>;
+
+		enable-active-high;
+		gpio = <&gpio0 2 GPIO_ACTIVE_HIGH>;
+
+		regulator-always-on;
+		regulator-boot-on;
+
+		vin-supply = <&pp1800>;
+	};
+
+	/* gpio is shared with pp3300_wifi_bt */
+	pp1800_pcie: pp1800-pcie {
+		compatible = "regulator-fixed";
+		regulator-name = "pp1800_pcie";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_module_pd_l>;
+
+		enable-active-high;
+		gpio = <&gpio0 4 GPIO_ACTIVE_HIGH>;
+
+		/*
+		 * Need to wait 1ms + ramp-up time before we can power on WiFi.
+		 * This has been approximated as 8ms total.
+		 */
+		regulator-enable-ramp-delay = <8000>;
+
+		vin-supply = <&pp1800>;
+	};
+
+	/* Always on; plain and simple */
+	pp3000_ap: pp3000_emmc: pp3000 {
+	};
+
+	pp1500_ap_io: pp1500-ap-io {
+		compatible = "regulator-fixed";
+		regulator-name = "pp1500_ap_io";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pp1500_en>;
+
+		enable-active-high;
+		gpio = <&gpio0 10 GPIO_ACTIVE_HIGH>;
+
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+
+		vin-supply = <&pp1800>;
+	};
+
+	pp3300_disp: pp3300-disp {
+		compatible = "regulator-fixed";
+		regulator-name = "pp3300_disp";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pp3300_disp_en>;
+
+		enable-active-high;
+		gpio = <&gpio4 27 GPIO_ACTIVE_HIGH>;
+
+		startup-delay-us = <2000>;
+		vin-supply = <&pp3300>;
+	};
+
+	/* EC turns on w/ pp3300_usb_en_l */
+	pp3300_usb: pp3300 {
+	};
+
+	/* gpio is shared with pp1800_pcie and pinctrl is set there */
+	pp3300_wifi_bt: pp3300-wifi-bt {
+		compatible = "regulator-fixed";
+		regulator-name = "pp3300_wifi_bt";
+
+		enable-active-high;
+		gpio = <&gpio0 4 GPIO_ACTIVE_HIGH>;
+
+		vin-supply = <&pp3300>;
+	};
+
+	/*
+	 * This is a bit of a hack. The WiFi module should be reset at least
+	 * 1ms after its regulators have ramped up (max rampup time is ~7ms).
+	 * With some stretching of the imagination, we can call the 1.8V
+	 * regulator a supply.
+	 */
+	wlan_pd_n: wlan-pd-n {
+		compatible = "regulator-fixed";
+		regulator-name = "wlan_pd_n";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_module_reset_l>;
+
+		enable-active-high;
+		gpio = <&gpio1 11 GPIO_ACTIVE_HIGH>;
+
+		vin-supply = <&pp1800_pcie>;
+	};
+};
+
+&ppvar_bigcpu {
+	min-slew-down-rate = <225>;
+	ovp-threshold-percent = <16>;
+};
+
+&ppvar_litcpu {
+	min-slew-down-rate = <225>;
+	ovp-threshold-percent = <16>;
+};
+
+&ppvar_gpu {
+	min-slew-down-rate = <225>;
+	ovp-threshold-percent = <16>;
+};
+
+&cdn_dp {
+	extcon = <&usbc_extcon0>, <&usbc_extcon1>;
+};
+
+ap_i2c_mic: &i2c1 {
+	status = "okay";
+
+	clock-frequency = <400000>;
+
+	/* These are relatively safe rise/fall times */
+	i2c-scl-falling-time-ns = <50>;
+	i2c-scl-rising-time-ns = <300>;
+
+	headsetcodec: rt5514 at 57 {
+		compatible = "realtek,rt5514";
+		reg = <0x57>;
+		realtek,dmic-init-delay-ms = <20>;
+	};
+};
+
+ap_i2c_tp: &i2c5 {
+	status = "okay";
+
+	clock-frequency = <400000>;
+
+	/* These are relatively safe rise/fall times */
+	i2c-scl-falling-time-ns = <50>;
+	i2c-scl-rising-time-ns = <300>;
+
+	/*
+	 * Note strange pullup enable.  Apparently this avoids leakage but
+	 * still allows us to get nice 4.7K pullups for high speed i2c
+	 * transfers.  Basically we want the pullup on whenever the ap is
+	 * alive, so the "en" pin just gets set to output high.
+	 */
+	pinctrl-0 = <&i2c5_xfer &ap_i2c_tp_pu_en>;
+};
+
+&cros_ec {
+	cros_ec_pwm: ec-pwm {
+		compatible = "google,cros-ec-pwm";
+		#pwm-cells = <1>;
+	};
+
+	usbc_extcon1: extcon at 1 {
+		compatible = "google,extcon-usbc-cros-ec";
+		google,usb-port-id = <1>;
+
+		#extcon-cells = <0>;
+	};
+};
+
+&sound {
+	rockchip,codec = <&max98357a &headsetcodec
+			  &codec &wacky_spi_audio &cdn_dp>;
+};
+
+&spi2 {
+	wacky_spi_audio: spi2 at 0 {
+		compatible = "realtek,rt5514";
+		reg = <0>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mic_int>;
+		/* May run faster once verified. */
+		spi-max-frequency = <10000000>;
+		wakeup-source;
+	};
+};
+
+&pci_rootport {
+	mvl_wifi: wifi at 0,0 {
+		compatible = "pci1b4b,2b42";
+		reg = <0x83010000 0x0 0x00000000 0x0 0x00100000
+		       0x83010000 0x0 0x00100000 0x0 0x00100000>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_host_wake_l>;
+		wakeup-source;
+	};
+};
+
+&tcphy1 {
+	status = "okay";
+	extcon = <&usbc_extcon1>;
+};
+
+&u2phy1 {
+	status = "okay";
+};
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host1_ehci {
+	status = "okay";
+};
+
+&usb_host1_ohci {
+	status = "okay";
+};
+
+&usbdrd3_1 {
+	status = "okay";
+	extcon = <&usbc_extcon1>;
+};
+
+&usbdrd_dwc3_1 {
+	status = "okay";
+	dr_mode = "host";
+};
+
+&pinctrl {
+	discrete-regulators {
+		pp1500_en: pp1500-en {
+			rockchip,pins = <RK_GPIO0 10 RK_FUNC_GPIO
+					 &pcfg_pull_none>;
+		};
+
+		pp1800_audio_en: pp1800-audio-en {
+			rockchip,pins = <RK_GPIO0 2 RK_FUNC_GPIO
+					 &pcfg_pull_down>;
+		};
+
+		pp3000_en: pp3000-en {
+			rockchip,pins = <RK_GPIO0 12 RK_FUNC_GPIO
+					 &pcfg_pull_none>;
+		};
+
+		pp3300_disp_en: pp3300-disp-en {
+			rockchip,pins = <RK_GPIO4 27 RK_FUNC_GPIO
+					 &pcfg_pull_none>;
+		};
+
+		wlan_module_pd_l: wlan-module-pd-l {
+			rockchip,pins = <RK_GPIO0 4 RK_FUNC_GPIO
+					 &pcfg_pull_down>;
+		};
+	};
+};
+
+&wifi {
+		wifi_perst_l: wifi-perst-l {
+			rockchip,pins = <2 27 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		wlan_host_wake_l: wlan-host-wake-l {
+			rockchip,pins = <0 8 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
index 356c4d71c95b..e582ec9fbc97 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
@@ -6,7 +6,7 @@
  */
 
 /dts-v1/;
-#include "rk3399-gru.dtsi"
+#include "rk3399-gru-chromebook.dtsi"
 #include <dt-bindings/input/linux-event-codes.h>
 
 /*
@@ -337,10 +337,4 @@ ap_i2c_dig: &i2c2 {
 			rockchip,pins = <0 13 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
-
-	wifi {
-		wlan_host_wake_l: wlan-host-wake-l {
-			rockchip,pins = <0 8 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index e2a60680c66c..614b4f198cc0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -45,19 +45,6 @@
 		regulator-boot-on;
 	};
 
-	pp900_ap: pp900-ap {
-		compatible = "regulator-fixed";
-		regulator-name = "pp900_ap";
-
-		/* EC turns on w/ pp900_ap_en; always on for AP */
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <900000>;
-		regulator-max-microvolt = <900000>;
-
-		vin-supply = <&ppvar_sys>;
-	};
-
 	pp1200_lpddr: pp1200-lpddr {
 		compatible = "regulator-fixed";
 		regulator-name = "pp1200_lpddr";
@@ -84,23 +71,6 @@
 		vin-supply = <&ppvar_sys>;
 	};
 
-	pp3000: pp3000 {
-		compatible = "regulator-fixed";
-		regulator-name = "pp3000";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pp3000_en>;
-
-		enable-active-high;
-		gpio = <&gpio0 12 GPIO_ACTIVE_HIGH>;
-
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <3000000>;
-		regulator-max-microvolt = <3000000>;
-
-		vin-supply = <&ppvar_sys>;
-	};
-
 	pp3300: pp3300 {
 		compatible = "regulator-fixed";
 		regulator-name = "pp3300";
@@ -154,8 +124,6 @@
 		ctrl-voltage-range = <800107 1302232>;
 
 		regulator-settling-time-up-us = <322>;
-		min-slew-down-rate = <225>;
-		ovp-threshold-percent = <16>;
 	};
 
 	ppvar_litcpu_pwm: ppvar-litcpu-pwm {
@@ -185,8 +153,6 @@
 		ctrl-voltage-range = <797743 1307837>;
 
 		regulator-settling-time-up-us = <384>;
-		min-slew-down-rate = <225>;
-		ovp-threshold-percent = <16>;
 	};
 
 	ppvar_gpu_pwm: ppvar-gpu-pwm {
@@ -216,63 +182,12 @@
 		ctrl-voltage-range = <786384 1217747>;
 
 		regulator-settling-time-up-us = <390>;
-		min-slew-down-rate = <225>;
-		ovp-threshold-percent = <16>;
-	};
-
-	ppvar_centerlogic_pwm: ppvar-centerlogic-pwm {
-		compatible = "pwm-regulator";
-		regulator-name = "ppvar_centerlogic_pwm";
-
-		pwms = <&pwm3 0 3337 0>;
-		pwm-supply = <&ppvar_sys>;
-		pwm-dutycycle-range = <100 0>;
-		pwm-dutycycle-unit = <100>;
-
-		/* EC turns on w/ ppvar_centerlogic_en; always on for AP */
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <799434>;
-		regulator-max-microvolt = <1049925>;
-	};
-
-	ppvar_centerlogic: ppvar-centerlogic {
-		compatible = "vctrl-regulator";
-		regulator-name = "ppvar_centerlogic";
-
-		regulator-min-microvolt = <799434>;
-		regulator-max-microvolt = <1049925>;
-
-		ctrl-supply = <&ppvar_centerlogic_pwm>;
-		ctrl-voltage-range = <799434 1049925>;
-
-		regulator-settling-time-up-us = <378>;
-		min-slew-down-rate = <225>;
-		ovp-threshold-percent = <16>;
-	};
-
-	/* Schematics call this PPVAR even though it's fixed */
-	ppvar_logic: ppvar-logic {
-		compatible = "regulator-fixed";
-		regulator-name = "ppvar_logic";
-
-		/* EC turns on w/ ppvar_logic_en; always on for AP */
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <900000>;
-		regulator-max-microvolt = <900000>;
-
-		vin-supply = <&ppvar_sys>;
 	};
 
 	/* EC turns on w/ pp900_ddrpll_en */
 	pp900_ddrpll: pp900-ap {
 	};
 
-	/* EC turns on w/ pp900_pcie_en */
-	pp900_pcie: pp900-ap {
-	};
-
 	/* EC turns on w/ pp900_pll_en */
 	pp900_pll: pp900-ap {
 	};
@@ -281,10 +196,6 @@
 	pp900_pmu: pp900-ap {
 	};
 
-	/* EC turns on w/ pp900_usb_en */
-	pp900_usb: pp900-ap {
-	};
-
 	/* EC turns on w/ pp1800_s0_en_l */
 	pp1800_ap_io: pp1800_emmc: pp1800_nfc: pp1800_s0: pp1800 {
 	};
@@ -309,79 +220,6 @@
 	pp1800_usb: pp1800 {
 	};
 
-	pp1500_ap_io: pp1500-ap-io {
-		compatible = "regulator-fixed";
-		regulator-name = "pp1500_ap_io";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pp1500_en>;
-
-		enable-active-high;
-		gpio = <&gpio0 10 GPIO_ACTIVE_HIGH>;
-
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <1500000>;
-		regulator-max-microvolt = <1500000>;
-
-		vin-supply = <&pp1800>;
-	};
-
-	pp1800_audio: pp1800-audio {
-		compatible = "regulator-fixed";
-		regulator-name = "pp1800_audio";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pp1800_audio_en>;
-
-		enable-active-high;
-		gpio = <&gpio0 2 GPIO_ACTIVE_HIGH>;
-
-		regulator-always-on;
-		regulator-boot-on;
-
-		vin-supply = <&pp1800>;
-	};
-
-	/* gpio is shared with pp3300_wifi_bt */
-	pp1800_pcie: pp1800-pcie {
-		compatible = "regulator-fixed";
-		regulator-name = "pp1800_pcie";
-		pinctrl-names = "default";
-		pinctrl-0 = <&wlan_module_pd_l>;
-
-		enable-active-high;
-		gpio = <&gpio0 4 GPIO_ACTIVE_HIGH>;
-
-		/*
-		 * Need to wait 1ms + ramp-up time before we can power on WiFi.
-		 * This has been approximated as 8ms total.
-		 */
-		regulator-enable-ramp-delay = <8000>;
-
-		vin-supply = <&pp1800>;
-	};
-
-	/*
-	 * This is a bit of a hack. The WiFi module should be reset at least
-	 * 1ms after its regulators have ramped up (max rampup time is ~7ms).
-	 * With some stretching of the imagination, we can call the 1.8V
-	 * regulator a supply.
-	 */
-	wlan_pd_n: wlan-pd-n {
-		compatible = "regulator-fixed";
-		regulator-name = "wlan_pd_n";
-		pinctrl-names = "default";
-		pinctrl-0 = <&wlan_module_reset_l>;
-
-		enable-active-high;
-		gpio = <&gpio1 11 GPIO_ACTIVE_HIGH>;
-
-		vin-supply = <&pp1800_pcie>;
-	};
-
-	/* Always on; plain and simple */
-	pp3000_ap: pp3000_emmc: pp3000 {
-	};
-
 	pp3000_sd_slot: pp3000-sd-slot {
 		compatible = "regulator-fixed";
 		regulator-name = "pp3000_sd_slot";
@@ -420,34 +258,6 @@
 	pp3300_trackpad: pp3300-trackpad {
 	};
 
-	/* EC turns on w/ pp3300_usb_en_l */
-	pp3300_usb: pp3300 {
-	};
-
-	pp3300_disp: pp3300-disp {
-		compatible = "regulator-fixed";
-		regulator-name = "pp3300_disp";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pp3300_disp_en>;
-
-		enable-active-high;
-		gpio = <&gpio4 27 GPIO_ACTIVE_HIGH>;
-
-		startup-delay-us = <2000>;
-		vin-supply = <&pp3300>;
-	};
-
-	/* gpio is shared with pp1800_pcie and pinctrl is set there */
-	pp3300_wifi_bt: pp3300-wifi-bt {
-		compatible = "regulator-fixed";
-		regulator-name = "pp3300_wifi_bt";
-
-		enable-active-high;
-		gpio = <&gpio0 4 GPIO_ACTIVE_HIGH>;
-
-		vin-supply = <&pp3300>;
-	};
-
 	/* EC turns on w/ usb_a_en */
 	pp5000_usb_a_vbus: pp5000 {
 	};
@@ -478,14 +288,11 @@
 	sound {
 		compatible = "rockchip,rk3399-gru-sound";
 		rockchip,cpu = <&i2s0 &i2s2>;
-		rockchip,codec = <&max98357a &headsetcodec
-				  &codec &wacky_spi_audio &cdn_dp>;
 	};
 };
 
 &cdn_dp {
 	status = "okay";
-	extcon = <&usbc_extcon0>, <&usbc_extcon1>;
 };
 
 /*
@@ -576,22 +383,6 @@
 	status = "okay";
 };
 
-ap_i2c_mic: &i2c1 {
-	status = "okay";
-
-	clock-frequency = <400000>;
-
-	/* These are relatively safe rise/fall times */
-	i2c-scl-falling-time-ns = <50>;
-	i2c-scl-rising-time-ns = <300>;
-
-	headsetcodec: rt5514 at 57 {
-		compatible = "realtek,rt5514";
-		reg = <0x57>;
-		realtek,dmic-init-delay-ms = <20>;
-	};
-};
-
 ap_i2c_ts: &i2c3 {
 	status = "okay";
 
@@ -602,24 +393,6 @@ ap_i2c_ts: &i2c3 {
 	i2c-scl-rising-time-ns = <300>;
 };
 
-ap_i2c_tp: &i2c5 {
-	status = "okay";
-
-	clock-frequency = <400000>;
-
-	/* These are relatively safe rise/fall times */
-	i2c-scl-falling-time-ns = <50>;
-	i2c-scl-rising-time-ns = <300>;
-
-	/*
-	 * Note strange pullup enable.  Apparently this avoids leakage but
-	 * still allows us to get nice 4.7K pullups for high speed i2c
-	 * transfers.  Basically we want the pullup on whenever the ap is
-	 * alive, so the "en" pin just gets set to output high.
-	 */
-	pinctrl-0 = <&i2c5_xfer &ap_i2c_tp_pu_en>;
-};
-
 ap_i2c_audio: &i2c8 {
 	status = "okay";
 
@@ -693,17 +466,6 @@ ap_i2c_audio: &i2c8 {
 		#address-cells = <3>;
 		#size-cells = <2>;
 		ranges;
-
-		mvl_wifi: wifi at 0,0 {
-			compatible = "pci1b4b,2b42";
-			reg = <0x83010000 0x0 0x00000000 0x0 0x00100000
-			       0x83010000 0x0 0x00100000 0x0 0x00100000>;
-			interrupt-parent = <&gpio0>;
-			interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&wlan_host_wake_l>;
-			wakeup-source;
-		};
 	};
 };
 
@@ -793,18 +555,6 @@ ap_i2c_audio: &i2c8 {
 
 &spi2 {
 	status = "okay";
-
-	wacky_spi_audio: spi2 at 0 {
-		compatible = "realtek,rt5514";
-		reg = <0>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&mic_int>;
-		/* May run faster once verified. */
-		spi-max-frequency = <10000000>;
-		wakeup-source;
-	};
 };
 
 &spi5 {
@@ -826,24 +576,12 @@ ap_i2c_audio: &i2c8 {
 			#size-cells = <0>;
 		};
 
-		cros_ec_pwm: ec-pwm {
-			compatible = "google,cros-ec-pwm";
-			#pwm-cells = <1>;
-		};
-
 		usbc_extcon0: extcon at 0 {
 			compatible = "google,extcon-usbc-cros-ec";
 			google,usb-port-id = <0>;
 
 			#extcon-cells = <0>;
 		};
-
-		usbc_extcon1: extcon at 1 {
-			compatible = "google,extcon-usbc-cros-ec";
-			google,usb-port-id = <1>;
-
-			#extcon-cells = <0>;
-		};
 	};
 };
 
@@ -859,19 +597,10 @@ ap_i2c_audio: &i2c8 {
 	extcon = <&usbc_extcon0>;
 };
 
-&tcphy1 {
-	status = "okay";
-	extcon = <&usbc_extcon1>;
-};
-
 &u2phy0 {
 	status = "okay";
 };
 
-&u2phy1 {
-	status = "okay";
-};
-
 &u2phy0_host {
 	status = "okay";
 };
@@ -892,22 +621,10 @@ ap_i2c_audio: &i2c8 {
 	status = "okay";
 };
 
-&usb_host0_ehci {
-	status = "okay";
-};
-
 &usb_host0_ohci {
 	status = "okay";
 };
 
-&usb_host1_ehci {
-	status = "okay";
-};
-
-&usb_host1_ohci {
-	status = "okay";
-};
-
 &usbdrd3_0 {
 	status = "okay";
 	extcon = <&usbc_extcon0>;
@@ -918,16 +635,6 @@ ap_i2c_audio: &i2c8 {
 	dr_mode = "host";
 };
 
-&usbdrd3_1 {
-	status = "okay";
-	extcon = <&usbc_extcon1>;
-};
-
-&usbdrd_dwc3_1 {
-	status = "okay";
-	dr_mode = "host";
-};
-
 &vopb {
 	status = "okay";
 };
@@ -986,26 +693,6 @@ ap_i2c_audio: &i2c8 {
 	};
 
 	discrete-regulators {
-		pp1500_en: pp1500-en {
-			rockchip,pins = <RK_GPIO0 10 RK_FUNC_GPIO
-					 &pcfg_pull_none>;
-		};
-
-		pp1800_audio_en: pp1800-audio-en {
-			rockchip,pins = <RK_GPIO0 2 RK_FUNC_GPIO
-					 &pcfg_pull_down>;
-		};
-
-		pp3300_disp_en: pp3300-disp-en {
-			rockchip,pins = <RK_GPIO4 27 RK_FUNC_GPIO
-					 &pcfg_pull_none>;
-		};
-
-		pp3000_en: pp3000-en {
-			rockchip,pins = <RK_GPIO0 12 RK_FUNC_GPIO
-					 &pcfg_pull_none>;
-		};
-
 		sd_io_pwr_en: sd-io-pwr-en {
 			rockchip,pins = <RK_GPIO2 2 RK_FUNC_GPIO
 					 &pcfg_pull_none>;
@@ -1020,11 +707,6 @@ ap_i2c_audio: &i2c8 {
 			rockchip,pins = <RK_GPIO4 29 RK_FUNC_GPIO
 					 &pcfg_pull_none>;
 		};
-
-		wlan_module_pd_l: wlan-module-pd-l {
-			rockchip,pins = <RK_GPIO0 4 RK_FUNC_GPIO
-					 &pcfg_pull_down>;
-		};
 	};
 
 	codec {
@@ -1132,10 +814,6 @@ ap_i2c_audio: &i2c8 {
 	};
 
 	wifi {
-		wifi_perst_l: wifi-perst-l {
-			rockchip,pins = <2 27 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
 		wlan_module_reset_l: wlan-module-reset-l {
 			rockchip,pins = <1 11 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
-- 
2.17.0
