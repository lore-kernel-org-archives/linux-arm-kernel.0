From: sebastien.bourdelin@savoirfairelinux.com (Sebastien Bourdelin)
Date: Wed,  1 Nov 2017 13:06:45 -0400
Subject: [PATCH v7 2/2] ARM: dts: TS-4600: add basic device tree
In-Reply-To: <20171101170645.12918-1-sebastien.bourdelin@savoirfairelinux.com>
References: <20171101170645.12918-1-sebastien.bourdelin@savoirfairelinux.com>
Message-ID: <20171101170645.12918-2-sebastien.bourdelin@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These device trees add support for the TS-4600 by Technologic Systems.

More details here:
  http://wiki.embeddedarm.com/wiki/TS-4600

Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
---
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
 arch/arm/boot/dts/Makefile                 |  2 +
 arch/arm/boot/dts/imx28-ts4600-common.dtsi | 74 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx28-ts4600-rev-a.dts   | 22 +++++++++
 arch/arm/boot/dts/imx28-ts4600-rev-b.dts   | 22 +++++++++
 4 files changed, 120 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx28-ts4600-common.dtsi
 create mode 100644 arch/arm/boot/dts/imx28-ts4600-rev-a.dts
 create mode 100644 arch/arm/boot/dts/imx28-ts4600-rev-b.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index faf46abaa4a2..430fe7f1e644 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -532,6 +532,8 @@ dtb-$(CONFIG_ARCH_MXS) += \
 	imx28-m28cu3.dtb \
 	imx28-m28evk.dtb \
 	imx28-sps1.dtb \
+	imx28-ts4600-rev-a.dtb \
+	imx28-ts4600-rev-b.dtb \
 	imx28-tx28.dtb
 dtb-$(CONFIG_ARCH_NOMADIK) += \
 	ste-nomadik-s8815.dtb \
diff --git a/arch/arm/boot/dts/imx28-ts4600-common.dtsi b/arch/arm/boot/dts/imx28-ts4600-common.dtsi
new file mode 100644
index 000000000000..c5f6bef87fd5
--- /dev/null
+++ b/arch/arm/boot/dts/imx28-ts4600-common.dtsi
@@ -0,0 +1,74 @@
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
+	compatible = "technologic,imx28-ts4600", "fsl,imx28";
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
diff --git a/arch/arm/boot/dts/imx28-ts4600-rev-a.dts b/arch/arm/boot/dts/imx28-ts4600-rev-a.dts
new file mode 100644
index 000000000000..e8cb72988fcf
--- /dev/null
+++ b/arch/arm/boot/dts/imx28-ts4600-rev-a.dts
@@ -0,0 +1,22 @@
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
+#include "imx28-ts4600-common.dtsi"
+
+/ {
+	model = "Technologic Systems i.MX28 TS-4600 Rev A";
+
+	memory {
+		reg = <0x40000000 0x08000000>;   /* 128MB */
+	};
+
+};
diff --git a/arch/arm/boot/dts/imx28-ts4600-rev-b.dts b/arch/arm/boot/dts/imx28-ts4600-rev-b.dts
new file mode 100644
index 000000000000..a115f831fe2b
--- /dev/null
+++ b/arch/arm/boot/dts/imx28-ts4600-rev-b.dts
@@ -0,0 +1,22 @@
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
+#include "imx28-ts4600-common.dtsi"
+
+/ {
+	model = "Technologic Systems i.MX28 TS-4600 Rev B";
+
+	memory {
+		reg = <0x40000000 0x10000000>;   /* 256MB */
+	};
+
+};
-- 
2.13.4
