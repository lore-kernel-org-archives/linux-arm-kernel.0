From: kmpark@infradead.org (Kyungmin Park)
Date: Mon, 18 Jun 2012 13:37:48 +0900
Subject: [RFC PATCH] ARM: Make a compile trustzone conditionally
In-Reply-To: <CAOesGMgGQMwQTUy2g-XSYFrQ-p+x9g2q8kAd-ZYq=TBgVFu0Zw@mail.gmail.com>
References: <20120611051502.GA24030@july>
 <CAOesGMgGQMwQTUy2g-XSYFrQ-p+x9g2q8kAd-ZYq=TBgVFu0Zw@mail.gmail.com>
Message-ID: <CAH9JG2X=15G6wDX5SGJkDEVohkQQkzfBoL3Qv7HVuBUMqYnwRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On 6/18/12, Olof Johansson <olof@lixom.net> wrote:
> On Sun, Jun 10, 2012 at 10:15 PM, Kyungmin Park <kmpark@infradead.org>
> wrote:
>> From: Kyungmin Park <kyungmin.park@samsung.com>
>>
>> Some boards can use the trustzone but others can't use trustzone.
>> However we need to build it simultaneously. To address this issue,
>> introduce arm trustzone support and use it at each board files.
>>
>> e.g., In boot_secondary at mach-exynos/platsmp.c
>>
>>        __raw_writel(virt_to_phys(exynos4_secondary_startup),
>>                CPU1_BOOT_REG);
>>
>>        if (trustzone_enabled()) {
>>                /* Call Exynos specific smc call */
>>                /* exynos_smc(SMC_CMD_CPU1BOOT, cpu, 0, 0); */
>>        }
>>
>>        gic_raise_softirq(cpumask_of(cpu), 1);
>>
>>        if (pen_release == -1)
>
> I would prefer to see this handled by using the smp_ops patchset that
> Marc Zyngier has been posting instead, replacing the boot_secondary
> function pointer during early boot depending on whether trustzone is
> enabled or not.
I understand your request, but it's not only boot_secondary but also
exynos pm common code and so on.even more it's used at devfreq to
adjust the RAM bus timings.

Now these files are covered.

arch/arm/mach-exynos/cpu-exynos4.c
arch/arm/mach-exynos/cpu-exynos5.c
arch/arm/mach-exynos/cpuidle-exynos4.c
arch/arm/mach-exynos/cpuidle-exynos5.c
arch/arm/mach-exynos/idle-exynos4.S
arch/arm/mach-exynos/idle-exynos5.S
arch/arm/mach-exynos/include/mach/entry-macro.S
arch/arm/mach-exynos/platsmp.c
arch/arm/mach-exynos/pm-exynos4.c
arch/arm/mach-exynos/pm-exynos5.c
arch/arm/mach-exynos/sleep-exynos4.S
arch/arm/mach-exynos/sleep-exynos5.S
arch/arm/mach-exynos/tmu.c

How do you think?

Thank you,
Kyungmin Park
