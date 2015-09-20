From: scottwood@freescale.com (Scott Wood)
Date: Sat, 19 Sep 2015 23:29:52 -0500
Subject: [PATCH v3 0/5] clk: qoriq: Move chip-specific knowledge into driver
Message-ID: <1442723397-26329-1-git-send-email-scottwood@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The existing device tree bindings are error-prone and inflexible. 
Correct the mistake by moving the knowledge into the driver, which has
more flexibility in describing the quirks of each chip.  This leaves the
device tree to its proper role of identifying a programming interface
rather than describing its individual registers.

For more detail, see the commit message of patch 2.

As there are both ARM and PPC patches that depend on this patchset, I'm
requesting ACKs from clk and cpufreq in order to put this into a topic
branch that both ARM and PPC can pull.

Scott Wood (5):
  powerpc/fsl: Move fsl_guts.h out of arch/powerpc
  clk: qoriq: Move chip-specific knowledge into driver
  clk: qoriq: Add ls2080a support.
  clk: Add consumer APIs for discovering possible parent clocks
  cpufreq: qoriq: Don't look at clock implementation details

 .../devicetree/bindings/clock/qoriq-clock.txt      |   61 +-
 arch/powerpc/include/asm/fsl_guts.h                |  192 ---
 arch/powerpc/platforms/85xx/mpc85xx_mds.c          |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c          |    2 +-
 arch/powerpc/platforms/85xx/p1022_ds.c             |    2 +-
 arch/powerpc/platforms/85xx/p1022_rdk.c            |    2 +-
 arch/powerpc/platforms/85xx/smp.c                  |    2 +-
 arch/powerpc/platforms/85xx/twr_p102x.c            |    2 +-
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c         |    2 +-
 drivers/clk/Kconfig                                |    2 +-
 drivers/clk/clk-qoriq.c                            | 1316 ++++++++++++++++----
 drivers/clk/clk.c                                  |   19 +
 drivers/cpufreq/qoriq-cpufreq.c                    |  137 +-
 drivers/iommu/fsl_pamu.c                           |    2 +-
 include/linux/clk.h                                |   31 +
 include/linux/fsl/guts.h                           |  192 +++
 sound/soc/fsl/mpc8610_hpcd.c                       |    2 +-
 sound/soc/fsl/p1022_ds.c                           |    2 +-
 sound/soc/fsl/p1022_rdk.c                          |    2 +-
 19 files changed, 1441 insertions(+), 531 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/fsl_guts.h
 create mode 100644 include/linux/fsl/guts.h

-- 
2.1.4
