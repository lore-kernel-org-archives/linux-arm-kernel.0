From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 15 Feb 2017 16:06:54 +0100
Subject: [PATCH v3] ARM: dts: armada-385-synology-ds116: add support for
 Synology DS116 NAS
In-Reply-To: <1486891835-6641-1-git-send-email-w@1wt.eu> (Willy Tarreau's
 message of "Sun, 12 Feb 2017 10:30:35 +0100")
References: <1486891835-6641-1-git-send-email-w@1wt.eu>
Message-ID: <87mvdncx2p.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Willy,
 
 On dim., f?vr. 12 2017, Willy Tarreau <w@1wt.eu> wrote:

> This commit adds the device tree description for the Synology DS116 NAS.
>
> It is a one-bay NAS powered by a Marvell Armada 385 at 1.866 GHz. The
> device features the following items :
>   - 1 GB DDR3 RAM
>   - a 8MB SPI flash
>   - 2 USB3 ports, power-controlled via a GPIO for each
>   - 1 gigabit ethernet interface connected over SGMII to a 88e1514 phy
>   - a single SATA port, power-controlled via a GPIO
>   - a battery-powered RTC
>   - one UART connected to the serial console (2mm connector on board)
>   - the Tx line of the second UART connected to a PIC microcontroller
>     dealing with beep, reset, power-off and LED blinking (9600 Bps)
>   - some of the front-panel LEDs are connected to GPIOs, one is directly
>     connected to the SATA link to report disk activity.
>   - a GPIO-controlled fan (3 bits for 7 speeds and OFF)
>
> With this DTS, my NAS is 100% functional starting with kernel 4.9.
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Willy Tarreau <w@1wt.eu>

Applied on mvebu/dt-4.12

Thanks,

Gregory
>
> ---
> v3:
>   - rebased it on master, v2 was accidently sent for 4.9 and conflicts there
>
> v2, after Andrew's review:
>   - added a poweroff node in addition to serial1 (tested and works)
>   - changed the comment to mention that serial1's speed is 9600 not 115200 bps
>     after a new series of test, don't know why I believed I tested it at 115k.
>   - fixed a typo in a comment
> ---
>  arch/arm/boot/dts/Makefile                      |   1 +
>  arch/arm/boot/dts/armada-385-synology-ds116.dts | 321 ++++++++++++++++++++++++
>  2 files changed, 322 insertions(+)
>  create mode 100644 arch/arm/boot/dts/armada-385-synology-ds116.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 01d178a..2bc2b33 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -949,6 +949,7 @@ dtb-$(CONFIG_MACH_ARMADA_38X) += \
>  	armada-385-db-ap.dtb \
>  	armada-385-linksys-caiman.dtb \
>  	armada-385-linksys-cobra.dtb \
> +	armada-385-synology-ds116.dtb \
>  	armada-385-turris-omnia.dtb \
>  	armada-388-clearfog.dtb \
>  	armada-388-db.dtb \
> diff --git a/arch/arm/boot/dts/armada-385-synology-ds116.dts b/arch/arm/boot/dts/armada-385-synology-ds116.dts
> new file mode 100644
> index 0000000..31510eb
> --- /dev/null
> +++ b/arch/arm/boot/dts/armada-385-synology-ds116.dts
> @@ -0,0 +1,321 @@
> +/*
> + * Device Tree file for Synology DS116 NAS
> + *
> + * Copyright (C) 2017 Willy Tarreau <w@1wt.eu>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is licensed under the terms of the GNU General Public
> + *     License version 2.  This program is licensed "as is" without
> + *     any warranty of any kind, whether express or implied.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +/dts-v1/;
> +#include "armada-385.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model = "Synology DS116";
> +	compatible = "marvell,a385-gp", "marvell,armada385", "marvell,armada380";
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x40000000>; /* 1 GB */
> +	};
> +
> +	soc {
> +		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
> +			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000
> +			  MBUS_ID(0x09, 0x19) 0 0xf1100000 0x10000
> +			  MBUS_ID(0x09, 0x15) 0 0xf1110000 0x10000
> +			  MBUS_ID(0x0c, 0x04) 0 0xf1200000 0x100000>;
> +
> +		internal-regs {
> +			i2c at 11000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&i2c0_pins>;
> +				status = "okay";
> +				clock-frequency = <100000>;
> +
> +				eeprom at 57 {
> +					compatible = "atmel,24c64";
> +					reg = <0x57>;
> +				};
> +			};
> +
> +			serial at 12000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&uart0_pins>;
> +				status = "okay";
> +			};
> +
> +			serial at 12100 {
> +				/* A PIC16F1829 is connected to uart1 at 9600 bps,
> +				 * and takes single-character orders :
> +				 *   "1" : power off // already handled by the poweroff node
> +				 *   "2" : short beep
> +				 *   "3" : long beep
> +				 *   "4" : turn the power LED ON
> +				 *   "5" : flash the power LED
> +				 *   "6" : turn the power LED OFF
> +				 *   "7" : turn the status LED OFF
> +				 *   "8" : turn the status LED ON
> +				 *   "9" : flash the status LED
> +				 *   "A" : flash the motherboard LED (D8)
> +				 *   "B" : turn the motherboard LED OFF
> +				 *   "C" : hard reset
> +				 */
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&uart1_pins>;
> +				status = "okay";
> +			};
> +
> +			poweroff at 12100 {
> +				compatible = "synology,power-off";
> +				reg = <0x12100 0x100>;
> +				clocks = <&coreclk 0>;
> +			};
> +
> +			ethernet at 70000 {
> +				pinctrl-names = "default";
> +				phy = <&phy0>;
> +				phy-mode = "sgmii";
> +				buffer-manager = <&bm>;
> +				bm,pool-long = <0>;
> +				status = "okay";
> +			};
> +
> +
> +			mdio at 72004 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&mdio_pins>;
> +
> +				phy0: ethernet-phy at 1 {
> +					reg = <1>;
> +				};
> +			};
> +
> +			sata at a8000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&sata0_pins>;
> +				status = "okay";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				sata0: sata-port at 0 {
> +					reg = <0>;
> +					target-supply = <&reg_5v_sata0>;
> +				};
> +			};
> +
> +			bm at c8000 {
> +				status = "okay";
> +			};
> +
> +			usb3 at f0000 {
> +				usb-phy = <&usb3_0_phy>;
> +				status = "okay";
> +			};
> +
> +			usb3 at f8000 {
> +				usb-phy = <&usb3_1_phy>;
> +				status = "okay";
> +			};
> +		};
> +
> +		bm-bppi {
> +			status = "okay";
> +		};
> +
> +		gpio-fan {
> +			compatible = "gpio-fan";
> +			gpios = <&gpio1 18 GPIO_ACTIVE_HIGH>,
> +				<&gpio1 17 GPIO_ACTIVE_HIGH>,
> +				<&gpio1 16 GPIO_ACTIVE_HIGH>;
> +			gpio-fan,speed-map = <   0 0
> +					      1500 1
> +					      2500 2
> +					      3000 3
> +					      3400 4
> +					      3700 5
> +					      3900 6
> +					      4000 7>;
> +			cooling-cells = <2>;
> +		};
> +
> +		gpio-leds {
> +			compatible = "gpio-leds";
> +
> +			/* The green part is on gpio0.20 which is also used by
> +			 * sata0, and accesses to SATA disk 0 make it blink so it
> +			 * doesn't need to be declared here.
> +			 */
> +			orange {
> +				gpios = <&gpio0 13 GPIO_ACTIVE_HIGH>;
> +				label = "ds116:orange:disk";
> +				default-state = "off";
> +			};
> +		};
> +	};
> +
> +	usb3_0_phy: usb3_0_phy {
> +		compatible = "usb-nop-xceiv";
> +		vcc-supply = <&reg_usb3_0_vbus>;
> +	};
> +
> +	usb3_1_phy: usb3_1_phy {
> +		compatible = "usb-nop-xceiv";
> +		vcc-supply = <&reg_usb3_1_vbus>;
> +	};
> +
> +	reg_usb3_0_vbus: usb3-vbus0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb3-vbus0";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&xhci0_vbus_pins>;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		enable-active-high;
> +		gpio = <&gpio1 26 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	reg_usb3_1_vbus: usb3-vbus1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb3-vbus1";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&xhci1_vbus_pins>;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		enable-active-high;
> +		gpio = <&gpio1 27 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	reg_sata0: pwr-sata0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pwr_en_sata0";
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +		enable-active-high;
> +		regulator-boot-on;
> +		gpio = <&gpio0 15 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	reg_5v_sata0: v5-sata0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "v5.0-sata0";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&reg_sata0>;
> +	};
> +
> +	reg_12v_sata0: v12-sata0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "v12.0-sata0";
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +		vin-supply = <&reg_sata0>;
> +	};
> +};
> +
> +&spi0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi0_pins>;
> +	status = "okay";
> +
> +	spi-flash at 0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "macronix,mx25l6405d", "jedec,spi-nor";
> +		reg = <0>; /* Chip select 0 */
> +		spi-max-frequency = <50000000>;
> +		m25p,fast-read;
> +
> +		/* Note: there is a redboot partition table despite u-boot
> +		 * being used. The names presented here are the same as those
> +		 * found in the FIS directory. There is also a small device
> +		 * tree in the last 64kB of the RedBoot partition which is not
> +		 * enumerated. The MAC address and the serial number are listed
> +		 * in the "vendor" partition.
> +		 */
> +		partition at 00000000 {
> +			label = "RedBoot";
> +			reg = <0x00000000 0x000f0000>;
> +			read-only;
> +		};
> +
> +		partition at 000c0000 {
> +			label = "zImage";
> +			reg = <0x000f0000 0x002d0000>;
> +		};
> +
> +		partition at 00390000 {
> +			label = "rd.gz";
> +			reg = <0x003c0000 0x00410000>;
> +		};
> +
> +		partition at 007d0000 {
> +			label = "vendor";
> +			reg = <0x007d0000 0x00010000>;
> +			read-only;
> +		};
> +
> +		partition at 007e0000 {
> +			label = "RedBoot config";
> +			reg = <0x007e0000 0x00010000>;
> +			read-only;
> +		};
> +
> +		partition at 007f0000 {
> +			label = "FIS directory";
> +			reg = <0x007f0000 0x00010000>;
> +			read-only;
> +		};
> +	};
> +};
> +
> +&pinctrl {
> +	/* use only one pin for UART1, as mpp20 is used by sata0 */
> +	uart1_pins: uart-pins-1 {
> +		marvell,pins = "mpp19";
> +		marvell,function = "ua1";
> +	};
> +
> +	xhci0_vbus_pins: xhci0_vbus_pins {
> +		marvell,pins = "mpp58";
> +		marvell,function = "gpio";
> +	};
> +	xhci1_vbus_pins: xhci1_vbus_pins {
> +		marvell,pins = "mpp59";
> +		marvell,function = "gpio";
> +	};
> +};
> -- 
> 2.8.0.rc2.1.gbe9624a
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
