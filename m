From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sun,  6 Nov 2016 23:26:53 +0100
Subject: [PATCH 00/19] Various Armada 370/XP DT warning fixup
Message-ID: <20161106222712.27366-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As it was done a few months ago for kirkwood, this patchset fixes up
various warning from the DT compiler when using the flag W=1 with
make.

The only remaining warnings are the following:
  DTC     arch/arm/boot/dts/armada-370-db.dtb
Warning (unit_address_vs_reg): Node /sound/simple-audio-card,dai-link at 0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound/simple-audio-card,dai-link at 1 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound/simple-audio-card,dai-link at 2 has a unit name, but no reg property

However it seems a false positive as here the '@' is part of the name
of the node and is not a reference of an address. Moreover the node
name is directly used by the driver so it must not be modified.

While working on this series I found that currently PCIe can't work on
the Armada XP Matrix board, the firs patch fixes it.

The next steps will be to do the same on the Armada 375, 38x, 39x and
on the arm64 SoCs.

Then an other improvement would be to flatten the device tree of the
dts by using the reference to the label as much as possible.

Gregory

Gregory CLEMENT (19):
  ARM: dts: armada-xp-matrix: Fix the location of the pcie-controller
    node
  ARM: dts: armada-370-xp: move the cpurst node in the common file
  ARM: dts: armada-370-xp: add node labels
  ARM: dts: armada-370-xp: Use the node labels
  ARM: dts: armada-370-xp: Fixup mdio DT warning
  ARM: dts: armada-370-xp: Fixup bootrom DT warning
  ARM: dts: armada-370-xp: Fixup devbus DT warning
  ARM: dts: armada-370-xp: Fixup bm-bppi DT warning
  ARM: dts: armada-370-xp: Fixup sa-ram DT warning
  ARM: dts: armada-xp: Fixup pcie DT warnings
  ARM: dts: armada-370: Fixup pcie DT warnings
  ARM: dts: armada-370-xp: Remove skeleton.dtsi
  ARM: dts: armada-370-xp: Fixup l2-cache DT warning
  ARM: dts: armada-370-xp: Fixup internal-regs DT warning
  ARM: dts: armada-370-xp: Fixup soc DT warning
  ARM: dts: armada-370-xp: Fixup memory DT warning
  ARM: dts: armada-370-xp: Remove address from dsa unit name
  ARM: dts: armada-370-xp: Remove button address and fixup names
  ARM: dts: armada-370-xp: Fixup regulator DT warning

 arch/arm/boot/dts/armada-370-db.dts                |  67 ++++----
 arch/arm/boot/dts/armada-370-dlink-dns327l.dts     |  34 ++---
 arch/arm/boot/dts/armada-370-mirabox.dts           |  61 ++++----
 arch/arm/boot/dts/armada-370-netgear-rn102.dts     |  54 +++----
 arch/arm/boot/dts/armada-370-netgear-rn104.dts     |  62 ++++----
 arch/arm/boot/dts/armada-370-rd.dts                |  61 ++++----
 arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts  |  31 ++--
 arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi |  49 +++---
 .../dts/armada-370-seagate-personal-cloud-2bay.dts |   4 +-
 .../boot/dts/armada-370-seagate-personal-cloud.dts |   4 +-
 .../dts/armada-370-seagate-personal-cloud.dtsi     |  48 +++---
 arch/arm/boot/dts/armada-370-synology-ds213j.dts   |  22 +--
 arch/arm/boot/dts/armada-370-xp.dtsi               |  43 +++---
 arch/arm/boot/dts/armada-370.dtsi                  | 144 +++++++++--------
 arch/arm/boot/dts/armada-xp-axpwifiap.dts          |  72 ++++-----
 arch/arm/boot/dts/armada-xp-db.dts                 | 170 ++++++++++-----------
 arch/arm/boot/dts/armada-xp-gp.dts                 | 146 +++++++++---------
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts    |  57 ++++---
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts      |  56 +++----
 arch/arm/boot/dts/armada-xp-matrix.dts             |  24 +--
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           |  16 +-
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |  24 +--
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |  26 ++--
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts     |  71 ++++-----
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   | 124 +++++++--------
 arch/arm/boot/dts/armada-xp-synology-ds414.dts     |  79 +++++-----
 arch/arm/boot/dts/armada-xp.dtsi                   | 106 ++++++-------
 27 files changed, 832 insertions(+), 823 deletions(-)

-- 
2.10.1
