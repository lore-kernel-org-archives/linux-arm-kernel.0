From: dave.long@linaro.org (David Long)
Date: Fri, 20 May 2016 00:18:03 -0400
Subject: [PATCH v12 01/10] arm64: Add HAVE_REGS_AND_STACK_ACCESS_API
 feature
In-Reply-To: <20160517091446.GB5082@sha-win-210.asiapac.arm.com>
References: <1461783185-9056-1-git-send-email-dave.long@linaro.org>
 <1461783185-9056-2-git-send-email-dave.long@linaro.org>
 <20160517091446.GB5082@sha-win-210.asiapac.arm.com>
Message-ID: <573E8FFB.3000107@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/17/2016 05:14 AM, Huang Shijie wrote:
> On Wed, Apr 27, 2016 at 02:52:56PM -0400, David Long wrote:
>> From: "David A. Long" <dave.long@linaro.org>
>> +/**
>> + * regs_within_kernel_stack() - check the address in the stack
>> + * @regs:      pt_regs which contains kernel stack pointer.
>> + * @addr:      address which is checked.
>> + *
>> + * regs_within_kernel_stack() checks @addr is within the kernel stack page(s).
>> + * If @addr is within the kernel stack, it returns true. If not, returns false.
>> + */
>> +bool regs_within_kernel_stack(struct pt_regs *regs, unsigned long addr)
>> +{
>> +	return ((addr & ~(THREAD_SIZE - 1))  ==
>> +		(kernel_stack_pointer(regs) & ~(THREAD_SIZE - 1))) ||
>> +		on_irq_stack(addr, raw_smp_processor_id());
>> +}
>> +
>> +/**
>> + * regs_get_kernel_stack_nth() - get Nth entry of the stack
>> + * @regs:	pt_regs which contains kernel stack pointer.
>> + * @n:		stack entry number.
>> + *
>> + * regs_get_kernel_stack_nth() returns @n th entry of the kernel stack which
>> + * is specified by @regs. If the @n th entry is NOT in the kernel stack,
>> + * this returns 0.
>> + */_
>> +unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs, unsigned int n)
>> +{
>> +	unsigned long *addr = (unsigned long *)kernel_stack_pointer(regs);
>> +
>> +	addr += n;
>> +	if (regs_within_kernel_stack(regs, (unsigned long)addr))
> If the @addr fall in the interrupt stack, the regs_within_kernel_stack()
> will return true. But Is it what we want?
>

Yes, I think it is.  The function is used in regs_get_kernel_stack_nth() 
to make sure the data being asked for (based on the pt_regs saved stack 
pointer) is actually on the stack, whether it's "kernel" stack or "irq" 
stack.

Thanks,
-dl
