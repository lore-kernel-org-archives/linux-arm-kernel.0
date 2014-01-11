From: alex.shi@linaro.org (Alex Shi)
Date: Sat, 11 Jan 2014 09:35:52 +0800
Subject: LSK merge linux-stable review
In-Reply-To: <20140110163239.GF925@arm.com>
References: <20140110013011.GA6447@alex-shi> <52CF61CC.40305@linaro.org>
 <20140110105615.GD925@arm.com> <52D01234.5040402@linaro.org>
 <20140110163239.GF925@arm.com>
Message-ID: <52D09FF8.8060308@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>>
>> the first column '-/+' means contents was removed/added from file
>> 5e9d274. the 2nd column '-/+' means contents was removed/added from file
>> 9c93e12.
>>
>> Yes, The notify_cpu_starting kept in final file later.
> 
> Just make sure it is in line with commit 7ade67b5984d0a (arm64: move
> enabling of GIC before CPUs are set online)
> 

Give you the part of modified smp.c file here :)
====

        printk("CPU%u: Booted secondary processor\n", cpu);

        /*
         * All kernel threads share the same mm context; grab a
         * reference and switch to it.
         */
        atomic_inc(&mm->mm_count);
        current->active_mm = mm;
        cpumask_set_cpu(cpu, mm_cpumask(mm));

        /*
         * TTBR0 is only used for the identity mapping at this stage. Make it
         * point to zero page to avoid speculatively fetching new entries.
         */
        cpu_set_reserved_ttbr0();
        flush_tlb_all();

        preempt_disable();
        trace_hardirqs_off();

        if (cpu_ops[cpu]->cpu_postboot)
                cpu_ops[cpu]->cpu_postboot();

        smp_store_cpu_info(cpu);

        /*
         * OK, now it's safe to let the boot CPU continue.  Wait for
         * the CPU migration code to notice that the CPU is online
         * before we continue.
         */
        set_cpu_online(cpu, true);
        complete(&cpu_running);

        /*
         * Enable GIC and timers.
         */
        notify_cpu_starting(cpu);

        local_irq_enable();
        local_fiq_enable();

        /*
         * OK, it's off to the idle thread for us
         */
        cpu_startup_entry(CPUHP_ONLINE);
}

-- 
Thanks
    Alex
