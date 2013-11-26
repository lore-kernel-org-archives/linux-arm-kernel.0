From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 26 Nov 2013 21:32:43 +0100
Subject: [GIT PULL] ux500 devicetree changes for v3.14, take one
Message-ID: <CACRpkdZKZdQ08MnDL94f3DwdE1CYbdcHSYwNKwgqr3AhYqE_mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

as you know we discontinued ATAG booting for the ux500 platforms
in the v3.13 merge window.

Now we can start to move things over to device tree exclusively and
get rid of board files, especially AUXDATA.

In some ACKed cases we even get rid of the non-DT boot path in
individual drivers.

Please have a look at this nice diffstat and pull in for v3.14 if you are
satisfied with the end result.

Yours,
Linus Walleij


The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-devicetree-v3.14-1

for you to fetch changes up to 089b5c9595eb3c516ab6af12802f16505cde271b:

  ARM: ux500: decomission custom SMP TWD timer init (2013-11-26 21:01:59 +0100)

----------------------------------------------------------------
Ux500 device tree patches for v3.14, take one:

- Fix up tc3589x bindings so this chip works again.

- Remove SSP platform devices, as we now boot from device tree
  exclusively.

- Delete surplus AB8500/DB8500 platform data, not obtained from
  the device tree.

- Add DMA config for the MSP devices.

- A series of 21 patches moving pin control config for the
  on-chip Nomadik pin controller from the board file
  to the device tree, step by step.

- Two patches to the STE DMA40 driver regarding the high-prio
  DMA channel so this can be moved to the device tree. Both have
  Vinod's ACK.

- Decommission of the non-device tree boot path for the timer
  initialization code.

- Deletion of the non-devicetree probe path from the MTU timer
  driver, as all platforms using it are now using device tree.
  This has Daniel Lezcano's ACK.

----------------------------------------------------------------
Lee Jones (9):
      ARM: ux500: Remove legacy ATAG SSP support
      ARM: ux500: Consolidate [A|D]B8500 platform data
      ARM: ux500: Add DMA config bindings for MSP devices
      ARM: ux500: Clean-up non-DT IRQ initialisation
      ARM: ux500: Remove unused call to register AMBA devices
      ARM: ux500: Clean-up legacy extern prototype
      ARM: ux500: Remove checking for DT during timer init
      dma: ste_dma40: Expand DT binding to accept 'high-priority channel' flag
      dma: ste_dma40: Parse flags property for new 'high priority
channel' request

Linus Walleij (30):
      ARM: ux500: adjust the TC3589x devices to the binding
      ARM: ux500: move UART pin control to the device tree
      ARM: ux500: move I2C pin control to the device tree
      ARM: ux500: move MMC/SD/SDIO pin control to the device tree
      ARM: ux500: move MSP pin control to the device tree
      ARM: ux500: move GPIO217/218 config to device tree
      ARM: ux500: move MUSB pin config to device tree
      ARM: ux500: move SPI pin config to device tree
      ARM: ux500: create MCDE node to collect resources
      ARM: ux500: move MCDE pin config to device tree
      ARM: ux500: move SKE pin config to device tree
      ARM: ux500: drop STM pinmap settings
      ARM: ux500: move old HREF ipgpio to the device tree
      ARM: ux500: move GPIO key configuration to device tree
      ARM: ux500: move the WLAN GPIO pin setup to the device tree
      ARM: ux500: move the HREFv60plus IPGPIO pins to device tree
      ARM: ux500: move final HREFv60 LCD pins to device tree
      ARM: ux500: move HREFv60plus pin configs to device tree
      ARM: ux500: move snowball ethernet config to device tree
      ARM: ux500: convert Snowball SPI pin reference
      ARM: ux500: move snowball LED pin control to device tree
      ARM: ux500: move snowball pin configs to device tree
      ARM: ux500: delete remnant pin config macros
      ARM: ux500: delete Nomadik pinctrl AUXDATA
      ARM: ux500: get rid of unused header
      pinctrl: nomadik: move platform data handling into driver
      pinctrl: nomadik: decomission non-DT boot path
      ARM: ux500: decomission the non-DT MTU init sequence
      clksrc: delete nomadik MTU non-DT boot path
      ARM: ux500: decomission custom SMP TWD timer init

 .../devicetree/bindings/dma/ste-dma40.txt          |   3 +
 arch/arm/boot/dts/ste-dbx5x0.dtsi                  |  32 +
 arch/arm/boot/dts/ste-href-family-pinctrl.dtsi     | 745 +++++++++++++++++++
 arch/arm/boot/dts/ste-href-stuib.dtsi              |  41 ++
 arch/arm/boot/dts/ste-href-tvk1281618.dtsi         |  90 ++-
 arch/arm/boot/dts/ste-href.dtsi                    |  78 +-
 arch/arm/boot/dts/ste-hrefprev60.dtsi              |  73 +-
 arch/arm/boot/dts/ste-hrefv60plus.dtsi             | 217 +++++-
 arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi         |  80 ++
 arch/arm/boot/dts/ste-snowball.dts                 | 225 ++++++
 arch/arm/mach-ux500/Makefile                       |   6 +-
 arch/arm/mach-ux500/board-mop500-audio.c           |   3 -
 arch/arm/mach-ux500/board-mop500-pins.c            | 804 ---------------------
 arch/arm/mach-ux500/board-mop500-sdi.c             |   2 -
 arch/arm/mach-ux500/board-mop500.c                 |  78 --
 arch/arm/mach-ux500/board-mop500.h                 |   1 -
 arch/arm/mach-ux500/cpu-db8500.c                   |  22 +-
 arch/arm/mach-ux500/cpu.c                          |  23 +-
 arch/arm/mach-ux500/devices-db8500.c               |  28 -
 arch/arm/mach-ux500/devices-db8500.h               |  19 -
 arch/arm/mach-ux500/devices.c                      |  26 -
 arch/arm/mach-ux500/devices.h                      |  15 -
 arch/arm/mach-ux500/setup.h                        |   6 -
 arch/arm/mach-ux500/timer.c                        |  76 +-
 drivers/clocksource/nomadik-mtu.c                  |  23 +-
 drivers/dma/ste_dma40.c                            |   4 +
 drivers/pinctrl/pinctrl-nomadik.c                  | 296 ++++++--
 drivers/pinctrl/pinctrl-nomadik.h                  |  14 +-
 .../linux/platform_data/clocksource-nomadik-mtu.h  |   9 -
 include/linux/platform_data/pinctrl-nomadik.h      | 242 -------
 30 files changed, 1850 insertions(+), 1431 deletions(-)
 create mode 100644 arch/arm/boot/dts/ste-href-family-pinctrl.dtsi
 delete mode 100644 arch/arm/mach-ux500/board-mop500.c
 delete mode 100644 arch/arm/mach-ux500/devices-db8500.c
 delete mode 100644 arch/arm/mach-ux500/devices-db8500.h
 delete mode 100644 arch/arm/mach-ux500/devices.c
 delete mode 100644 arch/arm/mach-ux500/devices.h
 delete mode 100644 include/linux/platform_data/clocksource-nomadik-mtu.h
 delete mode 100644 include/linux/platform_data/pinctrl-nomadik.h
