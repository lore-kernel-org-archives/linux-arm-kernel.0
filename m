From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat,  4 Aug 2018 13:10:03 +0200
Subject: [PATCH 2/2] ARM: dts: add Raspberry Pi Compute Module 3 and IO board
In-Reply-To: <1533381003-13367-1-git-send-email-stefan.wahren@i2se.com>
References: <1533381003-13367-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1533381003-13367-3-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Raspberry Pi Compute Module 3 (CM3) and the Raspberry Pi
Compute Module 3 Lite (CM3L) are SoMs which contains a BCM2837 processor,
1 GB RAM and a GPIO expander. The CM3 has a 4 GB eMMC, but on the CM3L
the eMMC is unpopulated and it's up to the user to connect their
own SD/MMC device. The dtsi file is designed to work for both modules.
There is also a matching carrier board which is called
Compute Module IO Board V3.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/Makefile                         |  1 +
 arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts          | 87 ++++++++++++++++++++++
 arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi             | 52 +++++++++++++
 arch/arm64/boot/dts/broadcom/Makefile              |  3 +-
 .../boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts      |  2 +
 5 files changed, 144 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts
 create mode 100644 arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b5bd3de..35c749f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -81,6 +81,7 @@ dtb-$(CONFIG_ARCH_BCM2835) += \
 	bcm2836-rpi-2-b.dtb \
 	bcm2837-rpi-3-b.dtb \
 	bcm2837-rpi-3-b-plus.dtb \
+	bcm2837-rpi-cm3-io3.dtb \
 	bcm2835-rpi-zero.dtb \
 	bcm2835-rpi-zero-w.dtb
 dtb-$(CONFIG_ARCH_BCM_5301X) += \
diff --git a/arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts b/arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts
new file mode 100644
index 0000000..6c8233a
--- /dev/null
+++ b/arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+#include "bcm2837-rpi-cm3.dtsi"
+#include "bcm283x-rpi-usb-host.dtsi"
+
+/ {
+	compatible = "raspberrypi,3-compute-module", "brcm,bcm2837";
+	model = "Raspberry Pi Compute Module 3 IO board V3.0";
+};
+
+&gpio {
+	/*
+	 * This is based on the official GPU firmware DT blob.
+	 *
+	 * Legend:
+	 * "NC" = not connected (no rail from the SoC)
+	 * "FOO" = GPIO line named "FOO" on the schematic
+	 * "FOO_N" = GPIO line named "FOO" on schematic, active low
+	 */
+	gpio-line-names = "GPIO0",
+			  "GPIO1",
+			  "GPIO2",
+			  "GPIO3",
+			  "GPIO4",
+			  "GPIO5",
+			  "GPIO6",
+			  "GPIO7",
+			  "GPIO8",
+			  "GPIO9",
+			  "GPIO10",
+			  "GPIO11",
+			  "GPIO12",
+			  "GPIO13",
+			  "GPIO14",
+			  "GPIO15",
+			  "GPIO16",
+			  "GPIO17",
+			  "GPIO18",
+			  "GPIO19",
+			  "GPIO20",
+			  "GPIO21",
+			  "GPIO22",
+			  "GPIO23",
+			  "GPIO24",
+			  "GPIO25",
+			  "GPIO26",
+			  "GPIO27",
+			  "GPIO28",
+			  "GPIO29",
+			  "GPIO30",
+			  "GPIO31",
+			  "GPIO32",
+			  "GPIO33",
+			  "GPIO34",
+			  "GPIO35",
+			  "GPIO36",
+			  "GPIO37",
+			  "GPIO38",
+			  "GPIO39",
+			  "GPIO40",
+			  "GPIO41",
+			  "GPIO42",
+			  "GPIO43",
+			  "GPIO44",
+			  "GPIO45",
+			  "GPIO46",
+			  "GPIO47",
+			  /* Used by eMMC */
+			  "SD_CLK_R",
+			  "SD_CMD_R",
+			  "SD_DATA0_R",
+			  "SD_DATA1_R",
+			  "SD_DATA2_R",
+			  "SD_DATA3_R";
+
+	pinctrl-0 = <&gpioout &alt0>;
+};
+
+&hdmi {
+	hpd-gpios = <&expgpio 1 GPIO_ACTIVE_LOW>;
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_gpio14>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi b/arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi
new file mode 100644
index 0000000..7b7ab6a
--- /dev/null
+++ b/arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+#include "bcm2837.dtsi"
+#include "bcm2835-rpi.dtsi"
+
+/ {
+	memory {
+		reg = <0 0x40000000>;
+	};
+
+	reg_3v3: fixed-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	reg_1v8: fixed-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+};
+
+&firmware {
+	expgpio: gpio {
+		compatible = "raspberrypi,firmware-gpio";
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "HDMI_HPD_N",
+				  "EMMC_EN_N",
+				  "NC",
+				  "NC",
+				  "NC",
+				  "NC",
+				  "NC",
+				  "NC";
+		status = "okay";
+	};
+};
+
+&sdhost {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhost_gpio48>;
+	bus-width = <4>;
+	vmmc-supply = <&reg_3v3>;
+	vqmmc-supply = <&reg_1v8>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
index 1193a9e..3d98f5f 100644
--- a/arch/arm64/boot/dts/broadcom/Makefile
+++ b/arch/arm64/boot/dts/broadcom/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_BCM2835) += bcm2837-rpi-3-b.dtb \
-			      bcm2837-rpi-3-b-plus.dtb
+			      bcm2837-rpi-3-b-plus.dtb \
+			      bcm2837-rpi-cm3-io3.dts
 
 subdir-y	+= northstar2
 subdir-y	+= stingray
diff --git a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts
new file mode 100644
index 0000000..b1c4ab2
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "arm/bcm2837-rpi-cm3-io3.dts"
-- 
2.7.4
