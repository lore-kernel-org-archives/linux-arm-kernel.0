From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 16 Nov 2012 10:24:00 +0100
Subject: [PATCH 5/6] ARM: sunxi: Add device tree for the A13 and the
 Olinuxino board
In-Reply-To: <50A5F1E4.10505@denx.de>
References: <1353019586-21043-1-git-send-email-maxime.ripard@free-electrons.com>
 <1353019586-21043-6-git-send-email-maxime.ripard@free-electrons.com>
 <50A5F1E4.10505@denx.de>
Message-ID: <50A60630.4070803@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 16/11/2012 08:57, Stefan Roese a ?crit :
> On 11/15/2012 11:46 PM, Maxime Ripard wrote:
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> ---
>>  arch/arm/boot/dts/Makefile            |    1 +
>>  arch/arm/boot/dts/sun5i-olinuxino.dts |   30 +++++++++++++++++
>>  arch/arm/boot/dts/sun5i.dtsi          |   58 +++++++++++++++++++++++++++++++++
>>  3 files changed, 89 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/sun5i-olinuxino.dts
>>  create mode 100644 arch/arm/boot/dts/sun5i.dtsi
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index f37cf9f..9b2d3f0 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -84,6 +84,7 @@ dtb-$(CONFIG_ARCH_SPEAR3XX)+= spear300-evb.dtb \
>>  	spear310-evb.dtb \
>>  	spear320-evb.dtb
>>  dtb-$(CONFIG_ARCH_SPEAR6XX)+= spear600-evb.dtb
>> +dtb-$(CONFIG_ARCH_SUNXI) += sun5i-olinuxino.dtb
>>  dtb-$(CONFIG_ARCH_TEGRA) += tegra20-harmony.dtb \
>>  	tegra20-medcom-wide.dtb \
>>  	tegra20-paz00.dtb \
>> diff --git a/arch/arm/boot/dts/sun5i-olinuxino.dts b/arch/arm/boot/dts/sun5i-olinuxino.dts
>> new file mode 100644
>> index 0000000..add1e60
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/sun5i-olinuxino.dts
>> @@ -0,0 +1,30 @@
>> +/*
>> + * Copyright 2012 Maxime Ripard
>> + *
>> + * Maxime Ripard <maxime.ripard@free-electrons.com>
>> + *
>> + * The code contained herein is licensed under the GNU General Public
>> + * License. You may obtain a copy of the GNU General Public License
>> + * Version 2 or later at the following locations:
>> + *
>> + * http://www.opensource.org/licenses/gpl-license.html
>> + * http://www.gnu.org/copyleft/gpl.html
>> + */
>> +
>> +/dts-v1/;
>> +/include/ "sun5i.dtsi"
>> +
>> +/ {
>> +	model = "Olimex A13-Olinuxino";
>> +	compatible = "olimex,a13-olinuxino", "allwinner,sun5i";
>> +
>> +	memory {
>> +		reg = <0x40000000 0x40000000>;
>> +	};
> 
> Sure that the board support 1GiB of RAM? AFAIK A13 only supports 512MiB.
> Please re-check.

Ah, you're right. Good catch.

>> +	soc {
>> +		duart: uart at 01c28400 {
>> +			status = "okay";
>> +		};
>> +	};
>> +};
>> diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
>> new file mode 100644
>> index 0000000..5797323
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/sun5i.dtsi
>> @@ -0,0 +1,58 @@
>> +/*
>> + * Copyright 2012 Maxime Ripard
>> + *
>> + * Maxime Ripard <maxime.ripard@free-electrons.com>
>> + *
>> + * The code contained herein is licensed under the GNU General Public
>> + * License. You may obtain a copy of the GNU General Public License
>> + * Version 2 or later at the following locations:
>> + *
>> + * http://www.opensource.org/licenses/gpl-license.html
>> + * http://www.gnu.org/copyleft/gpl.html
>> + */
>> +
>> +/include/ "skeleton.dtsi"
>> +
>> +/ {
>> +	interrupt-parent = <&intc>;
>> +
>> +	cpus {
>> +		cpu at 0 {
>> +			compatible = "arm,cortex-a8";
>> +		};
>> +	};
>> +
>> +	chosen {
>> +		bootargs = "earlyprintk console=ttyS0,115200";
>> +	};
> 
> No memory node here? My experience is, that the soc.dtsi file should
> contain a memory node with the max possible memory size of the SoC.
> Which will be overwritten by the board dts file containing the max
> memory size of the board.

I've worked on boards that were not doing that, so I have a different
experience here, but that looks reasonable.

> 
>> +	soc {
>> +		compatible = "simple-bus";
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		reg = <0x01c20000 0x300000>;
>> +		ranges;
>> +
>> +		timer at 01c20c00 {
>> +			compatible = "allwinner,sunxi-timer";
>> +			reg = <0x01c20c00 0x400>;
>> +			interrupts = <22>;
>> +		};
>> +
>> +		intc: interrupt-controller at 01c20400 {
>> +			compatible = "allwinner,sunxi-ic";
>> +			reg = <0x01c20400 0x400>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <1>;
>> +		};
>> +
>> +		uart1: uart at 01c28400 {
>> +			compatible = "ns8250";
>> +			reg = <0x01c28400 0x400>;
>> +			interrupts = <2>;
>> +			reg-shift = <2>;
>> +			clock-frequency = <24000000>;
>> +			status = "disabled";
>> +		};
>> +	};
>> +};
> 
> Looks good so far. I suggest that with the A10/cubieboard support we
> move to the following dts/dtsi organization:
> 
> sunxi.dtsi - Devices common to all Allwinner sunXi SoC's
> sun4i.dtsi - sun4i Devices, will include sunxi.dtsi
> sun5i.dtsi - sun5i Devices, will include sunxi.dtsi
> board.dts - will include either sun4i.dtsi or sun5i.dtsi
> 
> If we agree on this, then I'll send a patch with this re-organization
> with the cubieboard patches.

Yes, that would make sense.

Thanks!


-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
