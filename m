From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 14 Apr 2014 14:26:34 +0800
Subject: [PATCH v2 02/12] ARM: append ARCH_MULTI_V7_LPAE
In-Reply-To: <5170679.UrtmSgyEZI@wuerfel>
References: <1396944052-9887-1-git-send-email-haojian.zhuang@linaro.org>
 <1396944052-9887-3-git-send-email-haojian.zhuang@linaro.org>
 <5170679.UrtmSgyEZI@wuerfel>
Message-ID: <CAD6h2NTmVBm++Co2_YGmTp44qcrDjaBDEvatutbQq+P0OBEhWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 April 2014 18:59, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 08 April 2014 16:00:42 Haojian Zhuang wrote:
>> Add new ARCH_MULTI_V7_LPAE config. It will select ARM_LPAE only both
>> ARCH_MULTI_V6 & ARCH_MULTI_V7 is disabled.
>>
>> ARCH_MULTI_V7 means non-LPAE platform.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>
> I think it's good to have this option, but it should be added more carefully.
>
>>  arch/arm/Kconfig | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 5248923..a8b2b45 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -918,12 +918,19 @@ config ARCH_MULTI_V6
>>       select CPU_V6K
>>
>>  config ARCH_MULTI_V7
>> -     bool "ARMv7 based platforms (Cortex-A, PJ4, Scorpion, Krait)"
>> +     bool "ARMv7 non-LPAE based platforms (Cortex-A, PJ4, Scorpion, Krait)"
>>       default y
>>       select ARCH_MULTI_V6_V7
>>       select CPU_V7
>>       select HAVE_SMP
>>
>> +config ARCH_MULTI_V7_LPAE
>> +     bool "ARMv7 LPAE based platforms (HIP04)"
>> +     select ARCH_MULTI_V6_V7
>> +     select CPU_V7
>> +     select HAVE_SMP
>> +     select ARM_LPAE if !(ARCH_MULTI_V6 || ARCH_MULTI_V7)
>> +
>>  config ARCH_MULTI_V6_V7
>>       bool
>>       select MIGHT_HAVE_CACHE_L2X0
>
> Two points here:
>
> a) The other options all list the CPU types (Cortex-A, PJ4, ...),
>    while the one you introduce lists the platform name. I think they
>    should all list the CPU cores, like
>
>   bool "ARMv7 non-LPAE based platforms (Cortex-A5/A8/A9, PJ4, Scorpion)"
>
>   bool "ARMv7 non-LPAE based platforms (Cortex-A7/A12/A15/A17, Brahma-B15, PJ4B, Krait)"
>   (I'm not completely sure about Krait, need to check that).
>
I think that you're saying ARMv7 LPAE based platforms (Cortex-A7/...) at here.

> b) When you introduce this, please change the other platforms over to use
> the symbol correctly. We already have a number of platforms based on A7, A15,
> PJ4B and Krait.
>
Sure, I'll update all the platforms.

Regards
Haojian
