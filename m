From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 3 Feb 2016 17:23:33 +0000
Subject: [PATCH v4 4/7] arm64: Handle early CPU boot failures
In-Reply-To: <20160203125735.GA26487@MBP.local>
References: <1453745225-27736-1-git-send-email-suzuki.poulose@arm.com>
 <1453745225-27736-5-git-send-email-suzuki.poulose@arm.com>
 <20160203125735.GA26487@MBP.local>
Message-ID: <56B23795.5090202@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

>> +/* Fatal system error detected by secondary CPU, crash the system */
>> +#define CPU_PANIC_KERNEL	3
>
> Please add braces around these numbers, just in case (I added them
> locally).

OK, I will base my changes on top of the corrections.

>
>>   /*
>> + * The booting CPU updates the failed status, with MMU turned off,
>> + * below which lies in head.txt to make sure it doesn't share the same writeback
>> + * granule. So that we can invalidate it properly.
>
> I can't really parse this (it looks like punctuation in the wrong place;
> also "share the same..." with what?).

Sorry it doesn't parse :(. It should have been something like :

"The booting CPU updates the failed status @__early_cpu_boot_status (with
the MMU turned off). It is placed in head.txt to make sure it doesn't
share the same write back granule with anything else while the CPU updates
it."


>> +	.macro	update_early_cpu_boot_status tmp, status
>> +	mov	\tmp, lr
>> +	adrp	x0, __early_cpu_boot_status
>> +	add	x0, x0, #:lo12:__early_cpu_boot_status
>
> Nitpick: you could use the adr_l macro.

Yes, that looks much better, will keep in mind.


>> @@ -117,7 +131,35 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>>   		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
>>   	}
>>
>> +	/* Make sure the update to status is visible */
>> +	smp_rmb();
>
> Which status? In relation to what?

The secondary_data.status updated by the successful CPUs which have mmu turned on, and
updating the cpu_running. But as Mark pointed out, complete() implies a barrier, hence
won't need it.

>
>>   	secondary_data.stack = NULL;
>> +	status = READ_ONCE(secondary_data.status);
>> +	if (ret && status) {
>> +
>> +		if (status == CPU_MMU_OFF)
>> +			status = READ_ONCE(__early_cpu_boot_status);
>
> You need cache maintenance before reading this.

OK.

Thanks
Suzuki
