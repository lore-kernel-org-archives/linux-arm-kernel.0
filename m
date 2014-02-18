From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 18 Feb 2014 22:37:36 +0100
Subject: [GIT PULL v2] get rid of <mach/timex.h>
Message-ID: <20140218213736.GA6988@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

the following changes since commit 6a79799d5654bb7800614e8b7a009252be7ff90e:

  ARM: u300: fix timekeeping when periodic mode is used (2013-11-26 21:00:21 +0100)

(which is v3.13-rc1 + 3 commits that were merged into 3.14-rc1)
are available in the git repository at:

  git://git.pengutronix.de/git/ukl/linux.git tags/dropmachtimexh-v2

for you to fetch changes up to fb3174e4ad2427c6ad90c67093d6ca97f13e8672:

  ARM: ixp4xx: fix timer latch calculation (2014-02-18 21:23:19 +0100)

----------------------------------------------------------------
This cleanup series gets rid of <mach/timex.h> for platforms not using
ARCH_MULTIPLATFORM. (For multi-platform code it's already unused since
387798b (ARM: initial multiplatform support).)

To make this work some code out of arch/arm needed to be adapted. The
respective changes got acks by their maintainers to be taken via armsoc
(with Andrew Morton substituting for Alessandro Zummo as rtc maintainer).

Compared to the previous pull request there was another patch added that
fixes a (non-critical) regression on ixp4xx. Olof Johansson asked to not
squash this fix into the original commit to save him from the need to
reverify the series.

----------------------------------------------------------------

The series still creates the same merge conflicts when being pulled into
linus/master. See
http://git.pengutronix.de/?p=ukl/linux.git;a=commitdiff;h=dropmachtimexh-merged
for how I resolved for the first pull request.

It would be great to get this merged into v3.15-rc1.

Thanks
Uwe

Linus Walleij (1):
      ARM/serial: at91: switch atmel serial to use gpiolib

Uwe Kleine-K?nig (13):
      rtc: at91sam9: include <mach/hardware.h> explicitly
      rtc: pxa: drop unused #define TIMER_FREQ
      clocksource: sirf/marco+prima2: drop usage of CLOCK_TICK_RATE
      ARM: sa1100: stop using mach/timex.h
      ARM: netx: stop using mach/timex.h
      ARM: mmp: stop using mach/timex.h
      ARM: ep93xx: stop using mach/timex.h
      ARM: at91: don't use <mach/timex.h>
      input: ixp4xx-beeper: don't use symbols from <mach/timex.h>
      ARM: ixp4xx: stop using <mach/timex.h>
      ARM: rpc: stop using <mach/timex.h>
      ARM: drop <mach/timex.h> for !ARCH_MULTIPLATFORM, too
      ARM: ixp4xx: fix timer latch calculation

 .../devicetree/bindings/serial/atmel-usart.txt     |  3 ++
 arch/arm/include/asm/timex.h                       |  6 ---
 arch/arm/mach-at91/at91rm9200.c                    |  1 +
 arch/arm/mach-at91/at91rm9200_devices.c            | 11 ++++-
 arch/arm/mach-at91/at91rm9200_time.c               |  1 +
 arch/arm/mach-at91/at91sam9260.c                   |  1 +
 arch/arm/mach-at91/at91sam9260_devices.c           |  8 ++++
 arch/arm/mach-at91/at91sam9261.c                   |  1 +
 arch/arm/mach-at91/at91sam9261_devices.c           |  5 +++
 arch/arm/mach-at91/at91sam9263.c                   |  1 +
 arch/arm/mach-at91/at91sam9263_devices.c           |  5 +++
 arch/arm/mach-at91/at91sam926x_time.c              |  1 +
 arch/arm/mach-at91/at91sam9g45.c                   |  1 +
 arch/arm/mach-at91/at91sam9g45_devices.c           |  6 +++
 arch/arm/mach-at91/at91sam9rl.c                    |  1 +
 arch/arm/mach-at91/at91sam9rl_devices.c            |  6 +++
 arch/arm/mach-at91/at91x40.c                       |  2 +-
 arch/arm/mach-at91/at91x40_time.c                  |  1 +
 arch/arm/mach-at91/board-gsia18s.c                 |  1 +
 arch/arm/mach-at91/board-pcontrol-g20.c            |  1 +
 arch/arm/mach-at91/board-stamp9g20.c               |  1 +
 arch/arm/mach-at91/include/mach/at91x40.h          |  2 +
 arch/arm/mach-at91/include/mach/timex.h            | 37 ----------------
 arch/arm/mach-at91/pm.c                            |  1 +
 arch/arm/mach-clps711x/include/mach/timex.h        |  2 -
 arch/arm/mach-davinci/include/mach/timex.h         | 22 ----------
 arch/arm/mach-dove/include/mach/timex.h            |  9 ----
 arch/arm/mach-ebsa110/include/mach/timex.h         | 19 ---------
 arch/arm/mach-ep93xx/core.c                        |  2 +-
 arch/arm/mach-ep93xx/include/mach/timex.h          |  5 ---
 arch/arm/mach-exynos/include/mach/timex.h          | 29 -------------
 arch/arm/mach-footbridge/include/mach/timex.h      | 18 --------
 arch/arm/mach-gemini/include/mach/timex.h          | 13 ------
 arch/arm/mach-integrator/include/mach/timex.h      | 26 ------------
 arch/arm/mach-iop13xx/include/mach/timex.h         |  1 -
 arch/arm/mach-iop32x/include/mach/timex.h          |  6 ---
 arch/arm/mach-iop33x/include/mach/timex.h          |  6 ---
 arch/arm/mach-ixp4xx/common.c                      | 14 ++++++-
 arch/arm/mach-ixp4xx/include/mach/timex.h          | 16 -------
 arch/arm/mach-kirkwood/include/mach/timex.h        | 10 -----
 arch/arm/mach-ks8695/include/mach/timex.h          | 21 ----------
 arch/arm/mach-lpc32xx/include/mach/timex.h         | 28 -------------
 arch/arm/mach-mmp/include/mach/timex.h             | 13 ------
 arch/arm/mach-mmp/time.c                           | 12 ++++--
 arch/arm/mach-msm/include/mach/timex.h             | 21 ----------
 arch/arm/mach-mv78xx0/include/mach/timex.h         |  9 ----
 arch/arm/mach-netx/include/mach/timex.h            | 20 ---------
 arch/arm/mach-netx/time.c                          | 11 +++--
 arch/arm/mach-omap1/include/mach/timex.h           |  5 ---
 arch/arm/mach-omap2/include/mach/timex.h           |  5 ---
 arch/arm/mach-orion5x/include/mach/timex.h         | 11 -----
 arch/arm/mach-pxa/include/mach/timex.h             | 34 ---------------
 arch/arm/mach-realview/include/mach/timex.h        | 23 ----------
 arch/arm/mach-rpc/include/mach/timex.h             | 17 --------
 arch/arm/mach-rpc/time.c                           | 15 ++++---
 arch/arm/mach-s3c24xx/include/mach/timex.h         | 24 -----------
 arch/arm/mach-s3c64xx/include/mach/timex.h         | 24 -----------
 arch/arm/mach-s5p64x0/include/mach/timex.h         | 27 ------------
 arch/arm/mach-s5pc100/include/mach/timex.h         | 24 -----------
 arch/arm/mach-s5pv210/include/mach/timex.h         | 29 -------------
 arch/arm/mach-sa1100/include/mach/timex.h          | 12 ------
 arch/arm/mach-sa1100/time.c                        |  8 +++-
 arch/arm/mach-shmobile/include/mach/timex.h        |  6 ---
 arch/arm/mach-spear/include/mach/timex.h           | 19 ---------
 arch/arm/mach-versatile/include/mach/timex.h       | 23 ----------
 arch/arm/mach-w90x900/include/mach/timex.h         | 25 -----------
 arch/arm/plat-omap/include/plat/timex.h            | 33 ---------------
 drivers/clocksource/timer-marco.c                  | 13 +++---
 drivers/clocksource/timer-prima2.c                 | 16 ++++---
 drivers/input/misc/ixp4xx-beeper.c                 |  2 +-
 drivers/rtc/rtc-at91sam9.c                         |  2 +-
 drivers/rtc/rtc-pxa.c                              |  1 -
 drivers/tty/serial/atmel_serial.c                  | 49 ++++++++++++++--------
 include/linux/platform_data/atmel.h                |  1 +
 74 files changed, 153 insertions(+), 732 deletions(-)
 delete mode 100644 arch/arm/mach-at91/include/mach/timex.h
 delete mode 100644 arch/arm/mach-clps711x/include/mach/timex.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/timex.h
 delete mode 100644 arch/arm/mach-dove/include/mach/timex.h
 delete mode 100644 arch/arm/mach-ebsa110/include/mach/timex.h
 delete mode 100644 arch/arm/mach-ep93xx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-exynos/include/mach/timex.h
 delete mode 100644 arch/arm/mach-footbridge/include/mach/timex.h
 delete mode 100644 arch/arm/mach-gemini/include/mach/timex.h
 delete mode 100644 arch/arm/mach-integrator/include/mach/timex.h
 delete mode 100644 arch/arm/mach-iop13xx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-iop32x/include/mach/timex.h
 delete mode 100644 arch/arm/mach-iop33x/include/mach/timex.h
 delete mode 100644 arch/arm/mach-ixp4xx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/timex.h
 delete mode 100644 arch/arm/mach-ks8695/include/mach/timex.h
 delete mode 100644 arch/arm/mach-lpc32xx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-mmp/include/mach/timex.h
 delete mode 100644 arch/arm/mach-msm/include/mach/timex.h
 delete mode 100644 arch/arm/mach-mv78xx0/include/mach/timex.h
 delete mode 100644 arch/arm/mach-netx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-omap1/include/mach/timex.h
 delete mode 100644 arch/arm/mach-omap2/include/mach/timex.h
 delete mode 100644 arch/arm/mach-orion5x/include/mach/timex.h
 delete mode 100644 arch/arm/mach-pxa/include/mach/timex.h
 delete mode 100644 arch/arm/mach-realview/include/mach/timex.h
 delete mode 100644 arch/arm/mach-rpc/include/mach/timex.h
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-s5p64x0/include/mach/timex.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/timex.h
 delete mode 100644 arch/arm/mach-s5pv210/include/mach/timex.h
 delete mode 100644 arch/arm/mach-sa1100/include/mach/timex.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/timex.h
 delete mode 100644 arch/arm/mach-spear/include/mach/timex.h
 delete mode 100644 arch/arm/mach-versatile/include/mach/timex.h
 delete mode 100644 arch/arm/mach-w90x900/include/mach/timex.h
 delete mode 100644 arch/arm/plat-omap/include/plat/timex.h

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
