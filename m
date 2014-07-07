From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Mon, 7 Jul 2014 19:07:40 +0530
Subject: [PATCH] ARM: dts: remove display power domain for exynos5420
In-Reply-To: <CAPdUM4OK+ATMMRM67dV5JeeTGMu=XA7Gvi7Uif+Hypf3iP+6jg@mail.gmail.com>
References: <1402313299-18885-1-git-send-email-rahul.sharma@samsung.com>
 <CAPdUM4OVjRSqVdQDUJZR7vGm1uUEYr31s-tx7Oxs8tM_xc2v7g@mail.gmail.com>
 <53A12EA3.5010007@samsung.com>
 <CAPdUM4OK+ATMMRM67dV5JeeTGMu=XA7Gvi7Uif+Hypf3iP+6jg@mail.gmail.com>
Message-ID: <CAPdUM4MToVJC5KRS1DUDmYEdUx2PGBE0G1v7p-SGgqpw7SPOhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrej, Inki,

On 18 June 2014 12:06, Rahul Sharma <rahul.sharma@samsung.com> wrote:
> Hi Andrej,
>
> On 18 June 2014 11:46, Andrzej Hajda <a.hajda@samsung.com> wrote:
>> On 06/17/2014 07:49 AM, Rahul Sharma wrote:
>>> Hi All,
>>>
>>> Please review this patch.
>>>
>>> Regards,
>>> Rahul Sharma
>>>
>>> On 9 June 2014 16:58, Rahul Sharma <rahul.sharma@samsung.com> wrote:
>>>> Display domain is removed due to instability issues. Explaining
>>>> the problem below:
>>>>
>>>> exynos_init_late triggers the pm_genpd_poweroff_unused which
>>>> powers off the unused power domains. This call hits before
>>>> the trigger to deferred probes.
>>>>
>>>> DRM DP Panel defers the probe due to supply get failure. By the
>>>> time, deferred probe is scheduled again, Display Power Domain is
>>>> powered off by pm_genpd_poweroff_unused.
>>>>
>>>> FIMD and DP drivers are accessing registers during Probe and Bind
>>>> callbacks. If display domain is enabled/disabled around register
>>>> accesses, display domain gets unstable and we are getting Power
>>>> Domain Disable fail notification. Increasing the Timeout also
>>>> didn't help.
>>
>> As I understand the problem is that fimd and dp drivers access hw
>> registers without enabling power domain. So the proper solution is to
>> fix these drivers.
>
> That is also a problem but I fixed those accesses in my local kernel before
> hitting this issue. If we do register accesses in FIMD/DP probe/bind we
> observes "Prefetch abort" exception. But here the problem is that 'DP
> domain disable' starts failing if we enable/disable multiple times.
>
>>
>> Btw. there are already patches removing hw access from probe/bind of
>> fimd. I guess removing also hw access from dp probe/bind could be a good
>> solution.
>
> Please let me know the links for posted patches. I will test with those patches.

Is there any update on this? Please share the patches which fixes the
above issue or avoid the above scenario of multiple PM Domain enable/disable.
I will test them for exynos5 based boards. Otherwise we should get this change
merged else display will remain broken for exynos5 based boards.

Regards,
Rahul Sharma.

>
> Regards,
> Rahul Sharma
>
>>
>> Regards
>> Andrzej
>>
>>>>
>>>> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
>>>> ---
>>>> based on Kukjin's for-next branch.
>>>>
>>>>  arch/arm/boot/dts/exynos5420.dtsi |    6 ------
>>>>  1 file changed, 6 deletions(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
>>>> index e385322..3d528cf 100644
>>>> --- a/arch/arm/boot/dts/exynos5420.dtsi
>>>> +++ b/arch/arm/boot/dts/exynos5420.dtsi
>>>> @@ -262,11 +262,6 @@
>>>>                 reg = <0x10044060 0x20>;
>>>>         };
>>>>
>>>> -       disp_pd: power-domain at 100440C0 {
>>>> -               compatible = "samsung,exynos4210-pd";
>>>> -               reg = <0x100440C0 0x20>;
>>>> -       };
>>>> -
>>>>         msc_pd: power-domain at 10044120 {
>>>>                 compatible = "samsung,exynos4210-pd";
>>>>                 reg = <0x10044120 0x20>;
>>>> @@ -518,7 +513,6 @@
>>>>         };
>>>>
>>>>         fimd: fimd at 14400000 {
>>>> -               samsung,power-domain = <&disp_pd>;
>>>>                 clocks = <&clock CLK_SCLK_FIMD1>, <&clock CLK_FIMD1>;
>>>>                 clock-names = "sclk_fimd", "fimd";
>>>>         };
>>>> --
>>>> 1.7.9.5
>>>>
>>
