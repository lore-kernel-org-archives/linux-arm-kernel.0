From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 29 Jun 2017 17:07:35 +0200
Subject: [PATCH v4 20/28] ARM: owl: Implement CPU enable-method for S500
In-Reply-To: <CAK8P3a1fLABzSc7kej6uw751uoZma1Qvpm7c3mkLB45rcBNQTA@mail.gmail.com>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-21-afaerber@suse.de>
 <CAK8P3a1fLABzSc7kej6uw751uoZma1Qvpm7c3mkLB45rcBNQTA@mail.gmail.com>
Message-ID: <CAK8P3a3Pg2rm8nSPUm_E61F7+zSr3gWV6sNqhC0Et3Zh2xPtmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +static int s500_smp_boot_secondary(unsigned int cpu, struct task_struct *idle)
>> +{
>> +       unsigned long timeout;
>> +       int ret;
>> +
>> +       ret = s500_wakeup_secondary(cpu);
>> +       if (ret)
>> +               return ret;
>> +
>> +       udelay(10);
>> +
>> +       spin_lock(&boot_lock);
>> +
>> +       /*
>> +        * The secondary processor is waiting to be released from
>> +        * the holding pen - release it, then wait for it to flag
>> +        * that it has been released by resetting pen_release.
>> +        */
>> +       write_pen_release(cpu_logical_map(cpu));
>> +       smp_send_reschedule(cpu);
>> +
>> +       timeout = jiffies + (1 * HZ);
>> +       while (time_before(jiffies, timeout)) {
>> +               if (pen_release == -1)
>> +                       break;
>> +       }
>> +
>> +       writel(0, timer_base_addr + OWL_CPU1_ADDR + (cpu - 1) * 4);
>> +       writel(0, timer_base_addr + OWL_CPU1_FLAG + (cpu - 1) * 4);
>> +
>> +       spin_unlock(&boot_lock);
>> +
>> +       return pen_release != -1 ? -ENOSYS : 0;
>> +}
>
> This looks more complicated than necessary. Why do you need the holding
> pen when you have a register to start up the CPU?
>

It seems you missed my question here. Can you please follow up, and
if possible send a patch to remove the pen_release logic that appears
to be unnecessary here?

        Arnd
