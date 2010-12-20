From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 20 Dec 2010 22:29:55 +0100
Subject: [PATCH v8 00/15] ARM: mxs: Add initial support for MX23 and MX28
In-Reply-To: <1292857064-5032-1-git-send-email-shawn.guo@freescale.com>
References: <1292857064-5032-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <20101220212955.GC14221@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 20, 2010 at 10:57:41PM +0800, Shawn Guo wrote:
> Changes for v8:
>  - Reuse debug-pl01x.S as mxs DUART is just an amba-pl011
So shouldn't "ARM: mxs: Dynamically allocate duart devices" create an
amba-pl011 device?

>  - Remove extra space in iomux.c
>  - Remove uncessary line breaker in mach-mx23evk.c
> 
>  [PATCH v8 05/15] ARM: mxs: Add low-level debug UART support
>  [PATCH v8 08/15] ARM: mxs: Add iomux support
>  [PATCH v8 13/15] ARM: mxs: Add initial mx23evk support

I was not yet able to boot a machine with an imx28 because of a missing
rootfs (no flash, no ethernet driver) but up to there it looks good.

I suggest to let Sascha take the current series to get it into the next
merge window and to be able to start patching based on something.  (Well
unless Russell or Sascha still have objections.)

I already have a few (simple) patches; I will clean them up and send
them in reply to this mail.

My next step is to look into the fec driver to make it work on mx28, so
if anyone already has something and wants to stop me doing duplicate
work, please tell me.

The following changes since commit 81e8d2162566379adcf4b3700f03845c62577145:

  Merge branch 'irq-fixes-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip (2010-12-07 08:14:28 -0800)

are available in the git repository at:

  git://git.pengutronix.de/git/ukl/linux-2.6.git sgu/mxs-core-v8

Shawn Guo (15):
      ARM: mxs: Add core definitions
      ARM: mxs: Add helper definition and function
      ARM: mxs: Add reset routines
      ARM: mxs: Add interrupt support
      ARM: mxs: Add low-level debug UART support
      ARM: mxs: Add timer support
      ARM: mxs: Add gpio support
      ARM: mxs: Add iomux support
      ARM: mxs: Add clock support
      ARM: mxs: Add static memory mapping
      ARM: mxs: Dynamically allocate duart devices
      ARM: mxs: Dynamically allocate fec devices
      ARM: mxs: Add initial mx23evk support
      ARM: mxs: Add initial mx28evk support
      ARM: mxs: Add build configuration for mxs

 arch/arm/Kconfig                                |   10 +
 arch/arm/Makefile                               |    1 +
 arch/arm/mach-mxs/Kconfig                       |   34 +
 arch/arm/mach-mxs/Makefile                      |   10 +
 arch/arm/mach-mxs/Makefile.boot                 |    1 +
 arch/arm/mach-mxs/clock-mx23.c                  |  526 ++++++++++++++++
 arch/arm/mach-mxs/clock-mx28.c                  |  734 +++++++++++++++++++++++
 arch/arm/mach-mxs/clock.c                       |  200 ++++++
 arch/arm/mach-mxs/devices-mx23.h                |   16 +
 arch/arm/mach-mxs/devices-mx28.h                |   20 +
 arch/arm/mach-mxs/devices.c                     |   75 +++
 arch/arm/mach-mxs/devices/Kconfig               |    5 +
 arch/arm/mach-mxs/devices/Makefile              |    2 +
 arch/arm/mach-mxs/devices/platform-duart.c      |   48 ++
 arch/arm/mach-mxs/devices/platform-fec.c        |   50 ++
 arch/arm/mach-mxs/gpio.c                        |  325 ++++++++++
 arch/arm/mach-mxs/gpio.h                        |   34 +
 arch/arm/mach-mxs/icoll.c                       |   81 +++
 arch/arm/mach-mxs/include/mach/clkdev.h         |    7 +
 arch/arm/mach-mxs/include/mach/clock.h          |   64 ++
 arch/arm/mach-mxs/include/mach/common.h         |   31 +
 arch/arm/mach-mxs/include/mach/debug-macro.S    |   38 ++
 arch/arm/mach-mxs/include/mach/devices-common.h |   46 ++
 arch/arm/mach-mxs/include/mach/entry-macro.S    |   41 ++
 arch/arm/mach-mxs/include/mach/gpio.h           |   35 ++
 arch/arm/mach-mxs/include/mach/hardware.h       |   29 +
 arch/arm/mach-mxs/include/mach/io.h             |   22 +
 arch/arm/mach-mxs/include/mach/iomux-mx23.h     |  355 +++++++++++
 arch/arm/mach-mxs/include/mach/iomux-mx28.h     |  537 +++++++++++++++++
 arch/arm/mach-mxs/include/mach/iomux.h          |  165 +++++
 arch/arm/mach-mxs/include/mach/irqs.h           |   32 +
 arch/arm/mach-mxs/include/mach/memory.h         |   24 +
 arch/arm/mach-mxs/include/mach/mx23.h           |  145 +++++
 arch/arm/mach-mxs/include/mach/mx28.h           |  188 ++++++
 arch/arm/mach-mxs/include/mach/mxs.h            |  105 ++++
 arch/arm/mach-mxs/include/mach/system.h         |   27 +
 arch/arm/mach-mxs/include/mach/timex.h          |   21 +
 arch/arm/mach-mxs/include/mach/uncompress.h     |   76 +++
 arch/arm/mach-mxs/include/mach/vmalloc.h        |   22 +
 arch/arm/mach-mxs/iomux.c                       |  101 ++++
 arch/arm/mach-mxs/mach-mx23evk.c                |   57 ++
 arch/arm/mach-mxs/mach-mx28evk.c                |  138 +++++
 arch/arm/mach-mxs/mm-mx23.c                     |   45 ++
 arch/arm/mach-mxs/mm-mx28.c                     |   45 ++
 arch/arm/mach-mxs/regs-clkctrl-mx23.h           |  455 ++++++++++++++
 arch/arm/mach-mxs/regs-clkctrl-mx28.h           |  663 ++++++++++++++++++++
 arch/arm/mach-mxs/system.c                      |  137 +++++
 arch/arm/mach-mxs/timer.c                       |  296 +++++++++
 48 files changed, 6119 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/Kconfig
 create mode 100644 arch/arm/mach-mxs/Makefile
 create mode 100644 arch/arm/mach-mxs/Makefile.boot
 create mode 100644 arch/arm/mach-mxs/clock-mx23.c
 create mode 100644 arch/arm/mach-mxs/clock-mx28.c
 create mode 100644 arch/arm/mach-mxs/clock.c
 create mode 100644 arch/arm/mach-mxs/devices-mx23.h
 create mode 100644 arch/arm/mach-mxs/devices-mx28.h
 create mode 100644 arch/arm/mach-mxs/devices.c
 create mode 100644 arch/arm/mach-mxs/devices/Kconfig
 create mode 100644 arch/arm/mach-mxs/devices/Makefile
 create mode 100644 arch/arm/mach-mxs/devices/platform-duart.c
 create mode 100644 arch/arm/mach-mxs/devices/platform-fec.c
 create mode 100644 arch/arm/mach-mxs/gpio.c
 create mode 100644 arch/arm/mach-mxs/gpio.h
 create mode 100644 arch/arm/mach-mxs/icoll.c
 create mode 100644 arch/arm/mach-mxs/include/mach/clkdev.h
 create mode 100644 arch/arm/mach-mxs/include/mach/clock.h
 create mode 100644 arch/arm/mach-mxs/include/mach/common.h
 create mode 100644 arch/arm/mach-mxs/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-mxs/include/mach/devices-common.h
 create mode 100644 arch/arm/mach-mxs/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-mxs/include/mach/gpio.h
 create mode 100644 arch/arm/mach-mxs/include/mach/hardware.h
 create mode 100644 arch/arm/mach-mxs/include/mach/io.h
 create mode 100644 arch/arm/mach-mxs/include/mach/iomux-mx23.h
 create mode 100644 arch/arm/mach-mxs/include/mach/iomux-mx28.h
 create mode 100644 arch/arm/mach-mxs/include/mach/iomux.h
 create mode 100644 arch/arm/mach-mxs/include/mach/irqs.h
 create mode 100644 arch/arm/mach-mxs/include/mach/memory.h
 create mode 100644 arch/arm/mach-mxs/include/mach/mx23.h
 create mode 100644 arch/arm/mach-mxs/include/mach/mx28.h
 create mode 100644 arch/arm/mach-mxs/include/mach/mxs.h
 create mode 100644 arch/arm/mach-mxs/include/mach/system.h
 create mode 100644 arch/arm/mach-mxs/include/mach/timex.h
 create mode 100644 arch/arm/mach-mxs/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-mxs/include/mach/vmalloc.h
 create mode 100644 arch/arm/mach-mxs/iomux.c
 create mode 100644 arch/arm/mach-mxs/mach-mx23evk.c
 create mode 100644 arch/arm/mach-mxs/mach-mx28evk.c
 create mode 100644 arch/arm/mach-mxs/mm-mx23.c
 create mode 100644 arch/arm/mach-mxs/mm-mx28.c
 create mode 100644 arch/arm/mach-mxs/regs-clkctrl-mx23.h
 create mode 100644 arch/arm/mach-mxs/regs-clkctrl-mx28.h
 create mode 100644 arch/arm/mach-mxs/system.c
 create mode 100644 arch/arm/mach-mxs/timer.c

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
