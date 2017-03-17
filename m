From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 17 Mar 2017 15:33:39 +0000
Subject: [PATCH v3] irqchip/gicv3-its: Avoid memory over allocation for
 ITEs
In-Reply-To: <f91e706e-c0b1-cf38-484a-1965435ad5bb@codeaurora.org>
References: <1488896720-6223-1-git-send-email-shankerd@codeaurora.org>
 <b74f8fbb-0d9a-b1e2-83d2-ba9c1a858222@arm.com>
 <f91e706e-c0b1-cf38-484a-1965435ad5bb@codeaurora.org>
Message-ID: <24159fb4-0438-9f9e-9e28-6ac573f6b6f6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/03/17 14:18, Shanker Donthineni wrote:
> Hi Marc,
> 
> 
> On 03/17/2017 08:50 AM, Marc Zyngier wrote:
>> On 07/03/17 14:25, Shanker Donthineni wrote:
>>> We are always allocating extra 255Bytes of memory to handle ITE
>>> physical address alignment requirement. The kmalloc() satisfies
>>> the ITE alignment since the ITS driver is requesting a minimum
>>> size of ITS_ITT_ALIGN bytes.
>>>
>>> Let's try to allocate the exact amount of memory that is required
>>> for ITEs to avoid wastage.
>>>
>>> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
>>> ---Hi 
>>> v2: removed 'Change-Id: Ia8084189833f2081ff13c392deb5070c46a64038' from commit.
>>> v3: changed from IITE to ITE.
>>>
>>>  drivers/irqchip/irq-gic-v3-its.c | 7 ++++++-
>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>>> index 86bd428..5aeca78 100644
>>> --- a/drivers/irqchip/irq-gic-v3-its.c
>>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>>> @@ -1329,8 +1329,13 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
>>>  	 */
>>>  	nr_ites = max(2UL, roundup_pow_of_two(nvecs));
>>>  	sz = nr_ites * its->ite_size;
>>> -	sz = max(sz, ITS_ITT_ALIGN) + ITS_ITT_ALIGN - 1;
>>> +	sz = max(sz, ITS_ITT_ALIGN);
>>>  	itt = kzalloc(sz, GFP_KERNEL);
>>> +	if (itt && !IS_ALIGNED(virt_to_phys(itt), ITS_ITT_ALIGN)) {
>>> +		kfree(itt);
>>> +		itt = kzalloc(sz + ITS_ITT_ALIGN - 1, GFP_KERNEL);
>>> +	}
>>> +
>> Is this really worth the complexity? Are you aware of a system where the
>> accumulation of overallocation actually shows up as being an issue?
> 
> As such there is no issue with over allocation. Actually this change masked QDF2400 bug 'iirqchip/gicv3-its: Add workaround for QDF2400 ITS erratum 0065' till now, found and fixed recently while looking at the code for possible memory optimizations.
>  
>> If you want to be absolutely exact in your allocation, then I'd suggest
>> doing it all the time, and have a proper dedicated allocator that always
>> do the right thing, without a wasteful fallback like you still have here.
> 
> We don't need to fallbak, and it can be removed safely. Looking for
> your suggestion. should I implement a dedicated allocator or remove
> fallbak for simpler code?

Are you saying that kmalloc is guaranteed to give us something that is
256 byte aligned? If so, why do we test for alignment (with free +
over-allocate if it fails)?

I'd rather have only one way of allocating the ITT. Either we always
overallocate in order to guarantee right alignment (and my personal view
is that for most system, this doesn't matter at all), or we create our
own allocator. The issue with the latter is that we don't really have a
good story for allocating arrays of objects with a given alignment
(kmem_cache_* only deals with single objects).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
