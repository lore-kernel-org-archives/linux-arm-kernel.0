From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 10 Feb 2014 18:37:12 +0100
Subject: [PATCH 04/11] ARM: mvebu: add Device Tree description of the
 Armada 375 SoC
In-Reply-To: <20140210173527.GR8533@titan.lakedaemon.net>
References: <1392053002-19831-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1392053002-19831-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140210173527.GR8533@titan.lakedaemon.net>
Message-ID: <52F90E48.8010204@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/2014 18:35, Jason Cooper wrote:
> On Mon, Feb 10, 2014 at 06:23:15PM +0100, Thomas Petazzoni wrote:
>> From: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>
>> The Armada 375 SoC is a new SoC from Marvell, based on a dual core
>> Cortex-A9 and a number of hardware blocks that are common with earlier
>> SoCs from the mvebu family.
>>
>> The provided Device Tree describes the following parts of the SoC:
>>
>>  * CPUs
>>  * Device Bus
>>  * Clocks
>>  * Interrupt controllers: GIC and MPIC
>>  * GPIO controllers
>>  * I2C buses
>>  * L2 cache
>>  * MBus controller
>>  * SDIO
>>  * Pinctrl
>>  * SATA
>>  * Serial
>>  * SPI buses
>>  * System controller (for reboot)
>>  * Timer
>>  * XOR engines
>>  * PCIe controllers
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> ---
>>  arch/arm/boot/dts/armada-375.dtsi | 439 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 439 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/armada-375.dtsi
>>
>> diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
>> new file mode 100644
>> index 0000000..2697345
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/armada-375.dtsi
>> @@ -0,0 +1,439 @@
>> +/*
>> + * Device Tree Include file for Marvell Armada 375 family SoC
>> + *
>> + * Copyright (C) 2014 Marvell
>> + *
>> + * Gregory CLEMENT <gregory.clement@free-electrons.com>
>> + * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2.  This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + */
>> +
>> +/include/ "skeleton.dtsi"
>> +
>> +#define MBUS_ID(target,attributes) (((target) << 24) | ((attributes) << 16))
>> +
>> +/ {
>> +	model = "Marvell Armada 375 family SoC";
>> +	compatible = "marvell,armada375";
>> +
>> +	aliases {
>> +		gpio0 = &gpio0;
>> +		gpio1 = &gpio1;
>> +		gpio2 = &gpio2;
>> +	};
>> +
>> +	clocks {
>> +		/* 2 GHz fixed main PLL */
>> +		mainpll: mainpll {
>> +			compatible = "fixed-clock";
>> +			#clock-cells = <0>;
>> +			clock-frequency = <2000000000>;
>> +		};
>> +	};
>> +
>> +	cpus {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		cpu at 0 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a9";
>> +			reg = <0>;
>> +		};
>> +		cpu at 1 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a9";
>> +			reg = <1>;
>> +		};
>> +	};
>> +
>> +	soc {
> ...
>> +		internal-regs {
> ...
>> +			gateclk: clock-gating-control at 18220 {
>> +				compatible = "marvell,armada-375-gating-clock";
>> +				reg = <0x18220 0x4>;
>> +				clocks = <&coreclk 0>;
>> +				#clock-cells = <1>;
>> +			};
>> +
> ...
>> +			coreclk: mvebu-sar at e8204 {
>> +				compatible = "marvell,armada-375-core-clock";
>> +				reg = <0xe8204 0x04>;
>> +				#clock-cells = <1>;
>> +			};
>> +
>> +			coredivclk: corediv-clock at e8250 {
>> +				compatible = "marvell,armada-375-corediv-clock";
>> +				reg = <0xe8250 0xc>;
>> +				#clock-cells = <1>;
>> +				clocks = <&mainpll>;
>> +				clock-output-names = "nand";
>> +			};
> 
> Thanks for putting the internal-regs nodes in order so I didn't have to
> ask.  :) Have you noticed the same problem as the other SoCs with clock
> ordering on bootup?

Yes :(

> 
> thx,
> 
> Jason.
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
