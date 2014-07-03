From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Fri, 4 Jul 2014 01:30:50 +0530
Subject: several messages
In-Reply-To: <alpine.LFD.2.11.1407031442210.6220@knanqh.ubzr>
References: <1404363737-26222-1-git-send-email-a.kesavan@samsung.com>
 <1404398818-6859-1-git-send-email-a.kesavan@samsung.com>
 <alpine.LFD.2.11.1407031111100.6220@knanqh.ubzr>
 <CAM4voanVAA4KOHWemQf59WjBpZXxVG_0P49xfzeq8KOvOwg4xg@mail.gmail.com>
 <alpine.LFD.2.11.1407031442210.6220@knanqh.ubzr>
Message-ID: <CAM4voamgOkJ5+OgX577YrGJc3gdxQAcWYkQziw9Uv92PJQAgRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Fri, Jul 4, 2014 at 12:30 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Thu, 3 Jul 2014, Abhilash Kesavan wrote:
>
>> Hi Nicolas,
>>
>> On Thu, Jul 3, 2014 at 9:15 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>> > On Thu, 3 Jul 2014, Abhilash Kesavan wrote:
>> >
>> >> On Thu, Jul 3, 2014 at 6:59 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>> >> > Please, let's avoid going that route.  There is no such special handling
>> >> > needed if the API is sufficient.  And the provided API allows you to
>> >> > suspend a CPU or shut it down.  It shouldn't matter at that level if
>> >> > this is due to a cluster switch or a hotplug event. Do you really need
>> >> > something else?
>> >> No, just one local flag for suspend should be enough for me. Will remove these.
>> >
>> > [...]
>> >
>> >> Changes in v5:
>> >>       - Removed the MCPM flags and just used a local flag to
>> >>       indicate that we are suspending.
>> >
>> > [...]
>> >
>> >> -static void exynos_power_down(void)
>> >> +static void exynos_mcpm_power_down(u64 residency)
>> >>  {
>> >>       unsigned int mpidr, cpu, cluster;
>> >>       bool last_man = false, skip_wfi = false;
>> >> @@ -150,7 +153,12 @@ static void exynos_power_down(void)
>> >>       BUG_ON(__mcpm_cluster_state(cluster) != CLUSTER_UP);
>> >>       cpu_use_count[cpu][cluster]--;
>> >>       if (cpu_use_count[cpu][cluster] == 0) {
>> >> -             exynos_cpu_power_down(cpunr);
>> >> +             /*
>> >> +              * Bypass power down for CPU0 during suspend. This is being
>> >> +              * taken care by the SYS_PWR_CFG bit in CORE0_SYS_PWR_REG.
>> >> +              */
>> >> +             if ((cpunr != 0) || (residency != S5P_CHECK_SLEEP))
>> >> +                     exynos_cpu_power_down(cpunr);
>> >>
>> >>               if (exynos_cluster_unused(cluster)) {
>> >>                       exynos_cluster_power_down(cluster);
>> >> @@ -209,6 +217,11 @@ static void exynos_power_down(void)
>> >>       /* Not dead at this point?  Let our caller cope. */
>> >>  }
>> >>
>> >> +static void exynos_power_down(void)
>> >> +{
>> >> +     exynos_mcpm_power_down(0);
>> >> +}
>> >
>> > [...]
>> >
>> >> +static int notrace exynos_mcpm_cpu_suspend(unsigned long arg)
>> >> +{
>> >> +     /* MCPM works with HW CPU identifiers */
>> >> +     unsigned int mpidr = read_cpuid_mpidr();
>> >> +     unsigned int cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
>> >> +     unsigned int cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
>> >> +
>> >> +     __raw_writel(0x0, sysram_base_addr + EXYNOS5420_CPU_STATE);
>> >> +
>> >> +     mcpm_set_entry_vector(cpu, cluster, exynos_cpu_resume);
>> >> +
>> >> +     /*
>> >> +      * Pass S5P_CHECK_SLEEP flag to the MCPM back-end to indicate that
>> >> +      * we are suspending the system and need to skip CPU0 power down.
>> >> +      */
>> >> +     mcpm_cpu_suspend(S5P_CHECK_SLEEP);
>> >
>> > NAK.
>> >
>> > When I say "local flag with local meaning", I don't want you to smuggle
>> > that flag through a public interface either.  I find it rather inelegant
>> > to have the notion of special handling for CPU0 being spread around like
>> > that.
>> >
>> > If CPU0 is special, then it should be dealth with in one place only,
>> > ideally in the MCPM backend, so the rest of the kernel doesn't have to
>> > care.
>> >
>> > Again, here's what I mean:
>> >
>> > static void exynos_mcpm_down_handler(int flags)
>> > {
>> >         [...]
>> >         if ((cpunr != 0) || !(flags & SKIP_CPU_POWERDOWN_IF_CPU0))
>> >                 exynos_cpu_power_down(cpunr);
>> >         [...]
>> > }
>> >
>> > static void exynos_mcpm_power_down()
>> > {
>> >         exynos_mcpm_down_handler(0);
>> > }
>> >
>> > static void exynos_mcpm_suspend(u64 residency)
>> > {
>> >         /*
>> >          * Theresidency argument is ignored for now.
>> >          * However, in the CPU suspend case, we bypass power down for
>> >          * CPU0 as this is being taken care by the SYS_PWR_CFG bit in
>> >          * CORE0_SYS_PWR_REG.
>> >          */
>> >         exynos_mcpm_down_handler(SKIP_CPU_POWERDOWN_IF_CPU0);
>> > }
>> >
>> > And SKIP_CPU_POWERDOWN_IF_CPU0 is defined in and visible to
>> > mcpm-exynos.c only.
>> Sorry if I am being dense, but the exynos_mcpm_suspend function would
>> get called from both the bL cpuidle driver as well the exynos pm code.
>
> What is that exynos pm code actually doing?
exynos pm code is shared across Exynos4 and 5 SoCs. It primarily does
a series of register configurations which are required to put the
system to sleep (some parts of these are SoC specific and others
common). It also populates the suspend_ops for exynos. In the current
patch, exynos_suspend_enter() is where I have plugged in the
mcpm_cpu_suspend call.

This patch is based on the S2R series for 5420
(http://comments.gmane.org/gmane.linux.kernel.samsung-soc/33898), you
may also have a look at that for a clearer picture.
>
>> We want to skip CPU0 only in case of the S2R case i.e. the pm code and
>> keep the CPU0 power down code for all other cases including CPUIdle.
>
> OK.  If so I missed that somehow (hint hint).
>
>> If I call exynos_mcpm_down_handler with the flag in
>> exynos_mcpm_suspend(), CPUIdle will also skip CPU0 isn't it ?
>
> As it is, yes.  You could logically use an infinite residency time
> (something like U64_MAX) to distinguish S2RAM from other types of
> suspend.
OK, I will use this rather than the S5P_CHECK_SLEEP macro.
>
> Yet, why is this SYS_PWR_CFG bit set outside of MCPM?  Couldn't the MCPM
> backend handle it directly instead of expecting some other entity to do
> it?
Low power modes such as Sleep, Low Power Audio, AFTR (ARM Off Top
Running) require a series of register configurations as specified by
the UM to enter/exit them. All the exynos SoCs including 5420, do such
configurations (including sys_pwr_reg setup) as part of the
exynos_pm_prepare function in pm.c and so we just need to skip the cpu
power down.

Regards,
Abhilash
>
>
> Nicolas
