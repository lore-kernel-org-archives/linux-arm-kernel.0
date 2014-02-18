From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Feb 2014 15:08:01 +0000
Subject: [PATCH RFC 00/31] SDHCI and SDIO IRQ improvements
Message-ID: <20140218150801.GD21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patch series is targetted at two things - fixing the SDIO
interrupt handling, and fixing problems with the sdhci driver.

- the first two patches from Thomas Gleixner provide genirq support to
  allow us to fix the SDIO interrupt handling in a graceful manner.
- patch 3 adds support for avoiding the buggy sdio_irq thread - the
  problem is described in that commit.  Other solutions were explored,
  but this is the one which was settled on after discussions between
  Thomas, scheduler people and myself.
- patches 4 to 7 update sdhci to use a genirq to deal with the threaded
  part of the interrupts.
- patch 8 allows card interrupts to be received from a SDIO card while
  runtime suspended.  Without this patch, Wifi cards attached to a
  kernel with runtime PM support built in totally fail to work.  This
  allows them to work.  Tested in 4-bit mode.
- patches 9 onwards are cleanups and fixes to the sdhci code.

 drivers/mmc/core/sdio_irq.c        |  41 ++-
 drivers/mmc/host/sdhci-acpi.c      |   8 +
 drivers/mmc/host/sdhci-bcm-kona.c  |   4 +
 drivers/mmc/host/sdhci-bcm2835.c   |   4 +
 drivers/mmc/host/sdhci-cns3xxx.c   |  13 +-
 drivers/mmc/host/sdhci-dove.c      |   4 +
 drivers/mmc/host/sdhci-esdhc-imx.c |  82 ++---
 drivers/mmc/host/sdhci-esdhc.h     |   4 +-
 drivers/mmc/host/sdhci-of-arasan.c |   4 +
 drivers/mmc/host/sdhci-of-esdhc.c  |  70 +++--
 drivers/mmc/host/sdhci-of-hlwd.c   |   4 +
 drivers/mmc/host/sdhci-pci.c       |   9 +-
 drivers/mmc/host/sdhci-pltfm.c     |   4 +
 drivers/mmc/host/sdhci-pxav2.c     |  14 +-
 drivers/mmc/host/sdhci-pxav3.c     |  13 +-
 drivers/mmc/host/sdhci-s3c.c       |  36 ++-
 drivers/mmc/host/sdhci-sirf.c      |   4 +
 drivers/mmc/host/sdhci-spear.c     |   5 +-
 drivers/mmc/host/sdhci-tegra.c     |  27 +-
 drivers/mmc/host/sdhci.c           | 606 ++++++++++++++++++-------------------
 drivers/mmc/host/sdhci.h           |  20 +-
 include/linux/hardirq.h            |   1 +
 include/linux/interrupt.h          |   1 +
 include/linux/mmc/host.h           |   3 +
 include/linux/mmc/sdhci.h          |  14 +-
 kernel/irq/handle.c                |   4 +-
 kernel/irq/internals.h             |   1 +
 kernel/irq/manage.c                |  94 ++++--
 28 files changed, 608 insertions(+), 486 deletions(-)

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
