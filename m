From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 15 Nov 2013 13:53:55 -0700
Subject: [PATCH 00/31] ARM: tegra: use common reset and DMA bindings
Message-ID: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This series implements a common reset framework driver for Tegra, and
updates all relevant Tegra drivers to use it. It also removes the custom
DMA bindings and replaced them with the standard DMA DT bindings.

Historically, the Tegra clock driver has exported a custom API for module
reset. This series removes that API, and transitions DT and drivers to
the new reset framework.

The custom API used a "struct clk" to identify which module to reset, and
consequently some DT bindings and drivers required clocks to be provided
where they really needed just a reset identifier instead. Due to this
known deficiency, I have always considered most Tegra bindings to be
unstable. This series removes this excuse for instability, although I
still consider some Tegra bindings unstable due to the need to convert to
the common DMA bindings.

Historically, Tegra DMA channels have been represented in DT using a
custom nvidia,dma-request-selector property. Now that standard DMA DT
bindings exist, convert all Tegra bindings, DTs, and drivers to use the
standard instead.

This series makes a DT-ABI-incompatible change to:
- Require reset specifiers in DT where relevant.
- Require standard DMA specifiers.
- Remove clock specifiers from DT where they were only needed for reset.
- Remove legacy DMA specifier properties.

I anticipate merging this whole series into the Tegra and arm-soc trees
as its own branch, due to internal dependencies. This branch will be
stable and can then be merged into any other subsystem trees should any
conflicts arise.

This series depends on Peter's Tegra clock driver rework, available at
git://nv-tegra.nvidia.com/user/pdeschrijver/linux tegra-clk-tegra124-0
(or whatever version of that gets included in 3.14)

Cc: ac100 at lists.launchpad.net
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: alsa-devel at alsa-project.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Airlie <airlied@linux.ie>
Cc: devel at driverdev.osuosl.org
Cc: devicetree at vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dmitry Torokhov <dtor@mail.ru>
Cc: dri-devel at lists.freedesktop.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Julian Andres Klode <jak@jak-linux.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-i2c at vger.kernel.org
Cc: linux-input at vger.kernel.org
Cc: linux-pci at vger.kernel.org
Cc: linux-serial at vger.kernel.org
Cc: linux-spi at vger.kernel.org
Cc: linux-tegra at vger.kernel.org
Cc: linux-usb at vger.kernel.org
Cc: Marc Dietrich <marvin24@gmx.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: pdeschrijver at nvidia.com
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Terje Bergstr?m <tbergstrom@nvidia.com>
Cc: treding at nvidia.com
Cc: Wolfram Sang <wsa@the-dreams.de>

Stephen Warren (31):
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
  dma: add channel request API that supports deferred probe
  dma: tegra: use reset framework
  dma: tegra: register as an OF DMA controller
  ASoC: dmaengine: support deferred probe for DMA channels
  ASoC: dmaengine: add custom DMA config to snd_dmaengine_pcm_config
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

 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      |   1 +
 .../bindings/clock/nvidia,tegra114-car.txt         |   4 +
 .../bindings/clock/nvidia,tegra124-car.txt         |   4 +
 .../bindings/clock/nvidia,tegra20-car.txt          |   4 +
 .../bindings/clock/nvidia,tegra30-car.txt          |   4 +
 .../devicetree/bindings/dma/tegra20-apbdma.txt     |   9 ++
 .../bindings/gpu/nvidia,tegra20-host1x.txt         | 124 +++++++++++++++
 .../devicetree/bindings/i2c/nvidia,tegra20-i2c.txt |  27 +++-
 .../bindings/input/nvidia,tegra20-kbc.txt          |   9 ++
 .../bindings/mmc/nvidia,tegra20-sdhci.txt          |   9 ++
 .../devicetree/bindings/nvec/nvidia,nvec.txt       |  12 ++
 .../bindings/pci/nvidia,tegra20-pcie.txt           |  28 ++--
 .../devicetree/bindings/pwm/nvidia,tegra20-pwm.txt |   9 ++
 .../devicetree/bindings/rtc/nvidia,tegra20-rtc.txt |   3 +
 .../bindings/serial/nvidia,tegra20-hsuart.txt      |  19 ++-
 .../bindings/sound/nvidia,tegra-audio-alc5632.txt  |   7 +-
 .../bindings/sound/nvidia,tegra-audio-rt5640.txt   |   7 +-
 .../bindings/sound/nvidia,tegra-audio-wm8753.txt   |   7 +-
 .../bindings/sound/nvidia,tegra-audio-wm8903.txt   |   7 +-
 .../bindings/sound/nvidia,tegra-audio-wm9712.txt   |   7 +-
 .../bindings/sound/nvidia,tegra20-ac97.txt         |  20 ++-
 .../bindings/sound/nvidia,tegra20-i2s.txt          |  19 ++-
 .../bindings/sound/nvidia,tegra30-ahub.txt         |  54 +++++--
 .../bindings/sound/nvidia,tegra30-i2s.txt          |  11 +-
 .../bindings/spi/nvidia,tegra114-spi.txt           |  24 ++-
 .../bindings/spi/nvidia,tegra20-sflash.txt         |  20 ++-
 .../bindings/spi/nvidia,tegra20-slink.txt          |  20 ++-
 .../bindings/timer/nvidia,tegra20-timer.txt        |   3 +
 .../bindings/timer/nvidia,tegra30-timer.txt        |   3 +
 .../bindings/usb/nvidia,tegra20-ehci.txt           |   7 +-
 arch/arm/boot/dts/tegra114.dtsi                    | 142 ++++++++++++++---
 arch/arm/boot/dts/tegra20-paz00.dts                |   2 +
 arch/arm/boot/dts/tegra20.dtsi                     | 132 ++++++++++++++--
 arch/arm/boot/dts/tegra30.dtsi                     | 171 +++++++++++++++++----
 arch/arm/mach-tegra/Kconfig                        |   2 +
 arch/arm/mach-tegra/powergate.c                    |   8 +-
 drivers/clk/tegra/clk-periph-gate.c                |  22 ---
 drivers/clk/tegra/clk-periph.c                     |  40 -----
 drivers/clk/tegra/clk-tegra114.c                   |   3 +-
 drivers/clk/tegra/clk-tegra124.c                   |   2 +-
 drivers/clk/tegra/clk-tegra20.c                    |   9 +-
 drivers/clk/tegra/clk-tegra30.c                    |  10 +-
 drivers/clk/tegra/clk.c                            |  55 ++++++-
 drivers/clk/tegra/clk.h                            |   3 +-
 drivers/dma/acpi-dma.c                             |  12 +-
 drivers/dma/dmaengine.c                            |  44 +++++-
 drivers/dma/of-dma.c                               |  12 +-
 drivers/dma/tegra20-apb-dma.c                      |  49 +++++-
 drivers/gpu/drm/tegra/Kconfig                      |   1 +
 drivers/gpu/drm/tegra/dc.c                         |   9 +-
 drivers/gpu/drm/tegra/drm.h                        |   3 +
 drivers/gpu/drm/tegra/gr3d.c                       |  22 ++-
 drivers/gpu/drm/tegra/hdmi.c                       |  14 +-
 drivers/i2c/busses/i2c-tegra.c                     |  13 +-
 drivers/input/keyboard/tegra-kbc.c                 |  13 +-
 drivers/pci/host/pci-tegra.c                       |  52 +++++--
 drivers/spi/Kconfig                                |   3 +
 drivers/spi/spi-tegra114.c                         |  66 ++++----
 drivers/spi/spi-tegra20-sflash.c                   |  18 ++-
 drivers/spi/spi-tegra20-slink.c                    |  66 ++++----
 drivers/staging/nvec/nvec.c                        |  11 +-
 drivers/staging/nvec/nvec.h                        |   5 +-
 drivers/tty/serial/serial-tegra.c                  |  86 +++++------
 drivers/usb/host/ehci-tegra.c                      |  14 +-
 include/dt-bindings/clock/tegra20-car.h            |   2 +-
 include/dt-bindings/clock/tegra30-car.h            |   2 +-
 include/linux/clk/tegra.h                          |   7 -
 include/linux/dmaengine.h                          |   7 +
 include/linux/of_dma.h                             |   9 +-
 include/linux/tegra-powergate.h                    |   4 +-
 include/sound/dmaengine_pcm.h                      |   6 +
 sound/soc/soc-generic-dmaengine-pcm.c              |  82 +++++++---
 sound/soc/tegra/Kconfig                            |   2 +
 sound/soc/tegra/tegra20_ac97.c                     |  11 --
 sound/soc/tegra/tegra20_i2s.c                      |  20 +--
 sound/soc/tegra/tegra30_ahub.c                     | 125 +++++++++------
 sound/soc/tegra/tegra30_ahub.h                     |  11 +-
 sound/soc/tegra/tegra30_i2s.c                      |  97 ++++++------
 sound/soc/tegra/tegra30_i2s.h                      |   3 +
 sound/soc/tegra/tegra_pcm.c                        |  17 +-
 sound/soc/tegra/tegra_pcm.h                        |   5 +
 81 files changed, 1448 insertions(+), 558 deletions(-)

-- 
1.8.1.5
