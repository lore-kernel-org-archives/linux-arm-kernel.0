From: drinkcat@chromium.org (Nicolas Boichat)
Date: Sun, 11 Nov 2018 17:03:38 +0800
Subject: [PATCH v2 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page
 tables
Message-ID: <20181111090341.120786-1-drinkcat@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a follow-up to the discussion in [1], to make sure that the page
tables allocated by iommu/io-pgtable-arm-v7s are contained within 32-bit
physical address space.

[1] https://lists.linuxfoundation.org/pipermail/iommu/2018-November/030876.html

Fixes since v1:
 - Add support for SLAB_CACHE_DMA32 in slab and slub (patches 1/2)
 - iommu/io-pgtable-arm-v7s (patch 3):
   - Changed approach to use SLAB_CACHE_DMA32 added by the previous
     commit.
   - Use DMA or DMA32 depending on the architecture (DMA for arm,
     DMA32 for arm64).

Nicolas Boichat (3):
  mm: slab/slub: Add check_slab_flags function to check for valid flags
  mm: Add support for SLAB_CACHE_DMA32
  iommu/io-pgtable-arm-v7s: Request DMA32 memory, and improve debugging

 drivers/iommu/io-pgtable-arm-v7s.c | 20 ++++++++++++++++----
 include/linux/slab.h               |  2 ++
 mm/internal.h                      | 21 +++++++++++++++++++--
 mm/slab.c                          | 10 +++-------
 mm/slab.h                          |  3 ++-
 mm/slab_common.c                   |  2 +-
 mm/slub.c                          | 24 +++++++++++++++++-------
 7 files changed, 60 insertions(+), 22 deletions(-)

-- 
2.19.1.930.g4563a0d9d0-goog
