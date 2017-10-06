From: lsun@mellanox.com (Liming Sun)
Date: Fri,  6 Oct 2017 15:21:23 -0400
Subject: [PATCH 0/9] Enable dw-mmc multi-card support
Message-ID: <cover.1507315433.git.lsun@mellanox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of commits enables the multi-card support for the dw-mmc
controller. It includes two parts as below.

The first part (patches 1-7) reverts the series of recent commits that
removed the multi-card support with comments saying there was no such
use case in the real world. Actually this feature is being used in
Mellanox Bluefield SoC and has been requested by customers.

The second part (patches 8-9) fixes the DesignWare multi-card support
according to the dw-mmc databook (synnopsys: DesignWare Cores Mobile
Storage Host Databook, 2.70a). It has changes to set the card number
into the CMD register to multiplex requests to different cards when
working in SD_MMC_CEATA mode, set the CTYPE / CLKENA / CDTHRCTL
registers properly according to the spec, and parse the per-card
configuration to match the Linux Documentation
(bindings/mmc/synopsys-dw-mshc.txt).

Liming Sun (9):
  Revert "Documentation: dw-mshc: deprecate num-slots"
  Revert "mmc: dw_mmc: remove the unnecessary slot variable"
  Revert "mmc: dw_mmc: use the 'slot' instead of 'cur_slot'"
  Revert "mmc: dw_mmc: remove the 'id' arguments about functions
    relevant to slot"
  Revert "mmc: dw_mmc: change the array of slots"
  Revert "mmc: dw_mmc: remove the loop about finding slots"
  Revert "mmc: dw_mmc: deprecated the "num-slots" property"
  mmc: dw_mmc: Support two SD_MMC_CE-ATA cards
  mmc: dw_mmc: Parse slot-specific configuration

 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  16 +-
 drivers/mmc/host/dw_mmc-exynos.c                   |   4 +-
 drivers/mmc/host/dw_mmc.c                          | 277 ++++++++++++++++-----
 drivers/mmc/host/dw_mmc.h                          |  17 +-
 4 files changed, 236 insertions(+), 78 deletions(-)

-- 
1.8.3.1
