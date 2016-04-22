From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Fri, 22 Apr 2016 14:27:37 +0800
Subject: [v8, 0/7] Fix eSDHC host version register bug
Message-ID: <1461306464-19521-1-git-send-email-yangbo.lu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is used to fix a host version register bug in the T4240-R1.0-R2.0
eSDHC controller. To get the SoC version and revision, it's needed to add the
GUTS driver to access the global utilities registers.

So, the first four patches are to add the GUTS driver.
The following patches except the updating MAINTAINERS patch are to enable
GUTS driver support to get SVR in eSDHC driver and fix host version for T4240.

Yangbo Lu (7):
  Documentation: DT: update Freescale DCFG compatible
  ARM64: dts: ls2080a: add device configuration node
  soc: fsl: add GUTS driver for QorIQ platforms
  dt: move guts devicetree doc out of powerpc directory
  powerpc/fsl: move mpc85xx.h to include/linux/fsl
  MAINTAINERS: add entry for Freescale SoC specific driver
  mmc: sdhci-of-esdhc: fix host version for T4240-R1.0-R2.0

 Documentation/devicetree/bindings/arm/fsl.txt      |   2 +-
 .../bindings/{powerpc => soc}/fsl/guts.txt         |   3 +
 MAINTAINERS                                        |  16 ++-
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     |   6 +
 arch/powerpc/kernel/cpu_setup_fsl_booke.S          |   2 +-
 drivers/clk/clk-qoriq.c                            |   3 +-
 drivers/i2c/busses/i2c-mpc.c                       |   2 +-
 drivers/iommu/fsl_pamu.c                           |   3 +-
 drivers/mmc/host/Kconfig                           |   1 +
 drivers/mmc/host/sdhci-of-esdhc.c                  |  23 ++++
 drivers/net/ethernet/freescale/gianfar.c           |   2 +-
 drivers/soc/Kconfig                                |   2 +-
 drivers/soc/fsl/Kconfig                            |   8 ++
 drivers/soc/fsl/Makefile                           |   1 +
 drivers/soc/fsl/guts.c                             | 119 +++++++++++++++++++
 include/linux/fsl/guts.h                           | 126 +++++++++++++--------
 .../asm/mpc85xx.h => include/linux/fsl/svr.h       |   4 +-
 17 files changed, 263 insertions(+), 60 deletions(-)
 rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/guts.txt (91%)
 create mode 100644 drivers/soc/fsl/Kconfig
 create mode 100644 drivers/soc/fsl/guts.c
 rename arch/powerpc/include/asm/mpc85xx.h => include/linux/fsl/svr.h (97%)

-- 
2.1.0.27.g96db324
