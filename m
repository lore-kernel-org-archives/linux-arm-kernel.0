From: tnowicki@caviumnetworks.com (Tomasz Nowicki)
Date: Tue, 19 Sep 2017 10:10:26 +0200
Subject: [PATCH 1/1] iommu/iova: Make rcache flush optional on IOVA
 allocation failure
In-Reply-To: <da87f76b-bcd4-ace8-4dd6-166dfde136e3@codeaurora.org>
References: <1505732214-9052-1-git-send-email-tomasz.nowicki@caviumnetworks.com>
 <1505732214-9052-2-git-send-email-tomasz.nowicki@caviumnetworks.com>
 <250f41c9-fb37-49b7-c336-68e163f77e16@arm.com>
 <da87f76b-bcd4-ace8-4dd6-166dfde136e3@codeaurora.org>
Message-ID: <03297a05-8490-a86d-12ab-a99cf73c09ba@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nate,

On 19.09.2017 04:57, Nate Watterson wrote:
> Hi Tomasz,
> 
> On 9/18/2017 12:02 PM, Robin Murphy wrote:
>> Hi Tomasz,
>>
>> On 18/09/17 11:56, Tomasz Nowicki wrote:
>>> Since IOVA allocation failure is not unusual case we need to flush
>>> CPUs' rcache in hope we will succeed in next round.
>>>
>>> However, it is useful to decide whether we need rcache flush step 
>>> because
>>> of two reasons:
>>> - Not scalability. On large system with ~100 CPUs iterating and flushing
>>>    rcache for each CPU becomes serious bottleneck so we may want to 
>>> deffer it.
> s/deffer/defer
> 
>>> - free_cpu_cached_iovas() does not care about max PFN we are 
>>> interested in.
>>>    Thus we may flush our rcaches and still get no new IOVA like in the
>>>    commonly used scenario:
>>>
>>>      if (dma_limit > DMA_BIT_MASK(32) && dev_is_pci(dev))
>>>          iova = alloc_iova_fast(iovad, iova_len, DMA_BIT_MASK(32) >> 
>>> shift);
>>>
>>>      if (!iova)
>>>          iova = alloc_iova_fast(iovad, iova_len, dma_limit >> shift);
>>>
>>>     1. First alloc_iova_fast() call is limited to DMA_BIT_MASK(32) to 
>>> get
>>>        PCI devices a SAC address
>>>     2. alloc_iova() fails due to full 32-bit space
>>>     3. rcaches contain PFNs out of 32-bit space so 
>>> free_cpu_cached_iovas()
>>>        throws entries away for nothing and alloc_iova() fails again
>>>     4. Next alloc_iova_fast() call cannot take advantage of rcache 
>>> since we
>>>        have just defeated caches. In this case we pick the slowest 
>>> option
>>>        to proceed.
>>>
>>> This patch reworks flushed_rcache local flag to be additional function
>>> argument instead and control rcache flush step. Also, it updates all 
>>> users
>>> to do the flush as the last chance.
>>
>> Looks like you've run into the same thing Nate found[1] - I came up with
>> almost the exact same patch, only with separate alloc_iova_fast() and
>> alloc_iova_fast_noretry() wrapper functions, but on reflection, just
>> exposing the bool to callers is probably simpler. One nit, can you
>> document it in the kerneldoc comment too? With that:
>>
>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>>
>> Thanks,
>> Robin.
>>
>> [1]:https://www.mail-archive.com/iommu at lists.linux-foundation.org/msg19758.html 
>>
> This patch completely resolves the issue I reported in [1]!!

I somehow missed your observations in [1] :/
Anyway, it's great it fixes performance for you too.

> Tested-by: Nate Watterson <nwatters@codeaurora.org>

Thanks!
Tomasz
