From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Fri,  9 Nov 2018 20:03:40 +1300
Subject: [PATCH v6 0/9] EDAC drivers for Armada XP L2 and DDR
Message-ID: <20181109070349.20464-1-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current plan is for these to go in via the ARM tree once appropriate
Reviews/Acks have been given

http://lists.infradead.org/pipermail/linux-arm-kernel/2017-August/525561.html

This series adds drivers for the L2 cache and DDR RAM ECC functionality as
found on the MV78230/MV78x60 SoCs. Jan has tested these changes with the
MV78460 (on a custom board with a DDR3 ECC DIMM), Chris has tested these
changes with 88F6820 and 98dx3236 (both a custom boards with fixed DDR3 + ECC).

Also contained in this series is an additional debugfs wrapper.

Compared to the previous v5 series I've split the dt-binding documentation into
its own patch and updated armada_xp_edac.c to use a SPDX license.

Compared to the previous v4 series I've added my s-o-b to some of Jan's
patches and rebased against v4.19.0.

Compared to the previous v3 series, the following changes have been made:
- Use shorter names for the AURORA ECC and parity registers
- Numerous formatting changes to edac/armada_xp.c (as requested by Boris)
- Added support for Armada-38x and 98dx3236 SoCs

Compared to the previous v2 series, the following changes have been made:
- Allocate EDAC structures later during probing and drop devres support
  patches (requested by Boris)
- Make drvdata->width usage consistent according to the comment (suggested by
  Chris)

Compared to the previous v1 series, the following changes have been made:
- Add the aurora-l2 register defines earlier in the series (suggested by
  Russell King and Gregory CLEMENT )
- Changed the DT vendor prefix from "arm" to "marvell" for the ecc-enable/disable
  properties on the aurora-l2 (suggested by Russell King)
- Fix some warnings reported by checkpatch

Compared to the original RFC series, the following changes have been made:
- Integrated Chris' patches for parity and ECC configuration via DT
- Merged the DDR RAM and L2 cache drivers (as requested by Boris, analogous
  to fsl_ddr_edac.c and mpc85xx_edac.c)
- Added myself to MAINTAINERS (requested by Boris)
- L2 cache: Track the msg size and use snprintf (review comment by Chris)
- L2 cache: Split error injection from the check function (review comment by
  Chris)
- DDR RAM: Allow 16 bit width in addition to 32 and 64 bit (review comment by
  Chris)
- Use of_match_ptr() (review comments by Chris)
- Minor checkpatch cleanups

Chris Packham (4):
  ARM: l2x0: support parity-enable/disable on aurora
  dt-bindings: ARM: document marvell,ecc-enable binding
  ARM: l2x0: add marvell,ecc-enable property for aurora
  EDAC: armada_xp: Add support for more SoCs

Jan Luebbe (5):
  ARM: l2c: move cache-aurora-l2.h to asm/hardware
  ARM: aurora-l2: add prefix to MAX_RANGE_SIZE
  ARM: aurora-l2: add defines for parity and ECC registers
  EDAC: Add missing debugfs_create_x32 wrapper
  EDAC: Add driver for the Marvell Armada XP SDRAM and L2 cache ECC

 .../devicetree/bindings/arm/l2c2x0.txt        |   2 +
 MAINTAINERS                                   |   6 +
 .../asm/hardware}/cache-aurora-l2.h           |  50 +-
 arch/arm/mm/cache-l2x0.c                      |  20 +-
 drivers/edac/Kconfig                          |   7 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/armada_xp_edac.c                 | 635 ++++++++++++++++++
 drivers/edac/debugfs.c                        |  11 +
 drivers/edac/edac_module.h                    |   5 +
 9 files changed, 733 insertions(+), 4 deletions(-)
 rename arch/arm/{mm => include/asm/hardware}/cache-aurora-l2.h (50%)
 create mode 100644 drivers/edac/armada_xp_edac.c

-- 
2.19.1
