From: kyungmin.park@samsung.com (Kyungmin Park)
Date: Sat, 17 Jul 2010 12:10:42 +0900
Subject: [PATCH v2 2/5] ARM: S5P: Added default pll values for APLL
	800/1000MHz
In-Reply-To: <012f01cb24e1$85628920$90279b60$%kim@samsung.com>
References: <1279267277-6804-1-git-send-email-myungjoo.ham@samsung.com>
	<1279267277-6804-2-git-send-email-myungjoo.ham@samsung.com>
	<1279267277-6804-3-git-send-email-myungjoo.ham@samsung.com>
	<012f01cb24e1$85628920$90279b60$%kim@samsung.com>
Message-ID: <AANLkTiliHDKDO_QIAW9xKGVaDtrzotYFH1lxAICnIXbo@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 16, 2010 at 9:22 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> MyungJoo Ham wrote:
>>
>> CPUFREQ of S5PV210 uses different APLL settings and we provide
>> such values for CPUFREQ at pll.h. We have been using differently
>> between EVT0 and EVT1 machines. Although this version of kernel
>> assumes that the CPU is EVT1, users may use code for EVT0 later.
>>
>> Note that at 1GHz of ARMCLK, APLL should be 1GHz and for other lower
>> ARMCLK, APLL should be 800MHz.
>>
>> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>> ?arch/arm/plat-s5p/include/plat/pll.h | ? ?8 ++++++++
>> ?1 files changed, 8 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/plat-s5p/include/plat/pll.h
> b/arch/arm/plat-s5p/include/plat/pll.h
>> index 7db3227..3112aba 100644
>> --- a/arch/arm/plat-s5p/include/plat/pll.h
>> +++ b/arch/arm/plat-s5p/include/plat/pll.h
>> @@ -21,6 +21,14 @@
>>
>> ?#include <asm/div64.h>
>>
>> +#ifdef CONFIG_CPU_S5PC110_EVT0_ERRATA
>
> Actually, EVT0 is not real chip and not for mass production.
> So don't use in here.

But we got too many board and want to use it. ARM core is also has
some workaround to fix internal bug. so you can regard it.

config S5PC110_WORKAROUND
    help
        Early s5pc110 has some errata blah blah ... To fix it you can enable it.

Thank you,
Kyungmin Park

>
>> +#define PLL45XX_APLL_VAL_1000 ? ? ? ?(1 << 31) | (0xfa<<16) | (0x6<<8) |
> (0x1)
>> +#define PLL45XX_APLL_VAL_800 (1 << 31) | (0xc8<<16) | (0x6<<8) | (0x1)
>> +#else
>> +#define PLL45XX_APLL_VAL_1000 ? ? ? ?(1 << 31) | (125<<16) | (3<<8) | (1)
>> +#define PLL45XX_APLL_VAL_800 (1 << 31) | (100<<16) | (3<<8) | (1)
>> +#endif
>> +
>> ?enum pll45xx_type_t {
>> ? ? ? pll_4500,
>> ? ? ? pll_4502,
>> --
>
> And...I got the below result from scripts/checkpatch.pl.
>
> --
>
> ERROR: Macros with complex values should be enclosed in parenthesis
> #27: FILE: arch/arm/plat-s5p/include/plat/pll.h:25:
> +#define PLL45XX_APLL_VAL_1000 ?(1 << 31) | (0xfa<<16) | (0x6<<8) | (0x1)
>
> ERROR: Macros with complex values should be enclosed in parenthesis
> #28: FILE: arch/arm/plat-s5p/include/plat/pll.h:26:
> +#define PLL45XX_APLL_VAL_800 ? (1 << 31) | (0xc8<<16) | (0x6<<8) | (0x1)
>
> ERROR: Macros with complex values should be enclosed in parenthesis
> #30: FILE: arch/arm/plat-s5p/include/plat/pll.h:28:
> +#define PLL45XX_APLL_VAL_1000 ?(1 << 31) | (125<<16) | (3<<8) | (1)
>
> ERROR: Macros with complex values should be enclosed in parenthesis
> #31: FILE: arch/arm/plat-s5p/include/plat/pll.h:29:
> +#define PLL45XX_APLL_VAL_800 ? (1 << 31) | (100<<16) | (3<<8) | (1)
>
> total: 4 errors, 0 warnings, 14 lines checked
>
> --
>
> I already said to you about that :-(
> See the Documentation/SubmittingPatches...
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
