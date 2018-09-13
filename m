From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Thu, 13 Sep 2018 23:35:42 +0530
Subject: [PATCH v3 1/4] arm64: dts: rockchip: Split out common nodes for
 Rock960 based boards
In-Reply-To: <20180913180545.29756-1-manivannan.sadhasivam@linaro.org>
References: <20180913180545.29756-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180913180545.29756-2-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the same family members of Rock960 boards (Rock960 and Ficus)
share the same configuration, split out the common nodes into a common
dtsi file for reducing code duplication. The board specific nodes for
Ficus boards are then placed in corresponding board DTS file.

Below are some of the key differences between both Rock960 and Ficus
boards:

1. Different host enable GPIO for USB
2. Different power and reset GPIO for PCI-E
3. No Ethernet port on Rock960

Only the properties which differ between both boards are placed in the
board specific dts and the reset of the nodes are placed in common dtsi
file.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-ficus.dts | 524 +----------------
 .../boot/dts/rockchip/rk3399-rock960.dtsi     | 541 ++++++++++++++++++
 2 files changed, 546 insertions(+), 519 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
index 8978d924eb83..cce266da28cd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
@@ -7,8 +7,7 @@
  */
 
 /dts-v1/;
-#include "rk3399.dtsi"
-#include "rk3399-opp.dtsi"
+#include "rk3399-rock960.dtsi"
 
 / {
 	model = "96boards RK3399 Ficus";
@@ -24,97 +23,6 @@
 		clock-output-names = "clkin_gmac";
 		#clock-cells = <0>;
 	};
-
-	vcc1v8_s0: vcc1v8-s0 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc1v8_s0";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-always-on;
-	};
-
-	vcc_sys: vcc-sys {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_sys";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
-	};
-
-	vcc3v3_sys: vcc3v3-sys {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc3v3_sys";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-		vin-supply = <&vcc_sys>;
-	};
-
-	vcc3v3_pcie: vcc3v3-pcie-regulator {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio1 24 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pcie_drv>;
-		regulator-boot-on;
-		regulator-name = "vcc3v3_pcie";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		vin-supply = <&vcc3v3_sys>;
-	};
-
-	vcc5v0_host: vcc5v0-host-regulator {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio4 27 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&host_vbus_drv>;
-		regulator-name = "vcc5v0_host";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
-		vin-supply = <&vcc_sys>;
-	};
-
-	vdd_log: vdd-log {
-		compatible = "pwm-regulator";
-		pwms = <&pwm2 0 25000 0>;
-		regulator-name = "vdd_log";
-		regulator-min-microvolt = <800000>;
-		regulator-max-microvolt = <1400000>;
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&vcc_sys>;
-	};
-
-};
-
-&cpu_l0 {
-	cpu-supply = <&vdd_cpu_l>;
-};
-
-&cpu_l1 {
-	cpu-supply = <&vdd_cpu_l>;
-};
-
-&cpu_l2 {
-	cpu-supply = <&vdd_cpu_l>;
-};
-
-&cpu_l3 {
-	cpu-supply = <&vdd_cpu_l>;
-};
-
-&cpu_b0 {
-	cpu-supply = <&vdd_cpu_b>;
-};
-
-&cpu_b1 {
-	cpu-supply = <&vdd_cpu_b>;
-};
-
-&emmc_phy {
-	status = "okay";
 };
 
 &gmac {
@@ -133,279 +41,8 @@
 	status = "okay";
 };
 
-&hdmi {
-	ddc-i2c-bus = <&i2c3>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&hdmi_cec>;
-	status = "okay";
-};
-
-&i2c0 {
-	clock-frequency = <400000>;
-	i2c-scl-rising-time-ns = <168>;
-	i2c-scl-falling-time-ns = <4>;
-	status = "okay";
-
-	vdd_cpu_b: regulator at 40 {
-		compatible = "silergy,syr827";
-		reg = <0x40>;
-		fcs,suspend-voltage-selector = <1>;
-		regulator-name = "vdd_cpu_b";
-		regulator-min-microvolt = <712500>;
-		regulator-max-microvolt = <1500000>;
-		regulator-ramp-delay = <1000>;
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&vcc_sys>;
-		status = "okay";
-
-		regulator-state-mem {
-			regulator-off-in-suspend;
-		};
-	};
-
-	vdd_gpu: regulator at 41 {
-		compatible = "silergy,syr828";
-		reg = <0x41>;
-		fcs,suspend-voltage-selector = <1>;
-		regulator-name = "vdd_gpu";
-		regulator-min-microvolt = <712500>;
-		regulator-max-microvolt = <1500000>;
-		regulator-ramp-delay = <1000>;
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&vcc_sys>;
-		regulator-state-mem {
-			regulator-off-in-suspend;
-		};
-	};
-
-	rk808: pmic at 1b {
-		compatible = "rockchip,rk808";
-		reg = <0x1b>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pmic_int_l>;
-		rockchip,system-power-controller;
-		wakeup-source;
-		#clock-cells = <1>;
-		clock-output-names = "xin32k", "rk808-clkout2";
-
-		vcc1-supply = <&vcc_sys>;
-		vcc2-supply = <&vcc_sys>;
-		vcc3-supply = <&vcc_sys>;
-		vcc4-supply = <&vcc_sys>;
-		vcc6-supply = <&vcc_sys>;
-		vcc7-supply = <&vcc_sys>;
-		vcc8-supply = <&vcc3v3_sys>;
-		vcc9-supply = <&vcc_sys>;
-		vcc10-supply = <&vcc_sys>;
-		vcc11-supply = <&vcc_sys>;
-		vcc12-supply = <&vcc3v3_sys>;
-		vddio-supply = <&vcc_1v8>;
-
-		regulators {
-			vdd_center: DCDC_REG1 {
-				regulator-name = "vdd_center";
-				regulator-min-microvolt = <750000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vdd_cpu_l: DCDC_REG2 {
-				regulator-name = "vdd_cpu_l";
-				regulator-min-microvolt = <750000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vcc_ddr: DCDC_REG3 {
-				regulator-name = "vcc_ddr";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-state-mem {
-					regulator-on-in-suspend;
-				};
-			};
-
-			vcc_1v8: DCDC_REG4 {
-				regulator-name = "vcc_1v8";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1800000>;
-				};
-			};
-
-			vcc1v8_dvp: LDO_REG1 {
-				regulator-name = "vcc1v8_dvp";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1800000>;
-				};
-			};
-
-			vcca1v8_hdmi: LDO_REG2 {
-				regulator-name = "vcca1v8_hdmi";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1800000>;
-				};
-			};
-
-			vcca_1v8: LDO_REG3 {
-				regulator-name = "vcca_1v8";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1800000>;
-				};
-			};
-
-			vcc_sd: LDO_REG4 {
-				regulator-name = "vcc_sd";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3300000>;
-				};
-			};
-
-			vcc3v0_sd: LDO_REG5 {
-				regulator-name = "vcc3v0_sd";
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3000000>;
-				};
-			};
-
-			vcc_1v5: LDO_REG6 {
-				regulator-name = "vcc_1v5";
-				regulator-min-microvolt = <1500000>;
-				regulator-max-microvolt = <1500000>;
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1500000>;
-				};
-			};
-
-			vcca0v9_hdmi: LDO_REG7 {
-				regulator-name = "vcca0v9_hdmi";
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <900000>;
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <900000>;
-				};
-			};
-
-			vcc_3v0: LDO_REG8 {
-				regulator-name = "vcc_3v0";
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3000000>;
-				};
-			};
-
-			vcc3v3_s3: SWITCH_REG1 {
-				regulator-name = "vcc3v3_s3";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-state-mem {
-					regulator-on-in-suspend;
-				};
-			};
-
-			vcc3v3_s0: SWITCH_REG2 {
-				regulator-name = "vcc3v3_s0";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-state-mem {
-					regulator-on-in-suspend;
-				};
-			};
-		};
-	};
-};
-
-&i2c1 {
-	status = "okay";
-};
-
-&i2c2 {
-	status = "okay";
-};
-
-&i2c3 {
-	status = "okay";
-};
-
-&i2c4 {
-	status = "okay";
-};
-
-&io_domains {
-	bt656-supply = <&vcc1v8_s0>; /* bt656_gpio2ab_ms */
-	audio-supply = <&vcc1v8_s0>; /* audio_gpio3d4a_ms */
-	sdmmc-supply = <&vcc_sd>; /* sdmmc_gpio4b_ms */
-	gpio1830-supply = <&vcc_3v0>; /* gpio1833_gpio4cd_ms */
-	status = "okay";
-};
-
-&pcie_phy {
-	status = "okay";
-};
-
 &pcie0 {
 	ep-gpios = <&gpio4 RK_PD4 GPIO_ACTIVE_HIGH>;
-	num-lanes = <4>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pcie_clkreqn_cpm>;
-	vpcie3v3-supply = <&vcc3v3_pcie>;
-	status = "okay";
-};
-
-&pmu_io_domains {
-	pmu1830-supply = <&vcc_1v8>;
-	status = "okay";
 };
 
 &pinctrl {
@@ -416,31 +53,6 @@
 		};
 	};
 
-	sdmmc {
-		sdmmc_bus1: sdmmc-bus1 {
-			rockchip,pins =
-				<4 8 RK_FUNC_1 &pcfg_pull_up_8ma>;
-		};
-
-		sdmmc_bus4: sdmmc-bus4 {
-			rockchip,pins =
-				<4 8 RK_FUNC_1 &pcfg_pull_up_8ma>,
-				<4 9 RK_FUNC_1 &pcfg_pull_up_8ma>,
-				<4 10 RK_FUNC_1 &pcfg_pull_up_8ma>,
-				<4 11 RK_FUNC_1 &pcfg_pull_up_8ma>;
-		};
-
-		sdmmc_clk: sdmmc-clk {
-			rockchip,pins =
-				<4 12 RK_FUNC_1 &pcfg_pull_none_18ma>;
-		};
-
-		sdmmc_cmd: sdmmc-cmd {
-			rockchip,pins =
-				<4 13 RK_FUNC_1 &pcfg_pull_up_8ma>;
-		};
-	};
-
 	pcie {
 		pcie_drv: pcie-drv {
 			rockchip,pins =
@@ -448,23 +60,6 @@
 			};
 	};
 
-	pmic {
-		pmic_int_l: pmic-int-l {
-			rockchip,pins =
-				<1 21 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-
-		vsel1_gpio: vsel1-gpio {
-			rockchip,pins =
-				<1 17 RK_FUNC_GPIO &pcfg_pull_down>;
-		};
-
-		vsel2_gpio: vsel2-gpio {
-			rockchip,pins =
-				<1 14 RK_FUNC_GPIO &pcfg_pull_down>;
-		};
-	};
-
 	usb2 {
 		host_vbus_drv: host-vbus-drv {
 			rockchip,pins =
@@ -473,127 +68,18 @@
 	};
 };
 
-&pwm2 {
-	status = "okay";
-};
-
-&pwm3 {
-	status = "okay";
-};
-
-&sdhci {
-	bus-width = <8>;
-	mmc-hs400-1_8v;
-	mmc-hs400-enhanced-strobe;
-	non-removable;
-	status = "okay";
-};
-
-&sdmmc {
-	bus-width = <4>;
-	cap-mmc-highspeed;
-	cap-sd-highspeed;
-	clock-frequency = <100000000>;
-	clock-freq-min-max = <100000 100000000>;
-	disable-wp;
-	sd-uhs-sdr104;
-	vqmmc-supply = <&vcc_sd>;
-	card-detect-delay = <800>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
-	status = "okay";
-};
-
-&tcphy0 {
-	status = "okay";
-};
-
-&tcphy1 {
-	status = "okay";
-};
-
-&u2phy0 {
-	status = "okay";
-};
-
-&u2phy1 {
-	status = "okay";
-};
-
-&u2phy0_host {
-	phy-supply = <&vcc5v0_host>;
-	status = "okay";
-};
-
-&u2phy1_host {
-	phy-supply = <&vcc5v0_host>;
-	status = "okay";
-};
-
-&u2phy0_otg {
-	status = "okay";
-};
-
-&u2phy1_otg {
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_xfer &uart0_cts>;
-	status = "okay";
-};
-
-&uart2 {
-	status = "okay";
-};
-
-&usb_host0_ehci {
-	status = "okay";
-};
-
-&usb_host0_ohci {
-	status = "okay";
-};
-
-&usb_host1_ehci {
-	status = "okay";
-};
-
-&usb_host1_ohci {
-	status = "okay";
-};
-
-&usbdrd3_0 {
-	status = "okay";
-};
-
 &usbdrd_dwc3_0 {
-	status = "okay";
 	dr_mode = "host";
 };
 
-&usbdrd3_1 {
-	status = "okay";
-};
-
 &usbdrd_dwc3_1 {
-	status = "okay";
 	dr_mode = "host";
 };
 
-&vopb {
-	status = "okay";
-};
-
-&vopb_mmu {
-	status = "okay";
-};
-
-&vopl {
-	status = "okay";
+&vcc3v3_pcie {
+	gpio = <&gpio1 24 GPIO_ACTIVE_HIGH>;
 };
 
-&vopl_mmu {
-	status = "okay";
+&vcc5v0_host {
+	gpio = <&gpio4 27 GPIO_ACTIVE_HIGH>;
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
new file mode 100644
index 000000000000..cc9c373f3a37
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
@@ -0,0 +1,541 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2018 Collabora Ltd.
+ * Copyright (c) 2018 Fuzhou Rockchip Electronics Co., Ltd.
+ * Copyright (c) 2018 Linaro Ltd.
+ */
+
+#include "rk3399.dtsi"
+#include "rk3399-opp.dtsi"
+
+/ {
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
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie_drv>;
+		regulator-boot-on;
+		regulator-name = "vcc3v3_pcie";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc3v3_sys>;
+	};
+
+	vcc5v0_host: vcc5v0-host-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&host_vbus_drv>;
+		regulator-name = "vcc5v0_host";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		vin-supply = <&vcc_sys>;
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
+&hdmi {
+	ddc-i2c-bus = <&i2c3>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdmi_cec>;
+	status = "okay";
+};
+
+&i2c0 {
+	clock-frequency = <400000>;
+	i2c-scl-rising-time-ns = <168>;
+	i2c-scl-falling-time-ns = <4>;
+	status = "okay";
+
+	vdd_cpu_b: regulator at 40 {
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
+		status = "okay";
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+
+	vdd_gpu: regulator at 41 {
+		compatible = "silergy,syr828";
+		reg = <0x41>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-name = "vdd_gpu";
+		regulator-min-microvolt = <712500>;
+		regulator-max-microvolt = <1500000>;
+		regulator-ramp-delay = <1000>;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vcc_sys>;
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
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
+	bt656-supply = <&vcc1v8_s0>; /* bt656_gpio2ab_ms */
+	audio-supply = <&vcc1v8_s0>; /* audio_gpio3d4a_ms */
+	sdmmc-supply = <&vcc_sd>; /* sdmmc_gpio4b_ms */
+	gpio1830-supply = <&vcc_3v0>; /* gpio1833_gpio4cd_ms */
+	status = "okay";
+};
+
+&pcie_phy {
+	status = "okay";
+};
+
+&pcie0 {
+	num-lanes = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_clkreqn_cpm>;
+	vpcie3v3-supply = <&vcc3v3_pcie>;
+	status = "okay";
+};
+
+&pmu_io_domains {
+	pmu1830-supply = <&vcc_1v8>;
+	status = "okay";
+};
+
+&pinctrl {
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
+&tcphy0 {
+	status = "okay";
+};
+
+&tcphy1 {
+	status = "okay";
+};
+
+&u2phy0 {
+	status = "okay";
+};
+
+&u2phy1 {
+	status = "okay";
+};
+
+&u2phy0_host {
+	phy-supply = <&vcc5v0_host>;
+	status = "okay";
+};
+
+&u2phy1_host {
+	phy-supply = <&vcc5v0_host>;
+	status = "okay";
+};
+
+&u2phy0_otg {
+	status = "okay";
+};
+
+&u2phy1_otg {
+	status = "okay";
+};
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
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
+&usbdrd3_0 {
+	status = "okay";
+};
+
+&usbdrd_dwc3_0 {
+	status = "okay";
+};
+
+&usbdrd3_1 {
+	status = "okay";
+};
+
+&usbdrd_dwc3_1 {
+	status = "okay";
+};
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
-- 
2.17.1
