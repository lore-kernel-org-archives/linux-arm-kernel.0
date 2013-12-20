From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 20 Dec 2013 14:11:27 +0100
Subject: [PATCH v4 0/9] ASoC: fsl-ssi: offline/online configuration and
 cleanups
Message-ID: <1387545096-2334-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series fixes some fsl-ssi code that does not act exactly as it is
described in the reference manuals.

The reference manuals before imx51 do mention that some register bits,
including TDMAE/RDMAE, should not be changed while the SSI unit is enabled
(SSIEN). At the same time the SDMA unit has a undefined request handling if
there are DMA requests before the SDMA engine and its channel is configured.
The reference manual states that SSI DMA requests are sent as soon as the FIFO
and the DMAE bits are enabled. It does not mention a dependency to SCR's TE/RE
bit.

To avoid sending DMA requests before a channel is configured, we have to
seperate the fsl-ssi behavior into offline and online configuration. SoCs
before imx51 have to use offline configuration while later SoC versions can use
online reconfiguration.

This series adds support for online configuration and cleans up the
configuration register code especially in fsl_ssi_trigger. At the end we have a
seperation between enable/disable logic and the actual configuration register
values used to enable/disable TX/RX.

v4 is another rebase onto latest topic/fsl branch. It includes the DAI master
mode changes from Nicolin.

@Nicolin: Could you please test this series with your hardware to verify that
your patch still works?

I tested this series on mx53.

The series is based on Mark Brown's topic/fsl branch.

Regards,

Markus

Changes in v4:
 - Support for irqstats on all imx SoCs
 - Fix offline_config and use switch statement
 - Introduce ssi_private->irq_stats bool

Changes in v3:
 - Rebase on latest topic/fsl
 - Added patch to cleanup probe function error handling
 - Fix interrupt stats for imx53
 - Replace imx50-ssi by imx51-ssi

Markus Pargmann (9):
  ASoC: fsl-ssi: Fix probe error handling
  ASoC: fsl-ssi: Move sysfs stats to debugfs
  ASoC: fsl-ssi: Add imx51-ssi and of_device_id matching
  ASoC: fsl-ssi: Fix interrupt stats for imx
  ASoC: fsl-ssi: Add offline_config flag
  ASoC: fsl-ssi: Add configuration helper functions
  ASoC: fsl-ssi: Move RX/TX configuration to seperate functions
  ASoC: fsl-ssi: Drop ac97 specific trigger function
  ARM: DTS: imx5* imx6*, use imx51-ssi

 arch/arm/boot/dts/imx53.dtsi   |  10 +-
 arch/arm/boot/dts/imx6qdl.dtsi |  12 +-
 arch/arm/boot/dts/imx6sl.dtsi  |  12 +-
 sound/soc/fsl/fsl_ssi.c        | 567 ++++++++++++++++++++++++++++-------------
 4 files changed, 411 insertions(+), 190 deletions(-)

-- 
1.8.5.1
