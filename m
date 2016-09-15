From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 15 Sep 2016 09:13:49 +0100
Subject: [PATCH v26 2/7] arm64: kdump: implement machine_crash_shutdown()
In-Reply-To: <57D9925D.5000508@arm.com>
References: <20160907042908.6232-1-takahiro.akashi@linaro.org>
 <20160907042908.6232-3-takahiro.akashi@linaro.org> <57D9925D.5000508@arm.com>
Message-ID: <57DA583D.9030900@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

Thanks for cc-ing me.

On 14/09/16 19:09, James Morse wrote:
> Hi Akashi,
> 
> (CC: Marc who knows how this irqchip wizardry works
>  Cover letter: https://www.spinics.net/lists/arm-kernel/msg529520.html )
> 
> On 07/09/16 05:29, AKASHI Takahiro wrote:
>> Primary kernel calls machine_crash_shutdown() to shut down non-boot cpus
>> and save registers' status in per-cpu ELF notes before starting crash
>> dump kernel. See kernel_kexec().
>> Even if not all secondary cpus have shut down, we do kdump anyway.
>>
>> As we don't have to make non-boot(crashed) cpus offline (to preserve
>> correct status of cpus at crash dump) before shutting down, this patch
>> also adds a variant of smp_send_stop().
>>
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> ---
>>  arch/arm64/include/asm/hardirq.h  |  2 +-
>>  arch/arm64/include/asm/kexec.h    | 41 ++++++++++++++++++++++++-
>>  arch/arm64/include/asm/smp.h      |  2 ++
>>  arch/arm64/kernel/machine_kexec.c | 56 ++++++++++++++++++++++++++++++++--
>>  arch/arm64/kernel/smp.c           | 63 +++++++++++++++++++++++++++++++++++++++
>>  5 files changed, 159 insertions(+), 5 deletions(-)

[...]

>> +static void machine_kexec_mask_interrupts(void)
>> +{
>> +	unsigned int i;
>> +	struct irq_desc *desc;
>> +
>> +	for_each_irq_desc(i, desc) {
>> +		struct irq_chip *chip;
>> +		int ret;
>> +
>> +		chip = irq_desc_get_chip(desc);
>> +		if (!chip)
>> +			continue;
>> +
>> +		/*
>> +		 * First try to remove the active state. If this
>> +		 * fails, try to EOI the interrupt.
>> +		 */
>> +		ret = irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);
>> +
>> +		if (ret && irqd_irq_inprogress(&desc->irq_data) &&
>> +		    chip->irq_eoi)
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
> This function is over my head ... I have no idea how this works, I can only
> comment that its different to the version under arch/arm
> 
> /me adds Marc Z to CC.

I wrote the damn code! ;-)

The main idea is that simply EOIing an interrupt is not good enough if
the interrupt has been offloaded to a VM. It needs to be actively
deactivated for the state machine to be reset.

But realistically, even that is not enough. What we need is a way to
completely shut off the GIC, irrespective of the state of the various
interrupts. A "panic button" of some sort, with no return.

That would probably work for GICv3 (assuming that we don't need to
involve the secure side of things), but anything GICv2 based would be
difficult to deal with (you cannot access the other CPU private
interrupt configuration). Maybe that'd be enough, maybe not. Trying to
boot a crash kernel is like buying a lottery ticket anyway (and with
similar odds...).

I'll have a look.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
