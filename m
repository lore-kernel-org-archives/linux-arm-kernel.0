From: roy.pledge@nxp.com (Roy Pledge)
Date: Thu, 24 Aug 2017 16:37:44 -0400
Subject: [v4 00/11] soc/fsl/qbman: Enable QBMan on ARM Platforms
Message-ID: <1503607075-28970-1-git-send-email-roy.pledge@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series enables DPAA1 QBMan devices for ARM and
ARM64 architectures. This allows the LS1043A and LS1046A to use
QBMan functionality which allows access to ethernet and cyptographic
devices for example.

Changes since v3:
- Use memremap() instead of ioremap() for non iomem QBMan portal regions
- Ensured the __iomem attribute is respected when accessing iomem mapped regions
- Removed calls to flush/invalidate/prefetch for ARM/ARM64 since mapping is done as write combine

Changes since v2:
- Fixed some misspellings
- Added 'no-map' constraint to device tree bindings
- Described ordering contraint on regions in the device tree
- Removed confusing comment regarding non-shareable mappings
- Added warning if old reserved-memory technique is used on ARM

Changes since v1:
- Reworked private memory allocations to use shared-dma-pool on ARM platforms


Claudiu Manoil (2):
  soc/fsl/qbman: Drop L1_CACHE_BYTES compile time check
  soc/fsl/qbman: Add missing headers on ARM

Madalin Bucur (4):
  soc/fsl/qbman: Drop set/clear_bits usage
  soc/fsl/qbman: add QMAN_REV32
  soc/fsl/qbman: different register offsets on ARM
  fsl/soc/qbman: Enable FSL_LAYERSCAPE config on ARM

Roy Pledge (4):
  soc/fsl/qbman: Use shared-dma-pool for BMan private memory allocations
  soc/fsl/qbman: Use shared-dma-pool for QMan private memory allocations
  dt-bindings: soc/fsl: Update reserved memory binding for QBMan
  soc/fsl/qbman: Rework portal mapping calls for ARM/PPC

Valentin Rothberg (1):
  soc/fsl/qbman: Fix ARM32 typo

 Documentation/devicetree/bindings/soc/fsl/bman.txt |  12 +-
 Documentation/devicetree/bindings/soc/fsl/qman.txt |  26 ++--
 drivers/soc/fsl/qbman/Kconfig                      |   2 +-
 drivers/soc/fsl/qbman/bman.c                       |  30 ++++-
 drivers/soc/fsl/qbman/bman_ccsr.c                  |  35 +++++-
 drivers/soc/fsl/qbman/bman_portal.c                |  36 ++++--
 drivers/soc/fsl/qbman/bman_priv.h                  |  11 +-
 drivers/soc/fsl/qbman/dpaa_sys.h                   |  14 +--
 drivers/soc/fsl/qbman/qman.c                       |  52 ++++++--
 drivers/soc/fsl/qbman/qman_ccsr.c                  | 140 ++++++++++++++++-----
 drivers/soc/fsl/qbman/qman_portal.c                |  36 ++++--
 drivers/soc/fsl/qbman/qman_priv.h                  |  13 +-
 drivers/soc/fsl/qbman/qman_test.h                  |   2 -
 13 files changed, 305 insertions(+), 104 deletions(-)

--
2.7.4
