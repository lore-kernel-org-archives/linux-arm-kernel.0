From: marvin24@gmx.de (Marc Dietrich)
Date: Fri, 05 Jul 2013 13:03:58 +0200
Subject: [PATCH v2 00/22] Unified SMMU driver among Tegra SoCs
In-Reply-To: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <4999563.JlU6BysXQl@fb07-iapwap2.physik.uni-giessen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 5. Juli 2013, 13:44:35 schrieb Hiroshi Doyu:
> Hi,
> 
> This series provides:
> 
> (1) Unified SMMU driver among Tegra SoCs

does this affect tegra2 in any way?

> (2) Multiple Address Space support(MASID) in IOMMU(SMMMU)
> (3) Tegra IOMMU'able devices, most of platform devices are IOMMU'able.
> 
> There's some discussion[1] about device population order, which can
> solve the following patches.
> 
>   [HACK] of: dev_node has struct device pointer
>   ARM: tegra: Populate AHB/IOMMU earlier than others
> 
> Also "ARM: dma-mapping: Drop GFP_COMP for DMA memory allocations" may
> not be necessary by [2]
> 
> Tested IOMMU functionality with T30 SD/MMC. Any further testing with
> T114 and/or other devices would be really appreciated.
> 
> v2:
> Updated based on Thierry Reding's and Stephen Warren's feedback
> 
> v1:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/180267.html
> 
> Hiroshi Doyu (22):
>   [HACK] of: dev_node has struct device pointer
>   ARM: tegra: Populate AHB/IOMMU earlier than others
>   ARM: tegra: Create a DT header defining swgroups ID
>   ARM: dt: tegra30: iommu: Add "nvidia,swgroup"
>   ARM: dt: tegra30: iommu: Add "nvidia,memory-client"
>   ARM: dt: tegra114: iommu: Fix IOMMU register address
>   ARM: dt: tegra114: iommu: Add "nvidia,swgroups"
>   ARM: dt: tegra114: Add "nvidia,memory-client"
>   amba: Move AHB to core_initcall
>   iommu/tegra: smmu: Move IOMMU to core_initcall
>   iommu/tegra: smmu: Add Tegra 114 support
>   iommu/tegra: smmu: Select ARM_DMA_USE_IOMMU in Kconfig
>   iommu/tegra: smmu: Create default IOVA maps
>   iommu/tegra: smmu: Register platform_device to IOMMU dynamically
>   iommu/tegra: smmu: Calculate ASID register offset by ID
>   iommu/tegra: smmu: Get "nvidia,swgroup" from DT
>   iommu/tegra: smmu: Unfied driver for Tegra SoCs
>   iommu/tegra: smmu: Use dt-bindings MACRO
>   iommu/tegra: smmu: Workaround PCIe IOMMU'able
>   iommu/tegra: smmu: Get "nvidia,memory-client" from DT
>   iommu/tegra: smmu: Support Multiple ASID
>   ARM: dma-mapping: Drop GFP_COMP for DMA memory allocations
> 
>  .../bindings/iommu/nvidia,tegra30-smmu.txt         |   20 +-
>  arch/arm/boot/dts/tegra114.dtsi                    |   13 +-
>  arch/arm/boot/dts/tegra30.dtsi                     |   21 ++
>  arch/arm/mach-tegra/tegra.c                        |   22 ++
>  arch/arm/mm/dma-mapping.c                          |    7 +
>  drivers/amba/tegra-ahb.c                           |    7 +-
>  drivers/iommu/Kconfig                              |    1 +
>  drivers/iommu/tegra-smmu.c                         |  211
> +++++++++++--------- drivers/of/base.c                                  |  
> 23 +++
>  drivers/of/platform.c                              |    8 +
>  include/dt-bindings/memory/tegra-swgroup.h         |   50 +++++
>  include/linux/of.h                                 |   16 ++
>  12 files changed, 296 insertions(+), 103 deletions(-)
>  create mode 100644 include/dt-bindings/memory/tegra-swgroup.h
