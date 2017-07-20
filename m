From: icenowy@aosc.io (icenowy at aosc.io)
Date: Thu, 20 Jul 2017 13:15:15 +0800
Subject: [linux-sunxi] [PATCH v4 4/5] ARM: sunxi: h3/h5: switch
 apb0-related clocks to r_ccu
In-Reply-To: <3299ee7dd04482f0a21752651335e223@aosc.io>
References: <20170404095100.18649-1-icenowy@aosc.io>
 <20170404095100.18649-5-icenowy@aosc.io> <1500505173.23770.1.camel@xff.cz>
 <3299ee7dd04482f0a21752651335e223@aosc.io>
Message-ID: <20236586042490458d0f1b8e47c5481a@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017-07-20 10:03?icenowy at aosc.io ???
> ? 2017-07-20 06:59?Ond?ej Jirman ???
>> Hi,
>> 
>> Icenowy Zheng p??e v ?t 04. 04. 2017 v 17:50 +0800:
>>> From: Icenowy Zheng <icenowy@aosc.xyz>
>>> 
>>> Now we have driver for the PRCM CCU, switch to use it instead of
>>> old-style clock nodes for apb0-related clocks in sunxi-h3-h5.dtsi .
>>> 
>>> The mux 3 of R_CCU is still the internal oscillator, which is said to 
>>> be
>>> 16MHz plus minus 30%, and get a measured value of 15MHz~16MHz on my 
>>> two
>>> H3 boards and one H5 board.
>> 
>> There's issue with the new r_ccu that breaks r_i2c. (no devices can be
>> found on the bus). Reverting this patch fixes the issue with the I2C
>> controller. (everything else being the same)
>> 
>> Here's the code I'm using: 
>> https://github.com/megous/linux/commits/oran
>> ge-pi-4.12
>> 
>> The last commit is the revert.
>> 
>> The issue manifests itself by non-working DVFS, because kernel lacks
>> access to SY8106A regulator, because r_i2c doesn't work with sunxi-ng
>> clock driver (sun8i-r).
>> 
>> Relevant difference in registers between working/non-working state is
>> just this (diff -u):
>> 
>>  0x01f02400 = 0x00000000
>>  0x01f02404 = 0x00000000
>> -0x01f02408 = 0x00000091
>> +0x01f02408 = 0x00000095 DATA register inisde the I2C controller
>>  0x01f0240c = 0x00000044
>>  0x01f02410 = 0x000000f8
>> -0x01f02414 = 0x00000059
>> +0x01f02414 = 0x00000000 CLOCK setup register inside the I2C 
>> controller
>>  0x01f02418 = 0x00000000
>>  0x01f0241c = 0x00000000
>>  0x01f02420 = 0x0000003a
>> 
>> It looks like the new sunxi-ng clock driver causes the I2C driver to
>> not correctly configure the CLOCK register. I don't know why and I'm
>> not sure how to deal with this. Any ideas what can I do next?
>> 
>> thank you and regards,
>>   o.
> 
> It seems to be a very very very weird problem -- the CPUS_CFG register
> seems to be not accessible in non-secure mode on H3, and if the r_ccu
> driver reads it a value of 0x0 is read out (which means that the parent
> of ar100 is osc32k), but the real initial value of the register is
> 0x00010000 (which means the parent is osc24M).
> 
> So the bus clock of r_i2c is wrongly claimed as 32kHz, not 24MHz, then
> the r_i2c fails to work.

The protection to AR100 registers can be removed by writing 1 to 
0x01f015d0
(0x1d0 at PRCM memory region).

Interestingly this controlling register can be written in non-secure 
world,
so it's still broken secure/non-secure division ;-)

> 
> This clock problem doesn't exist for A64.
> 
>> 
>>> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>>> ---
>>> Changes in v4:
>>> - Temporarily dropped the CCU headers.
>>> Changes in v3:
>>> - Change osc32000 to iosc.
>>> 
>>>  arch/arm/boot/dts/sunxi-h3-h5.dtsi | 45 
>>> ++++++++++++--------------------------
>>>  1 file changed, 14 insertions(+), 31 deletions(-)
>>> 
>>> diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi 
>>> b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
>>> index 6640ebfa6419..1aeeacb3a884 100644
>>> --- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
>>> +++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
>>> @@ -68,31 +68,12 @@
>>>  			clock-output-names = "osc32k";
>>>  		};
>>> 
>>> -		apb0: apb0_clk {
>>> -			compatible = "fixed-factor-clock";
>>> +		iosc: internal-osc-clk {
>>>  			#clock-cells = <0>;
>>> -			clock-div = <1>;
>>> -			clock-mult = <1>;
>>> -			clocks = <&osc24M>;
>>> -			clock-output-names = "apb0";
>>> -		};
>>> -
>>> -		apb0_gates: clk at 01f01428 {
>>> -			compatible = "allwinner,sun8i-h3-apb0-gates-clk",
>>> -				     "allwinner,sun4i-a10-gates-clk";
>>> -			reg = <0x01f01428 0x4>;
>>> -			#clock-cells = <1>;
>>> -			clocks = <&apb0>;
>>> -			clock-indices = <0>, <1>;
>>> -			clock-output-names = "apb0_pio", "apb0_ir";
>>> -		};
>>> -
>>> -		ir_clk: ir_clk at 01f01454 {
>>> -			compatible = "allwinner,sun4i-a10-mod0-clk";
>>> -			reg = <0x01f01454 0x4>;
>>> -			#clock-cells = <0>;
>>> -			clocks = <&osc32k>, <&osc24M>;
>>> -			clock-output-names = "ir";
>>> +			compatible = "fixed-clock";
>>> +			clock-frequency = <16000000>;
>>> +			clock-accuracy = <300000000>;
>>> +			clock-output-names = "iosc";
>>>  		};
>>>  	};
>>> 
>>> @@ -576,9 +557,12 @@
>>>  				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
>>>  		};
>>> 
>>> -		apb0_reset: reset at 01f014b0 {
>>> -			reg = <0x01f014b0 0x4>;
>>> -			compatible = "allwinner,sun6i-a31-clock-reset";
>>> +		r_ccu: clock at 1f01400 {
>>> +			compatible = "allwinner,sun50i-a64-r-ccu";
>>> +			reg = <0x01f01400 0x100>;
>>> +			clocks = <&osc24M>, <&osc32k>, <&iosc>;
>>> +			clock-names = "hosc", "losc", "iosc";
>>> +			#clock-cells = <1>;
>>>  			#reset-cells = <1>;
>>>  		};
>>> 
>>> @@ -589,9 +573,9 @@
>>> 
>>>  		ir: ir at 01f02000 {
>>>  			compatible = "allwinner,sun5i-a13-ir";
>>> -			clocks = <&apb0_gates 1>, <&ir_clk>;
>>> +			clocks = <&r_ccu 4>, <&r_ccu 11>;
>>>  			clock-names = "apb", "ir";
>>> -			resets = <&apb0_reset 1>;
>>> +			resets = <&r_ccu 0>;
>>>  			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
>>>  			reg = <0x01f02000 0x40>;
>>>  			status = "disabled";
>>> @@ -601,9 +585,8 @@
>>>  			compatible = "allwinner,sun8i-h3-r-pinctrl";
>>>  			reg = <0x01f02c00 0x400>;
>>>  			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
>>> -			clocks = <&apb0_gates 0>, <&osc24M>, <&osc32k>;
>>> +			clocks = <&r_ccu 3>, <&osc24M>, <&osc32k>;
>>>  			clock-names = "apb", "hosc", "losc";
>>> -			resets = <&apb0_reset 0>;
>>>  			gpio-controller;
>>>  			#gpio-cells = <3>;
>>>  			interrupt-controller;
>>> --
>>> 2.12.2
>>> 
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
