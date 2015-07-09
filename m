From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 09 Jul 2015 15:12:27 +0200
Subject: [PATCH v2 1/2] ARM: dts: add buffalo linkstation ls-wxl/wsxl
In-Reply-To: <20150629133816.GA4535@lunn.ch>
References: <1434713319-8691-2-git-send-email-rogershimizu@gmail.com>
 <1434985216-6409-1-git-send-email-rogershimizu@gmail.com>
 <559146AD.4040602@free-electrons.com> <20150629133816.GA4535@lunn.ch>
Message-ID: <559E733B.7010206@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew, Roger,



On 29/06/2015 15:38, Andrew Lunn wrote:
> On Mon, Jun 29, 2015 at 03:22:53PM +0200, Gregory CLEMENT wrote:
>> Hi Roger,
>>
>> On 22/06/2015 17:00, Roger Shimizu wrote:
>>> Add dts file to support Buffalo Linkstation LS-WXL and LS-WSXL,
>>> which are 2-bay NAS with 3.5" and 2.5" HDD respectively.
>>>
>>> Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
>>> Reviewed-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>>
>> it seems that you addressed Andrew's remarks too, so
>>
>> Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>
>> However I will wait for Andrew's formal acked-by before applying it.
> 
> Thanks for the reminder:
> 
> Acked-by: Andrew Lunn <andrew@lunn.ch>
> 
> 	  Andrew


now applied on mvebu/dt

Thanks,

Gregory

> 
> 
>>
>> Thanks,
>>
>> Gregory
>>> ---
>>>  .../devicetree/bindings/arm/marvell,kirkwood.txt   |   1 +
>>>  arch/arm/boot/dts/Makefile                         |   1 +
>>>  arch/arm/boot/dts/kirkwood-lswxl.dts               | 301 +++++++++++++++++++++
>>>  3 files changed, 303 insertions(+)
>>>  create mode 100644 arch/arm/boot/dts/kirkwood-lswxl.dts
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt b/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt
>>> index 4f40ff3..b79212f 100644
>>> --- a/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt
>>> +++ b/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt
>>> @@ -20,6 +20,7 @@ And in addition, the compatible shall be extended with the specific
>>>  board. Currently known boards are:
>>>  
>>>  "buffalo,lschlv2"
>>> +"buffalo,lswxl"
>>>  "buffalo,lsxhl"
>>>  "buffalo,lsxl"
>>>  "dlink,dns-320"
>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>>> index a8bf702..b45c974 100644
>>> --- a/arch/arm/boot/dts/Makefile
>>> +++ b/arch/arm/boot/dts/Makefile
>>> @@ -176,6 +176,7 @@ dtb-$(CONFIG_MACH_KIRKWOOD) += \
>>>  	kirkwood-km_kirkwood.dtb \
>>>  	kirkwood-laplug.dtb \
>>>  	kirkwood-lschlv2.dtb \
>>> +	kirkwood-lswxl.dtb \
>>>  	kirkwood-lsxhl.dtb \
>>>  	kirkwood-mplcec4.dtb \
>>>  	kirkwood-mv88f6281gtw-ge.dtb \
>>> diff --git a/arch/arm/boot/dts/kirkwood-lswxl.dts b/arch/arm/boot/dts/kirkwood-lswxl.dts
>>> new file mode 100644
>>> index 0000000..f5db16a
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/kirkwood-lswxl.dts
>>> @@ -0,0 +1,301 @@
>>> +/*
>>> + * Device Tree file for Buffalo Linkstation LS-WXL/WSXL
>>> + *
>>> + * Copyright (C) 2015, rogershimizu at gmail.com
>>> + *
>>> + * This program is free software; you can redistribute it and/or
>>> + * modify it under the terms of the GNU General Public License
>>> + * as published by the Free Software Foundation; either version
>>> + * 2 of the License, or (at your option) any later version.
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "kirkwood.dtsi"
>>> +#include "kirkwood-6281.dtsi"
>>> +
>>> +/ {
>>> +	model = "Buffalo Linkstation LS-WXL/WSXL";
>>> +	compatible = "buffalo,lswxl", "marvell,kirkwood-88f6281", "marvell,kirkwood";
>>> +
>>> +	memory { /* 128 MB */
>>> +		device_type = "memory";
>>> +		reg = <0x00000000 0x8000000>;
>>> +	};
>>> +
>>> +	chosen {
>>> +		bootargs = "console=ttyS0,115200n8 earlyprintk";
>>> +		stdout-path = &uart0;
>>> +	};
>>> +
>>> +	mbus {
>>> +		pcie-controller {
>>> +			status = "okay";
>>> +			pcie at 1,0 {
>>> +				status = "okay";
>>> +			};
>>> +		};
>>> +	};
>>> +
>>> +	ocp at f1000000 {
>>> +		pinctrl: pin-controller at 10000 {
>>> +			pmx_power_hdd0: pmx-power-hdd0 {
>>> +				marvell,pins = "mpp28";
>>> +				marvell,function = "gpio";
>>> +			};
>>> +			pmx_power_hdd1: pmx-power-hdd1 {
>>> +				marvell,pins = "mpp29";
>>> +				marvell,function = "gpio";
>>> +			};
>>> +			pmx_usb_vbus: pmx-usb-vbus {
>>> +				marvell,pins = "mpp37";
>>> +				marvell,function = "gpio";
>>> +			};
>>> +			pmx_fan_high: pmx-fan-high {
>>> +				marvell,pins = "mpp47";
>>> +				marvell,function = "gpio";
>>> +			};
>>> +			pmx_fan_low: pmx-fan-low {
>>> +				marvell,pins = "mpp48";
>>> +				marvell,function = "gpio";
>>> +			};
>>> +			pmx_led_hdderr0: pmx-led-hdderr0 {
>>> +				marvell,pins = "mpp8";
>>> +				marvell,function = "gpio";
>>> +			};
>>> +			pmx_led_hdderr1: pmx-led-hdderr1 {
>>> +				marvell,pins = "mpp46";
>>> +				marvell,function = "gpio";
>>> +			};
>>> +			pmx_led_alarm: pmx-led-alarm {
>>> +				marvell,pins = "mpp49";
>>> +				marvell,function = "gpio";
>>> +			};
>>> +			pmx_led_function_red: pmx-led-function-red {
>>> +				marvell,pins = "mpp34";
>>> +				marvell,function = "gpio";
>>> +			};
>>> +			pmx_led_function_blue: pmx-led-function-blue {
>>> +				marvell,pins = "mpp36";
>>> +				marvell,function = "gpio";
>>> +			};
>>> +			pmx_led_info: pmx-led-info {
>>> +				marvell,pins = "mpp38";
>>> +				marvell,function = "gpio";
>>> +			};
>>> +			pmx_led_power: pmx-led-power {
>>> +				marvell,pins = "mpp39";
>>> +				marvell,function = "gpio";
>>> +			};
>>> +			pmx_fan_lock: pmx-fan-lock {
>>> +				marvell,pins = "mpp40";
>>> +				marvell,function = "gpio";
>>> +			};
>>> +			pmx_button_function: pmx-button-function {
>>> +				marvell,pins = "mpp41";
>>> +				marvell,function = "gpio";
>>> +			};
>>> +			pmx_power_switch: pmx-power-switch {
>>> +				marvell,pins = "mpp42";
>>> +				marvell,function = "gpio";
>>> +			};
>>> +			pmx_power_auto_switch: pmx-power-auto-switch {
>>> +				marvell,pins = "mpp43";
>>> +				marvell,function = "gpio";
>>> +			};
>>> +		};
>>> +
>>> +		serial at 12000 {
>>> +			status = "okay";
>>> +		};
>>> +
>>> +		sata at 80000 {
>>> +			status = "okay";
>>> +			nr-ports = <2>;
>>> +		};
>>> +
>>> +		spi at 10600 {
>>> +			status = "okay";
>>> +
>>> +			m25p40 at 0 {
>>> +				#address-cells = <1>;
>>> +				#size-cells = <1>;
>>> +				compatible = "st,m25p40", "jedec,spi-nor";
>>> +				reg = <0>;
>>> +				spi-max-frequency = <25000000>;
>>> +				mode = <0>;
>>> +
>>> +				partition at 0 {
>>> +					reg = <0x0 0x60000>;
>>> +					label = "uboot";
>>> +					read-only;
>>> +				};
>>> +
>>> +				partition at 60000 {
>>> +					reg = <0x60000 0x10000>;
>>> +					label = "dtb";
>>> +					read-only;
>>> +				};
>>> +
>>> +				partition at 70000 {
>>> +					reg = <0x70000 0x10000>;
>>> +					label = "uboot_env";
>>> +				};
>>> +			};
>>> +		};
>>> +	};
>>> +
>>> +	gpio_keys {
>>> +		compatible = "gpio-keys";
>>> +		#address-cells = <1>;
>>> +		#size-cells = <0>;
>>> +		pinctrl-0 = <&pmx_button_function &pmx_power_switch
>>> +			     &pmx_power_auto_switch>;
>>> +		pinctrl-names = "default";
>>> +
>>> +		button at 1 {
>>> +			label = "Function Button";
>>> +			linux,code = <KEY_OPTION>;
>>> +			gpios = <&gpio1 41 GPIO_ACTIVE_LOW>;
>>> +		};
>>> +
>>> +		button at 2 {
>>> +			label = "Power-on Switch";
>>> +			linux,code = <KEY_RESERVED>;
>>> +			linux,input-type = <5>;
>>> +			gpios = <&gpio1 42 GPIO_ACTIVE_LOW>;
>>> +		};
>>> +
>>> +		button at 3 {
>>> +			label = "Power-auto Switch";
>>> +			linux,code = <KEY_ESC>;
>>> +			linux,input-type = <5>;
>>> +			gpios = <&gpio1 43 GPIO_ACTIVE_LOW>;
>>> +		};
>>> +	};
>>> +
>>> +	gpio_leds {
>>> +		compatible = "gpio-leds";
>>> +		pinctrl-0 = <&pmx_led_function_red &pmx_led_alarm
>>> +			     &pmx_led_info &pmx_led_power
>>> +			     &pmx_led_function_blue
>>> +			     &pmx_led_hdderr0
>>> +			     &pmx_led_hdderr1>;
>>> +		pinctrl-names = "default";
>>> +
>>> +		led at 1 {
>>> +			label = "lswxl:blue:func";
>>> +			gpios = <&gpio1 36 GPIO_ACTIVE_LOW>;
>>> +		};
>>> +
>>> +		led at 2 {
>>> +			label = "lswxl:red:alarm";
>>> +			gpios = <&gpio1 49 GPIO_ACTIVE_LOW>;
>>> +		};
>>> +
>>> +		led at 3 {
>>> +			label = "lswxl:amber:info";
>>> +			gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
>>> +		};
>>> +
>>> +		led at 4 {
>>> +			label = "lswxl:blue:power";
>>> +			gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
>>> +		};
>>> +
>>> +		led at 5 {
>>> +			label = "lswxl:red:func";
>>> +			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
>>> +			default-state = "keep";
>>> +		};
>>> +
>>> +		led at 6 {
>>> +			label = "lswxl:red:hdderr0";
>>> +			gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
>>> +		};
>>> +
>>> +		led at 7 {
>>> +			label = "lswxl:red:hdderr1";
>>> +			gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
>>> +		};
>>> +	};
>>> +
>>> +	gpio_fan {
>>> +		compatible = "gpio-fan";
>>> +		pinctrl-0 = <&pmx_fan_low &pmx_fan_high &pmx_fan_lock>;
>>> +		pinctrl-names = "default";
>>> +
>>> +		gpios = <&gpio0 47 GPIO_ACTIVE_LOW
>>> +			 &gpio0 48 GPIO_ACTIVE_LOW>;
>>> +
>>> +		gpio-fan,speed-map = <0 3
>>> +				1500 2
>>> +				3250 1
>>> +				5000 0>;
>>> +
>>> +		alarm-gpios = <&gpio1 49 GPIO_ACTIVE_HIGH>;
>>> +	};
>>> +
>>> +	restart_poweroff {
>>> +		compatible = "restart-poweroff";
>>> +	};
>>> +
>>> +	regulators {
>>> +		compatible = "simple-bus";
>>> +		#address-cells = <1>;
>>> +		#size-cells = <0>;
>>> +		pinctrl-0 = <&pmx_power_hdd0 &pmx_power_hdd1 &pmx_usb_vbus>;
>>> +		pinctrl-names = "default";
>>> +
>>> +		usb_power: regulator at 1 {
>>> +			compatible = "regulator-fixed";
>>> +			reg = <1>;
>>> +			regulator-name = "USB Power";
>>> +			regulator-min-microvolt = <5000000>;
>>> +			regulator-max-microvolt = <5000000>;
>>> +			enable-active-high;
>>> +			regulator-always-on;
>>> +			regulator-boot-on;
>>> +			gpio = <&gpio0 37 GPIO_ACTIVE_HIGH>;
>>> +		};
>>> +		hdd_power0: regulator at 2 {
>>> +			compatible = "regulator-fixed";
>>> +			reg = <2>;
>>> +			regulator-name = "HDD0 Power";
>>> +			regulator-min-microvolt = <5000000>;
>>> +			regulator-max-microvolt = <5000000>;
>>> +			enable-active-high;
>>> +			regulator-always-on;
>>> +			regulator-boot-on;
>>> +			gpio = <&gpio0 28 GPIO_ACTIVE_HIGH>;
>>> +		};
>>> +		hdd_power1: regulator at 3 {
>>> +			compatible = "regulator-fixed";
>>> +			reg = <3>;
>>> +			regulator-name = "HDD1 Power";
>>> +			regulator-min-microvolt = <5000000>;
>>> +			regulator-max-microvolt = <5000000>;
>>> +			enable-active-high;
>>> +			regulator-always-on;
>>> +			regulator-boot-on;
>>> +			gpio = <&gpio0 29 GPIO_ACTIVE_HIGH>;
>>> +		};
>>> +	};
>>> +};
>>> +
>>> +&mdio {
>>> +	status = "okay";
>>> +
>>> +	ethphy1: ethernet-phy at 8 {
>>> +		device_type = "ethernet-phy";
>>> +		reg = <8>;
>>> +	};
>>> +};
>>> +
>>> +&eth1 {
>>> +	status = "okay";
>>> +
>>> +	ethernet1-port at 0 {
>>> +		phy-handle = <&ethphy1>;
>>> +	};
>>> +};
>>>
>>
>>
>> -- 
>> Gregory Clement, Free Electrons
>> Kernel, drivers, real-time and embedded Linux
>> development, consulting, training and support.
>> http://free-electrons.com


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
