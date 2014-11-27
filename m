From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Thu, 27 Nov 2014 10:29:44 +0530
Subject: [PATCH 3/9] ARM: MB86S7X: Add MCPM support
In-Reply-To: <alpine.LFD.2.11.1411251205500.11690@knanqh.ubzr>
References: <1416486442-25200-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1416486920-25343-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <alpine.LFD.2.11.1411251205500.11690@knanqh.ubzr>
Message-ID: <CAJe_ZheS1Gsbhuhm=yUbcamTw-5vWAcSNntU6_eEz=NC1tr-8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 November 2014 at 23:12, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:

>
>> +
>> +static void
>> +mb86s7x_set_wficolor(unsigned clstr, unsigned cpu, unsigned clr)
>> +{
>> +     u8 val;
>> +
>> +     if (clr & ~AT_WFI_COLOR_MASK)
>> +             return;
>
> Shouldn't this be a BUG() rather than a return?
>
There are only 2 callers of this and they use explicit defines
AT_WFI_DO_xxx, so the check is actually lame and could be removed.

>> +
>> +     val = readb_relaxed(mb86s7x_shm_base
>> +                         + WFI_COLOR_OFFSET + clstr * 2 + cpu);
>> +     val &= ~AT_WFI_COLOR_MASK;
>> +     val |= clr;
>> +     writeb_relaxed(val, mb86s7x_shm_base
>> +                    + WFI_COLOR_OFFSET + clstr * 2 + cpu);
>> +}
>> +
>> +static int mb86s7x_pm_power_up(unsigned int cpu, unsigned int cluster)
>> +{
>> +     int ret = 0;
>> +
>> +     if (cluster >= S7X_MAX_CLUSTER || cpu >= S7X_MAX_CPU)
>> +             return -EINVAL;
>> +
>> +     pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
>> +
>> +     local_irq_disable();
>> +     arch_spin_lock(&mb86s7x_pm_lock);
>> +
>> +     mb86s7x_pm_use_count[cluster][cpu]++;
>> +
>> +     if (mb86s7x_pm_use_count[cluster][cpu] == 1) {
>> +             struct mb86s7x_cpu_gate cmd;
>> +
>> +             arch_spin_unlock(&mb86s7x_pm_lock);
>> +             local_irq_enable();
>
> From that point onward, nothing prevents concurrent execution in
> mb86s7x_pm_suspend() racing to call mb86s7x_set_wficolor() resulting in
> an incoherent state depending on who wins the race.
>
yeah, the set_wficolor() better be before we release the arch_spin_unlock.

Thanks,
Jassi
