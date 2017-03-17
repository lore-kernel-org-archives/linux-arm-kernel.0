From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 17 Mar 2017 11:01:26 +0000
Subject: [PATCH 1/2] irqchip/gic-v3-its: bail out on already enabled LPIs
In-Reply-To: <db757dab-7ef8-45fd-873d-43cfcb59e264@codeaurora.org>
References: <20170316170542.3568-1-andre.przywara@arm.com>
 <20170316170542.3568-2-andre.przywara@arm.com>
 <e640f2c6-9445-ef85-ff80-6826fb230371@codeaurora.org>
 <8f9e3620-8c38-126b-2d90-ed5b07432e7e@arm.com>
 <db757dab-7ef8-45fd-873d-43cfcb59e264@codeaurora.org>
Message-ID: <446825ce-8a75-5567-f648-1946e75ce764@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/03/17 10:43, Shanker Donthineni wrote:
> Hi Marc,
> 
> 
> On 03/17/2017 04:46 AM, Marc Zyngier wrote:
>> Hi Shanker,
>>
>> On 16/03/17 17:25, Shanker Donthineni wrote:
>>> Hi Andre,
>>>
>>>
>>> On 03/16/2017 12:05 PM, Andre Przywara wrote:
>>>> The GICv3 spec says that once LPIs have been enabled, they can't be
>>>> disabled anymore:
>>>> "When a write changes this bit from 0 to 1, this bit becomes RES1 ..."
>>>> As we can't setup the pending and property table registers when LPIs are
>>>> enabled, we have to bail out here in this case.
>>>> But first try to disable LPIs anyway, to check whether this actually works.
>>>> If not, return an error.
>>>>
>>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>>> ---
>>>>  drivers/irqchip/irq-gic-v3-its.c | 36 ++++++++++++++++++++++++++++--------
>>>>  1 file changed, 28 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>>>> index f77f840..b777c57 100644
>>>> --- a/drivers/irqchip/irq-gic-v3-its.c
>>>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>>>> @@ -1082,12 +1082,30 @@ static int its_alloc_collections(struct its_node *its)
>>>>  	return 0;
>>>>  }
>>>>  
>>>> -static void its_cpu_init_lpis(void)
>>>> +static int its_cpu_init_lpis(void)
>>>>  {
>>>>  	void __iomem *rbase = gic_data_rdist_rd_base();
>>>>  	struct page *pend_page;
>>>>  	u64 val, tmp;
>>>>  
>>>> +	/*
>>>> +	 * Architecturally, once LPIs have been enabled on a specific
>>>> +	 * redistributor, they can't be disabled anymore (the enable
>>>> +	 * bit becomes RES1).
>>>> +	 * But as we can't setup the pending and property table registers
>>>> +	 * while LPIs are enabled, we are basically screwed in this case.
>>>> +	 * But be slightly more optimistic here, and actually check whether
>>>> +	 * this is really implemented like this.
>>>> +	 */
>>>> +	val = readl_relaxed(rbase + GICR_CTLR);
>>>> +	val &= ~GICR_CTLR_ENABLE_LPIS;
>>>> +	writel_relaxed(val, rbase + GICR_CTLR);
>>> Spec says we are not supposed to disable once it is enabled, why code
>>> is trying to disable? Why can't we check the enable bit without a
>>> write operation?
>> The reasoning here is that some implementation could support having
>> their LPI disabled (hint: a software implementation like the one we have
>> in KVM). As much as I'm willing to follow the architecture, I see little
>> value in not supporting something that trivial. But maybe we could quirk
>> it and not do that in the general case. Andre, what do you think?
>>
>>>> +	if (readl_relaxed(rbase + GICR_CTLR) & GICR_CTLR_ENABLE_LPIS) {
>>>> +		pr_warn("CPU%d: LPIs already enabled, cannot initialize redistributor\n",
>>>> +			smp_processor_id());
>>>> +		return -EBUSY;
>>>> +	}
>>>> +
>>>>  	/* If we didn't allocate the pending table yet, do it now */
>>>>  	pend_page = gic_data_rdist()->pend_page;
>>>>  	if (!pend_page) {
>>>> @@ -1101,7 +1119,7 @@ static void its_cpu_init_lpis(void)
>>>>  		if (!pend_page) {
>>>>  			pr_err("Failed to allocate PENDBASE for CPU%d\n",
>>>>  			       smp_processor_id());
>>>> -			return;
>>>> +			return -ENOMEM;
>>>>  		}
>>>>  
>>>>  		/* Make sure the GIC will observe the zero-ed page */
>>>> @@ -1113,11 +1131,6 @@ static void its_cpu_init_lpis(void)
>>>>  		gic_data_rdist()->pend_page = pend_page;
>>>>  	}
>>>>  
>>>> -	/* Disable LPIs */
>>>> -	val = readl_relaxed(rbase + GICR_CTLR);
>>>> -	val &= ~GICR_CTLR_ENABLE_LPIS;
>>>> -	writel_relaxed(val, rbase + GICR_CTLR);
>>>> -
>>>>  	/*
>>>>  	 * Make sure any change to the table is observable by the GIC.
>>>>  	 */
>>>> @@ -1174,6 +1187,8 @@ static void its_cpu_init_lpis(void)
>>>>  
>>>>  	/* Make sure the GIC has seen the above */
>>>>  	dsb(sy);
>>>> +
>>>> +	return 0;
>>>>  }
>>>>  
>>>>  static void its_cpu_init_collection(void)
>>>> @@ -1789,12 +1804,17 @@ static bool gic_rdists_supports_plpis(void)
>>>>  
>>>>  int its_cpu_init(void)
>>>>  {
>>>> +	int ret;
>>>> +
>>>>  	if (!list_empty(&its_nodes)) {
>>>>  		if (!gic_rdists_supports_plpis()) {
>>>>  			pr_info("CPU%d: LPIs not supported\n", smp_processor_id());
>>>>  			return -ENXIO;
>>>>  		}
>>>> -		its_cpu_init_lpis();
>>>> +		ret = its_cpu_init_lpis();
>>>> +		if (ret)
>>>> +			return ret;
>>> This is not enough, you have to skip all the disabled collections
>>> inside the function its_set_affinity() when mapping an event to
>>> collection. Otherwise all LPIs might mapped to collection 0, causes
>>> the possibility of memory corruption by GICR hardware on updating
>>> incorrect PENDING table.
>> I'm not sure I understand what you mean here.
> 
> Don't initialize a collection in case of errors is the right approach
> but rest of the ITS driver should not be accessing the disabled
> collection. It would be better to keep some kind of validation check
> inside function its_set_affinity().
> 
> static int its_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
>                 bool force)
> {
> ...
> 
>     target_col = &its_dev->its->collections[cpu];
>     its_send_movi(its_dev, target_col, id);
>     its_dev->event_map.col_map[id] = cpu;
> 
>     return IRQ_SET_MASK_OK_DONE;
> }

I think the big picture is to disable the ITS *and* not present it as an
MSI controller to the rest of the system. We should not even get here if
we find that we're in an unsafe situation. This may require significant
changes to the way we initialize the ITS.

>> But in any case, memory corruption may already have happened, and you
>> have no idea where. In general, finding LPIs being already enabled is
>> terminally unsafe unless we can key it on a particular implementation.
>>
> 
> Yes, because we are not disabling the ITS hardware in the first
> kernel. Better approach would be disable ITS hardware during the
> kernel shutdown path, but not during driver probe time. This way we
> can guarantee no memory corruption happens in the second (KEXEC0ed)
> kernel.

Again, that's a different thing altogether. I've long been toying with
the idea of having a .reset irqchip operation which could be called as
we're about to kexec another payload. This would nicely replace the
hacks we currently have to try and shut off interrupts. I'll try to cook
something.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
