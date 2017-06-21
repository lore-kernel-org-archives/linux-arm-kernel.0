From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Tue, 20 Jun 2017 20:22:40 -0500
Subject: [PATCH v4] irqchip/gicv3-its: Avoid memory over allocation for
 ITEs
In-Reply-To: <87vapekz1t.fsf@on-the-bus.cambridge.arm.com>
References: <1493562975-14365-1-git-send-email-shankerd@codeaurora.org>
 <87lgqfmdy7.fsf@on-the-bus.cambridge.arm.com>
 <f3ca8eb8-88e9-6672-134a-d5eaac73f11f@codeaurora.org>
 <87vapekz1t.fsf@on-the-bus.cambridge.arm.com>
Message-ID: <599e5af4-26c9-a17c-c058-c49285a5ff60@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 05/06/2017 06:25 AM, Marc Zyngier wrote:
> On Fri, May 05 2017 at 11:04:22 pm BST, Shanker Donthineni <shankerd@codeaurora.org> wrote:
>> Hi Marc,
>>
>>
>> On 05/02/2017 11:16 AM, Marc Zyngier wrote:
>>> On Sun, Apr 30 2017 at  3:36:15 pm BST, Shanker Donthineni <shankerd@codeaurora.org> wrote:
>>>> We are always allocating extra 255Bytes of memory to handle ITE
>>>> physical address alignment requirement. The kmalloc() satisfies
>>>> the ITE alignment since the ITS driver is requesting a minimum
>>>> size of ITS_ITT_ALIGN bytes.
>>>>
>>>> Let's try to allocate the exact amount of memory that is required
>>>> for ITEs to avoid wastage.
>>>>
>>>> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
>>>> ---
>>>> Changes:
>>>> v2: removed 'Change-Id: Ia8084189833f2081ff13c392deb5070c46a64038' from commit.
>>>> v3: changed from IITE to ITE.
>>>> v3: removed fallback since kmalloc() guarantees the right alignment.
>>>>
>>>>  drivers/irqchip/irq-gic-v3-its.c | 6 +++---
>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>>>> index 45ea1933..72e56f03 100644
>>>> --- a/drivers/irqchip/irq-gic-v3-its.c
>>>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>>>> @@ -261,7 +261,6 @@ static struct its_collection *its_build_mapd_cmd(struct its_cmd_block *cmd,
>>>>  	u8 size = ilog2(desc->its_mapd_cmd.dev->nr_ites);
>>>>  
>>>>  	itt_addr = virt_to_phys(desc->its_mapd_cmd.dev->itt);
>>>> -	itt_addr = ALIGN(itt_addr, ITS_ITT_ALIGN);
>>>>  
>>>>  	its_encode_cmd(cmd, GITS_CMD_MAPD);
>>>>  	its_encode_devid(cmd, desc->its_mapd_cmd.dev->device_id);
>>>> @@ -1329,13 +1328,14 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
>>>>  	 */
>>>>  	nr_ites = max(2UL, roundup_pow_of_two(nvecs));
>>>>  	sz = nr_ites * its->ite_size;
>>>> -	sz = max(sz, ITS_ITT_ALIGN) + ITS_ITT_ALIGN - 1;
>>>> +	sz = max(sz, ITS_ITT_ALIGN);
>>>>  	itt = kzalloc(sz, GFP_KERNEL);
>>>>  	lpi_map = its_lpi_alloc_chunks(nvecs, &lpi_base, &nr_lpis);
>>>>  	if (lpi_map)
>>>>  		col_map = kzalloc(sizeof(*col_map) * nr_lpis, GFP_KERNEL);
>>>>  
>>>> -	if (!dev || !itt || !lpi_map || !col_map) {
>>>> +	if (!dev || !itt || !lpi_map || !col_map ||
>>>> +	    !IS_ALIGNED(virt_to_phys(itt), ITS_ITT_ALIGN)) {
>>>>  		kfree(dev);
>>>>  		kfree(itt);
>>>>  		kfree(lpi_map);
>>> I'm confused. Either the alignment is guaranteed (and you should
>>> document why it is so), or it is not, and we need to handle the
>>> non-alignment (instead of failing).
>>
>> Sorry for confusion, alignment is guaranteed by kmalloc(), added a
>> check for readability purpose only can be removed.
> 
> My question still remains. Where exactly is that alignment guarantee
> documented and enforced? I can't see anything giving that certainty.
> 

The internal implementation of kmalloc() uses the slab/slub feature to allocate memory from 2^N size pool. Linux kernel maintains the fixed size of kmem_cache pools to serve the kmalloc(), It allocates minimum size of 128Bytes and maximum size depends on the system configuration and memory availability. In fact SMMUv3 driver has a similar requirement and absolutely there no problem using kmalloc() to meet the address alignment requirement.

Call trace:
    kmalloc()
      kmalloc_slab() --> convert size to kmem_cache
      slab_alloc()   ---> allocate 2^N size kmem_cache object
   
root at null-8cfdf006971f:~# cat /proc/slabinfo | grep kmall
dma-kmalloc-131072     0      0 131072    4    8 : tunables    0    0    0 : slabdata      0      0      0
dma-kmalloc-65536      0      0  65536    8    8 : tunables    0    0    0 : slabdata      0      0      0
dma-kmalloc-32768      0      0  32768   16    8 : tunables    0    0    0 : slabdata      0      0      0
dma-kmalloc-16384      0      0  16384   32    8 : tunables    0    0    0 : slabdata      0      0      0
dma-kmalloc-8192       0      0   8192   32    4 : tunables    0    0    0 : slabdata      0      0      0
dma-kmalloc-4096       0      0   4096   32    2 : tunables    0    0    0 : slabdata      0      0      0
dma-kmalloc-2048       0      0   2048   32    1 : tunables    0    0    0 : slabdata      0      0      0
dma-kmalloc-1024       0      0   1024   64    1 : tunables    0    0    0 : slabdata      0      0      0
dma-kmalloc-512      128    128    512  128    1 : tunables    0    0    0 : slabdata      1      1      0
dma-kmalloc-256        0      0    256  256    1 : tunables    0    0    0 : slabdata      0      0      0
dma-kmalloc-128      512    512    128  512    1 : tunables    0    0    0 : slabdata      1      1      0
kmalloc-131072         4      4 131072    4    8 : tunables    0    0    0 : slabdata      1      1      0
kmalloc-65536        376    376  65536    8    8 : tunables    0    0    0 : slabdata     47     47      0
kmalloc-32768        320    320  32768   16    8 : tunables    0    0    0 : slabdata     20     20      0
kmalloc-16384       5248   5248  16384   32    8 : tunables    0    0    0 : slabdata    164    164      0
kmalloc-8192        2176   2176   8192   32    4 : tunables    0    0    0 : slabdata     68     68      0
kmalloc-4096        4452   4576   4096   32    2 : tunables    0    0    0 : slabdata    143    143      0
kmalloc-2048        4416   4416   2048   32    1 : tunables    0    0    0 : slabdata    138    138      0
kmalloc-1024       10048  10176   1024   64    1 : tunables    0    0    0 : slabdata    159    159      0
kmalloc-512        19071  19584    512  128    1 : tunables    0    0    0 : slabdata    153    153      0
kmalloc-256        75873  77312    256  256    1 : tunables    0    0    0 : slabdata    302    302      0
kmalloc-128        82078  85504    128  512    1 : tunables    0    0    0 : slabdata    167    167      0
             

> I would expect kmalloc to give you something that is cache-line aligned,
> but probably nothing more than that. Now, I'd happily be proven wrong,
> but so far, all I can see is that:
> 
> - ARCH_KMALLOC_MINALIGN is defined as ARCH_DMA_MINALIGN
> - ARCH_DMA_MINALIGN is defined as L1_CACHE_BYTES
> - L1_CACHE_BYTES is 128 on arm64, and either 32, 64, or 128 on arm.
> 

Kmalloc always allocates memory with size=roundup_pow_of_two(size) and address alignment roundup_pow_of_two(size).   

> What am I missing?
> 
> Thanks,
> 
> 	M.
> 

-- 
Shanker Donthineni
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
