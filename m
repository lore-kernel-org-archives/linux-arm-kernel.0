From: matthew@mattleach.net (Matthew Leach)
Date: Wed,  8 Jun 2016 19:30:55 +0100
Subject: [RFC PATCH 00/15] Exynos big-endian fixes
Message-ID: <20160608183110.13851-1-matthew@mattleach.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I've been working with Ben Dooks to get a big-endian kernel working on
my Exynos 4412 board.  Primarily this series consists of:

  - Replacing the __raw_{read,write}l accessors, which aren't
    endian-clean, with their respective {read,write}l_relaxed versions
    across various drivers.

  - Adding endian-aware {set,clear}_bit functions to the Exynos serial
    driver as the __{set,clear}_bit() functions aren't endian-clean.

  - Make the low-level Exynos debug printing macros endian-clean.

There may well be other things that are broken under BE that we've not
tested but this series should be enough to allow a board to boot
user-space to a login prompt.

Comments/feedback welcome!

Thanks,
Matt

Ben Dooks (9):
  ARM: exynos: fixup debug macros for big-endian
  ARM: samsung: fixup endian issues in cpu detection
  ARM: EXYNOS: fixups for big-endian operation
  ARM: EXYNOS: fixup endian in pm/pmu
  ARM: EXYNOS: Enable ARCH_SUPPORTS_BIG_ENDIAN explicitly
  irqchip/s3c24xx: fixup IO accessors for big endian
  memory: samsung: endian fixes for IO
  hwrng: exynos - fixup IO accesors
  iommu/exynos: update to use iommu big-endian

Matthew Leach (6):
  clock: exynos: fixup endian in pll clk
  clocksource: samsung_pwm_timer: fix endian accessors
  clk: samsung: exynos4: fixup reg access on be
  irqchip: exynos_combiner: fixup reg access on be
  tty: serial: samsung: fixup accessors for endian
  tty: serial: samsung: add byte-order aware bit functions

 arch/arm/include/debug/samsung.S        |   8 +++
 arch/arm/mach-exynos/Kconfig            |   1 +
 arch/arm/mach-exynos/common.h           |   4 +-
 arch/arm/mach-exynos/firmware.c         |  16 ++---
 arch/arm/mach-exynos/headsmp.S          |   3 +
 arch/arm/mach-exynos/platsmp.c          |   4 +-
 arch/arm/mach-exynos/pm.c               |   4 +-
 arch/arm/mach-exynos/pm_domains.c       |   6 +-
 arch/arm/plat-samsung/cpu.c             |   8 +--
 drivers/char/hw_random/exynos-rng.c     |   4 +-
 drivers/clk/samsung/clk-exynos4.c       |   4 +-
 drivers/clk/samsung/clk-pll.c           | 122 ++++++++++++++++----------------
 drivers/clocksource/samsung_pwm_timer.c |  16 ++---
 drivers/iommu/exynos-iommu.c            |   6 +-
 drivers/irqchip/exynos-combiner.c       |  14 ++--
 drivers/irqchip/irq-s3c24xx.c           |  36 +++++-----
 drivers/memory/samsung/exynos-srom.c    |   6 +-
 drivers/tty/serial/samsung.c            |  16 ++---
 drivers/tty/serial/samsung.h            |  33 ++++++++-
 19 files changed, 177 insertions(+), 134 deletions(-)

-- 
2.8.3
