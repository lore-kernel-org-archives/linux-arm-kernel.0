From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 31 Mar 2016 09:12:32 +0100
Subject: [PATCH v15 17/20] arm64: kdump: implement machine_crash_shutdown()
In-Reply-To: <20160331075659.GD2267@linaro.org>
References: <cover.1457977401.git.geoff@infradead.org>
 <8f53a31cf8bbfdd73eb289e078addc31c5a19fcf.1457977403.git.geoff@infradead.org>
 <56EC440F.4050406@arm.com> <56EFF738.1040308@arm.com>
 <20160331075659.GD2267@linaro.org>
Message-ID: <56FCDBF0.2010505@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/03/16 08:57, AKASHI Takahiro wrote:
> On Mon, Mar 21, 2016 at 01:29:28PM +0000, James Morse wrote:
>> Hi!
>>
>> On 18/03/16 18:08, James Morse wrote:
>>> On 14/03/16 17:48, Geoff Levand wrote:
>>>> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>>>
>>>> Primary kernel calls machine_crash_shutdown() to shut down non-boot cpus
>>>> and save registers' status in per-cpu ELF notes before starting crash
>>>> dump kernel. See kernel_kexec().
>>>> Even if not all secondary cpus have shut down, we do kdump anyway.
>>>>
>>>> As we don't have to make non-boot(crashed) cpus offline (to preserve
>>>> correct status of cpus at crash dump) before shutting down, this patch
>>>> also adds a variant of smp_send_stop().
>>
>>>> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>>>> index b1adc51..76402c6cd 100644
>>>> --- a/arch/arm64/kernel/smp.c
>>>> +++ b/arch/arm64/kernel/smp.c
>>>> @@ -701,6 +705,28 @@ static void ipi_cpu_stop(unsigned int cpu)
>>>>  		cpu_relax();
>>>>  }
>>>>  
>>>> +static atomic_t waiting_for_crash_ipi;
>>>> +
>>>> +static void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
>>>> +{
>>>> +	crash_save_cpu(regs, cpu);
>>>> +
>>>> +	raw_spin_lock(&stop_lock);
>>>> +	pr_debug("CPU%u: stopping\n", cpu);
>>>> +	raw_spin_unlock(&stop_lock);
>>>> +
>>>> +	atomic_dec(&waiting_for_crash_ipi);
>>>> +
>>>> +	local_irq_disable();
>>>> +
>>>> +	if (cpu_ops[cpu]->cpu_die)
>>>> +		cpu_ops[cpu]->cpu_die(cpu);
>>>> +
>>>> +	/* just in case */
>>>> +	while (1)
>>>> +		wfi();
>>
>> Having thought about this some more: I don't think spinning like this is safe.
>> We need to spin with the MMU turned off, otherwise this core will pollute the
>> kdump kernel with TLB entries from the old page tables.
> 
> I think that wfi() will never wake up since local interrupts are disabled
> here. So how can it pollute the kdump kernel?

Having interrupts disabled doesn't prevent an exit from WFI. Quite the
opposite, actually. It is designed to wake-up the core when something
happens on the external interface.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
