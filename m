From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 14 Apr 2016 13:04:09 +0100
Subject: SMMU problem found on LS2085A with 4.6-rc3
In-Reply-To: <570E9EA9.2070903@linaro.org>
References: <570E9EA9.2070903@linaro.org>
Message-ID: <570F8739.1060508@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yang,

On 13/04/16 20:31, Shi, Yang wrote:
> Hi Will & Robin,
>
> I just ran some quick test on my LS2085A board, which has 8 Cortex A57
> cores, with 4.6-rc3 kernel, but I found a regression issue with SMMU.
>
> SMMU driver reports:
>
> arm_smmu_global_fault: 297974 callbacks suppressed
> arm_smmu_global_fault: 298561 callbacks suppressed
> arm-smmu 5000000.iommu:         GFSR 0x80000004, GFSYNR0 0x00000008,
> GFSYNR1 0x00000300, GFSYNR2 0x00000000
> arm-smmu 5000000.iommu:         GFSR 0x80000004, GFSYNR0 0x00000008,
> GFSYNR1 0x00000300, GFSYNR2 0x00000000
> arm-smmu 5000000.iommu:         GFSR 0x80000004, GFSYNR0 0x00000008,
> GFSYNR1 0x00000300, GFSYNR2 0x00000000
> arm-smmu 5000000.iommu:         GFSR 0x80000004, GFSYNR0 0x00000008,
> GFSYNR1 0x00000300, GFSYNR2 0x00000000
> arm-smmu 5000000.iommu:         GFSR 0x80000004, GFSYNR0 0x00000008,
> GFSYNR1 0x00000300, GFSYNR2 0x00000000
> arm-smmu 5000000.iommu:         GFSR 0x80000004, GFSYNR0 0x00000008,
> GFSYNR1 0x00000300, GFSYNR2 0x00000000
> arm-smmu 5000000.iommu:         GFSR 0x80000004, GFSYNR0 0x00000008,
> GFSYNR1 0x00000300, GFSYNR2 0x00000000
> arm-smmu 5000000.iommu:         GFSR 0x80000004, GFSYNR0 0x00000008,
> GFSYNR1 0x00000300, GFSYNR2 0x00000000
> arm-smmu 5000000.iommu:         GFSR 0x80000004, GFSYNR0 0x00000008,
> GFSYNR1 0x00000300, GFSYNR2 0x00000000
> arm-smmu 5000000.iommu:         GFSR 0x80000004, GFSYNR0 0x00000008,
> GFSYNR1 0x00000300, GFSYNR2 0x00000000
> arm-smmu 5000000.iommu: Unexpected global fault, this could be serious
> arm-smmu 5000000.iommu: Unexpected global fault, this could be serious
> arm-smmu 5000000.iommu: Unexpected global fault, this could be serious
> arm-smmu 5000000.iommu: Unexpected global fault, this could be serious
> arm-smmu 5000000.iommu: Unexpected global fault, this could be serious
> arm-smmu 5000000.iommu: Unexpected global fault, this could be serious
> arm-smmu 5000000.iommu: Unexpected global fault, this could be serious
> arm-smmu 5000000.iommu: Unexpected global fault, this could be serious
> arm-smmu 5000000.iommu: Unexpected global fault, this could be serious
> arm-smmu 5000000.iommu: Unexpected global fault, this could be serious

That's a stream match conflict fault, so you've somehow got two devices 
using the same stream ID attached to different domains, and at least one 
of them is trying to do DMA.

> But, it is good with 4.5 kernel. I found the below commit causes it:
>
> commit 9adb95949a343dac53b1cd81dc973b5f815c88d4
> Author: Robin Murphy <robin.murphy@arm.com>
> Date:   Tue Jan 26 18:06:36 2016 +0000
>
>      iommu/arm-smmu: Support DMA-API domains
>
>      With DMA mapping ops provided by the iommu-dma code, only a minimal
>      contribution from the IOMMU driver is needed to create a suitable
>      DMA-API domain for them to use. Implement this for the ARM SMMUs.
>
>      Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>      Signed-off-by: Will Deacon <will.deacon@arm.com>
>
> Any idea?

My first guess would be the same thing as [1] - does that patch help?

Beyond that, what does your DT look like? The one in mainline has one 
token mmu-masters property which isn't even valid, so nothing ever gets 
attached to the SMMU - indeed I've happily booted -rc3 on an LS2085A 
earlier this week - so there's clearly something going on there.

More generally, I'd note that the mmu-masters binding will never fully 
work on this board - you can get the platform devices to cooperate by 
programming the assorted ICID registers to ensure they present unique 
stream IDs, but PCI devices cannot work at all because there's no way to 
make the stream IDs coming out of the root complex be equal to the PCI 
RID in the way it relies on. In that sense, any regression here is quite 
likely just a shift from "subtly not working" to "loudly and obnoxiously 
not working". Conversely, those reasons have also proved it a really 
useful platform for implementing and testing the iommu-map binding[2] 
(with an awful hack in the PCI driver to program the lookup table 
suitably) :D

Robin.

[1]:http://thread.gmane.org/gmane.linux.kernel.iommu/12810
[2]:http://thread.gmane.org/gmane.linux.kernel.iommu/12454

>
> Thanks,
> Yang
>
