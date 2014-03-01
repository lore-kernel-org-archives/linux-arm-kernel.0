From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 1 Mar 2014 11:34:17 +0100
Subject: Device Tree file for Zyxel NSA320
In-Reply-To: <53112C83.9010700@baker-net.org.uk>
References: <53112C83.9010700@baker-net.org.uk>
Message-ID: <20140301103417.GK27832@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 01, 2014 at 12:40:35AM +0000, Adam Baker wrote:
> Hi,
> 
> I've been trying to get my Zyxel NSA320 working with kernel 3.14-rc1
> and device tree. I've included on CC the two developers who produced
> old style board files for the NSA310 / 320 in case you've already
> looked at this.

Hi Adam

It is good to also CC the Marvell maintainers. I added them.

First off, thanks for working on a new board. 

> I've developed a file (below) which is enough to get it to boot but
> I've got a couple of outstanding issues that I'd appreciate some
> advice on.

Great. I will review it and try to help with your issues.

> First, the USB ports aren't working. I presume this is because on
> this board mpp21, instead of taking it's usual role as
> MPP21_SATA0_ACTn is used as a control line for power to the USB
> ports. My dmesg contains
> 
> Kirkwood: MV88F6281-A1.
> Feroceon L2: Enabling L2
> Feroceon L2: Cache support initialised.
> [Firmware Info]: /ocp at f1000000/ethernet-controller at 72000/ethernet0-
> port at 0: local-mac-address is not set
> bio: create slab <bio-0> at 0
> USB Power Off: Failed to request enable GPIO21: -517
> reg-fixed-voltage 1.regulator: Failed to register regulator: -517
> platform 1.regulator: Driver reg-fixed-voltage requests probe deferral
> vgaarb: loaded
> SCSI subsystem initialized
> 
> and I can't see any indication that the deferred registration ever succeeds.

I'm not sure you ever do. But you should be able to see something in
/sys/kernel/debug/regulator/
 
> /sys/kernel/debug/pinctrl/f1010000.pinctrl/pinmux-pins contains
> 
> pin 21 (PIN21): (MUX UNCLAIMED) mvebu-gpio:21
> 
> but /sys/kernel/debug/pinctrl/f1010000.pinctrl/pinconf-groups says
> 21 (mpp21):current: gpio(io), available = [ ts(mp1) tdm(rx0ql)
> ge1(txd1) audio(spdifo) sata0(act) ]
> 
> so I suspect it has defaulted to the right mode but
> /sys/kernel/debug/gpio says
> 
>  gpio-21  (USB Power Off       ) out lo

What is interesting is that it has the name. Some something is working
here. What might help is turning on REGULATOR_DEBUG.

> The other issue I've found is that the Ethernet only works if I have
> booted the original kernel at least once since the unit was powered
> on. It does get the correct MAC address when it doesn't work. I'm
> not sure what might be causing that other than that Ethernet from
> uboot apparently only works if connected to a 1G switch.

This sounds like a phy issue. You have it at address one. Does your
u-boot have the commands:

Marvell>> help phyRead
phyRead  Phy_address Phy_offset. 
        Read the Phy register. 

What do you get with:

phyRead 1 0

> Whilst writing this device tree file I have noticed that the
> Ethernet node is missing from the NSA310 files. Unfortunately there
> are 2 variants of the 310 and I've only ever seen one board setup
> file that specifies the phy number and as that doesn't match the 320
> I don't feel able to fix that without someone to test it.

We can probably get somebody to test, if you can provide a patch.
 
> I do realise that when sending this as a proper patch you will need
> a signed off by and you will need it sent via something other than
> Thunderbird that can be relied upon not to mangle the patch.

git send-email is the preferred method.

> diff --git a/arch/arm/boot/dts/kirkwood-nsa320.dts
> b/arch/arm/boot/dts/kirkwood-nsa320.dts
> new file mode 100644
> index 0000000..d91a480
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-nsa320.dts
> @@ -0,0 +1,203 @@
> +/dts-v1/;
> +
> +#include "kirkwood-nsa310-common.dtsi"
> +
> +/ {
> +       model = "Zyxel NSA320";
> +	compatible = "zyxel,nsa320", "marvell,kirkwood-88f6281",
> "marvell,kirkwood";

You have a mixture of tabs and space in this file. Please use tabs.


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
> +			pinctrl-0 = <&pmx_unknown>;
> +			pinctrl-names = "default";
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
> +			pmx_led_usb_green: pmx-led-usb-green {
> +				marvell,pins = "mpp15";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_led_usb_red: pmx-led-usb-red {
> +				marvell,pins = "mpp16";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_led_sys_green: pmx-led-sys-green {
> +				marvell,pins = "mpp28";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_led_sys_red: pmx-led-sys-red {
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
> +			pmx_unknown: pmx-unknown {
> +				marvell,pins = "mpp44";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_btn_power: pmx-btn-power {
> +				marvell,pins = "mpp46";
> +				marvell,function = "gpio";
> +			};
> +		};

These all look identical to nsa310. Maybe it makes sense to refactor
kirkwood-nsa310.dts and place the common parts into a .dtsi file?

> +
> +		i2c at 11000 {
> +			status = "okay";
> +
> +			pcf8563: pcf8563 at 51 {
> +				compatible = "pcf8563";

Please put a vendor name in the compatible string. So it should be
"nxp,pcf8563". We have only just started to enforce this, and lots of
existing files need fixing.

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
> +			     &pmx_led_usb_green &pmx_led_usb_red
> +			     &pmx_led_sys_green &pmx_led_sys_red
> +			     &pmx_led_copy_green &pmx_led_copy_red
> +			     &pmx_led_hdd1_green &pmx_led_hdd1_red>;
> +		pinctrl-names = "default";
> +
> +		green-sys {
> +			label = "nsa320:green:sys";
> +			gpios = <&gpio0 28 GPIO_ACTIVE_HIGH>;
> +		};
> +		red-sys {
> +			label = "nsa320:red:sys";
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
> +		red-usb {
> +			label = "nsa320:red:usb";
> +			gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
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
> +};
> +
> +&mdio {
> +       	status = "okay";
> +
> +        ethphy0: ethernet-phy at 1 {
> +                reg = <1>;
> +       	};
> +};
> +
> +&eth0 {
> +       	status = "okay";
> +       	ethernet0-port at 0 {
> +               	phy-handle = <&ethphy0>;
> +       	};
> +};

Here you can see how the mixture of tabs and spaces causes problems...
