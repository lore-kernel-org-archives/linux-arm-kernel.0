From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 02 Sep 2014 12:42:13 +0200
Subject: [RFC PATCH 0/7] Introduce automatic DMA configuration for IOMMU
 masters
In-Reply-To: <33373396.gPTVFGBBxa@wuerfel>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
 <20140902083138.GA25379@arm.com> <54058442.2070204@samsung.com>
 <33373396.gPTVFGBBxa@wuerfel>
Message-ID: <54059F05.2090901@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 2014-09-02 10:56, Arnd Bergmann wrote:
> On Tuesday 02 September 2014 10:48:02 Marek Szyprowski wrote:
>>>    -- I have concerns that allocating one domain per master might be
>>> too much, but it's hard to tell without an IOMMU driver ported over.
>> One domain per master is IMHO a sane default configuration. The only default
>> alternative I see is to have only one domain (related with dma-mapping
>> subsystem) and bind all devices to it. However I really don't see any
>> disadvantage of having separate domain per each master and such
>> configuration
>> gives devices better separation.
> I was expecting that the dma-mapping implementation would by default use
> one domain for all devices, since that is what the simpler IOMMUs without
> domain support have to do anyway.
>
> For isolation purposes, it can only help to have more domains, but
> I would guess that there is some space overhead in maintaining lots
> of page tables.

I'm okay with both approaches (separate domain for each device vs. single
common domain for all devices). Maybe this can be some kind of Kconfig
option added to DMA debugging? Separation might be really helpful when
debugging strange device behavior.

>> However we also need to figure out how to let drivers to make their own
>> configuration, like it is required by Exynos DRM subsystem, which consist
>> of several devices, each having its own IOMMU controller, but for
>> convenience those drivers assume that they all have been bound to the same,
>> single domain.
> IIRC with the way we ended up putting the mask into the iommu descriptor of
> the ARM SMMU, you can put multiple devices into the same iommu group, and
> have them automatically share a domain.
>
> I don't know if the same would work for the Samsung implementation.

The question is how to transfer such information from the device 
drivers, that
need/benefit from such configuration to iommu driver, which does all the 
setup?
This is something completely internal to particular drivers and should 
not be
exported to device tree or userspace. Thierry suggested to hardcode this
information in the iommu driver, but I'm looking for other approaches.
Maybe simply releasing device from the default dma-mapping domain before
attaching to custom one will be the easiest solution.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
