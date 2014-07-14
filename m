From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Mon, 14 Jul 2014 14:39:18 +0530
Subject: [PATCH] ARM: dts: remove display power domain for exynos5420
In-Reply-To: <CAPdUM4NGXDz-bX=qqzC7LXRE5fCapdHGZeUZ29Xov=P7VZykgg@mail.gmail.com>
References: <1402313299-18885-1-git-send-email-rahul.sharma@samsung.com>
 <CAPdUM4OVjRSqVdQDUJZR7vGm1uUEYr31s-tx7Oxs8tM_xc2v7g@mail.gmail.com>
 <53A12EA3.5010007@samsung.com>
 <CAPdUM4OK+ATMMRM67dV5JeeTGMu=XA7Gvi7Uif+Hypf3iP+6jg@mail.gmail.com>
 <CAPdUM4MToVJC5KRS1DUDmYEdUx2PGBE0G1v7p-SGgqpw7SPOhw@mail.gmail.com>
 <53BC0F8F.4010106@samsung.com>
 <CAPdUM4NGXDz-bX=qqzC7LXRE5fCapdHGZeUZ29Xov=P7VZykgg@mail.gmail.com>
Message-ID: <CAPdUM4P7sijj_-fa_Opuo73ugAW7coUDZ+UnSp_tnjkHacJFVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

Please consider this patch for your branch. This patch is important
for Display for Exynos5 boards.

Regards,
Rahul Sharma.

On 9 July 2014 17:00, Rahul Sharma <rahul.sharma@samsung.com> wrote:
> Hi Tomasz,
>
> On 8 July 2014 21:04, Tomasz Figa <t.figa@samsung.com> wrote:
>> Hi Rahul,
>>
>> On 07.07.2014 15:37, Rahul Sharma wrote:
>>> Hi Andrej, Inki,
>>>
>>> On 18 June 2014 12:06, Rahul Sharma <rahul.sharma@samsung.com> wrote:
>>>> Hi Andrej,
>>>>
>>>> On 18 June 2014 11:46, Andrzej Hajda <a.hajda@samsung.com> wrote:
>>>>> On 06/17/2014 07:49 AM, Rahul Sharma wrote:
>>>>>> Hi All,
>>>>>>
>>>>>> Please review this patch.
>>>>>>
>>>>>> Regards,
>>>>>> Rahul Sharma
>>>>>>
>>>>>> On 9 June 2014 16:58, Rahul Sharma <rahul.sharma@samsung.com> wrote:
>>>>>>> Display domain is removed due to instability issues. Explaining
>>>>>>> the problem below:
>>>>>>>
>>>>>>> exynos_init_late triggers the pm_genpd_poweroff_unused which
>>>>>>> powers off the unused power domains. This call hits before
>>>>>>> the trigger to deferred probes.
>>>>>>>
>>>>>>> DRM DP Panel defers the probe due to supply get failure. By the
>>>>>>> time, deferred probe is scheduled again, Display Power Domain is
>>>>>>> powered off by pm_genpd_poweroff_unused.
>>>>>>>
>>>>>>> FIMD and DP drivers are accessing registers during Probe and Bind
>>>>>>> callbacks. If display domain is enabled/disabled around register
>>>>>>> accesses, display domain gets unstable and we are getting Power
>>>>>>> Domain Disable fail notification. Increasing the Timeout also
>>>>>>> didn't help.
>>>>>
>>>>> As I understand the problem is that fimd and dp drivers access hw
>>>>> registers without enabling power domain. So the proper solution is to
>>>>> fix these drivers.
>>>>
>>>> That is also a problem but I fixed those accesses in my local kernel before
>>>> hitting this issue. If we do register accesses in FIMD/DP probe/bind we
>>>> observes "Prefetch abort" exception. But here the problem is that 'DP
>>>> domain disable' starts failing if we enable/disable multiple times.
>>>>
>>>>>
>>>>> Btw. there are already patches removing hw access from probe/bind of
>>>>> fimd. I guess removing also hw access from dp probe/bind could be a good
>>>>> solution.
>>>>
>>>> Please let me know the links for posted patches. I will test with those patches.
>>>
>>> Is there any update on this? Please share the patches which fixes the
>>> above issue or avoid the above scenario of multiple PM Domain enable/disable.
>>> I will test them for exynos5 based boards. Otherwise we should get this change
>>> merged else display will remain broken for exynos5 based boards.
>>
>> Andrzej is on holidays right now, so he won't be able to reply in this
>> thread until he's back. Here are two patches I was able to find on the
>> related MLs that might be fixing the cause of your issues:
>
> Ok. thanks for the update.
>
> We should test with Ajay's patches which includes DP probe deferring
> based on availability of bridge chip. +
>
> few patches which cleanup register access in FIMD and DP probe/bind
> OR
> few patches to enable Display power domain and clocks just before the
> register access. As done in https://lkml.org/lkml/2014/7/4/188.
>
> Later solution results into display power domain enable failure in case of DRM
> probe defer.
>
> I am just curious if Andrej has some solution for the first approach which can
> be tested for defer probe and S2R scenarios.
>
> Regards,
> Rahul Sharma.
>
>>
>> [PATCH] drm/exynos: remove hardware overlays disable from fimd probe
>> (https://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg31629.html)
>>
>> [PATCH] drm/exynos: fimd: Keep power enabled during fimd_bind
>> (https://lkml.org/lkml/2014/7/4/188)
>>
>> Best regards,
>> Tomasz
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
