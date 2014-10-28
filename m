From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 28 Oct 2014 11:00:57 +0900
Subject: [GIT PULL 2/3 v2] 1st Round of Samsung PM updates for v3.19
Message-ID: <021801cff253$0374fe40$0a5efac0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm sending new pull-request for tags/samsung-pm-v2 instead of tags/samsung-pm.
Note that just added "fix build with ARM_CPU_SUSPEND=n" from Arnd, please pull.

Thanks,
Kukjin

------------

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git tags/samsung-pm-v2

for you to fetch changes up to 5d184e4fb69a9ca64c4ab75c470fd60a2f466160:

  Merge branch 'v3.19-next/pm-samsung-2' into for-next (2014-10-28 08:10:55 +0900)

----------------------------------------------------------------

Samsung PM (v2) updates for v3.19

- added fix build with ARM_CPU_SUSPEND=n based on previous
  tags/samsung-pm

- Refactor the pm code to use DT based lookup instead of
  using "soc_is_exynosxxxx"

- Firmware supporting suspend and resume to excute of low
  level operations to enter and leave power mode for exynos
  : introduce suspend() and resume() firmware operations

- Fix AFTR mode on boards with secure firmware enabled and
  allows exynos cpuidle driver usage on exynos4x12 SoCs

- Fix build with PM_SLEEP=n and ARM_EXYNOS_CPUIDLE=y

- SWRESET is needed to boot secondary CPU on exynos3250

----------------------------------------------------------------
Andreas Faerber (8):
      ARM: dts: Prepare node labels for exynos5250
      ARM: dts: Clean up exynos5250-snow
      ARM: dts: Fill in bootargs for exynos5250-snow
      ARM: dts: Clean up exynos5250-smdk5250
      ARM: dts: Clean up exynos5250-arndale
      ARM: dts: Fix apparent GPIO typo in exynos5250-arndale
      ARM: dts: Simplify USB3503 on exynos5250-arndale
      ARM: dts: Add exynos5250-spring device tree

Arnd Bergmann (1):
      ARM: EXYNOS: Fix build with ARM_CPU_SUSPEND=n

Bartlomiej Zolnierkiewicz (7):
      ARM: EXYNOS: replace EXYNOS_BOOT_VECTOR_* macros by static inlines
      ARM: firmware: add AFTR mode support to firmware do_idle method
      ARM: EXYNOS: add secure firmware support to AFTR mode code
      ARM: EXYNOS: fix register setup for AFTR mode code
      ARM: EXYNOS: allow driver usage on Exynos4x12 SoCs
      ARM: EXYNOS: Fix build with PM_SLEEP=n and ARM_EXYNOS_CPUIDLE=y
      ARM: dts: add CPU nodes for Exynos4 SoCs

Jacek Anaszewski (1):
      ARM: dts: add MFC codec device node for exynos3250

Javier Martinez Canillas (2):
      ARM: dts: Add rtc_src clk for s3c-rtc on exynos Peach boards
      ARM: dts: Add rtc_src clk for s3c-rtc on exynos5250-snow

Krzysztof Kozlowski (5):
      ARM: EXYNOS: Move code from hotplug.c to platsmp.c
      ARM: EXYNOS: Remove unneeded __ref annotation for cpu_die function
      ARM: EXYNOS: Fix CPU idle clock down after CPU off
      ARM: EXYNOS: SWRESET is needed to boot secondary CPU on exynos3250
      ARM: dts: Add Maxim 77693 PMIC to exynos4412-trats2

Kukjin Kim (3):
      Merge branch 'v3.19-next/pm-samsung' into for-next
      Merge branch 'v3.19-next/dt-samsung' into for-next
      Merge branch 'v3.19-next/pm-samsung-2' into for-next

Naveen Krishna Chatradhi (1):
      ARM: dts: correct the mmc0 capability string for exynos Peach boards

Tomasz Figa (6):
      ARM: firmware: Introduce suspend and resume operations
      ARM: EXYNOS: Add support for firmware-assisted suspend/resume
      ARM: dts: Enable PWM node by default for s3c64xx
      ARM: dts: Keep eMMC regulators soft-disabled for exynos4412-trats2
      ARM: dts: Add utility macro to define pin sleep states for exynos4x12-pinctrl
      ARM: dts: Add sleep mode pin configuration for exynos4412-trats2

Vikas Sajjan (2):
      ARM: EXYNOS: Move Disabling of JPEG USE_RETENTION for exynos5250 to pmu.c
      ARM: EXYNOS: Refactor the pm code to use DT based lookup

 Documentation/arm/firmware.txt             |  28 +-
 arch/arm/boot/dts/Makefile                 |   1 +
 arch/arm/boot/dts/exynos3250.dtsi          |  10 +
 arch/arm/boot/dts/exynos4210.dtsi          |  17 +
 arch/arm/boot/dts/exynos4212.dtsi          |  17 +
 arch/arm/boot/dts/exynos4412-trats2.dts    | 352 ++++++++++-
 arch/arm/boot/dts/exynos4412.dtsi          |  29 +
 arch/arm/boot/dts/exynos4x12-pinctrl.dtsi  |  16 +
 arch/arm/boot/dts/exynos5250-arndale.dts   | 907 ++++++++++++++---------------
 arch/arm/boot/dts/exynos5250-smdk5250.dts  | 618 ++++++++++----------
 arch/arm/boot/dts/exynos5250-snow.dts      | 266 ++++-----
 arch/arm/boot/dts/exynos5250-spring.dts    | 536 +++++++++++++++++
 arch/arm/boot/dts/exynos5250.dtsi          |  16 +-
 arch/arm/boot/dts/exynos5420-peach-pit.dts |   7 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts  |   7 +-
 arch/arm/boot/dts/s3c6410-mini6410.dts     |   4 -
 arch/arm/boot/dts/s3c64xx.dtsi             |   1 -
 arch/arm/include/asm/firmware.h            |  10 +-
 arch/arm/mach-exynos/Kconfig               |   5 +
 arch/arm/mach-exynos/Makefile              |   7 +-
 arch/arm/mach-exynos/common.h              |  15 +-
 arch/arm/mach-exynos/exynos.c              |   5 +-
 arch/arm/mach-exynos/firmware.c            |  67 ++-
 arch/arm/mach-exynos/hotplug.c             |  91 ---
 arch/arm/mach-exynos/platsmp.c             | 136 +++++
 arch/arm/mach-exynos/pm.c                  | 310 ++--------
 arch/arm/mach-exynos/pmu.c                 |   1 +
 arch/arm/mach-exynos/regs-pmu.h            |   6 +
 arch/arm/mach-exynos/sleep.S               |  28 +
 arch/arm/mach-exynos/smc.h                 |   4 +
 arch/arm/mach-exynos/suspend.c             | 356 +++++++++++
 arch/arm/mach-tegra/cpuidle-tegra114.c     |   2 +-
 arch/arm/plat-samsung/Makefile             |   1 +
 33 files changed, 2565 insertions(+), 1311 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos5250-spring.dts
 delete mode 100644 arch/arm/mach-exynos/hotplug.c
 create mode 100644 arch/arm/mach-exynos/suspend.c
