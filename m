From: james.morse@arm.com (James Morse)
Date: Thu, 07 Jul 2016 17:58:42 +0100
Subject: [PATCH v3 6/7] arm64: hibernate: Resume on the CPU that created
 the hibernate image
In-Reply-To: <20160705145530.GA19925@red-moon>
References: <1467125510-18758-1-git-send-email-james.morse@arm.com>
 <1467125510-18758-7-git-send-email-james.morse@arm.com>
 <20160705145530.GA19925@red-moon>
Message-ID: <577E8A42.1020609@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On 05/07/16 15:55, Lorenzo Pieralisi wrote:
> On Tue, Jun 28, 2016 at 03:51:49PM +0100, James Morse wrote:
>> On arm64 the cpu with logical id 0 is assumed to be the boot CPU. If a
>> user hotplugs this CPU out, then uses kexec to boot a new kernel, the new
>> kernel will assign logical id 0 to a different physical CPU.
>> This breaks hibernate as hibernate and resume will be attempted on different
>> CPUs. A previous patch detects this situation when we come to resume,
>> and returns an error. (data stored in the hibernate image is lost)
>>
>> We currently forbid hibernate if CPU0 has been hotplugged out to avoid
>> this situation without kexec.
>>
>> Use arch_hibernation_disable_cpus() to direct which CPU we should resume
>> on based on the MPIDR of the CPU we hibernated on. This allows us to
>> hibernate/resume on any CPU, even if the logical numbers have been
>> shuffled by kexec.

>> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
>> index 8c7c6d7d4cd4..cbcc8243575e 100644
>> --- a/arch/arm64/kernel/hibernate.c
>> +++ b/arch/arm64/kernel/hibernate.c

>> +int _arch_hibernation_disable_cpus(bool suspend)
>> +{
>> +	int cpu, ret;
>> +
>> +	if (suspend) {
>> +		/*
>> +		 * During hibernate we need frozen_cpus to be updated and saved.
>> +		 */
>> +		ret = disable_nonboot_cpus();
>> +	} else {
>> +		/*
>> +		 * Resuming from hibernate. From here, we can't race with
>> +		 * userspace, and don't need to update frozen_cpus.
> 
> Yes, but...
> 
>> +		 */
>> +		pr_info("Disabling secondary CPUs ...\n");
>> +
>> +		/* sleep_cpu must have been loaded from the arch header */
>> +		BUG_ON(sleep_cpu < 0);
>> +
>> +		for_each_online_cpu(cpu) {
>> +			if (cpu == sleep_cpu)
>> +				continue;
>> +			ret = cpu_down(cpu);
> 
> This has a side effect, in that tasks are frozen here but we are now
> calling _cpu_down() through:
> 
> 	cpu_down() -> do_cpu_down()
> 
> and we are telling the kernel that tasks are _not_ frozen, which
> AFAIK changes the cpuhp_tasks_frozen variable and related actions
> (eg __cpu_notify()), I suspect this may confuse some notifiers
> state machines that depend on CPU_TASKS_FROZEN to be set, maybe
> not but it is worth a look.

Thanks for this - I missed that implication.

I've been through all the cpu notifiers in the core code, almost all of them
either mask out the frozen bits, or do something symmetric.

The exceptions are:
__zcomp_cpu_notifier() and __zswap_cpu_dstmem_notifier(), which will free memory
in this scenario.
evtchn_fifo_cpu_notification() which could end up in generic_handle_irq().
nmi_timer_cpu_notifier() (part of oprofile), will disable a perf timer.
bcm2836_arm_irqchip_cpu_notify() will mask IPIs, but will still unmask them on
CPU_STARTING_FROZEN.

coretemp_cpu_callback(), via_cputemp_cpu_callback() and
powerclamp_cpu_callback() would remove platform devices, or stop threads, but
these three are x86 specific.
All the rest live under /arch.

I haven't found any that are a problem, but this doesn't feel like the right
thing to do. I will look for a way to tidy this up.


Thanks,

James
