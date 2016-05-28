From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 28 May 2016 11:54:28 +0200
Subject: [PATCH v5 17/22] ARM: dts: exynos: Add initial support for Odroid XU
 board
In-Reply-To: <1464429273-23457-1-git-send-email-krzk@kernel.org>
References: <1464429273-23457-1-git-send-email-krzk@kernel.org>
Message-ID: <1464429273-23457-18-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Hardkernel's Odroid XU board was first design with big.LITTLE SoC
from Samsung: the Exynos5410. Details:
1. Exynos5410 octa-core (A15+A7, however as of now only one cluster is
   enabled),
2. 2 GB DDR3 RAM,
3. PowerVR SGX544MP3 GPU (not enabled in DTS),
4. USB 3.0 Host x 1, USB 3.0 OTG x 1, USB 2.0 Host x 4,
5. HDMI 1.4a, MIPI DSI and Display Port (Display Port not on all of
   revisions though),
6. eMMC 4.5 and microSD slots.

Comparing this board to Odroid XU3 (more popular), the differences are:
1. Exynos5410 instead of 5422,
2. MIPI DSI LCD connector,
3. Main PMIC: Maxim 77802 instead of S2MPS11,
4. USB3503+LAN9730 instead of integrated LAN9514,
5. eMMC 4.5 instead of eMMC 5.0,

This patch adds initial support for the XU board with working basic
functions, eMMC/SD and USB (including attached ethernet adapter).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Link: http://www.hardkernel.com/main/products/prdt_info.php?g_code=G137510300620
---
 .../bindings/arm/samsung/samsung-boards.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/exynos5410-odroidxu.dts          | 121 +++++++++++++++++++++
 3 files changed, 123 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos5410-odroidxu.dts

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
index f5deace2b380..0ea7f14ef294 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
@@ -47,6 +47,7 @@ Required root node properties:
 	- "hardkernel,odroid-u3"  - for Exynos4412-based Hardkernel Odroid U3.
 	- "hardkernel,odroid-x"   - for Exynos4412-based Hardkernel Odroid X.
 	- "hardkernel,odroid-x2"  - for Exynos4412-based Hardkernel Odroid X2.
+	- "hardkernel,odroid-xu"  - for Exynos5410-based Hardkernel Odroid XU.
 	- "hardkernel,odroid-xu3" - for Exynos5422-based Hardkernel Odroid XU3.
 	- "hardkernel,odroid-xu3-lite" - for Exynos5422-based Hardkernel
 					 Odroid XU3 Lite board.
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 5aeb10674370..9ed1c7abedb1 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -134,6 +134,7 @@ dtb-$(CONFIG_ARCH_EXYNOS5) += \
 	exynos5250-snow-rev5.dtb \
 	exynos5250-spring.dtb \
 	exynos5260-xyref5260.dtb \
+	exynos5410-odroidxu.dtb \
 	exynos5410-smdk5410.dtb \
 	exynos5420-arndale-octa.dtb \
 	exynos5420-peach-pit.dtb \
diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
new file mode 100644
index 000000000000..9fe04500ecaf
--- /dev/null
+++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
@@ -0,0 +1,121 @@
+/*
+ * Hardkernel Odroid XU board device tree source
+ *
+ * Copyright (c) 2013 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ * Copyright (c) 2016 Krzysztof Kozlowski
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/dts-v1/;
+#include "exynos5410.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "exynos54xx-odroidxu-leds.dtsi"
+
+/ {
+	model = "Hardkernel Odroid XU";
+	compatible = "hardkernel,odroid-xu", "samsung,exynos5410", "samsung,exynos5";
+
+	memory {
+		reg = <0x40000000 0x7ea00000>;
+	};
+
+	chosen {
+		linux,stdout-path = &serial_2;
+	};
+
+	emmc_pwrseq: pwrseq {
+		pinctrl-0 = <&emmc_nrst_pin>;
+		pinctrl-names = "default";
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&gpd1 0 GPIO_ACTIVE_LOW>;
+	};
+
+	fan0: pwm-fan {
+		compatible = "pwm-fan";
+		pwms = <&pwm 0 20972 0>;
+		cooling-min-state = <0>;
+		cooling-max-state = <3>;
+		#cooling-cells = <2>;
+		cooling-levels = <0 130 170 230>;
+	};
+
+	fin_pll: xxti {
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		clock-output-names = "fin_pll";
+		#clock-cells = <0>;
+	};
+
+	firmware at 02073000 {
+		compatible = "samsung,secure-firmware";
+		reg = <0x02073000 0x1000>;
+	};
+};
+
+&mmc_0 {
+	status = "okay";
+	mmc-pwrseq = <&emmc_pwrseq>;
+	cd-gpios = <&gpc0 2 GPIO_ACTIVE_LOW>;
+	card-detect-delay = <200>;
+	samsung,dw-mshc-ciu-div = <3>;
+	samsung,dw-mshc-sdr-timing = <0 4>;
+	samsung,dw-mshc-ddr-timing = <0 2>;
+	samsung,dw-mshc-hs400-timing = <0 2>;
+	samsung,read-strobe-delay = <90>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8 &sd0_cd>;
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+};
+
+&mmc_2 {
+	status = "okay";
+	card-detect-delay = <200>;
+	samsung,dw-mshc-ciu-div = <3>;
+	samsung,dw-mshc-sdr-timing = <0 4>;
+	samsung,dw-mshc-ddr-timing = <0 2>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4>;
+	bus-width = <4>;
+	cap-sd-highspeed;
+};
+
+&pinctrl_0 {
+	emmc_nrst_pin: emmc-nrst {
+		samsung,pins = "gpd1-0";
+		samsung,pin-function = <0>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+};
+
+&serial_0 {
+	status = "okay";
+};
+
+&serial_1 {
+	status = "okay";
+};
+
+&serial_2 {
+	status = "okay";
+};
+
+&serial_3 {
+	status = "okay";
+};
+
+&usbdrd_dwc3_0 {
+	dr_mode = "host";
+};
+
+&usbdrd_dwc3_1 {
+	dr_mode = "peripheral";
+};
-- 
2.7.4
