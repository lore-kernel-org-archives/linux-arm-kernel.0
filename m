From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 4 Jan 2018 17:46:39 +0100
Subject: ARM: SoC fixes for 4.15
Message-ID: <CAK8P3a3cSGE7jK9S09hCgJHBW-VZvD+_Q7sQnc6fUp5NimeJqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ce39882eb1d87dd9bb4f89d4ae09ef2547aee079:

  Merge tag 'amlogic-fixes-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic
into fixes (2017-12-09 20:23:29 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
tags/armsoc-fixes

for you to fetch changes up to abb62c46d4949d44979fa647740feff3f7538799:

  arm64: dts: uniphier: fix gpio-ranges property of PXs3 SoC
(2018-01-04 17:09:01 +0100)

----------------------------------------------------------------
ARM: SoC fixes for 4.15

Fixes this time include mostly device tree changes, as usual,
the notable ones include:

- A number of patches to fix most of the remaining DTC warnings
  that got introduced when DTC started warning about some
  obvious mistakes. We still have some remaining warnings that
  probably may have to wait until 4.16 to get fixed while we
  try to figure out what the correct contents should be.
- On Allwinner A64, Ethernet PHYs need a fix after a mistake in
  coordination between patches merged through multiple branches.
- Various fixes for PMICs on allwinner based boards
- Two fixes for ethernet link detection on some Renesas machines
- Two stability fixes for rockchip based boards

Aside from device-tree, two other areas got fixes for older
problems:

- For TI Davinci DM365, a couple of fixes were needed to repair
  the MMC DMA engine support, apparently this has been broken for
  a while.
- One important fix for all Allwinner chips with the PMIC driver
  as a loadable module.

----------------------------------------------------------------

[note: this is a bit larger than usual. Most of the fixes were merged
before Christmas into the fixes branch, but then neither of us
was around to send the pull request until now].

Alejandro Mery (3):
      ARM: davinci: Use platform_device_register_full() to create pdev
for dm365's eDMA
      ARM: davinci: Add dma_mask to dm365's eDMA device
      ARM: davinci: fix mmc entries in dm365's dma_slave_map

Arnd Bergmann (8):
      Merge tag 'v4.15-rockchip-dts32fixes-1' of
ssh://gitolite.kernel.org/.../mmind/linux-rockchip into fixes
      Merge tag 'v4.15-rockchip-dts64fixes-1' of
ssh://gitolite.kernel.org/.../mmind/linux-rockchip into fixes
      Merge tag 'at91-ab-4.15-dt-fixes' of
ssh://gitolite.kernel.org/.../abelloni/linux into fixes
      Merge tag 'davinci-fixes-for-v4.15' of
ssh://gitolite.kernel.org/.../nsekhar/linux-davinci into fixes
      ARM: dts: ls1021a: fix incorrect clock references
      ARM: dts: tango4: remove bogus interrupt-controller property
      Merge tag 'renesas-fixes-for-v4.15' of
ssh://gitolite.kernel.org/.../horms/renesas into fixes
      Merge tag 'sunxi-fixes-for-4.15' of
ssh://gitolite.kernel.org/.../sunxi/linux into fixes

Bogdan Mirea (2):
      arm64: dts: renesas: salvator-x: Remove renesas, no-ether-link property
      arm64: dts: renesas: ulcb: Remove renesas, no-ether-link property

Chen-Yu Tsai (1):
      ARM: dts: sunxi: Convert to CCU index macros for HDMI controller

David Lechner (1):
      ARM: dts: da850-lego-ev3: Fix battery voltage gpio

Heiko Stuebner (3):
      ARM: dts: rockchip: add cpu0-regulator on rk3066a-marsboard
      arm64: dts: rockchip: fix trailing 0 in rk3328 tsadc interrupts
      arm64: dts: rockchip: limit rk3328-rock64 gmac speed to 100MBit for now

Icenowy Zheng (1):
      arm64: allwinner: a64: add Ethernet PHY regulator for several boards

Jagan Teki (1):
      arm64: allwinner: a64-sopine: Fix to use dcdc1 regulator instead of vcc3v3

Javier Martinez Canillas (1):
      ARM: dts: exynos: Enable Mixer node for Exynos5800 Peach Pi machine

Joel Stanley (1):
      ARM: dts: aspeed-g4: Correct VUART IRQ number

Klaus Goger (1):
      arm64: dts: rockchip: remove vdd_log from rk3399-puma

Masahiro Yamada (1):
      arm64: dts: uniphier: fix gpio-ranges property of PXs3 SoC

Maxime Ripard (1):
      ARM: dts: sun8i: a711: Reinstate the PMIC compatible

Peter Rosin (1):
      ARM: dts: at91: disable the nxp,se97b SMBUS timeout on the TSE-850

Rob Herring (1):
      ARM: dts: rockchip: fix rk3288 iep-IOMMU interrupts property cells

Sergey Matyukevich (1):
      arm64: dts: orange-pi-zero-plus2: fix sdcard detect

Stefan Br?ns (1):
      sunxi-rsb: Include OF based modalias in device uevent

 arch/arm/boot/dts/aspeed-g4.dtsi                   |  2 +-
 arch/arm/boot/dts/at91-tse850-3.dts                |  1 +
 arch/arm/boot/dts/da850-lego-ev3.dts               |  4 +--
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |  4 +++
 arch/arm/boot/dts/ls1021a-qds.dts                  |  2 +-
 arch/arm/boot/dts/ls1021a-twr.dts                  |  2 +-
 arch/arm/boot/dts/rk3066a-marsboard.dts            |  4 +++
 arch/arm/boot/dts/rk3288.dtsi                      |  2 +-
 arch/arm/boot/dts/sun4i-a10.dtsi                   |  4 +--
 arch/arm/boot/dts/sun5i-a10s.dtsi                  |  4 +--
 arch/arm/boot/dts/sun6i-a31.dtsi                   |  4 +--
 arch/arm/boot/dts/sun7i-a20.dtsi                   |  4 +--
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts          |  1 +
 arch/arm/boot/dts/tango4-common.dtsi               |  1 -
 arch/arm/mach-davinci/dm365.c                      | 29 ++++++++++++++--------
 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts |  1 +
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |  1 +
 .../dts/allwinner/sun50i-a64-sopine-baseboard.dts  |  3 ++-
 .../boot/dts/allwinner/sun50i-a64-sopine.dtsi      | 11 +-------
 .../allwinner/sun50i-h5-orangepi-zero-plus2.dts    |  2 +-
 arch/arm64/boot/dts/renesas/salvator-common.dtsi   |  1 -
 arch/arm64/boot/dts/renesas/ulcb.dtsi              |  1 -
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts     |  2 ++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      | 11 --------
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi   |  4 +--
 drivers/bus/sunxi-rsb.c                            |  1 +
 27 files changed, 54 insertions(+), 54 deletions(-)
