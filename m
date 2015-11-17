From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 17 Nov 2015 13:39:12 +0900
Subject: [PATCH 1/2] clk: samsung: Don't build ARMv8 clock drivers on ARMv7
In-Reply-To: <564AADB2.3030400@samsung.com>
References: <1447637775-9887-1-git-send-email-k.kozlowski@samsung.com>
 <1447637775-9887-2-git-send-email-k.kozlowski@samsung.com>
 <564AADB2.3030400@samsung.com>
Message-ID: <564AAF70.9080507@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.11.2015 13:31, pankaj.dubey wrote:
> 
> 
> On Monday 16 November 2015 07:06 AM, Krzysztof Kozlowski wrote:
>> Currently the Exynos5433 (ARMv8 SoC) clock driver depends on ARCH_EXYNOS
>> so it is built also on ARMv7. This does not bring any kind of benefit.
>> There won't be a single kernel image for ARMv7 and ARMv8 SoCs (like
>> multi_v7 for ARMv7).
>>
>> Instead build clock drivers only for respective SoC's architecture.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> ---
>>  drivers/clk/samsung/Kconfig  | 13 +++++++++++++
>>  drivers/clk/samsung/Makefile |  4 ++--
>>  2 files changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/samsung/Kconfig b/drivers/clk/samsung/Kconfig
>> index 84196ecdaa12..5f138fc4d84d 100644
>> --- a/drivers/clk/samsung/Kconfig
>> +++ b/drivers/clk/samsung/Kconfig
>> @@ -2,6 +2,7 @@ config COMMON_CLK_SAMSUNG
>>  	bool
>>  	select COMMON_CLK
>>  
>> +# ARMv7 SoCs:
>>  config S3C2410_COMMON_CLK
>>  	bool
>>  	select COMMON_CLK_SAMSUNG
>> @@ -24,3 +25,15 @@ config S3C2443_COMMON_CLK
>>  	bool
>>  	select COMMON_CLK_SAMSUNG
>>  
>> +# ARMv8 SoCs:
>> +config EXYNOS5433_COMMON_CLK
>> +	bool
>> +	depends on ARM64 || COMPILE_TEST
>> +	default ARCH_EXYNOS
>> +	select COMMON_CLK_SAMSUNG
>> +
>> +config EXYNOS7_COMMON_CLK
>> +	bool
>> +	depends on ARM64 || COMPILE_TEST
>> +	default ARCH_EXYNOS
>> +	select COMMON_CLK_SAMSUNG
>> diff --git a/drivers/clk/samsung/Makefile b/drivers/clk/samsung/Makefile
>> index 5f6833ea355d..a31332a24ef4 100644
>> --- a/drivers/clk/samsung/Makefile
>> +++ b/drivers/clk/samsung/Makefile
>> @@ -10,11 +10,11 @@ obj-$(CONFIG_SOC_EXYNOS5250)	+= clk-exynos5250.o
>>  obj-$(CONFIG_SOC_EXYNOS5260)	+= clk-exynos5260.o
>>  obj-$(CONFIG_SOC_EXYNOS5410)	+= clk-exynos5410.o
>>  obj-$(CONFIG_SOC_EXYNOS5420)	+= clk-exynos5420.o
>> -obj-$(CONFIG_ARCH_EXYNOS)	+= clk-exynos5433.o
>> +obj-$(CONFIG_EXYNOS5433_COMMON_CLK)	+= clk-exynos5433.o
>>  obj-$(CONFIG_SOC_EXYNOS5440)	+= clk-exynos5440.o
>>  obj-$(CONFIG_ARCH_EXYNOS)	+= clk-exynos-audss.o
>>  obj-$(CONFIG_ARCH_EXYNOS)	+= clk-exynos-clkout.o
>> -obj-$(CONFIG_ARCH_EXYNOS7)	+= clk-exynos7.o
>> +obj-$(CONFIG_EXYNOS7_COMMON_CLK)	+= clk-exynos7.o
>>  obj-$(CONFIG_S3C2410_COMMON_CLK)+= clk-s3c2410.o
>>  obj-$(CONFIG_S3C2410_COMMON_DCLK)+= clk-s3c2410-dclk.o
>>  obj-$(CONFIG_S3C2412_COMMON_CLK)+= clk-s3c2412.o
>>
> 
> So in this approach we need to add separate config for clock support of
> each ARM64 Exynos64 SoC. Is this fine?
> 
> Can we club compilation of each ARM64 Exynos SoC clock file under
> EXYNOS7_COMMON_CLK? As for all ARM64 SoC there is single defconfig and
> binary.

Yes, it can be one config symbol for all clocks of ARMv8 Exynos SoCs.
>From my point of view both has some advantages and disadvantages (kernel
size, granularity, number of Kconfig symbols etc.) and I don't mind
choosing different than I selected before.

Any opinion from Samsung clock maintainers? Which do you prefer?

Best regards,
Krzysztof
it even looks
