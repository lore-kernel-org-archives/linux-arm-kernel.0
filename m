From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 15 Mar 2017 18:46:22 +0000
Subject: [PATCH v2 8/8] irqchip, gicv3-its, cma: Use CMA for allocation of
 large device tables
In-Reply-To: <20170315183734.GW16822@rric.localdomain>
References: <20170306125739.19445-1-rrichter@cavium.com>
 <20170306125739.19445-9-rrichter@cavium.com>
 <3c462655-fb2c-ede7-1dc0-ca5c7f64904f@codeaurora.org>
 <20170315183734.GW16822@rric.localdomain>
Message-ID: <9b492795-3759-801e-c77d-e74e86c814d1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/03/17 18:37, Robert Richter wrote:
> On 14.03.17 12:40:45, Shanker Donthineni wrote:
> 
>> I don't see anywhere in this patch, code calls explicitly CMA API to
>> allocate memory for device table.  The CMA feature is an optional in
>> kernel, and will be handled transparently inside the the DMA
>> layer. It would be nicer to not mention CMA word in the commit
>> subject.
> 
> Still CMA is *essential* and used for large tables. IMO this needs to
> be emphasized. That's the reason for using devm_alloc_coherent().
> 
>> On 03/06/2017 06:57 AM, Robert Richter wrote:
>>> The gicv3-its device table may have a size of up to 16MB. With 4k
>>> pagesize the maximum size of memory allocation is 4MB. Use CMA for
>>> allocation of large tables.
>> Just say use devm_alloc_coherent() to allocate memory.
>>
>>> We use the device managed version of dma_alloc_coherent(). Thus, we
>>> don't need to release it manually on device removal.
>>>
>>> Signed-off-by: Robert Richter <rrichter@cavium.com>
>>> ---
>>>  drivers/irqchip/irq-gic-v3-its.c | 69 +++++++++++++++++++++++-----------------
>>>  1 file changed, 40 insertions(+), 29 deletions(-)
>>>
>>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>>> index 6625b3a505f0..6d293a0165b0 100644
>>> --- a/drivers/irqchip/irq-gic-v3-its.c
>>> +++ b/drivers/irqchip/irq-gic-v3-its.c
> 
>>> @@ -876,13 +878,26 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
>>>  		order = get_order(GITS_BASER_PAGES_MAX * psz);
>>>  	}
>>>  
>>> -	base = (void *)devm_get_free_pages(&its->dev, GFP_KERNEL | __GFP_ZERO,
>>> -					   order);
>>> -	if (!base)
>>> +	base = dmam_alloc_coherent(&its->dev,
>>> +				PAGE_ORDER_TO_SIZE(order),
>>> +				&dma_handle,
>>> +				GFP_KERNEL | __GFP_ZERO);
> 
>> Not just for 1st level device table, you have do a similar code
>> change when allocating memory for 2nd level device table.
> 
> The 2nd level tables are much smaller, so no need for
> dmam_alloc_coherent() there.
> 
> Though, we could use device managed devm_get_free_pages() there too.
> 
>>> +
>>> +	if (!base && order >= MAX_ORDER) {
>>> +		order = MAX_ORDER - 1;
>>> +		dev_warn(&its->dev, "Device Table too large, reduce ids %u->%u, no CMA memory available\n",
>>> +			its->device_ids,
>>> +			ilog2(PAGE_ORDER_TO_SIZE(order) / (int)esz));
>>> +		goto retry_alloc_baser;
>>> +	}
>>> +
>>> +	if (!base) {
>>> +		dev_err(&its->dev, "Failed to allocate device table\n");
>>>  		return -ENOMEM;
>>> +	}
> 
>>> @@ -1698,6 +1706,9 @@ static int __init its_init_one(struct its_node *its)
>>>  		return err;
>>>  	}
>>>  
>>> +	/* Setup dma_ops for dmam_alloc_coherent() */
>>> +	arch_setup_dma_ops(&its->dev, 0, 0, NULL, true);
>>> +
> 
>> Why you are hard-coding DMA coherent property to true here ? It
>> breaks the MSI(x) functionally on systems where ITS hardware doesn't
>> support coherency.
> 
> Aren't current ITS tables coherent only?

No, there is no such guarantee. Actually, there is strictly no need for
coherency, as the ITS tables are only written by the ITS itself, for its
own purpose.

The only things that may benefit from coherency are the property table
and the command queue.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
