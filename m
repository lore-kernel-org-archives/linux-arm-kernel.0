From: rask@formelder.dk (Rask Ingemann Lambertsen)
Date: Thu,  9 Feb 2017 00:34:06 +0100 (CET)
Subject: [PATCH v6 5/5] ARM: dts: sun9i: Initial support for the Sunchip
 CX-A99 board
In-Reply-To: <cover.1486592470.git.rask@formelder.dk>
References: <cover.1486592470.git.rask@formelder.dk>
Message-ID: <d4211c5d57f80b0281d7d332edc7d69e66202d3d.1486592471.git.rask@formelder.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Suncip CX-A99 board is found in at least four brands of media players.
It features an Allwinner A80 ARM SoC and is found in two models:

1) 2 GiB DDR3 DRAM and 16 GB eMMC
2) 4 GiB DDR3 DRAM and 32 GB eMMC

For details of the board, see the linux-sunxi page
<URL:https://linux-sunxi.org/Sunchip_CX-A99>.

Supported features (+ means tested):
+ One Cortex-A7 CPU core (or four with experimental U-Boot PSCI patches)
+ AXP808 power management chip
+ OZ80120 voltage regulator
+ Serial console port (internal)
+ eMMC and SD card slot
+ USB 2.0 host ports on on-board USB hub
+ SATA port on on-board SATA-to-USB bridge *
+ IEEE 802.11 a/b/g/n/ac SDIO Wifi
+ Real-time clock
+ LEDs
- IR receiver for remote control

* Only shows up when a SATA device is connected. Also, if a power source
  is connected to the USB 3.0 connector across power cycles (e.g. FEL
  boot), the bridge may not properly reset and not show up on the USB bus.
  The vendor U-Boot performs some unknown magic which resets the bridge.

So far unsupported features:
- Using any of the Cortex-A15 CPU cores
- USB 3.0 port (except for supplying 5 V power)
- IEEE 802.3 10/100/1000 megabit Ethernet
- HDMI connector
- S/PDIF audio output
- Jack socket with composite video and analog stereo audio
- Bluetooth
- FM radio receiver (assuming it is even wired on the board)

Signed-off-by: Rask Ingemann Lambertsen <rask@formelder.dk>
---

Changes in v6:
- Updated commit message description of SATA-to-USB bridge quirk and added
  note about experimental U-Boot PSCI support for up to four CPU cores.
- The blue LED is no longer on by default as its meaning is not documented.
- Removed "regulator-boot-on" from regulators having "regulator-always-on".
- Removed misleading mention of "OTG connector" which the device doesn't have.
- More detailed explanation for the need for "broken-cd" on mmc0.
- Several regulators have had their voltage range relaxed a little to match
  the permissible range according to the data sheets of the consumers. This
  is similar to what is used for the Cubieboard4 and Merrii A80 Optimus.
- Shortened regulator dcdce name as per v5 comments. A comment now lists the
  pin groups supplied by dcdce.

Changes in v5:
- Switched pinmux modes to generic properties and dropped 
  #include <dt-bindings/pinctrl/sun4i-a10.h> as a consequence.
- Dropped pinctrl properties from GPIO nodes and dropped the pinmux
  nodes for them.
- AXP808 regulators added.
- Dropped the now unused #include <sunxi-common-regulators.dtsi>.
- Ampak AP6335 SDIO-Wifi added.
- USB Vbus changes as per v4 comments.
- Added "broken-cd" to mmc0 because GPIO interrupts don't work.

Changes in v4:
- Node names had underscores changed to hyphens.
- Changed formatting of the ac100/rtc node's clock output name list to match
 that of the same node in the cubieboard4 and a80-optimus device trees.

Changes in v3:
None.

Changes in v2:
- Fixed formatting and style issues found by scripts/checkpatch.pl.

 arch/arm/boot/dts/Makefile             |   3 +-
 arch/arm/boot/dts/sun9i-a80-cx-a99.dts | 409 +++++++++++++++++++++++++++++++++
 2 files changed, 411 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/sun9i-a80-cx-a99.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 8553bd7..40546fa 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -862,7 +862,8 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-v3s-licheepi-zero.dtb
 dtb-$(CONFIG_MACH_SUN9I) += \
 	sun9i-a80-optimus.dtb \
-	sun9i-a80-cubieboard4.dtb
+	sun9i-a80-cubieboard4.dtb \
+	sun9i-a80-cx-a99.dtb
 dtb-$(CONFIG_ARCH_TANGO) += \
 	tango4-vantage-1172.dtb
 dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += \
diff --git a/arch/arm/boot/dts/sun9i-a80-cx-a99.dts b/arch/arm/boot/dts/sun9i-a80-cx-a99.dts
new file mode 100644
index 0000000..f5496d2
--- /dev/null
+++ b/arch/arm/boot/dts/sun9i-a80-cx-a99.dts
@@ -0,0 +1,409 @@
+/*
+ * sun9i-a80-cx-a99.dts - Device Tree file for the Sunchip CX-A99 board.
+ *
+ * Copyright (C) 2017 Rask Ingemann Lambertsen <rask@formelder.dk>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/*
+ * The Sunchip CX-A99 board is found in several similar Android media
+ * players, such as:
+ *
+ * Instabox Fantasy A8 (no external antenna)
+ * Jesurun CS-Q8 (ships with larger remote control)
+ * Jesurun Maxone
+ * Rikomagic (RKM) MK80/MK80LE
+ * Tronsmart Draco AW80 Meta/Telos
+ *
+ * See <URL:https://linux-sunxi.org/Sunchip_CX-A99> for more information.
+ */
+
+/dts-v1/;
+#include "sun9i-a80.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Sunchip CX-A99";
+	compatible = "sunchip,cx-a99", "allwinner,sun9i-a80";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		blue {
+			gpios = <&pio 6 10 GPIO_ACTIVE_HIGH>;	/* PG10 */
+			label = "cx-a99:blue:status";
+		};
+
+		red {
+			gpios = <&pio 6 11 GPIO_ACTIVE_HIGH>;	/* PG11 */
+			label = "cx-a99:red:status";
+		};
+	};
+
+	powerseq_wifi: powerseq-wifi {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&ac100_rtc 1>;
+		clock-names = "ext_clock";
+		reset-gpios = <&r_pio 1 0 GPIO_ACTIVE_LOW>;	/* PM0 */
+		post-power-on-delay-ms = <1>;	/* Minimum 2 cycles. */
+	};
+
+	/* USB 3.0 standard-A receptacle. For now, only Vbus is supported. */
+	reg_usb0_vbus: regulator-usb0-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb0-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 7 15 GPIO_ACTIVE_HIGH>;	/* PH15 */
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	/*
+	 * A GL850G hub with two external USB connectors is connected
+	 * to ehci0. Each has a Vbus regulator controlled by a GPIO:
+	 * PL7 for port 1, closest to the 12 V power connector, and
+	 * PL8 for port 2, next to the SD card slot.
+	 * Because regulator-fixed doesn't support a GPIO list, and
+	 * allwinner,sun9i-a80-usb-phy doesn't support more than one
+	 * supply, we have to use regulator-always-on on usb1-2-vbus.
+	 * Note that the GPIO pins also need cldo1 to be enabled.
+	 */
+	reg_usb1_1_vbus: regulator-usb1-1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb1-1-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&r_pio 0 7 GPIO_ACTIVE_HIGH>;	/* PL7 */
+		enable-active-high;
+	};
+
+	reg_usb1_2_vbus: regulator-usb1-2-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb1-2-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&r_pio 0 8 GPIO_ACTIVE_HIGH>;	/* PL8 */
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	/* OZ80120 voltage regulator for the four Cortex-A15 cores. */
+	reg_vdd_cpub: regulator-vdd-cpub {
+		compatible = "regulator-gpio";
+
+		regulator-always-on;
+		regulator-min-microvolt = < 800000>;
+		regulator-max-microvolt = <1100000>;
+		regulator-name = "vdd-cpub";
+
+		enable-gpio = <&r_pio 0 2 GPIO_ACTIVE_HIGH>;	/* PL2 */
+		enable-active-high;
+		gpios = <&r_pio 0 3 GPIO_ACTIVE_HIGH>,		/* PL3 */
+			<&r_pio 0 4 GPIO_ACTIVE_HIGH>,		/* PL4 */
+			<&r_pio 0 5 GPIO_ACTIVE_HIGH>;		/* PL5 */
+
+		gpios-states = <1 0 0>;
+		states = <	 750000 0x7
+				 800000 0x3
+				 850000 0x5
+				 900000 0x1
+				 950000 0x6
+				1000000 0x2
+				1100000 0x4
+				1200000 0x0>;
+	};
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci2 {
+	status = "okay";
+};
+
+/*
+ * SD card slot. Although the GPIO pin for card detection is listed as capable
+ * of generating interrupts in the "A80 User Manual", this doesn't work for
+ * some unknown reason, so poll the GPIO for card detection. This is also what
+ * the vendor sys_config.fex file specifies.
+ */
+&mmc0 {
+	bus-width = <4>;
+	cd-gpios = <&pio 7 17 GPIO_ACTIVE_LOW>;	/* PH17 */
+	broken-cd;				/* Poll. */
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins>;
+	vmmc-supply = <&reg_dcdce>;
+	status = "okay";
+};
+
+/* Ampak AP6335 IEEE 802.11 a/b/g/n/ac "Wifi". */
+&mmc1 {
+	bus-width = <4>;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+	vmmc-supply = <&reg_cldo3>;	/* See cldo2,cldo3 note. */
+	vqmmc-supply = <&reg_aldo2>;
+	mmc-pwrseq = <&powerseq_wifi>;
+	status = "okay";
+};
+
+/* On-board eMMC card. */
+&mmc2 {
+	bus-width = <8>;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_8bit_pins>;
+	vmmc-supply = <&reg_dcdce>;
+	status = "okay";
+};
+
+&osc32k {
+	clocks = <&ac100_rtc 0>;
+};
+
+&r_ir {
+	status = "okay";
+};
+
+&r_rsb {
+	status = "okay";
+
+	ac100: codec at e89 {
+		compatible = "x-powers,ac100";
+		reg = <0xe89>;
+
+		ac100_codec: codec {
+			compatible = "x-powers,ac100-codec";
+			interrupt-parent = <&r_pio>;
+			interrupts = <0 9 IRQ_TYPE_LEVEL_LOW>;	/* PL9 */
+			#clock-cells = <0>;
+			clock-output-names = "4M_adda";
+		};
+
+		ac100_rtc: rtc {
+			compatible = "x-powers,ac100-rtc";
+			interrupt-parent = <&nmi_intc>;
+			interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&ac100_codec>;
+			#clock-cells = <1>;
+			clock-output-names = "cko1_rtc",
+					     "cko2_rtc",
+					     "cko3_rtc";
+		};
+	};
+
+	pmic at 745 {
+		compatible = "x-powers,axp808", "x-powers,axp806";
+		reg = <0x745>;
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		swin-supply = <&reg_dcdce>;
+
+		/* In comments: Initial setup from vendor sys_config.fex. */
+		regulators {
+			/* 3.0 V (enabled). */
+			reg_aldo1: aldo1 {
+				regulator-boot-on;
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-name = "vcc-3v0";
+			};
+
+			/* 1.8 V (enabled). */
+			reg_aldo2: aldo2 {
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-name = "vcc-pg-pm-wifi+btio-audio";
+			};
+
+			/* 2.5 V (enabled). */
+			reg_aldo3: aldo3 {
+				regulator-boot-on;
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <2500000>;
+				regulator-name = "vcc-pa-gmac2v5";
+			};
+
+			/* 1.8 V (enabled). */
+			reg_bldo1: bldo1 {
+				regulator-always-on;	/* Hang if disabled */
+				regulator-min-microvolt = <1700000>;
+				regulator-max-microvolt = <1900000>;
+				regulator-name = "vdd18-dll-vcc18-pll";
+			};
+
+			/* 0.9 V (enabled). */
+			reg_bldo2: bldo2 {
+				regulator-always-on;	/* Hang if disabled */
+				regulator-min-microvolt = < 800000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-name = "vdd-cpus";
+			};
+
+			/* 1.2 V (disabled). */
+			reg_bldo3: bldo3 {
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-name = "vcc12-hsic";
+			};
+
+			/* 1.1 V (enabled). */
+			reg_bldo4: bldo4 {
+				regulator-boot-on;
+				regulator-min-microvolt = < 800000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-name = "vdd09-hdmi";
+			};
+
+			/* 3.3 V (enabled). PLx pins control some regulators. */
+			reg_cldo1: cldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-pl-led";
+			};
+
+			/*
+			 * cldo2 and cldo3 are connected in parallel.
+			 * There is currently no way to express that.
+			 * For now, use regulator-always-on on cldo2 and lock
+			 * the voltage on both to 3.3 V.
+			 *
+			 * 3.3 V (disabled).
+			 */
+			reg_cldo2: cldo2 {
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vbat2-wifi+bt";
+			};
+
+			/* 3.3 V (disabled). */
+			reg_cldo3: cldo3 {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vbat1-wifi+bt";
+			};
+
+			/* 0.9 V (enabled). */
+			reg_dcdca: dcdca {
+				regulator-always-on;
+				regulator-min-microvolt = < 800000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-name = "vdd-cpua";
+			};
+
+			/* 1.5 V (enabled). */
+			reg_dcdcb: dcdcb {
+				regulator-always-on;
+				regulator-min-microvolt = <1450000>;
+				regulator-max-microvolt = <1550000>;
+				regulator-name = "vcc-dram";
+			};
+
+			/* 0.9 V (disabled). */
+			reg_dcdcc: dcdcc {
+				regulator-min-microvolt = < 800000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-name = "vdd-gpu";
+			};
+
+			/* 0.9 V (enabled). */
+			reg_dcdcd: dcdcd {
+				regulator-always-on;	/* Hang if disabled. */
+				regulator-min-microvolt = < 800000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-name = "vdd-sys";
+			};
+
+			/* 3.3 V (enabled). Supplies pin groups B-F and H. */
+			reg_dcdce: dcdce {
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-io-mmc-spdif";
+			};
+
+			/* 3.3 V (disabled). */
+			reg_sw: sw {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-gmac3v3-audio";
+			};
+		};
+	};
+};
+
+/*
+ * 5-pin connector opposite of the SD card slot:
+ * 1 = GND (pointed to by small triangle), 2 = GND, 3 = 3.3 V, 4 = RX, 5 = TX.
+ */
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "okay";
+};
+
+/* The port has two Vbus supplies. See workaround at regulator-usb1-1-vbus. */
+&usbphy1 {
+	phy-supply = <&reg_usb1_1_vbus>;
+	status = "okay";
+};
+
+&usbphy3 {
+	status = "okay";
+};
-- 
2.10.2
