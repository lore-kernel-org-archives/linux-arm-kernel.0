From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 05 Aug 2014 21:53:00 +0200
Subject: [PATCH v5 1/3] ARM: EXYNOS: Move code from hotplug.c to platsmp.c
In-Reply-To: <1407251006.9849.8.camel@AMDC1943>
References: <1407235425-13937-1-git-send-email-k.kozlowski@samsung.com>
 <53E0EE32.7060500@linaro.org> <1407251006.9849.8.camel@AMDC1943>
Message-ID: <53E1361C.2070905@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.08.2014 17:03, Krzysztof Kozlowski wrote:
> On wto, 2014-08-05 at 16:46 +0200, Daniel Lezcano wrote:
>> On 08/05/2014 12:43 PM, Krzysztof Kozlowski wrote:
>>> Cleanup a little the SMP/hotplug code for Exynos by:
>>> 1. Moving completely all functions from hotplug.c into the platsmp.c;
>>> 2. Deleting the hotplug.c file.
>>>
>>> After recent cleanups (e.g. 75ad2ab28f0f "ARM: EXYNOS: use
>>> v7_exit_coherency_flush macro for cache disabling") there was only CPU
>>> power down related code in hotplug.c file. Keeping this file does not
>>> give any benefits.
>>>
>>> The commit only moves code around with one additional observable change:
>>> the hotplug.c was compiled with custom CFLAGS (-march=armv7-a). These
>>> CFLAGS are not necessary any more.
>>
>> What is the benefit of moving this code around ?
>>
>> Usually the cpu hotplug code is located in hotplug.c for most of the 
>> platforms, so why moving pm code inside platsmp ?
> 
> The benefits are:
> 
> 1. Less dependencies, cleaner code because platsmp.c is the only user of
> code located in hotplug.c. So the exynos_cpu_die() had to be declared in
> common.h.
> 
> 2. Less dependencies between modules after adding patch 3/3 [1] which
> introduces exynos_set_delayed_reset_assertion() function. The
> exynos_set_delayed_reset_assertion() is called by:
>  - cpu_leave_power (hotplug.c)
>  - platform_do_lowpower (hotplug.c)
>  - exynos_boot_secondary (platsmp.c)
> 
> so merging everything into one file seemed simpler and cleaner.

mach-exynos/hotplug.c does not have too much code right now and as
Krzysztof noticed the only user of functions from it is platsmp.c
anyway. We don't need to follow other machs in something that makes no
sense, so

Acked-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
