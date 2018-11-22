From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 22 Nov 2018 16:36:17 +0000
Subject: arm: dma-mapping: CPU may not see up-to-date data after DMA
 transaction
In-Reply-To: <1542900920.26115.92.camel@atviedlbe741.rss.d3s.at.thales>
References: <1542872133.26115.4.camel@atviedlbe741.rss.d3s.at.thales>
 <20181122092928.GF30658@n2100.armlinux.org.uk>
 <1542889465.26115.54.camel@atviedlbe741.rss.d3s.at.thales>
 <20181122125100.GG30658@n2100.armlinux.org.uk>
 <1542900920.26115.92.camel@atviedlbe741.rss.d3s.at.thales>
Message-ID: <96204a43-d2c6-aa5a-7b23-64e2ba12a800@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/11/2018 15:36, JABLONSKY Jan wrote:
> Yes, you have right,
> 
> Synopsys DesignWare Multimedia Card Interface driver dw_mmc
> 
> SoC is using internal DMA controller (IDMAC)
> A Few days ago, I also analyzed driver and proper using of DMA-API.
> I found in dw_mci_dmac_complete_dma callback function, that invalidation of caches is performed only in the case
> of external DMA.
> https://lore.kernel.org/patchwork/patch/1015401/
> 
> there is some significant progress, but the problem still occurs

Frankly, dw_mci_dmac_complete_dma() looks pretty bogus anyway - that 
dma_sync_sg_for_cpu() is immediately before a call to 
host->dma_ops->cleanup(), which does the dma_unmap_sg() that I would 
expect to see at the end of a DMA transfer. So at best that sync should 
just be redundant with the unmap in terms of cache maintenance, but the 
fact that is uses a hard-coded direction and a possibly different device 
really smells of that driver being a lot more rotten in general.

Robin.

> 
> 
> The idea behind using function __sync_cache_range_r is, that the sequence
> of cache maintaining is similar as described in L2 cache controller TRM to ensure coherency
> 
> http://infocenter.arm.com/help/topic/com.arm.doc.ddi0246h/DDI0246H_l2c310_r3p3_trm.pdf
> 
> Perform a combination of Clean and Invalidate operations that ensures coherency from
> the outside in, and from the inside out.
> 
> CleanLevel1 Address ; This is broadcast within the cluster
> DSB ; Ensure completion of the clean as far as Level 2
> Clean&InvalLevel2 Address ; forces the address out past level 2
> SYNC ; Ensures completion of the L2 inval
> Clean&InvalLevel1 Address ; This is broadcast within the cluster
> DSB ; Ensure completion of the clean&inval as far as Level 2 (no data lost)
> 
> With mentioned sequence, I really can see big difference.
> But anyway, I understand what you mean, I will continue with the analysis
> 
> 
> 
> 
> 
> On Do, 2018-11-22 at 12:51 +0000, Russell King - ARM Linux wrote:
>> On Thu, Nov 22, 2018 at 12:25:18PM +0000, JABLONSKY Jan wrote:
>>> After DMA transaction is complete, content of the DMA buffer is stored in the main memory.
>>>
>>> outer_inv_range invalidates cache lines only in L2 level.
>>
>> Correct.
>>
>>> outer_cache is dedicated to L2 cache, but CPU must also clean L1 dcache to avoid possible L1 hit
>>
>> Correct, except we _do_ handle the L1 cache.  See dmac_*_area functions
>> that are already being called via dma_cache_maint_page().  You did
>> analyse the code before proposing these modifications? ;)
>>
>> Given that we already handle the L1 cache, why do we need more L1 cache
>> maintanence?
>>
>> In any case, in your patch, using phys_to_virt() on the addresses is
>> utterly wrong, and will lead to hitting the wrong memory if the physical
>> address is a highmem page (this is why we have dma_cache_maint_page(),
>> which has the necessary code to handle this case.)  The physical to
>> virtual translation functions and macros are only valid for lowmem.
>>
>> So, I think your patch actually ends up breaking stuff by doing cache
>> maintanence on unexpected memory locations.
>>
>> Given, also, that we have shed-loads of Cortex A9 systems out there,
>> using DMA with MMC, some using it for the rootfs, I doubt that the
>> problem lies here but elsewhere - which MMC host controller are you
>> using?  Has that driver been properly reviewed - does it use the DMA
>> API correctly?  Does it use the correct DMA direction (which should
>> always be the same for all DMA API operations on the buffer.)
>>
>> It could also be a hardware bug (which is suggested with your
>> modifications to disable preemption).  As cache maintanence is
>> broadcasted across all cores in a SMP system with Cortex A9, it should
>> not matter whether we are pre-empted during cache handling for DMA.  If
>> disabling preemption makes a difference for that, it probably means you
>> have bigger coherency issues on your SoC.
>>
>> Yes, you may have found a rare corner case, but we really need to fully
>> understand the details of what is going on here _before_ making radical
>> changes to code that has been proven by probably billions of users over
>> the course of the last nine years.
>>
>> Thanks.
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
