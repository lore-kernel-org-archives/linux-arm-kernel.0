From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 25 Nov 2013 15:05:58 -0700
Subject: [PATCH V2 0/3] ARM: tegra: use common reset and DMA bindings
Message-ID: <1385417161-5542-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

(((
This is V2 of a small subset of a much larger series. All the driver
code in the series has been ack'd, so I'm just missing acks for the DT
bindings changes, which is all I'm reposting here. The changes in V2
are minor typo-oriented changes. V1 was at:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November/211699.html
)))

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

Cc: treding at nvidia.com
Cc: pdeschrijver at nvidia.com
Cc: linux-tegra at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree at vger.kernel.org

Stephen Warren (3):
  ARM: tegra: add missing clock documentation to DT bindings
  ARM: tegra: document reset properties in DT bindings
  ARM: tegra: document use of standard DMA DT bindings

 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      |   1 +
 .../bindings/clock/nvidia,tegra114-car.txt         |   4 +
 .../bindings/clock/nvidia,tegra124-car.txt         |   4 +
 .../bindings/clock/nvidia,tegra20-car.txt          |   4 +
 .../bindings/clock/nvidia,tegra30-car.txt          |   4 +
 .../devicetree/bindings/dma/tegra20-apbdma.txt     |  14 +++
 .../bindings/gpu/nvidia,tegra20-host1x.txt         | 122 +++++++++++++++++++++
 .../devicetree/bindings/i2c/nvidia,tegra20-i2c.txt |  27 ++++-
 .../bindings/input/nvidia,tegra20-kbc.txt          |   9 ++
 .../bindings/mmc/nvidia,tegra20-sdhci.txt          |   9 ++
 .../devicetree/bindings/nvec/nvidia,nvec.txt       |  12 ++
 .../bindings/pci/nvidia,tegra20-pcie.txt           |  28 +++--
 .../devicetree/bindings/pwm/nvidia,tegra20-pwm.txt |   9 ++
 .../devicetree/bindings/rtc/nvidia,tegra20-rtc.txt |   3 +
 .../bindings/serial/nvidia,tegra20-hsuart.txt      |  19 +++-
 .../bindings/sound/nvidia,tegra-audio-alc5632.txt  |   7 +-
 .../bindings/sound/nvidia,tegra-audio-rt5640.txt   |   7 +-
 .../bindings/sound/nvidia,tegra-audio-wm8753.txt   |   7 +-
 .../bindings/sound/nvidia,tegra-audio-wm8903.txt   |   7 +-
 .../bindings/sound/nvidia,tegra-audio-wm9712.txt   |   7 +-
 .../bindings/sound/nvidia,tegra20-ac97.txt         |  20 +++-
 .../bindings/sound/nvidia,tegra20-i2s.txt          |  19 +++-
 .../bindings/sound/nvidia,tegra30-ahub.txt         |  54 ++++++---
 .../bindings/sound/nvidia,tegra30-i2s.txt          |  11 +-
 .../bindings/spi/nvidia,tegra114-spi.txt           |  24 +++-
 .../bindings/spi/nvidia,tegra20-sflash.txt         |  20 +++-
 .../bindings/spi/nvidia,tegra20-slink.txt          |  20 +++-
 .../bindings/timer/nvidia,tegra20-timer.txt        |   3 +
 .../bindings/timer/nvidia,tegra30-timer.txt        |   3 +
 .../bindings/usb/nvidia,tegra20-ehci.txt           |   7 +-
 30 files changed, 416 insertions(+), 69 deletions(-)

-- 
1.8.1.5
