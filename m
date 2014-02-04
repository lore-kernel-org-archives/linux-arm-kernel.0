From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 4 Feb 2014 11:38:32 -0500
Subject: [RFC/RFT 1/2] ARM: mm: introduce arch hooks for dma address
 translation routines
In-Reply-To: <201402041715.54538.arnd@arndb.de>
References: <1391470107-15927-1-git-send-email-santosh.shilimkar@ti.com>
 <1391470107-15927-2-git-send-email-santosh.shilimkar@ti.com>
 <201402041715.54538.arnd@arndb.de>
Message-ID: <52F11788.4030500@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 February 2014 11:15 AM, Arnd Bergmann wrote:
> On Tuesday 04 February 2014, Santosh Shilimkar wrote:
>> Currently arch specific DMA address translation routines can be enabled
>> using only defines which makes impossible to use them in with
>> multi-platform builds.
>>
>> Hence, introduce arch specific hooks for DMA address translations
>> routines to be compatible with multi-platform builds:
>> dma_addr_t (*arch_pfn_to_dma)(struct device *dev, unsigned long pfn);
>> unsigned long (*arch_dma_to_pfn)(struct device *dev, dma_addr_t addr);
>> void* (*arch_dma_to_virt)(struct device *dev, dma_addr_t addr);
>> dma_addr_t (*arch_virt_to_dma)(struct device *dev, void *addr);
>>
>> In case if architecture won't use it - DMA address translation routines
>> will fall-back to existing implementation.
>> v
>> Also, modify machines omap1, ks8695, iop13xx to use new DMA hooks.
> 
> I think this is going into a wrong direction. DMA translation is not
> at all a platform-specific thing, but rather bus specific. The most
> common scenario is that you have some 64-bit capable buses and some
> buses that are limited to 32-bit DMA (or less if you are unfortunate).
>
I may be wrong but you could have 64 bit bus but 32 bit DMA controllers.
That is one of the case I am dealing with.
 
> We also can't rely on {pfn,phys,virt}_to_{bus,dma} and the reverse
> to work anywhere outside of the dma_map_ops implementation, because
> of IOMMUs in-between.
> 
> Of course we do need a proper solution for this problem, but we
> can't make it a per-platform decision, and whatever the solution is
> needs to take into account both nontrivial linear mappings (offset
> or cropped) and IOMMUs, and set the appropriate dma_map_ops for
> the device.
> 
> I guess for the legacy cases (omap1, iop13xx, ks8695), we can
> hardcode dma_map_ops for all devices to get this right. For everything
> else, I'd suggest defaulting to the arm_dma_ops unless we get
> other information from DT. This means we have to create standardized
> properties to handle any combination of these:
> 
Thats the case and the $subject series doesn't change that.

> 1. DMA is coherent
> 2. DMA space is offset from phys space
> 3. DMA space is smaller than 32-bit
> 4. DMA space is larger than 32-bit
> 5. DMA goes through an IOMMU
> 
> The dma-ranges property can deal with 2-4. Highbank already introduced
> a "dma-coherent" flag for 1, and we can decide to generalize that.
> I don't know what the state of IOMMU support is, but we have to come
> up with something better than what we had on PowerPC, because we now
> have to deal with a combination of different IOMMUs in the same system,
> whereas the most complex case on PowerPC was some devices all going
> through one IOMMU and the other devices being linearly mapped.
> 
Just to be clear, the patch set is not fiddling with dma_ops as such.
The dma_ops needs few accessors to convert addresses and these accessors
are different on few platforms. And hence needs to be patched.

We will try to look at "dma-ranges" to see if it can address my case.
Thanks for the pointer

Regards,
Santosh
 
