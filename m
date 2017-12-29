From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 29 Dec 2017 17:17:14 +0100
Subject: [PATCH 0/4] Armada 7K/8K CP110 DT de-duplication
Message-ID: <20171229161718.8896-1-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series aims at de-duplicating the Armada CP110 Device Tree
description, which is currently duplicated between
armada-cp110-master.dtsi and armada-cp110-slave.dtsi, even though they
are almost identical. Indeed, one concept of Marvell SoCs is that they
are made of HW blocks composed of a variety of IPs (network, PCIe,
SATA, XOR, SPI, I2C, etc.), and those HW blocks can be duplicated
several times within a given SoC. The Armada 7K SoC has a single CP110
(so no duplication), while the Armada 8K SoC has two CP110. In the
future, SoCs with more than 2 CP110s will be introduced.

This duplication issue has been discussed at the DT workshop [1] in
Prague last October, and I presented on this topic [2]. The solution
of using the C pre-processor to avoid this duplication has been
validated by the people present in this DT workshop, and this patch
series simply submits what has been presented.

The first three patches are minor preparation patches. The patch
making use of aliases for SPI busses simply aims at reducing the
number of changes between the CP110 master and CP110 slave
description, by avoiding the need for the cell-index property in the
SPI controller DT nodes.

The last patch implements the de-duplication itself, by introducing an
armada-cp110.dtsi file included twice on Armada 8K platforms, once for
the master CP110 and once for the slave CP110.

Note: this series is based on mvebu/dt64-nand, since it is the branch
that contains the most up-to-date DT changes for the Marvell Armada
7K/8K platforms. When PATCH 4/4 is applied, I recommend checking that
the DTB contents are the same before/after. To achieve that, just
build the dtb before/after, "decompile" it with "dtc -I dtb -O dts",
and diff the result. The only difference should be the SDHCI
controller appearing in the slave CP (see the commit log of PATCH 4/4
for details about this).

Thanks!

Thomas

[1] https://elinux.org/Device_tree_kernel_summit_2017_etherpad
[2] https://elinux.org/images/1/14/DTWorkshop2017-duplicate-data.pdf

Thomas Petazzoni (4):
  arm64: dts: marvell: fix watchdog unit address in Armada AP806
  arm64: dts: marvell: use mvebu-icu.h where possible
  arm64: dts: marvell: use aliases for SPI busses on Armada 7K/8K
  arm64: dts: marvell: de-duplicate CP110 description

 arch/arm64/boot/dts/marvell/armada-70x0.dtsi       |   2 +
 arch/arm64/boot/dts/marvell/armada-80x0.dtsi       |   4 +
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |   4 +-
 arch/arm64/boot/dts/marvell/armada-common.dtsi     |  10 +
 .../boot/dts/marvell/armada-cp110-master.dtsi      | 406 +-------------------
 .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 414 ++-------------------
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi      | 398 ++++++++++++++++++++
 7 files changed, 465 insertions(+), 773 deletions(-)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-common.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-cp110.dtsi

-- 
2.14.3
