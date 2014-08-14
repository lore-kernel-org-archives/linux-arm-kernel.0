From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Thu, 14 Aug 2014 09:37:22 +0800
Subject: [PATCH v19 2/8] ARM: hisi: enable MCPM implementation
In-Reply-To: <alpine.LFD.2.11.1408131345160.1133@knanqh.ubzr>
References: <1407912091-29866-1-git-send-email-haojian.zhuang@linaro.org>
 <alpine.LFD.2.11.1408131345160.1133@knanqh.ubzr>
Message-ID: <CAD6h2NQmFK++j9FxB7JXs5RHtzy9FyKMMhvo1Ed2RzBUq4JjPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 August 2014 02:01, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Wed, 13 Aug 2014, Haojian Zhuang wrote:
>
>> +static int hip04_mcpm_wait_for_powerdown(unsigned int cpu, unsigned int cluster)
>> +{
>> +     unsigned int data, tries;
>> +
>> +     BUG_ON(cluster >= HIP04_MAX_CLUSTERS ||
>> +            cpu >= HIP04_MAX_CPUS_PER_CLUSTER);
>> +
>> +     spin_lock_irq(&boot_lock);
>> +     /*
>> +      * Target core should enter WFI first.
>> +      * Then cluster could be disabled in snoop filter.
>> +      * At last, target core could be reset.
>
> Please add: "This is safe only against concurrent calls to
> hip04_mcpm_power_up().  This is not safe with asynchronous CPU wake-ups
> and therefore cannot be used to implement deep idle C-states."
>

Now I can move disabling snoop filter into power_down() after L2
prefetch disabled. So I don't need the comment any more.

>> +      */
>> +     for (tries = 0; tries < MAX_TRIES; tries++) {
>> +             if (hip04_cpu_table[cluster][cpu])
>> +                     goto err;
>
> I'd suggest returning a different error code in this case.

OK. How about use EBUSY when the count in hipp04_cpu_table is set? And
use ETIMEOUT when status result unmatch our expected value.

>
>> +             /*
>> +              * We'll meet kernel panic without delay. Maybe L2 is still
>> +              * in the process of clean.
>> +              * Since there's no command to clean L2 in Cortex A15. It
>> +              * seems that we need to disable MMU & C bit in target cpu.
>
> That's what v7_exit_coherency_flush() does: disabling C bit and MMU on
> the calling CPU.

Just clarify that v7_exit_coherency_flush() disable C bit in SCTLR &
SMP bit in ACTLR. MMU bit in SCTLR is always on. Otherwise, we need to
calculate the PA, and jump to PA in this function.

>
> Also, maybe you need to disable the L2 prefetching before disabling
> the cache if those are
> A15 cores.  See tc2_pm.c.

After disabling the L2 prefetching, this issue is gone. So I don't
need both delay & disabling snoop filter in wait_for_power_down().
Great thanks for your help.

Best Regards
Haojian
