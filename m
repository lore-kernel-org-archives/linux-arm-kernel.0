From: dinguyen@altera.com (dinguyen at altera.com)
Date: Thu, 24 Jan 2013 19:00:28 -0600
Subject: [PATCHv1 for soc 0/5] Enabling socfpga on hardware
Message-ID: <1359075633-13502-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Hi,

Up until this point, support for socfpga has only been for a virtual target environment.
Here are a set of patches that enables socfpga on actual hardware.

patch: arm: Add v7_invalidate_l1 to cache-v7.S  should be of some interest.
When enabling SMP on ARMv7 hardware on socfpga, the call to v7_flush_dcache_all was
making the main CPU lost. On socfpga, as well as IMX, SHMOBILE, and TEGRA the call
to v7_invalidate_l1 was required.

Thanks,
Dinh

Dinh Nguyen (5):
  arm: socfpga: Add new device tree source for actual socfpga HW
  arm: socfpga: Add clock entries to socfpga.dtsi
  arm: socfpga: Add entries to enable make dtbs socfpga
  arm: Add v7_invalidate_l1 to cache-v7.S
  arm: socfpga: Add SMP support for actual socfpga harware

 arch/arm/boot/dts/Makefile             |    2 ++
 arch/arm/boot/dts/socfpga.dtsi         |   59 ++++++++++++++++++++++++-------
 arch/arm/boot/dts/socfpga_cyclone5.dts |   28 ++++++++++++++-
 arch/arm/boot/dts/socfpga_vt.dts       |   60 ++++++++++++++++++++++++++++++++
 arch/arm/configs/socfpga_defconfig     |    1 +
 arch/arm/mach-imx/headsmp.S            |   47 -------------------------
 arch/arm/mach-shmobile/headsmp.S       |   48 -------------------------
 arch/arm/mach-socfpga/core.h           |    4 ++-
 arch/arm/mach-socfpga/headsmp.S        |   14 +++++---
 arch/arm/mach-socfpga/platsmp.c        |    3 +-
 arch/arm/mach-socfpga/socfpga.c        |   17 +++++++++
 arch/arm/mach-tegra/headsmp.S          |   43 -----------------------
 arch/arm/mm/cache-v7.S                 |   47 +++++++++++++++++++++++++
 13 files changed, 216 insertions(+), 157 deletions(-)
 create mode 100644 arch/arm/boot/dts/socfpga_vt.dts

-- 
1.7.9.5
