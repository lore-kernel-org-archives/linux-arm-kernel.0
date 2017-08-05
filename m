From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat,  5 Aug 2017 23:44:36 +0200
Subject: [PATCH v2] ARM: dts: Add DTS file for D-Link DIR-685
Message-ID: <20170805214436.6581-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a device tree file for the Gemini-based D-Link DIR-685
router, supporting all devices that are currently supported in
the main DTSI SoC file.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Drop bootargs, use stdout-path = "uart0:115200n8";
- Give sensible names to GPIO keys and GPIO LEDs
---
 arch/arm/boot/dts/Makefile                 |   1 +
 arch/arm/boot/dts/gemini-dlink-dir-685.dts | 191 +++++++++++++++++++++++++++++
 2 files changed, 192 insertions(+)
 create mode 100644 arch/arm/boot/dts/gemini-dlink-dir-685.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4b17f35dc9a7..dc00f3ec1b23 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -180,6 +180,7 @@ dtb-$(CONFIG_ARCH_EXYNOS5) += \
 	exynos5440-ssdk5440.dtb \
 	exynos5800-peach-pi.dtb
 dtb-$(CONFIG_ARCH_GEMINI) += \
+	gemini-dlink-dir-685.dtb \
 	gemini-nas4220b.dtb \
 	gemini-rut1xx.dtb \
 	gemini-sq201.dtb \
diff --git a/arch/arm/boot/dts/gemini-dlink-dir-685.dts b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
new file mode 100644
index 000000000000..10ab4d878513
--- /dev/null
+++ b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
@@ -0,0 +1,191 @@
+/*
+ * Device Tree file for D-Link DIR-685 Xtreme N Storage Router
+ */
+
+/dts-v1/;
+
+#include "gemini.dtsi"
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "D-Link DIR-685 Xtreme N Storage Router";
+	compatible = "dlink,dir-685", "cortina,gemini";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	memory {
+		/* 128 MB SDRAM in 2 x Hynix HY5DU121622DTP-D43 */
+		device_type = "memory";
+		reg = <0x00000000 0x8000000>;
+	};
+
+	chosen {
+		stdout-path = "uart0:115200n8";
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		button-esc {
+			debounce_interval = <50>;
+			wakeup-source;
+			linux,code = <KEY_ESC>;
+			label = "reset";
+			gpios = <&gpio0 8 GPIO_ACTIVE_LOW>;
+		};
+		button-eject {
+			debounce_interval = <50>;
+			wakeup-source;
+			linux,code = <KEY_EJECTCD>;
+			label = "unmount";
+			gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		led-wps {
+			label = "dir685:blue:WPS";
+			gpios = <&gpio0 7 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+			linux,default-trigger = "heartbeat";
+		};
+		/*
+		 * These two LEDs are on the side of the device.
+		 * For electrical reasons, both LEDs cannot be active
+		 * at the same time so only blue or orange can on at
+		 * one time. Enabling both makes the LED go dark.
+		 * The LEDs both sit inside the unmount button and the
+		 * label on the case says "unmount".
+		 */
+		led-blue-hd {
+			label = "dir685:blue:HD";
+			gpios = <&gpio0 11 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+		led-orange-hd {
+			label = "dir685:orange:HD";
+			gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
+
+	/*
+	 * This is a Sunon Maglev GM0502PFV2-8 cooling fan @10000 RPM.
+	 * Since the platform has no temperature sensor, this is controlled
+	 * from userspace by using the hard disks S.M.A.R.T. temperature
+	 * sensor. It is turned on when the temperature exceeds 46 degrees
+	 * and turned off when the temperatures goes below 41 degrees
+	 * (celsius).
+	 */
+	gpio-fan {
+		compatible = "gpio-fan";
+		gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
+		gpio-fan,speed-map = <0 0>, <10000 1>;
+		#cooling-cells = <2>;
+	};
+
+	/*
+	 * The touchpad input is connected to a GPIO bit-banged
+	 * I2C bus.
+	 */
+	gpio-i2c {
+		compatible = "i2c-gpio";
+		gpios = <&gpio0 5 0>, /* SDA */
+			<&gpio0 6 0>; /* SCL */
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		touchkeys at 26 {
+			compatible = "dlink,dir685-touchkeys";
+			reg = <0x26>;
+			interrupt-parent = <&gpio0>;
+			interrupts = <17 IRQ_TYPE_EDGE_FALLING>;
+		};
+	};
+
+	soc {
+		flash at 30000000 {
+			status = "okay";
+			/* 32MB of flash */
+			reg = <0x30000000 0x02000000>;
+
+			/*
+			 * This "RedBoot" is the Storlink derivative.
+			 */
+			partition at 0 {
+				label = "RedBoot";
+				reg = <0x00000000 0x00040000>;
+				read-only;
+			};
+			/*
+			 * Between the boot loader and the rootfs is the kernel
+			 * in a custom Storlink format flashed from the boot
+			 * menu. The rootfs is in squashfs format.
+			 */
+			partition at 1800c0 {
+				label = "rootfs";
+				reg = <0x001800c0 0x01dbff40>;
+				read-only;
+			};
+			partition at 1f40000 {
+				label = "upgrade";
+				reg = <0x01f40000 0x00040000>;
+				read-only;
+			};
+			partition at 1f80000 {
+				label = "rgdb";
+				reg = <0x01f80000 0x00040000>;
+				read-only;
+			};
+			/*
+			 * This partition contains MAC addresses for WAN,
+			 * WLAN and LAN, and the country code (for wireless
+			 * I guess).
+			 */
+			partition at 1fc0000 {
+				label = "nvram";
+				reg = <0x01fc0000 0x00020000>;
+				read-only;
+			};
+			partition at 1fe0000 {
+				label = "LangPack";
+				reg = <0x01fe0000 0x00020000>;
+				read-only;
+			};
+		};
+
+		sata: sata at 46000000 {
+			cortina,gemini-ata-muxmode = <0>;
+			cortina,gemini-enable-sata-bridge;
+			status = "okay";
+		};
+
+		pci at 50000000 {
+			status = "okay";
+			interrupt-map-mask = <0xf800 0 0 7>;
+			interrupt-map =
+				<0x4800 0 0 1 &pci_intc 0>, /* Slot 9 */
+				<0x4800 0 0 2 &pci_intc 1>,
+				<0x4800 0 0 3 &pci_intc 2>,
+				<0x4800 0 0 4 &pci_intc 3>,
+				<0x5000 0 0 1 &pci_intc 1>, /* Slot 10 */
+				<0x5000 0 0 2 &pci_intc 2>,
+				<0x5000 0 0 3 &pci_intc 3>,
+				<0x5000 0 0 4 &pci_intc 0>,
+				<0x5800 0 0 1 &pci_intc 2>, /* Slot 11 */
+				<0x5800 0 0 2 &pci_intc 3>,
+				<0x5800 0 0 3 &pci_intc 0>,
+				<0x5800 0 0 4 &pci_intc 1>,
+				<0x6000 0 0 1 &pci_intc 3>, /* Slot 12 */
+				<0x6000 0 0 2 &pci_intc 0>,
+				<0x6000 0 0 3 &pci_intc 1>,
+				<0x6000 0 0 4 &pci_intc 2>;
+		};
+
+		ata at 63000000 {
+			status = "okay";
+		};
+	};
+};
-- 
2.9.4
