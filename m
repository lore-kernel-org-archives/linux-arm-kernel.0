From: alim.akhtar@gmail.com (Alim Akhtar)
Date: Mon, 19 Oct 2015 21:43:33 +0530
Subject: [PATCH 7/7] ARM: EXYNOS: Remove code for restart and poweroff for
 exynos SoCs
In-Reply-To: <5624F932.7030001@osg.samsung.com>
References: <1445234635-3950-1-git-send-email-alim.akhtar@samsung.com>
 <1445234635-3950-8-git-send-email-alim.akhtar@samsung.com>
 <562494F8.6070003@samsung.com> <5624BE39.7020605@osg.samsung.com>
 <CAJKOXPcvKeDNwof5eyD5XjzUiZrHoyShD8gOPGo7uUxEyypQbw@mail.gmail.com>
 <5624F932.7030001@osg.samsung.com>
Message-ID: <CAGOxZ53k5Nftc=YgTnow382S2mG51yiLO4RmkMM8fONBB4GnCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On Mon, Oct 19, 2015 at 7:37 PM, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
> Hello Krzysztof,
>
> On 10/19/2015 03:28 PM, Krzysztof Kozlowski wrote:
>> 2015-10-19 18:56 GMT+09:00 Javier Martinez Canillas <javier@osg.samsung.com>:
>>> Hello,
>>>
>>> On 10/19/2015 09:00 AM, Krzysztof Kozlowski wrote:
>>>> On 19.10.2015 15:03, Alim Akhtar wrote:
>>>>> Now we can use the generic syscon-{reboot/poweroff} drivers,
>>>>> so we don't need special handling for reboot/poweroff in
>>>>> exynos pmu driver. This patch remove the same.
>>>>>
>>>>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>>>>> ---
>>>>>  arch/arm/mach-exynos/pmu.c |   43 -------------------------------------------
>>>>>  1 file changed, 43 deletions(-)
>>>>
>>>> I think that removal of this stuff will effectively remove the
>>>> restart/poweroff handlers from:
>>>> 1. Other defconfigs, like multi_v7
>>>> 2. Custom configs.
>>>>
>>>
>>> This will also break old DTBs that don't have a "syscon-poweroff" device
>>> node that contains the necessary PMU regmap, offset and mask information.
>>
>> I am not sure whether this is ABI break issue. There was no compatible
>> mentioning that "reset works" which now would be replaced. The
>> existing PMU compatible (like samsung,exynos4412-pmu) does not mention
>> "reset" as a feature coming with this compatible.
>>
>> So no ABI break.
>>
>>
>
> I deliberately didn't use the "DT ABI break" expression since as you said is
> not part of the documented DT bindings. But what I said is that this change
> will break old DTBs with newer kernels since reboot and power off will stop
> working after $SUBJECT.
>
> I'm not a particular fan of the stable DT idea since in practice it seems to
> do more harm than good but since that was decided, the expectation for users
> is that booting a new kernel with an old DT should not cause any regression.
>
> So I think that at least a comment in the commit message is needed so if
> there are people really using old DTs with newer kernels on Exynos boards,
> they can know that the commit causes such an issue instead of having to
> figure it out themselves.
>
Agree, will add a comment about this in commit message.

>>>
>>>> Previously this code was always compiled in for ARCH_EXYNOS. Now it is
>>>> not so I am thinking about selecting necessary drivers from main exynos
>>>> Kconfig symbol. That could be tricky though, because "select" should be
>>>> used only for non-visible symbols.
>>>>
>>>> Any ideas how to solve that?
>>>>
>>>
>>> Is true that select should only be used for non-visible symbols but there
>>> are others user visible symbols that are selected by ARCH_EXYNOS such as
>>> EXYNOS_THERMAL. So I think selecting the regmap syscon reset stuff there
>>> is a sensible option.
>>
>> Selecting from defconfig is not sufficient... since I do not have
>> other idea than selecting then ovak, but Alim please check it whether
>> it does not create circular dependencies on various configs.
>>
>
> Agreed, Kconfig circular dependencies is the reason why select is avoided.
> Fortunately now the 0-day bot analyzes even posted patches so it's possible
> that such an issue could be found even before these patches are merged.
>
ok..will select it from mach-exynos/Kconfig.
Thanks.

>> Best regards,
>> Krzysztof
>>
>
> Best regards,
> --
> Javier Martinez Canillas
> Open Source Group
> Samsung Research America
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards,
Alim
