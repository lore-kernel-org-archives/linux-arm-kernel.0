From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 14 Sep 2016 14:25:48 +0100
Subject: [PATCH v7 22/22] iommu/dma: Avoid PCI host bridge windows
In-Reply-To: <dc9f945f-2756-ab70-d061-9fdc7c5afdee@samsung.com>
References: <cover.1473695704.git.robin.murphy@arm.com>
 <CGME20160912161514eucas1p10818019bf2302609421ad9c35d1af4b8@eucas1p1.samsung.com>
 <5f7bfee298f98d29a35933d3e0252d32b83d62b8.1473695704.git.robin.murphy@arm.com>
 <ab8693f6-20d6-2a95-9f1f-0607e72bc012@samsung.com>
 <49c51c4f-cb00-445d-b8f8-b632babf2b3e@arm.com>
 <dc9f945f-2756-ab70-d061-9fdc7c5afdee@samsung.com>
Message-ID: <bbdc42fa-ea35-945f-3e2a-e0ab03fc997d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/09/16 13:35, Marek Szyprowski wrote:
> Hi Robin,
> 
> 
> On 2016-09-14 13:10, Robin Murphy wrote:
>> On 14/09/16 11:55, Marek Szyprowski wrote:
>>> On 2016-09-12 18:14, Robin Murphy wrote:
>>>> With our DMA ops enabled for PCI devices, we should avoid allocating
>>>> IOVAs which a host bridge might misinterpret as peer-to-peer DMA and
>>>> lead to faults, corruption or other badness. To be safe, punch out
>>>> holes
>>>> for all of the relevant host bridge's windows when initialising a DMA
>>>> domain for a PCI device.
>>>>
>>>> CC: Marek Szyprowski <m.szyprowski@samsung.com>
>>>> CC: Inki Dae <inki.dae@samsung.com>
>>>> Reported-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>> I don't know much about PCI and their IOMMU integration, but can't we
>>> use
>>> the direct mapping region feature of iommu core for it? There are
>>> already
>>> iommu_get_dm_regions(), iommu_put_dm_regions() and
>>> iommu_request_dm_for_dev()
>>> functions for handling them...
>> It's rather the opposite problem - in the direct-mapping case, we're
>> making sure the iommu_domain has translations installed for the given
>> IOVAs (which are also the corresponding physical address) before it goes
>> live, whereas what we need to do here is make sure the these addresses
>> never get used as IOVAs at all, because any attempt to do so them will
>> likely go wrong. Thus we carve them out of the iova_domain such that
>> they will never get near an actual IOMMU API call.
>>
>> This is a slightly generalised equivalent of e.g. amd_iommu.c's
>> init_reserved_iova_ranges().
> 
> Hmmm. Each dm_region have protection parameter. Can't we reuse them to
> create prohibited/reserved regions by setting it to 0 (no read / no write)
> and mapping to physical 0 address? That's just a quick idea, because
> dm_regions and the proposed code for pci looks a bit similar for me...

It might look similar, but at different levels (iommu_domain vs.
iova_domain) and with the opposite intent. The dm_region prot flag is
just the standard flag as passed to iommu_map() - trying to map a region
with no access in an empty pagetable isn't going to achieve anything
anyway (it's effectively unmapping addresses that are already unmapped).

But for this case, even if you _did_ map something in the pagetable
(i.e. the iommu_domain), it wouldn't make any difference, because the
thing we're mitigating against is handing out addresses which are going
to cause a device's accesses to blow up inside the PCI root complex
without ever even reaching the IOMMU. In short, dm_regions are about
"these addresses are already being used for DMA, so make sure the IOMMU
API doesn't block them", whereas reserved ranges are about "these
addresses are unusable for DMA, so make sure the DMA API can't allocate
them".

Robin.

> 
> [...]
> 
> Best regards
