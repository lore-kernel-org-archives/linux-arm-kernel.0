From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 30 Mar 2012 16:59:53 -0600
Subject: [PATCH 00/11] ARM: tegra: GPIO and pinmux-related changes
Message-ID: <1333148404-17691-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This series:
* Updates the Tegra GPIO driver to interact with pinctrl per the recent
  gpio.txt documentation changes. Consequently, there's no need for
  tegra_gpio_enable() any more, and no need for board-pinmux.c to do
  anything GPIO-related.
* Switches to the new Tegra pinctrl driver, and deletes the old one.
* Moves pinctrl configuration to the device tree when booted using DT, so
  that board-dt-tegra*.c no longer depend on anything in board*.[ch].

Note to self: This series relies upon DT support in pinctrl, which
should be merged in 3.5.

Stephen Warren (11):
  usb: ehci-tegra: Add vbus_gpio to platform data
  ARM: tegra: Remove VBUS_GPIO handling from board files
  gpio: tegra: fix register address calculations for Tegra30
  gpio: tegra: Iterate over the correct number of banks
  gpio: tegra: configure pins during irq_set_type
  ARM: tegra: seaboard: Don't gpio_request() ISL29018_IRQ
  gpio: tegra: Hide tegra_gpio_enable/disable()
  ARM: tegra: Switch to new pinctrl driver
  ARM: tegra: Remove pre-pinctrl pinmux driver
  ARM: dt: tegra cardhu: add pinmux to device tree
  ARM: dt: tegra20: add pinmux to device tree

 arch/arm/boot/dts/tegra-cardhu.dts                |   44 +
 arch/arm/boot/dts/tegra-harmony.dts               |  224 +++++
 arch/arm/boot/dts/tegra-paz00.dts                 |  220 +++++
 arch/arm/boot/dts/tegra-seaboard.dts              |  243 +++++
 arch/arm/boot/dts/tegra-trimslice.dts             |  230 +++++
 arch/arm/boot/dts/tegra-ventana.dts               |  230 +++++
 arch/arm/mach-tegra/Makefile                      |    3 -
 arch/arm/mach-tegra/board-dt-tegra20.c            |   31 -
 arch/arm/mach-tegra/board-harmony-pinmux.c        |  266 +++---
 arch/arm/mach-tegra/board-paz00-pinmux.c          |  263 +++---
 arch/arm/mach-tegra/board-pinmux.c                |  105 +--
 arch/arm/mach-tegra/board-pinmux.h                |   38 +-
 arch/arm/mach-tegra/board-seaboard-pinmux.c       |  346 ++++----
 arch/arm/mach-tegra/board-seaboard.c              |   21 +-
 arch/arm/mach-tegra/board-trimslice-pinmux.c      |  264 +++---
 arch/arm/mach-tegra/board-trimslice.c             |   15 +-
 arch/arm/mach-tegra/devices.c                     |    3 +
 arch/arm/mach-tegra/include/mach/gpio-tegra.h     |    9 -
 arch/arm/mach-tegra/include/mach/pinmux-tegra20.h |  184 ----
 arch/arm/mach-tegra/include/mach/pinmux-tegra30.h |  320 -------
 arch/arm/mach-tegra/include/mach/pinmux.h         |  302 -------
 arch/arm/mach-tegra/pinmux-tegra20-tables.c       |  244 -----
 arch/arm/mach-tegra/pinmux-tegra30-tables.c       |  376 --------
 arch/arm/mach-tegra/pinmux.c                      |  987 ---------------------
 arch/arm/mach-tegra/usb_phy.c                     |    1 -
 drivers/gpio/gpio-tegra.c                         |   98 ++-
 drivers/mmc/host/sdhci-tegra.c                    |   24 +-
 drivers/pinctrl/pinctrl-tegra.c                   |    6 +-
 drivers/usb/host/ehci-tegra.c                     |   13 +-
 include/linux/platform_data/tegra_usb.h           |    1 +
 30 files changed, 1887 insertions(+), 3224 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/include/mach/pinmux-tegra20.h
 delete mode 100644 arch/arm/mach-tegra/include/mach/pinmux-tegra30.h
 delete mode 100644 arch/arm/mach-tegra/include/mach/pinmux.h
 delete mode 100644 arch/arm/mach-tegra/pinmux-tegra20-tables.c
 delete mode 100644 arch/arm/mach-tegra/pinmux-tegra30-tables.c
 delete mode 100644 arch/arm/mach-tegra/pinmux.c
