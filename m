From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 13 Oct 2015 11:12:40 +0100
Subject: [PATCH v2 12/22] arm64: Delay cpu feature checks
In-Reply-To: <20151008110840.GF17192@e104818-lin.cambridge.arm.com>
References: <1444064531-25607-1-git-send-email-suzuki.poulose@arm.com>
 <1444064531-25607-13-git-send-email-suzuki.poulose@arm.com>
 <20151008110840.GF17192@e104818-lin.cambridge.arm.com>
Message-ID: <561CD918.7000107@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/15 12:08, Catalin Marinas wrote:
> On Mon, Oct 05, 2015 at 06:02:01PM +0100, Suzuki K. Poulose wrote:
>> +	/*
>> +	 * second pass allows enable() invoked on active each CPU
>> +	 * to consider interacting capabilities.
>> +	 */
>
> This comment doesn't read properly.
>

Fixed locally

>> +	/*XXX: Are we really safe to call printk here ? */
>> +	pr_crit("FATAL: CPU%d is missing %s : %s \n",
>> +			smp_processor_id(), cap_type, cap->desc);
>
> I'm not sure it's safe either, basically we haven't fully brought the
> CPU into the system.

Btw, we already print "Booted secondary cpu" from secondary_start_kernel()
before we trigger the notifiers. So I think it should be safe to call it
at the moment.

>
>> +	asm volatile(
>> +			" 1:	wfe \n\t"
>> +			"	b 1b\n"
>> +		    );
>> +}
>
> We could add a wfi as well in the mix.
>
> However, if we have PSCI, we should use it to park the CPUs back into
> firmware (via cpu_operations.cpu_die), and only use the above loop if
> that fails.

Added cpu_die() and falls back to the trap as above.


>
>> +/*
>> + * Run through the enabled system capabilities and enable() it on this CPU.
>
> s/it/them/
>

Fixed.

Thanks
Suzuki
