From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 2 Nov 2012 14:25:05 +0530
Subject: [PATCH 3/3] ARM: OMAP: Remove plat-omap/common.c
In-Reply-To: <5093891D.6070302@ti.com>
References: <20121101224703.2103.95474.stgit@muffinssi.local>
 <20121101224828.2103.82950.stgit@muffinssi.local> <50936A6E.3020202@ti.com>
 <5093891D.6070302@ti.com>
Message-ID: <50938A69.9040908@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 November 2012 02:19 PM, Tomi Valkeinen wrote:
> On 2012-11-02 08:38, Santosh Shilimkar wrote:
>> Tony,
>>
>> On Friday 02 November 2012 04:18 AM, Tony Lindgren wrote:
>>> This file has only omap_init_consistent_dma_size()
>>> left that can be moved to plat-omap/dma.c.
>>>
>>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>>> ---
>>>    arch/arm/plat-omap/Makefile |    2 +-
>>>    arch/arm/plat-omap/common.c |   26 --------------------------
>>>    arch/arm/plat-omap/dma.c    |    8 ++++++++
>>>    3 files changed, 9 insertions(+), 27 deletions(-)
>>>    delete mode 100644 arch/arm/plat-omap/common.c
>>>
>>
>> [..]
>>
>>> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
>>> index c288b76..00a3a53 100644
>>> --- a/arch/arm/plat-omap/dma.c
>>> +++ b/arch/arm/plat-omap/dma.c
>>> @@ -2146,6 +2146,14 @@ static struct platform_driver
>>> omap_system_dma_driver = {
>>>        },
>>>    };
>>>
>>> +/* This must be called from init_early() */
>>> +void __init omap_init_consistent_dma_size(void)
>>> +{
>>> +#ifdef CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE
>>> +    init_consistent_dma_size(CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE << 20);
>>> +#endif
>>> +}
>>> +
>> Lets not move this in DMA code since the above is really related
>> to frame buffer. It reserves more DMA area for dma_alloc_coherent()
>> etc than default 2 MB. Infact, we should no longer need this with
>> CMA and memblock in place.
>>
>> Tomi,
>> Can we not get rid of the above memory reservation ?
>
> Yes, I think so. This one is only used for the old omapfb, i.e. omap1,
> and I have no means to test it out, though. But below is a patch to
> remove it. I also attached the patch, as it looks like thunderbird wants
> to reformat the pasted patch... I'll remove the
> CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE from the omapfb driver's Kconfig file
> in my tree later.
>
Great !!
Thanks for the patches Tomi.

For both the patches, feel free add.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
