From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 3 Feb 2016 17:24:07 +0000
Subject: [PATCH v4 4/7] arm64: Handle early CPU boot failures
In-Reply-To: <20160203170114.GD1234@leverpostej>
References: <1453745225-27736-1-git-send-email-suzuki.poulose@arm.com>
 <1453745225-27736-5-git-send-email-suzuki.poulose@arm.com>
 <20160203170114.GD1234@leverpostej>
Message-ID: <56B237B7.1060805@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/02/16 17:01, Mark Rutland wrote:
> On Mon, Jan 25, 2016 at 06:07:02PM +0000, Suzuki K Poulose wrote:
>> From: Suzuki K. Poulose <suzuki.poulose@arm.com>
>>

>>   3. CPU_PANIC_KERNEL - CPU detected some serious issues which
>> requires kernel to crash immediately. The secondary CPU cannot
>> call panic() until it has initialised the GIC. This flag can
>> be used to instruct the master to do so.
>
> When would we use this last case?

As of now, it is used when we have incompatible ASID bits.

>
> Perhaps a better option is to always throw any incompatible CPU into an
> (MMU-off) pen, and assume that it's stuck in the kernel, even if we
> could theoretically turn it off.

Right, that is another option. I am fine with either.

>> -	b __no_granule_support
>> +	wfi
>> +	b 1b
>
> The addition of wfi seems fine, but should be mentioned in the commit
> message.

Sure.

>>   struct secondary_data secondary_data;
>> +/* Number of CPUs which aren't online, but looping in kernel text. */
>> +u32 cpus_stuck_in_kernel;
>
> Why u32 rather than int?

No specific reasons, since it is going to be a quantity, which cannot be < 0,
kept it unsigned. It could be unsigned int.

>> +#ifdef CONFIG_HOTPLUG_CPU
>> +static int op_cpu_kill(unsigned int cpu);
>> +#else
>> +static inline int op_cpu_kill(unsigned int cpu)
>> +{
>> +	return -ENOSYS;
>> +}
>> +#endif
>
> There is no !CONFIG_HOTPLUG_CPU configuration any more.

Thats what I thought but then there was [1]. If you disable CONFIG_PM_SLEEP, you can
still build with !CONFIG_HOTPLUG_CPU (or in other words allnoconfig)

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/384589.html

>>
>> +	/* Make sure the update to status is visible */
>> +	smp_rmb();
>>   	secondary_data.stack = NULL;
>> +	status = READ_ONCE(secondary_data.status);
>
> What is the rmb intended to order here?

It was for the complete(). But...

>> +	update_cpu_boot_status(CPU_BOOT_SUCCESS);
>> +	/* Make sure the status update is visible before we complete */
>> +	smp_wmb();
>
> Surely complete() has appropriate barriers?

Yes, it does. We can remove it.
  
>>   #ifdef CONFIG_HOTPLUG_CPU
>> +	update_cpu_boot_status(CPU_KILL_ME);
>>   	/* Check if we can park ourselves */
>>   	if (cpu_ops[cpu] && cpu_ops[cpu]->cpu_die)
>>   		cpu_ops[cpu]->cpu_die(cpu);
>
> I think you need a barrier to ensure visibility of the store prior to
> calling cpu_die (i.e. you want to order an access against execution). A
> dsb is what you want -- smp_wmb() only expands to a dmb.
>

OK.

>>   #endif
>> +	update_cpu_boot_status(CPU_STUCK_IN_KERNEL);
>>
>>   	cpu_park_loop();
>
> Likewise here.

OK.

Thanks
Suzuki
