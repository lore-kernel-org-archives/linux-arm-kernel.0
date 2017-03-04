From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat,  4 Mar 2017 10:52:13 +0100
Subject: [PATCH v2 1/1] ARM64: dts: meson-gxl: improve support for the P212
 reference design
In-Reply-To: <20170304095213.8221-1-martin.blumenstingl@googlemail.com>
References: <20170219224114.17201-1-martin.blumenstingl@googlemail.com>
 <20170304095213.8221-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170304095213.8221-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Amlogic P212 reference design is used by other devices as well, such
as (for example) the Khadas VIM boards. Thus this patch adds and moves
all common entries from meson-gxl-s905x-p212.dts to a new, separate
meson-gxl-s905x-p212.dtsi (which can be re-used on boards such as the
Khadas VIM).
Support for all boards based on the P212 reference design includes:
- enabling IR support
- enabling the SAR ADC (SARADC_CH1 is connected to a resistor which
  indicates the hardware revision, a similar design is found on the
  Khadas VIM boards)
- all MMC controllers (which means that SDIO wifi, the SD card and the
  eMMC are now supported)
- pwm_ef as dependency for the SDIO wifi modules
- uart_A which is connected to the bluetooth module (the bluetooth
  module itself is not enabled yet due to missing devicetree bindings
  for the Broadcom serial bluetooth devices)
- uart_AO is moved to the .dtsi (as all known devices use it as their
  boot-console)

Specific to the P212 board:
- this also enables the CVBS connector (which is not available on the
  Khadas VIM boards for example)
- Realtek based SDIO wifi (instead of Broadcom which most other devices
  use)

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Tested-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dts      |  21 +--
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dtsi     | 173 +++++++++++++++++++++
 2 files changed, 185 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
index 9639f012b02b..db31e093f40e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
@@ -43,23 +43,26 @@
 
 /dts-v1/;
 
-#include "meson-gxl-s905x.dtsi"
+#include "meson-gxl-s905x-p212.dtsi"
 
 / {
 	compatible = "amlogic,p212", "amlogic,s905x", "amlogic,meson-gxl";
 	model = "Amlogic Meson GXL (S905X) P212 Development Board";
 
-	aliases {
-		serial0 = &uart_AO;
-	};
+	cvbs-connector {
+		compatible = "composite-video-connector";
 
-	chosen {
-		stdout-path = "serial0:115200n8";
+		port {
+			cvbs_connector_in: endpoint {
+				remote-endpoint = <&cvbs_vdac_out>;
+			};
+		};
 	};
+};
 
-	memory at 0 {
-		device_type = "memory";
-		reg = <0x0 0x0 0x0 0x80000000>;
+&cvbs_vdac_port {
+	cvbs_vdac_out: endpoint {
+		remote-endpoint = <&cvbs_connector_in>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
new file mode 100644
index 000000000000..f3eea8e89d12
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
@@ -0,0 +1,173 @@
+/*
+ * Copyright (c) 2016 Martin Blumenstingl <martin.blumenstingl@googlemail.com>.
+ * Based on meson-gx-p23x-q20x.dtsi:
+ * - Copyright (c) 2016 Endless Computers, Inc.
+ *   Author: Carlo Caione <carlo@endlessm.com>
+ * - Copyright (c) 2016 BayLibre, SAS.
+ *   Author: Neil Armstrong <narmstrong@baylibre.com>
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+/* Common DTSI for devices which are based on the P212 reference board. */
+
+#include "meson-gxl-s905x.dtsi"
+
+/ {
+	aliases {
+		serial0 = &uart_AO;
+		serial1 = &uart_A;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory at 0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;
+	};
+
+	vddio_boot: regulator-vddio_boot {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_BOOT";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	vddao_3v3: regulator-vddao_3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDAO_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	vddio_ao18: regulator-vddio_ao18 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_AO18";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	vcc_3v3: regulator-vcc_3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
+	};
+
+	wifi32k: wifi32k {
+		compatible = "pwm-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
+		clocks = <&wifi32k>;
+		clock-names = "ext_clock";
+	};
+};
+
+&ethmac {
+	status = "okay";
+};
+
+&ir {
+	status = "okay";
+	pinctrl-0 = <&remote_input_ao_pins>;
+	pinctrl-names = "default";
+};
+
+&saradc {
+	status = "okay";
+	vref-supply = <&vddio_ao18>;
+};
+
+/* Wireless SDIO Module */
+&sd_emmc_a {
+	status = "okay";
+	pinctrl-0 = <&sdio_pins>;
+	pinctrl-names = "default";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	bus-width = <4>;
+	cap-sd-highspeed;
+	max-frequency = <100000000>;
+
+	non-removable;
+	disable-wp;
+
+	mmc-pwrseq = <&sdio_pwrseq>;
+
+	vmmc-supply = <&vddao_3v3>;
+	vqmmc-supply = <&vddio_boot>;
+};
+
+/* SD card */
+&sd_emmc_b {
+	status = "okay";
+	pinctrl-0 = <&sdcard_pins>;
+	pinctrl-names = "default";
+
+	bus-width = <4>;
+	cap-sd-highspeed;
+	max-frequency = <100000000>;
+	disable-wp;
+
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
+	cd-inverted;
+
+	vmmc-supply = <&vddao_3v3>;
+	vqmmc-supply = <&vddio_boot>;
+};
+
+/* eMMC */
+&sd_emmc_c {
+	status = "okay";
+	pinctrl-0 = <&emmc_pins>;
+	pinctrl-names = "default";
+
+	bus-width = <8>;
+	cap-sd-highspeed;
+	cap-mmc-highspeed;
+	max-frequency = <200000000>;
+	non-removable;
+	disable-wp;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+
+	mmc-pwrseq = <&emmc_pwrseq>;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&vddio_boot>;
+};
+
+&pwm_ef {
+	status = "okay";
+	pinctrl-0 = <&pwm_e_pins>;
+	pinctrl-names = "default";
+	clocks = <&clkc CLKID_FCLK_DIV4>;
+	clock-names = "clkin0";
+};
+
+/* This is connected to the Bluetooth module: */
+&uart_A {
+	status = "okay";
+	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+};
+
+&uart_AO {
+	status = "okay";
+	pinctrl-0 = <&uart_ao_a_pins>;
+	pinctrl-names = "default";
+};
-- 
2.12.0
