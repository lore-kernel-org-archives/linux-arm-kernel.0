From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Dec 2013 15:10:07 -0700
Subject: [GIT PULL 05/10] ARM: tegra: common DMA/reset DT binding conversion
In-Reply-To: <1387231812-5701-1-git-send-email-swarren@wwwdotorg.org>
References: <1387231812-5701-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1387231812-5701-5-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series converts the Tegra DTs and drivers to use the common/
standard DMA and reset bindings, rather than custom bindings. It also
adds complete documentation for the Tegra clock bindings without
actually changing any binding definitions.

This conversion relies on a few sets of patches in branches from outside
the Tegra tree:

1) A patch to add an DMA channel request API which allows deferred probe
   to be implemented.

2) A patch to implement a common part of the of_xlate function for DMA
   controllers.

3) Some ASoC patches (which in turn rely on (1) above), which support
   deferred probe during DMA channel allocation.

4) The Tegra clock driver changes for 3.14.

Consequently, this branch is based on a merge of all of those external
branches.

In turn, this branch is or will be pulled into a few places that either
rely on features introduced here, or would otherwise conflict with the
patches:

a) Tegra's own for-3.14/powergate and for-4.14/dt branches, to avoid
   conflicts.

b) The DRM tree, which introduces new code that relies on the reset
   controller framework introduced in this branch, and to avoid
   conflicts.

----------------------------------------------------------------

The following changes since commit e9827d9be9777cf287dd1340e6e7a8526f9e0b70:

  Merge tag 'clk-tegra-for-3.14' into for-3.14/dmas-resets-rework

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tegra-for-3.14-dmas-resets-rework

for you to fetch changes up to 8a0a1af30cbf56b41220a02e34835022c4d72f41:

  spi: tegra: checking for ERR_PTR instead of NULL

----------------------------------------------------------------

Dan Carpenter (1):
      spi: tegra: checking for ERR_PTR instead of NULL

Stephen Warren (29):
      ARM: tegra: add missing clock documentation to DT bindings
      ARM: tegra: document reset properties in DT bindings
      ARM: tegra: document use of standard DMA DT bindings
      ARM: tegra: update DT files to add reset properties
      ARM: tegra: update DT files to add DMA properties
      ARM: tegra: select the reset framework
      clk: tegra: implement a reset driver
      pci: tegra: use reset framework
      drm/tegra: use reset framework
      ARM: tegra: pass reset to tegra_powergate_sequence_power_up()
      dma: tegra: use reset framework
      dma: tegra: register as an OF DMA controller
      ASoC: tegra: use reset framework
      ASoC: tegra: call pm_runtime APIs around register accesses
      ASoC: tegra: allocate AHUB FIFO during probe() not startup()
      ASoC: tegra: convert to standard DMA DT bindings
      i2c: tegra: use reset framework
      staging: nvec: use reset framework
      spi: tegra: use reset framework
      spi: tegra: convert to standard DMA DT bindings
      serial: tegra: use reset framework
      serial: tegra: convert to standard DMA DT bindings
      Input: tegra-kbc - use reset framework
      USB: EHCI: tegra: use reset framework
      ARM: tegra: remove legacy clock entries from DT
      ARM: tegra: remove legacy DMA entries from DT
      clk: tegra: remove legacy reset APIs
      clk: tegra: remove bogus PCIE_XCLK
      ASoC: tegra: update module reset list for Tegra124

 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt   |   1 +
 .../bindings/clock/nvidia,tegra114-car.txt      |   4 +
 .../bindings/clock/nvidia,tegra124-car.txt      |   4 +
 .../bindings/clock/nvidia,tegra20-car.txt       |   4 +
 .../bindings/clock/nvidia,tegra30-car.txt       |   4 +
 .../devicetree/bindings/dma/tegra20-apbdma.txt  |  14 ++
 .../bindings/gpu/nvidia,tegra20-host1x.txt      | 122 +++++++++++++
 .../bindings/i2c/nvidia,tegra20-i2c.txt         |  27 ++-
 .../bindings/input/nvidia,tegra20-kbc.txt       |   9 +
 .../bindings/mmc/nvidia,tegra20-sdhci.txt       |   9 +
 .../devicetree/bindings/nvec/nvidia,nvec.txt    |  12 ++
 .../bindings/pci/nvidia,tegra20-pcie.txt        |  26 +--
 .../bindings/pwm/nvidia,tegra20-pwm.txt         |   9 +
 .../bindings/rtc/nvidia,tegra20-rtc.txt         |   3 +
 .../bindings/serial/nvidia,tegra20-hsuart.txt   |  19 +-
 .../sound/nvidia,tegra-audio-alc5632.txt        |   7 +-
 .../sound/nvidia,tegra-audio-rt5640.txt         |   7 +-
 .../sound/nvidia,tegra-audio-wm8753.txt         |   7 +-
 .../sound/nvidia,tegra-audio-wm8903.txt         |   7 +-
 .../sound/nvidia,tegra-audio-wm9712.txt         |   7 +-
 .../bindings/sound/nvidia,tegra20-ac97.txt      |  20 ++-
 .../bindings/sound/nvidia,tegra20-i2s.txt       |  19 +-
 .../bindings/sound/nvidia,tegra30-ahub.txt      |  63 +++++--
 .../bindings/sound/nvidia,tegra30-i2s.txt       |  11 +-
 .../bindings/spi/nvidia,tegra114-spi.txt        |  24 ++-
 .../bindings/spi/nvidia,tegra20-sflash.txt      |  20 ++-
 .../bindings/spi/nvidia,tegra20-slink.txt       |  20 ++-
 .../bindings/timer/nvidia,tegra20-timer.txt     |   3 +
 .../bindings/timer/nvidia,tegra30-timer.txt     |   3 +
 .../bindings/usb/nvidia,tegra20-ehci.txt        |   7 +-
 arch/arm/boot/dts/tegra114.dtsi                 | 157 +++++++++++++----
 arch/arm/boot/dts/tegra20-paz00.dts             |   2 +
 arch/arm/boot/dts/tegra20.dtsi                  | 136 ++++++++++++--
 arch/arm/boot/dts/tegra30.dtsi                  | 175 ++++++++++++++++---
 arch/arm/mach-tegra/Kconfig                     |   2 +
 arch/arm/mach-tegra/powergate.c                 |   8 +-
 drivers/clk/tegra/clk-periph-gate.c             |  22 ---
 drivers/clk/tegra/clk-periph.c                  |  40 -----
 drivers/clk/tegra/clk-tegra114.c                |   3 +-
 drivers/clk/tegra/clk-tegra124.c                |   2 +-
 drivers/clk/tegra/clk-tegra20.c                 |   9 +-
 drivers/clk/tegra/clk-tegra30.c                 |  10 +-
 drivers/clk/tegra/clk.c                         |  50 +++++-
 drivers/clk/tegra/clk.h                         |   3 +-
 drivers/dma/tegra20-apb-dma.c                   |  52 +++++-
 drivers/gpu/drm/tegra/Kconfig                   |   1 +
 drivers/gpu/drm/tegra/dc.c                      |  10 +-
 drivers/gpu/drm/tegra/drm.h                     |   3 +
 drivers/gpu/drm/tegra/gr3d.c                    |  22 ++-
 drivers/gpu/drm/tegra/hdmi.c                    |  15 +-
 drivers/i2c/busses/i2c-tegra.c                  |  13 +-
 drivers/input/keyboard/tegra-kbc.c              |  13 +-
 drivers/pci/host/pci-tegra.c                    |  53 ++++--
 drivers/spi/Kconfig                             |   3 +
 drivers/spi/spi-tegra114.c                      |  66 ++++---
 drivers/spi/spi-tegra20-sflash.c                |  18 +-
 drivers/spi/spi-tegra20-slink.c                 |  66 ++++---
 drivers/staging/nvec/nvec.c                     |  11 +-
 drivers/staging/nvec/nvec.h                     |   5 +-
 drivers/tty/serial/serial-tegra.c               |  38 ++--
 drivers/usb/host/ehci-tegra.c                   |  14 +-
 include/dt-bindings/clock/tegra20-car.h         |   2 +-
 include/dt-bindings/clock/tegra30-car.h         |   2 +-
 include/linux/clk/tegra.h                       |   7 -
 include/linux/tegra-powergate.h                 |   7 +-
 sound/soc/tegra/Kconfig                         |   2 +
 sound/soc/tegra/tegra20_ac97.c                  |  11 --
 sound/soc/tegra/tegra20_i2s.c                   |  20 +--
 sound/soc/tegra/tegra30_ahub.c                  | 138 +++++++++------
 sound/soc/tegra/tegra30_ahub.h                  |  11 +-
 sound/soc/tegra/tegra30_i2s.c                   |  97 +++++-----
 sound/soc/tegra/tegra30_i2s.h                   |   3 +
 sound/soc/tegra/tegra_pcm.c                     |  17 +-
 sound/soc/tegra/tegra_pcm.h                     |   5 +
 74 files changed, 1320 insertions(+), 516 deletions(-)
