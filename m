From: vz@mleia.com (Vladimir Zapolskiy)
Date: Thu, 30 Jul 2015 03:06:30 +0300
Subject: [PATCH] ARM: EXYNOS: pd: fix resource deallocation on error path
In-Reply-To: <CAJKOXPeWgXR0SuRzZyXHSiewZDuuJXXFmjyWasXDFxDAQUzyqA@mail.gmail.com>
References: <1438200913-10532-1-git-send-email-vz@mleia.com>
 <CAJKOXPeWgXR0SuRzZyXHSiewZDuuJXXFmjyWasXDFxDAQUzyqA@mail.gmail.com>
Message-ID: <55B96A86.8000502@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.07.2015 02:37, Krzysztof Kozlowski wrote:
> 2015-07-30 5:15 GMT+09:00 Vladimir Zapolskiy <vz@mleia.com>:
>> The change fixes a bug introduced by 2be2a3ff42a5, memory allocated
>> by kstrdup_const() must be always deallocated with kfree_const(),
>> otherwise there is a risk of kfree'ing ro memory.
> 
> This looks good. Can you provide also Cc-stable and fixes tags?

Since the change fixes two independent issues I decided not to add a
particular commit to Fixes tag. I can split the commit of course, but I
feel reluctant to send a series in this particular case.

Let me know your decision with respect to my comments.

>>
>> Also remove unneeded of_node_put(), if for_each_compatible_node() body
>> execution is not terminated, this prevents from double kfree() in
>> OF_DYNAMIC build.
> 
> Each iteration of for_each_compatible_node() has a check:
> (dn = of_find_compatible_node(dn, type, compatible))
> this increases the references to 'np'. 

Correct.

> If loop continues then previous 'np' is not of_node_put().

This I don't understand. The previous 'np' is of_node_put() on next
iteration of the loop, i.e. if and only if loop continues. Please elaborate.

--
With best wishes,
Vladimir

> 
>>
>> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
>> ---
>>  arch/arm/mach-exynos/pm_domains.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
>> index 6001f1c..4a87e86 100644
>> --- a/arch/arm/mach-exynos/pm_domains.c
>> +++ b/arch/arm/mach-exynos/pm_domains.c
>> @@ -146,9 +146,8 @@ static __init int exynos4_pm_init_power_domain(void)
>>                 pd->base = of_iomap(np, 0);
>>                 if (!pd->base) {
>>                         pr_warn("%s: failed to map memory\n", __func__);
>> -                       kfree(pd->pd.name);
>> +                       kfree_const(pd->pd.name);
>>                         kfree(pd);
>> -                       of_node_put(np);
>>                         continue;
>>                 }
>>
>> --
>> 2.1.4
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
