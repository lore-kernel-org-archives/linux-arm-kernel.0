From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 14 Dec 2011 17:03:12 +0200
Subject: [PATCH v7 00/14] Add support for tegra30 and cardhu
Message-ID: <1323875032-18221-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the tegra30 SoC and the cardhu development
board.

Patchset is on top of linux-next and
http://www.spinics.net/lists/linux-tegra/msg03016.html.

Most important changes in v7:

* split board-dt.c in board-dt-tegra20.c and board-dt-tegra30.c
* split early init preparation into several patches
* remove tegra_sdmmc_tap_delay. Drivers should use tegra2_sdmmc_tap_delay as
  from tegra30 onwards this feature will no longer handled by the clock code
  as it's implemented in the SDMMC block now.
* remove CONFIG_CARDHU and the corresponding Kconfig entry

Most important changes in v6:

* Align with latest version of the ARM restart implementation
* Address comments on tegra_sdmmc_tap_delay()

Most important changes in v5:

* use devicetree binding for GIC
* define a seperate machine for tegra30
* add documentation for tegra devicetree compatible definitions

Most important changes in v4:

* cleanup clock code to work on multiple tegra variants
* added dependencies to avoid building tegra20 only code for tegra30

Most important changes in v3:

* align with ARM restart rework. might need a bit of rework to merge with the
  latest version of this.
* minor cleanups and reformats

Most important changes in v2:

* account for arch_reset cleanup
* seperate patch for renaming pinmux-t2.h and pinmux-t2-tables.c
* fixed bug in common cache initialization
* fixed compatibility with non DT boards (boottested on harmony)
* improved commit messages

Peter De Schrijver (14):
  arm/tegra: initial device tree for tegra30
  arm/tegra: cleanup tegra20 support
  arm/tegra: prepare clock code for multiple tegra variants
  arm/tegra: don't export clk_measure_input_freq
  arm/tegra: prepare early init for multiple tegra variants
  arm/tegra: rename board-dt.c to board-dt-tegra20.c
  arm/tegra: use PMC reset
  arm/tegra: generalize L2 cache initialization
  arm/tegra: rename tegra20 pinmux files
  arm/tegra: prepare pinmux code for multiple tegra variants
  arm/tegra: add new fields to struct tegra_pingroup_desc
  arm/tegra: pinmux tables and definitions for tegra30
  arm/tegra: implement support for tegra30
  arm/tegra: add support for tegra30 based board cardhu

 Documentation/devicetree/bindings/arm/tegra.txt   |   14 +
 arch/arm/boot/dts/tegra-cardhu.dts                |   36 ++
 arch/arm/boot/dts/tegra30.dtsi                    |  127 +++++++
 arch/arm/mach-tegra/Kconfig                       |   30 ++-
 arch/arm/mach-tegra/Makefile                      |    9 +-
 arch/arm/mach-tegra/Makefile.boot                 |    1 +
 arch/arm/mach-tegra/board-dt-tegra20.c            |  143 ++++++++
 arch/arm/mach-tegra/board-dt-tegra30.c            |   63 ++++
 arch/arm/mach-tegra/board-dt.c                    |  154 ---------
 arch/arm/mach-tegra/board-harmony-pcie.c          |    1 +
 arch/arm/mach-tegra/board-harmony-pinmux.c        |    1 +
 arch/arm/mach-tegra/board-harmony.c               |    2 +-
 arch/arm/mach-tegra/board-paz00-pinmux.c          |    1 +
 arch/arm/mach-tegra/board-paz00.c                 |    2 +-
 arch/arm/mach-tegra/board-seaboard-pinmux.c       |    2 +-
 arch/arm/mach-tegra/board-seaboard.c              |    6 +-
 arch/arm/mach-tegra/board-trimslice-pinmux.c      |    1 +
 arch/arm/mach-tegra/board-trimslice.c             |    2 +-
 arch/arm/mach-tegra/board.h                       |    4 +-
 arch/arm/mach-tegra/clock.c                       |   20 +-
 arch/arm/mach-tegra/clock.h                       |    4 -
 arch/arm/mach-tegra/common.c                      |   53 +++-
 arch/arm/mach-tegra/include/mach/clk.h            |    2 +-
 arch/arm/mach-tegra/include/mach/irqs.h           |    2 -
 arch/arm/mach-tegra/include/mach/pinmux-t2.h      |  184 ----------
 arch/arm/mach-tegra/include/mach/pinmux-tegra20.h |  184 ++++++++++
 arch/arm/mach-tegra/include/mach/pinmux-tegra30.h |  320 ++++++++++++++++++
 arch/arm/mach-tegra/include/mach/pinmux.h         |   88 ++++-
 arch/arm/mach-tegra/pinmux-t2-tables.c            |  228 -------------
 arch/arm/mach-tegra/pinmux-tegra20-tables.c       |  244 +++++++++++++
 arch/arm/mach-tegra/pinmux-tegra30-tables.c       |  376 +++++++++++++++++++++
 arch/arm/mach-tegra/pinmux.c                      |  153 ++++++---
 arch/arm/mach-tegra/tegra2_clocks.c               |   19 +-
 arch/arm/mach-tegra/timer.c                       |   12 +-
 34 files changed, 1789 insertions(+), 699 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra.txt
 create mode 100644 arch/arm/boot/dts/tegra-cardhu.dts
 create mode 100644 arch/arm/boot/dts/tegra30.dtsi
 create mode 100644 arch/arm/mach-tegra/board-dt-tegra20.c
 create mode 100644 arch/arm/mach-tegra/board-dt-tegra30.c
 delete mode 100644 arch/arm/mach-tegra/board-dt.c
 delete mode 100644 arch/arm/mach-tegra/include/mach/pinmux-t2.h
 create mode 100644 arch/arm/mach-tegra/include/mach/pinmux-tegra20.h
 create mode 100644 arch/arm/mach-tegra/include/mach/pinmux-tegra30.h
 delete mode 100644 arch/arm/mach-tegra/pinmux-t2-tables.c
 create mode 100644 arch/arm/mach-tegra/pinmux-tegra20-tables.c
 create mode 100644 arch/arm/mach-tegra/pinmux-tegra30-tables.c

-- 
1.7.7.rc0.72.g4b5ea.dirty
