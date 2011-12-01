From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Thu, 01 Dec 2011 18:05:13 +0900
Subject: [PATCH 0/4] PM/Devfreq: Exynos4210 Bus/VDD_int
Message-ID: <1322730317-8171-1-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds DVFS (Dynamic Voltage and Frequency Scaling)
capability to Exynos4210 memory-bus and vdd_int of the SoC.

The Exynos4210 Bus Devfreq driver uses PPMU counters of memory
controllers (DMC0/DMC1 of Exynos4210), and adjusts OPP based on
the current load.

In other to support Exynos4210-bus devfreq driver (patch 2/4),
we have added patches:
1/4: Enable DMC1, Enable PPMU for DMC0/1.
3/4: Remove compiler errors in Exynos4-Nuri board (Nuri is the
test board for this driver)
4/4: Add Exynos4210-bus devfreq device to Nuri board.

Note that any Exynos4210 board may add this capability by adding
the platform device "exynos4210-busfreq" and provide a regulator
(VDD_INT) to the added device.

ASV (Adaptive Supply Voltage) capability has been introduced in
the ARM-kernel mailing list. However, it has not been merged, yet.
Thus, the device driver (exynos4210_memorybus.c) has a symbol
"CONFIG_EXYNOS4_ASV" to block ASV-related code.
With support of ASV, this devfreq driver reduces power consumption
futher; most Exynos4210 SoCs have lower voltage requirement than
the worst case (ASV number 0) scenario.

MyungJoo Ham (4):
  ARM: EXYNOS4: Add DMC1, allow PPMU access for DMC.
  PM/Devfreq: Add Exynos4210-bus device DVFS driver.
  ARM Exynos4210-Nuri: remove compiler errors
  ARM Exynos4210-Nuri: support Exynos4210-bus Devfreq driver.

 arch/arm/mach-exynos/cpu.c              |    7 +-
 arch/arm/mach-exynos/include/mach/map.h |    1 +
 arch/arm/mach-exynos/mach-nuri.c        |   13 +-
 drivers/devfreq/Kconfig                 |   12 +
 drivers/devfreq/Makefile                |    3 +
 drivers/devfreq/exynos4210_memorybus.c  |  636 +++++++++++++++++++++++++++++++
 6 files changed, 668 insertions(+), 4 deletions(-)
 create mode 100644 drivers/devfreq/exynos4210_memorybus.c

-- 
1.7.4.1
