From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 10 Mar 2015 14:39:18 +0100
Subject: [PATCH] ARM: Kirkwood: add DT description for nas2big
In-Reply-To: <20150310131612.GA6052@lunn.ch>
References: <1425243100-318-1-git-send-email-simon.guinot@sequanux.org>
 <54F57EBB.7040009@free-electrons.com> <20150309094531.GM1509@kw.sim.vm.gnt>
 <20150310131612.GA6052@lunn.ch>
Message-ID: <54FEF406.3020205@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/03/2015 14:16, Andrew Lunn wrote:
> On Mon, Mar 09, 2015 at 10:45:32AM +0100, Simon Guinot wrote:
>> On Tue, Mar 03, 2015 at 10:28:27AM +0100, Gregory CLEMENT wrote:
>>> Hi Simon,
>>>
>>> On 01/03/2015 21:51, Simon Guinot wrote:
>>>> This patch adds the DT description for the LaCie "2Big NAS" (nas2big).
>>>> This NAS is an hardware upgrade of the 2Big Network v2.
>>>>
>>>> Chipset and device list:
>>>>
>>>> - CPU Marvell 88F6282 1600Mhz
>>>> - SDRAM memory, 256MB DDR3 (2x128MB x8) 533Mhz
>>>> - 1 Ethernet Gigabit port (PHY Marvell 88E1518)
>>>> - Flash memory, NAND 256MB TSOP48
>>>> - I2C EEPROM, 512 bytes (AT24 type)
>>>> - PCIe SATA controller JMicron JMB360 (eSATA)
>>>> - I2C fan controller GMT G762 (with a separate alarm GPIO)
>>>> - 1 USB2 host port
>>>> - 1 push button
>>>> - 1 power switch
>>>> - 2 SATA LEDs (bi-color, blue and red)
>>>> - 1 power LED (bi-color, blue and red)
>>>> - CPLD for LEDs and start-up management (Altera Max EMP3064)
>>>
>>>
>>> This dts looks fine for me, however I would like to have an Acked-by
>>> from Andrew or Jason before applying it as kikwood is not my area of
>>> expertise.
>>
>> Hi Jason and Andrew,
>>
>> What do you think about this DTS file ?
> 
> Hi Simon
> 
> Sorry for taking so long. I've been travelling for the last few weeks.
> 
> I just took a look at the patch. Nothing jumps out at me as being
> wrong or needing changes.
> 
> Acked-by: Andrew Lunn <andrew@lunn.ch>
> 

applied on mvebu/dt with Andrew Acked-by

Thanks,

Gregory


> 	  Andrew
> 
>>
>> Thanks,
>>
>> Simon
>>
>>>>
>>>> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
>>>> ---
>>>>  .../devicetree/bindings/arm/marvell,kirkwood.txt   |   1 +
>>>>  arch/arm/boot/dts/Makefile                         |   1 +
>>>>  arch/arm/boot/dts/kirkwood-nas2big.dts             | 144 +++++++++++++++++++++
>>>>  3 files changed, 146 insertions(+)
>>>>  create mode 100644 arch/arm/boot/dts/kirkwood-nas2big.dts
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt b/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt
>>>> index 925ecbf6e7b7..4f40ff3fee4b 100644
>>>> --- a/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt
>>>> +++ b/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt
>>>> @@ -42,6 +42,7 @@ board. Currently known boards are:
>>>>  "lacie,cloudbox"
>>>>  "lacie,inetspace_v2"
>>>>  "lacie,laplug"
>>>> +"lacie,nas2big"
>>>>  "lacie,netspace_lite_v2"
>>>>  "lacie,netspace_max_v2"
>>>>  "lacie,netspace_mini_v2"
>>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>>>> index a1c776b8dcec..920fd9dd7a35 100644
>>>> --- a/arch/arm/boot/dts/Makefile
>>>> +++ b/arch/arm/boot/dts/Makefile
>>>> @@ -165,6 +165,7 @@ dtb-$(CONFIG_MACH_KIRKWOOD) += \
>>>>  	kirkwood-lsxhl.dtb \
>>>>  	kirkwood-mplcec4.dtb \
>>>>  	kirkwood-mv88f6281gtw-ge.dtb \
>>>> +	kirkwood-nas2big.dtb \
>>>>  	kirkwood-net2big.dtb \
>>>>  	kirkwood-net5big.dtb \
>>>>  	kirkwood-netgear_readynas_duo_v2.dtb \
>>>> diff --git a/arch/arm/boot/dts/kirkwood-nas2big.dts b/arch/arm/boot/dts/kirkwood-nas2big.dts
>>>> new file mode 100644
>>>> index 000000000000..d459c94fd1d4
>>>> --- /dev/null
>>>> +++ b/arch/arm/boot/dts/kirkwood-nas2big.dts
>>>> @@ -0,0 +1,144 @@
>>>> +/*
>>>> + * Device Tree file for LaCie 2Big NAS
>>>> + *
>>>> + * Copyright (C) 2015 Seagate
>>>> + *
>>>> + * Author: Simon Guinot <simon.guinot@sequanux.org>
>>>> + *
>>>> + * This file is licensed under the terms of the GNU General Public
>>>> + * License version 2.  This program is licensed "as is" without any
>>>> + * warranty of any kind, whether express or implied.
>>>> +*/
>>>> +
>>>> +/dts-v1/;
>>>> +
>>>> +#include <dt-bindings/leds/leds-netxbig.h>
>>>> +#include "kirkwood-netxbig.dtsi"
>>>> +
>>>> +/ {
>>>> +	model = "LaCie 2Big NAS";
>>>> +	compatible = "lacie,nas2big", "lacie,netxbig", "marvell,kirkwood-88f6282", "marvell,kirkwood";
>>>> +
>>>> +	memory {
>>>> +		device_type = "memory";
>>>> +		reg = <0x00000000 0x10000000>;
>>>> +	};
>>>> +
>>>> +	chosen {
>>>> +		bootargs = "console=ttyS0,115200n8";
>>>> +		stdout-path = &uart0;
>>>> +	};
>>>> +
>>>> +	mbus {
>>>> +		pcie-controller {
>>>> +			status = "okay";
>>>> +
>>>> +			pcie at 1,0 {
>>>> +				status = "okay";
>>>> +			};
>>>> +		};
>>>> +	};
>>>> +
>>>> +	ocp at f1000000 {
>>>> +		rtc at 10300 {
>>>> +			/* The on-chip RTC is not powered (no supercap). */
>>>> +			status = "disabled";
>>>> +		};
>>>> +		spi at 10600 {
>>>> +			/*
>>>> +			 * A NAND flash is used instead of an SPI flash for
>>>> +			 * the other netxbig-compatible boards.
>>>> +			 */
>>>> +			status = "disabled";
>>>> +		};
>>>> +	};
>>>> +
>>>> +	fan {
>>>> +		/*
>>>> +		 * An I2C fan controller (GMT G762) is used but alarm is
>>>> +		 * wired to a separate GPIO.
>>>> +		 */
>>>> +		compatible = "gpio-fan";
>>>> +		alarm-gpios = <&gpio0 25 GPIO_ACTIVE_LOW>;
>>>> +	};
>>>> +
>>>> +	regulators: regulators {
>>>> +		status = "okay";
>>>> +		compatible = "simple-bus";
>>>> +		#address-cells = <1>;
>>>> +		#size-cells = <0>;
>>>> +		pinctrl-names = "default";
>>>> +
>>>> +		regulator at 2 {
>>>> +			compatible = "regulator-fixed";
>>>> +			reg = <2>;
>>>> +			regulator-name = "hdd1power";
>>>> +			regulator-min-microvolt = <5000000>;
>>>> +			regulator-max-microvolt = <5000000>;
>>>> +			enable-active-high;
>>>> +			regulator-always-on;
>>>> +			regulator-boot-on;
>>>> +			gpio = <&gpio0 17 GPIO_ACTIVE_HIGH>;
>>>> +		};
>>>> +		clocks {
>>>> +			g762_clk: g762-oscillator {
>>>> +				compatible = "fixed-clock";
>>>> +				#clock-cells = <0>;
>>>> +				clock-frequency = <32768>;
>>>> +			};
>>>> +		};
>>>> +	};
>>>> +};
>>>> +
>>>> +&mdio {
>>>> +	status = "okay";
>>>> +
>>>> +	ethphy0: ethernet-phy at 0 {
>>>> +		reg = <0>;
>>>> +	};
>>>> +};
>>>> +
>>>> +&i2c0 {
>>>> +	status = "okay";
>>>> +
>>>> +	/*
>>>> +	 * An external I2C RTC (Dallas DS1337S+) is used. This allows
>>>> +	 * to power-up the board on an RTC alarm. The external RTC can
>>>> +	 * be kept powered, even when the SoC is off.
>>>> +	 */
>>>> +	rtc at 68 {
>>>> +		compatible = "dallas,ds1307";
>>>> +		reg = <0x68>;
>>>> +		interrupts = <43>;
>>>> +	};
>>>> +	g762 at 3e {
>>>> +		compatible = "gmt,g762";
>>>> +		reg = <0x3e>;
>>>> +		clocks = <&g762_clk>;
>>>> +	};
>>>> +};
>>>> +
>>>> +&nand {
>>>> +	chip-delay = <50>;
>>>> +	status = "okay";
>>>> +
>>>> +	partition at 0 {
>>>> +		label = "U-Boot";
>>>> +		reg = <0x0 0x100000>;
>>>> +	};
>>>> +
>>>> +	partition at 100000 {
>>>> +		label = "uImage";
>>>> +		reg = <0x100000 0x1000000>;
>>>> +	};
>>>> +
>>>> +	partition at 1100000 {
>>>> +		label = "root";
>>>> +		reg = <0x1100000 0x8000000>;
>>>> +	};
>>>> +
>>>> +	partition at 9100000 {
>>>> +		label = "unused";
>>>> +		reg = <0x9100000 0x6f00000>;
>>>> +	};
>>>> +};
>>>>
>>>
>>>
>>> -- 
>>> Gregory Clement, Free Electrons
>>> Kernel, drivers, real-time and embedded Linux
>>> development, consulting, training and support.
>>> http://free-electrons.com
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
