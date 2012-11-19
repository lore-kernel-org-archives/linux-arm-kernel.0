From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 11:04:38 +0100
Subject: [GIT PULL] Marvell XOR driver cleanup and DT binding
Message-ID: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jason,

Here is hopefully the final version of the Marvell XOR driver cleanup
and DT binding series. Note that this series contains the driver
changes only, I'll send the DT changes shortly in a separate pull
request. That said, the driver changes are intermixed with plat-orion
changes, but this is needed as we change the platform_data of the
driver, so we need to keep plat-orion in sync with those changes.

Changes since v1:

 * Fixed the section mismatch warnings reported by Sebastian
   Hesselbarth.

 * Integrated Andrew Lunn patch adding the device_control hook

 * Fixed the warning about irq_dispose_mapping() on !OF platforms.

 * Use MV_XOR_NAME in more places (Dove and Kirkwood) so that the
   driver renaming is transparent. Reported by Sebastian Hesselbarth.

These patches apply on top of the clk patches from Andrew Lunn, that
you have already merged.

Thanks!

The following changes since commit 457dd0c77ec7616ea5028e96bcfd4cee676b2caf:

  arm: mvebu: armada 370/XP adding clock gating support: dt binding (2012-11-19 10:07:45 +0100)

are available in the git repository at:

  git at github.com:MISL-EBU-System-SW/mainline-public.git tags/marvell-xor-cleanup-dt-binding-3.8

for you to fetch changes up to 7a008db916df99af0cd1d765badcb3e4261b4021:

  dma: mv_xor: Add a device_control function (2012-11-19 10:53:30 +0100)

----------------------------------------------------------------
Marvell XOR driver cleanup and DT binding for 3.8

----------------------------------------------------------------
Andrew Lunn (1):
      dma: mv_xor: Add a device_control function

Thomas Petazzoni (29):
      dma: mv_xor: use dev_(err|info|notice) instead of dev_printk
      dma: mv_xor: do not use pool_size from platform_data within the driver
      dma: mv_xor: split initialization/cleanup of XOR channels
      dma: mv_xor: allow channels to be registered directly from the main device
      arm: plat-orion: convert the registration of the xor0 engine to the single driver
      arm: plat-orion: convert the registration of the xor1 engine to the single driver
      arm: plat-orion: remove unused orion_xor_init_channels()
      dma: mv_xor: remove sub-driver 'mv_xor'
      dma: mv_xor: remove 'shared' from mv_xor_platform_data
      dma: mv_xor: rename mv_xor_platform_data to mv_xor_channel_data
      dma: mv_xor: rename mv_xor_shared_platform_data to mv_xor_platform_data
      dma: mv_xor: change the driver name to 'mv_xor'
      dma: mv_xor: rename many symbols to remove the 'shared' word
      dma: mv_xor: remove unused id field in mv_xor_device structure
      dma: mv_xor: remove unused to_mv_xor_device() macro
      dma: mv_xor: simplify dma_sync_single_for_cpu() calls
      dma: mv_xor: introduce a mv_chan_to_devp() helper
      dma: mv_xor: get rid of the pdev pointer in mv_xor_device
      dma: mv_xor: in mv_xor_chan, rename 'common' to 'dmachan'
      dma: mv_xor: in mv_xor_device, rename 'common' to 'dmadev'
      dma: mv_xor: use mv_xor_chan pointers as arguments to self-test functions
      dma: mv_xor: merge mv_xor_device and mv_xor_chan
      dma: mv_xor: rename mv_xor_private to mv_xor_device
      dma: mv_xor: remove useless backpointer from mv_xor_chan to mv_xor_device
      dma: mv_xor: remove hw_id field from platform_data
      dma: mv_xor: remove the pool_size from platform_data
      dma: mv_xor: add missing free_irq() call
      dma: mv_xor: add Device Tree binding
      dma: mv_xor: add missing __devinit and __devexit qualifiers on probe and remove

 Documentation/devicetree/bindings/dma/mv-xor.txt |   40 +++
 arch/arm/mach-dove/common.c                      |    9 +-
 arch/arm/mach-kirkwood/board-dt.c                |    5 +-
 arch/arm/mach-kirkwood/common.c                  |    4 +-
 arch/arm/plat-orion/common.c                     |  192 ++++------
 drivers/dma/mv_xor.c                             |  417 ++++++++++++----------
 drivers/dma/mv_xor.h                             |   35 +-
 include/linux/platform_data/dma-mv_xor.h         |   11 +-
 8 files changed, 366 insertions(+), 347 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/mv-xor.txt
