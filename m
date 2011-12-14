From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Wed, 14 Dec 2011 20:28:41 +0900
Subject: [PATCH v2 0/4] PM/Devfreq: Exynos4 bus frequency, vdd_int, and vdd_mif
Message-ID: <1323862125-10699-1-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds DVFS (Dynamic Voltage and Frequency Scaling)
capability to the following three Exynos4 SoCs.
Exynos4210: memory-bus and vdd_int.
Exynos4212: memory-bus and vdd_int/vdd_mif.
Exynos4412: memory-bus and vdd_int/vdd_mif.

The Exynos4 bus devfreq driver uses PPMU counters of memory
controllers (DMC0/DMC1 of Exynos4), and adjusts OPP based on
the current load.

In other to support Exynos4 bus devfreq driver (patch 3/4),
we have added patches:
1/4: Enable DMC1, Enable PPMU for DMC0/1.
2/4: Add register information for Exynos4212/4412 support.
3/4: The Exynos4 bus devfreq driver.
4/4: Add Exynos4210-bus devfreq device to Nuri board.

Note that any Exynos4210 board may add this capability by adding
the platform device "exynos4210-busfreq" and provide a regulator
(VDD_INT) to the added device.

For Exynos4212 boards, the device name is "exynos4212-busfreq" and
for Exynos4412 boards, the device name is "exynos4412-busfreq".

This device driver has been tested in Exynos4210-NURI board and
an Exynos4412 board, which is not upstreamed, yet. Because
Exynos4212 and 4412 are supposed not to have any differences
in this part, Exynos4212 was not tested.

ASV (Adaptive Supply Voltage) capability has been introduced in
the ARM-kernel mailing list. However, it has not been merged, yet.
Thus, the device driver (exynos4_bus.c) has a symbol
"CONFIG_EXYNOS4_ASV" to block ASV-related code.
With support of ASV, this devfreq driver reduces power consumption
futher; most Exynos4210 SoCs have lower voltage requirement than
the worst case (ASV number 0) scenario.

MyungJoo Ham (4):
  ARM: EXYNOS4: Add DMC1, allow PPMU access for DMC.
  ARM: EXYNOS4: Add clock register addresses for Exynos4x12 bus devfreq
    driver
  PM/Devfreq: Add Exynos4-bus device DVFS driver for
    Exynos4210/4212/4412.
  ARM Exynos4210-Nuri: support Exynos4210-bus Devfreq driver.

 arch/arm/mach-exynos/cpu.c                     |    7 +-
 arch/arm/mach-exynos/include/mach/map.h        |    1 +
 arch/arm/mach-exynos/include/mach/regs-clock.h |   42 +
 arch/arm/mach-exynos/mach-nuri.c               |   11 +-
 drivers/devfreq/Kconfig                        |   13 +
 drivers/devfreq/Makefile                       |    3 +
 drivers/devfreq/exynos4_bus.c                  | 1135 ++++++++++++++++++++++++
 7 files changed, 1208 insertions(+), 4 deletions(-)
 create mode 100644 drivers/devfreq/exynos4_bus.c

-- 
1.7.4.1
