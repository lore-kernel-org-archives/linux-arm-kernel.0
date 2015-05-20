From: andrew@ncrmnt.org (Andrew)
Date: Wed, 20 May 2015 13:20:47 +0300
Subject: [PATCH v4 1/1] ARM: mvebu: dts: Add dts file for DLink DNS-327L
In-Reply-To: <555C4E48.6020707@gmail.com>
References: <1432069858-10958-1-git-send-email-andrew@ncrmnt.org>
 <1432069858-10958-2-git-send-email-andrew@ncrmnt.org>
 <555C4E48.6020707@gmail.com>
Message-ID: <699cee8678f6e671bd1457aa06180ccf@mail.ncrmnt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian Hesselbarth ????? 20.05.2015 12:05:
> On 19.05.2015 23:10, Andrew Andrianov wrote:
>> DNS-327L is a 2-bay NAS with the following specs:
> [...]
>> Signed-off-by: Andrew Andrianov <andrew@ncrmnt.org>
>> ---
>>   arch/arm/boot/dts/Makefile                     |   1 +
>>   arch/arm/boot/dts/armada-370-dlink-dns327l.dts | 356 
>> +++++++++++++++++++++++++
>>   2 files changed, 357 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/armada-370-dlink-dns327l.dts
> [...]
>> diff --git a/arch/arm/boot/dts/armada-370-dlink-dns327l.dts 
>> b/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
>> new file mode 100644
>> index 0000000..0f4555c4
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
>> @@ -0,0 +1,356 @@
> [...]
>> +	regulators {
>> +		compatible = "simple-bus";
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		pinctrl-0 = <&xhci_pwr_pin
>> +			&sata_l_pwr_pin
>> +			&sata_r_pwr_pin>;
>> +
>> +		pinctrl-names = "default";
> 
> Andrew,
> 
> I doubt pinctrl will not work as you expected. For regulators, unlike
> gpio-keys/leds above, this node just describes the "bus" of regulators.

Are you sure about this moment? FYI: I've taken 
armada-370-synology-ds213j.dts
as the reference which happens to list regulator pinctrl (As of 4.1-rc1)
just the same way:

	compatible = "simple-bus";
		#address-cells = <1>;
		#size-cells = <0>;
		pinctrl-0 = <&sata1_pwr_pin &sata2_pwr_pin>;
		pinctrl-names = "default";
                 ...

If that's erroneous we should fix armada-370-synology-ds213j.dts as 
well.

> 
>> +
>> +		usb_power: regulator at 1 {
>> +			compatible = "regulator-fixed";
>> +			reg = <1>;
>> +			regulator-name = "USB3.0 Port Power";
>> +			regulator-min-microvolt = <5000000>;
>> +			regulator-max-microvolt = <5000000>;
>> +			enable-active-high;
>> +			regulator-boot-on;
>> +			regulator-always-on;
>> +			gpio = <&gpio0 13 GPIO_ACTIVE_HIGH>;
> 
> Instead you'll have to put the corresponding pinctrl-0/names properties
> in each of the regulator nodes, i.e.
> 
> 		pinctrl-0 = <&xhci_pwr_pin>
> 		pinctrl-names = "default";
> 
> here and similar for the other regulator nodes.
> 
>> +		};
>> +
>> +		sata_r_power: regulator at 2 {
>> +			compatible = "regulator-fixed";
>> +			reg = <2>;
>> +			regulator-name = "SATA-R Power";
>> +			regulator-min-microvolt = <5000000>;
>> +			regulator-max-microvolt = <5000000>;
>> +			startup-delay-us = <2000000>;
>> +			enable-active-high;
>> +			regulator-always-on;
>> +			regulator-boot-on;
>> +			gpio = <&gpio1 22 GPIO_ACTIVE_HIGH>;
>> +		};
>> +
>> +		sata_l_power: regulator at 3 {
>> +			compatible = "regulator-fixed";
>> +			reg = <3>;
>> +			regulator-name = "SATA-L Power";
>> +			regulator-min-microvolt = <5000000>;
>> +			regulator-max-microvolt = <5000000>;
>> +			startup-delay-us = <4000000>;
>> +			enable-active-high;
>> +			regulator-always-on;
>> +			regulator-boot-on;
>> +			gpio = <&gpio1 24 GPIO_ACTIVE_HIGH>;
>> +		};
>> +	};
>> +};
>> +
>> +&pinctrl {
>> +	sata_l_white_pin: sata-l-white-pin {
>> +		marvell,pins = "mpp57";
>> +		marvell,function = "sata0";
>> +	};
>> +
>> +	sata_r_white_pin: sata-r-white-pin {
>> +		marvell,pins = "mpp55";
>> +		marvell,function = "sata1";
>> +	};
>> +
>> +	sata_r_amber_pin: sata-r-amber-pin {
>> +		marvell,pins = "mpp52";
>> +		marvell,function = "gpio";
>> +	};
>> +
> 
> Remove extra empty line.
> 
>> +
>> +	sata_l_amber_pin: sata-l-amber-pin {
>> +		marvell,pins = "mpp53";
>> +		marvell,function = "gpio";
>> +	};
>> +
>> +	backup_led_pin: backup-led-pin {
>> +		marvell,pins = "mpp61";
>> +		marvell,function = "gpo";
>> +	};
>> +
>> +	xhci_pwr_pin: xhci-pwr-pin {
>> +		marvell,pins = "mpp13";
>> +		marvell,function = "gpio";
>> +	};
>> +
>> +	sata_r_pwr_pin: sata-r-pwr-pin {
>> +		marvell,pins = "mpp54";
>> +		marvell,function = "gpio";
>> +	};
>> +
>> +	sata_l_pwr_pin: sata-l-pwr-pin {
>> +		marvell,pins = "mpp56";
>> +		marvell,function = "gpio";
>> +	};
>> +
>> +	uart1_pins: uart1-pins {
>> +		marvell,pins = "mpp60", "mpp61";
>> +		marvell,function = "uart1";
>> +	};
>> +
>> +	power_button_pin: power-button-pin {
>> +		marvell,pins = "mpp65";
>> +		marvell,function = "gpio";
>> +	};
>> +
>> +	backup_button_pin: backup-button-pin {
>> +		marvell,pins = "mpp63";
>> +		marvell,function = "gpio";
>> +	};
>> +
>> +	reset_button_pin: reset-button-pin {
>> +		marvell,pins = "mpp64";
>> +		marvell,function = "gpio";
>> +	};
>> +};
>> +
>> +/* Serial console */
>> +&uart0 {
>> +	status = "okay";
>> +};
>> +
>> +/* Connected to Weltrend MCU */
>> +&uart1 {
>> +	pinctrl-0 = <&uart1_pins>;
> 
> missing pinctrl-names = "default";
> 
>> +	status = "okay";
>> +};
>> +
>> +&mdio {
>> +	phy0: ethernet-phy at 0 { /* Marvell 88E1318 */
>> +		reg = <0>;
>> +		marvell,reg-init = <0x0 0x16 0x0 0x2>,
>> +		                   <0x0 0x19 0x0 0x77>,
>> +		                   <0x0 0x18 0x0 0x5747>;
> 
> nit: if you are at it, you could prepend the mdio reg data with 0, i.e.
> <0x0 0x16 0x0 0x0002>.
> 
> If you address the comments and stick with this version, i.e. do not 
> add
> any new stuff now - you can add my
> 
> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> 
> Thanks!
> 
>> +	};
>> +};
>> +
>> +&eth1 {
>> +	phy = <&phy0>;
>> +	phy-mode = "rgmii-id";
>> +	status = "okay";
>> +};
>> +
>> +&i2c0 {
>> +	compatible = "marvell,mv64xxx-i2c";
>> +	clock-frequency = <100000>;
>> +	status = "okay";
>> +};
>> 

-- 
Regards,
Andrew
