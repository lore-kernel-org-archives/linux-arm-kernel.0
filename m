From: mark.yao@rock-chips.com (Mark yao)
Date: Mon, 18 Apr 2016 10:18:37 +0800
Subject: [RFC 0/3] Unify IOMMU-based DMA-mapping code for ARM and ARM64
In-Reply-To: <1455870164-25337-1-git-send-email-m.szyprowski@samsung.com>
References: <1455870164-25337-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <571443FD.9090508@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek

With your patches, do drm/rockchip dma-mapping rewrite, IOMMU works good 
on drm/rockchip ARM64 platform.

Thanks for your patches.

On 2016?02?19? 16:22, Marek Szyprowski wrote:
> Dear All,
>
> This is an initial RFC on the unification of IOMMU-based DMA-mapping
> code for ARM and ARM64 architectures.
>
> Right now ARM architecture still use my old code for IOMMU-based
> DMA-mapping glue, initially merged in commit
> 4ce63fcd919c32d22528e54dcd89506962933719 ("ARM: dma-mapping: add support
> for IOMMU mapper"). In meantime ARM64 got a new, slightly improved
> implementation provided by Robin Murphy in commit
> 13b8629f651164d71f4d38b821925f93ba4236c8 ("arm64: Add IOMMU dma_ops").
>
> Both implementations are very similar thus their unification is desired
> to avoid duplicating future works and simplify code, which uses this
> layer on both architectures. In this patchset I've selected the new
> implementation (from ARM64 architecture) as a base. This means that
> ARM-specific, old interface (arm_iommu_* functions) for configuring
> IOMMU domains will be no longer available and its users have to be
> converted to new API.
>
> Besides lack of old interface, the second difference is additional
> requirements for IOMMU drivers. New code relies on the support for
> IOMMU_DOMAIN_DMA and default IOMMU domain, which is automatically
> attached by the IOMMU core.
>
> The new code also assumes that the IOMMU-based DMA-mapping ops are
> mainly configured from arch_setup_dma_ops() function, which means that
> the IOMMU driver should provide needed of_xlate callbacks and initialize
> IOMMU ops for device nodes. However it should be also possible to
> initialize IOMMU-based DMA-mapping ops for client devices directly from
> IOMMU drivers by calling common_iommu_setup_dma_ops() (some drivers used
> such approach).
>
> IOMMU drivers should be also aware of the fact that the
> default domain is attached via device_attach and then device_attach
> callback can be called once again with different domain without previous
> detach from default domain. For more information on this issue, see the
> following thread:
> https://lists.linaro.org/pipermail/linaro-mm-sig/2016-February/004625.html
>
> Currently there are 4 users of the old arm_iommu_* interface:
> 1. Exynos DRM driver
> 2. Rockchip DRM driver
> 3. OMAP3 ISP camera driver
> 4. Renesas VMSA-compatible IPMMU driver
>
> In this patchset I've converted Exynos DRM driver for the new API (patch
> 1). This required some changes in the memory management model inside the
> driver and removal of some hacks, which were used to setup IOMMU-based
> DMA-mapping ops on the 'exynos-drm' virtual device and common IOMMU
> domain for all Exynos DRM sub-devices, those changes have been posted
> separately here: http://www.spinics.net/lists/dri-devel/msg100861.html
> Rockchip DRM driver requires similar conversion.
>
> Converting OMAP3 ISP camera driver to new API requires adding support
> for IOMMU groups to OMAP IOMMU driver, because the new DMA/IOMMU code
> used IOMMU_DOMAIN_DMA type domains and default groups.
>
> Renesas IPMMU driver needs also to be extended with IOMMU_DOMAIN_DMA domain
> type support. It can also be prepared for IOMMU_OF_DECLARE and of_xlate
> callback-based initialization to let core to automatically setup of
> IOMMU-based DMA mapping implementation.
>
> Patch 2 moves existing code from arch/arm64 to drivers/iommu and
> introduces some minor changes in function names - mainly adding arch_
> prefix to some dma-mapping internal functions, which stay in arch/arm64/
> (functions of similar names are present in arch/arm). Patch 3 adapts ARM
> architecture for the common code.
>
> I would like to get your comments on the proposed approach. There is
> still some work that need to be done to convert remaining users of the
> old API and updating IOMMU drivers to the new API requirements. This
> change need to be tested on the all affected ARM sub-architectures.
>
> Right now patches were tested on only Exynos based boards: ARM 32bit:
> Exynos4412 and Exynos5422 boards and ARM 64 bit Exnyos 5433 (with some
> out-of-tree DTS).
>
> To ease testing I've prepared a branch with all the patches needed
> (there are all needed patches for Exynos subarch, which have been posted
> as separate patchsets):
> https://git.linaro.org/people/marek.szyprowski/linux-srpol.git v4.5-dma-iommu-unification
>
> Patches are based on Linux v4.5-rc4 vanilla tree.
>
> Best regards
> Marek Szyprowski
> Samsung R&D Institute Poland
>
>
> Patch summary:
>
> Marek Szyprowski (3):
>    drm/exynos: rewrite IOMMU support code
>    iommu: dma-iommu: move IOMMU/DMA-mapping code from ARM64 arch to drivers
>    iommu: dma-iommu: use common implementation also on ARM architecture
>
>   arch/arm/Kconfig                          |   22 +-
>   arch/arm/include/asm/device.h             |    9 -
>   arch/arm/include/asm/dma-iommu.h          |   37 -
>   arch/arm/include/asm/dma-mapping.h        |   59 +-
>   arch/arm/mm/dma-mapping.c                 | 1158 +----------------------------
>   arch/arm64/include/asm/dma-mapping.h      |   39 +-
>   arch/arm64/mm/dma-mapping.c               |  491 +-----------
>   drivers/gpu/drm/exynos/Kconfig            |    2 +-
>   drivers/gpu/drm/exynos/exynos_drm_drv.c   |    7 +-
>   drivers/gpu/drm/exynos/exynos_drm_drv.h   |    2 +-
>   drivers/gpu/drm/exynos/exynos_drm_iommu.c |   91 ++-
>   drivers/gpu/drm/exynos/exynos_drm_iommu.h |    2 +-
>   drivers/gpu/drm/rockchip/Kconfig          |    1 +
>   drivers/iommu/Kconfig                     |    1 +
>   drivers/iommu/Makefile                    |    2 +-
>   drivers/iommu/dma-iommu-ops.c             |  471 ++++++++++++
>   drivers/media/platform/Kconfig            |    1 +
>   include/linux/dma-iommu.h                 |   14 +
>   18 files changed, 679 insertions(+), 1730 deletions(-)
>   delete mode 100644 arch/arm/include/asm/dma-iommu.h
>   create mode 100644 drivers/iommu/dma-iommu-ops.c
>


-- 
?ark Yao
