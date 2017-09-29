From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 Sep 2017 13:53:35 +0200
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v4.15
Message-ID: <cover.1506683482.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT updates for v4.15.


The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v4.15

for you to fetch changes up to 7031a219f649d12acda8a70a4b6b816ee123c8e2:

  ARM: dts: r8a7743: Add MSIOF[012] support (2017-09-28 08:02:04 +0200)

----------------------------------------------------------------
Renesas ARM Based SoC DT Updates for v4.15

* r7s72100 (RZ/A1) Peach board
  - Add pin groups for SCIF2 serial debug interface and Ethernet
    This avoids relying on bootloader settings
  - Support control of LED1 using gpio-leds

* r8a7743 (RZ/G1M) and r8a7745 (RZ/G1E) SoCs
  - Add MSIOF[012] support and define aliases for spi[0123]

* r8a7743 (RZ/G1M) SoC
  - Add I2C and IIC core nodes

* r8a7743 (RZ/G1M) iW-RainboW-G20D-Qseven development platform
   - Enable SDHI1 SD controller supporting high-speed and SDR50 transfers
   - Add chosen node to allow correct selection of serial console
     and the kernel command line
   - Enable RTC support
   - Enable USB2.0 host support
     This includes enabling USB PHY and internal PCI

* r8a7743 (RZ/G1M) iW-RainboW-G20M-Qseven and
  r8a7745 (RZ/G1E) iW-RainboW-G22M-SM SoMs
   - Enable Add SPI NOR support
     This devices is used to boot up the system to the SoM DT

* r8a7743 (RZ/G1M) iW-RainboW-G20M-Qseven SoM
  - Enable SDHI0 SD controller supporting high-speed transfers

* r8a7745 (RZ/G1E) iW-RainboW-G22D development platform
  - Add pnctl support for scif4
    This avoids reling on boot loader settings
  - Add EtherAVB support

* r8a7745 (RZ/G1E) iW-RainboW-G22M-SM SoM
  - Add basic SoM support
  - Enable MMCIF eMMC support
  - Enable RTC support
  - Enable SDHI1 SD controller supporting high-speed transfers

* r8a779[0-4] R-Car Gen2 SoCs
  - Add reset control properties
    Geert Uytterhoeven says:

    This patch series describes the reset topology on all R-Car Gen2 Socs,
    like was done before for R-Car Gen3 and RZ/G1.

    Resets usually match the corresponding module clocks.  Exceptions are:
      - The audio module has resets for the Serial Sound Interfaces only,
      - The display module has only a single reset for all DU channels, but
	adding reset properties for the display is postponed upon request
	from Laurent.

   - Convert to new CPG/MSSR bindings
     Geert Uytterhoven says:

     Currently Renesas R-Car Gen2 SoCs use the common clk-rcar-gen2,
     clk-mstp, and clk-div6 drivers, which depend on most clocks being
     described in DT.  Especially the module (MSTP) clocks are cumbersome
     and error prone, due to 3 arrays (clocks, clock-indices, and
     clock-output-names) to be kept in sync. In addition, the clk-mstp
     driver cannot be extended easily to also support module resets, which
     are provided by the same hardware module.

     Hence when developing support for R-Car Gen3 SoCs, another approach
     was chosen, which led to the CPG/MSSR driver core, and SoC-specific
     subdrivers (initially for R-Car Gen3, but later also for RZ/G1).

     This series converts the various R-Car Gen2 DTSes to migrate to the
     new CPG/MSSR drivers that were added in v4.13-rc1.

* r8a779[0,1,3,4] R-Car Gen2 SoCs
  - Stop grouping clocks under a "clocks" subnode
    Geert Uytterhoeven says:

    The current practice is to not group clocks under a "clocks" subnode,
    but just put them together with the other on-SoC devices.

    Hence this patch series implements this for the various R-Car Gen2
    DTSes that still need this (r8a7792.dtsi is OK).

* r8a7794 (E2) Alt board
  - Correct inverted sense of SD wip pins

----------------------------------------------------------------
Biju Das (17):
      ARM: dts: r8a7743: Add SDHI controllers
      ARM: dts: iwg20m: Enable SDHI0 controller
      ARM: dts: iwg20d-q7: Add SDHI1 support
      ARM: dts: r8a7745: Add GPIO support
      ARM: dts: iwg22m: Add iWave RZG1E SODIMM SOM
      ARM: dts: iwg22d-sodimm: Add support for iWave G22D-SODIMM board
      ARM: dts: r8a7745: Add Ethernet AVB support
      ARM: dts: iwg20d-q7: Add chosen node
      ARM: dts: iwg20d-q7: Add RTC support
      ARM: dts: iwg22d-sodimm: Add pinctl support for scif4
      ARM: dts: iwg22d-sodimm: Add Ethernet AVB support
      ARM: dts: r8a7743: Add internal PCI bridge nodes
      ARM: dts: r8a7743: Add USB PHY DT support
      ARM: dts: r8a7743: Link PCI USB devices to USB PHY
      ARM: dts: iwg20d-q7: Enable internal PCI
      ARM: dts: iwg20d-q7: Enable USB PHY
      ARM: dts: r8a7743: Add IIC cores to dtsi

Fabrizio Castro (13):
      ARM: dts: r8a7745: Add I2C DT support
      ARM: dts: r8a7745: Add MMC interface support
      ARM: dts: iwg22m: Add eMMC support
      ARM: dts: iwg22m: Add RTC support
      ARM: dts: r8a7745: Add SDHI controllers
      ARM: dts: iwg22m: Enable SDHI1 controller
      ARM: dts: r8a7743: Add QSPI support
      ARM: dts: iwg20m: Add SPI NOR support
      ARM: dts: r8a7745: Add QSPI support
      ARM: dts: iwg22m: Add SPI NOR support
      ARM: dts: iwg22d: Enable SDHI0 controller
      ARM: dts: r8a7745: Add MSIOF[012] support
      ARM: dts: r8a7743: Add MSIOF[012] support

Geert Uytterhoeven (14):
      ARM: dts: r8a7790: Convert to new CPG/MSSR bindings
      ARM: dts: r8a7792: Convert to new CPG/MSSR bindings
      ARM: dts: r8a7793: Convert to new CPG/MSSR bindings
      ARM: dts: r8a7794: Convert to new CPG/MSSR bindings
      ARM: dts: r8a7790: Stop grouping clocks under a "clocks" subnode
      ARM: dts: r8a7793: Stop grouping clocks under a "clocks" subnode
      ARM: dts: r8a7794: Stop grouping clocks under a "clocks" subnode
      ARM: dts: r8a7791: Convert to new CPG/MSSR bindings
      ARM: dts: r8a7791: Stop grouping clocks under a "clocks" subnode
      ARM: dts: r8a7790: Add reset control properties
      ARM: dts: r8a7791: Add reset control properties
      ARM: dts: r8a7792: Add reset control properties
      ARM: dts: r8a7793: Add reset control properties
      ARM: dts: r8a7794: Add reset control properties

Jacopo Mondi (3):
      ARM: dts: gr-peach: Remove empty line
      ARM: dts: gr-peach: Add SCIF2 pin group
      ARM: dts: gr-peach: Add user led device nodes

Wolfram Sang (1):
      ARM: dts: alt: use correct logic for SD WP pins

 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/r7s72100-gr-peach.dts     |  22 +-
 arch/arm/boot/dts/r8a7743-iwg20d-q7.dts     |  97 ++++
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi       |  43 ++
 arch/arm/boot/dts/r8a7743.dtsi              | 257 ++++++++++
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts |  94 ++++
 arch/arm/boot/dts/r8a7745-iwg22m.dtsi       | 111 ++++
 arch/arm/boot/dts/r8a7745.dtsi              | 337 +++++++++++++
 arch/arm/boot/dts/r8a7790-lager.dts         |   7 +-
 arch/arm/boot/dts/r8a7790.dtsi              | 748 +++++++++------------------
 arch/arm/boot/dts/r8a7791-koelsch.dts       |   4 +-
 arch/arm/boot/dts/r8a7791-porter.dts        |   4 +-
 arch/arm/boot/dts/r8a7791.dtsi              | 754 +++++++++-------------------
 arch/arm/boot/dts/r8a7792-blanche.dts       |   3 +-
 arch/arm/boot/dts/r8a7792-wheat.dts         |   3 +-
 arch/arm/boot/dts/r8a7792.dtsi              | 378 ++++----------
 arch/arm/boot/dts/r8a7793-gose.dts          |   4 +-
 arch/arm/boot/dts/r8a7793.dtsi              | 626 +++++++----------------
 arch/arm/boot/dts/r8a7794-alt.dts           |   7 +-
 arch/arm/boot/dts/r8a7794-silk.dts          |   3 +-
 arch/arm/boot/dts/r8a7794.dtsi              | 696 +++++++------------------
 21 files changed, 1931 insertions(+), 2268 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
 create mode 100644 arch/arm/boot/dts/r8a7745-iwg22m.dtsi
