From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 24 Apr 2015 11:43:46 +0100
Subject: [v2 2/5] arm64: kdump: implement machine_crash_shutdown()
In-Reply-To: <20150424103900.GF29183@leverpostej>
References: <1429861989-8417-1-git-send-email-takahiro.akashi@linaro.org>
 <1429861989-8417-3-git-send-email-takahiro.akashi@linaro.org>
 <20150424103900.GF29183@leverpostej>
Message-ID: <553A1E62.9030400@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/04/15 11:39, Mark Rutland wrote:
> On Fri, Apr 24, 2015 at 08:53:05AM +0100, AKASHI Takahiro wrote:
>> kdump calls machine_crash_shutdown() to shut down non-boot cpus and
>> save per-cpu general-purpose registers before restarting the crash dump
>> kernel. See kernel_kexec().
>> ipi_cpu_stop() is used and a bit modified to support this behavior.
>>
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> ---
>>  arch/arm64/include/asm/kexec.h    |   34 ++++++++++++++++++++++-
>>  arch/arm64/kernel/machine_kexec.c |   55 ++++++++++++++++++++++++++++++++++++-
>>  arch/arm64/kernel/smp.c           |   12 ++++++--
>>  3 files changed, 97 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
>> index 3530ff5..eaf3fcb 100644
>> --- a/arch/arm64/include/asm/kexec.h
>> +++ b/arch/arm64/include/asm/kexec.h
>> @@ -30,6 +30,8 @@
>>  
>>  #if !defined(__ASSEMBLY__)
>>  
>> +extern bool in_crash_kexec;
>> +
>>  /**
>>   * crash_setup_regs() - save registers for the panic kernel
>>   *
>> @@ -40,7 +42,37 @@
>>  static inline void crash_setup_regs(struct pt_regs *newregs,
>>  				    struct pt_regs *oldregs)
>>  {
>> -	/* Empty routine needed to avoid build errors. */
>> +	if (oldregs) {
>> +		memcpy(newregs, oldregs, sizeof(*newregs));
>> +	} else {
>> +		__asm__ __volatile__ (
>> +			"stp	 x0,   x1, [%3]\n\t"
> 
> Why the tabs?
> 
> Please use #16 * N as the offset for consistency with entry.S, with 0
> for the first N.
> 
> [...]
> 
>> +static void machine_kexec_mask_interrupts(void)
>> +{
>> +	unsigned int i;
>> +	struct irq_desc *desc;
>> +
>> +	for_each_irq_desc(i, desc) {
>> +		struct irq_chip *chip;
>> +
>> +		chip = irq_desc_get_chip(desc);
>> +		if (!chip)
>> +			continue;
>> +
>> +		if (chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
>> +			chip->irq_eoi(&desc->irq_data);
>> +
>> +		if (chip->irq_mask)
>> +			chip->irq_mask(&desc->irq_data);
>> +
>> +		if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
>> +			chip->irq_disable(&desc->irq_data);
>> +	}
>> +}
> 
> I'm surprised that this isn't left to the irqchip driver init code in
> the crash kernel. For all we know this state could be corrupt anyway.

Indeed, parsing the irqdesc list is a recipe for disaster. Who knows
which locks have been taken or simply corrupted, pointers nuked...

> Is there any reason we can't get the GIC driver to nuke all of this at
> probe time?

This feels like the better option. I can cook a patch or two for that.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
