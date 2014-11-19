From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 19 Nov 2014 12:21:26 +0100
Subject: [RFC PATCH v4 0/8] Introduce automatic DMA configuration for IOMMU
 masters
In-Reply-To: <1415991397-9618-1-git-send-email-will.deacon@arm.com>
References: <1415991397-9618-1-git-send-email-will.deacon@arm.com>
Message-ID: <546C7D36.7030400@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2014-11-14 19:56, Will Deacon wrote:
> Hello everybody,
>
> Here is the fourth iteration of the RFC I've previously posted here:
>
>    RFCv1: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/283023.html
>    RFCv2: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/283752.html
>    RFCv3: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/287031.html
>
> Changes since RFCv3 include:
>
>    - Drastic simplification of the data structures, so that we no longer
>      pass around lists of domains. Instead, dma-mapping is expected to
>      allocate the domain (Joerg talked about adding a get_default_domain
>      operation to iommu_ops).
>
>    - iommu_ops is used to hold the per-instance IOMMU data
>
>    - Configuration of DMA segments added to of_dma_configure
>
> All feedback welcome.

I've rebased my Exynos SYSMMU patches on top of this patchset and it 
works fine,
You can find them in the "[PATCH v3 00/19] Exynos SYSMMU (IOMMU) 
integration with DT
and DMA-mapping subsystem" thread.

You can add to all your patches:
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

I'm also interested in adding get_default_domain() callback, but I 
assume that this
can be done once the basic patchset get merged. Do you plan to work on 
it, do you want
me to implement it?

> Cheers,
>
> Will
>
> --->8
>
> Will Deacon (8):
>    iommu: provide early initialisation hook for IOMMU drivers
>    dma-mapping: replace set_arch_dma_coherent_ops with arch_setup_dma_ops
>    iommu: add new iommu_ops callback for adding an OF device
>    iommu: provide helper function to configure an IOMMU for an of master
>    dma-mapping: detect and configure IOMMU in of_dma_configure
>    dma-mapping: set dma segment properties in of_dma_configure
>    arm: call iommu_init before of_platform_populate
>    arm: dma-mapping: plumb our iommu mapping ops into arch_setup_dma_ops
>
>   arch/arm/include/asm/dma-mapping.h | 12 +++---
>   arch/arm/kernel/setup.c            |  2 +
>   arch/arm/mm/dma-mapping.c          | 80 ++++++++++++++++++++++++++++++++++----
>   drivers/iommu/Kconfig              |  2 +-
>   drivers/iommu/of_iommu.c           | 50 ++++++++++++++++++++++++
>   drivers/of/platform.c              | 54 +++++++++++++------------
>   include/asm-generic/vmlinux.lds.h  |  2 +
>   include/linux/amba/bus.h           |  1 +
>   include/linux/dma-mapping.h        | 13 ++++---
>   include/linux/iommu.h              |  8 ++++
>   include/linux/of_iommu.h           | 31 +++++++++++++++
>   include/linux/platform_device.h    |  2 +
>   12 files changed, 214 insertions(+), 43 deletions(-)
>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
