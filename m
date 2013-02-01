From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 1 Feb 2013 15:51:59 +0000
Subject: [GIT PULL  3/4] ARM: mvebu: boards for v3.9
In-Reply-To: <1359733918.Bf7ecc0.22262@triton>
Message-ID: <1359733919.c3D01c3.22262@triton>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 949db153b6466c6f7cad5a427ecea94985927311:

  Linux 3.8-rc5

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/boards_for_v3.9

for you to fetch changes up to c7064904895f69b2e33117b450a05746f75abf3a:

  ARM: kirkwood: convert Guruplug Server Plus to use the device tree

----------------------------------------------------------------
mvebu boards for v3.9
     - Guruplug Server Plus DT board
     - RD-A370-A1 board
     - mvebu improved SMP support in interrupt controller
     - update defconfigs
     - split legacy and DT setup for dove
     - remove some redundant clock aliases
    
    depends on:
     - tags/mvebu_fixes_for_v3.8-rc6
     - tags/cleanup_for_v3.9_round2
     - tags/drivers_for_v3.9
     - mmc/mmc-next up to:
        d293875 mmc: mvsdio: add pinctrl integration
    
    conflicts:
     - arm-soc/for-next
        - arch/arm/mach-dove/common.c
           * remove all DT code (it's now in .../board-dt.c)
    
    build fixes (not merge conflict)
     - arm-soc/for-next
        - arch/arm/mach-dove/board-dt.c
           - .timer no longer used
           * s/.timer = &dove_timer/.init_time = dove_timer_init/ (not valid sed)
----------------------------------------------------------------
Andrew Lunn (2):
      ARM: Kirkwood: Remove redundent USB clock alias
      ARM: Kirkwood: Remove redundent SDIO clock alias

Florian Fainelli (1):
      arm: mvebu: add DTS file for Marvell RD-A370-A1 board

Gregory CLEMENT (2):
      arm: mvebu: Update defconfig with Marvell RTC support
      arm: mvebu: Improve the SMP support of the interrupt controller

Jason Cooper (4):
      Merge tag 'tags/mvebu_fixes_for_v3.8-rc6' into mvebu/boards
      Merge tag 'tags/cleanup_for_v3.9_round2' into mvebu/boards
      Merge tag 'tags/drivers_for_v3.9' into mvebu/boards
      Merge commit 'd293875' into mvebu/boards

Olof Johansson (1):
      ARM: dove: update dove_defconfig with a few useful options

Sebastian Hesselbarth (1):
      ARM: Dove: split legacy and DT setup

Thomas Petazzoni (4):
      arm: mvebu: enable SDIO support in mvebu_defconfig
      arm: mvebu: enable mwifiex driver in mvebu_defconfig
      arm: mvebu: enable btmrvl driver in mvebu_defconfig
      arm: mvebu: add LEDs support to defconfig file

Willy Tarreau (1):
      ARM: kirkwood: convert Guruplug Server Plus to use the device tree

 .../bindings/mmc/brcm,bcm2835-sdhci.txt         |  18 ++
 .../devicetree/bindings/mmc/orion-sdio.txt      |  17 ++
 arch/arm/boot/dts/Makefile                      |   2 +
 arch/arm/boot/dts/armada-370-rd.dts             |  61 ++++
 arch/arm/boot/dts/armada-xp.dtsi                |   2 +-
 arch/arm/boot/dts/dove.dtsi                     |   2 +
 .../boot/dts/kirkwood-guruplug-server-plus.dts  |  94 +++++++
 arch/arm/configs/dove_defconfig                 |  28 +-
 arch/arm/configs/kirkwood_defconfig             |   1 +
 arch/arm/configs/mvebu_defconfig                |  16 ++
 arch/arm/mach-dove/Kconfig                      |   5 +
 arch/arm/mach-dove/Makefile                     |   4 +-
 arch/arm/mach-dove/board-dt.c                   | 102 +++++++
 arch/arm/mach-dove/common.c                     | 114 +-------
 arch/arm/mach-kirkwood/Kconfig                  |   7 +
 arch/arm/mach-kirkwood/Makefile                 |   2 +-
 arch/arm/mach-kirkwood/board-dt.c               |  15 +-
 arch/arm/mach-kirkwood/board-guruplug.c         |  39 +++
 arch/arm/mach-kirkwood/board-ib62x0.c           |   1 -
 arch/arm/mach-kirkwood/board-mplcec4.c          |   1 -
 arch/arm/mach-kirkwood/board-nsa310.c           |   8 +-
 arch/arm/mach-kirkwood/common.c                 |  23 ++
 arch/arm/mach-kirkwood/common.h                 |   6 +
 arch/arm/mach-kirkwood/dockstar-setup.c         |   1 -
 arch/arm/mach-kirkwood/include/mach/kirkwood.h  |   3 +-
 arch/arm/mach-kirkwood/pcie.c                   |  10 +-
 arch/arm/mach-mvebu/irq-armada-370-xp.c         |  72 +++++
 arch/arm/plat-orion/mpp.c                       |   2 +-
 drivers/cpuidle/Kconfig                         |   6 +
 drivers/cpuidle/Makefile                        |   1 +
 .../cpuidle/cpuidle-kirkwood.c                  |  45 ++-
 drivers/mmc/card/block.c                        |  30 +-
 drivers/mmc/card/queue.c                        |  32 ++-
 drivers/mmc/card/queue.h                        |   3 +
 drivers/mmc/core/bus.c                          |   1 +
 drivers/mmc/core/core.c                         | 121 +++++++-
 drivers/mmc/core/core.h                         |   1 +
 drivers/mmc/core/sdio.c                         |  33 ++-
 drivers/mmc/core/slot-gpio.c                    |  57 +++-
 drivers/mmc/host/Kconfig                        |  11 +
 drivers/mmc/host/Makefile                       |   1 +
 drivers/mmc/host/mvsdio.c                       | 131 +++++----
 drivers/mmc/host/sdhci-bcm2835.c                | 227 +++++++++++++++
 drivers/mmc/host/sdhci-esdhc-imx.c              |  59 +---
 drivers/mmc/host/sdhci-pxav3.c                  |  12 +-
 drivers/mmc/host/sdhci.c                        | 117 +++++---
 drivers/mmc/host/sh_mmcif.c                     | 280 +++++++++++--------
 drivers/mmc/host/tmio_mmc_pio.c                 |   8 -
 drivers/rtc/Kconfig                             |   2 +-
 include/linux/mmc/card.h                        |  12 +
 include/linux/mmc/core.h                        |   3 +-
 include/linux/mmc/host.h                        |  25 ++
 52 files changed, 1381 insertions(+), 493 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhci.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/orion-sdio.txt
 create mode 100644 arch/arm/boot/dts/armada-370-rd.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
 create mode 100644 arch/arm/mach-dove/board-dt.c
 create mode 100644 arch/arm/mach-kirkwood/board-guruplug.c
 rename arch/arm/mach-kirkwood/cpuidle.c => drivers/cpuidle/cpuidle-kirkwood.c (61%)
 create mode 100644 drivers/mmc/host/sdhci-bcm2835.c
