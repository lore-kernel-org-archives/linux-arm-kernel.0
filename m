From: s-anna@ti.com (Suman Anna)
Date: Tue, 11 Jun 2013 12:03:23 -0500
Subject: [PATCH v2 0/6] move omap mailbox to drivers & minor fixes
Message-ID: <1370970203-6634-1-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is an updated series addressing review comments from Russ Dill.

Main changes in v2:
===================
- Dropped the patch "omap: mailbox: check for NULL nb in mailbox_put"
- Removed the mailbox device attr data addition to OMAP4 hwmod files,
  the hwmod cleanup of irqlines for 3.11 would cause the mailbox probe
  to fail anyway when enabled. The data would have to be removed when
  DT node for mailbox is added anyway, and there are no current active
  users within the tree.
- Other minor comments and patch description changes as per review
  comments.

I have tested this series on Panda 4 (using the removed OMAP4 hwmod
changes on top of the series) and on Beagle-XM.

v1:
==
The series moves the OMAP mailbox code to drivers/mailbox folder
and includes other minor fixes. The OMAP mailbox code is disabled
for couple of releases now because of multi-platform support,
and the move enables the driver to be built again and be functional.

These also serve as the base preparatory patches for adapting the
OMAP mailbox code to the upcoming mailbox framework, and for
device-tree conversion.

http://marc.info/?l=linux-omap&m=137065697924665&w=2

Suman Anna (6):
  omap: mailbox: check iomem resource before dereferencing it
  omap: mailbox: call request_irq after mbox queues are allocated
  omap: mailbox: correct the argument type for irq ops
  ARM: OMAP2+: mbox: remove dependencies with soc.h
  ARM: OMAP2+: add user and fifo info to mailbox platform data
  mailbox/omap: move the OMAP mailbox framework to drivers

 arch/arm/configs/omap1_defconfig                   |   3 +-
 arch/arm/mach-omap1/Makefile                       |   4 -
 arch/arm/mach-omap2/Makefile                       |   3 -
 arch/arm/mach-omap2/devices.c                      |  13 +-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |  14 ++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |  13 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  13 +
 arch/arm/plat-omap/Kconfig                         |  16 --
 arch/arm/plat-omap/Makefile                        |   3 -
 drivers/mailbox/Kconfig                            |  34 +++
 drivers/mailbox/Makefile                           |   6 +
 .../mailbox.c => drivers/mailbox/mailbox-omap1.c   |  12 +-
 .../mailbox.c => drivers/mailbox/mailbox-omap2.c   | 276 ++++++++-------------
 .../mailbox.c => drivers/mailbox/omap-mailbox.c    |  54 +++-
 .../plat/mailbox.h => drivers/mailbox/omap-mbox.h  |  70 ++----
 drivers/remoteproc/Kconfig                         |   3 +-
 drivers/remoteproc/omap_remoteproc.c               |   2 +-
 drivers/staging/tidspbridge/Kconfig                |   3 +-
 .../tidspbridge/include/dspbridge/host_os.h        |   2 +-
 include/linux/omap-mailbox.h                       |  29 +++
 include/linux/platform_data/mailbox-omap.h         |  58 +++++
 21 files changed, 355 insertions(+), 276 deletions(-)
 rename arch/arm/mach-omap1/mailbox.c => drivers/mailbox/mailbox-omap1.c (94%)
 rename arch/arm/mach-omap2/mailbox.c => drivers/mailbox/mailbox-omap2.c (59%)
 rename arch/arm/plat-omap/mailbox.c => drivers/mailbox/omap-mailbox.c (92%)
 rename arch/arm/plat-omap/include/plat/mailbox.h => drivers/mailbox/omap-mbox.h (54%)
 create mode 100644 include/linux/omap-mailbox.h
 create mode 100644 include/linux/platform_data/mailbox-omap.h

-- 
1.8.2
