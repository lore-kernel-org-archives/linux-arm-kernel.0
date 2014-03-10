From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 10 Mar 2014 17:24:11 +0900
Subject: [PATCH 1/3] drivers: clk: add samsung common clock config option
In-Reply-To: <531D0718.8000305@gmail.com>
References: <1393392247-6247-1-git-send-email-pankaj.dubey@samsung.com>
 <1393392247-6247-2-git-send-email-pankaj.dubey@samsung.com>
 <531D0718.8000305@gmail.com>
Message-ID: <531D76AB.2030401@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On 03/10/2014 09:28 AM, Tomasz Figa wrote:
> Hi Pankaj,
>
> On 26.02.2014 06:24, Pankaj Dubey wrote:
>> add samsung common clock config option and let ARCH_EXYNOS or 
>> ARCH_S3CXXXX
>> select this if they want to use samsung common clock infrastructure.
>>
>> CC: Mike Turquette <mturquette@linaro.org>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>>   drivers/clk/Kconfig  |   10 ++++++++++
>>   drivers/clk/Makefile |    2 +-
>>   2 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
>> index 7641965..d93a325 100644
>> --- a/drivers/clk/Kconfig
>> +++ b/drivers/clk/Kconfig
>> @@ -23,6 +23,16 @@ config COMMON_CLK
>>   menu "Common Clock Framework"
>>       depends on COMMON_CLK
>>
>> +config COMMON_CLK_SAMSUNG
>> +    bool "Clock driver for Samsung SoCs"
>> +    depends on ARCH_S3C64XX || ARCH_S3C24XX || ARCH_EXYNOS || ARM64
>> +    ---help---
>> +          Supports clocking on Exynos SoCs:
>> +      - Exynos5250, Exynos5420 board.
>> +      - Exynos4 boards.
>> +      - S3C2412, S3C2416, S3C2466 boards.
>> +      - S3C64XX boards.
>
> I don't think listing the platforms here explicitly is a good idea, as 
> this option shouldn't generally be user-visible (related platforms 
> would not work without this option enabled) and adding support for 
> every new SoC would require changing the help string.
>
> I wonder if we really need this to be user-visible. What about moving 
> it out of this menu, making the symbol select COMMON_CLK and let the 
> platforms just select COMMON_CLK_SAMSUNG alone?
>
> Best regards,
> Tomasz
>

Thanks for review. I agree your point. In that case how about adding 
"drivers/clk/samsung/Kconfig" as below:

+config COMMON_CLK_SAMSUNG
+    bool
+    select COMMON_CLK
+
+config S3C2412_COMMON_CLK //These macros are introduced by Heiko's 
clock patches for S3C24XX SoC
+    bool
+    select COMMON_CLK_SAMSUNG
+
+config S3C2443_COMMON_CLK
+    bool
+    select COMMON_CLK_SAMSUNG

In this way we can get rid of clock related config options from 
"arch/arm/mach-s3c24xx/Kconfig" and in future
if any other old SoC such as S5P clocks getting converted to use common 
clock, they can add related config here rather
than arch/mach-xxx/Kconfig if required. Thus we can keep all common 
clock config option for Samsung SoC at one place.
All Exynos SOC can select only COMMON_CLK_SAMSUNG to use Samsung common 
clock infrastructure.

-- 
Best Regards,
Pankaj Dubey
