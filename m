From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Wed, 17 Jan 2018 23:25:30 +0800
Subject: [PATCH v3 00/12] iommu/rockchip: Use OF_IOMMU
Message-ID: <20180117152542.26429-1-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This series fixes some issues in rockchip iommu driver, and add of_iommu
support in it.

Changes in v3:
Also remove remove() and module_exit() as Tomasz suggested.
Loop platform_get_irq() as Robin suggested.
Add struct rk_iommudata.
Squash iommu/rockchip: Use iommu_group_get_for_dev() for add_device
Only call startup() and shutdown() when iommu attached.
Remove pm_mutex.
Check runtime PM disabled.
Check pm_runtime in rk_iommu_irq().
Remove rk_iommudata->domain.

Changes in v2:
Move irq request to probe(in patch[0])
Move bus_set_iommu() to rk_iommu_probe().

Jeffy Chen (8):
  iommu/rockchip: Prohibiat unbind and remove
  iommu/rockchip: Fix error handling in probe
  iommu/rockchip: Request irqs in rk_iommu_probe()
  iommu/rockchip: Use IOMMU device for dma mapping operations
  iommu/rockchip: Use OF_IOMMU to attach devices automatically
  iommu/rockchip: Fix error handling in init
  iommu/rockchip: Add runtime PM support
  iommu/rockchip: Support sharing IOMMU between masters

Tomasz Figa (4):
  iommu/rockchip: Fix error handling in attach
  iommu/rockchip: Use iopoll helpers to wait for hardware
  iommu/rockchip: Fix TLB flush of secondary IOMMUs
  iommu/rockchip: Control clocks needed to access the IOMMU

 .../devicetree/bindings/iommu/rockchip,iommu.txt   |   8 +
 drivers/iommu/rockchip-iommu.c                     | 653 ++++++++++++---------
 2 files changed, 379 insertions(+), 282 deletions(-)

-- 
2.11.0
