From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 15 May 2014 20:31:55 +0900
Subject: [PATCH v6 00/17] ARM: shmobile: r8a7779, marzen: CCF and multiplatform
Message-ID: <1400153532-23675-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The aim of this series is to add common clock framework and in turn
multiplatform support to the r8a7779 SoC and marzen-reference.  It
subsequently removes non-multiplatform support from marzen-reference.

This is based on work for R-Car Gen2 by Laurent Pinchart and Magnus Damm.


This series is a minor update to v5 to take into account:
* An Ack
* Request for caching of the pin mode
* Patches that have been queued up for v3.16

I intend to merge this series unless there are objections.


Applied on top of a merge of:
* The renesas-devel-v3.15-rc1-20140515 tag of my renesas tree.
* The clk-next branch of Mike Turquettes's tree
  This is to provide the following which were previously part of this series:
  - clk: shmobile: r8a7779: Add MSTP clock support
  - clk: shmobile: r8a7779: Add clocks support


Caveats:

* SMSC_PHY is known not to work with marzen though the reason for
  this is not known. As this is selected in the shmobile_defconfig
  it should be manually disabled before compiling that configuration
  for use on Marzen.

Simon Horman (17):
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

 arch/arm/boot/dts/Makefile                      |   4 +-
 arch/arm/boot/dts/r8a7779-marzen-reference.dts  | 121 ------------------
 arch/arm/boot/dts/r8a7779-marzen.dts            |  98 +++++++++++++++
 arch/arm/boot/dts/r8a7779.dtsi                  | 156 ++++++++++++++++++++++++
 arch/arm/configs/shmobile_defconfig             |   2 +
 arch/arm/mach-shmobile/Kconfig                  |  23 ++--
 arch/arm/mach-shmobile/Makefile                 |   2 +-
 arch/arm/mach-shmobile/Makefile.boot            |   1 -
 arch/arm/mach-shmobile/board-marzen-reference.c |  28 +++++
 arch/arm/mach-shmobile/clock-r8a7779.c          |  22 ++--
 arch/arm/mach-shmobile/include/mach/r8a7779.h   |   2 +-
 arch/arm/mach-shmobile/setup-r8a7779.c          |  32 ++---
 include/dt-bindings/clock/r8a7779-clock.h       |  64 ++++++++++
 13 files changed, 393 insertions(+), 162 deletions(-)
 delete mode 100644 arch/arm/boot/dts/r8a7779-marzen-reference.dts
 create mode 100644 include/dt-bindings/clock/r8a7779-clock.h

-- 
1.8.5.2
