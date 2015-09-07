From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 07 Sep 2015 18:41:50 +0100
Subject: [PATCH v4 2/5] irqchip, gicv3: Workaround for Cavium ThunderX
 erratum 23154
In-Reply-To: <20150907171501.GD10645@e104818-lin.cambridge.arm.com>
References: <1439576885-15621-1-git-send-email-rric@kernel.org>
 <1439576885-15621-3-git-send-email-rric@kernel.org>
 <55EDC12E.8000408@arm.com>
 <20150907171501.GD10645@e104818-lin.cambridge.arm.com>
Message-ID: <55EDCC5E.9080203@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/15 18:15, Catalin Marinas wrote:
> On Mon, Sep 07, 2015 at 05:54:06PM +0100, Suzuki K. Poulose wrote:
>> On 14/08/15 19:28, Robert Richter wrote:
>>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>>> index c52f7ba205b4..4211c39b8744 100644
>>> --- a/drivers/irqchip/irq-gic-v3.c
>>> +++ b/drivers/irqchip/irq-gic-v3.c
>>> @@ -107,7 +107,7 @@ static void gic_redist_wait_for_rwp(void)
>>
>> ...
>>
>>> +}
>>> +
>>>   static void __maybe_unused gic_write_pmr(u64 val)
>>>   {
>>>   	asm volatile("msr_s " __stringify(ICC_PMR_EL1) ", %0" : : "r" (val));
>>> @@ -766,6 +798,12 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
>>>   	.free = gic_irq_domain_free,
>>>   };
>>>
>>> +static void gicv3_enable_quirks(void)
>>> +{
>>> +	if (cpus_have_cap(ARM64_WORKAROUND_CAVIUM_23154))
>>> +		static_key_slow_inc(&is_cavium_thunderx);
>>
>> May be you could use the enable() method added to struct arm64_cpu_capability
>> here to perform the above operation, added by James :
>>
>> commit 1c0763037f1e1caef739e36e09c6d41ed7b61b2d
>> Author: James Morse <james.morse@arm.com>
>> Date:   Tue Jul 21 13:23:28 2015 +0100
>>
>>      arm64: kernel: Add cpufeature 'enable' callback
>
> I thought about this as well when looking at the patch but decided it's
> better as it is. The "enable" method is meant to enable per-CPU features
> (or workarounds) but here it is about GICv3, so we don't want to enable
> for every CPU.

Right. I have been playing with a series where the checks are delayed until
all CPUs are brought up. But yes, I understand this usecase is slightly different
and may not match what I was thinking about.

May be, gic can have its own private list of _cpu_capability which it can run
over check_cpu_capabilities(), which it can run over and that will fall back to
what we have at the moment. So, may be what we have here is as good as we can
get.

Cheers
Suzuki
