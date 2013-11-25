From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 25 Nov 2013 12:13:36 +0100
Subject: [PATCH v2 0/9] ASoC: fsl-ssi: offline/online configuration and
 cleanups
Message-ID: <1385378025-1262-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series fixes some fsl-ssi code that does not act exactly as it is
described in the reference manuals.

The reference manuals before imx50 do mention that some register bits,
including TDMAE/RDMAE, should not be changed while the SSI unit is enabled
(SSIEN). At the same time the SDMA unit has a undefined request handling if
there are DMA requests before the SDMA engine and its channel is configured.
The reference manual states that SSI DMA requests are sent as soon as the FIFO
and the DMAE bits are enabled. It does not mention a dependency to SCR's TE/RE
bit.

To avoid sending DMA requests before a channel is configured, we have to
seperate the fsl-ssi behavior into offline and online configuration. SoCs
before imx50 have to use offline configuration while later SoC versions can use
online reconfiguration.

This series adds support for online configuration and cleans up the
configuration register code especially in fsl_ssi_trigger. At the end we have a
seperation between enable/disable logic and the actual configuration register
values used to enable/disable TX/RX.

I tested this series on mx53.

The series is based on Mark Brown's topic/fsl branch.

Regards,

Markus

Changes in v2:
 - Enable fsl-ssi interrupts independent of CONFIG_DEBUG_FS.
 - Move irq mapping fix into seperate patch (was in "Move sysfs stats to debugfs")
 - Rebased on v3.13-rc1 topic/fsl branch.

Changes in v1:
 - Not removing imx21-ssi from the compatible array in the DTS patch.
 - Dropped "ASoC: fsl-ssi: Drop AC97 debug register usage" for the moment as I
   don't have time to setup AC97 hardware for some tests

Markus Pargmann (9):
  ASoC: fsl-ssi: Move sysfs stats to debugfs
  ASoC: fsl-ssi: Fix interrupt mapping and release
  ASoC: fsl-ssi: Add imx50-ssi and of_device_id matching
  ASoC: fsl-ssi: Add offline_config flag
  ASoC: fsl-ssi: Add configuration helper functions
  ASoC: fsl-ssi: Move RX/TX configuration to seperate functions
  ASoC: fsl-ssi: Drop ac97 specific trigger function
  ARM: DTS: imx5* imx6*, use imx50-ssi
  ASoC: fsl-ssi: Drop AC97 debug register usage

 arch/arm/boot/dts/imx51.dtsi   |  10 +-
 arch/arm/boot/dts/imx53.dtsi   |  10 +-
 arch/arm/boot/dts/imx6qdl.dtsi |  12 +-
 arch/arm/boot/dts/imx6sl.dtsi  |  12 +-
 sound/soc/fsl/fsl_ssi.c        | 521 +++++++++++++++++++++++++++--------------
 5 files changed, 371 insertions(+), 194 deletions(-)

-- 
1.8.4.2
