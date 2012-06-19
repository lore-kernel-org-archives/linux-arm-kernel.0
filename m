From: kmpark@infradead.org (Kyungmin Park)
Date: Tue, 19 Jun 2012 15:50:51 +0900
Subject: [RFC PATCH] ARM: Make a compile trustzone conditionally
In-Reply-To: <201206181410.39267.arnd@arndb.de>
References: <20120611051502.GA24030@july>
 <CAOesGMgGQMwQTUy2g-XSYFrQ-p+x9g2q8kAd-ZYq=TBgVFu0Zw@mail.gmail.com>
 <CAH9JG2X=15G6wDX5SGJkDEVohkQQkzfBoL3Qv7HVuBUMqYnwRg@mail.gmail.com>
 <201206181410.39267.arnd@arndb.de>
Message-ID: <CAH9JG2UwwvZTK+RptKQ+fmfAMHeqyXG=eo9bJN+JogGBDTgqNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/18/12, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 18 June 2012, Kyungmin Park wrote:
>> > I would prefer to see this handled by using the smp_ops patchset that
>> > Marc Zyngier has been posting instead, replacing the boot_secondary
>> > function pointer during early boot depending on whether trustzone is
>> > enabled or not.
>> I understand your request, but it's not only boot_secondary but also
>> exynos pm common code and so on.even more it's used at devfreq to
>> adjust the RAM bus timings.
>>
>> Now these files are covered.
>>
>
> Would it help to have a trustzone_ops structure with pointers to
> functions if needed, similar to but separate from smp_ops?
Here's real usages. I'm not sure it's possible since smc call is
vendor specific.

static int exynos4_cpu_suspend(unsigned long arg)
{
        outer_flush_all();

        /* issue the standby signal into the pm unit. */
        if (trustzone_enabled())
                exynos_smc(SMC_CMD_SLEEP, 0, 0, 0);
        else
                cpu_do_idle();

        /* we should never get past here */
        panic("sleep resumed to originator?");
}

static int exynos4_pm_add(struct device *dev, struct subsys_interface *sif)
{
        pm_cpu_prep = exynos4_pm_prepare;
        pm_cpu_sleep = exynos4_cpu_suspend;

        return 0;
}

static struct subsys_interface exynos4_pm_interface = {
        .name           = "exynos4_pm",
        .subsys         = &exynos4_subsys,
        .add_dev        = exynos4_pm_add,
};

static __init int exynos4_pm_drvinit(void)
{
        ..snip..
        return subsys_interface_register(&exynos4_pm_interface);
}
arch_initcall(exynos4_pm_drvinit);

In this case, it should be sepated two functions.

static int exynos4_cpu_suspend(unsigned long arg)
{
        outer_flush_all();

        /* issue the standby signal into the pm unit. */
        cpu_do_idle();

        /* we should never get past here */
        panic("sleep resumed to originator?");
}

static int exynos4_cpu_smc_suspend(unsigned long arg)
{
        outer_flush_all();

        exynos_smc(SMC_CMD_SLEEP, 0, 0, 0);

        /* we should never get past here */
        panic("sleep resumed to originator?");
}

but still we should check it's trustzone is enabled or not to assign
proper function into pm_cpu_suspend

I think it's different from smp_ops.

In case of resume it's similar situcation.

static void exynos4_pm_resume(void)
{
        ... snip ...
        if (trustzone_enabled()) {
                exynos_smc(SMC_CMD_C15RESUME, save_arm_register[0],
                           save_arm_register[1], 0);
        } else {
                /* Restore Power control register */
                tmp = save_arm_register[0];
                asm volatile ("mcr p15, 0, %0, c15, c0, 0"
                              : : "r" (tmp)
                              : "cc");

                /* Restore Diagnostic register */
                tmp = save_arm_register[1];
                asm volatile ("mcr p15, 0, %0, c15, c0, 1"
                              : : "r" (tmp)
                              : "cc");
        }
        ... snip ...
}

static struct syscore_ops exynos4_pm_syscore_ops = {
        .suspend        = exynos4_pm_suspend,
        .resume         = exynos4_pm_resume,
};

>
> Instead of checking for trustzone_enabled() in each place where
> we call into smc, we can have a generic implementation that
> we call for the disabled case, and provide a vendor specific
> version of that struct with functions that call into smp
> where necessary.
Okay I'll think it more to make it generic. BTW omap uses smc call at
l2x0 codes.

Thank you,
Kyungmin Park
>
> 	Arnd
>
