From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 06 May 2017 12:25:02 +0100
Subject: [PATCH v4] irqchip/gicv3-its: Avoid memory over allocation for
 ITEs
In-Reply-To: <f3ca8eb8-88e9-6672-134a-d5eaac73f11f@codeaurora.org> (Shanker
 Donthineni's message of "Fri, 5 May 2017 17:04:22 -0500")
References: <1493562975-14365-1-git-send-email-shankerd@codeaurora.org>
 <87lgqfmdy7.fsf@on-the-bus.cambridge.arm.com>
 <f3ca8eb8-88e9-6672-134a-d5eaac73f11f@codeaurora.org>
Message-ID: <87vapekz1t.fsf@on-the-bus.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 05 2017 at 11:04:22 pm BST, Shanker Donthineni <shankerd@codeaurora.org> wrote:
> Hi Marc,
>
>
> On 05/02/2017 11:16 AM, Marc Zyngier wrote:
>> On Sun, Apr 30 2017 at  3:36:15 pm BST, Shanker Donthineni <shankerd@codeaurora.org> wrote:
>>> We are always allocating extra 255Bytes of memory to handle ITE
>>> physical address alignment requirement. The kmalloc() satisfies
>>> the ITE alignment since the ITS driver is requesting a minimum
>>> size of ITS_ITT_ALIGN bytes.
>>>
>>> Let's try to allocate the exact amount of memory that is required
>>> for ITEs to avoid wastage.
>>>
>>> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
>>> ---
>>> Changes:
>>> v2: removed 'Change-Id: Ia8084189833f2081ff13c392deb5070c46a64038' from commit.
>>> v3: changed from IITE to ITE.
>>> v3: removed fallback since kmalloc() guarantees the right alignment.
>>>
>>>  drivers/irqchip/irq-gic-v3-its.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>>> index 45ea1933..72e56f03 100644
>>> --- a/drivers/irqchip/irq-gic-v3-its.c
>>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>>> @@ -261,7 +261,6 @@ static struct its_collection *its_build_mapd_cmd(struct its_cmd_block *cmd,
>>>  	u8 size = ilog2(desc->its_mapd_cmd.dev->nr_ites);
>>>  
>>>  	itt_addr = virt_to_phys(desc->its_mapd_cmd.dev->itt);
>>> -	itt_addr = ALIGN(itt_addr, ITS_ITT_ALIGN);
>>>  
>>>  	its_encode_cmd(cmd, GITS_CMD_MAPD);
>>>  	its_encode_devid(cmd, desc->its_mapd_cmd.dev->device_id);
>>> @@ -1329,13 +1328,14 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
>>>  	 */
>>>  	nr_ites = max(2UL, roundup_pow_of_two(nvecs));
>>>  	sz = nr_ites * its->ite_size;
>>> -	sz = max(sz, ITS_ITT_ALIGN) + ITS_ITT_ALIGN - 1;
>>> +	sz = max(sz, ITS_ITT_ALIGN);
>>>  	itt = kzalloc(sz, GFP_KERNEL);
>>>  	lpi_map = its_lpi_alloc_chunks(nvecs, &lpi_base, &nr_lpis);
>>>  	if (lpi_map)
>>>  		col_map = kzalloc(sizeof(*col_map) * nr_lpis, GFP_KERNEL);
>>>  
>>> -	if (!dev || !itt || !lpi_map || !col_map) {
>>> +	if (!dev || !itt || !lpi_map || !col_map ||
>>> +	    !IS_ALIGNED(virt_to_phys(itt), ITS_ITT_ALIGN)) {
>>>  		kfree(dev);
>>>  		kfree(itt);
>>>  		kfree(lpi_map);
>> I'm confused. Either the alignment is guaranteed (and you should
>> document why it is so), or it is not, and we need to handle the
>> non-alignment (instead of failing).
>
> Sorry for confusion, alignment is guaranteed by kmalloc(), added a
> check for readability purpose only can be removed.

My question still remains. Where exactly is that alignment guarantee
documented and enforced? I can't see anything giving that certainty.

I would expect kmalloc to give you something that is cache-line aligned,
but probably nothing more than that. Now, I'd happily be proven wrong,
but so far, all I can see is that:

- ARCH_KMALLOC_MINALIGN is defined as ARCH_DMA_MINALIGN
- ARCH_DMA_MINALIGN is defined as L1_CACHE_BYTES
- L1_CACHE_BYTES is 128 on arm64, and either 32, 64, or 128 on arm.

What am I missing?

Thanks,

	M.
-- 
Jazz is not dead, it just smell funny.
