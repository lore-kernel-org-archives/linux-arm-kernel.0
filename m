From: jrdr.linux@gmail.com (Souptick Joarder)
Date: Thu, 15 Nov 2018 21:13:14 +0530
Subject: [PATCH 0/9] Use vm_insert_range
Message-ID: <20181115154314.GA27850@jordon-HP-15-Notebook-PC>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previouly drivers have their own way of mapping range of
kernel pages/memory into user vma and this was done by
invoking vm_insert_page() within a loop.

As this pattern is common across different drivers, it can
be generalized by creating a new function and use it across
the drivers.

vm_insert_range is the new API which will be used to map a
range of kernel memory/pages to user vma.

All the applicable places are converted to use new vm_insert_range
in this patch series.

Souptick Joarder (9):
  mm: Introduce new vm_insert_range API
  arch/arm/mm/dma-mapping.c: Convert to use vm_insert_range
  drivers/firewire/core-iso.c: Convert to use vm_insert_range
  drm/rockchip/rockchip_drm_gem.c: Convert to use vm_insert_range
  drm/xen/xen_drm_front_gem.c: Convert to use vm_insert_range
  iommu/dma-iommu.c: Convert to use vm_insert_range
  videobuf2/videobuf2-dma-sg.c: Convert to use vm_insert_range
  xen/gntdev.c: Convert to use vm_insert_range
  xen/privcmd-buf.c: Convert to use vm_insert_range

 arch/arm/mm/dma-mapping.c                         | 21 ++++++-----------
 drivers/firewire/core-iso.c                       | 15 ++----------
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c       | 20 ++--------------
 drivers/gpu/drm/xen/xen_drm_front_gem.c           | 20 +++++-----------
 drivers/iommu/dma-iommu.c                         | 12 ++--------
 drivers/media/common/videobuf2/videobuf2-dma-sg.c | 23 ++++++-------------
 drivers/xen/gntdev.c                              | 11 ++++-----
 drivers/xen/privcmd-buf.c                         |  8 ++-----
 include/linux/mm_types.h                          |  3 +++
 mm/memory.c                                       | 28 +++++++++++++++++++++++
 mm/nommu.c                                        |  7 ++++++
 11 files changed, 70 insertions(+), 98 deletions(-)

-- 
1.9.1
