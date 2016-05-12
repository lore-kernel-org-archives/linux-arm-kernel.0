From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Thu, 12 May 2016 20:05:57 +0800
Subject: [PATCH v4 00/18] Cleanup for populate default bus
Message-ID: <1463054775-18170-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This cleanup patchset cantains two parts.

Firstly, introduce a new way to populate the default bus, then, we can
drop unnecessary calls from the arch code, and do the same thing for
of_iommu_init() in [1].

Secondly, use helper of_platform_default_populate() in linux/of_platform
when possible, instead of calling of_platform_populate() with default
match table, After that, it is possible for driver code build as a module,
and no need to export of_default_bus_match_table anymore.

This patchset is based on Linux 4.6-rc5, and only test in arm/arm64 qemu
with defconfig.

Changes since v3:
- Get rid of by making of_platform_populate callable multiple times,
  sugguested by Rob Herring

Changes since v2:
- Add more acks
- Update based on v4.6-rc2, of-generic.c in sh and board-artpec6.c in arm
  are considered

Changes since v1:
- Add ack, test and review
- Remove v1 patch 14/15, the similar patch has posted and applied,
  see https://patchwork.kernel.org/patch/8096991/

v1:
- https://lkml.org/lkml/2016/1/26/1123

[1]: https://lkml.org/lkml/2016/4/23/31

Kefeng Wang (18):
  of/platform: Add common method to populate default bus
  arc: Remove unnecessary of_platform_populate with default match table
  arm: Remove unnecessary of_platform_populate with default match table
  arm64: Remove unnecessary of_platform_populate with default match
    table
  c6x: Remove unnecessary of_platform_populate with default match table
  cris: Remove unnecessary of_platform_populate with default match
    table
  metag: Remove unnecessary of_platform_populate with default match
    table
  mips: Remove unnecessary of_platform_populate with default match
    table
  nios2: Remove unnecessary of_platform_populate with default match
    table
  sh: Remove unnecessary of_platform_populate with default match table
  xtensa: Remove unnecessary of_platform_populate with default match
    table
  arm: use of_platform_default_populate() to populate
  mips: use of_platform_default_populate() to populate default bus
  bus: imx-weim: use of_platform_default_populate() to populate default
    bus
  bus: uniphier-system-bus: use of_platform_default_populate() to
    populate default bus
  memory: omap-gpmc: use of_platform_default_populate() to populate
    default bus
  of: unittest: use of_platform_default_populate() to populate default
    bus
  Revert "of/platform: export of_default_bus_match_table"

 arch/arc/kernel/setup.c                  |  6 ------
 arch/arm/kernel/setup.c                  |  6 +-----
 arch/arm/mach-artpec/board-artpec6.c     |  3 ---
 arch/arm/mach-at91/at91rm9200.c          |  2 +-
 arch/arm/mach-at91/at91sam9.c            |  2 +-
 arch/arm/mach-at91/sama5.c               |  2 +-
 arch/arm/mach-bcm/board_bcm21664.c       |  2 --
 arch/arm/mach-bcm/board_bcm281xx.c       |  2 --
 arch/arm/mach-bcm/board_bcm2835.c        | 10 ----------
 arch/arm/mach-cns3xxx/core.c             |  3 +--
 arch/arm/mach-davinci/da8xx-dt.c         |  3 +--
 arch/arm/mach-exynos/exynos.c            |  3 ---
 arch/arm/mach-highbank/highbank.c        |  3 ---
 arch/arm/mach-imx/imx27-dt.c             |  2 --
 arch/arm/mach-imx/mach-imx51.c           |  2 --
 arch/arm/mach-imx/mach-imx53.c           |  2 --
 arch/arm/mach-imx/mach-imx6q.c           |  2 +-
 arch/arm/mach-imx/mach-imx6sl.c          |  2 +-
 arch/arm/mach-imx/mach-imx6sx.c          |  2 +-
 arch/arm/mach-imx/mach-imx6ul.c          |  1 -
 arch/arm/mach-imx/mach-imx7d.c           |  1 -
 arch/arm/mach-integrator/integrator_ap.c |  3 +--
 arch/arm/mach-integrator/integrator_cp.c |  3 +--
 arch/arm/mach-keystone/keystone.c        |  1 -
 arch/arm/mach-lpc32xx/phy3250.c          |  3 +--
 arch/arm/mach-mvebu/board-v7.c           |  3 ---
 arch/arm/mach-mvebu/dove.c               |  2 --
 arch/arm/mach-mvebu/kirkwood.c           |  2 +-
 arch/arm/mach-mxs/mach-mxs.c             |  3 +--
 arch/arm/mach-nspire/nspire.c            |  3 +--
 arch/arm/mach-orion5x/board-dt.c         |  3 +--
 arch/arm/mach-picoxcell/common.c         |  2 --
 arch/arm/mach-rockchip/rockchip.c        |  1 -
 arch/arm/mach-s3c24xx/mach-s3c2416-dt.c  |  2 --
 arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c  |  3 ---
 arch/arm/mach-shmobile/setup-r8a7740.c   |  3 ---
 arch/arm/mach-shmobile/setup-sh73a0.c    |  2 --
 arch/arm/mach-spear/spear1310.c          |  2 --
 arch/arm/mach-spear/spear1340.c          |  1 -
 arch/arm/mach-spear/spear300.c           |  3 +--
 arch/arm/mach-spear/spear310.c           |  3 +--
 arch/arm/mach-spear/spear320.c           |  3 +--
 arch/arm/mach-spear/spear6xx.c           |  3 +--
 arch/arm/mach-tegra/tegra.c              |  2 +-
 arch/arm/mach-u300/core.c                |  3 +--
 arch/arm/mach-versatile/versatile_dt.c   |  3 +--
 arch/arm/mach-vt8500/vt8500.c            |  3 ---
 arch/arm/mach-zynq/common.c              |  2 +-
 arch/arm64/kernel/setup.c                | 13 -------------
 arch/c6x/platforms/Makefile              |  2 +-
 arch/c6x/platforms/platform.c            | 17 -----------------
 arch/cris/kernel/setup.c                 |  8 --------
 arch/metag/kernel/setup.c                |  5 +----
 arch/mips/ath79/setup.c                  |  2 --
 arch/mips/jz4740/setup.c                 |  8 --------
 arch/mips/mti-sead3/sead3-setup.c        |  8 --------
 arch/mips/pic32/pic32mzda/init.c         |  3 +--
 arch/mips/pistachio/init.c               | 13 -------------
 arch/mips/xilfpga/init.c                 | 13 -------------
 arch/nios2/platform/platform.c           |  4 +---
 arch/sh/boards/of-generic.c              | 14 --------------
 arch/xtensa/kernel/setup.c               | 11 -----------
 arch/xtensa/kernel/time.c                |  2 ++
 drivers/bus/imx-weim.c                   |  5 ++---
 drivers/bus/uniphier-system-bus.c        |  3 +--
 drivers/memory/omap-gpmc.c               |  3 +--
 drivers/of/platform.c                    | 24 ++++++++++++++++++++++--
 drivers/of/unittest.c                    |  5 ++---
 68 files changed, 58 insertions(+), 233 deletions(-)
 delete mode 100644 arch/c6x/platforms/platform.c

-- 
1.7.12.4
