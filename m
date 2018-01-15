From: stefan@olimex.com (Stefan Mavrodiev)
Date: Mon, 15 Jan 2018 12:07:34 +0200
Subject: [PATCH 1/1] ARM: dts: sunxi: Add Olimex A20-SOM204-EVB board
In-Reply-To: <20180115095031.pzsgrp3tdmemotrs@flea.lan>
References: <1515747666-6597-1-git-send-email-stefan@olimex.com>
 <20180115095031.pzsgrp3tdmemotrs@flea.lan>
Message-ID: <1b9667a4-75de-4ece-069d-7ec33b7e2f8d@olimex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/15/2018 11:50 AM, Maxime Ripard wrote:
> Hi Stefan,
>
> On Fri, Jan 12, 2018 at 11:01:05AM +0200, Stefan Mavrodiev wrote:
>> This is new System-On-Module platform with universal dimm socket for
>> easy insertation. The EVB board is designed to be universal with
>> future modules. Product page is located here [1].
>>
>> There are two dts files - one for base model and another for eMMC variant.
>>
>> Base features of A20-SOM204 board includes:
>> 	* 1GB DDR3 RAM
>> 	* AXP209 PMU
>> 	* KSZ9031 Gigabit PHY
>> 	* AT24C16 EEPROM
>> 	* Status LED
>> 	* LCD connector
>> 	* GPIO connector
>>
>> There will be variants with the following options:
>> 	* Second LAN8710A Megabit PHY
>> 	* 16MB SPI Flash memory
>> 	* eMMC card
>> 	* ATECC508 crypto device
>>
>> The EVB board has:
>> 	* Debug UART
>> 	* MicroSD card connector
>> 	* USB-OTG connector
>> 	* Two USB host
>> 	* RTL8723BS WiFi/BT combo
>> 	* IrDA transceiver/receiver
>> 	* HDMI connector
>> 	* VGA connector
>> 	* Megabit ethernet transceiver
>> 	* Gigabit ethernet transceiver
>> 	* SATA connector
>> 	* CAN driver
>> 	* CSI camera
>> 	* MIC and HP connectors
>> 	* PCIe x4 connector
>> 	* USB3 connector
>> 	* Two UEXT connectors
>> 	* Two user LEDs
>>
>> Some of the features are multiplexed and cannot be used the same time:
>> CAN and Megabit PHY. Others are not usable with A20 SoC: PCIe and USB3.
>>
>> [1] https://www.olimex.com/Products/SOM204/
>>
>> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
>> ---
>>   arch/arm/boot/dts/Makefile                         |   2 +
>>   .../boot/dts/sun7i-a20-olimex-som204-evb-emmc.dts  |  70 ++++
>>   arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts  | 392 +++++++++++++++++++++
>>   3 files changed, 464 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/sun7i-a20-olimex-som204-evb-emmc.dts
>>   create mode 100644 arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index d0381e9..c890042 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -918,6 +918,8 @@ dtb-$(CONFIG_MACH_SUN7I) += \
>>   	sun7i-a20-m3.dtb \
>>   	sun7i-a20-mk808c.dtb \
>>   	sun7i-a20-olimex-som-evb.dtb \
>> +	sun7i-a20-olimex-som204-evb.dtb \
>> +	sun7i-a20-olimex-som204-evb-emmc.dtb \
> Ideally, you should split that patch into two, one to introduce the
> base board and the second one for the emmc.
>
>>   	sun7i-a20-olinuxino-lime.dtb \
>>   	sun7i-a20-olinuxino-lime2.dtb \
>>   	sun7i-a20-olinuxino-lime2-emmc.dtb \
>> diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb-emmc.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb-emmc.dts
>> new file mode 100644
>> index 0000000..97c4824
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb-emmc.dts
>> @@ -0,0 +1,70 @@
>> +/*
>> + * Copyright 2018 - Stefan Mavrodiev <stefan@olimex.com>
>> + *
>> + * This file is dual-licensed: you can use it either under the terms
>> + * of the GPL or the X11 license, at your option. Note that this dual
>> + * licensing only applies to this file, and not this project as a
>> + * whole.
>> + *
>> + *  a) This file is free software; you can redistribute it and/or
>> + *     modify it under the terms of the GNU General Public License as
>> + *     published by the Free Software Foundation; either version 2 of the
>> + *     License, or (at your option) any later version.
>> + *
>> + *     This file is distributed in the hope that it will be useful,
>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *     GNU General Public License for more details.
>> + *
>> + * Or, alternatively,
>> + *
>> + *  b) Permission is hereby granted, free of charge, to any person
>> + *     obtaining a copy of this software and associated documentation
>> + *     files (the "Software"), to deal in the Software without
>> + *     restriction, including without limitation the rights to use,
>> + *     copy, modify, merge, publish, distribute, sublicense, and/or
>> + *     sell copies of the Software, and to permit persons to whom the
>> + *     Software is furnished to do so, subject to the following
>> + *     conditions:
>> + *
>> + *     The above copyright notice and this permission notice shall be
>> + *     included in all copies or substantial portions of the Software.
>> + *
>> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + *     OTHER DEALINGS IN THE SOFTWARE.
>> + */
> Could you use the SPDX header, as the first line,
>
> // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>
> instead?
>
> And then, you can drop the license text (but you should keep the
> Copyright line).
>
>> +/dts-v1/;
>> +#include "sun7i-a20-olimex-som204-evb.dts"
>> +
>> +/ {
>> +	model = "Olimex A20-SOM204-EVB-eMMC";
>> +	compatible = "olimex,a20-olimex-som204-evb-emmc", "allwinner,sun7i-a20";
>> +
>> +	mmc2_pwrseq: mmc2_pwrseq {
>> +		compatible = "mmc-pwrseq-emmc";
>> +		reset-gpios = <&pio 2 16 GPIO_ACTIVE_LOW>;
>> +	};
>> +};
>> +
>> +&mmc2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&mmc2_pins_a>;
>> +	vmmc-supply = <&reg_vcc3v3>;
>> +	mmc-pwrseq = <&mmc2_pwrseq>;
>> +	bus-width = <4>;
>> +	non-removable;
>> +	status = "okay";
>> +
>> +	emmc: emmc at 0 {
>> +		reg = <0>;
>> +		compatible = "mmc-card";
>> +		broken-hpi;
>> +	};
>> +};
>> diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts
>> new file mode 100644
>> index 0000000..ec4492b
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts
>> @@ -0,0 +1,392 @@
>> +/*
>> + * Copyright 2018 - Stefan Mavrodiev <stefan@olimex.com>
>> + *
>> + * This file is dual-licensed: you can use it either under the terms
>> + * of the GPL or the X11 license, at your option. Note that this dual
>> + * licensing only applies to this file, and not this project as a
>> + * whole.
>> + *
>> + *  a) This file is free software; you can redistribute it and/or
>> + *     modify it under the terms of the GNU General Public License as
>> + *     published by the Free Software Foundation; either version 2 of the
>> + *     License, or (at your option) any later version.
>> + *
>> + *     This file is distributed in the hope that it will be useful,
>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *     GNU General Public License for more details.
>> + *
>> + * Or, alternatively,
>> + *
>> + *  b) Permission is hereby granted, free of charge, to any person
>> + *     obtaining a copy of this software and associated documentation
>> + *     files (the "Software"), to deal in the Software without
>> + *     restriction, including without limitation the rights to use,
>> + *     copy, modify, merge, publish, distribute, sublicense, and/or
>> + *     sell copies of the Software, and to permit persons to whom the
>> + *     Software is furnished to do so, subject to the following
>> + *     conditions:
>> + *
>> + *     The above copyright notice and this permission notice shall be
>> + *     included in all copies or substantial portions of the Software.
>> + *
>> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + *     OTHER DEALINGS IN THE SOFTWARE.
>> + */
> Same thing for this file.
>
>> +/dts-v1/;
>> +#include "sun7i-a20.dtsi"
>> +#include "sunxi-common-regulators.dtsi"
>> +
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/pwm/pwm.h>
>> +
>> +/ {
>> +	model = "Olimex A20-SOM204-EVB";
>> +	compatible = "olimex,a20-olimex-som204-evb", "allwinner,sun7i-a20";
>> +
>> +	aliases {
>> +		serial0 = &uart0;
>> +		serial1 = &uart4;
>> +		serial2 = &uart7;
>> +		spi0 = &spi1;
>> +		spi1 = &spi2;
>> +		ethernet1 = &rtl8723bs;
> ethernet1? if there's a single network interface, it should be
> ethernet0.
I think this will conflict the gmac alias defined in sun7i-a20.dtsi:

aliases {
 ??? ethernet0 = &gmac;
};

>
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +
>> +	hdmi-connector {
>> +		compatible = "hdmi-connector";
>> +		type = "a";
>> +
>> +		port {
>> +			hdmi_con_in: endpoint {
>> +				remote-endpoint = <&hdmi_out_con>;
>> +			};
>> +		};
>> +	};
>> +
>> +	leds {
>> +		compatible = "gpio-leds";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&led_pins_olimex_som204_evb>;
> You don't need that pinctrl node.
>
>> +		stat {
>> +			label = "a20-som204:green:stat";
>> +			gpios = <&pio 8 0 GPIO_ACTIVE_HIGH>;
>> +			default-state = "on";
>> +		};
>> +
>> +		led1 {
>> +			label = "a20-som204-evb:green:led1";
>> +			gpios = <&pio 8 10 GPIO_ACTIVE_HIGH>;
>> +			default-state = "on";
>> +		};
>> +
>> +		led2 {
>> +			label = "a20-som204-evb:yellow:led2";
>> +			gpios = <&pio 8 11 GPIO_ACTIVE_HIGH>;
>> +			default-state = "on";
>> +		};
> You don't have the same prefix between stat and led1/led2. I'm fine
> with both, but you should be consistent :)
STAT led is on the SOM204 module, while led1/2 on the EVB. Thats why 
they have
different prefix.
>
>> +	};
>> +
>> +	mmc2_pwrseq: mmc2_pwrseq {
>> +		compatible = "mmc-pwrseq-emmc";
>> +		reset-gpios = <&pio 2 16 GPIO_ACTIVE_LOW>;
>> +	};
> This is already declared in the emmc variant, isn't it?
>
>> +	rtl_pwrseq: rtl_pwrseq {
>> +		compatible = "mmc-pwrseq-simple";
>> +		reset-gpios = <&pio 6 9 GPIO_ACTIVE_LOW>,
>> +			      <&pio 1 11 GPIO_ACTIVE_LOW>;
>> +	};
> It looks suspicious that you have two reset lines.
RTL8723BS is comblo WiFI/BT module. There is separate reset control for 
each of the
systems.
>
>> +};
>> +
>> +&ahci {
>> +	target-supply = <&reg_ahci_5v>;
> You should use the regulators you defined in your PMIC there.
>
>> +	status = "okay";
>> +};
>> +
>> +&can0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&can0_pins_a>;
>> +	status = "okay";
>> +};
>>
>> +&codec {
>> +	status = "okay";
>> +};
>> +
>> +&cpu0 {
>> +	cpu-supply = <&reg_dcdc2>;
>> +};
>> +
>> +&de {
>> +	status = "okay";
>> +};
>> +
>> +&ehci0 {
>> +	status = "okay";
>> +};
>> +
>> +&ehci1 {
>> +	status = "okay";
>> +};
>> +
>> +&gmac {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&gmac_pins_rgmii_a>;
>> +	phy = <&phy3>;
>> +	phy-mode = "rgmii";
>> +	phy-supply = <&reg_vcc3v3>;
>> +
>> +	snps,reset-gpio = <&pio 0 17 GPIO_ACTIVE_HIGH>;
>> +	snps,reset-active-low;
>> +	snps,reset-delays-us = <0 10000 1000000>;
>> +	status = "okay";
>> +
>> +	phy3: ethernet-phy at 3 {
>> +		reg = <3>;
>> +	};
>> +};
>> +
>> +&hdmi {
>> +	status = "okay";
>> +};
>> +
>> +&hdmi_out {
>> +	hdmi_out_con: endpoint {
>> +		remote-endpoint = <&hdmi_con_in>;
>> +	};
>> +};
>> +
>> +&i2c0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&i2c0_pins_a>;
>> +	status = "okay";
>> +
>> +	axp209: pmic at 34 {
>> +		reg = <0x34>;
>> +		interrupt-parent = <&nmi_intc>;
>> +		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>> +	};
>> +};
>> +
>> +&i2c1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&i2c1_pins_a>;
>> +	status = "okay";
>> +
>> +	eeprom: eeprom at 50 {
>> +		compatible = "atmel,24c16";
>> +		reg = <0x50>;
>> +		pagesize = <16>;
>> +	};
>> +};
>> +
>> +&i2c2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&i2c2_pins_a>;
>> +	status = "okay";
>> +};
> What is connected to that bus?
The bus is exposed to one of the connectors (UEXT2). Same for SPI1/2 and 
UART4/7.
>
>> +&ir0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&ir0_rx_pins_a>,
>> +		    <&ir0_tx_pins_a>;
>> +	status = "okay";
>> +};
>> +
>> +&mmc0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&mmc0_pins_a>;
>> +	vmmc-supply = <&reg_vcc3v3>;
>> +	bus-width = <4>;
>> +	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>;
>> +	cd-inverted;
>> +	status = "okay";
>> +};
>> +
>> +&mmc3 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&mmc3_pins_a>;
>> +	vmmc-supply = <&reg_vcc3v3>;
>> +	mmc-pwrseq = <&rtl_pwrseq>;
>> +	bus-width = <4>;
>> +	non-removable;
>> +	status = "okay";
>> +
>> +	rtl8723bs: sdio_wifi at 1 {
>> +		reg = <1>;
>> +	};
>> +};
>> +
>> +&ohci0 {
>> +	status = "okay";
>> +};
>> +
>> +&ohci1 {
>> +	status = "okay";
>> +};
>> +
>> +&otg_sram {
>> +	status = "okay";
>> +};
>> +
>> +&pio {
>> +
>> +	bt_uart_pins: bt_uart_pins at 0 {
>> +		pins = "PG6", "PG7", "PG8";
>> +		function = "uart3";
>> +	};
>> +
>> +	led_pins_olimex_som204_evb: led_pins at 0 {
>> +		pins = "PI0", "PI10", "PI11";
>> +		function = "gpio_out";
>> +		drive-strength = <20>;
>> +	};
>> +
>> +	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
>> +		pins = "PH4";
>> +		function = "gpio_in";
>> +		bias-pull-up;
>> +	};
>> +
>> +	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
>> +		pins = "PH5";
>> +		function = "gpio_in";
>> +		bias-pull-down;
>> +	};
>> +};
> You don't need any of these pins
>
>> +#include "axp209.dtsi"
>> +
>> +&ac_power_supply {
>> +	status = "okay";
>> +};
>> +&battery_power_supply {
>> +	status = "okay";
>> +};
>> +
>> +&reg_ahci_5v {
>> +	gpio = <&pio 2 3 GPIO_ACTIVE_HIGH>;
>> +	status = "okay";
>> +};
>> +
>> +&reg_dcdc2 {
>> +	regulator-always-on;
>> +	regulator-min-microvolt = <1000000>;
>> +	regulator-max-microvolt = <1400000>;
>> +	regulator-name = "vdd-cpu";
>> +};
>> +
>> +&reg_dcdc3 {
>> +	regulator-always-on;
>> +	regulator-min-microvolt = <1000000>;
>> +	regulator-max-microvolt = <1400000>;
>> +	regulator-name = "vdd-int-dll";
>> +};
>> +
>> +&reg_ldo1 {
>> +	regulator-always-on;
>> +	regulator-min-microvolt = <1300000>;
>> +	regulator-max-microvolt = <1300000>;
>> +	regulator-name = "vdd-rtc";
>> +};
>> +
>> +&reg_ldo2 {
>> +	regulator-always-on;
>> +	regulator-min-microvolt = <3000000>;
>> +	regulator-max-microvolt = <3000000>;
>> +	regulator-name = "avcc";
>> +};
>> +
>> +&reg_ldo4 {
>> +	regulator-min-microvolt = <3300000>;
>> +	regulator-max-microvolt = <3300000>;
>> +	regulator-name = "vcc-pg";
>> +};
>> +
>> +&reg_usb0_vbus {
>> +	gpio = <&pio 2 17 GPIO_ACTIVE_HIGH>;
>> +	status = "okay";
>> +};
>> +
>> +&reg_usb1_vbus {
>> +	status = "okay";
>> +};
>> +
>> +&reg_usb2_vbus {
>> +	status = "okay";
>> +};
>> +
>> +&spi1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&spi1_pins_a>,
>> +		    <&spi1_cs0_pins_a>;
>> +	status = "okay";
>> +};
>> +
>> +&spi2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&spi2_pins_a>,
>> +		    <&spi2_cs0_pins_a>;
>> +	status = "okay";
>> +};
> What is connected on those buses
As mentioned SPI1/2 are exposed to UEXT1/2.
>
>> +&uart0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&uart0_pins_a>;
>> +	status = "okay";
>> +};
>> +
>> +&uart3 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&bt_uart_pins>;
>> +	status = "okay";
>> +};
>> +
>> +&uart4 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&uart4_pins_a>;
>> +	status = "okay";
>> +};
>> +
>> +&uart7 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&uart7_pins_a>;
>> +	status = "okay";
>> +};
> Same thing for these three UARTs
Uart3 is used for H5 BT protocol. UART4/7 are exposed to UEXT.
>
>> +&usb_otg {
>> +	dr_mode = "otg";
>> +	status = "okay";
>> +};
>> +
>> +&usb_power_supply {
>> +	status = "okay";
>> +};
>> +
>> +&usbphy {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&usb0_id_detect_pin>,
>> +		    <&usb0_vbus_detect_pin>;
>> +	usb0_id_det-gpio = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
>> +	usb0_vbus_det-gpio = <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH5 */
>> +	usb0_vbus_power-supply = <&usb_power_supply>;
>> +	usb0_vbus-supply = <&reg_usb0_vbus>;
>> +	usb1_vbus-supply = <&reg_usb1_vbus>;
>> +	usb2_vbus-supply = <&reg_usb2_vbus>;
> You should also use one of the PMIC regulators here.
>
> Thanks!
> Maxime
>
Regards,
Stefan Mavrodiev
