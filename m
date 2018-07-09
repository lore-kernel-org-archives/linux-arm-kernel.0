From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 9 Jul 2018 12:30:38 +0100
Subject: [linux-sunxi] Re: [PATCH 05/10] arm64: dts: allwinner: a64:
 Olinuxino: enable USB
In-Reply-To: <20180709101509.pg2p5kompy35hc3k@nodbug.lucina.net>
References: <20180706085210.17952-1-andre.przywara@arm.com>
 <20180706085210.17952-6-andre.przywara@arm.com>
 <20180706150401.mhqse677vdqtxdzy@nodbug.lucina.net>
 <548f2eb5-b457-8fcd-c043-b897a447d96c@arm.com>
 <52713A44-E2BB-4388-A98F-D49AA3B6EAC3@aosc.io>
 <4b4d1662-4266-593c-79a9-39eea8fb668c@arm.com>
 <373C4D2E-E2CF-4AE9-9AC4-69AD4AF95AF4@aosc.io>
 <5b9a0818-b28e-76de-17b9-721c0950b64b@arm.com>
 <20180709101509.pg2p5kompy35hc3k@nodbug.lucina.net>
Message-ID: <1d2c3a9f-ec57-ebd2-a8d1-fcd7a84e0e91@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09/07/18 11:15, Martin Lucina wrote:
> Hi,
> 
> On Friday, 06.07.2018 at?17:17, Andre Przywara wrote:
>> Hi,
>>
>> On 06/07/18 16:50, Icenowy Zheng wrote:
>>>
>>>
>>> ? 2018?7?6? GMT+08:00 ??11:46:08, Andre Przywara <andre.przywara@arm.com> ??:
>>>> Hi,
>>>>
>>>> On 06/07/18 16:36, Icenowy Zheng wrote:
>>>>>
>>>>>
>>>>> ? 2018?7?6? GMT+08:00 ??11:35:38, Andre Przywara
>>>> <andre.przywara@arm.com> ??:
>>>>>> Hi,
>>>>>>
>>>>>> On 06/07/18 16:04, Martin Lucina wrote:
>>>>>>> On Friday, 06.07.2018 at?09:52, Andre Przywara wrote:
>>>>>>>> The Olinuxino has two USB socket:
>>>>>>>> USB0 is connected to a micro B socket. As it has the ID pin wired,
>>>>>> we
>>>>>>>> describe it as a proper OTG socket, which switches between host
>>>> and
>>>>>>>> device automatically.
>>>>>>>> USB1 is connected to a normal USB A socket. PG9 enables the power
>>>>>> line,
>>>>>>>> so add the required regulator as well.
>>>>>>>>
>>>>>>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>>>>>>> ---
>>>>>>>
>>>>>>> This is not sufficient. Booting with this change results in the
>>>>>> following
>>>>>>> in dmesg:
>>>>>>>
>>>>>>> musb-sunxi 1c19000.usb: Invalid or missing 'dr_mode' property
>>>>>>> musb-sunxi: probe of 1c19000.usb failed with error -22
>>>>>>> [...]
>>>>>>> usb0-vbus: disabling
>>>>>>>
>>>>>>> ... and neither of the USB ports work.
>>>>>>>
>>>>>>> Adding
>>>>>>>
>>>>>>>     dr_mode = "host";
>>>>>>
>>>>>> Argh, right, I remember you mentioned this before.
>>>>>> Still it should not affect the other USB port, and actually it is a
>>>>>> proper OTG port, so host is not right here. So this points to some
>>>>>> other
>>>>>> oddity or incorrect description. I need to go back to the schematics
>>>>>> and
>>>>>> our previous thread.
>>>>>
>>>>> OTG needs dr_mode = "otg"; and a ID pin.
>>>>
>>>> Yes, and we have the ID pin in the usbphy node.
>>>> Martin, can you please check if dr_mode = "otg"; works for you?
>>>>
>>>> Icenowy: still, how does it affect USB1? I mean, even if MUSB does not
>>>> initialise, it should leave the other host controller working? Is that
>>>> related to them sharing the usbphy? And this one gives up and tears
>>>> *everything* down, including the power for USB1?
>>>
>>> You wrongly bound the regulator to USB0, not USB1.
>>
>> Oh dear ...
>>
>>> USB0 regulator should be AXP's drivevbus if it's OTG in generic
>>> design based on AW reference.
>>
>> Yes, it is.
>> So, like this?
>>
>> --------------
>> 	reg_usb0_vbus: usb0-vbus { ....
>> 		(unchanged)
>> 	};
>> };
>> ....
>> &reg_drivevbus {
>> 	regulator-name = "usb0-vbus";
>> 	status = "okay";
>> };
>>
>> &usb_otg {
>> 	dr_mode = "otg";
>> 	status = "okay";
>> };
>>
>> &usbphy {
>> 	usb0_id_det-gpios = <&pio 7 9 GPIO_ACTIVE_HIGH>; /* PH9 */
>> 	usb0_vbus-supply = <&reg_drivevbus>;
>> 	usb1_vbus-supply = <&reg_usb0_vbus>;
>> };
>> --------------
>>
>> Martin, can you please give this a try? (It's PH9, not PH6 as in the
>> original patch).
> 
> I presume you mean all the above changes. This does not work, I see no USB
> busses apart from the kernel's internal ones:

Bummer!

I just saw that I forgot: 'status = "okay";' in the usbphy node. Can you
add this and recheck?

> Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> 
> and dmesg mentions "usb0-vbus: disabling", but no other complaints I can
> see.
> 
> For completeness, with your original patch, I have the following "lsusb"
> output (but non-working both ports):
> 
> Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> 
> With the addition of "dr_mode = "host"", I have the following (and working
> ports):

Well, yes, but as Icenowy pointed out, dr_mode = "host" and the original
patch are wrong and just happen to work by chance:
Adding dr_mode makes the OTG part work, which now *didn't disable* the
usb0_vbus-supply, which actually drives USB1. The actual USB0 supply was
not touched (because Linux didn't know about it in the first place). So
both ports happened to work.

Can you please try using the .dts I attached?

Cheers,
Andre.

> Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 005 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> 
> Cheers,
> 
> Martin
> 
-------------- next part --------------
/*
 * Copyright (C) 2017 Jagan Teki <jteki@openedev.com>
 *
 * This file is dual-licensed: you can use it either under the terms
 * of the GPL or the X11 license, at your option. Note that this dual
 * licensing only applies to this file, and not this project as a
 * whole.
 *
 *  a) This library is free software; you can redistribute it and/or
 *     modify it under the terms of the GNU General Public License as
 *     published by the Free Software Foundation; either version 2 of the
 *     License, or (at your option) any later version.
 *
 *     This library is distributed in the hope that it will be useful,
 *     but WITHOUT ANY WARRANTY; without even the implied warranty of
 *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *     GNU General Public License for more details.
 *
 * Or, alternatively,
 *
 *  b) Permission is hereby granted, free of charge, to any person
 *     obtaining a copy of this software and associated documentation
 *     files (the "Software"), to deal in the Software without
 *     restriction, including without limitation the rights to use,
 *     copy, modify, merge, publish, distribute, sublicense, and/or
 *     sell copies of the Software, and to permit persons to whom the
 *     Software is furnished to do so, subject to the following
 *     conditions:
 *
 *     The above copyright notice and this permission notice shall be
 *     included in all copies or substantial portions of the Software.
 *
 *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 *     OTHER DEALINGS IN THE SOFTWARE.
 */

/dts-v1/;

#include "sun50i-a64.dtsi"

#include <dt-bindings/gpio/gpio.h>

/ {
	model = "Olimex A64-Olinuxino";
	compatible = "olimex,a64-olinuxino", "allwinner,sun50i-a64";

	aliases {
		serial0 = &uart0;
	};

	chosen {
		stdout-path = "serial0:115200n8";
	};

	wifi_pwrseq: wifi_pwrseq {
		compatible = "mmc-pwrseq-simple";
		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
	};

	reg_usb0_vbus: usb0-vbus {
		compatible = "regulator-fixed";
		regulator-name = "usb0-vbus";
		regulator-min-microvolt = <5000000>;
		regulator-max-microvolt = <5000000>;
		regulator-boot-on;
		enable-active-high;
		gpio = <&pio 6 9 GPIO_ACTIVE_HIGH>; /* PG9 */
		status = "okay";
	};
};

&ehci0 {
	status = "okay";
};

&ehci1 {
	status = "okay";
};

&emac {
	pinctrl-names = "default";
	pinctrl-0 = <&rgmii_pins>;
	phy-mode = "rgmii";
	phy-handle = <&ext_rgmii_phy>;
	phy-supply = <&reg_dcdc1>;
	status = "okay";
};

&mdio {
	ext_rgmii_phy: ethernet-phy at 1 {
		compatible = "ethernet-phy-ieee802.3-c22";
		reg = <1>;
	};
};

&mmc0 {
	pinctrl-names = "default";
	pinctrl-0 = <&mmc0_pins>;
	vmmc-supply = <&reg_dcdc1>;
	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
	disable-wp;
	bus-width = <4>;
	status = "okay";
};

&mmc1 {
	pinctrl-names = "default";
	pinctrl-0 = <&mmc1_pins>;
	vmmc-supply = <&reg_aldo2>;
	vqmmc-supply = <&reg_dldo4>;
	mmc-pwrseq = <&wifi_pwrseq>;
	bus-width = <4>;
	non-removable;
	status = "okay";

	rtl8723bs: wifi at 1 {
		reg = <1>;
		interrupt-parent = <&r_pio>;
		interrupts = <0 3 IRQ_TYPE_LEVEL_LOW>; /* PL3 */
		interrupt-names = "host-wake";
	};
};

&ohci0 {
	status = "okay";
};

&ohci1 {
	status = "okay";
};

&r_rsb {
	status = "okay";

	axp803: pmic at 3a3 {
		compatible = "x-powers,axp803";
		reg = <0x3a3>;
		interrupt-parent = <&r_intc>;
		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
	};
};

#include "axp803.dtsi"

&reg_aldo1 {
	regulator-always-on;
	regulator-min-microvolt = <2800000>;
	regulator-max-microvolt = <2800000>;
	regulator-name = "vcc-pe";
};

&reg_aldo2 {
	regulator-always-on;
	regulator-min-microvolt = <3300000>;
	regulator-max-microvolt = <3300000>;
	regulator-name = "vcc-pl";
};

&reg_aldo3 {
	regulator-always-on;
	regulator-min-microvolt = <3000000>;
	regulator-max-microvolt = <3000000>;
	regulator-name = "vcc-pll-avcc";
};

&reg_dcdc1 {
	regulator-always-on;
	regulator-min-microvolt = <3300000>;
	regulator-max-microvolt = <3300000>;
	regulator-name = "vcc-3v3";
};

&reg_dcdc2 {
	regulator-always-on;
	regulator-min-microvolt = <1040000>;
	regulator-max-microvolt = <1300000>;
	regulator-name = "vdd-cpux";
};

/*
 * DCDC3 is polyphased with DCDC2 to supply the DDR3L DRAM chips.
 * 1.36V is the closest to the nominal 1.35V that the PMIC can drive.
 */
&reg_dcdc5 {
	regulator-always-on;
	regulator-min-microvolt = <1360000>;
	regulator-max-microvolt = <1360000>;
	regulator-name = "vcc-ddr3";
};

&reg_dcdc6 {
	regulator-always-on;
	regulator-min-microvolt = <1100000>;
	regulator-max-microvolt = <1100000>;
	regulator-name = "vdd-sys";
};

&reg_dldo1 {
	regulator-min-microvolt = <3300000>;
	regulator-max-microvolt = <3300000>;
	regulator-name = "vcc-hdmi";
};

&reg_dldo2 {
	regulator-min-microvolt = <3300000>;
	regulator-max-microvolt = <3300000>;
	regulator-name = "vcc-mipi";
};

&reg_dldo3 {
	regulator-min-microvolt = <2800000>;
	regulator-max-microvolt = <2800000>;
	regulator-name = "vcc-avdd-csi";
};

&reg_dldo4 {
	regulator-min-microvolt = <3300000>;
	regulator-max-microvolt = <3300000>;
	regulator-name = "vcc-wifi-io";
};

&reg_drivevbus {
	regulator-name = "usb0-vbus";
	status = "okay";
};

&reg_eldo1 {
	regulator-min-microvolt = <1800000>;
	regulator-max-microvolt = <1800000>;
	regulator-name = "cpvdd";
};

&reg_eldo2 {
	regulator-min-microvolt = <1800000>;
	regulator-max-microvolt = <1800000>;
	regulator-name = "vcc-dvdd-csi";
};

&reg_fldo1 {
	regulator-min-microvolt = <1200000>;
	regulator-max-microvolt = <1200000>;
	regulator-name = "vcc-1v2-hsic";
};

/*
 * The A64 chip cannot work without this regulator off, although
 * it seems to be only driving the AR100 core.
 * Maybe we don't still know well about CPUs domain.
 */
&reg_fldo2 {
	regulator-always-on;
	regulator-min-microvolt = <1100000>;
	regulator-max-microvolt = <1100000>;
	regulator-name = "vdd-cpus";
};

&reg_rtc_ldo {
	regulator-name = "vcc-rtc";
};

&simplefb_hdmi {
	vcc-hdmi-supply = <&reg_dldo1>;
};

&uart0 {
	pinctrl-names = "default";
	pinctrl-0 = <&uart0_pins_a>;
	status = "okay";
};

&usb_otg {
	dr_mode = "otg";
	status = "okay";
};

&usbphy {
	status = "okay";
	usb0_id_det-gpios = <&pio 7 9 GPIO_ACTIVE_HIGH>; /* PH9 */
	usb0_vbus-supply = <&reg_drivevbus>;
	usb1_vbus-supply = <&reg_usb0_vbus>;
};
