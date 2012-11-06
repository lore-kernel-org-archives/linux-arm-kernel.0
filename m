From: omar.luna@linaro.org (Omar Ramirez Luna)
Date: Mon,  5 Nov 2012 20:55:50 -0600
Subject: [PATCH v2 0/2] drivers: mailbox: omap-mailbox out of plat code
Message-ID: <1352170552-29564-1-git-send-email-omar.luna@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As part of plat-omap code cleanup, move omap-mailbox framework to
a newly drivers/mailbox folder, right now this code is specific to
OMAP platforms, but with some clean up it could be the base for a
generic framework; living under drivers/mailbox could give it some
exposure for interested developers to give feedback and propose changes.

In the past there was a mailbox-like driver in mach-ux500, I was
hoping both could live under the same folder, however the platform
using it, was dropped a couple of kernel releases back and with it the
other similar mailbox implementation.

However and as per Loic's comments[1], it looks like there could be
another potential mailbox candidate to live under drivers/mailbox in the
works, along with some proposed changes that could make the original
framework to evolve towards a generic implementation.

So for now, lets move the mailbox code to drivers/mailbox and split
internal structures from common API for others to use.

Based on 3.7-rc4.

1. https://lkml.org/lkml/2012/10/31/123

Omar Ramirez Luna (2):
  mailbox: OMAP: introduce mailbox framework
  mailbox: split internal header from API header

 arch/arm/configs/omap1_defconfig          |    3 +-
 arch/arm/mach-omap1/Makefile              |    4 -
 arch/arm/mach-omap1/mailbox.c             |  199 ------------
 arch/arm/mach-omap2/Makefile              |    3 -
 arch/arm/mach-omap2/devices.c             |    4 +-
 arch/arm/mach-omap2/mailbox.c             |  430 --------------------------
 arch/arm/plat-omap/Kconfig                |   16 -
 arch/arm/plat-omap/Makefile               |    3 -
 arch/arm/plat-omap/include/plat/mailbox.h |  105 -------
 arch/arm/plat-omap/mailbox.c              |  435 --------------------------
 drivers/Kconfig                           |    2 +
 drivers/Makefile                          |    1 +
 drivers/mailbox/Kconfig                   |   37 +++
 drivers/mailbox/Makefile                  |    4 +
 drivers/mailbox/mailbox-omap1.c           |  200 ++++++++++++
 drivers/mailbox/mailbox-omap2.c           |  430 ++++++++++++++++++++++++++
 drivers/mailbox/mailbox.c                 |  469 +++++++++++++++++++++++++++++
 drivers/mailbox/mailbox.h                 |   59 ++++
 include/linux/mailbox.h                   |   22 ++
 19 files changed, 1228 insertions(+), 1198 deletions(-)
 delete mode 100644 arch/arm/mach-omap1/mailbox.c
 delete mode 100644 arch/arm/mach-omap2/mailbox.c
 delete mode 100644 arch/arm/plat-omap/include/plat/mailbox.h
 delete mode 100644 arch/arm/plat-omap/mailbox.c
 create mode 100644 drivers/mailbox/Kconfig
 create mode 100644 drivers/mailbox/Makefile
 create mode 100644 drivers/mailbox/mailbox-omap1.c
 create mode 100644 drivers/mailbox/mailbox-omap2.c
 create mode 100644 drivers/mailbox/mailbox.c
 create mode 100644 drivers/mailbox/mailbox.h
 create mode 100644 include/linux/mailbox.h

-- 
1.7.9.5
