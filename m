From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 18 Dec 2013 12:57:36 +0100
Subject: [PATCH v3 0/9] ASoC: fsl-ssi: offline/online configuration and
 cleanups
Message-ID: <1387367865-26391-1-git-send-email-mpa@pengutronix.de>
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

v3 adds another fixup for the interrupt stats. The interrupt handler currently
writes back a subset of the interrupt flags to clear the interrupts in the
status register. This is not implemented on every processor. For example imx27
does not allow writebacks, imx53 does not allow writeback of RFRC and TFRC. The
interrupt stats were disabled for imx by default. 'Fix interrupt mapping and
release' enables it for mx53 again and changes the writeback flags.

I tested this series on mx53.

The series is based on Mark Brown's topic/fsl branch.

Regards,

Markus


Changes in v3:
 - Rebase on latest topic/fsl
 - Added patch to cleanup probe function error handling
 - Fix interrupt stats for imx53
 - Replace imx50-ssi by imx51-ssi



Markus Pargmann (9):
  ASoC: fsl-ssi: Fix probe error handling
  ASoC: fsl-ssi: Move sysfs stats to debugfs
  ASoC: fsl-ssi: Add imx51-ssi and of_device_id matching
  ASoC: fsl-ssi: Fix interrupt mapping and release
  ASoC: fsl-ssi: Add offline_config flag
  ASoC: fsl-ssi: Add configuration helper functions
  ASoC: fsl-ssi: Move RX/TX configuration to seperate functions
  ASoC: fsl-ssi: Drop ac97 specific trigger function
  ARM: DTS: imx5* imx6*, use imx51-ssi

 arch/arm/boot/dts/imx51.dtsi   |   3 +-
 arch/arm/boot/dts/imx53.dtsi   |  10 +-
 arch/arm/boot/dts/imx6qdl.dtsi |  12 +-
 arch/arm/boot/dts/imx6sl.dtsi  |  12 +-
 sound/soc/fsl/fsl_ssi.c        | 539 +++++++++++++++++++++++++++--------------
 5 files changed, 387 insertions(+), 189 deletions(-)

-- 
1.8.5.1
