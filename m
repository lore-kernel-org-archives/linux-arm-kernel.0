From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Mar 2014 17:59:43 +0900
Subject: [PATCH v4 00/19]  ARM: shmobile: r8a7779,
 marzen: CCF and multiplatform
Message-ID: <1394701202-25823-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The aim of this series is to add common clock framework and in turn
multiplatform support to the r8a7779 SoC and marzen-reference.  It
subsequently removes non-multiplatform support from marzen-reference.

This is based on work for R-Car Gen2 by Laurent Pinchart and Magnus Damm.


This series is based on the renesas-devel-v3.14-rc6-20140313v3
tag of my renesas tree.

This series requires "spi: sh-hspi: Do not specifically request shyway_clk"
in order for HSPI to be initialised when booting using multiplatform.

This series is known not to work when
booting with SMP enabled and maxcpus not set to 1.

This series attempts to address the extensive review
received for v3 of this series. Changes are noted
in the changelog of individual patches.

Simon Horman (19):
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
  ARM: shmobile: marzen: Add to shmobile defconfig
  ARM: shmobile: Remove non-multiplatform Marzen reference support
  ARM: shmobile: Let Marzen multiplatform boot with Marzen DTB
  ARM: shmobile: Remove Marzen reference DTS
  ARM: shmobile: marzen-reference: Remove legacy clock support

 .../bindings/clock/renesas,cpg-mstp-clocks.txt     |   1 +
 .../bindings/clock/renesas,r8a7779-cpg-clocks.txt  |  27 +++
 arch/arm/boot/dts/Makefile                         |   4 +-
 arch/arm/boot/dts/r8a7779-marzen-reference.dts     | 120 --------------
 arch/arm/boot/dts/r8a7779-marzen.dts               |  97 +++++++++++
 arch/arm/boot/dts/r8a7779.dtsi                     | 163 +++++++++++++++++++
 arch/arm/configs/shmobile_defconfig                |   2 +
 arch/arm/mach-shmobile/Kconfig                     |  22 +--
 arch/arm/mach-shmobile/Makefile                    |   2 +-
 arch/arm/mach-shmobile/Makefile.boot               |   1 -
 arch/arm/mach-shmobile/board-marzen-reference.c    |  30 ++++
 arch/arm/mach-shmobile/clock-r8a7779.c             |  22 ++-
 arch/arm/mach-shmobile/include/mach/r8a7779.h      |   2 +-
 arch/arm/mach-shmobile/setup-r8a7779.c             |  28 ++--
 drivers/clk/shmobile/Makefile                      |   1 +
 drivers/clk/shmobile/clk-r8a7779.c                 | 181 +++++++++++++++++++++
 include/dt-bindings/clock/r8a7779-clock.h          |  64 ++++++++
 include/linux/clk/shmobile.h                       |   3 +
 18 files changed, 609 insertions(+), 161 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,r8a7779-cpg-clocks.txt
 delete mode 100644 arch/arm/boot/dts/r8a7779-marzen-reference.dts
 create mode 100644 drivers/clk/shmobile/clk-r8a7779.c
 create mode 100644 include/dt-bindings/clock/r8a7779-clock.h

-- 
1.8.5.2
