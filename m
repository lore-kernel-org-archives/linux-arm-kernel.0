From: rvaswani@codeaurora.org (Rohit Vaswani)
Date: Mon, 09 Sep 2013 10:48:22 -0700
Subject: [PATCHv3 1/2] ARM: msm: Add support for APQ8074 Dragonboard
In-Reply-To: <20130906215051.GA29253@quad.lixom.net>
References: <1378495943-2572-1-git-send-email-rvaswani@codeaurora.org>
 <20130906215051.GA29253@quad.lixom.net>
Message-ID: <522E09E6.8040300@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/6/2013 2:50 PM, Olof Johansson wrote:
> Hi,
>
> Some comments below.
>
> On Fri, Sep 06, 2013 at 12:32:22PM -0700, Rohit Vaswani wrote:
>> This patch adds basic board support for APQ8074 Dragonboard
>> <snip>
>>   dtb-$(CONFIG_ARCH_MSM) += msm8660-surf.dtb \
>> -	msm8960-cdp.dtb
>> +	msm8960-cdp.dtb \
>> +	apq8074-dragonboard.dtb
> Please add boards alphabetically.
Will do.
>
>>   dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
>>   	armada-370-mirabox.dtb \
>>   	armada-370-rd.dtb \
>> diff --git a/arch/arm/boot/dts/apq8074-dragonboard.dts b/arch/arm/boot/dts/apq8074-dragonboard.dts
>> new file mode 100644
>> index 0000000..5b7b6a0
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/apq8074-dragonboard.dts
> arch/arm/boot/dts/ is getting really crowded. It's been working best if the SoC
> family or vendor is used as a prefix to keep things a bit more organized. In
> that spirit, prefixing these with msm-<foo> makes sense. Can you please do so?

Sure. But the board is called an APQ8074 and we wanted to keep the 
naming consistent with that.
>> @@ -0,0 +1,6 @@
>> +/include/ "msm8974.dtsi"
>> +
>> +/ {
>> +	model = "Qualcomm APQ8074 Dragonboard";
>> +	compatible = "qcom,apq8074-dragonboard", "qcom,apq8074";
>> +};
> Ok, I'm all for merging a early minimal dts file, but things like memory and
> a default bootargs tend to make sense.
>
>> diff --git a/arch/arm/boot/dts/msm8974.dtsi b/arch/arm/boot/dts/msm8974.dtsi
>> new file mode 100644
>> index 0000000..f04b643
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/msm8974.dtsi
>> @@ -0,0 +1,35 @@
>> +/dts-v1/;
>> +
>> +/include/ "skeleton.dtsi"
>> +
>> +/ {
>> +	model = "Qualcomm MSM8974";
>> +	compatible = "qcom,msm8974";
> the board uses "qcom,apq8074" and this overrides this. Which way is it?

So, MSM8974 is the base chip. The APQ8074 is a board based on it with 
the modem fused. So, apq8074 board compatible overrides the generic chip 
compatible.
>
>> +	interrupt-parent = <&intc>;
>> +
>> +	soc: soc { };
> For files that include this it's ok to use the &phandle syntax, but in this
> base dtsi, please use proper structure. In other words, move the contents of
> the soc node up above instead.

Will do.
>
>> +};
>> +
>> +&soc {
>> +	#address-cells = <1>;
>> +	#size-cells = <1>;
>> +	ranges;
>> +	compatible = "simple-bus";
>> +
>> +	intc: interrupt-controller at f9000000 {
>> +		compatible = "qcom,msm-qgic2";
>> +		interrupt-controller;
>> +		#interrupt-cells = <3>;
>> +		reg = <0xf9000000 0x1000>,
>> +		      <0xf9002000 0x1000>;
>> +	};
>> +
>> +	timer {
>> +		compatible = "arm,armv7-timer";
>> +		interrupts = <1 2 0xf08>,
>> +			     <1 3 0xf08>,
>> +			     <1 4 0xf08>,
>> +			     <1 1 0xf08>;
>> +		clock-frequency = <19200000>;
>> +	};
>> +};
> It'd make a lot of sense to include at least cpu nodes here as well, and
> ideally basics for the drivers you have already merged, such as uarts.

Those are scheduled next as separate patches with some additional changes.
>
>> diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
>> index 905efc8..499e8fe 100644
>> --- a/arch/arm/mach-msm/Kconfig
>> +++ b/arch/arm/mach-msm/Kconfig
>> @@ -1,12 +1,12 @@
>>   if ARCH_MSM
>>   
>>   comment "Qualcomm MSM SoC Type"
>> -	depends on (ARCH_MSM8X60 || ARCH_MSM8960)
>> +	depends on ARCH_MSM_DT
>>   
>>   choice
>>   	prompt "Qualcomm MSM SoC Type"
>>   	default ARCH_MSM7X00A
>> -	depends on !(ARCH_MSM8X60 || ARCH_MSM8960)
>> +	depends on !ARCH_MSM_DT
> This has nothing to do with adding support for dragonboard. Please break
> out the cleanup separately.
>
> I'm not sure what the purpose of ARCH_MSM_DT is either, it just looks to
> complicate matter here?

ARCH_MSM_DT is just a combined config to denote the targets that have DT 
support instead of ORing the chip configs.
>> +config ARCH_MSM8974
>> +	bool "MSM8974"
>> +	select ARM_GIC
>> +	select CPU_V7
>> +	select HAVE_ARM_ARCH_TIMER
>> +	select HAVE_SMP
>> +	select MSM_SCM if SMP
>> +	select USE_OF
>> +
>> +config ARCH_MSM_DT
>> +	def_bool y
>> +	depends on (ARCH_MSM8X60 || ARCH_MSM8960 || ARCH_MSM8974)
>> +
>>   config MSM_HAS_DEBUG_UART_HS
>>   	bool
>>   
>> @@ -68,6 +81,7 @@ config MSM_SOC_REV_A
>>   
>>   config  ARCH_MSM_ARM11
>>   	bool
>> +
>>   config  ARCH_MSM_SCORPION
>>   	bool
>>   
>> @@ -75,6 +89,7 @@ config  MSM_VIC
>>   	bool
>>   
>>   menu "Qualcomm MSM Board Type"
>> +	depends on !ARCH_MSM_DT
>>   
>>   config MACH_HALIBUT
>>   	depends on ARCH_MSM
>> @@ -122,6 +137,7 @@ config MSM_SMD
>>   
>>   config MSM_GPIOMUX
>>   	bool
>> +	depends on !ARCH_MSM_DT
>>   	help
>>   	  Support for MSM V1 TLMM GPIOMUX architecture.
>
> All of the above should be in a separate patch and motivated.
>
>>   
>> diff --git a/arch/arm/mach-msm/Makefile b/arch/arm/mach-msm/Makefile
>> index d257ff4..80e3b15 100644
>> --- a/arch/arm/mach-msm/Makefile
>> +++ b/arch/arm/mach-msm/Makefile
>> @@ -29,5 +29,6 @@ obj-$(CONFIG_ARCH_MSM7X30) += board-msm7x30.o devices-msm7x30.o
>>   obj-$(CONFIG_ARCH_QSD8X50) += board-qsd8x50.o devices-qsd8x50.o
>>   obj-$(CONFIG_ARCH_MSM8X60) += board-dt-8660.o
>>   obj-$(CONFIG_ARCH_MSM8960) += board-dt-8960.o
>> +obj-$(CONFIG_ARCH_MSM8974) += board-dt-8974.o
>>   obj-$(CONFIG_MSM_GPIOMUX) += gpiomux.o
>>   obj-$(CONFIG_ARCH_QSD8X50) += gpiomux-8x50.o
>> diff --git a/arch/arm/mach-msm/board-dt-8974.c b/arch/arm/mach-msm/board-dt-8974.c
>> new file mode 100644
>> index 0000000..01ed8d0
>> --- /dev/null
>> +++ b/arch/arm/mach-msm/board-dt-8974.c
>> @@ -0,0 +1,24 @@
>> +/* Copyright (c) 2013, The Linux Foundation. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 and
>> + * only version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/of_platform.h>
>> +#include <asm/mach/arch.h>
>> +
>> +static const char * const msm8974_dt_match[] __initconst = {
>> +	"qcom,msm8974",
>> +	"qcom,apq8074",
>> +	NULL
>> +};
>> +
>> +DT_MACHINE_START(MSM8974_DT, "Qualcomm MSM (Flattened Device Tree)")
>> +	.dt_compat = msm8974_dt_match,
>> +MACHINE_END
> This file should be shared across SoCs. You should avoid adding a new dt board
> file for every SoC like this.

Will club these changes with the ARCH_MSM_DT seperation and send that 
out as a precursor patch to 8074 support.
>
> -Olof


Thanks,
Rohit Vaswani

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation
