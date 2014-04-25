From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 25 Apr 2014 11:00:02 +0800
Subject: [PATCH v3 07/13] ARM: hisi: add hip04 SoC support
In-Reply-To: <alpine.LFD.2.11.1404212323440.980@knanqh.ubzr>
References: <1397801156-25682-1-git-send-email-haojian.zhuang@linaro.org>
 <1397801156-25682-8-git-send-email-haojian.zhuang@linaro.org>
 <alpine.LFD.2.11.1404212323440.980@knanqh.ubzr>
Message-ID: <CAD6h2NRZREHWaSGcJg4UgVWWfTGpgZFJyvCfF8X7octWLV8YDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 April 2014 12:08, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Fri, 18 Apr 2014, Haojian Zhuang wrote:
>
>> +
>> +     data = CORE_RESET_BIT(cpu) | NEON_RESET_BIT(cpu) | \
>> +            CORE_DEBUG_RESET_BIT(cpu);
>> +     writel_relaxed(data, sysctrl + SC_CPU_RESET_DREQ(cluster));
>
> It might be a good idea to reset and initialize things only if
> hip04_cpu_table[cluster][cpu] was zero initially.  Please see the
> comment in mcpm_cpu_power_down() discussing concurrent up/down
> operations, and the way races are handled using dcscb_use_count in
> dcscb_power_up() / dcscb_power_down() for example.
>

I'll use it as reference.

>> +     spin_unlock(&boot_lock);
>> +     msleep(POLL_MSEC);
>
> You don't have to wait here.  The MCPM up method should set things for
> the CPU to come up eventually and that CPU to signal itself when it is
> finally online.
>

I have to wait. Otherwise, I'll meet hang when make the CPU offline &
online continuously.

>> +     return 0;
>> +}
>> +
>> +static void hip04_mcpm_power_down(void)
>> +{
>> +     unsigned int mpidr, cpu, cluster;
>> +     unsigned int v;
>> +
>> +     mpidr = read_cpuid_mpidr();
>> +     cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
>> +     cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
>> +
>> +     spin_lock(&boot_lock);
>> +     BUG_ON(__mcpm_cluster_state(cluster) != CLUSTER_UP);
>> +     __mcpm_cpu_going_down(cpu, cluster);
>> +
>> +     hip04_cpu_table[cluster][cpu]--;
>> +     if (hip04_cpu_table[cluster][cpu]) {
>> +             pr_err("Cluster %d CPU%d is still running\n", cluster, cpu);
>> +             goto out;
>> +     }
>
> This is wrong.  Please see dcscb_power_down() or tc2_pm_down() for
> examples of how to deal with this situation.
>
>> +     __mcpm_cpu_down(cpu, cluster);
>
> That call should happen last i.e. after coherency has been disabled and
> the CPU is about to call WFI.  Again, see the TC2 implementation for
> example.  You may also read
> Documentation/arm/cluster-pm-race-avoidance.txt for more details about
> those calls and the algorithm behind them.
>
>> +     spin_unlock(&boot_lock);
>> +
>> +     asm volatile(
>> +     "       mrc     p15, 0, %0, c1, c0, 0\n"
>> +     "       bic     %0, %0, %1\n"
>> +     "       mcr     p15, 0, %0, c1, c0, 0\n"
>> +       : "=&r" (v)
>> +       : "Ir" (CR_C)
>> +       :);
>> +
>> +     flush_cache_louis();
>> +
>> +     asm volatile(
>> +     /* Turn off coherency, disable SMP bit in ACTLR */
>> +     "       mrc     p15, 0, %0, c1, c0, 1\n"
>> +     "       bic     %0, %0, %1\n"
>> +     "       mcr     p15, 0, %0, c1, c0, 1\n"
>> +     : "=&r" (v)
>> +     : "Ir" (0x40)
>> +     :);
>
> The above code is not safe.
>
> You should use v7_exit_coherency_flush() instead.
>

OK.

>> +     isb();
>> +     dsb();
>> +
>> +     while (true)
>> +             wfi();
>
> This is wrong.  By the time execution gets here, it is well possible
> that another CPU decided that this CPU should not be down anymore, in
> which case wfi() will return.  See what's expected in this case by
> looking at mcpm_cpu_power_down() and what other backend implementations
> do.
>
>> +     return;
>> +out:
>> +     spin_unlock(&boot_lock);
>> +}
>> +
>> +static int hip04_mcpm_wait_for_powerdown(unsigned int cpu, unsigned int cluster)
>> +{
>> +     unsigned int data, tries;
>> +
>> +     BUG_ON(cluster >= HIP04_MAX_CLUSTERS ||
>> +            cpu >= HIP04_MAX_CPUS_PER_CLUSTER);
>> +
>> +     for (tries = 0; tries < TIMEOUT_MSEC / POLL_MSEC; tries++) {
>> +             data = readl_relaxed(sysctrl + SC_CPU_RESET_STATUS(cluster));
>> +             if (!(data & CORE_WFI_STATUS(cpu))) {
>> +                     msleep(POLL_MSEC);
>> +                     continue;
>> +             }
>> +             data = CORE_RESET_BIT(cpu) | NEON_RESET_BIT(cpu) | \
>> +                    CORE_DEBUG_RESET_BIT(cpu);
>> +             writel_relaxed(data, sysctrl + SC_CPU_RESET_REQ(cluster));
>
> Why are you resetting those here?
>

Do you mean that I should move this reset code into hip04_mcpm_power_down()?

Regards
Haojian
