From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 14 Mar 2018 13:50:55 +0000
Subject: [PATCH] irqchip/gic-v3: Ensure GICR_CTLR.EnableLPI=0 is observed
 before enabling
In-Reply-To: <cc2a59b5-e514-3336-67c7-7ae8fb80c5fe@codeaurora.org>
References: <1520988601-16705-1-git-send-email-shankerd@codeaurora.org>
 <86bmfrayts.wl-marc.zyngier@arm.com>
 <cc2a59b5-e514-3336-67c7-7ae8fb80c5fe@codeaurora.org>
Message-ID: <d1206fe2-0613-2a2a-a023-c083885232ea@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/03/18 13:33, Shanker Donthineni wrote:
> Hi Marc,
> 
> On 03/14/2018 02:41 AM, Marc Zyngier wrote:
>> Hi Shanker,
>>
>> On Wed, 14 Mar 2018 00:50:01 +0000,
>> Shanker Donthineni wrote:
>>>
>>> The definition of the GICR_CTLR.RWP control bit was expanded to indicate
>>> status of changing GICR_CTLR.EnableLPI from 1 to 0 is being in progress
>>> or completed. Software must observe GICR_CTLR.RWP==0 after clearing
>>> GICR_CTLR.EnableLPI from 1 to 0 and before writing GICR_PENDBASER and/or
>>> GICR_PROPBASER, otherwise behavior is UNPREDICTABLE.
>>>
>>> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
>>> ---
>>>  drivers/irqchip/irq-gic-v3-its.c   | 30 +++++++++++++++++++++++-------
>>>  include/linux/irqchip/arm-gic-v3.h |  1 +
>>>  2 files changed, 24 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>>> index 1d3056f..85cd158 100644
>>> --- a/drivers/irqchip/irq-gic-v3-its.c
>>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>>> @@ -1875,15 +1875,31 @@ static void its_cpu_init_lpis(void)
>>>  		gic_data_rdist()->pend_page = pend_page;
>>>  	}
>>>  
>>> -	/* Disable LPIs */
>>>  	val = readl_relaxed(rbase + GICR_CTLR);
>>> -	val &= ~GICR_CTLR_ENABLE_LPIS;
>>> -	writel_relaxed(val, rbase + GICR_CTLR);
>>>  
>>> -	/*
>>> -	 * Make sure any change to the table is observable by the GIC.
>>> -	 */
>>> -	dsb(sy);
>>> +	/* Make sure LPIs are disabled before programming PEND/PROP registers */
>>> +	if (val & GICR_CTLR_ENABLE_LPIS) {
>>> +		u32 count = 1000000; /* 1s! */
>>> +
>>> +		/* Disable LPIs */
>>> +		val &= ~GICR_CTLR_ENABLE_LPIS;
>>> +		writel_relaxed(val, rbase + GICR_CTLR);
>>> +
>>> +		/* Make sure any change to GICR_CTLR is observable by the GIC */
>>> +		dsb(sy);
>>> +
>>> +		/* Wait for GICR_CTLR.RWP==0 or timeout */
>>> +		while (readl_relaxed(rbase + GICR_CTLR) & GICR_CTLR_RWP) {
>>> +			if (!count) {
>>> +				pr_err("CPU%d: Failed to disable LPIs\n",
>>> +				       smp_processor_id());
>>> +				return;
>>> +			}
>>> +			cpu_relax();
>>> +			udelay(1);
>>> +			count--;
>>> +		};
>>> +	}
>>
>> I can see a couple of issues with this patch:
>>
>> - Entering the kernel with GICR_CTLR.EnableLPIs set is a recipe for
>>   memory corruption and is likely to lead to Bad Things(tm). A loud
>>   warning would be in order, I believe.
>>
> 
> I agree with you entering kernel with GICR_CTLR.EnableLPI=1 causes many
> issues. Unfortunately this is happening with KDUMP/KEXEC case. We don't
> disable GICD, GICRs and ITSs before loading the 2nd kernel. 

This is an orthogonal issue, and I'm working on an irqchip reset
infrastructure that would allow the GIC (and any other irqchip) to be
properly torn down on kexec. For kdump, there is nothing that can be
done, and we will rely on the secondary kernel to cleanup things, if at
all possible.

>> - If you're on a system that doesn't allow GICR_CTLR.Enable_LPIs to be
>>   cleared, we end-up going down the polling path for nothing. It'd be
>>   worth checking that the bit can be cleared the first place (and
>>   shout again if it cannot).
>>
> 
> This tells the bug in hardware but not in software, as per per spec it
> should be able to cleared by software. Any suggestions how software knows
> GICR_CTLR.EnableLPI bit can be cleared from enabled state.

That's not what the spec says: "After it has been written to 1, it is
IMPLEMENTATION DEFINED whether the bit becomes RES 1 or can be cleared
by to 0.".

So both implementations are valid. One is clearly superior to the other,
but we still need to deal with it. What you need to do is to try and
clear the EnableLPIs bit, and then check that it has actually cleared.
If it has, you start polling RWP. If it hasn't, you scream because the
system is likely to be broken (you shouldn't have used kexec/kdump the
first place).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
