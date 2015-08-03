From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 03 Aug 2015 20:15:13 +0900
Subject: [PATCH v3 3/5] ARM: Exynos: switch to using generic cpufreq driver
 for Exynos4x12
In-Reply-To: <4532306.AVvo5hem3c@amdc1976>
References: <1438368557-2352-1-git-send-email-b.zolnierkie@samsung.com>
 <5201904.0cZWHobiJs@amdc1976> <20150803102926.GA21529@linux>
 <4532306.AVvo5hem3c@amdc1976>
Message-ID: <55BF4D41.1060903@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 03.08.2015 o 19:36, Bartlomiej Zolnierkiewicz pisze:
> On Monday, August 03, 2015 03:59:26 PM Viresh Kumar wrote:
>> On 03-08-15, 12:17, Bartlomiej Zolnierkiewicz wrote:
>>>
>>> Hi,
>>>
>>> On Saturday, August 01, 2015 04:47:21 PM Viresh Kumar wrote:
>>>> On 31-07-15, 20:49, Bartlomiej Zolnierkiewicz wrote:
>>>>> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
>>>>> index 659879a..bf6d596 100644
>>>>> --- a/drivers/cpufreq/Kconfig
>>>>> +++ b/drivers/cpufreq/Kconfig
>>>>> @@ -191,6 +191,7 @@ config CPUFREQ_DT
>>>>>  	# if CPU_THERMAL is on and THERMAL=m, CPUFREQ_DT cannot be =y:
>>>>>  	depends on !CPU_THERMAL || THERMAL
>>>>>  	select PM_OPP
>>>>> +	select EXYNOS_THERMAL if ARCH_EXYNOS
>>>>>  	help
>>>>>  	  This adds a generic DT based cpufreq driver for frequency management.
>>>>>  	  It supports both uniprocessor (UP) and symmetric multiprocessor (SMP)
>>>>
>>>> No, we shouldn't pollute generic Kconfig options with platform specific stuff.
>>>
>>> The old code depended on this.  You couldn't enable boost support
>>> without enabling thermal support (ARM_EXYNOS_CPU_FREQ_BOOST_SW
>>> config option selected EXYNOS_THERMAL).
>>>
>>>> Why don't you enable thermal in your .config?
>>>
>>> It is enabled in exynos_defconfig but without the above change it
>>> can disabled manually which is something that we don't want.
>>
>> You are not getting it. I am not asking you to not select thermal, but
>> to select it from within your architecture Kconfig option if you want.
> 
> OK.  Krzysztof/Kukjin do you agree with selecting EXYNOS_THERMAL
> from ARCH_EXYNOS in the platform code?

I agree, with your explanation it seems good. Can you just add this
justification to the commit message?

> 
>> Over that, thermal is really an option, not a dependency. So, if
>> someone manually disables it, its his problem not yours :)
> 
> I would really like it to be dependency not an option (+ I think
> that ideally it should be checked at runtime, IOW we should be
> checking from cpufreq-dt driver if the thermal support is enabled
> before enabling boost support).

That would be the best. It is fine with me if you want to do this in
consecutive patches (after applying patch selecting/depending on it in
mach-exynos code).

Best regards,
Krzysztof
