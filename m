From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 20 Jul 2016 17:31:16 +0100
Subject: [PATCH v15 04/10] arm64: Kprobes with single stepping support
In-Reply-To: <20160720162827.GF25890@e104818-lin.cambridge.arm.com>
References: <1467995754-32508-1-git-send-email-dave.long@linaro.org>
 <1467995754-32508-5-git-send-email-dave.long@linaro.org>
 <578FA238.3050206@arm.com>
 <20160720162827.GF25890@e104818-lin.cambridge.arm.com>
Message-ID: <578FA754.7050208@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/07/16 17:28, Catalin Marinas wrote:
> On Wed, Jul 20, 2016 at 05:09:28PM +0100, Marc Zyngier wrote:
>> +static inline unsigned long min_stack_size(unsigned long addr)
>> +{
>> +	unsigned long size;
>> +	struct kprobe_ctlblk *ctl;
>> +
>> +	if (on_irq_stack(addr, raw_smp_processor_id()))
>> +		size = IRQ_STACK_PTR(raw_smp_processor_id()) - addr;
>> +	else
>> +		size = (unsigned long)current_thread_info() + THREAD_START_SP - addr;
>> +
>> +	return min(size, sizeof(ctl->jprobes_stack));
>> +}
> 
> We could drop the local ctl pointer:
> 
> 	return min(size, sizeof(((struct kprobe_ctlblk *)0)->jprobes_stack));
> 
> If you add a log, I'll push the patch on top of the kprobes branch.

Sure, I'll write that now.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
