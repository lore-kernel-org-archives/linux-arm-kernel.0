From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 16 Dec 2015 10:39:50 +0000
Subject: [RFC PATCH v3 4/8] arm64: Handle early CPU boot failures
In-Reply-To: <20151215115518.GE9452@arm.com>
References: <1449655039-22022-1-git-send-email-suzuki.poulose@arm.com>
 <1449655039-22022-5-git-send-email-suzuki.poulose@arm.com>
 <20151215115518.GE9452@arm.com>
Message-ID: <56713F76.8080907@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/12/15 11:55, Will Deacon wrote:
> On Wed, Dec 09, 2015 at 09:57:15AM +0000, Suzuki K. Poulose wrote:

>>   /*
>>    * Initial data for bringing up a secondary CPU.
>> + * @stack  - sp for the secondary CPU
>> + * @status - Result passed back from the secondary CPU to
>> + *           indicate failure.
>>    */
>>   struct secondary_data {
>>   	void *stack;
>> -};
>> +	unsigned long status;
>> +} ____cacheline_aligned;
>
> Why is this necessary?

That was based on a suggestion from Mark Rutland here:

   https://lkml.org/lkml/2015/12/1/580


>> @@ -615,6 +616,7 @@ ENDPROC(__secondary_switched)
>>    * Enable the MMU.
>>    *
>>    *  x0  = SCTLR_EL1 value for turning on the MMU.
>> + *  x22 = __va(secondary_data)
>>    *  x27 = *virtual* address to jump to upon completion

...

>>
>>   __no_granule_support:
>> +	/* Indicate that this CPU can't boot and is stuck in the kernel */
>> +	cmp	x22, 0				// Boot CPU doesn't update status
>> +	b.eq	1f
>> +	adrp	x1, secondary_data
>> +	add	x1, x1, #:lo12:secondary_data	// x1 = __pa(secondary_data)
>
> This feels a bit grotty. You end up using the virtual address of
> secondary_data to figure out if you're the boot CPU or not, and then you
> end up having to compute the physical address of the same variable anyway.
>

Yes, it looks a bit weird, but we pass down the va(secondary_data) to the secondary
CPU and that is used only after the MMU is turned on, to fetch the stack ptr.
We use that information to detect if we are secondary. When we fail before turning
the MMU on, we need to update our result back, hence the va-to-pa conversion.
Is there a better way to handle it ? Am I missing something ? Or we could add another
register which would indicate if it is secondary or not.

>> +	mov	x0, #CPU_STUCK_IN_KERNEL
>> +	str	x0, [x1, #CPU_BOOT_STATUS]	// update the secondary_data.status
>> +	/* flush the data to PoC */
>
> Can you call __inval_cache_range instead of open-coding this?

Yes, that sounds better, will use that.

>> +	isb
>
> Why?

...

>
>> +	dc	civac, x1
>> +	dsb	sy
>> +	isb
>
> Why?

I now realize how bad this code is. I wrote this up in a hurry, without proper
understanding of the dependencies of 'dc'. I was under the assumption that the isb
needed just like we do after updating the system control registers, which is not
true for dc.

>
>> +1:
>>   	wfe
>
> Curious, but do you know why we don't have a wfi here too (like we do in
> the C code)?

Yes we do, will add it.

>>   	/*
>>   	 * Now bring the CPU into our world.
>> @@ -117,7 +135,31 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>>   		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
>>   	}
>>
>> +	mb();
>
> Why? (and why not smp_mb(), if the barrier is actually needed?).

Actually, now when I think of it we don't need it as the cache would have been
invalidated by the secondary. All we need is making secondary_data.status volatile,
to make sure we don't use a stale copy of secondary_data.status cached in the
register.

I will rewrite this code.

>> +
>>   	secondary_data.stack = NULL;
>> +	if (ret && secondary_data.status) {
>> +		switch(secondary_data.status) {
>> +		default:
>> +			pr_err("CPU%u: failed in unknown state : 0x%lx\n",
>> +					cpu, secondary_data.status);
>> +			break;
>> +		case CPU_KILL_ME:
>> +			if (op_cpu_kill(cpu)) {
>> +				pr_crit("CPU%u: may not have shut down cleanly\n",
>> +							cpu);
>> +				cpus_stuck_in_kernel++;
>
> Maybe restructure this so the failed kill case is a fallthrough to the
> CPU_STUCK_IN_KERNEL case?

Yes, makes sense.

>
>> +			} else
>> +				pr_crit("CPU%u: died during early boot\n", cpu);
>
> Missing braces.

Will fix that.

>> +			break;
>> +		case CPU_STUCK_IN_KERNEL:
>> +			pr_crit("CPU%u: is stuck in kernel\n", cpu);
>> +			cpus_stuck_in_kernel++;
>> +			break;
>> +		case CPU_PANIC_KERNEL:
>> +			panic("CPU%u detected unsupported configuration\n", cpu);
>
> It would nice to show what the configuration difference was, but maybe
> that's work for later.

One way would be to assign code for each of the failing cases overload the
status with the reason (on the top half). But thats only needed for cases where
we couldn't write something to the console. Anyways, thats something for later.

>
>> +		}
>> +	}
>>
>>   	return ret;
>>   }
>> @@ -185,6 +227,7 @@ asmlinkage void secondary_start_kernel(void)
>>   	 */
>>   	pr_info("CPU%u: Booted secondary processor [%08x]\n",
>>   					 cpu, read_cpuid_id());
>> +	update_cpu_boot_status(CPU_BOOT_SUCCESS);
>
> Why do we need to continue with the cacheflushing at this point?

>> +	update_cpu_boot_status(CPU_STUCK_IN_KERNEL);
>> +	__flush_dcache_area(&secondary_data, sizeof(secondary_data));
>
> Extra flushing, but I don't see why you need it at all when you're
> running in C on the CPU coming up.


You are right, we don't need to do this as we are already using the
va.

I will rewrite it properly. Thanks for the review and patience :)

Cheers
Suzuki
  
