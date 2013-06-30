From: arno@natisbad.org (Arnaud Ebalard)
Date: Sun, 30 Jun 2013 22:59:31 +0200
Subject: [RFC] Add .dts file for Netgear ReadyNAS 102
Message-ID: <87fvvzfh70.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is a .dts file for Armada-370-based Netgear ReadyNAS 102. The
purpose of this submission is to get some feedback and also some
directions on how to proceed to get it included at some point.

Regarding the device, I put some information on the various hardware
parts here: http://natisbad.org/NAS2/ . I still have to update the
page now that almost everything is as it should.

With the appended .dts file, all the various parts of the device work
as expected:

 - USB 3.0 rear ports via FL1009 XHCI controller connected to PCIe
   bus (eSATA not tested yet)
 - USB 2.0 front port
 - Gigabit Ethernet port (MAC needs to be set by the system at boot)
 - Backup, Power and Reset buttons
 - LEDS (most set to on but changeable). At the moment, I still have not
   found by which gpio the last one is controlled (activity led).
 - serial port at the rear

 - G762 PWM fan controller on I2C bus: it requires G762 driver which
   is *currently sitting in hwmon maintainer tree* and will be available
   in 3.11. Jason, as a side note I have a short patch for available for
   ReadyNAS Duo v2 .dts file (the device also has a G762). I can hold
   it until rc cycle if you prefer.

 - Intersil ISL 12057 RTC on I2C bus: support for that one is *not
   available upstream yet* but I have an initial working patch which I
   intend to push upstream (same as for G762 driver).

In the end, the main missing part is the NAND but I guess this is the
same for all Aramda 370/XP boards and this is not a big issue as it is
still possible to interact w/ it via u-boot and install a set of
uImage/uInitramfs that way. 

Jason, the tests were done against your for-next branch (with all the
fixes which accumulated in Linux tree from rc7). I will work directly
against Linus tree as soon as the rc- cycle for 3.11 starts. 

Additionally, I don't think this is a problem but my whole toolchain is
an arm-linux-gnueabi- one and the tests were done using a Debian (ho hfp
at all).

Cheers,

a+

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 arch/arm/boot/dts/Makefile                     |   1 +
 arch/arm/boot/dts/armada-370-netgear-rn102.dts | 215 +++++++++++++++++++++++++
 2 files changed, 216 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-370-netgear-rn102.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ae7124c..076ff01 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -97,6 +97,7 @@ dtb-$(CONFIG_ARCH_MSM) += msm8660-surf.dtb \
 	msm8960-cdp.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
 	armada-370-mirabox.dtb \
+	armada-370-netgear-rn102.dtb \
 	armada-370-rd.dtb \
 	armada-xp-db.dtb \
 	armada-xp-gp.dtb \
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
new file mode 100644
index 0000000..5a9e129
--- /dev/null
+++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
@@ -0,0 +1,215 @@
+/*
+ * Device Tree file for NETGEAR ReadyNAS 102
+ *
+ * Copyright (C) 2013, Arnaud EBALARD <arno@natisbad.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+/dts-v1/;
+
+/include/ "armada-370.dtsi"
+
+/ {
+	model = "NETGEAR ReadyNAS 102";
+	compatible = "netgear,readynas-102", "marvell,armada370", "marvell,armada-370-xp";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlyprintk";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>; /* 512 MB */
+	};
+
+	soc {
+		internal-regs {
+			serial at 12000 {
+				clock-frequency = <200000000>;
+				status = "okay";
+			};
+
+			sata at a0000 {
+				nr-ports = <2>;
+				status = "okay";
+			};
+
+			pinctrl {
+				power_led_pin: power-led-pin {
+					marvell,pins = "mpp57";
+					marvell,function = "gpio";
+				};
+				sata1_led_pin: sata1-led-pin {
+					marvell,pins = "mpp15";
+					marvell,function = "gpio";
+				};
+
+				sata2_led_pin: sata2-led-pin {
+					marvell,pins = "mpp14";
+					marvell,function = "gpio";
+				};
+
+				backup_led_pin: backup-led-pin {
+					marvell,pins = "mpp56";
+					marvell,function = "gpio";
+				};
+			};
+
+			gpio_leds {
+				compatible = "gpio-leds";
+				pinctrl-0 = < &power_led_pin
+					      &sata1_led_pin
+					      &sata2_led_pin
+					      &backup_led_pin >;
+				pinctrl-names = "default";
+
+				blue_power_led {
+					label = "rn102:blue:pwr";
+					gpios = <&gpio1 25 1>;  /* GPIO 57 Active Low */
+					linux,default-trigger = "heartbeat";
+				};
+
+				green_sata1_led {
+					label = "rn102:green:sata1";
+					gpios = <&gpio0 15 1>;  /* GPIO 15 Active Low */
+					default-state = "on";
+				};
+
+				green_sata2_led {
+					label = "rn102:green:sata2";
+					gpios = <&gpio0 14 1>;   /* GPIO 14 Active Low */
+					default-state = "on";
+				};
+
+				green_backup_led {
+					label = "rn102:green:backup";
+					gpios = <&gpio1 24 1>;   /* GPIO 56 Active Low */
+					default-state = "on";
+				};
+			};
+
+			gpio_keys {
+				compatible = "gpio-keys";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				button at 1 {
+					label = "Power Button";
+					linux,code = <116>;     /* KEY_POWER */
+					gpios = <&gpio1 30 1>;
+				};
+				button at 2 {
+					label = "Reset Button";
+					linux,code = <0x198>;   /* KEY_RESTART */
+					gpios = <&gpio0 6 1>;
+				};
+				button at 3 {
+					label = "Backup Button";
+					linux,code = <133>;     /* KEY_COPY */
+					gpios = <&gpio1 26 1>;
+				};
+			};
+
+			mdio {
+				phy0: ethernet-phy at 0 {
+					reg = <0>;
+				};
+			};
+
+			ethernet at 74000 {
+				status = "okay";
+				phy = <&phy0>;
+				phy-mode = "rgmii-id";
+			};
+
+			/* Waiting for NAND support to appear in armada-370.dtsi
+
+			nand at d0000 {
+				status = "okay";
+
+				partition at 0 {
+				   label = "u-boot";
+				   reg = <0x0000000 0x180000>;
+				   read-only;
+				};
+
+				partition at 180000 {
+				   label = "u-boot-env";
+				   reg = <0x180000 0x20000>;
+				};
+
+				partition at 200000 {
+				   label = "uImage";
+				   reg = <0x0200000 0x600000>;
+				};
+
+				partition at 800000 {
+				   label = "minirootfs";
+				   reg = <0x0800000 0x400000>;
+				};
+
+				partition at c00000 {
+				   label = "ubi";
+				   reg = <0x0c00000 0x7400000>;
+				};
+			};
+
+			*/
+
+			usb at 50000 {
+				status = "okay";
+			};
+
+			clocks {
+			       #address-cells = <1>;
+			       #size-cells = <0>;
+
+			       g762_clk: fixedclk {
+					 compatible = "fixed-clock";
+					 #clock-cells = <0>;
+					 clock-frequency = <8192>;
+			       };
+			};
+
+			i2c at 11000 {
+				compatible = "marvell,mv64xxx-i2c";
+				clock-frequency = <100000>;
+				status = "okay";
+
+				isl12057: isl12057 at 68 {
+					compatible = "isil,isl12057";
+					reg = <0x68>;
+					wakeup-source;
+				};
+
+				g762: g762 at 3e {
+					compatible = "gmt,g762";
+					reg = <0x3e>;
+					clocks = <&g762_clk>; /* input clock */
+					fan_gear_mode = <0>;
+					fan_startv = <1>;
+					pwm_polarity = <0>;
+				};
+			};
+
+			pcie-controller {
+				status = "okay";
+
+				/* Connected to Marvell SATA controller */
+				pcie at 1,0 {
+					/* Port 0, Lane 0 */
+					status = "okay";
+				};
+
+				/* Connected to FL1009 USB 3.0 controller */
+				pcie at 2,0 {
+					/* Port 1, Lane 0 */
+					status = "okay";
+				};
+			};
+		};
+	};
+};
-- 
1.8.3.1
