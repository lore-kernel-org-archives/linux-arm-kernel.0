From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 3 Nov 2015 12:08:53 +0100
Subject: [PATCH 20/22] clocksource/drivers/exynos_mct: Fix Kconfig and add
 COMPILE_TEST option
In-Reply-To: <9713489.TbNNoNQg5A@wuerfel>
References: <1446469011-22710-1-git-send-email-daniel.lezcano@linaro.org>
 <563806E7.6010105@samsung.com> <563872E2.10001@linaro.org>
 <9713489.TbNNoNQg5A@wuerfel>
Message-ID: <563895C5.9000502@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03/2015 11:02 AM, Arnd Bergmann wrote:
> On Tuesday 03 November 2015 09:40:02 Daniel Lezcano wrote:
>> On 11/03/2015 01:59 AM, Krzysztof Kozlowski wrote:
>>> On 03.11.2015 09:30, Krzysztof Kozlowski wrote:
>>>> On 02.11.2015 21:56, Daniel Lezcano wrote:
>>>>> Let the platform's Kconfig to select the clock instead of having a reverse
>>>>> dependency from the driver to the platform options.
>>>>
>>>> Selecting user-visible symbols is rather discouraged so why not
>>>> something like this:
>>>>
>>>> -       def_bool y if ARCH_EXYNOS
>>>> -       depends on !ARM64
>>>> +       bool "Exynos multi core timer driver"
>>>> +       depends on ARCH_EXYNOS || (COMPILE_TEST && ARM)
>>>
>>> Nope, that was wrong as we loose auto-select on Exynos. Instead:
>>> -       def_bool y if ARCH_EXYNOS
>>> -       depends on !ARM64
>>> +       bool "Exynos multi core timer driver" if ARM
>>> +       depends on ARCH_EXYNOS || COMPILE_TEST
>>> +       default y if ARCH_EXYNOS
>>>
>>> This way we avoid select (which is a reverse dependency for the driver),
>>> have it auto-selectable and compile tested on arm.
>>
>> I think you misunderstood the patch I sent.
>>
>> It does two things:
>>
>> 1. Follow the thumb of rule of the current Kconfig format
>>
>>      - The timer driver is selected by the platform (exynos in this case)
>>      - User can't select the driver in the menuconfig
>>      - There is no dependency on the platform except for compilation test
>>
>> 2. Add the COMPILE_TEST
>>
>>      - User can select the driver for compilation testing. This is for
>> allyesconfig when doing compilation test coverage (exynos timer could be
>> compiled on other platform). As the delay code is not portable, we have
>> to restrict the compilation on the ARM platform, this is why there is
>> the dependency on ARM.
>>
>> I am currently looking at splitting the delay code in order to prevent
>> this restriction on this driver and some others drivers.
>
> I suspect this will come up again in the future. The problem is
> really that drivers/clocksource has different rules from almost
> everything else, by requiring the platform to 'select' the driver.
>
> The second version that Krzysztof posted is how we handle this in
> other driver subsystems, and I would generally prefer it to do this
> consistently for everything, but John Stultz has in the past argued
> strongly for using 'select' in all clocksource drivers. The reason
> is that for each platform we know in advance which driver we want,
> and there is never a need for the user to have to select the right
> one.

Yes, and I second John in this.



-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
