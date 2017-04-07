From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 7 Apr 2017 14:24:12 +0200
Subject: [PATCH v9 02/12] ARM: EXYNOS: remove usage of soc_is_exynosMMMM
 from pm.c
In-Reply-To: <6cf529ca-a28a-6757-39aa-5ef2e5391e16@samsung.com>
References: <CGME20170330131421epcas5p40b0ad9c1003d3ab807667ae2b05d25bc@epcas5p4.samsung.com>
 <1490879826-16754-1-git-send-email-pankaj.dubey@samsung.com>
 <1490879826-16754-3-git-send-email-pankaj.dubey@samsung.com>
 <CAJKOXPcDO_4JonsxoywQq_D_AcWQsP8NnAsFMw1VsAhOgjLW0g@mail.gmail.com>
 <6cf529ca-a28a-6757-39aa-5ef2e5391e16@samsung.com>
Message-ID: <CAJKOXPf0O_3CZY5terJ7Vtu9yhf6AwD5ACOBuCrpTNa9Etd=5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 7, 2017 at 2:12 PM, pankaj.dubey <pankaj.dubey@samsung.com> wrote:
>
>
> On Friday 07 April 2017 01:54 PM, Krzysztof Kozlowski wrote:
>> On Thu, Mar 30, 2017 at 3:16 PM, Pankaj Dubey <pankaj.dubey@samsung.com> wrote:
>>> soc_is_exynosMMMM is staged for removal after adopting to exynos-chipid
>>> driver, so let's remove/minimize usage of any such helper function usage
>>> from pm.c.
>>>
>>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>>> ---
>>>  arch/arm/mach-exynos/pm.c                   | 22 ++++++++++++----------
>>>  include/linux/soc/samsung/exynos-regs-pmu.h |  3 +++
>>>  2 files changed, 15 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
>>> index 1a7e5b5..4a73b02 100644
>>> --- a/arch/arm/mach-exynos/pm.c
>>> +++ b/arch/arm/mach-exynos/pm.c
>>> @@ -123,11 +123,13 @@ int exynos_pm_central_resume(void)
>>>  }
>>>
>>>  /* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
>>> -static void exynos_set_wakeupmask(long mask)
>>> +static void exynos_set_wakeupmask(void)
>>>  {
>>> -       pmu_raw_writel(mask, S5P_WAKEUP_MASK);
>>> -       if (soc_is_exynos3250())
>>> +       if (of_machine_is_compatible("samsung,exynos3250")) {
>>> +               pmu_raw_writel(EXYNOS3_WAKEUP_MASK_VAL, S5P_WAKEUP_MASK);
>>>                 pmu_raw_writel(0x0, S5P_WAKEUP_MASK2);
>>> +       } else
>>> +               pmu_raw_writel(EXYNOS_WAKEUP_MASK_VAL, S5P_WAKEUP_MASK);
>>
>> You need {} around this too. Checkpatch should complain about it as
>> well so be sure to run it.
>>
>
> I ran checkpatch before posting, but it didn't complain about this. Here
> is the result when I ran it again today on the same patch.
>
> ./scripts/checkpatch.pl
> exynos-chipid-v9/0002-ARM-EXYNOS-remove-usage-of-soc_is_exynosMMMM-from-pm.patch
>
> total: 0 errors, 0 warnings, 81 lines checked
>
> exynos-chipid-v9/0002-ARM-EXYNOS-remove-usage-of-soc_is_exynosMMMM-from-pm.patch
> has no obvious style problems and is ready for submission.

Ahh, okay, my bad. :)
But anyway please fix it.

Best regards,
Krzysztof
