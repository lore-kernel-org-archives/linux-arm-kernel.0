From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 11 May 2018 10:03:40 +0800
Subject: [PATCH 3/3] arm64: dts: hi3798cv200: enable emmc support for poplar
 board
In-Reply-To: <1526004220-17030-1-git-send-email-shawn.guo@linaro.org>
References: <1526004220-17030-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1526004220-17030-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds pinctrl device pinconf at 8a21000, gpio-ranges for GPIO devices,
and then enables eMMC support for Hi3798CV200 Poplar board.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../boot/dts/hisilicon/hi3798cv200-poplar.dts      | 15 ++++
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi     | 74 +++++++++++++++-
 arch/arm64/boot/dts/hisilicon/poplar-pinctrl.dtsi  | 98 ++++++++++++++++++++++
 3 files changed, 184 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/boot/dts/hisilicon/poplar-pinctrl.dtsi

diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
index b0b790a5aa8d..d30f6eb8a5ee 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
@@ -11,6 +11,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include "hi3798cv200.dtsi"
+#include "poplar-pinctrl.dtsi"
 
 / {
 	model = "HiSilicon Poplar Development Board";
@@ -76,6 +77,20 @@
 	status = "okay";
 };
 
+&emmc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_pins_1 &emmc_pins_2
+		     &emmc_pins_3 &emmc_pins_4>;
+	fifo-depth = <256>;
+	clock-frequency = <200000000>;
+	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	non-removable;
+	bus-width = <8>;
+	status = "okay";
+};
+
 &gmac1 {
 	status = "okay";
 	#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
index c1723ef01cac..7c0fddd7c8cf 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
@@ -175,6 +175,46 @@
 			};
 		};
 
+		pmx0: pinconf at 8a21000 {
+			compatible = "pinconf-single";
+			reg = <0x8a21000 0x180>;
+			pinctrl-single,register-width = <32>;
+			pinctrl-single,function-mask = <7>;
+			pinctrl-single,gpio-range = <
+				&range 0  8 2  /* GPIO 0 */
+				&range 8  1 0  /* GPIO 1 */
+				&range 9  4 2
+				&range 13 1 0
+				&range 14 1 1
+				&range 15 1 0
+				&range 16 5 0  /* GPIO 2 */
+				&range 21 3 1
+				&range 24 4 1  /* GPIO 3 */
+				&range 28 2 2
+				&range 86 1 1
+				&range 87 1 0
+				&range 30 4 2  /* GPIO 4 */
+				&range 34 3 0
+				&range 37 1 2
+				&range 38 3 2  /* GPIO 6 */
+				&range 41 5 0
+				&range 46 8 1  /* GPIO 7 */
+				&range 54 8 1  /* GPIO 8 */
+				&range 64 7 1  /* GPIO 9 */
+				&range 71 1 0
+				&range 72 6 1  /* GPIO 10 */
+				&range 78 1 0
+				&range 79 1 1
+				&range 80 6 1  /* GPIO 11 */
+				&range 70 2 1
+				&range 88 8 0  /* GPIO 12 */
+			>;
+
+			range: gpio-range {
+				#pinctrl-single,gpio-range-cells = <3>;
+			};
+		};
+
 		uart0: serial at 8b00000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x8b00000 0x1000>;
@@ -274,12 +314,17 @@
 		};
 
 		emmc: mmc at 9830000 {
-			compatible = "snps,dw-mshc";
+			compatible = "hisilicon,hi3798cv200-dw-mshc";
 			reg = <0x9830000 0x10000>;
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&crg HISTB_MMC_CIU_CLK>,
-				 <&crg HISTB_MMC_BIU_CLK>;
-			clock-names = "ciu", "biu";
+				 <&crg HISTB_MMC_BIU_CLK>,
+				 <&crg HISTB_MMC_SAMPLE_CLK>,
+				 <&crg HISTB_MMC_DRV_CLK>;
+			clock-names = "ciu", "biu", "ciu-sample", "ciu-drive";
+			resets = <&crg 0xa0 4>;
+			reset-names = "reset";
+			status = "disabled";
 		};
 
 		gpio0: gpio at 8b20000 {
@@ -290,6 +335,7 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			gpio-ranges = <&pmx0 0 0 8>;
 			clocks = <&crg HISTB_APB_CLK>;
 			clock-names = "apb_pclk";
 			status = "disabled";
@@ -303,6 +349,13 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			gpio-ranges = <
+				&pmx0 0 8 1
+				&pmx0 1 9 4
+				&pmx0 5 13 1
+				&pmx0 6 14 1
+				&pmx0 7 15 1
+			>;
 			clocks = <&crg HISTB_APB_CLK>;
 			clock-names = "apb_pclk";
 			status = "disabled";
@@ -316,6 +369,7 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			gpio-ranges = <&pmx0 0 16 5 &pmx0 5 21 3>;
 			clocks = <&crg HISTB_APB_CLK>;
 			clock-names = "apb_pclk";
 			status = "disabled";
@@ -329,6 +383,12 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			gpio-ranges = <
+				&pmx0 0 24 4
+				&pmx0 4 28 2
+				&pmx0 6 86 1
+				&pmx0 7 87 1
+			>;
 			clocks = <&crg HISTB_APB_CLK>;
 			clock-names = "apb_pclk";
 			status = "disabled";
@@ -342,6 +402,7 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			gpio-ranges = <&pmx0 0 30 4 &pmx0 4 34 3 &pmx0 7 37 1>;
 			clocks = <&crg HISTB_APB_CLK>;
 			clock-names = "apb_pclk";
 			status = "disabled";
@@ -368,6 +429,7 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			gpio-ranges = <&pmx0 0 38 3 &pmx0 0 41 5>;
 			clocks = <&crg HISTB_APB_CLK>;
 			clock-names = "apb_pclk";
 			status = "disabled";
@@ -381,6 +443,7 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			gpio-ranges = <&pmx0 0 46 8>;
 			clocks = <&crg HISTB_APB_CLK>;
 			clock-names = "apb_pclk";
 			status = "disabled";
@@ -394,6 +457,7 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			gpio-ranges = <&pmx0 0 54 8>;
 			clocks = <&crg HISTB_APB_CLK>;
 			clock-names = "apb_pclk";
 			status = "disabled";
@@ -407,6 +471,7 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			gpio-ranges = <&pmx0 0 64 7 &pmx0 71 1>;
 			clocks = <&crg HISTB_APB_CLK>;
 			clock-names = "apb_pclk";
 			status = "disabled";
@@ -420,6 +485,7 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			gpio-ranges = <&pmx0 0 72 6 &pmx0 6 78 1 &pmx0 7 79 1>;
 			clocks = <&crg HISTB_APB_CLK>;
 			clock-names = "apb_pclk";
 			status = "disabled";
@@ -433,6 +499,7 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			gpio-ranges = <&pmx0 0 80 6 &pmx0 6 70 2>;
 			clocks = <&crg HISTB_APB_CLK>;
 			clock-names = "apb_pclk";
 			status = "disabled";
@@ -446,6 +513,7 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			gpio-ranges = <&pmx0 0 88 8>;
 			clocks = <&crg HISTB_APB_CLK>;
 			clock-names = "apb_pclk";
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/hisilicon/poplar-pinctrl.dtsi b/arch/arm64/boot/dts/hisilicon/poplar-pinctrl.dtsi
new file mode 100644
index 000000000000..7bb19e4b084a
--- /dev/null
+++ b/arch/arm64/boot/dts/hisilicon/poplar-pinctrl.dtsi
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Pinctrl dts file for HiSilicon Poplar board
+ *
+ * Copyright (c) 2016-2018 HiSilicon Technologies Co., Ltd.
+ */
+
+#include <dt-bindings/pinctrl/hisi.h>
+
+/* value, enable bits, disable bits, mask */
+#define PINCTRL_PULLDOWN(value, enable, disable, mask) \
+	(value << 13) (enable << 13) (disable << 13) (mask << 13)
+#define PINCTRL_PULLUP(value, enable, disable, mask) \
+	(value << 12) (enable << 12) (disable << 12) (mask << 12)
+#define PINCTRL_SLEW_RATE(value, mask)	  (value << 8) (mask << 8)
+#define PINCTRL_DRV_STRENGTH(value, mask) (value << 4) (mask << 4)
+
+&pmx0 {
+	emmc_pins_1: emmc-pins-1 {
+		pinctrl-single,pins = <
+			0x000 MUX_M2
+			0x004 MUX_M2
+			0x008 MUX_M2
+			0x00c MUX_M2
+			0x010 MUX_M2
+			0x014 MUX_M2
+			0x018 MUX_M2
+			0x01c MUX_M2
+			0x024 MUX_M2
+		>;
+		pinctrl-single,bias-pulldown = <
+			PINCTRL_PULLDOWN(0, 1, 0, 1)
+		>;
+		pinctrl-single,bias-pullup = <
+			PINCTRL_PULLUP(0, 1, 0, 1)
+		>;
+		pinctrl-single,slew-rate = <
+			PINCTRL_SLEW_RATE(1, 1)
+		>;
+		pinctrl-single,drive-strength = <
+			PINCTRL_DRV_STRENGTH(0xb, 0xf)
+		>;
+	};
+
+	emmc_pins_2: emmc-pins-2 {
+		pinctrl-single,pins = <
+			0x028 MUX_M2
+		>;
+		pinctrl-single,bias-pulldown = <
+			PINCTRL_PULLDOWN(0, 1, 0, 1)
+		>;
+		pinctrl-single,bias-pullup = <
+			PINCTRL_PULLUP(0, 1, 0, 1)
+		>;
+		pinctrl-single,slew-rate = <
+			PINCTRL_SLEW_RATE(1, 1)
+		>;
+		pinctrl-single,drive-strength = <
+			PINCTRL_DRV_STRENGTH(0x9, 0xf)
+		>;
+	};
+
+	emmc_pins_3: emmc-pins-3 {
+		pinctrl-single,pins = <
+			0x02c MUX_M2
+		>;
+		pinctrl-single,bias-pulldown = <
+			PINCTRL_PULLDOWN(0, 1, 0, 1)
+		>;
+		pinctrl-single,bias-pullup = <
+			PINCTRL_PULLUP(0, 1, 0, 1)
+		>;
+		pinctrl-single,slew-rate = <
+			PINCTRL_SLEW_RATE(1, 1)
+		>;
+		pinctrl-single,drive-strength = <
+			PINCTRL_DRV_STRENGTH(3, 3)
+		>;
+	};
+
+	emmc_pins_4: emmc-pins-4 {
+		pinctrl-single,pins = <
+			0x030 MUX_M2
+		>;
+		pinctrl-single,bias-pulldown = <
+			PINCTRL_PULLDOWN(1, 1, 0, 1)
+		>;
+		pinctrl-single,bias-pullup = <
+			PINCTRL_PULLUP(0, 1, 0, 1)
+		>;
+		pinctrl-single,slew-rate = <
+			PINCTRL_SLEW_RATE(1, 1)
+		>;
+		pinctrl-single,drive-strength = <
+			PINCTRL_DRV_STRENGTH(3, 3)
+		>;
+	};
+};
-- 
1.9.1
