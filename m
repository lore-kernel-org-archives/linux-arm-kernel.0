From: vz@mleia.com (Vladimir Zapolskiy)
Date: Tue,  3 Jul 2018 22:29:34 +0300
Subject: [PATCH 3/3] ARM: dts: imx31: add LogicPD MX31Lite board description
In-Reply-To: <20180703192934.6080-1-vz@mleia.com>
References: <20180703192934.6080-1-vz@mleia.com>
Message-ID: <20180703192934.6080-4-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The added DTS contains a combined description of LogicPD MX31 Lite
SoM devices, peripherals are routed to ports on a baseboard:
* PATA controller,
* SD/MMC controller,
* 2 GPIO LEDs,
* UART controllers,
* Freescale MC13783 MFD connected over SPI,
* SMSC LAN9117,
* ST Micro NAND SLC, 64 MiB,
* Intel NOR flash, 16 MiB.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/boot/dts/Makefile       |   3 +-
 arch/arm/boot/dts/imx31-lite.dts | 177 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 179 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/imx31-lite.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 37a3de7..2210b73 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -345,7 +345,8 @@ dtb-$(CONFIG_SOC_IMX27) += \
 	imx27-phytec-phycore-rdk.dtb \
 	imx27-phytec-phycard-s-rdk.dtb
 dtb-$(CONFIG_SOC_IMX31) += \
-	imx31-bug.dtb
+	imx31-bug.dtb \
+	imx31-lite.dtb
 dtb-$(CONFIG_SOC_IMX35) += \
 	imx35-eukrea-mbimxsd35-baseboard.dtb \
 	imx35-pdk.dtb
diff --git a/arch/arm/boot/dts/imx31-lite.dts b/arch/arm/boot/dts/imx31-lite.dts
new file mode 100644
index 0000000..db52ddc
--- /dev/null
+++ b/arch/arm/boot/dts/imx31-lite.dts
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (C) 2016-2018 Vladimir Zapolskiy <vz@mleia.com>
+
+/dts-v1/;
+
+#include "imx31.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	model = "LogicPD i.MX31 Lite";
+	compatible = "logicpd,imx31-lite", "fsl,imx31";
+
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	memory at 80000000 {
+		reg = <0x80000000 0x8000000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led0 {
+			gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
+		};
+
+		led1 {
+			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&ata {
+	status = "okay";
+};
+
+&nfc {
+	nand-bus-width = <8>;
+	nand-ecc-mode = "hw";
+	nand-on-flash-bbt;
+	status = "okay";
+};
+
+&sdhci1 {
+	bus-width = <4>;
+	cd-gpios = <&gpio2 11 GPIO_ACTIVE_HIGH>;
+	wp-gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&spi2 {
+	status = "okay";
+
+	pmic at 0 {
+		compatible = "fsl,mc13783";
+		reg = <0>;
+		spi-cs-high;
+		spi-max-frequency = <1000000>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <3 IRQ_TYPE_EDGE_RISING>;
+
+		fsl,mc13xxx-uses-adc;
+		fsl,mc13xxx-uses-rtc;
+
+		regulators {
+			sw1a {		/* QVCC */
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			sw1b {		/* QVCC */
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			sw2a {		/* 1.8V_DDR, NVCC2, NVCC21 and NVCC22 */
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			sw2b {		/* NVCC10 */
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			violo {		/* NVCC1 and NVCC7 */
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			viohi {		/* VIOHI */
+				regulator-min-microvolt = <2775000>;
+				regulator-max-microvolt = <2775000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			vaudio {	/* VAUDIO */
+				regulator-min-microvolt = <2775000>;
+				regulator-max-microvolt = <2775000>;
+			};
+
+			vcam {		/* NVCC4 */
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+			};
+
+			vgen {		/* NVCC5 / NVCC8 and NVCC6 / NVCC9 */
+				regulator-min-microvolt = <2775000>;
+				regulator-max-microvolt = <2775000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			vmmc2 {		/* NVCC3 */
+				regulator-min-microvolt = <1600000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+		};
+	};
+};
+
+&uart1 {
+	uart-has-rtscts;
+	status = "okay";
+};
+
+/* Routed to the extension board */
+&uart2 {
+	uart-has-rtscts;
+	status = "okay";
+};
+
+/* Routed to the extension board */
+&uart3 {
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&weim {
+	status = "okay";
+
+	nor at 0,0 {
+		compatible = "cfi-flash";
+		reg = <0 0x0 0x200000>;
+		bank-width = <2>;
+		linux,mtd-name = "physmap-flash.0";
+		fsl,weim-cs-timing = <0x0000cf03 0xa0330d01 0x00220800>;
+	};
+
+	ethernet at 4,0 {
+		compatible = "smsc,lan9117", "smsc,lan9115";
+		reg = <4 0x0 0x100>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
+		phy-mode = "mii";
+		reg-io-width = <2>;
+		smsc,irq-push-pull;
+		fsl,weim-cs-timing = <0x00008701 0x04000541 0x00010000>;
+	};
+};
-- 
2.10.2
