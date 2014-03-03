From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 3 Mar 2014 10:41:02 +0100
Subject: Device Tree file for Zyxel NSA320
In-Reply-To: <5313C24A.9070306@baker-net.org.uk>
References: <53112C83.9010700@baker-net.org.uk>
 <20140301103417.GK27832@lunn.ch>
 <5313C24A.9070306@baker-net.org.uk>
Message-ID: <20140303094102.GA13805@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I'm now suspicious as to whether this actually works on NSA310. The
> regulator was named USB Power Off and was set to always-on. Hence
> USB Power Off was always enabled, i.e. USB was off. Changing the
> name (because having the word off in the name of a regulator doesn't
> make sense) and making it an active high regulator brings the USB to
> life.

Hi Adam

So either the original definition is wrong, our your board has the
level inverted. I would guess yours is inverted. I think removing the
_off is O.K, but for the moment i would not invert it in the
-common.dtsi. We should get it verifies that the current code does
work/is broken.

You should also be able to override the node in your own .dts
file. Something like:

        regulators {
                usb0_power: regulator at 1 {
			enable-active-high;
		} 		 	     
	}

I often "decompile" the .dtb file back to .dts so you can see what
actually happened. This device tree language can be error prone.

> They were copy / pasted with just the one change I'd spotted at the
> time (esata is now hdd2) but I've since found some more differences.
> I'll refactor once I get to the bottom of what really is common.

O.K. If there is not too much common, don't bother refactoring.
 
> My biggest outstanding issue is now with the GPIO pins that are not
> used in any of the setup files I have seen. Running my pin state
> monitor with the vendor kernel I can see that that configures some
> of the unused pins, 43, 45 and 49 as GPIO inputs. Currently 43 ends
> up configured as a TDM input which isn't too bad, 45 ends up
> configured as TDM I/O and 49 ends up configured as GPIO output which
> ought to be fixed as it will increase power consumption if nothing
> else. It seems the marvell,function in the pinctrl is ignored if the
> pin isn't used. Is there a good way to fix that?

Yes, partially, using pin hogs. You can at least set the function as
gpio, or any other function you want. You cannot however set the
direction if its a gpio.

Taking an example from kirkwood-ts219-6282.dts

                pinctrl: pinctrl at 10000 {

                        pinctrl-0 = <&pmx_ram_size &pmx_board_id>;
                        pinctrl-names = "default";

this results in pmx_ram_size and pmx_board_id being configured be
default, even if no driver claims them.
 
> I've located a driver at http://pastebin.com/3LNtYZSD that claims to
> be able to use some of the other unused pins to talk to a
> temperature sensor and also uses these pins to configure the
> response to power on after a power failure so I guess that needs
> adding eventually too.

OpenWRT also has a patch containing a driver.
 
> diff --git a/arch/arm/boot/dts/kirkwood-nsa310-common.dtsi
> b/arch/arm/boot/dts/kirkwood-nsa310-common.dtsi
> index aa78c2d..63e1b6f 100644
> --- a/arch/arm/boot/dts/kirkwood-nsa310-common.dtsi
> +++ b/arch/arm/boot/dts/kirkwood-nsa310-common.dtsi
> @@ -7,7 +7,7 @@
>  	ocp at f1000000 {
>  		pinctrl: pinctrl at 10000 {
> 
> -			pmx_usb_power_off: pmx-usb-power-off {
> +			pmx_usb_power: pmx-usb-power {
>  				marvell,pins = "mpp21";
>  				marvell,function = "gpio";
>  			};
> @@ -47,17 +47,18 @@
>  		compatible = "simple-bus";
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> -		pinctrl-0 = <&pmx_usb_power_off>;
> +		pinctrl-0 = <&pmx_usb_power>;
>  		pinctrl-names = "default";
> 
> -		usb0_power_off: regulator at 1 {
> +		usb0_power: regulator at 1 {
>  			compatible = "regulator-fixed";
>  			reg = <1>;
> -			regulator-name = "USB Power Off";
> +			regulator-name = "USB Power";
>  			regulator-min-microvolt = <5000000>;
>  			regulator-max-microvolt = <5000000>;
>  			regulator-always-on;
>  			regulator-boot-on;
> +			enable-active-high;
>  			gpio = <&gpio0 21 GPIO_ACTIVE_HIGH>;
>  		};
>  	};

This makes sense as a general cleanup. Please submit as a separate
patch, but as i said above, without the enable-active-high until we
can test it.

> diff --git a/arch/arm/boot/dts/kirkwood-nsa320.dts
> b/arch/arm/boot/dts/kirkwood-nsa320.dts
> new file mode 100644
> index 0000000..43f1e1d
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-nsa320.dts
> @@ -0,0 +1,252 @@
> +/dts-v1/;
> +
> +/* Device tree file for the Zyxel NSA 320 NAS box.
> +   Based upon the board setup file created by Peter Schildmann */

Just nice to have, but a copyright notice and license would be
good. Not all .dts files have them, but i suspect it will become more
important when these files move out of the kernel and into a repo of
there own.

> +
> +#include "kirkwood-nsa310-common.dtsi"
> +
> +/ {
> +	model = "Zyxel NSA320";
> +	compatible = "zyxel,nsa320", "marvell,kirkwood-88f6281",
> "marvell,kirkwood";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x20000000>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200";
> +	};
> +
> +	mbus {
> +		pcie-controller {
> +			status = "okay";
> +
> +			pcie at 1,0 {
> +				status = "okay";
> +			};
> +		};
> +	};
> +
> +	ocp at f1000000 {
> +		pinctrl: pinctrl at 10000 {
> +			pinctrl-names = "default";
> +
> +			/* SATA Activity and Present pins are not connected */
> +			pmx_sata0: pmx-sata0 {
> +				marvell,pins ;
> +				marvell,function = "sata0";
> +			};
> +
> +			pmx_sata1: pmx-sata1 {
> +				marvell,pins ;
> +				marvell,function = "sata1";
> +			};
> +
> +			pmx_led_hdd2_green: pmx-led-hdd2-green {
> +				marvell,pins = "mpp12";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_led_hdd2_red: pmx-led-hdd2-red {
> +				marvell,pins = "mpp13";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_mcu_data: pmx-mcu-data {
> +				marvell,pins = "mpp14";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_led_usb_green: pmx-led-usb-green {
> +				marvell,pins = "mpp15";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_mcu_clk: pmx-mcu-clk {
> +				marvell,pins = "mpp16";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_mcu_act: pmx-mcu-act {
> +				marvell,pins = "mpp17";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_led_sys_green: pmx-led-sys-green {
> +				marvell,pins = "mpp28";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_led_sys_orange: pmx-led-sys-orange {
> +				marvell,pins = "mpp29";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_btn_reset: pmx-btn-reset {
> +				marvell,pins = "mpp36";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_btn_copy: pmx-btn-copy {
> +				marvell,pins = "mpp37";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_led_copy_green: pmx-led-copy-green {
> +				marvell,pins = "mpp39";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_led_copy_red: pmx-led-copy-red {
> +				marvell,pins = "mpp40";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_led_hdd1_green: pmx-led-hdd1-green {
> +				marvell,pins = "mpp41";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_led_hdd1_red: pmx-led-hdd1-red {
> +				marvell,pins = "mpp42";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_htp: pmx-htp {
> +				marvell,pins = "mpp43";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_buzzer: pmx-buzzer {
> +				marvell,pins = "mpp44";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_vid_b1: pmx-vid-b1 {
> +				marvell,pins = "mpp45";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_btn_power: pmx-btn-power {
> +				marvell,pins = "mpp46";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_power_resume_data: pmx-power-resume-data {
> +				marvell,pins = "mpp47";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_power_resume_clk: pmx-power-resume-clk {
> +				marvell,pins = "mpp49";
> +				marvell,function = "gpio";
> +			};
> +		};
> +
> +		i2c at 11000 {
> +			status = "okay";
> +
> +			pcf8563: pcf8563 at 51 {
> +				compatible = "nxp,pcf8563";
> +				reg = <0x51>;
> +			};
> +		};
> +	};
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-0 = <&pmx_btn_reset &pmx_btn_copy &pmx_btn_power>;
> +		pinctrl-names = "default";
> +
> +		button at 1 {
> +			label = "Power Button";
> +			linux,code = <KEY_POWER>;
> +			gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;
> +		};
> +		button at 2 {
> +			label = "Copy Button";
> +			linux,code = <KEY_COPY>;
> +			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
> +		};
> +		button at 3 {
> +			label = "Reset Button";
> +			linux,code = <KEY_RESTART>;
> +			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +		pinctrl-0 = <&pmx_led_hdd2_green &pmx_led_hdd2_red
> +			     &pmx_led_usb_green
> +			     &pmx_led_sys_green &pmx_led_sys_orange
> +			     &pmx_led_copy_green &pmx_led_copy_red
> +			     &pmx_led_hdd1_green &pmx_led_hdd1_red
> +			     &pmx_buzzer>;

I guess this last one does not belong here. It should be in the beeper
node below.

> +		pinctrl-names = "default";
> +
> +		green-sys {
> +			label = "nsa320:green:sys";
> +			gpios = <&gpio0 28 GPIO_ACTIVE_HIGH>;
> +		};
> +		orange-sys {
> +			label = "nsa320:orange:sys";
> +			gpios = <&gpio0 29 GPIO_ACTIVE_HIGH>;
> +		};
> +		green-hdd1 {
> +			label = "nsa320:green:hdd1";
> +			gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
> +		};
> +		red-hdd1 {
> +			label = "nsa320:red:hdd1";
> +			gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
> +		};
> +		green-hdd2 {
> +			label = "nsa320:green:hdd2";
> +			gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>;
> +		};
> +		red-hdd2 {
> +			label = "nsa320:red:hdd2";
> +			gpios = <&gpio0 13 GPIO_ACTIVE_HIGH>;
> +		};
> +		green-usb {
> +			label = "nsa320:green:usb";
> +			gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>;
> +		};
> +		green-copy {
> +			label = "nsa320:green:copy";
> +			gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
> +		};
> +		red-copy {
> +			label = "nsa320:red:copy";
> +			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +	beeper: beeper {
> +		compatible = "gpio-beeper";
> +		gpios = <&gpio1 12 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	/* The following pins are currently not assigned to a driver,
> +	   some of them should be configured as inputs.
> +	pinctrl-0 = <&pmx_mcu_data &pmx_mcu_clk &pmx_mcu_act
> +		     &pmx_htp &pmx_vid_b1
> +		     &pmx_power_resume_data &pmx_power_resume_clk>; */

These will become your pin hogs.

> +};
> +
> +&mdio {
> +	status = "okay";
> +	ethphy0: ethernet-phy at 1 {
> +		reg = <1>;
> +	};
> +};
> +
> +&eth0 {
> +	status = "okay";
> +	ethernet0-port at 0 {
> +		phy-handle = <&ethphy0>;
> +	};
> +};
> 

Looking good otherwise.

	Andrew
