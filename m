From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 04 Jul 2011 08:47:53 +0200
Subject: [PATCH 0/6+1] ARM: EXYNOS4: SYSMMU: Improvements on SYSMMU driver
In-Reply-To: <1309743708-1505-1-git-send-email-pullip.cho@samsung.com>
References: <1309743708-1505-1-git-send-email-pullip.cho@samsung.com>
Message-ID: <000001cc3a16$4cec0710$e6c41530$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Monday, July 04, 2011 3:42 AM KyongHo Cho wrote:

> This patch set includes the following patches:
> 
> - [PATCH 1/6] ARM: EXYNOS4: SYSMMU: Remove SYSMMU_MDMA2
>   The previous driver defines System MMUs for 2 MDMAs each.
>   Since one of the MDMAs is not used any more, it is removed.
>   SYSMMU_MDMA2 is renamed to SYSMMU_MDMA and it now represents number 10.
> 
> - [PATCH 2/6] ARM: EXYNOS4: SYSMMU: Enable clock gating for System MMUof
> SSS
>   System MMU of SSS was not complete to use because previous driver did not
>   prepare anything for its clock gating feature. This patch enables clock
>   gating for System MMU of SSS.
> 
> - [PATCH 3/6] ARM: EXYNOS4: SYSMMU: Enhancement on device definition
>   As the suggestion of Marek Szyprowski with his patch set, this patch
>   separates the single definition of platform device of System MMU into
>   15 different platform devices as well as structured resource management.
> 
> - [PATCH 4/6] ARM: EXYNOS4: SYSMMU: add devname in SYSMMU clock to support
> clkdev.
>   This patch adds 'devname' fields into the clokc definitions of System MMU.
>   The pointer to clk structure for System MMU can be found with kobj name
>   dynamically.
> 
> - [PATCH 5/6] ARM: EXYNOS4: SYSMMU: Add SYSMMU_NONE
>   This patch adds another System MMU ID(ips), "SYSMMU_NONE" which means
>   invalid system MMU ID.
> 
> - [PATCH 6/6] ARM: EXYNOS4: SYSMMU: Move clock gating functions to SYSMMU
> device driver.
>   The previous driver implements clock gating functions in the mach
>   directory because it is mach dependent. It is now removed and
>   clock gating functions are moved to System MMU driver because clkdev is
>   supported.
> 
> - [PATCH] ARM: EXYNOS4: iommu: Add IOMMU API and moved to drivers/iommu
>   This patch moves the existing System MMU driver to drivers/iommu
>   directory that is in Joerg Roedel's git.
>   git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
>   This patch also adds implementation of IOMMU API for Exynos4's System MMU.
> 
> The above patches must be applied in the order of their presence.
> 
> The last patch is not applicable to any kernel version except Joerg
> Roedel's git tree.
> 
> This patch set does not improve System MMU driver completely.
> The rest of enhancements will be submitted soon.

I really don't get why do You persist in creating one monster platform
device with resources for ALL SYSMMU/IOMMU controllers that are available
on Exynos4 CPU. We (SPRC, see Andrzej's SYSMMU patches) already proposed
a clean solution for making the SYSMMU controllers independent of each
other as well as making the main SYSMMU driver simpler and more
independent of the particular Exynos4 platform definition. In Linux
device model if the device/controller exist in the system in more than
one instance, there should by one generic driver for it and a set of
platform definitions for each instance. 

Here is the link to our SYSMMU updated driver (implementing common 
iommu API):
http://www.spinics.net/lists/linux-samsung-soc/msg04508.html
The driver still needs some cleanup, but this has been delayed until
the dma-mapping framework update is finished.

I also don't get why do you want to keep the completely custom sysmmu 
driver and implement iommu API on top of it. Is it really required for
anything? Mainline kernel is not a place for custom APIs if there is
already a common, generic one.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
