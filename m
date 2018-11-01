From: heiko@sntech.de (Heiko Stuebner)
Date: Thu,  1 Nov 2018 13:36:39 +0100
Subject: [PATCH v2 2/2] arm64: dts: rockchip: add Gru Scarlet devicetrees
In-Reply-To: <20181101123639.15560-1-heiko@sntech.de>
References: <20181101123639.15560-1-heiko@sntech.de>
Message-ID: <20181101123639.15560-2-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gru-Scarlet is a tablet device using ChomeOS, dual-dsi display
and Wacom touchscreen with stylus.

There exist two variants in the market using different displays
that are differentiated via their sku-id.
The bootloader on them also determines the correct devicetree to
load via the sku-id.

So add a common scarlet dtsi and two minimal board devicetrees
for the two display variants.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
changes in v2:
- drop coreboot param override
- rebase against current master state so it will apply against 4.20-rc1

 .../devicetree/bindings/arm/rockchip.txt      |  34 +
 arch/arm64/boot/dts/rockchip/Makefile         |   2 +
 .../dts/rockchip/rk3399-gru-scarlet-inx.dts   |  33 +
 .../dts/rockchip/rk3399-gru-scarlet-kd.dts    |  33 +
 .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi | 594 ++++++++++++++++++
 5 files changed, 696 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-inx.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-kd.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi

diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
index 0cc71236d639..7ce7382fedd8 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.txt
+++ b/Documentation/devicetree/bindings/arm/rockchip.txt
@@ -152,6 +152,40 @@ Rockchip platforms device tree bindings
       - compatible = "google,veyron-pinky-rev2", "google,veyron-pinky",
 		     "google,veyron", "rockchip,rk3288";
 
+- Google Scarlet - with display from Kingdisplay
+    Required root node properties:
+      - compatible = "google,scarlet-rev15-sku7", "google,scarlet-rev15",
+		     "google,scarlet-rev14-sku7", "google,scarlet-rev14",
+		     "google,scarlet-rev13-sku7", "google,scarlet-rev13",
+		     "google,scarlet-rev12-sku7", "google,scarlet-rev12",
+		     "google,scarlet-rev11-sku7", "google,scarlet-rev11",
+		     "google,scarlet-rev10-sku7", "google,scarlet-rev10",
+		     "google,scarlet-rev9-sku7",  "google,scarlet-rev9",
+		     "google,scarlet-rev8-sku7",  "google,scarlet-rev8",
+		     "google,scarlet-rev7-sku7",  "google,scarlet-rev7",
+		     "google,scarlet-rev6-sku7",  "google,scarlet-rev6",
+		     "google,scarlet-rev5-sku7",  "google,scarlet-rev5",
+		     "google,scarlet-rev4-sku7",  "google,scarlet-rev4",
+		     "google,scarlet-rev3-sku7",  "google,scarlet-rev3",
+		     "google,scarlet", "google,gru", "rockchip,rk3399";
+
+- Google Scarlet - with display from Innolux
+    Required root node properties:
+      - compatible = "google,scarlet-rev15-sku6", "google,scarlet-rev15",
+		     "google,scarlet-rev14-sku6", "google,scarlet-rev14",
+		     "google,scarlet-rev13-sku6", "google,scarlet-rev13",
+		     "google,scarlet-rev12-sku6", "google,scarlet-rev12",
+		     "google,scarlet-rev11-sku6", "google,scarlet-rev11",
+		     "google,scarlet-rev10-sku6", "google,scarlet-rev10",
+		     "google,scarlet-rev9-sku6",  "google,scarlet-rev9",
+		     "google,scarlet-rev8-sku6",  "google,scarlet-rev8",
+		     "google,scarlet-rev7-sku6",  "google,scarlet-rev7",
+		     "google,scarlet-rev6-sku6",  "google,scarlet-rev6",
+		     "google,scarlet-rev5-sku6",  "google,scarlet-rev5",
+		     "google,scarlet-rev4-sku6",  "google,scarlet-rev4",
+		     "google,scarlet", "google,gru", "rockchip,rk3399";
+
+
 - Google Speedy (Asus C201 Chromebook):
     Required root node properties:
       - compatible = "google,veyron-speedy-rev9", "google,veyron-speedy-rev8",
diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 49042c477870..de0c406c20cc 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -14,6 +14,8 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-ficus.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-firefly.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-bob.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-kevin.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-scarlet-inx.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-scarlet-kd.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock960.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-inx.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-inx.dts
new file mode 100644
index 000000000000..2d721a974790
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-inx.dts
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Gru-Scarlet Rev4+ (SKU-6/Innolux) board device tree source
+ *
+ * Copyright 2018 Google, Inc
+ */
+
+/dts-v1/;
+
+#include "rk3399-gru-scarlet.dtsi"
+
+/ {
+	model = "Google Scarlet";
+	compatible = "google,scarlet-rev15-sku6", "google,scarlet-rev15",
+		     "google,scarlet-rev14-sku6", "google,scarlet-rev14",
+		     "google,scarlet-rev13-sku6", "google,scarlet-rev13",
+		     "google,scarlet-rev12-sku6", "google,scarlet-rev12",
+		     "google,scarlet-rev11-sku6", "google,scarlet-rev11",
+		     "google,scarlet-rev10-sku6", "google,scarlet-rev10",
+		     "google,scarlet-rev9-sku6",  "google,scarlet-rev9",
+		     "google,scarlet-rev8-sku6",  "google,scarlet-rev8",
+		     "google,scarlet-rev7-sku6",  "google,scarlet-rev7",
+		     "google,scarlet-rev6-sku6",  "google,scarlet-rev6",
+		     "google,scarlet-rev5-sku6",  "google,scarlet-rev5",
+		     "google,scarlet-rev4-sku6",  "google,scarlet-rev4",
+		     "google,scarlet", "google,gru", "rockchip,rk3399";
+};
+
+&mipi_panel {
+	compatible = "innolux,p097pfg";
+	avdd-supply = <&ppvarp_lcd>;
+	avee-supply = <&ppvarn_lcd>;
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-kd.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-kd.dts
new file mode 100644
index 000000000000..e49a194aaa0f
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-kd.dts
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Gru-Scarlet Rev3+ (SKU-7/Kingdisplay) board device tree source
+ *
+ * Copyright 2018 Google, Inc
+ */
+
+/dts-v1/;
+
+#include "rk3399-gru-scarlet.dtsi"
+
+/ {
+	model = "Google Scarlet";
+	compatible = "google,scarlet-rev15-sku7", "google,scarlet-rev15",
+		     "google,scarlet-rev14-sku7", "google,scarlet-rev14",
+		     "google,scarlet-rev13-sku7", "google,scarlet-rev13",
+		     "google,scarlet-rev12-sku7", "google,scarlet-rev12",
+		     "google,scarlet-rev11-sku7", "google,scarlet-rev11",
+		     "google,scarlet-rev10-sku7", "google,scarlet-rev10",
+		     "google,scarlet-rev9-sku7",  "google,scarlet-rev9",
+		     "google,scarlet-rev8-sku7",  "google,scarlet-rev8",
+		     "google,scarlet-rev7-sku7",  "google,scarlet-rev7",
+		     "google,scarlet-rev6-sku7",  "google,scarlet-rev6",
+		     "google,scarlet-rev5-sku7",  "google,scarlet-rev5",
+		     "google,scarlet-rev4-sku7",  "google,scarlet-rev4",
+		     "google,scarlet-rev3-sku7",  "google,scarlet-rev3",
+		     "google,scarlet", "google,gru", "rockchip,rk3399";
+};
+
+&mipi_panel {
+	compatible = "kingdisplay,kd097d04";
+	power-supply = <&pp3300_s0>;
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
new file mode 100644
index 000000000000..fc50b3ef758c
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
@@ -0,0 +1,594 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Gru-scarlet board device tree source
+ *
+ * Copyright 2018 Google, Inc
+ */
+
+#include "rk3399-gru.dtsi"
+
+/{
+	/* Power tree */
+
+	/* ppvar_sys children, sorted by name */
+	pp1250_s3: pp1250-s3 {
+		compatible = "regulator-fixed";
+		regulator-name = "pp1250_s3";
+
+		/* EC turns on w/ pp1250_s3_en; always on for AP */
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1250000>;
+		regulator-max-microvolt = <1250000>;
+
+		vin-supply = <&ppvar_sys>;
+	};
+
+	pp1250_cam: pp1250-dvdd {
+		compatible = "regulator-fixed";
+		regulator-name = "pp1250_dvdd";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pp1250_cam_en>;
+
+		enable-active-high;
+		gpio = <&gpio2 4 GPIO_ACTIVE_HIGH>;
+
+		/* 740us delay from gpio output high to pp1250 stable,
+		 * rounding up to 1ms for safety.
+		 */
+		startup-delay-us = <1000>;
+		vin-supply = <&pp1250_s3>;
+	};
+
+	pp900_s0: pp900-s0 {
+		compatible = "regulator-fixed";
+		regulator-name = "pp900_s0";
+
+		/* EC turns on w/ pp900_s0_en; always on for AP */
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <900000>;
+
+		vin-supply = <&ppvar_sys>;
+	};
+
+	ppvarn_lcd: ppvarn-lcd {
+		compatible = "regulator-fixed";
+		regulator-name = "ppvarn_lcd";
+		pinctrl-names = "default";
+		pinctrl-0 = <&ppvarn_lcd_en>;
+
+		enable-active-high;
+		gpio = <&gpio4 28 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&ppvar_sys>;
+	};
+
+	ppvarp_lcd: ppvarp-lcd {
+		compatible = "regulator-fixed";
+		regulator-name = "ppvarp_lcd";
+		pinctrl-names = "default";
+		pinctrl-0 = <&ppvarp_lcd_en>;
+
+		enable-active-high;
+		gpio = <&gpio4 27 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&ppvar_sys>;
+	};
+
+	/* pp1800 children, sorted by name */
+	pp900_s3: pp900-s3 {
+		compatible = "regulator-fixed";
+		regulator-name = "pp900_s3";
+
+		/* EC turns on w/ pp900_s3_en; always on for AP */
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <900000>;
+
+		vin-supply = <&pp1800>;
+	};
+
+	/* EC turns on pp1800_s3_en */
+	pp1800_s3: pp1800 {
+	};
+
+	/* pp3300 children, sorted by name */
+	pp2800_cam: pp2800-avdd {
+		compatible = "regulator-fixed";
+		regulator-name = "pp2800_avdd";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pp2800_cam_en>;
+
+		enable-active-high;
+		gpio = <&gpio2 24 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <100>;
+		vin-supply = <&pp3300>;
+	};
+
+	/* EC turns on pp3300_s0_en */
+	pp3300_s0: pp3300 {
+	};
+
+	/* EC turns on pp3300_s3_en */
+	pp3300_s3: pp3300 {
+	};
+
+	/*
+	 * See b/66922012
+	 *
+	 * This is a hack to make sure the Bluetooth part of the QCA6174A
+	 * is reset at boot by toggling BT_EN. At boot BT_EN is first set
+	 * to low when the bt_3v3 regulator is registered (in disabled
+	 * state). The fake regulator is configured as a supply of the
+	 * wlan_3v3 regulator below. When wlan_3v3 is enabled early in
+	 * the boot process it also enables its supply regulator bt_3v3,
+	 * which changes BT_EN to high.
+	 */
+	bt_3v3: bt-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "bt_3v3";
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_en_1v8_l>;
+
+		enable-active-high;
+		gpio = <&gpio0 8 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&pp3300_s3>;
+	};
+
+	wlan_3v3: wlan-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "wlan_3v3";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_pd_1v8_l>;
+
+		/*
+		 * The WL_EN pin is driven low when the regulator is
+		 * registered, and transitions to high when the PCIe bus
+		 * is powered up.
+		 */
+		enable-active-high;
+		gpio = <&gpio0 4 GPIO_ACTIVE_HIGH>;
+
+		/*
+		 * Require minimum 10ms from power-on (e.g., PD#) to init PCIe.
+		 * TODO (b/64444991): how long to assert PD#?
+		 */
+		regulator-enable-ramp-delay = <10000>;
+		/* See bt_3v3 hack above */
+		vin-supply = <&bt_3v3>;
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		enable-gpios = <&gpio4 21 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bl_en>;
+		pwms = <&pwm1 0 1000000 0>;
+		pwm-delay-us = <10000>;
+	};
+
+	dmic: dmic {
+		compatible = "dmic-codec";
+		dmicen-gpios = <&gpio4 3 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&dmic_en>;
+		wakeup-delay-ms = <250>;
+	};
+};
+
+/* pp900_s0 aliases */
+pp900_ddrpll_ap: &pp900_s0 {
+};
+pp900_pcie: &pp900_s0 {
+};
+pp900_usb: &pp900_s0 {
+};
+
+/* pp900_s3 aliases */
+pp900_emmcpll: &pp900_s3 {
+};
+
+/* EC turns on; alias for pp1800_s0 */
+pp1800_pcie: &pp1800_s0 {
+};
+
+/* On scarlet PPVAR(big_cpu, lit_cpu, gpu) need to adjust voltage ranges */
+&ppvar_bigcpu {
+	ctrl-voltage-range = <800074 1299226>;
+	regulator-min-microvolt = <800074>;
+	regulator-max-microvolt = <1299226>;
+};
+
+&ppvar_bigcpu_pwm {
+	/* On scarlet ppvar big cpu use pwm3 */
+	pwms = <&pwm3 0 3337 0>;
+	regulator-min-microvolt = <800074>;
+	regulator-max-microvolt = <1299226>;
+};
+
+&ppvar_litcpu {
+	ctrl-voltage-range = <802122 1199620>;
+	regulator-min-microvolt = <802122>;
+	regulator-max-microvolt = <1199620>;
+};
+
+&ppvar_litcpu_pwm {
+	regulator-min-microvolt = <802122>;
+	regulator-max-microvolt = <1199620>;
+};
+
+&ppvar_gpu {
+	ctrl-voltage-range = <799600 1099600>;
+	regulator-min-microvolt = <799600>;
+	regulator-max-microvolt = <1099600>;
+};
+
+&ppvar_gpu_pwm {
+	regulator-min-microvolt = <799600>;
+	regulator-max-microvolt = <1099600>;
+};
+
+&ppvar_sd_card_io {
+	states = <1800000 0x0 3300000 0x1>;
+	regulator-max-microvolt = <3300000>;
+};
+
+&pp3000_sd_slot {
+	vin-supply = <&pp3300>;
+};
+
+ap_i2c_dig: &i2c2 {
+	status = "okay";
+
+	clock-frequency = <400000>;
+
+	/* These are relatively safe rise/fall times. */
+	i2c-scl-falling-time-ns = <50>;
+	i2c-scl-rising-time-ns = <300>;
+
+	digitizer: digitizer at 9 {
+		compatible = "hid-over-i2c";
+		reg = <0x9>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		hid-descr-addr = <0x1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pen_int_odl &pen_reset_l>;
+	};
+};
+
+&ap_i2c_ts {
+	touchscreen: touchscreen at 10 {
+		compatible = "elan,ekth3500";
+		reg = <0x10>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&touch_int_l &touch_reset_l>;
+		reset-gpios = <&gpio0 10 GPIO_ACTIVE_LOW>;
+	};
+};
+
+camera: &i2c7 {
+	status = "okay";
+
+	clock-frequency = <400000>;
+
+	/* These are relatively safe rise/fall times; TODO: measure */
+	i2c-scl-falling-time-ns = <50>;
+	i2c-scl-rising-time-ns = <300>;
+
+	/* 24M mclk is shared between world and user cameras */
+	pinctrl-0 = <&i2c7_xfer &test_clkout1>;
+};
+
+&cdn_dp {
+	extcon = <&usbc_extcon0>;
+	phys = <&tcphy0_dp>;
+};
+
+&cpu_alert0 {
+	temperature = <66000>;
+};
+
+&cpu_alert1 {
+	temperature = <71000>;
+};
+
+&cros_ec {
+	interrupt-parent = <&gpio1>;
+	interrupts = <18 IRQ_TYPE_LEVEL_LOW>;
+};
+
+&cru {
+	assigned-clocks =
+		<&cru PLL_GPLL>, <&cru PLL_CPLL>,
+		<&cru PLL_NPLL>,
+		<&cru ACLK_PERIHP>, <&cru HCLK_PERIHP>,
+		<&cru PCLK_PERIHP>,
+		<&cru ACLK_PERILP0>, <&cru HCLK_PERILP0>,
+		<&cru PCLK_PERILP0>, <&cru ACLK_CCI>,
+		<&cru HCLK_PERILP1>, <&cru PCLK_PERILP1>,
+		<&cru ACLK_VIO>,
+		<&cru ACLK_GIC_PRE>,
+		<&cru PCLK_DDR>,
+		<&cru ACLK_HDCP>;
+	assigned-clock-rates =
+		<600000000>, <1600000000>,
+		<1000000000>,
+		<150000000>, <75000000>,
+		<37500000>,
+		<100000000>, <100000000>,
+		<50000000>, <800000000>,
+		<100000000>, <50000000>,
+		<400000000>,
+		<200000000>,
+		<200000000>,
+		<400000000>;
+};
+
+&gpio_keys {
+	pinctrl-names = "default";
+	pinctrl-0 = <&bt_host_wake_l>, <&pen_eject_odl>;
+
+	pen-insert {
+		label = "Pen Insert";
+		/* Insert = low, eject = high */
+		gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
+		linux,code = <SW_PEN_INSERTED>;
+		linux,input-type = <EV_SW>;
+		wakeup-source;
+	};
+};
+
+&i2c_tunnel {
+	google,remote-bus = <0>;
+};
+
+&io_domains {
+	bt656-supply = <&pp1800_s0>;		/* APIO2_VDD;  2a 2b */
+	audio-supply = <&pp1800_s0>;		/* APIO5_VDD;  3d 4a */
+	gpio1830-supply = <&pp1800_s0>;		/* APIO4_VDD;  4c 4d */
+};
+
+&max98357a {
+	sdmode-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
+};
+
+&mipi_dsi {
+	status = "okay";
+	clock-master;
+
+	ports {
+		mipi_out: port at 1 {
+			reg = <1>;
+
+			mipi_out_panel: endpoint {
+				remote-endpoint = <&mipi_in_panel>;
+			};
+		};
+	};
+
+	mipi_panel: panel at 0 {
+		/* 2 different panels are used, compatibles are in dts files */
+		reg = <0>;
+		backlight = <&backlight>;
+		enable-gpios = <&gpio4 25 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&display_rst_l>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+
+				mipi_in_panel: endpoint {
+					remote-endpoint = <&mipi_out_panel>;
+				};
+			};
+
+			port at 1 {
+				reg = <1>;
+
+				mipi1_in_panel: endpoint at 1 {
+					remote-endpoint = <&mipi1_out_panel>;
+				};
+			};
+		};
+	};
+};
+
+&mipi_dsi1 {
+	status = "okay";
+
+	ports {
+		mipi1_out: port at 1 {
+			reg = <1>;
+
+			mipi1_out_panel: endpoint {
+				remote-endpoint = <&mipi1_in_panel>;
+			};
+		};
+	};
+};
+
+&pcie0 {
+	ep-gpios = <&gpio0 3 GPIO_ACTIVE_HIGH>;
+
+	/* PERST# asserted in S3 */
+	pcie-reset-suspend = <1>;
+
+	vpcie3v3-supply = <&wlan_3v3>;
+	vpcie1v8-supply = <&pp1800_pcie>;
+};
+
+&sdmmc {
+	cd-gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
+};
+
+&sound {
+	rockchip,codec = <&max98357a &dmic &codec &cdn_dp>;
+};
+
+&spi2 {
+	status = "okay";
+};
+
+&wake_on_bt {
+	gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
+};
+
+/* PINCTRL OVERRIDES */
+&ec_ap_int_l {
+	rockchip,pins = <1 18 RK_FUNC_GPIO &pcfg_pull_up>;
+};
+
+&ap_fw_wp {
+	rockchip,pins = <0 13 RK_FUNC_GPIO &pcfg_pull_none>;
+};
+
+&bl_en {
+	rockchip,pins = <4 21 RK_FUNC_GPIO &pcfg_pull_none>;
+};
+
+&bt_host_wake_l {
+	rockchip,pins = <1 2 RK_FUNC_GPIO &pcfg_pull_up>;
+};
+
+&ec_ap_int_l {
+	rockchip,pins = <1 18 RK_FUNC_GPIO &pcfg_pull_up>;
+};
+
+&headset_int_l {
+	rockchip,pins = <1 23 RK_FUNC_GPIO &pcfg_pull_up>;
+};
+
+&i2s0_8ch_bus {
+	rockchip,pins =
+		<3 24 RK_FUNC_1 &pcfg_pull_none_6ma>,
+		<3 25 RK_FUNC_1 &pcfg_pull_none_6ma>,
+		<3 26 RK_FUNC_1 &pcfg_pull_none_6ma>,
+		<3 27 RK_FUNC_1 &pcfg_pull_none_6ma>,
+		<3 31 RK_FUNC_1 &pcfg_pull_none_6ma>,
+		<4 0 RK_FUNC_1 &pcfg_pull_none_6ma>;
+};
+
+/* there is no external pull up, so need to set this pin pull up */
+&sdmmc_cd_gpio {
+	rockchip,pins = <1 11 RK_FUNC_GPIO &pcfg_pull_up>;
+};
+
+&sd_pwr_1800_sel {
+	rockchip,pins = <2 28 RK_FUNC_GPIO &pcfg_pull_up>;
+};
+
+&sdmode_en {
+	rockchip,pins = <0 2 RK_FUNC_GPIO &pcfg_pull_down>;
+};
+
+&touch_reset_l {
+	rockchip,pins = <0 10 RK_FUNC_GPIO &pcfg_pull_down>;
+};
+
+&touch_int_l {
+	rockchip,pins = <1 4 RK_FUNC_GPIO &pcfg_pull_down>;
+};
+
+&pinctrl {
+	pinctrl-0 = <
+		&ap_pwroff	/* AP will auto-assert this when in S3 */
+		&clk_32k	/* This pin is always 32k on gru boards */
+		&wlan_rf_kill_1v8_l
+	>;
+
+	pcfg_pull_none_6ma: pcfg-pull-none-6ma {
+		bias-disable;
+		drive-strength = <6>;
+	};
+
+	camera {
+		pp1250_cam_en: pp1250-dvdd {
+			rockchip,pins = <2 4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		pp2800_cam_en: pp2800-avdd {
+			rockchip,pins = <2 24 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		ucam_rst: ucam_rst {
+			rockchip,pins = <2 3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		wcam_rst: wcam_rst {
+			rockchip,pins = <2 5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	digitizer {
+		pen_int_odl: pen-int-odl {
+			rockchip,pins = <1 0 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		pen_reset_l: pen-reset-l {
+			rockchip,pins = <0 12 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	discrete-regulators {
+		display_rst_l: display-rst-l {
+			rockchip,pins = <4 25 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
+		ppvarp_lcd_en: ppvarp-lcd-en {
+			rockchip,pins = <4 27 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		ppvarn_lcd_en: ppvarn-lcd-en {
+			rockchip,pins = <4 28 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	dmic {
+		dmic_en: dmic-en {
+			rockchip,pins = <4 3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pen {
+		pen_eject_odl: pen-eject-odl {
+			rockchip,pins = <1 1 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	tpm {
+		h1_int_od_l: h1-int-od-l {
+			rockchip,pins = <1 17 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+};
+
+&wifi {
+	bt_en_1v8_l: bt-en-1v8-l {
+		rockchip,pins = <0 8 RK_FUNC_GPIO &pcfg_pull_none>;
+	};
+
+	wlan_pd_1v8_l: wlan-pd-1v8-l {
+		rockchip,pins = <0 4 RK_FUNC_GPIO &pcfg_pull_none>;
+	};
+
+	/* Default pull-up, but just to be clear */
+	wlan_rf_kill_1v8_l: wlan-rf-kill-1v8-l {
+		rockchip,pins = <0 5 RK_FUNC_GPIO &pcfg_pull_up>;
+	};
+
+	wifi_perst_l: wifi-perst-l {
+		rockchip,pins = <0 3 RK_FUNC_GPIO &pcfg_pull_none>;
+	};
+
+	wlan_host_wake_l: wlan-host-wake-l {
+		rockchip,pins = <1 3 RK_FUNC_GPIO &pcfg_pull_up>;
+	};
+};
-- 
2.18.0
