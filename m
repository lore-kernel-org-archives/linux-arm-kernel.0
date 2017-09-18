From: roy.pledge@nxp.com (Roy Pledge)
Date: Mon, 18 Sep 2017 16:39:35 -0400
Subject: [v5 00/12] soc/fsl/qbman: Enable QBMan on ARM Platforms
Message-ID: <1505767187-4596-1-git-send-email-roy.pledge@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series enables DPAA1 QBMan devices for ARM and
ARM64 architectures. This allows the LS1043A and LS1046A to use
QBMan functionality which allows access to ethernet and cyptographic
devices for example.

Changes since v4:
- Introduce a common function for QBMan private memory initialization
- Fix sparse warnings making sure that __iomem and __be32 are respected
- Control different memremap() attributes using a #define

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
  soc/fsl/qbman: Enable FSL_LAYERSCAPE config on ARM

Roy Pledge (5):
  soc/fsl/qbman: Add common routine for QBMan private allocations
  soc/fsl/qbman: Use shared-dma-pool for BMan private memory allocations
  soc/fsl/qbman: Use shared-dma-pool for QMan private memory allocations
  dt-bindings: soc/fsl: Update reserved memory binding for QBMan
  soc/fsl/qbman: Rework portal mapping calls for ARM/PPC

Valentin Rothberg (1):
  soc/fsl/qbman: Fix ARM32 typo

 Documentation/devicetree/bindings/soc/fsl/bman.txt | 12 +--
 Documentation/devicetree/bindings/soc/fsl/qman.txt | 26 ++++--
 drivers/soc/fsl/qbman/Kconfig                      |  2 +-
 drivers/soc/fsl/qbman/Makefile                     |  2 +-
 drivers/soc/fsl/qbman/bman.c                       | 42 ++++++++--
 drivers/soc/fsl/qbman/bman_ccsr.c                  | 15 ++++
 drivers/soc/fsl/qbman/bman_portal.c                | 23 +++---
 drivers/soc/fsl/qbman/bman_priv.h                  |  8 +-
 drivers/soc/fsl/qbman/dpaa_sys.c                   | 78 ++++++++++++++++++
 drivers/soc/fsl/qbman/dpaa_sys.h                   | 25 ++++--
 drivers/soc/fsl/qbman/qman.c                       | 77 +++++++++++++-----
 drivers/soc/fsl/qbman/qman_ccsr.c                  | 95 +++++++++++++++-------
 drivers/soc/fsl/qbman/qman_portal.c                | 23 +++---
 drivers/soc/fsl/qbman/qman_priv.h                  | 11 +--
 drivers/soc/fsl/qbman/qman_test.h                  |  2 -
 15 files changed, 318 insertions(+), 123 deletions(-)
 create mode 100644 drivers/soc/fsl/qbman/dpaa_sys.c

--
2.7.4
