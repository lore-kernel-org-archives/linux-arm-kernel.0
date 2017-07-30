From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 30 Jul 2017 19:10:34 +0200
Subject: [PATCH V2 3/3] ARM: dts: bcm2835: Add Raspberry Pi Zero W
In-Reply-To: <1501434634-2325-1-git-send-email-stefan.wahren@i2se.com>
References: <1501434634-2325-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1501434634-2325-4-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Raspberry Pi Zero W has the same components like the Zero plus
a Cypress CYW43438 wireless chip (wifi + bl).

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/Makefile               |   3 +-
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts | 139 +++++++++++++++++++++++++++++++
 2 files changed, 141 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts

I'm not sure that GPIO34 to GPIO39 are really "not connected".
They are listed in dt-blob.dts, but only declared as input.
Still no full schematics available.

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4b17f35..6e632a3 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -73,7 +73,8 @@ dtb-$(CONFIG_ARCH_BCM2835) += \
 	bcm2835-rpi-a-plus.dtb \
 	bcm2836-rpi-2-b.dtb \
 	bcm2837-rpi-3-b.dtb \
-	bcm2835-rpi-zero.dtb
+	bcm2835-rpi-zero.dtb \
+	bcm2835-rpi-zero-w.dtb
 dtb-$(CONFIG_ARCH_BCM_5301X) += \
 	bcm4708-asus-rt-ac56u.dtb \
 	bcm4708-asus-rt-ac68u.dtb \
diff --git a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
new file mode 100644
index 0000000..82651c3
--- /dev/null
+++ b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
@@ -0,0 +1,139 @@
+/*
+ * Copyright (C) 2017 Stefan Wahren <stefan.wahren@i2se.com>
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
+#include "bcm2835.dtsi"
+#include "bcm2835-rpi.dtsi"
+#include "bcm283x-rpi-usb-host.dtsi"
+
+/ {
+	compatible = "raspberrypi,model-zero-w", "brcm,bcm2835";
+	model = "Raspberry Pi Zero W";
+
+	/* Needed by firmware to properly init UARTs */
+	aliases {
+		uart0 = "/soc/serial at 7e201000";
+		uart1 = "/soc/serial at 7e215040";
+		serial0 = "/soc/serial at 7e201000";
+		serial1 = "/soc/serial at 7e215040";
+	};
+
+	leds {
+		act {
+			gpios = <&gpio 47 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wl_on>;
+		reset-gpios = <&gpio 41 GPIO_ACTIVE_LOW>;
+	};
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
+			  "SDA1",
+			  "SCL1",
+			  "GPIO_GCLK",
+			  "GPIO5",
+			  "GPIO6",
+			  "SPI_CE1_N",
+			  "SPI_CE0_N",
+			  "SPI_MISO",
+			  "SPI_MOSI",
+			  "SPI_SCLK",
+			  "GPIO12",
+			  "GPIO13",
+			  /* Serial port */
+			  "TXD0",
+			  "RXD0",
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
+			  "SDA0",
+			  "SCL0",
+			  "NC", /* GPIO30 */
+			  "NC", /* GPIO31 */
+			  "NC", /* GPIO32 */
+			  "NC", /* GPIO33 */
+			  "NC", /* GPIO34 */
+			  "NC", /* GPIO35 */
+			  "NC", /* GPIO36 */
+			  "NC", /* GPIO37 */
+			  "NC", /* GPIO38 */
+			  "NC", /* GPIO39 */
+			  "CAM_GPIO1", /* GPIO40 */
+			  "WL_ON", /* GPIO41 */
+			  "NC", /* GPIO42 */
+			  "WIFI_CLK", /* GPIO43 */
+			  "CAM_GPIO0", /* GPIO44 */
+			  "BT_ON", /* GPIO45 */
+			  "HDMI_HPD_N",
+			  "STATUS_LED_N",
+			  /* Used by SD Card */
+			  "SD_CLK_R",
+			  "SD_CMD_R",
+			  "SD_DATA0_R",
+			  "SD_DATA1_R",
+			  "SD_DATA2_R",
+			  "SD_DATA3_R";
+
+	pinctrl-0 = <&gpioout &alt0>;
+
+	wl_on: wl-on {
+		brcm,pins = <41>;
+		brcm,function = <BCM2835_FSEL_GPIO_OUT>;
+	};
+};
+
+&hdmi {
+	hpd-gpios = <&gpio 46 GPIO_ACTIVE_LOW>;
+};
+
+&sdhci {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-0 = <&emmc_gpio34 &gpclk2_gpio43>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	non-removable;
+	status = "okay";
+
+	brcmf: wifi at 1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_gpio14>;
+	status = "okay";
+};
-- 
2.7.4
