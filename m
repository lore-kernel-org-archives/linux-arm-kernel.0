From: thomas.ab@samsung.com (Thomas Abraham)
Date: Thu, 09 Jun 2011 10:08:35 +0530
Subject: [PATCH 0/9] Add clkdev support for Samsung platforms
Message-ID: <1307594324-11053-1-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds clkdev support for all Samsung platforms. clkdev
support is a prerequisite for adding device tree on Samsung platforms
and possibly revive framebuffer driver patches for Exynos4 platforms.

The first of the two patches are for eliminating the explict
console_initcall from the serial drivers. This is required to prevent
the clk_get being invoked at time when device registrations have not
completed.

This patch series is based on the latest
git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git for-next

and the patch "[PATCH] Consolidate the clkdev header files".

It has been tested on the following boards.

SMDK2416, SMDK2440, SMDK2450, SMDK6410, SMDK6440, SMDK6450,
SMDKC100, SMDKV210 and SMDKV310.

Thomas Abraham (9):
  serial: samsung: Fix unintended usage of uart port 0 as console
  serial: Remove redundant console_initcall from s3c and s5p console drivers
  ARM: SAMSUNG: Add clkdev infrastructure
  ARM: S3C24XX: Add clkdev support
  ARM: S3C64XX: Add clkdev support
  ARM: S5P64X0: Add clkdev support
  ARM: S5PC100: Add clkdev support
  ARM: S5PV210: Add clkdev support
  ARM: Exynos4: Add clkdev support

 arch/arm/Kconfig                           |    6 +
 arch/arm/mach-exynos4/clock.c              |  200 +++++++++-------------------
 arch/arm/mach-exynos4/time.c               |    2 +
 arch/arm/mach-s3c2412/clock.c              |   36 +-----
 arch/arm/mach-s3c2416/clock.c              |   10 +-
 arch/arm/mach-s3c2440/clock.c              |    3 -
 arch/arm/mach-s3c2443/clock.c              |   16 +--
 arch/arm/mach-s3c64xx/clock.c              |   86 ++++---------
 arch/arm/mach-s5p64x0/clock-s5p6440.c      |   74 +++--------
 arch/arm/mach-s5p64x0/clock-s5p6450.c      |   68 +++-------
 arch/arm/mach-s5pc100/clock.c              |  163 ++++++-----------------
 arch/arm/mach-s5pv210/clock.c              |  130 ++++++-------------
 arch/arm/plat-s3c24xx/clock-dclk.c         |    4 -
 arch/arm/plat-s3c24xx/s3c2410-clock.c      |   21 +---
 arch/arm/plat-s3c24xx/s3c2443-clock.c      |   39 +-----
 arch/arm/plat-s5p/s5p-time.c               |    9 ++
 arch/arm/plat-samsung/clock.c              |   98 +-------------
 arch/arm/plat-samsung/include/plat/clock.h |    3 +
 arch/arm/plat-samsung/pwm-clock.c          |   10 ++
 arch/arm/plat-samsung/time.c               |    2 +
 drivers/tty/serial/s3c2400.c               |    2 -
 drivers/tty/serial/s3c2410.c               |    2 -
 drivers/tty/serial/s3c2412.c               |    2 -
 drivers/tty/serial/s3c2440.c               |    2 -
 drivers/tty/serial/s3c24a0.c               |    2 -
 drivers/tty/serial/s3c6400.c               |    2 -
 drivers/tty/serial/s5pv210.c               |    7 -
 drivers/tty/serial/samsung.c               |    9 +-
 drivers/tty/serial/samsung.h               |   19 ---
 29 files changed, 271 insertions(+), 756 deletions(-)
