From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 24 Feb 2016 18:14:52 +0900
Subject: [PATCH 2/3] ARM: EXYNOS: remove unused register offset definition
In-Reply-To: <56CD6885.4060904@samsung.com>
References: <1456135396-17767-1-git-send-email-pankaj.dubey@samsung.com>
 <1456135396-17767-3-git-send-email-pankaj.dubey@samsung.com>
 <56CBA1BC.4050003@samsung.com> <56CC2238.2040303@samsung.com>
 <56CCEF84.6090502@samsung.com> <56CD6885.4060904@samsung.com>
Message-ID: <56CD748C.7060007@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24.02.2016 17:23, pankaj.dubey wrote:
> 
> 
> On Wednesday 24 February 2016 05:17 AM, Krzysztof Kozlowski wrote:
>> On 23.02.2016 18:11, pankaj.dubey wrote:
>>> Hi Krzysztof,
>>>
>>> On Tuesday 23 February 2016 05:33 AM, Krzysztof Kozlowski wrote:
>>>> On 22.02.2016 19:03, Pankaj Dubey wrote:
>>>>> This patch cleans up map.h by removing unused register offset
>>>>> and changing EXYNOS4 to EXYNOS in header comment section.
>>>>>
>>>>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>>>>> ---
>>>>>  arch/arm/mach-exynos/include/mach/map.h | 9 +--------
>>>>>  1 file changed, 1 insertion(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
>>>>> index 351e839..c48ba4f 100644
>>>>> --- a/arch/arm/mach-exynos/include/mach/map.h
>>>>> +++ b/arch/arm/mach-exynos/include/mach/map.h
>>>>> @@ -2,7 +2,7 @@
>>>>>   * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
>>>>>   *		http://www.samsung.com/
>>>>>   *
>>>>> - * EXYNOS4 - Memory map definitions
>>>>> + * EXYNOS - Memory map definitions
>>>>>   *
>>>>>   * This program is free software; you can redistribute it and/or modify
>>>>>   * it under the terms of the GNU General Public License version 2 as
>>>>> @@ -14,12 +14,6 @@
>>>>>  
>>>>>  #include <plat/map-base.h>
>>>>>  
>>>>> -/*
>>>>> - * EXYNOS4 UART offset is 0x10000 but the older S5P SoCs are 0x400.
>>>>> - * So need to define it, and here is to avoid redefinition warning.
>>>>> - */
>>>>> -#define S3C_UART_OFFSET			(0x10000)
>>>>> -
>>>>>  #include <plat/map-s5p.h>
>>>>
>>>> This does not look good. The S3C_UART_OFFSET is used in plat/map-s5p.h.
>>>>
>>>
>>> Actually it's just defined there but not getting used anywhere. In fact
>>> we can remove it from there also.
>>
>> The point is that your patch introduce changes. Before S3C_UART_OFFSET
>> was defined to 0x10000, after (because of #ifndef) it will be 0x400.
>> Description of "unused" is not accurate. Unused stuff does not impact
>> anything.
>>
>>> So I submitted another patch to
>>> cleanup such redundant register definitions from plat/map-s5p.h.
>>
>> That would be good.
>>
>>> Only platform using S3C_UART_OFFSET is s3c64xx and its using definition
>>> from map-s3c.h. I have compiled all related platform defconfigs and
>>> found no issues because of removal of S3C_UART_OFFSET from map-s5p.c and
>>> map.h.
>>
>> The compilation is not a test. You compiled something like this:
>> -#define S3C_UART_OFFSET			(0x10000)
>>  #ifndef S3C_UART_OFFSET
>>  #define S3C_UART_OFFSET         (0x400)
>>  #endif
>>
>> ... and found no errors. Of course there are no compilation errors! But
>> the value has changed!
>>
> 
> OK. I see, there are quite a few places these definitions are scattered
> even though not used (not used in the sense what ever values these
> macros are taking in code it's not used). Such as
> mach-exynos/include/map.h, plat-samsung/include/plat/{map-s3c.h,
> map-s5p.h} and mach-s3c24xx/include/mach/map.h. So I will remove all
> these in one go.
> Is this fine?

Except the used ones (s3c64xx) - yes, all at once. Some of them depend
on previous ones (ifndef) so "unused" when patching this one-by-one is
not accurate.

> Also I have one doubt in case I am touching files across various mach
> files and preparing a single patch what should be commit message
> heading? Is commit starting with "ARM: samsung" fine? or anything more
> appropriate you would suggest.

It is still the same Samsung tree and either way it would end in the
same branch. ARM: SAMSUNG: is fine (I saw it in the log).

Best regards,
Krzysztof
