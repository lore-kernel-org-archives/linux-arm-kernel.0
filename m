From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Jan 2018 17:12:15 +0100
Subject: ARM: SoC fixes for 4.15
Message-ID: <CAK8P3a2Ys-N3K+51gQ9Af+j+BdYR2SxJ6K24V+qz2odBzbdtAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit b2cd1df66037e7c4697c7e40496bf7e4a5e16a2d:

  Linux 4.15-rc7 (2018-01-07 14:22:41 -0800)

are available in the git repository at:

  ssh://git at gitolite.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
tags/armsoc-fixes

for you to fetch changes up to b7563e2796f8b23c98afcfea7363194227fa089d:

  phy: work around 'phys' references to usb-nop-xceiv devices
(2018-01-19 16:12:37 +0100)

----------------------------------------------------------------
ARM: SoC fixes for 4.15

We have various small DT fixes, and one important regression fix:

The recent device tree bugfixes that were intended to address issues that
'dtc' started warning about in 4.15 fixed various USB PHY device nodes,
but it turns out that we had code that depended on those nodes being
incorrect and the probe failing with a particular error code. With the
workaround we can also deal with correct device nodes.

The DT fixes include:
 - Allwinner A10 and A20 had the display pipeline set up incorrectly
   (introduced in v4.15)
 - The Altera PMU lacked an interrupt-parent (never worked)
 - Pin muxing on the Openblocks A7 (never worked)
 - Clocks might get set up wrong on Armada 7K/8K (4.15 regression)

We now have  additional device tree patches to address all the remaining
warnings introduced in 4.15, but decided to queue them for 4.16 instead,
to avoid risking another regression like the USB PHY thing mentioned
above.

----------------------------------------------------------------

[note: I originally sent the phy-core patch to Greg with Kishon's
 ack, as drivers/phy stuff tends to go that route but got no reply
 over the last week, so I'm including it here instead. As the bug
 was introduced through arm-soc, this seems like the best way
 to now make sure we fix it before the release.]

Arnd Bergmann (2):
      arm64: dts: socfpga: add missing interrupt-parent
      phy: work around 'phys' references to usb-nop-xceiv devices

Chen-Yu Tsai (1):
      ARM: dts: sun[47]i: Fix display backend 1 output to TCON0 remote endpoint

Gregory CLEMENT (1):
      ARM64: dts: marvell: armada-cp110: Fix clock resources for various node

Mathieu Malaterre (1):
      ARM: dts: da850-lcdk: Remove leading 0x and 0s from unit address

Maxime Ripard (1):
      ARM: sunxi_defconfig: Enable CMA

Olof Johansson (3):
      Merge tag 'davinci-for-v4.16/dt' of
https://git.kernel.org/.../nsekhar/linux-davinci into fixes
      Merge tag 'mvebu-fixes-4.15-1' of
git://git.infradead.org/linux-mvebu into fixes
      Merge tag 'sunxi-fixes-for-4.15-2' of
https://git.kernel.org/.../sunxi/linux into fixes

Thomas Petazzoni (1):
      ARM: dts: kirkwood: fix pin-muxing of MPP7 on OpenBlocks A7

 arch/arm/boot/dts/da850-lcdk.dts                     |  4 ++--
 arch/arm/boot/dts/kirkwood-openblocks_a7.dts         | 10 ++++++++--
 arch/arm/boot/dts/sun4i-a10.dtsi                     |  2 +-
 arch/arm/boot/dts/sun7i-a20.dtsi                     |  2 +-
 arch/arm/configs/sunxi_defconfig                     |  2 ++
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi    |  1 +
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 13 ++++++++-----
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  |  9 ++++++---
 drivers/phy/phy-core.c                               |  4 ++++
 9 files changed, 33 insertions(+), 14 deletions(-)
