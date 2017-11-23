From: sebastien.bourdelin@savoirfairelinux.com (Sebastien Bourdelin)
Date: Thu, 23 Nov 2017 16:04:10 -0500
Subject: [PATCH v8 2/2] ARM: dts: TS-4600: add basic device tree
In-Reply-To: <20171123210410.7107-1-sebastien.bourdelin@savoirfairelinux.com>
References: <20171123210410.7107-1-sebastien.bourdelin@savoirfairelinux.com>
Message-ID: <20171123210410.7107-2-sebastien.bourdelin@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These device trees add support for the TS-4600 by Technologic Systems.

More details here:
  http://wiki.embeddedarm.com/wiki/TS-4600

Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
---
Changes v7 -> v8:
  - rebase on master
  - merge the rev A and B into one device tree based on the last rev B
  because only the memory size change between the two rev currently
  (suggested by Shawn Guo)

Changes v6 -> v7:
  - rebase on master
  - remove unneeded pinctrl-name (suggested by Shawn Guo)
  - add reg to the node en-sd-pwr (suggested by Shawn Guo)
  - use define for gpio polarity (suggested by Shawn Guo)
  - remove the fake bus container for regulator (suggested by Shawn Guo)

Changes v5 -> v6:
  - rebase on master
  - split the previous patch series into series by subsystem

Changes v4 -> v5:
  - fix missing signed off

Changes v3 -> v4:
  - rebase on master

Changes v2 -> v3:
  - rebase on master

Changes v1 -> v2:
  - rebase on master
---
 arch/arm/boot/dts/Makefile         |  1 +
 arch/arm/boot/dts/imx28-ts4600.dts | 79 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx28-ts4600.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d0381e9caf21..678373d299d8 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -558,6 +558,7 @@ dtb-$(CONFIG_ARCH_MXS) += \
 	imx28-m28cu3.dtb \
 	imx28-m28evk.dtb \
 	imx28-sps1.dtb \
+	imx28-ts4600.dtb \
 	imx28-tx28.dtb
 dtb-$(CONFIG_ARCH_NOMADIK) += \
 	ste-nomadik-s8815.dtb \
diff --git a/arch/arm/boot/dts/imx28-ts4600.dts b/arch/arm/boot/dts/imx28-ts4600.dts
new file mode 100644
index 000000000000..f37d81381620
--- /dev/null
+++ b/arch/arm/boot/dts/imx28-ts4600.dts
@@ -0,0 +1,79 @@
+/*
+ * Copyright (C) 2016 Savoir-Faire Linux
+ * Author: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+#include "imx28.dtsi"
+#include "dt-bindings/gpio/gpio.h"
+
+/ {
+
+	model = "Technologic Systems i.MX28 TS-4600";
+	compatible = "technologic,imx28-ts4600", "fsl,imx28";
+
+	memory {
+		reg = <0x40000000 0x10000000>;   /* 256MB */
+	};
+
+	apb at 80000000 {
+		apbh at 80000000 {
+			ssp0: ssp at 80010000 {
+				compatible = "fsl,imx28-mmc";
+				pinctrl-names = "default";
+				pinctrl-0 = <&mmc0_4bit_pins_a
+					     &mmc0_sck_cfg
+					     &en_sd_pwr>;
+				broken-cd = <1>;
+				bus-width = <4>;
+				vmmc-supply = <&reg_vddio_sd0>;
+				status = "okay";
+			};
+
+			pinctrl at 80018000 {
+
+				en_sd_pwr: en-sd-pwr at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						MX28_PAD_PWM3__GPIO_3_28
+					>;
+					fsl,drive-strength = <MXS_DRIVE_4mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_DISABLE>;
+				};
+
+			};
+		};
+
+		apbx at 80040000 {
+			pwm: pwm at 80064000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pwm2_pins_a>;
+				status = "okay";
+			};
+
+			duart: serial at 80074000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&duart_pins_a>;
+				status = "okay";
+			};
+		};
+	};
+
+	reg_vddio_sd0: regulator-vddio-sd0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vddio-sd0";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		gpio = <&gpio3 28 GPIO_ACTIVE_HIGH>;
+	};
+
+};
-- 
2.15.0
