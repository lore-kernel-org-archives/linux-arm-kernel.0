From: ezequiel@collabora.com (Ezequiel Garcia)
Date: Mon, 18 Jun 2018 19:08:04 -0300
Subject: [PATCH] arm64: dts: rockchip: add 96boards RK3399 Ficus board
Message-ID: <20180618220804.18468-1-ezequiel@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RK3399 Ficus board is an Enterprise Edition board
manufactured by Vamrs Ltd., based on the Rockchip RK3399 SoC.

The board exposes a bunch of nice peripherals, including
SATA, HDMI, MIPI CSI, Ethernet, WiFi, USB 2.0, USB 3.0
and PCIe.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
I am not including USB support because I cannot seem
to make it work.

[    1.677293] dwc3 fe800000.dwc3: Failed to get clk 'ref': -2
[    1.677937] dwc3 fe800000.dwc3: Configuration mismatch. dr_mode forced to host
[    1.678602] dwc3 fe800000.dwc3: failed to initialize core
[    1.679409] dwc3 fe900000.dwc3: Failed to get clk 'ref': -2
[    1.679988] dwc3 fe900000.dwc3: failed to initialize core

I am under the impression it is related to:

commit fe8abf332b8f66868013cfcd6bfe727136a2ab5f
Author: Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed May 16 11:41:07 2018 +0900

    usb: dwc3: support clocks and resets for DWC3 core

Any ideas? Would like to sort out the USB issue before
merging.

Also, I should probably split the rk3399.dtsi change.

 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 arch/arm64/boot/dts/rockchip/rk3399-ficus.dts | 564 ++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi      |   9 +
 3 files changed, 574 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-ficus.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 48a83f882947..2811fb701f12 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -9,6 +9,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-orion-r68-meta.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-px5-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-r88.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-evb.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-ficus.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-firefly.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-kevin.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
new file mode 100644
index 000000000000..17471b4b7a14
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
@@ -0,0 +1,564 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2018 Collabora Ltd.
+ * Copyright (c) 2018 Fuzhou Rockchip Electronics Co., Ltd.
+ */
+
+/dts-v1/;
+#include "rk3399.dtsi"
+#include "rk3399-opp.dtsi"
+
+/ {
+	model = "96boards RK3399 Ficus";
+	compatible = "vamrs,ficus", "rockchip,rk3399";
+
+	chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+
+	clkin_gmac: external-gmac-clock {
+		compatible = "fixed-clock";
+		clock-frequency = <125000000>;
+		clock-output-names = "clkin_gmac";
+		#clock-cells = <0>;
+	};
+
+	usb_typec_vbus: usb-typec-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "typec-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio1 3 GPIO_ACTIVE_HIGH>;
+	};
+
+	vcc1v8_s0: vcc1v8-s0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc1v8_s0";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	vcc_sys: vcc-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_sys";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	vcc_phy: vcc-phy-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_phy";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vcc3v3_sys: vcc3v3-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_sys";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		vin-supply = <&vcc_sys>;
+	};
+
+	vcc3v3_pcie: vcc3v3-pcie-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio1 24 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie_drv>;
+		regulator-boot-on;
+		regulator-name = "vcc3v3_pcie";
+		vin-supply = <&vcc3v3_sys>;
+	};
+
+	vcc5v0_host: vcc5v0-host-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio4 27 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&host_vbus_drv>;
+		regulator-name = "vcc5v0_host";
+		regulator-always-on;
+	};
+
+	vdd_log: vdd-log {
+		compatible = "pwm-regulator";
+		pwms = <&pwm2 0 25000 0>;
+		regulator-name = "vdd_log";
+		regulator-min-microvolt = <800000>;
+		regulator-max-microvolt = <1400000>;
+		regulator-always-on;
+		regulator-boot-on;
+
+		/* for rockchip boot on */
+		rockchip,pwm_id= <2>;
+		rockchip,pwm_voltage = <900000>;
+
+		vin-supply = <&vcc_sys>;
+	};
+
+};
+
+&cpu_l0 {
+	cpu-supply = <&vdd_cpu_l>;
+};
+
+&cpu_l1 {
+	cpu-supply = <&vdd_cpu_l>;
+};
+
+&cpu_l2 {
+	cpu-supply = <&vdd_cpu_l>;
+};
+
+&cpu_l3 {
+	cpu-supply = <&vdd_cpu_l>;
+};
+
+&cpu_b0 {
+	cpu-supply = <&vdd_cpu_b>;
+};
+
+&cpu_b1 {
+	cpu-supply = <&vdd_cpu_b>;
+};
+
+&emmc_phy {
+	status = "okay";
+};
+
+&gmac {
+	assigned-clocks = <&cru SCLK_RMII_SRC>;
+	assigned-clock-parents = <&clkin_gmac>;
+	clock_in_out = "input";
+	phy-supply = <&vcc_phy>;
+	phy-mode = "rgmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii_pins>;
+	snps,reset-gpio = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
+	snps,reset-active-low;
+	snps,reset-delays-us = <0 10000 50000>;
+	tx_delay = <0x28>;
+	rx_delay = <0x11>;
+	status = "okay";
+};
+
+&hdmi {
+	ddc-i2c-bus = <&i2c3>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdmi_cec>;
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+	i2c-scl-rising-time-ns = <168>;
+	i2c-scl-falling-time-ns = <4>;
+	clock-frequency = <400000>;
+
+	vdd_cpu_b: syr827 at 40 {
+		status = "okay";
+		compatible = "silergy,syr827";
+		reg = <0x40>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-name = "vdd_cpu_b";
+		regulator-min-microvolt = <712500>;
+		regulator-max-microvolt = <1500000>;
+		regulator-ramp-delay = <1000>;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vcc_sys>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+
+        vdd_gpu: regulator at 41 {
+                compatible = "silergy,syr828";
+                reg = <0x41>;
+                fcs,suspend-voltage-selector = <1>;
+                regulator-name = "vdd_gpu";
+                regulator-min-microvolt = <712500>;
+                regulator-max-microvolt = <1500000>;
+                regulator-ramp-delay = <1000>;
+                regulator-always-on;
+                regulator-boot-on;
+                vin-supply = <&vcc_sys>;
+
+                regulator-state-mem {
+                        regulator-off-in-suspend;
+                };
+        };
+
+	fusb0: fusb30x at 22 {
+		vbus-supply = <&usb_typec_vbus>;
+		compatible = "fairchild,fusb302";
+		reg = <0x22>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&fusb0_int>;
+		int-n-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
+		status = "okay";
+	};
+
+	rk808: pmic at 1b {
+		compatible = "rockchip,rk808";
+		reg = <0x1b>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_int_l>;
+		rockchip,system-power-controller;
+		wakeup-source;
+		#clock-cells = <1>;
+		clock-output-names = "xin32k", "rk808-clkout2";
+
+		vcc1-supply = <&vcc_sys>;
+		vcc2-supply = <&vcc_sys>;
+		vcc3-supply = <&vcc_sys>;
+		vcc4-supply = <&vcc_sys>;
+		vcc6-supply = <&vcc_sys>;
+		vcc7-supply = <&vcc_sys>;
+		vcc8-supply = <&vcc3v3_sys>;
+		vcc9-supply = <&vcc_sys>;
+		vcc10-supply = <&vcc_sys>;
+		vcc11-supply = <&vcc_sys>;
+		vcc12-supply = <&vcc3v3_sys>;
+		vddio-supply = <&vcc_1v8>;
+
+		regulators {
+			vdd_center: DCDC_REG1 {
+				regulator-name = "vdd_center";
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_cpu_l: DCDC_REG2 {
+				regulator-name = "vdd_cpu_l";
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <1350000>;
+				//regulator-ramp-delay = <6001>;
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_ddr: DCDC_REG3 {
+				regulator-name = "vcc_ddr";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vcc_1v8: DCDC_REG4 {
+				regulator-name = "vcc_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vcc1v8_dvp: LDO_REG1 {
+				regulator-name = "vcc1v8_dvp";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vcca1v8_hdmi: LDO_REG2 {
+				regulator-name = "vcca1v8_hdmi";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vcca_1v8: LDO_REG3 {
+				regulator-name = "vcca_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vcc_sd: LDO_REG4 {
+				regulator-name = "vcc_sd";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vcc3v0_sd: LDO_REG5 {
+				regulator-name = "vcc3v0_sd";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3000000>;
+				};
+			};
+
+			vcc_1v5: LDO_REG6 {
+				regulator-name = "vcc_1v5";
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1500000>;
+				};
+			};
+
+			vcca0v9_hdmi: LDO_REG7 {
+				regulator-name = "vcca0v9_hdmi";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <900000>;
+				};
+			};
+
+			vcc_3v0: LDO_REG8 {
+				regulator-name = "vcc_3v0";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3000000>;
+				};
+			};
+
+			vcc3v3_s3: SWITCH_REG1 {
+				regulator-name = "vcc3v3_s3";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vcc3v3_s0: SWITCH_REG2 {
+				regulator-name = "vcc3v3_s0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+		};
+	};
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&io_domains {
+	status = "okay";
+
+	bt656-supply = <&vcc1v8_s0>; /* bt656_gpio2ab_ms */
+	audio-supply = <&vcc1v8_s0>; /* audio_gpio3d4a_ms */
+	sdmmc-supply = <&vcc_sd>; /* sdmmc_gpio4b_ms */
+	gpio1830-supply = <&vcc_3v0>; /* gpio1833_gpio4cd_ms */
+};
+
+&pcie_phy {
+	status = "okay";
+};
+
+&pcie0 {
+	ep-gpios = <&gpio4 RK_PD4 GPIO_ACTIVE_HIGH>;
+	num-lanes = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_clkreqn_cpm>;
+	status = "okay";
+};
+
+&pmu_io_domains {
+	pmu1830-supply = <&vcc_1v8>;
+	status = "okay";
+};
+
+&pinctrl {
+	gmac {
+		rgmii_sleep_pins: rgmii-sleep-pins {
+			rockchip,pins =
+				<3 15 RK_FUNC_GPIO &pcfg_output_low>;
+		};
+	};
+
+	sdmmc {
+		sdmmc_bus1: sdmmc-bus1 {
+			rockchip,pins =
+				<4 8 RK_FUNC_1 &pcfg_pull_up_8ma>;
+		};
+
+		sdmmc_bus4: sdmmc-bus4 {
+			rockchip,pins =
+				<4 8 RK_FUNC_1 &pcfg_pull_up_8ma>,
+				<4 9 RK_FUNC_1 &pcfg_pull_up_8ma>,
+				<4 10 RK_FUNC_1 &pcfg_pull_up_8ma>,
+				<4 11 RK_FUNC_1 &pcfg_pull_up_8ma>;
+		};
+
+		sdmmc_clk: sdmmc-clk {
+			rockchip,pins =
+				<4 12 RK_FUNC_1 &pcfg_pull_none_18ma>;
+		};
+
+		sdmmc_cmd: sdmmc-cmd {
+			rockchip,pins =
+				<4 13 RK_FUNC_1 &pcfg_pull_up_8ma>;
+		};
+	};
+
+	pcie {
+		pcie_drv: pcie-drv {
+			rockchip,pins =
+				<1 24 RK_FUNC_GPIO &pcfg_pull_none>;
+			};
+	};
+
+	pmic {
+		pmic_int_l: pmic-int-l {
+			rockchip,pins =
+				<1 21 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		vsel1_gpio: vsel1-gpio {
+			rockchip,pins =
+				<1 17 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
+		vsel2_gpio: vsel2-gpio {
+			rockchip,pins =
+				<1 14 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+
+	usb2 {
+		host_vbus_drv: host-vbus-drv {
+			rockchip,pins =
+				<4 27 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	fusb30x {
+		fusb0_int: fusb0-int {
+			rockchip,pins =
+				<1 2 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+};
+
+&pwm2 {
+	status = "okay";
+};
+
+&pwm3 {
+	status = "okay";
+};
+
+&sdhci {
+	bus-width = <8>;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+	non-removable;
+	status = "okay";
+};
+
+&sdmmc {
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	clock-frequency = <100000000>;
+	clock-freq-min-max = <100000 100000000>;
+	disable-wp;
+	sd-uhs-sdr104;
+	vqmmc-supply = <&vcc_sd>;
+	card-detect-delay = <800>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_xfer &uart0_cts>;
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+
+&vopb {
+	status = "okay";
+};
+
+&vopb_mmu {
+	status = "okay";
+};
+
+&vopl {
+	status = "okay";
+};
+
+&vopl_mmu {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index adb037cd80fe..7169603590f5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1923,6 +1923,11 @@
 			drive-strength = <12>;
 		};
 
+                pcfg_pull_none_18ma: pcfg-pull-none-18ma {
+                        bias-disable;
+                        drive-strength = <18>;
+                };
+
 		pcfg_pull_up_8ma: pcfg-pull-up-8ma {
 			bias-pull-up;
 			drive-strength = <8>;
@@ -1948,6 +1953,10 @@
 			drive-strength = <13>;
 		};
 
+                pcfg_output_low: pcfg-output-low {
+                        output-low;
+                };
+
 		clock {
 			clk_32k: clk-32k {
 				rockchip,pins = <0 0 RK_FUNC_2 &pcfg_pull_none>;
-- 
2.17.1
