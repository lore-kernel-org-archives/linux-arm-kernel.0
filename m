From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 03 May 2014 15:11:36 +0900
Subject: [PATCH 0/4] Introducing Exynos ChipId driver
Message-ID: <1399097500-4052-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series attempts to get rid of soc_is_exynosXXXX macros
and eventually with the help of this series we can probably get
rid of CONFIG_SOC_EXYNOSXXXX in near future.
Each Exynos SoC has ChipID block which can give information about
SoC's product Id and revision number. Currently we have single
DT binding information for this as "samsung,exynos4210-chipid".
But Exynos4 and Exynos5 SoC series have one small difference in
chip Id, with resepect to product id bit-masks. So it means we
should have separate compatible string for these different series
of SoCs. So I have created new binding information for handling
this difference. Also currently I can think of putting this driver
code under "drivers/misc/" but suggestions are welcome.
Also current form of driver is missing platfrom driver and needs
init function to be called from machine file (either exynos.c or
platsmp.c). I hope lot of suggestions and comments to improve this
further.

This patch series is based on Kukjin Kim's for-next (3.14_rc1 tag)
and prepared on top of following patch series and it's dependent
patch series.

[1]: Map SYSRAM through generic SRAM bindings.
	http://www.spinics.net/lists/arm-kernel/msg327677.html
[2]: Exynos PMU cleanup and refactoring.
	https://lkml.org/lkml/2014/4/30/44

Pankaj Dubey (4):
  ARM: EXYNOS: remove soc_is_exynos4/5 from exynos.c
  ARM:  EXYNOS: remove unused header inclusion from hotplug.c
  misc: exynos-chipid: Add Exynos Chipid driver support
  ARM: EXYNOS: Refactoring to remove soc_is_exynosXXXX macros from
    exynos

 .../bindings/arm/samsung/exynos-chipid.txt         |   15 ++++
 arch/arm/Kconfig                                   |    1 +
 arch/arm/boot/dts/exynos4.dtsi                     |    2 +-
 arch/arm/boot/dts/exynos5.dtsi                     |    2 +-
 arch/arm/mach-exynos/exynos.c                      |   66 ++++++++--------
 arch/arm/mach-exynos/hotplug.c                     |    2 -
 arch/arm/mach-exynos/platsmp.c                     |   10 ++-
 arch/arm/mach-exynos/pm.c                          |   28 +++----
 arch/arm/plat-samsung/include/plat/cpu.h           |   60 --------------
 drivers/clk/samsung/clk-exynos4.c                  |    2 +-
 drivers/cpufreq/exynos-cpufreq.c                   |    9 +--
 drivers/cpufreq/exynos-cpufreq.h                   |    1 -
 drivers/cpufreq/exynos4x12-cpufreq.c               |    5 +-
 drivers/misc/Kconfig                               |    7 ++
 drivers/misc/Makefile                              |    1 +
 drivers/misc/exynos-chipid.c                       |   83 ++++++++++++++++++++
 include/linux/exynos-soc.h                         |   46 +++++++++++
 17 files changed, 215 insertions(+), 125 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/exynos-chipid.txt
 create mode 100644 drivers/misc/exynos-chipid.c
 create mode 100644 include/linux/exynos-soc.h

-- 
1.7.10.4
