From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 28 May 2015 10:40:11 +0200
Subject: [PATCH 0/3] bus: mvebu-mbus: important fixes and improvements
Message-ID: <1432802414-12355-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear mvebu maintainers,

This set of patches contain two very important fixes to the mvebu-mbus
driver fixing significant regressions introduced during the 4.0 cycle,
and one patch re-implementing in a different a feature that caused one
of the two regressions.

 * The first patch, provided by Nicolas Schichan, fixed a regression
    introduced in 4.0 by commit a0b5cd4ac2d6 ("bus: mvebu-mbus: use
    automatic I/O synchronization barriers"). This commit didn't take
    into account non-HW I/O coherent platforms such as Kirkwood or
    Orion, for which the new special bit being set causes problems. It
    makes some of the MBus I/O windows unusable on these SoCs.

    Therefore, this patch is marked for stable and should be merged
    for 4.1-rc.

 * The second patch is a simple revert of commit "bus: mvebu-mbus:
    make sure SDRAM CS for DMA don't overlap the MBus bridge window"
    introduced in 4.0. This commit was added in preparation for the
    merge of the new DMA-capable CESA crypto driver submitted by Boris
    Brezillon. However, it breaks DMA for all the other units if your
    platform has 4 GB of RAM or more. Of course, by reverting it, the
    functionality needed for the crypto driver is no longer present,
    but this is OK since the crypto driver isn't merged yet, and will
    not be merged for 4.1.

    Therefore, this patch is marked for stable and should be merged
    for 4.1-rc.

  * The last re-implements the mechanism originally implemented by
    "bus: mvebu-mbus: make sure SDRAM CS for DMA don't overlap the
    MBus bridge window", but in a completely different way. This patch
    will be needed for the CESA driver.

    This patch is not a fix, and should therefore be merged in 4.2.

Thanks,

Thomas

Nicolas Schichan (1):
  bus: mvebu-mbus: do not set WIN_CTRL_SYNCBARRIER on non io-coherent
    platforms.

Thomas Petazzoni (2):
  Revert "bus: mvebu-mbus: make sure SDRAM CS for DMA don't overlap the
    MBus bridge window"
  bus: mvebu-mbus: add mv_mbus_dram_info_nooverlap()

 drivers/bus/mvebu-mbus.c | 120 ++++++++++++++++++++++++++++++++---------------
 include/linux/mbus.h     |   1 +
 2 files changed, 84 insertions(+), 37 deletions(-)

-- 
2.1.0
