From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 27 Nov 2015 00:01:08 +0100
Subject: [PATCH 2/2] ARM: mvebu: kirkwood: add PogoPlug series 4 device tree
Message-ID: <1448578868-6323-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a device tree for the CloudEngines PogoPlug series 4
NAS device. Inspired by out-of-tree boardfiles from ArchLinux
by Kevin Mihelich.

Cc: Moonman <moonman.ca@gmail.com>
Cc: Kevin Mihelich <kevin@archlinuxarm.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/Makefile                       |   1 +
 arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts | 183 +++++++++++++++++++++++
 2 files changed, 184 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 30bbc3746130..2d9f475a9ceb 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -206,6 +206,7 @@ dtb-$(CONFIG_MACH_KIRKWOOD) += \
 	kirkwood-openrd-client.dtb \
 	kirkwood-openrd-ultimate.dtb \
 	kirkwood-pogo_e02.dtb \
+	kirkwood-pogoplug-series-4.dtb \
 	kirkwood-rd88f6192.dtb \
 	kirkwood-rd88f6281-z0.dtb \
 	kirkwood-rd88f6281-a.dtb \
diff --git a/arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts b/arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts
new file mode 100644
index 000000000000..28318d666e72
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts
@@ -0,0 +1,183 @@
+/*
+ * kirkwood-pogoplug-series-4.dts - Device tree file for PogoPlug Series 4
+ * inspired by the board files made by Kevin Mihelich for ArchLinux,
+ * and their DTS file.
+ *
+ * Copyright (C) 2015 Linus Walleij <linus.walleij@linaro.org>
+ */
+
+/dts-v1/;
+
+#include "kirkwood.dtsi"
+#include "kirkwood-6192.dtsi"
+
+/ {
+	model = "Cloud Engines PogoPlug Series 4";
+	compatible = "cloudengines,pogoplugv4", "marvell,kirkwood-88f6192",
+		     "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x08000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8";
+		stdout-path = &uart0;
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&pmx_button_eject>;
+		pinctrl-names = "default";
+
+		button at 1 {
+			debounce_interval = <50>;
+			wakeup-source;
+			/* KEY_EJECTCD */
+			linux,code = <161>;
+			label = "Eject Button";
+			gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_led_green &pmx_led_red>;
+		pinctrl-names = "default";
+
+		health {
+			label = "status:green:health";
+			gpios = <&gpio0 22 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+		fault {
+			label = "status:red:fault";
+			gpios = <&gpio0 24 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&pinctrl {
+	pmx_sata0: pmx-sata0 {
+		marvell,pins = "mpp21";
+		marvell,function = "sata0";
+	};
+
+	pmx_sata1: pmx-sata1 {
+		marvell,pins = "mpp20";
+		marvell,function = "sata1";
+	};
+
+	pmx_sdio_cd: pmx-sdio-cd {
+		marvell,pins = "mpp27";
+		marvell,function = "gpio";
+	};
+
+	pmx_sdio_wp: pmx-sdio-wp {
+		marvell,pins = "mpp28";
+		marvell,function = "gpio";
+	};
+
+	pmx_button_eject: pmx-button-eject {
+		marvell,pins = "mpp29";
+		marvell,function = "gpio";
+	};
+
+	pmx_led_green: pmx-led-green {
+		marvell,pins = "mpp22";
+		marvell,function = "gpio";
+	};
+
+	pmx_led_red: pmx-led-red {
+		marvell,pins = "mpp24";
+		marvell,function = "gpio";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+/*
+ * This PCIE controller has a USB 3.0 XHCI controller at 1,0
+ */
+&pciec {
+	status = "okay";
+};
+
+&pcie0 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&sata {
+	status = "okay";
+	pinctrl-0 = <&pmx_sata0 &pmx_sata1>;
+	pinctrl-names = "default";
+	nr-ports = <1>;
+};
+
+&sdio {
+	status = "okay";
+	pinctrl-0 = <&pmx_sdio &pmx_sdio_cd &pmx_sdio_wp>;
+	pinctrl-names = "default";
+	cd-gpios = <&gpio0 27 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio0 28 GPIO_ACTIVE_HIGH>;
+};
+
+&nand {
+	/* 128 MiB of NAND flash */
+	chip-delay = <40>;
+	status = "okay";
+	partitions {
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition at 0 {
+			label = "u-boot";
+			reg = <0x00000000 0x200000>;
+			read-only;
+		};
+
+		partition at 200000 {
+			label = "uImage";
+			reg = <0x00200000 0x300000>;
+		};
+
+		partition at 500000 {
+			label = "uImage2";
+			reg = <0x00500000 0x300000>;
+		};
+
+		partition at 800000 {
+			label = "failsafe";
+			reg = <0x00800000 0x800000>;
+		};
+
+		partition at 1000000 {
+			label = "root";
+			reg = <0x01000000 0x7000000>;
+		};
+	};
+};
+
+&mdio {
+	status = "okay";
+
+	ethphy0: ethernet-phy at 0 {
+		reg = <0>;
+	};
+};
+
+&eth0 {
+	status = "okay";
+	ethernet0-port at 0 {
+		phy-handle = <&ethphy0>;
+	};
+};
-- 
2.4.3
