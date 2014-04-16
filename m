From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 16 Apr 2014 10:57:14 +0900
Subject: [PATCH v5 00/20] ARM: shmobile: r8a7779, marzen: CCF and multiplatform
Message-ID: <1397613454-7522-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The aim of this series is to add common clock framework and in turn
multiplatform support to the r8a7779 SoC and marzen-reference.  It
subsequently removes non-multiplatform support from marzen-reference.

This is based on work for R-Car Gen2 by Laurent Pinchart and Magnus Damm.


This series attempts to address the  review received for v4 of this series.
Changes are noted in the changelog of individual patches.


Applied on top of the renesas-devel-v3.15-rc1-20140415 tag of
my renesas tree.

Requires the following patch for correct runtime operation:

spi: sh-hspi: Do not specifically request shyway_clk clock

Caveats:

* SMSC_PHY is known not to work with marzen though the reason for
  this is not known. As this is selected in the shmobile_defconfig
  it should be manually disabled before compiling that configuration
  for use on Marzen.

* Does not appear to work with SMP. A work around is to use maxcpus=1.


Simon Horman (20):
  clk: shmobile: r8a7779: Add clocks support
  clk: shmobile: r8a7779: Add MSTP clock support
  ARM: shmobile: r8a7779: Add clock index macros for DT sources
  ARM: shmobile: r8a7779: Add clocks
  ARM: shmobile: Sync Marzen DTS with Marzen reference DTS
  ARM: shmobile: marzen: Specify external clock frequency in DT
  ARM: shmobile: r8a7779: Reference clocks
  ARM: shmobile: r8a7779: Add helper to read mode pins
  ARM: shmobile: r8a7779: Move r8a7779_earlytimer_init to
    clock-r8a7779.c
  ARM: shmobile: marzen-reference: Move clock and OF device
    initialisation into board code
  ARM: shmobile: r8a7779: Do not include sh_clk.h in r8a7779.h
  ARM: shmobile: r8a7779: Initial multiplatform support
  ARM: shmobile: marzen-reference: Initialize CPG device
  ARM: shmobile: marzen-reference: Instantiate clkdevs for SCIF and TMU
  ARM: shmobile: marzen-reference: Work around core clock issues
  ARM: shmobile: marzen: Add to shmobile defconfig
  ARM: shmobile: Remove non-multiplatform Marzen reference support
  ARM: shmobile: Let Marzen multiplatform boot with Marzen DTB
  ARM: shmobile: Remove Marzen reference DTS
  ARM: shmobile: marzen-reference: Remove legacy clock support

 .../bindings/clock/renesas,cpg-mstp-clocks.txt     |   1 +
 .../bindings/clock/renesas,r8a7779-cpg-clocks.txt  |  27 ++++
 arch/arm/boot/dts/Makefile                         |   4 +-
 arch/arm/boot/dts/r8a7779-marzen-reference.dts     | 120 --------------
 arch/arm/boot/dts/r8a7779-marzen.dts               |  97 +++++++++++
 arch/arm/boot/dts/r8a7779.dtsi                     | 156 ++++++++++++++++++
 arch/arm/configs/shmobile_defconfig                |   2 +
 arch/arm/mach-shmobile/Kconfig                     |  23 ++-
 arch/arm/mach-shmobile/Makefile                    |   2 +-
 arch/arm/mach-shmobile/Makefile.boot               |   1 -
 arch/arm/mach-shmobile/board-marzen-reference.c    |  39 +++++
 arch/arm/mach-shmobile/clock-r8a7779.c             |  22 +--
 arch/arm/mach-shmobile/include/mach/r8a7779.h      |   2 +-
 arch/arm/mach-shmobile/setup-r8a7779.c             |  28 ++--
 drivers/clk/shmobile/Makefile                      |   1 +
 drivers/clk/shmobile/clk-r8a7779.c                 | 180 +++++++++++++++++++++
 include/dt-bindings/clock/r8a7779-clock.h          |  64 ++++++++
 include/linux/clk/shmobile.h                       |   3 +
 18 files changed, 611 insertions(+), 161 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,r8a7779-cpg-clocks.txt
 delete mode 100644 arch/arm/boot/dts/r8a7779-marzen-reference.dts
 create mode 100644 drivers/clk/shmobile/clk-r8a7779.c
 create mode 100644 include/dt-bindings/clock/r8a7779-clock.h

-- 
1.8.5.2
