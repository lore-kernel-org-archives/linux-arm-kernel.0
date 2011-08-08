From: tixy@yxit.co.uk (Jon Medhurst)
Date: Mon,  8 Aug 2011 15:28:20 +0100
Subject: [PATCH 0/12] ARM: Remove define CONSISTENT_DMA_SIZE
Message-ID: <1312813712-22808-1-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The size of the consistent DMA mapping region is given by the define
CONSISTENT_DMA_SIZE. This defaults to a value of 2MB but various
platforms increase this, usually to support larger frame buffers.

To enable support for building multiple ARM platforms into a single
kernel binary, we need to remove the compile time constant
CONSISTENT_DMA_SIZE and make it configured at boot time.

To implement this, this patch series provides a function to set the
size - init_consistent_dma_size() - then each platform which requires a
non-default value is modified to call this during the map_io callback.
(This call-site was chosen as it is platform specific, early enough, and
is somewhat related to the functions being performed.)

Future CMA work may make these changes obsolete, so this is probably a
near term solution to help progress the 'single zImage' work.

CC: Ben Dooks <ben-linux@fluff.org>
CC: Kukjin Kim <kgene.kim@samsung.com>
CC: Sascha Hauer <kernel@pengutronix.de>
CC: Amit Kucheria <amit.kucheria@canonical.com>
CC: Sekhar Nori <nsekhar@ti.com>
CC: Kevin Hilman <khilman@ti.com>
CC: Linus Walleij <linus.walleij@stericsson.com>
CC: Nicolas Ferre <nicolas.ferre@atmel.com>
CC: Jiandong Zheng <jdzheng@broadcom.com>
CC: Scott Branden <sbranden@broadcom.com>
CC: Paul Mundt <lethal@linux-sh.org>
CC: Magnus Damm <magnus.damm@gmail.com>

---
 arch/arm/include/asm/dma-mapping.h            |    3 ++
 arch/arm/include/asm/memory.h                 |    9 -----
 arch/arm/mach-at91/at91sam9g45.c              |    2 +
 arch/arm/mach-at91/include/mach/at91sam9g45.h |    2 -
 arch/arm/mach-bcmring/include/mach/memory.h   |    5 ---
 arch/arm/mach-bcmring/mm.c                    |    3 ++
 arch/arm/mach-davinci/common.c                |    3 ++
 arch/arm/mach-davinci/include/mach/memory.h   |    5 ---
 arch/arm/mach-imx/mm-imx1.c                   |    1 +
 arch/arm/mach-imx/mm-imx21.c                  |    1 +
 arch/arm/mach-imx/mm-imx25.c                  |    1 +
 arch/arm/mach-imx/mm-imx27.c                  |    1 +
 arch/arm/mach-imx/mm-imx31.c                  |    1 +
 arch/arm/mach-imx/mm-imx35.c                  |    1 +
 arch/arm/mach-mx5/mm-mx50.c                   |    1 +
 arch/arm/mach-mx5/mm.c                        |    2 +
 arch/arm/mach-omap1/io.c                      |    1 +
 arch/arm/mach-omap2/io.c                      |    2 +-
 arch/arm/mach-s3c64xx/cpu.c                   |    2 +
 arch/arm/mach-s3c64xx/include/mach/memory.h   |    2 -
 arch/arm/mach-s5p64x0/cpu.c                   |    3 ++
 arch/arm/mach-s5p64x0/include/mach/memory.h   |    1 -
 arch/arm/mach-s5pv210/cpu.c                   |    2 +
 arch/arm/mach-s5pv210/include/mach/memory.h   |    1 -
 arch/arm/mach-shmobile/board-ag5evm.c         |    3 ++
 arch/arm/mach-shmobile/board-ap4evb.c         |    3 ++
 arch/arm/mach-shmobile/board-g3evm.c          |    3 ++
 arch/arm/mach-shmobile/board-g4evm.c          |    3 ++
 arch/arm/mach-shmobile/board-mackerel.c       |    3 ++
 arch/arm/mach-shmobile/include/mach/memory.h  |    3 --
 arch/arm/mach-u300/core.c                     |    3 ++
 arch/arm/mach-u300/include/mach/memory.h      |    5 ---
 arch/arm/mm/dma-mapping.c                     |   45 +++++++++++++++++++------
 arch/arm/mm/init.c                            |    9 -----
 arch/arm/plat-mxc/include/mach/common.h       |    1 +
 arch/arm/plat-mxc/include/mach/memory.h       |   15 --------
 arch/arm/plat-mxc/system.c                    |   16 +++++++++
 arch/arm/plat-omap/include/plat/io.h          |    2 +
 arch/arm/plat-omap/include/plat/memory.h      |   13 -------
 arch/arm/plat-omap/io.c                       |    8 ++++
 40 files changed, 108 insertions(+), 82 deletions(-)
