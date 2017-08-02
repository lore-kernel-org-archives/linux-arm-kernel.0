From: jlu@pengutronix.de (Jan Luebbe)
Date: Wed,  2 Aug 2017 14:39:13 +0200
Subject: [PATCH v2 0/9] EDAC drivers for Armada XP L2 and DDR
Message-ID: <20170802123922.11498-1-jlu@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds drivers for the L2 cache and DDR RAM ECC functionality as
found on the MV78230/MV78x60 SoCs. I've tested these changes with the MV78460
(on a custom board with a DDR3 ECC DIMM).

Also contained in this series are an additional debugfs wrapper and devm_
helpers for edac_mc_/edac_device_ allocation and registration, which make error
handing and cleanup simpler.

Compared to the previous v1 series, the following changes have been made:
- Add the aurora-l2 register defines earlier in the series (suggested by
  Russell King and Gregory CLEMENT )
- Changed the DT vendor prefix from "arm" to "marvell" for the ecc-enable/disable
  properties on the aurora-l2 (suggested by Russell King)
- Fix some warnings reported by checkpatch

Compared to the original RFC series, the following changes have been made:
- Integrated Chris' patches for parity and ECC configuration via DT
- Merged the DDR RAM and L2 cache drivers (as requested by Borislav, analogous
  to fsl_ddr_edac.c and mpc85xx_edac.c)
- Added myself to MAINTAINERS (requested by Borislav)
- L2 cache: Track the msg size and use snprintf (review comment by Chris)
- L2 cache: Split error injection from the check function (review comment by
  Chris)
- DDR RAM: Allow 16 bit width in addition to 32 and 64 bit (review comment by
  Chris)
- Use of_match_ptr() (review comments by Chris)
- Minor checkpatch cleanups

Chris Packham (2):
  ARM: l2x0: support parity-enable/disable on aurora
  ARM: l2x0: add marvell,ecc-enable property for aurora

Jan Luebbe (7):
  ARM: l2c: move cache-aurora-l2.h to asm/hardware
  ARM: aurora-l2: add prefix to MAX_RANGE_SIZE
  ARM: aurora-l2: add defines for parity and ECC registers
  EDAC: Add missing debugfs_create_x32 wrapper
  EDAC: Add devres helpers for
    edac_mc_alloc/edac_mc_add_mc(_with_groups)
  EDAC: Add devres helpers for
    edac_device_alloc_ctl_info/edac_device_add_device
  EDAC: Add driver for the Marvell Armada XP SDRAM and L2 cache ECC

 Documentation/devicetree/bindings/arm/l2c2x0.txt |   2 +
 MAINTAINERS                                      |   6 +
 arch/arm/include/asm/hardware/cache-aurora-l2.h  | 103 ++++
 arch/arm/mm/cache-aurora-l2.h                    |  55 --
 arch/arm/mm/cache-l2x0.c                         |  20 +-
 drivers/edac/Kconfig                             |   7 +
 drivers/edac/Makefile                            |   1 +
 drivers/edac/armada_xp_edac.c                    | 639 +++++++++++++++++++++++
 drivers/edac/debugfs.c                           |  11 +
 drivers/edac/edac_device.c                       |  60 +++
 drivers/edac/edac_device.h                       |  29 +
 drivers/edac/edac_mc.c                           |  54 ++
 drivers/edac/edac_mc.h                           |  26 +
 drivers/edac/edac_module.h                       |   5 +
 14 files changed, 960 insertions(+), 58 deletions(-)
 create mode 100644 arch/arm/include/asm/hardware/cache-aurora-l2.h
 delete mode 100644 arch/arm/mm/cache-aurora-l2.h
 create mode 100644 drivers/edac/armada_xp_edac.c

-- 
2.11.0
