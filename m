From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Aug 2017 12:36:31 +0200
Subject: [GIT PULL] ARM: SoC fixes for 4.13
Message-ID: <CAK8P3a1sFafctSh6-=9dmD8yFXx8uAhRZs8oFPy2GPJSjGzoTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit aae4e7a8bc44722fe70d58920a36916b1043195e:

  Linux 4.13-rc4 (2017-08-06 18:44:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
tags/armsoc-fixes

for you to fetch changes up to 4dd6a9973b8aaffac4bf37c5bb70e8eae5a7afb4:

  soc: ti: ti_sci_pm_domains: Populate name for genpd (2017-08-18
11:59:53 +0200)

----------------------------------------------------------------
ARM: SoC fixes for 4.13

A small number of bugfixes, nothing serious this time.
Here is a full list.

4.13 regression fix:

- imx7d-sdb pinctrl support regressed in 4.13 due to an incomplete patch

DT fixes for recently added devices:

- badly copied DT entries on imx6qdl-nitrogen6_som broke PCI reset

- sama5d2 memory controller had the wrong ID and registers

- imx7 power domains did not work correctly with deferred probing
  (driver added in 4.12)

- Allwinner H5 pinctrl (added in 4.12) did not work right with GPIO
  interrupts

Fixes for older bugs that just got noticed:

- i.MX25 ADC support (added in 4.6) apparently never worked right due
  to a missing 'ranges' property in DT.

- Renesas Salvador Audio support (added in v4.5) was broken for device
  repeated bind/unbind due to a naming conflict.

- Various allwinner boards are missing an 'ethernet' alias in DT,
  leading to unstable device naming.

Preventive bugfix:

- TI Keystone needs a fix to prevent a NULL pointer dereference with
  an upcoming PM change.

----------------------------------------------------------------
Arnd Bergmann (6):
      Merge tag 'imx-fixes-4.13' of
git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'imx-fixes-4.13-2' of
git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'at91-ab-4.13-dt-fixes' of
git://git.kernel.org/.../abelloni/linux into fixes
      Merge tag 'renesas-fixes4-for-v4.13' of
https://git.kernel.org/.../horms/renesas into fixes
      Merge tag 'sunxi-fixes-for-4.13-2' of
https://git.kernel.org/.../sunxi/linux into fixes
      Merge tag 'imx-fixes-4.13-3' of
git://git.kernel.org/.../shawnguo/linux into fixes

Dave Gerlach (1):
      soc: ti: ti_sci_pm_domains: Populate name for genpd

Fabio Estevam (1):
      ARM: dts: imx7d-sdb: Put pinctrl_spi4 in the correct location

Gary Bisson (1):
      ARM: dts: imx6qdl-nitrogen6_som2: fix PCIe reset

Icenowy Zheng (4):
      arm64: allwinner: a64: bananapi-m64: add missing ethernet0 alias
      arm64: allwinner: a64: pine64: add missing ethernet0 alias
      arm64: allwinner: a64: sopine: add missing ethernet0 alias
      arm64: allwinner: h5: fix pinctrl IRQs

Kuninori Morimoto (1):
      arm64: renesas: salvator-common: avoid audio_clkout naming conflict

Ludovic Desroches (2):
      ARM: dts: at91: sama5d2: use sama5d2 compatible string for SMC
      ARM: dts: at91: sama5d2: fix EBI/NAND controllers declaration

Martin Kaiser (1):
      ARM: dts: i.MX25: add ranges to tscadc

Stefan Agner (1):
      soc: imx: gpcv2: fix regulator deferred probe

 arch/arm/boot/dts/imx25.dtsi                             |  1 +
 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi            |  4 ++--
 arch/arm/boot/dts/imx7d-sdb.dts                          | 16 ++++++++--------
 arch/arm/boot/dts/sama5d2.dtsi                           | 12 ++++++------
 .../arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts |  1 +
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts      |  1 +
 .../boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts   |  1 +
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi             |  3 +++
 arch/arm64/boot/dts/renesas/salvator-common.dtsi         |  2 +-
 drivers/soc/imx/gpcv2.c                                  | 15 ++++++++-------
 drivers/soc/ti/ti_sci_pm_domains.c                       |  2 ++
 11 files changed, 34 insertions(+), 24 deletions(-)
