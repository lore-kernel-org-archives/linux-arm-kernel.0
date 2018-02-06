From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Tue, 6 Feb 2018 09:22:37 +0200
Subject: [PATCH v2 7/7] arm64: tegra: Add device tree for the Tegra194
 P2972-0000 board
In-Reply-To: <1517901757-15353-1-git-send-email-mperttunen@nvidia.com>
References: <1517901757-15353-1-git-send-email-mperttunen@nvidia.com>
Message-ID: <1517901757-15353-8-git-send-email-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree files for the Tegra194 P2972-0000 development board.
The board consists of the P2888 compute module and the P2822 baseboard.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/Makefile                |   1 +
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi     | 248 +++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts |  16 ++
 3 files changed, 265 insertions(+)
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts

diff --git a/arch/arm64/boot/dts/nvidia/Makefile b/arch/arm64/boot/dts/nvidia/Makefile
index 676aa2f238d1..7c13d7df484e 100644
--- a/arch/arm64/boot/dts/nvidia/Makefile
+++ b/arch/arm64/boot/dts/nvidia/Makefile
@@ -5,3 +5,4 @@ dtb-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210-p2371-2180.dtb
 dtb-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210-p2571.dtb
 dtb-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210-smaug.dtb
 dtb-$(CONFIG_ARCH_TEGRA_186_SOC) += tegra186-p2771-0000.dtb
+dtb-$(CONFIG_ARCH_TEGRA_194_SOC) += tegra194-p2972-0000.dtb
diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
new file mode 100644
index 000000000000..ecb034177fc2
--- /dev/null
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "tegra194.dtsi"
+
+#include <dt-bindings/mfd/max77620.h>
+
+/ {
+	model = "NVIDIA Tegra194 P2888 Processor Module";
+	compatible = "nvidia,p2888", "nvidia,tegra194";
+
+	aliases {
+		sdhci0 = "/cbb/sdhci at 3460000";
+		sdhci1 = "/cbb/sdhci at 3400000";
+		serial0 = &uartb;
+		i2c0 = "/bpmp/i2c";
+		i2c1 = "/cbb/i2c at 3160000";
+		i2c2 = "/cbb/i2c at c240000";
+		i2c3 = "/cbb/i2c at 3180000";
+		i2c4 = "/cbb/i2c at 3190000";
+		i2c5 = "/cbb/i2c at 31c0000";
+		i2c6 = "/cbb/i2c at c250000";
+		i2c7 = "/cbb/i2c at 31e0000";
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8";
+		stdout-path = "serial0:115200n8";
+	};
+
+	cbb {
+		serial at 3110000 {
+			status = "okay";
+		};
+
+		/* SDMMC1 (SD/MMC) */
+		sdhci at 3400000 {
+/*
+			cd-gpios = <&gpio TEGRA194_MAIN_GPIO(A, 0) GPIO_ACTIVE_LOW>;
+*/
+		};
+
+		/* SDMMC4 (eMMC) */
+		sdhci at 3460000 {
+			status = "okay";
+			bus-width = <8>;
+			non-removable;
+
+			vqmmc-supply = <&vdd_1v8ls>;
+			vmmc-supply = <&vdd_emmc_3v3>;
+		};
+
+		pmc at c360000 {
+			nvidia,invert-interrupt;
+		};
+	};
+
+	bpmp {
+		i2c {
+			status = "okay";
+
+			pmic: pmic at 3c {
+				compatible = "maxim,max20024";
+				reg = <0x3c>;
+
+				interrupts = <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
+				#interrupt-cells = <2>;
+				interrupt-controller;
+
+				#gpio-cells = <2>;
+				gpio-controller;
+
+				pinctrl-names = "default";
+				pinctrl-0 = <&max20024_default>;
+
+				max20024_default: pinmux {
+					gpio0 {
+						pins = "gpio0";
+						function = "gpio";
+					};
+
+					gpio1 {
+						pins = "gpio1";
+						function = "fps-out";
+						maxim,active-fps-source = <MAX77620_FPS_SRC_DEF>;
+					};
+
+					gpio2 {
+						pins = "gpio2";
+						function = "fps-out";
+						maxim,active-fps-source = <MAX77620_FPS_SRC_DEF>;
+					};
+
+					gpio3 {
+						pins = "gpio3";
+						function = "fps-out";
+						maxim,active-fps-source = <MAX77620_FPS_SRC_DEF>;
+					};
+
+					gpio4 {
+						pins = "gpio4";
+						function = "32k-out1";
+						drive-push-pull = <1>;
+					};
+
+					gpio6 {
+						pins = "gpio6";
+						function = "gpio";
+						drive-push-pull = <1>;
+					};
+
+					gpio7 {
+						pins = "gpio7";
+						function = "gpio";
+						drive-push-pull = <0>;
+					};
+				};
+
+				fps {
+					fps0 {
+						maxim,fps-event-source = <MAX77620_FPS_EVENT_SRC_EN0>;
+						maxim,shutdown-fps-time-period-us = <640>;
+					};
+
+					fps1 {
+						maxim,fps-event-source = <MAX77620_FPS_EVENT_SRC_EN1>;
+						maxim,shutdown-fps-time-period-us = <640>;
+						maxim,device-state-on-disabled-event = <MAX77620_FPS_INACTIVE_STATE_SLEEP>;
+					};
+
+					fps2 {
+						maxim,fps-event-source = <MAX77620_FPS_EVENT_SRC_EN0>;
+						maxim,shutdown-fps-time-period-us = <640>;
+					};
+				};
+
+				regulators {
+					in-sd0-supply = <&vdd_5v0_sys>;
+					in-sd1-supply = <&vdd_5v0_sys>;
+					in-sd2-supply = <&vdd_5v0_sys>;
+					in-sd3-supply = <&vdd_5v0_sys>;
+					in-sd4-supply = <&vdd_5v0_sys>;
+
+					in-ldo0-1-supply = <&vdd_5v0_sys>;
+					in-ldo2-supply = <&vdd_5v0_sys>;
+					in-ldo3-5-supply = <&vdd_5v0_sys>;
+					in-ldo4-6-supply = <&vdd_5v0_sys>;
+					in-ldo7-8-supply = <&vdd_1v8ls>;
+
+					sd0 {
+						regulator-name = "VDD_1V0";
+						regulator-min-microvolt = <1000000>;
+						regulator-max-microvolt = <1000000>;
+						regulator-always-on;
+						regulator-boot-on;
+					};
+
+					sd1 {
+						regulator-name = "VDD_1V8HS";
+						regulator-min-microvolt = <1800000>;
+						regulator-max-microvolt = <1800000>;
+						regulator-always-on;
+						regulator-boot-on;
+					};
+
+					vdd_1v8ls: sd2 {
+						regulator-name = "VDD_1V8LS";
+						regulator-min-microvolt = <1800000>;
+						regulator-max-microvolt = <1800000>;
+						regulator-always-on;
+						regulator-boot-on;
+					};
+
+					sd3 {
+						regulator-name = "VDD_1V8AO";
+						regulator-min-microvolt = <1800000>;
+						regulator-max-microvolt = <1800000>;
+						regulator-always-on;
+						regulator-boot-on;
+					};
+
+					sd4 {
+						regulator-name = "VDD_DDR_1V1";
+						regulator-min-microvolt = <1100000>;
+						regulator-max-microvolt = <1100000>;
+						regulator-always-on;
+						regulator-boot-on;
+					};
+
+					ldo0 {
+						regulator-name = "VDD_RTC";
+						regulator-min-microvolt = <800000>;
+						regulator-max-microvolt = <800000>;
+						regulator-always-on;
+						regulator-boot-on;
+					};
+
+					ldo2 {
+						regulator-name = "VDD_AO_3V3";
+						regulator-min-microvolt = <3300000>;
+						regulator-max-microvolt = <3300000>;
+						regulator-always-on;
+						regulator-boot-on;
+					};
+
+					vdd_emmc_3v3: ldo3 {
+						regulator-name = "VDD_EMMC_3V3";
+						regulator-min-microvolt = <3300000>;
+						regulator-max-microvolt = <3300000>;
+					};
+
+					ldo5 {
+						regulator-name = "VDD_USB_3V3";
+						regulator-min-microvolt = <3300000>;
+						regulator-max-microvolt = <3300000>;
+					};
+
+					ldo6 {
+						regulator-name = "VDD_SDIO_3V3";
+						regulator-min-microvolt = <3300000>;
+						regulator-max-microvolt = <3300000>;
+					};
+
+					ldo7 {
+						regulator-name = "VDD_CSI_1V2";
+						regulator-min-microvolt = <1200000>;
+						regulator-max-microvolt = <1200000>;
+					};
+				};
+			};
+		};
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		vdd_5v0_sys: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+
+			regulator-name = "VIN_SYS_5V0";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
new file mode 100644
index 000000000000..9ff3c18280c4
--- /dev/null
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "tegra194-p2888.dtsi"
+
+/ {
+	model = "NVIDIA Tegra194 P2972-0000 Development Board";
+	compatible = "nvidia,p2972-0000", "nvidia,tegra194";
+
+	cbb {
+		/* SDMMC1 (SD/MMC) */
+		sdhci at 3400000 {
+			status = "okay";
+		};
+	};
+};
-- 
2.1.4
