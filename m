From: s-anna@ti.com (Anna, Suman)
Date: Thu, 4 Apr 2013 21:48:16 +0000
Subject: [GIT PULL] mailbox driver framework for v3.10 merge window
Message-ID: <37C860A02101E749A747FA2D3C1E3C504A1971@DLEE11.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9: 

        Linux 3.9-rc2 (2013-03-10 16:54:19 -0700)

are available in the git repository at:

        git://github.com/sumananna/mailbox.git dbx500-prcmu-mailbox

for you to fetch changes up to c497eba5247728c67ba0e0de0907723dd114134a:

        mailbox: fix invalid use of sizeof in mailbox_msg_send() (2013-03-23 15:04:14 +0800)

------------------------------------------------------------------------------
OMAP and ST-Ericsson platforms are both using mailbox to communicate with some coprocessors. This series creates a consolidated framework, living under drivers/mailbox.
The changes mainly contain:
- create a mailbox framework independent from OMAP h/w
- creates dbx500 mailbox driver for ST-Ericsson platforms
- move the omap mailbox out of plat-omap/mach-omapX  adapting to the new framework.
- minor bug fixes in mailbox code

This series is needed for the work currently being done on the PRCMU driver.
------------------------------------------------------------------------------

Loic Pallardy (7):
  mailbox: rename omap_mbox in mailbox
  mailbox: create opened message type
  mailbox: change protection mechanisms
  mailbox: add shared memory mailbox type
  mailbox: add IRQF_NO_SUSPEND flag
  mailbox: add no_irq send message
  mailbox: create dbx500 mailbox driver

Omar Ramirez Luna (2):
  mailbox: OMAP: introduce mailbox framework
  mailbox: split internal header from API header

Suman Anna (5):
  mailbox: rename pl320-ipc specific mailbox.h
  ARM: OMAP2+: mbox: remove dependencies with soc.h
  mailbox/omap: check iomem resource before dereferencing it
  mailbox: check for NULL nb in mailbox_put
  mailbox: call request_irq after mbox queues are allocated

Wei Yongjun (1):
  mailbox: fix invalid use of sizeof in mailbox_msg_send()

 .../devicetree/bindings/mailbox/dbx500-mailbox.txt |  27 +
 arch/arm/configs/omap1_defconfig                   |   3 +-
 arch/arm/mach-omap1/Makefile                       |   4 -
 arch/arm/mach-omap1/mailbox.c                      | 199 -------
 arch/arm/mach-omap2/Makefile                       |   3 -
 arch/arm/mach-omap2/devices.c                      |  13 +-
 arch/arm/mach-omap2/mailbox.c                      | 430 --------------
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |  12 +
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |  11 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  11 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |  13 +
 arch/arm/plat-omap/Kconfig                         |  16 -
 arch/arm/plat-omap/Makefile                        |   3 -
 arch/arm/plat-omap/include/plat/mailbox.h          | 105 ----
 arch/arm/plat-omap/mailbox.c                       | 435 --------------
 drivers/cpufreq/highbank-cpufreq.c                 |   2 +-
 drivers/mailbox/Kconfig                            |  41 ++
 drivers/mailbox/Makefile                           |   5 +
 drivers/mailbox/mailbox-dbx500.c                   | 648 +++++++++++++++++++++
 drivers/mailbox/mailbox-omap1.c                    | 229 ++++++++
 drivers/mailbox/mailbox-omap2.c                    | 370 ++++++++++++
 drivers/mailbox/mailbox.c                          | 552 ++++++++++++++++++
 drivers/mailbox/mailbox_internal.h                 |  70 +++
 drivers/mailbox/pl320-ipc.c                        |   2 +-
 drivers/remoteproc/Kconfig                         |   3 +-
 drivers/remoteproc/omap_remoteproc.c               |  36 +-
 drivers/staging/tidspbridge/Kconfig                |   3 +-
 drivers/staging/tidspbridge/core/_tiomap.h         |   2 +-
 drivers/staging/tidspbridge/core/chnl_sm.c         |   8 +-
 drivers/staging/tidspbridge/core/io_sm.c           |   5 +-
 drivers/staging/tidspbridge/core/tiomap3430.c      |   6 +-
 drivers/staging/tidspbridge/core/tiomap3430_pwr.c  |   6 +-
 drivers/staging/tidspbridge/core/tiomap_io.c       |   9 +-
 .../tidspbridge/include/dspbridge/host_os.h        |   2 +-
 include/linux/mailbox.h                            |  52 +-
 include/linux/pl320-ipc.h                          |  17 +
 include/linux/platform_data/mailbox-dbx500.h       |  12 +
 include/linux/platform_data/mailbox-omap.h         |  53 ++
 38 files changed, 2170 insertions(+), 1248 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/dbx500-mailbox.txt
 delete mode 100644 arch/arm/mach-omap1/mailbox.c
 delete mode 100644 arch/arm/mach-omap2/mailbox.c
 delete mode 100644 arch/arm/plat-omap/include/plat/mailbox.h
 delete mode 100644 arch/arm/plat-omap/mailbox.c
 create mode 100644 drivers/mailbox/mailbox-dbx500.c
 create mode 100644 drivers/mailbox/mailbox-omap1.c
 create mode 100644 drivers/mailbox/mailbox-omap2.c
 create mode 100644 drivers/mailbox/mailbox.c
 create mode 100644 drivers/mailbox/mailbox_internal.h
 create mode 100644 include/linux/pl320-ipc.h
 create mode 100644 include/linux/platform_data/mailbox-dbx500.h
 create mode 100644 include/linux/platform_data/mailbox-omap.h

--
