From: sophian.yoma@gmail.com (yoma sophian)
Date: Fri, 31 Jul 2015 00:20:54 +0800
Subject: question about detect hard lockups without NMIs using secondary
 cpus
In-Reply-To: <20150729182905.GO7557@n2100.arm.linux.org.uk>
References: <CADUS3onib4DYYtPo7RfLAYiN4fpspzcFCx86-pJwuLc37hz3dQ@mail.gmail.com>
 <20150729182905.GO7557@n2100.arm.linux.org.uk>
Message-ID: <CADUS3o=AQ2ic7K2RboDzEyBuJSzkACpbDXB=hcpsnedbi1dKcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Russel

2015-07-30 2:29 GMT+08:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Thu, Jul 30, 2015 at 12:03:46AM +0800, yoma sophian wrote:
>> hi all:
>> below link introduced how to emulate NMIs on systems where they are
>> not available by using timer interrupts on other cpus.
>>
>> http://article.gmane.org/gmane.linux.kernel/1419661
>>
>> in kernel/watchdog.c
>>     --> watchdog_overflow_callback
>>           if (is_hardlockup()) {
>>            ...........................
>>                 if (hardlockup_panic)
>>                         panic("Watchdog detected hard LOCKUP on cpu %d",
>>                               this_cpu); /*************/
>>                 else
>>                         WARN(1, "Watchdog detected hard LOCKUP on cpu %d",
>>                              this_cpu);
>>              .......................
>>         }
>>
>> I have some questions:
>> a.
>> in SMP system, suppose 4 cores, and hardlockup_panic is 1.
>> Core0 find Core1 hard lcokup in hardIRQ context
>> the panic function, above with '*' marked, will fail on
>> smp_send_stop(), and we will have no idea where core1 is trapped in,
>> right?
>
> watchdog_overflow_callback() is only ever entered for the failed core.
> What you missed out on is:
>
>         int this_cpu = smp_processor_id();
>
> which gets the CPU number of the CPU executing this code.  So, Core 0
> will never find Core 1 having locked up via this code path.
if core0 found it is locked in lockdep, that mean the situation is no so worse,
core0 has the chance to go back, right.



>> b.
>> things will get worse if we are running single core system if hard
>> lockup happen.
>> We even have no idea what happen.
>
> Basically, without NMIs (or FIQs in ARM speak) lockups with IRQs off are
> undetectable by the kernel other than "the system stopped responding".
>
> In a SMP system, there are mechanisms by which other CPUs can detect a
> locked-up CPU, and they can call trigger_all_cpu_backtrace() - and that
> can only get a trace out of the locked up CPU if it uses FIQs.  A CPU
> which has locked up in an IRQs-off region won't be able to receive an
> IRQ or IPI by definition.

so in ur case "A CPU  which has locked up in an IRQs-off region won't
be able to receive an
IRQ or IPI by definition.' the only wake to trigger_them is by FIQ, right?


> Work has been going on for the last 9 months to try and bring a working
> trigger_all_cpu_backtrace() implementation, initially with IRQs and
> later with FIQs.
>
> In previous merge windows, we have moved forward with getting some FIQ
> changes merged, and in the next merge window, I have patches queued up
> (available in linux-next) which add IRQ-based trigger_all_cpu_backtrace()
> support.
>
> The next piece of the puzzle is sorting out the patches which bring FIQ
> based trigger_all_cpu_backtrace() support - but even if we do, that won't
> be available everywhere - for example, it won't be available if your kernel
> runs in the non-secure world with a secure monitor, because FIQs generally
> aren't usable in that world.
Is there patch that we can reference what you describe above?
if we stay in secure world, and take some ppi as fiq and others ppi/spi are IRQ.
isn't that enough to cover above idea?
( GIC has the cability to let NS irq to be handed by secure Cpu)

appreciate ur kine help
