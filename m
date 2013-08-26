From: amit.daniel@samsung.com (amit daniel kachhap)
Date: Mon, 26 Aug 2013 17:48:35 +0530
Subject: [GIT PULL 3/3] 2nd Round Samsung mach-exynos for v3.12
In-Reply-To: <4070794.XxjluIqBpK@amdc1032>
References: <1f7701cea1f1$431f2d30$c95d8790$%kim@samsung.com>
 <3145165.ZB7l3vNJ7a@amdc1032>
 <CADGdYn7_Gm7rwkhRSUmvktB_hHNboY8eB5fi8E62-Br5Vk5D0A@mail.gmail.com>
 <4070794.XxjluIqBpK@amdc1032>
Message-ID: <CADGdYn7YWscQ_EOqjbq29pNHvoxa0qqXHZeOBuz-Wi22H=Dc_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Submitted the V2 version of this patch with your suggestion.

Thanks
Amit

On Mon, Aug 26, 2013 at 4:49 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> On Monday, August 26, 2013 04:33:55 PM amit daniel kachhap wrote:
>> Hi,
>>
>> On Mon, Aug 26, 2013 at 3:36 PM, Bartlomiej Zolnierkiewicz
>> <b.zolnierkie@samsung.com> wrote:
>> >
>> > Hi,
>> >
>> > On Monday, August 26, 2013 09:14:42 AM Kukjin Kim wrote:
>> >> The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:
>> >>
>> >>   Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)
>> >>
>> >> are available in the git repository at:
>> >>
>> >>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
>> >> tags/samsung-mach-exynos
>> >>
>> >> for you to fetch changes up to f52616f4233d71d0fb00f06f86d046d18d2b7f3b:
>> >>
>> >>   ARM: EXYNOS: always enable PM domains support for EXYNOS4X12 (2013-08-19
>> >> 05:05:16 +0900)
>> >>
>> >> ----------------------------------------------------------------
>> >> update mach-exynos
>> >> - enable ARCH_HAS_BANDGAP for exynos SoCs
>> >> - skip C1 cpuidle for exynos5440 because non-supporting
>> >> - always enable PM domains for exynos4x12
>> >>
>> >> ----------------------------------------------------------------
>> >> Amit Daniel Kachhap (2):
>> >>       ARM: EXYNOS: enable ARCH_HAS_BANDGAP
>> >>       ARM: EXYNOS: Skip C1 cpuidle state for exynos5440
>> >
>> > The patch "ARM: EXYNOS: Skip C1 cpuidle state for exynos5440":
>> >
>> > --- a/arch/arm/mach-exynos/cpuidle.c
>> > +++ b/arch/arm/mach-exynos/cpuidle.c
>> > @@ -210,7 +210,7 @@ static int __init exynos4_init_cpuidle(void)
>> >                 device->cpu = cpu_id;
>> >
>> >                 /* Support IDLE only */
>> > -               if (cpu_id != 0)
>> > +               if (soc_is_exynos5440() || cpu_id != 0)
>> >                         device->state_count = 1;
>> >
>> >                 ret = cpuidle_register_device(device);
>> >
>> > is incorrect as noted a month ago in:
>> >
>> > http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/186355.html
>> >
>> > [ Because of the deficiency in the core cpuidle core (device->state_count
>> >   not being used by governors' code) only sysfs entries for C1 state will be
>> >   disabled and EXYNOS cpuidle driver will still attempt to use C1 state.
>> >
>> > also non-working device->state_count is planned to be removed by:
>> >
>> > http://permalink.gmane.org/gmane.linux.power-management.general/37390
>> I looked at your patch series and it seems reasonable. I will repost
>> this patch on top of yours.
>
> If you correctly use driver's state_count (instead of device's) there will be
> no dependency on my patch series and the new patch can be applied immediately.
>
>> But I suggest to keep this patch temporary till your patch series gets merged.
>
> The current patch (the one Kukjin merged) is incorrect as it just doesn't
> do what it advertises. I see no reason to keep it.
>
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
>
>> Thanks,
>> Amit Daniel
>> >
>> >
>> > To disable C1 state on EXYNOS5440 something like:
>> >
>> >         static int __init exynos4_init_cpuidle(void)
>> >         {
>> >         ...
>> >                 if (soc_is_exynos5440())
>> >                         exynos4_idle_driver.state_count = 1;
>> >         ...
>> >         }
>> >
>> > should be done instead.
>> >
>> > Best regards,
>> > --
>> > Bartlomiej Zolnierkiewicz
>> > Samsung R&D Institute Poland
>> > Samsung Electronics
>> >
>> >
>> > _______________________________________________
>> > linux-arm-kernel mailing list
>> > linux-arm-kernel at lists.infradead.org
>> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>>
>> On Mon, Aug 26, 2013 at 3:36 PM, Bartlomiej Zolnierkiewicz
>> <b.zolnierkie@samsung.com> wrote:
>> >
>> > Hi,
>> >
>> > On Monday, August 26, 2013 09:14:42 AM Kukjin Kim wrote:
>> >> The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:
>> >>
>> >>   Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)
>> >>
>> >> are available in the git repository at:
>> >>
>> >>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
>> >> tags/samsung-mach-exynos
>> >>
>> >> for you to fetch changes up to f52616f4233d71d0fb00f06f86d046d18d2b7f3b:
>> >>
>> >>   ARM: EXYNOS: always enable PM domains support for EXYNOS4X12 (2013-08-19
>> >> 05:05:16 +0900)
>> >>
>> >> ----------------------------------------------------------------
>> >> update mach-exynos
>> >> - enable ARCH_HAS_BANDGAP for exynos SoCs
>> >> - skip C1 cpuidle for exynos5440 because non-supporting
>> >> - always enable PM domains for exynos4x12
>> >>
>> >> ----------------------------------------------------------------
>> >> Amit Daniel Kachhap (2):
>> >>       ARM: EXYNOS: enable ARCH_HAS_BANDGAP
>> >>       ARM: EXYNOS: Skip C1 cpuidle state for exynos5440
>> >
>> > The patch "ARM: EXYNOS: Skip C1 cpuidle state for exynos5440":
>> >
>> > --- a/arch/arm/mach-exynos/cpuidle.c
>> > +++ b/arch/arm/mach-exynos/cpuidle.c
>> > @@ -210,7 +210,7 @@ static int __init exynos4_init_cpuidle(void)
>> >                 device->cpu = cpu_id;
>> >
>> >                 /* Support IDLE only */
>> > -               if (cpu_id != 0)
>> > +               if (soc_is_exynos5440() || cpu_id != 0)
>> >                         device->state_count = 1;
>> >
>> >                 ret = cpuidle_register_device(device);
>> >
>> > is incorrect as noted a month ago in:
>> >
>> > http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/186355.html
>> >
>> > [ Because of the deficiency in the core cpuidle core (device->state_count
>> >   not being used by governors' code) only sysfs entries for C1 state will be
>> >   disabled and EXYNOS cpuidle driver will still attempt to use C1 state.
>> >
>> > also non-working device->state_count is planned to be removed by:
>> >
>> > http://permalink.gmane.org/gmane.linux.power-management.general/37390
>> >
>> >
>> > To disable C1 state on EXYNOS5440 something like:
>> >
>> >         static int __init exynos4_init_cpuidle(void)
>> >         {
>> >         ...
>> >                 if (soc_is_exynos5440())
>> >                         exynos4_idle_driver.state_count = 1;
>> >         ...
>> >         }
>> >
>> > should be done instead.
>> >
>> > Best regards,
>> > --
>> > Bartlomiej Zolnierkiewicz
>> > Samsung R&D Institute Poland
>> > Samsung Electronics
>> >
>> >
>> > _______________________________________________
>> > linux-arm-kernel mailing list
>> > linux-arm-kernel at lists.infradead.org
>> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
