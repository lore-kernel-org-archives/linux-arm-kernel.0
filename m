From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 6 Sep 2011 21:22:29 +0200
Subject: [GIT PULL] i.MX features for next
In-Reply-To: <20110826082644.GD7526@pengutronix.de>
References: <20110823115658.GK31404@pengutronix.de>
	<20110826082644.GD7526@pengutronix.de>
Message-ID: <20110906192229.GK28816@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

if I remember correctly you don't mind non-fast-forward updates?! If I'm
wrong just tell me. 

Compared to Sascha's pull request this mail is a reply to, the following
changed:

 - squash a patch by Jason Liu <jason.hui@linaro.org> into
   d27536c6619221528114746317def345467a3e80 fixing a build failure for
   mx25 (1314623624-9999-1-git-send-email-jason.hui at linaro.org)
 - squash a patch by Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
   into 236c4e8be436380b5354fe0d7facf94688e024ec fixing the resource
   size for pata_imx devices (20110827131911.571434313 at rtp-net.org)
 - two new patches:
   "ARM: mx51/efika: Configure esdhc cd/wp on efika mx/sb" and "ARM: mx5: fix clock
   usage for suspend" both by Arnaud Patard.

I choosed to squash the two fixes to ease bisection.
Though the 2nd patch by Arnaud fixes suspend, I think it's not necessary
to go in before v3.1.

So please drop e93aabb and take this instead:

The following changes since commit fcb8ce5cfe30ca9ca5c9a79cdfe26d1993e65e0c:

  Linux 3.1-rc3 (2011-08-22 11:42:53 -0700)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git imx-features

Arnaud Patard (5):
      imx51: add pata device
      imx51: add pata clock
      imx: efika: Enable pata.
      ARM: mx51/efika: Configure esdhc cd/wp on efika mx/sb
      ARM: mx5: fix clock usage for suspend

Dong Aisheng (5):
      ARM: mxs: add saif clock
      ARM: mxs: add saif device
      ARM: mxs: add sgtl5000 i2c device
      ARM: mxs: add mxs-sgtl5000 device
      ARM: mxs: correct the using of frac div for saif

Fabio Estevam (7):
      ARM: imx: pwm: Add support for MX53
      ARM: mx53_loco: Add support for the accelerometer
      ARM: imx: Introduce generic function for displaying silicon revision
      ARM: mach-imx/mx25_3ds: Add FlexCAN support
      ARM: imx: Add PATA resources for other i.MX processors
      ARM: imx: Add PATA clock support
      ARM: imx: Define functions for registering PATA

Jason Liu (6):
      ARM: i.MX: initialize l2x0 at early_init time
      ARM: mx25: Print silicon revision on boot
      ARM: mx27: Print silicon revision on boot
      ARM: mx31: use generic function for displaying silicon revision
      ARM: mx35: use generic function for displaying silicon revision
      ARM: mx5: use generic function for displaying silicon revision

Sascha Hauer (4):
      ARM i.MX: allow to compile together ARMv4 and ARMv5 based SoCs
      ARM i.MX: allow to compile together all i.MX5 based SoCs
      ARM i.MX5: update defconfig
      ARM i.MX defconfigs: use one defconfig for all ARMv4/v5 SoCs

Uwe Kleine-K?nig (1):
      Merge branches 'features/assorted', 'features/imx-cpurev', 'features/imx-pata', 'features/multisoc' and 'features/mxs' into imx-features

Wolfram Sang (3):
      arm: mxs: mx28evk: add fixed regulators for audio
      arm: mach-mxs: add device for rtc
      arm: mach-mxs: add rtc to all boards

 arch/arm/Makefile                                  |    4 +-
 .../{mx27_defconfig => imx_v4_v5_defconfig}        |   68 +++++++++++---
 arch/arm/configs/mx1_defconfig                     |   91 ------------------
 arch/arm/configs/mx21_defconfig                    |   97 --------------------
 arch/arm/configs/{mx51_defconfig => mx5_defconfig} |   60 ++++++++-----
 arch/arm/mach-imx/Kconfig                          |   51 ++++-------
 arch/arm/mach-imx/Makefile                         |    2 +-
 arch/arm/mach-imx/cache-l2x0.c                     |    2 +-
 arch/arm/mach-imx/clock-imx25.c                    |    6 +
 arch/arm/mach-imx/clock-imx27.c                    |    6 +-
 arch/arm/mach-imx/clock-imx31.c                    |    8 +-
 arch/arm/mach-imx/clock-imx35.c                    |    7 +-
 arch/arm/mach-imx/cpu-imx25.c                      |   41 ++++++++
 arch/arm/mach-imx/cpu-imx27.c                      |   28 +++---
 arch/arm/mach-imx/cpu-imx31.c                      |   49 ++++++-----
 arch/arm/mach-imx/cpu-imx35.c                      |   30 +++---
 arch/arm/mach-imx/devices-imx27.h                  |    4 +
 arch/arm/mach-imx/devices-imx31.h                  |    4 +
 arch/arm/mach-imx/devices-imx35.h                  |    4 +
 arch/arm/mach-imx/mach-mx25_3ds.c                  |   10 ++
 arch/arm/mach-mx5/Kconfig                          |   19 +---
 arch/arm/mach-mx5/board-mx51_efikamx.c             |   11 ++-
 arch/arm/mach-mx5/board-mx51_efikasb.c             |   18 ++++-
 arch/arm/mach-mx5/board-mx53_loco.c                |   20 ++++
 arch/arm/mach-mx5/clock-mx51-mx53.c                |   12 ++-
 arch/arm/mach-mx5/cpu.c                            |   74 ++++------------
 arch/arm/mach-mx5/devices-imx51.h                  |    4 +
 arch/arm/mach-mx5/devices-imx53.h                  |    4 +
 arch/arm/mach-mx5/mx51_efika.c                     |    3 +-
 arch/arm/mach-mx5/pm-imx5.c                        |   15 +++-
 arch/arm/mach-mxs/Kconfig                          |    6 +
 arch/arm/mach-mxs/clock-mx28.c                     |    8 +-
 arch/arm/mach-mxs/devices-mx23.h                   |    2 +
 arch/arm/mach-mxs/devices-mx28.h                   |    5 +
 arch/arm/mach-mxs/devices/Kconfig                  |    6 +
 arch/arm/mach-mxs/devices/Makefile                 |    2 +
 arch/arm/mach-mxs/devices/platform-mxs-saif.c      |   60 ++++++++++++
 arch/arm/mach-mxs/devices/platform-rtc-stmp3xxx.c  |   51 ++++++++++
 arch/arm/mach-mxs/include/mach/devices-common.h    |   12 +++
 arch/arm/mach-mxs/mach-mx23evk.c                   |    1 +
 arch/arm/mach-mxs/mach-mx28evk.c                   |   78 ++++++++++++++++
 arch/arm/mach-mxs/mach-stmp378x_devb.c             |    1 +
 arch/arm/mach-mxs/mach-tx28.c                      |    1 +
 arch/arm/plat-mxc/Kconfig                          |   39 ++------
 arch/arm/plat-mxc/cpu.c                            |    9 ++
 arch/arm/plat-mxc/devices/Kconfig                  |    3 +
 arch/arm/plat-mxc/devices/Makefile                 |    1 +
 arch/arm/plat-mxc/devices/platform-pata_imx.c      |   59 ++++++++++++
 arch/arm/plat-mxc/include/mach/common.h            |    1 +
 arch/arm/plat-mxc/include/mach/devices-common.h    |    8 ++
 arch/arm/plat-mxc/include/mach/memory.h            |   16 +---
 arch/arm/plat-mxc/include/mach/mx25.h              |    5 +
 arch/arm/plat-mxc/include/mach/mx35.h              |    2 +-
 arch/arm/plat-mxc/include/mach/mx3x.h              |   18 +---
 arch/arm/plat-mxc/pwm.c                            |    2 +-
 55 files changed, 677 insertions(+), 471 deletions(-)
 rename arch/arm/configs/{mx27_defconfig => imx_v4_v5_defconfig} (69%)
 delete mode 100644 arch/arm/configs/mx1_defconfig
 delete mode 100644 arch/arm/configs/mx21_defconfig
 rename arch/arm/configs/{mx51_defconfig => mx5_defconfig} (82%)
 create mode 100644 arch/arm/mach-imx/cpu-imx25.c
 create mode 100644 arch/arm/mach-mxs/devices/platform-mxs-saif.c
 create mode 100644 arch/arm/mach-mxs/devices/platform-rtc-stmp3xxx.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-pata_imx.c

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
