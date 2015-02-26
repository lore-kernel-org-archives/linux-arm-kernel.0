From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 26 Feb 2015 17:28:00 +0900
Subject: [PATCH v4 1/8] arm64: exynos5433: Enable ARMv8 based Exynos5433
 (SoC) support
In-Reply-To: <8838911.kfOYZxBsJP@wuerfel>
References: <1424755011-15999-1-git-send-email-cw00.choi@samsung.com>
 <1424755011-15999-2-git-send-email-cw00.choi@samsung.com>
 <8838911.kfOYZxBsJP@wuerfel>
Message-ID: <54EED910.4010603@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/24/2015 05:31 PM, Arnd Bergmann wrote:
> On Tuesday 24 February 2015 14:16:44 Chanwoo Choi wrote:
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 1b8e973..d83cea0 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -154,6 +154,17 @@ config ARCH_EXYNOS
>>         help
>>           This enables support for Samsung Exynos SoC family
>>  
>> +config ARCH_EXYNOS5433
>> +       bool "ARMv8 based Samsung Exynos5433"
>> +       select ARCH_EXYNOS
>> +       select COMMON_CLK_SAMSUNG
>> +       select HAVE_S3C_RTC if RTC_CLASS
>> +       select PINCTRL
>> +       select PINCTRL_EXYNOS
>> +
>> +       help
>> +         This enables support for Samsung Exynos5433 SoC family
>> +
>>  config ARCH_EXYNOS7
>>         bool "ARMv8 based Samsung Exynos7"
>>         select ARCH_EXYNOS
>> -- 
>>
> 
> Can we collapse all these entries into one for EXYNOS? I don't
> want to end up with endless lists like we have on arm32 when
> there is no platform specific code that is actually controlled
> by this anway.

I agree.

I check the some issue for only using the CONFIG_ARCH_EXYNOS
insead of CONFIG_ARCH_EXYNOS7 and CONFIG_ARCH_EXYNOS5433.

Each CONFIG_ARCH_EXYNOS{7|5433} configuraiton was used on following list:
- CONFIG_ARCH_EXYNOS7
arch/arm64/boot/dts/exynos/Makefile:1:dtb-$(CONFIG_ARCH_EXYNOS7) += exynos7-espresso.dtb
drivers/clk/samsung/Makefile:17:obj-$(CONFIG_ARCH_EXYNOS7)	+= clk-exynos7.o
- CONFIG_ARCH_EXYNOS5433
drivers/clk/samsung/Makefile:13:obj-$(CONFIG_ARCH_EXYNOS5433)	+= clk-exynos5433.o

We may can fix it as following by only using 'CONFIG_ARCH_EXYNOS' without any specific configuration.

arch/arm64/boot/dts/exynos/Makefile:1:dtb-$(CONFIG_ARCH_EXYNOS) += exynos7-espresso.dtb
drivers/clk/samsung/Makefile:17:obj-$(CONFIG_ARCH_EXYNOS)	+= clk-exynos7.o clk-exynos5433.o

I think that we need the opinion of Kukjin Kim (Exynos SoC Maintainer)
and Sylwester Nawrocki(Samsung clock Maintainer)

Thanks,
Chanwoo Choi
