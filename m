From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Fri, 20 Jul 2012 12:00:15 +0200
Subject: [PATCH V2 1/7] ARM: SAMSUNG: add additional registers and SFR
 definitions for writeback
In-Reply-To: <CAL1wa8dyLjC8BZBc0wBnjP=a2Yo5XDQq1Kfq9yw35_e8wxp0bw@mail.gmail.com>
References: <1342591053-7092-1-git-send-email-l.krishna@samsung.com>
 <1429943.UqWt7uDBOU@flatron>
 <CAL1wa8cCq-w8w-d-Z7rqRfA9yrfPvxQjxFn9b475A-D=J8d3Ew@mail.gmail.com>
 <4240594.0SndFBiAl5@flatron>
 <000a01cd661e$4e1e19e0$ea5a4da0$%han@samsung.com>
 <CAL1wa8dyLjC8BZBc0wBnjP=a2Yo5XDQq1Kfq9yw35_e8wxp0bw@mail.gmail.com>
Message-ID: <50092C2F.9010304@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/20/2012 04:59 AM, Leela Krishna Amudala wrote:
>>>>>> --- a/arch/arm/plat-samsung/include/plat/regs-fb-v4.h
>>>>>> +++ b/arch/arm/plat-samsung/include/plat/regs-fb-v4.h
>>>>>> @@ -30,9 +30,16 @@
>>>>>>
>>>>>>   #define VIDCON1_FSTATUS_EVEN (1<<  15)
>>>>>>
>>>>>>   /* Video timing controls */
>>>>>>
>>>>>> +#ifdef CONFIG_FB_EXYNOS_FIMD_V8
>>>>>> +#define VIDTCON0                                (0x20010)
>>>>>> +#define VIDTCON1                                (0x20014)
>>>>>> +#define VIDTCON3                                (0x2001C)
>>>>>> +#else
>>>>>>
>>>>>>   #define VIDTCON0                             (0x10)
>>>>>>   #define VIDTCON1                             (0x14)
>>>>>>   #define VIDTCON2                             (0x18)
>>>>>>
>>>>>> +#define VIDTCON3                             (0x1C)
>>>>>> +#endif
>>>>>
>>>>> Wouldn't it break s3c-fb on SoCs with earlier FIMD versions with
>>>>> CONFIG_FB_EXYNOS_FIMD_V8 selected? We are aiming at multi-platform ARM
>>>>> kernels, aren't we (i.e support of both V8 and earlier FIMD in one
>>>>> kernel)?
>>>> Exynos5 has FIMD_V8 and other SoCs has older FIMD versions.
>>>> As address offsets for certain registers has changed in FIMD_V8, we
>>>> introduced these defines.
>>>> So we have to select CONFIG_FB_EXYNOS_FIMD_V8 in case of Exynos5 SoC,
>>>> and deselect for other SoCs.
>>>
>>> Yes, I'm aware of different FIMD versions in different SoCs. My point is
>>> that it shouldn't be necessary to deselect CONFIG_FB_EXYNOS_FIMD_V8 to
>>> support other SoCs than Exynos5, i.e. additional config options should be
>>> incremental - should not break other setups. Ideally there should not be
>>> any new config option for FIMD v8.
>>>
>>> The detection of FIMD version and selection of appropriate register offsets
>>> should be done in the driver at runtime, based for example on
>>> platform_device_id (see the s3c-fb driver and usage of s3c_fb_driverdata
>>> and s3c_fb_win_variant structs).
>>
>> I could not agree with Tomasz Figa more.
>> FIMD register offset should be selected at runtime.
>>
>> Leela Krishna Amudala,
>> Please, don't use ugly "#ifdef".
>>
>> Best regards,
>> Jingoo Han
>>
> 
> Yes, Each SoC having its own defconfigs (eg: exynos4_defconfig,
> exynos5_defconfig etc.,)
> So, CONFIG_FB_EXYNOS_FIMD_V8 will be added into exynos5_defconfig and
> it won't affect the other SoCs.

NACK.

As others explained, and you don't seem to understand or you are stubborn 
enough not to change your approach, resolving hardware differences at
compile time only is not acceptable, especially that Exynos SoCs are
going to be DT only platforms. We shouldn't be short-sighted like this.

Especially that the problem is relatively easy to solve at run-time, just 
add EXYNOS5_* register address definitions and create separate functions 
at the driver(s) touching those registers that changed on Exynos5.

Or parametrize existing ones with an offset that would be stored in driver 
data passed trough struct platform_device_id::driver_data.

@Jingoo: BTW, shouldn't we have 

plat-samsung/include/plat/regs-fb.h
plat-samsung/include/plat/regs-fb-v4.h

merged into one file and moved under include/video/ ?

For example include/video/s3c-fb.h, and board files could also include
that header. We have FIMD variant structures anyway, so why do we still
need multiple headers ?

--

Regards,
Sylwester
