From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 14 Sep 2015 10:24:35 +0900
Subject: [PATCHv2] ARM: EXYNOS: reset Little cores when cpu is up
In-Reply-To: <55E6AC57.4020208@samsung.com>
References: <1441117023-25478-1-git-send-email-parkch98@gmail.com>
 <55E63F8F.4020300@samsung.com> <55E64386.3000903@osg.samsung.com>
 <55E64559.7000105@samsung.com> <55E6A8F6.5020301@osg.samsung.com>
 <55E6AC57.4020208@samsung.com>
Message-ID: <55F621D3.3030207@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02.09.2015 16:59, Krzysztof Kozlowski wrote:
> On 02.09.2015 16:44, Javier Martinez Canillas wrote:
>> Hello Krzysztof,
>>
>> On 09/02/2015 02:39 AM, Krzysztof Kozlowski wrote:
>>> On 02.09.2015 09:32, Javier Martinez Canillas wrote:
>>>> Hello Krzysztof,
>>>>
>>>> On 09/02/2015 02:15 AM, Krzysztof Kozlowski wrote:
>>>>> On 01.09.2015 23:17, Chanho Park wrote:
>>>>>> The cpu booting of exynos5422 has been still broken since we discussed
>>>>>> it in last year[1]. This patch is inspired from Odroid XU3
>>>>>> code (Actually, it was from samsung exynos vendor kernel)[2]. This weird
>>>>>> reset code was founded exynos5420 octa cores series SoCs and only
>>>>>> required for the first boot core is the Little core (Cortex A7).
>>>>>> Some of the exynos5420 boards and all of the exynos5422 boards will require
>>>>>> this code.
>>>>>>
>>>>>> There is two ways to check the little core is the first cpu. One is
>>>>>> checking GPG2CON[1] GPIO value and the other is checking the cluster
>>>>>> number of the first cpu. I selected the latter because it's more easier
>>>>>> than the former.
>>>>>>
>>>>>> [1]:http://lists.infradead.org/pipermail/linux-arm-kernel/2015-June/350632.html
>>>>>> [2]:https://patchwork.kernel.org/patch/6782891/
>>>>>>
>>>>>> Cc: Kevin Hilman <khilman@kernel.org>
>>>>>> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
>>>>>> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>>>>> Tested-by: Kevin Hilman <khilman@linaro.org>
>>>>>> Signed-off-by: Chanho Park <parkch98@gmail.com>
>>>>>> ---
>>>>>> Changes from v1:
>>>>>>  .kfc to Little (Cortex A7) and eagle to big (Cortex A15)
>>>>>>  .append comments about waiting SPARE2 register
>>>>>>
>>>>>> Changes since RFC:
>>>>>>  .drop checking soc_is_exynos5800 to extend this codes to
>>>>>> exynos5420/5422 boards.
>>>>>>  .kfc cores will be reset only if the cpu0 is kfc core.
>>>>>>  .Rebase top of the kukjin's for-next branch
>>>>>>
>>>>>>  arch/arm/mach-exynos/mcpm-exynos.c | 25 ++++++++++++++++++++++++-
>>>>>>  arch/arm/mach-exynos/regs-pmu.h    |  6 ++++++
>>>>>>  2 files changed, 30 insertions(+), 1 deletion(-)
>>>>>
>>>>> Thanks for updating the patch. Remaining minor nit about comment style
>>>>> (/* on first line) can be fixed while applying.
>>>>>
>>>>> The patch works good, after disabling bL switcher I have 8 cores running:
>>>>>
>>>>> Tested on Odroid XU4:
>>>>> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>>>> Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>>>>
>>>>> It's 4.3 merge window so the patch will go probably to v4.4.
>>>>>
>>>>
>>>> Isn't this material for the v4.3 -rc cycle since it's fixing a bug
>>>> (CPUs not booting)? So I don't think that's necessary to wait for v4.4.
>>>
>>> It is a bug fix but:
>>> 1. Not a fix for regression introduced in current merge window,
>>
>> I thought the -rc cycle was for stabilization and fix not only regressions
>> introduced during the merge window but also long standing issues.
> 
> It's all subtle. Sometimes it also depends on the mood of maintainer...
> A lot of fixes for different issues are merged in -rc and in the same
> time they are rejected because they are too late and they don't fix
> regression from merge window. Anyway I used the argument #1 in
> combination with #2.
> 
> Best regards,
> Krzysztof
> 
>>
>>> 2. There may be more subtle issues like the one mentioned below, not
>>> found yet (probably no one tested it with all possible configurations),
>>>
>>
>> Right, this is indeed a better reason to wait for v4.4.
>>  
>>> so I don't think rushing with the patch to mainline is good idea.
>>>
>>
>> Yes, agreed.
>>  
>>> However your comment reminds me about stable. This actually looks like a
>>> candidate for stable.

I applied the patch to my repo marking it as stable backport for v4.1+.
Earlier kernels would require manual backporting/rebasing.

It should be in linux-next soon. Let's see how it turns out. If no one
complains than I actually agree with Javier's opinion of sending this to
v4.3.

Best regards,
Krzysztof
