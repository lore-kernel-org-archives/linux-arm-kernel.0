From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 16 Mar 2017 13:41:51 +0000
Subject: [PATCH v2 8/8] irqchip, gicv3-its, cma: Use CMA for allocation of
 large device tables
In-Reply-To: <20170316133154.GA16822@rric.localdomain>
References: <20170306125739.19445-1-rrichter@cavium.com>
 <20170306125739.19445-9-rrichter@cavium.com>
 <3c462655-fb2c-ede7-1dc0-ca5c7f64904f@codeaurora.org>
 <20170315183734.GW16822@rric.localdomain>
 <9b492795-3759-801e-c77d-e74e86c814d1@arm.com>
 <20170316133154.GA16822@rric.localdomain>
Message-ID: <a00390ef-808d-59ea-521c-b759a00b5951@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/03/17 13:31, Robert Richter wrote:
> On 15.03.17 18:46:22, Marc Zyngier wrote:
>> On 15/03/17 18:37, Robert Richter wrote:
>>> On 14.03.17 12:40:45, Shanker Donthineni wrote:
> 
>>>>> @@ -1698,6 +1706,9 @@ static int __init its_init_one(struct its_node *its)
>>>>>  		return err;
>>>>>  	}
>>>>>  
>>>>> +	/* Setup dma_ops for dmam_alloc_coherent() */
>>>>> +	arch_setup_dma_ops(&its->dev, 0, 0, NULL, true);
>>>>> +
>>>
>>>> Why you are hard-coding DMA coherent property to true here ? It
>>>> breaks the MSI(x) functionally on systems where ITS hardware doesn't
>>>> support coherency.
>>>
>>> Aren't current ITS tables coherent only?
>>
>> No, there is no such guarantee. Actually, there is strictly no need for
>> coherency, as the ITS tables are only written by the ITS itself, for its
>> own purpose.
> 
> So no need to change that, right?

I don't think there is any. We just need to allocate memory with the
relevant constraints (alignment and zeroing, mostly), and make sure we
never access it directly. Of course, property tables and command queues
would benefit from being allocated as DMA buffers, which would allow the
cache flush to be dealt with at the DMA level.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
