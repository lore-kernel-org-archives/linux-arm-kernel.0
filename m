From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 14 Mar 2016 15:57:53 +0900
Subject: [PATCH 05/10] ARM: dts: Add exynos3250-artik5 dtsi file for ARTIK5
 module
In-Reply-To: <56E65D5D.8060702@samsung.com>
References: <1457921056-21257-1-git-send-email-cw00.choi@samsung.com>
 <1457921056-21257-6-git-send-email-cw00.choi@samsung.com>
 <56E65D5D.8060702@samsung.com>
Message-ID: <56E660F1.3060407@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 2016? 03? 14? 15:42, Krzysztof Kozlowski wrote:
> On 14.03.2016 11:04, Chanwoo Choi wrote:
>> This patch adds the support for Device Tree source for Samsung ARTIK5 module[1]
>> based on Exynos3250 SoC. The ARTIK5 module includes the follwoing devices:
>> - Application Processor (Samsung Exynos3250)
>> - WiFi/BT Combo chip (Broadcom4354)
>> - PMIC (Samsung S2MPS14)
>> - eMMC (4GB)
>> - DRAM LPDDR3 (512MB)
>> - Connectors pin (60 Pins x 3 set)
>>
>> Also, this patch adds the ARTIK5 development board[2] dts file which includes
>> the ARTIK5 module[1] and have the devices such as sound codec, sd card port,
>> ethernet port, uart port and so on.
>>
>> [1] https://www.artik.io/hardware/artik-5
>> [2] http://www.digikey.com/product-search/en?FV=ffecca14
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
>> ---
>>  arch/arm/boot/dts/Makefile                    |   1 +
>>  arch/arm/boot/dts/exynos3250-artik5-devel.dts |  26 +++
>>  arch/arm/boot/dts/exynos3250-artik5.dtsi      | 282 ++++++++++++++++++++++++++
> 
> Plus changes in
> Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt.
> 
>>  3 files changed, 309 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/exynos3250-artik5-devel.dts
>>  create mode 100644 arch/arm/boot/dts/exynos3250-artik5.dtsi
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index a4a6d70e8b26..f2de160828e8 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -108,6 +108,7 @@ dtb-$(CONFIG_ARCH_DIGICOLOR) += \
>>  dtb-$(CONFIG_ARCH_EFM32) += \
>>  	efm32gg-dk3750.dtb
>>  dtb-$(CONFIG_ARCH_EXYNOS3) += \
>> +	exynos3250-artik5-devel.dtb \
>>  	exynos3250-monk.dtb \
>>  	exynos3250-rinato.dtb
>>  dtb-$(CONFIG_ARCH_EXYNOS4) += \
>> diff --git a/arch/arm/boot/dts/exynos3250-artik5-devel.dts b/arch/arm/boot/dts/exynos3250-artik5-devel.dts
>> new file mode 100644
>> index 000000000000..d17c28969118
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/exynos3250-artik5-devel.dts
>> @@ -0,0 +1,26 @@
>> +/*
>> + * Samsung's Exynos3250 based ARTIK5 development board device tree source
>> + *
>> + * Copyright (c) 2016 Samsung Electronics Co., Ltd.
>> + *		http://www.samsung.com
>> + *
>> + * Device tree source file for Samsung's ARTIK5 development board
>> + * which is based on Samsung Exynos3250 SoC.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +/dts-v1/;
>> +#include "exynos3250-artik5.dtsi"
>> +
>> +/ {
>> +	model = "Samsung ARTIK5 development board";
>> +	compatible = "samsung,artik5-devel", "samsung,artik5",
>> +			"samsung,exynos3250", "samsung,exynos3";
>> +};
>> +
>> +&serial_2 {
>> +	status = "okay";
>> +};
>> diff --git a/arch/arm/boot/dts/exynos3250-artik5.dtsi b/arch/arm/boot/dts/exynos3250-artik5.dtsi
>> new file mode 100644
>> index 000000000000..97d0087efb9f
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/exynos3250-artik5.dtsi
>> @@ -0,0 +1,282 @@
>> +/*
>> + * Samsung's Exynos3250 based ARTIK5 module device tree source
>> + *
>> + * Copyright (c) 2016 Samsung Electronics Co., Ltd.
>> + *		http://www.samsung.com
>> + *
>> + * Device tree source file for Samsung's ARTIK5 module which is based on
>> + * Samsung Exynos3250 SoC.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include "exynos3250.dtsi"
>> +#include <dt-bindings/clock/samsung,s2mps11.h>
>> +
>> +/ {
>> +	compatible = "samsung,artik5", "samsung,exynos3250", "samsung,exynos3";
>> +
>> +
> 
> Leave only one blank line.
> 
>> +	chosen {
>> +		linux,stdout = &serial_2;
> 
> 'stdout-path' should be used (linux,stdout is deprecated).
> 
>> +	};
>> +
>> +	memory {
>> +		reg =  <0x40000000 0x1ff00000>;
> 
> Just one space after '='.
> 
>> +	};
>> +
>> +	firmware at 0205F000 {
>> +		compatible = "samsung,secure-firmware";
>> +		reg = <0x0205F000 0x1000>;
> 
> Let stick to one convention of letter case for hex numbers. Lower-case
> maybe, so 0205f000?

I'm sorry about coding style issue.
I'll fix them you mentioned.

> 
>> +	};
>> +};
>> +
>> +&i2c_0 {
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	samsung,i2c-sda-delay = <100>;
>> +	samsung,i2c-slave-addr = <0x10>;
>> +	samsung,i2c-max-bus-freq = <100000>;
>> +	status = "okay";
>> +
>> +	s2mps14_pmic at 66 {
>> +		compatible = "samsung,s2mps14-pmic";
>> +		interrupt-parent = <&gpx3>;
>> +		interrupts = <5 0>;
> 
> IRQ_TYPE_NONE

OK, I'll modify it.

> 
>> +		reg = <0x66>;
>> +		wakeup;
> 
> This is not valid property and is ignored. Probably you meant
> 'wakeup_source' (which would still be ignored by sec-core driver by the
> way... fixing this is waiting on Exynos mainline todo list :) ).

OK. I'll remove it.

Thanks for your review.

Best Regards,
Chanwoo Choi
