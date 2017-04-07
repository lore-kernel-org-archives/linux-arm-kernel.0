From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 7 Apr 2017 16:57:12 +0200
Subject: [PATCH v9 07/12] ARM: EXYNOS: introduce soc specific pm ops
In-Reply-To: <fc69a6fa-7cb2-478b-b346-c59039c2b8da@samsung.com>
References: <CGME20170330131434epcas1p4e42fe06bae3456c39e0f93a2f8ae4bc0@epcas1p4.samsung.com>
 <1490879826-16754-1-git-send-email-pankaj.dubey@samsung.com>
 <1490879826-16754-8-git-send-email-pankaj.dubey@samsung.com>
 <CAJKOXPckh9C-mSq5NsJJfSW-brs6=wTDuctkD2EbtQOjKOQgbg@mail.gmail.com>
 <fc69a6fa-7cb2-478b-b346-c59039c2b8da@samsung.com>
Message-ID: <CAJKOXPf0wyZiu-dfTKeW=DX=SboO2x5Y5Xy6a4Vzs3uEHgaqQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 7, 2017 at 4:11 PM, pankaj.dubey <pankaj.dubey@samsung.com> wrote:

(...)

>>> +int __init exynos_s2r_init(void)
>>> +{
>>> +       const struct soc_device_attribute *match;
>>> +
>>> +       match = soc_device_match(exynos_soc_revision);
>>> +
>>> +       if (match)
>>> +               s2r_data = (const struct exynos_s2r_data *) match->data;
>>> +
>>> +       if (!s2r_data)
>>> +               return -ENODEV;
>>> +
>>> +       return 0;
>>> +}
>>> +arch_initcall(exynos_s2r_init);
>>> +
>>
>> I guess you already found possible probe-order issue. You should
>> register all of this after having the soc chipid driver. However it is
>> required by cpuidle driver which is being registered in machine_init()
>> call....  You cannot use deferred probe here, so maybe the only way is
>> to manually order the calls in machine_init():
>> 1. exynos_chipid_early_init()
>> 2. this one.
>> 3. cpuidle driver register.
>>
>
> exynos_s2r_init is not required during early stage of boot, so as Arnd
> suggested I can drop arch_initcall here and probably go for
>
> 1: late_init
> 2: Call this directly from machine_init

I think this will be used on first AFTR which might happen few moments
after exynos_dt_machine_init() because it registers the cpuidle
platform devices thus probing them. This is before late_init. You
might call it from machine_init, but again mind the order.

>
> I prefer first option, as I mentioned my long term plan to move these
> files out of arch/arm/mach-exynos/ and if I call it from mach-exynos,
> then while moving I have to make this function as export symbol or make
> it extern so that mach-exynos/exynos.c should be able to access it. Both
> of these approaches have been rejected in past. What do you say?

Because of the cpuidle I think late_initcall is too late.

Best regards,
Krzysztof
