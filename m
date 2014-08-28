From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 28 Aug 2014 09:35:50 +0100
Subject: [PATCH 11/14] arm64: dts: Add initial device tree support for
 EXYNOS7
In-Reply-To: <20140828035639.GB4972@localhost>
References: <1409132660-1898-1-git-send-email-ch.naveen@samsung.com>
 <1409132660-1898-3-git-send-email-ch.naveen@samsung.com>
 <20140828035639.GB4972@localhost>
Message-ID: <53FEE9E6.2000204@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/08/14 04:56, Olof Johansson wrote:
> Hi,
> 
> On Wed, Aug 27, 2014 at 03:14:18PM +0530, Naveen Krishna Chatradhi wrote:
>> Add initial device tree nodes for EXYNOS7 SoC.
>> Also, includes the dt-binding definitions for clock ids.
> 
> Uh, no -- it just adds the dtsi.
> 
>> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
>> Cc: Thomas Abraham <thomas.ab@samsung.com>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> ---
>>  arch/arm64/boot/dts/exynos7.dtsi |  553 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 553 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/exynos7.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/exynos7.dtsi b/arch/arm64/boot/dts/exynos7.dtsi
>> new file mode 100644
>> index 0000000..6b9eaf4
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/exynos7.dtsi
> 
> Let's not make the same mistake as on 32-bit, and go with a directory
> hierarchy here from day one.
> 
> So, please create a exynos subdirectory for this file. You also need
> a Makefile when you add a board dts.
> 
>> @@ -0,0 +1,553 @@
>> +/*
>> + * SAMSUNG EXYNOS7 SoC device tree source
>> + *
>> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
>> + *		http://www.samsung.com
>> + *
>> + * SAMSUNG EXYNOS7 SoC device nodes are listed in this file.
>> + * EXYNOS7 based board files can include this file and provide
>> + * values for board specfic bindings.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <dt-bindings/clock/exynos7-clk.h>
>> +
>> +/ {
>> +	compatible = "samsung,exynos7";
>> +	interrupt-parent = <&gic>;
>> +	#address-cells = <1>;
>> +	#size-cells = <1>;
> 
> You should probably use address-cells/size-cells 2/2 on a 64-bit platform.
> 
>> +	aliases {
>> +		pinctrl0 = &pinctrl_0;
>> +		pinctrl1 = &pinctrl_1;
>> +		pinctrl2 = &pinctrl_2;
>> +		pinctrl3 = &pinctrl_3;
>> +		pinctrl4 = &pinctrl_4;
>> +		pinctrl5 = &pinctrl_5;
>> +		pinctrl6 = &pinctrl_6;
>> +		pinctrl7 = &pinctrl_7;
>> +		pinctrl8 = &pinctrl_8;
>> +		pinctrl9 = &pinctrl_9;
>> +		mshc0 = &mmc_0;
>> +		mshc2 = &mmc_2;
>> +	};
>> +
>> +	chipid at 10000000 {
>> +		compatible = "samsung,exynos4210-chipid";
>> +		reg = <0x10000000 0x100>;
>> +	};
>> +
>> +	cpus {
>> +		#address-cells = <2>;
>> +		#size-cells = <0>;
> 
> Why size-cells=2? Can you not fit a cpuid in 32 bits?
> 
>> +		cpu at 0 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a57", "arm,armv8";
>> +			reg = <0x0 0x0>;
>> +		};
>> +	};
>> +
>> +	fin_pll: xxti {
>> +		compatible = "fixed-clock";
>> +		clock-frequency = <24000000>;
>> +		clock-output-names = "fin_pll";
>> +		#clock-cells = <0>;
>> +	};
>> +
>> +	gic: interrupt-controller at 11001000 {
>> +		compatible = "arm,gic-400";
>> +		#interrupt-cells = <3>;
>> +		#address-cells = <0>;
>> +		interrupt-controller;
>> +		reg =	<0x11001000 0x1000>,
>> +			<0x11002000 0x1000>,
>> +			<0x11004000 0x2000>,
>> +			<0x11006000 0x2000>;
>> +	};
>> +
>> +	hsi2c_0: hsi2c at 13640000 {
>> +		compatible = "samsung,exynos7-hsi2c";
> 
> Is the i2c controller here completely new?
> 
> Also, please use 'i2c' for node name on these nodes.
> 
>> +		reg = <0x13640000 0x1000>;
>> +		interrupts = <0 441 0>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&hs_i2c0_bus>;
>> +		clocks = <&clock_peric0 PCLK_HSI2C0>;
>> +		clock-names = "hsi2c";
>> +		status = "disabled";
>> +	};
>> +
>> +	hsi2c_1: hsi2c at 13650000 {
>> +		compatible = "samsung,exynos7-hsi2c";
>> +		reg = <0x13650000 0x1000>;
>> +		interrupts = <0 442 0>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&hs_i2c1_bus>;
>> +		clocks = <&clock_peric0 PCLK_HSI2C1>;
>> +		clock-names = "hsi2c";
>> +		status = "disabled";
>> +	};
>> +
>> +	hsi2c_2: hsi2c at 14E60000 {
> 
> I much prefer lowercase hex in unit addresses (and reg entries) below. I
> know 32-bit uses uppercase, but let's switch going forward here.
> 
>> +	mct at 101C0000 {
>> +		compatible = "samsung,exynos4210-mct";
> 
> Please just do away with MCT here, and use architected timers going
> forward. There really shouldn't be a need to keep supporting MCT any
> more -- it's a construct from before arch timers on Cortex-A9.
> 
>> +	mmc_0: mmc at 15740000 {
>> +		compatible = "samsung,exynos7-dw-mshc-smu";
> 
> Is this controller backwards compatible with exynos5 ones?
> 
>> +	/* The Clock nodes are ordered as per the usermanual. */
> 
> "The clock"
> 
> "user manual"
> 
>> +	timer {
>> +	        compatible = "arm,armv8-timer";
>> +	        interrupts = <1 13 0xff01>,
>> +	                     <1 14 0xff01>,
>> +	                     <1 11 0xff01>,
>> +	                     <1 10 0xff01>;
>> +	        clock-frequency = <24000000>;
>> +		use-clocksource-only;
>> +		use-physical-timer;
> 
> These two properties are not standard, and I would expect any 64-bit
> platform to come with PSCI such that you have a way to initialize the
> virtual timers.

It really sickens me that this is the n-th iteration of a Samsung SoC
having the generic timer (basically since the 5250 came out), and still
it is littered with stupid firmware bugs:
- Broken CNTFRQ (as outlined by the need of clock-frequency)
- Broken CNTVOFF (as hinted by the reliance on the physical timer)

You would think that after over two years, someone would have a clue and
added the missing 4 instructions to the boot ROM.

Or not.

	M.
-- 
Jazz is not dead. It just smells funny...
