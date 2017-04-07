From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 7 Apr 2017 16:18:32 +0200
Subject: [PATCH v9 09/12] ARM: EXYNOS: introduce exynos_cpu_info struct
In-Reply-To: <125999ed-afae-cd46-aae3-3139c7e94b02@samsung.com>
References: <CGME20170330131438epcas1p459ce93da17fcd05249eddaef18d5021e@epcas1p4.samsung.com>
 <1490879826-16754-1-git-send-email-pankaj.dubey@samsung.com>
 <1490879826-16754-10-git-send-email-pankaj.dubey@samsung.com>
 <CAJKOXPdWo_3Og-NuPRnzC3FgF2mGZup6+BC1_=9CUW-3dTz99w@mail.gmail.com>
 <125999ed-afae-cd46-aae3-3139c7e94b02@samsung.com>
Message-ID: <CAJKOXPcipwoHhkeeEPyJ2HOoCrnR_iJeFOOUf8JFKa2yR1hMTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 7, 2017 at 4:00 PM, pankaj.dubey <pankaj.dubey@samsung.com> wrote:
>
>
> On Friday 07 April 2017 04:11 PM, Krzysztof Kozlowski wrote:
>> On Thu, Mar 30, 2017 at 3:17 PM, Pankaj Dubey <pankaj.dubey@samsung.com> wrote:
>>> Various Exynos SoC has different CPU related information, such as CPU
>>> boot register, programming sequence making CPU up/down. Currently this
>>> is handled by adding lots of soc_is_exynosMMM checks in the code, in
>>> an attempt to remove the dependency of such helper functions specific to
>>> each SoC, let's separate this information pertaining to CPU by introducing
>>> a new "struct exynos_cpu_info". This struct will contain differences
>>> associated with CPU on various Exynos SoC. This can be matched by using
>>> generic API "soc_device_match".
>>>
>>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>>> ---
>>>  arch/arm/mach-exynos/platsmp.c | 146 +++++++++++++++++++++++++++++++++++++----
>>>  1 file changed, 135 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
>>> index cb6d199..ff369b9 100644
>>> --- a/arch/arm/mach-exynos/platsmp.c
>>> +++ b/arch/arm/mach-exynos/platsmp.c
>>> @@ -19,6 +19,7 @@
>>>  #include <linux/smp.h>
>>>  #include <linux/io.h>
>>>  #include <linux/of_address.h>
>>> +#include <linux/sys_soc.h>
>>>  #include <linux/soc/samsung/exynos-regs-pmu.h>
>>>
>>>  #include <asm/cacheflush.h>
>>> @@ -33,6 +34,16 @@
>>>
>>>  extern void exynos4_secondary_startup(void);
>>>
>>> +/*
>>> + * struct exynos_cpu_info - Exynos CPU related info/operations
>>> + * @cpu_boot_reg: computes cpu boot address for requested cpu
>>> + */
>>> +struct exynos_cpu_info {
>>> +       void __iomem* (*cpu_boot_reg)(u32 cpu);
>>> +};
>>
>> Beside Marek comments, I think we are getting too many structures for
>> differentiating Exynos. Actually all of them describe the same -
>> difference between Exynos revisions. Having many separate structures
>> means that you have to initialize all of them in different places in
>> different (probably) order. The good benefit is however making them
>> local (static) so the scope is limited... but anyway I dislike the
>> duplication.
>>
>
> OK, regarding duplication, only the way they are initialized is getting
> duplicated. But again, my long term goal was to remove dependency of
> pm.c and suspend.c from arm/mach-exynos/{exynos.c,platsmp.c} or common.h
> in mach-exynos. So that we could move these files as a Exynos Power
> Management driver in drivers/soc/ where we already moved pm_domain.c, as
> you see these three files pm.c, suspend.c and pm_domain.c are heavily
> dependent on PMU driver, and handles Power Management states.
>
> So I feel keeping CPU specific data separate from PM specific data makes
> sense and will help in moving these files as a platform driver one day?
>
> Surely I will work out and see how I can minimize duplication.

Hm, in that case it would make sense. However I am not quite sure what
is the benefit of moving this from arm/mach to drivers/soc. This code
will not be re-used on any other platform, unlike existing
drivers/soc/samsung drivers which are used also on ARMv8.

Best regards,
Krzysztof
