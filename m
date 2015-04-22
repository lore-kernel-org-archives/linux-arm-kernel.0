From: olof@lixom.net (Olof Johansson)
Date: Tue, 21 Apr 2015 23:11:12 -0700
Subject: [GIT PULL 5/9] ARM: SoC driver updates for v4.1
In-Reply-To: <1429683076-19881-1-git-send-email-olof@lixom.net>
References: <1429683076-19881-1-git-send-email-olof@lixom.net>
Message-ID: <1429683076-19881-6-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Driver updates for v4.1. Some of these are for drivers/soc, where we find more
and more SoC-specific drivers these days. Some are for other driver subsystems
where we have received acks from the appropriate maintainers.

The larger parts of this branch are:

- MediaTek support for their PMIC wrapper interface, a high-level interface
for talking to the system PMIC over a dedicated I2C interface.
- Qualcomm SCM driver has been moved to drivers/firmware. It's used for CPU
up/down and needs to be in a shared location for arm/arm64 common code.
- Cleanup of ARM-CCI PMU code.
- Anoter set of cleanusp to the OMAP GPMC code.


Conflicts:
MAINTAINERS:
Add/add, keep both sides.

drivers/bus/Makefile:
Add vs whitespace/sort fixup. Keep superset, realign indentation and sort. 

----------------------------------------------------------------

The following changes since commit 64ad494ec5d7fa1639a884e91e326648015d4bd0:

  Merge tag 'armsoc-dt' into testmerge

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-drivers

for you to fetch changes up to 7415d97ee2b809119270fc3a365968ff8d4f544b:

  Merge tag 'at91-clocksource-driver2' of git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91 into next/drivers

----------------------------------------------------------------

Alexandre Belloni (11):
      ARM: at91/dt: declare atmel,at91rm9200-st as a syscon
      mfd: syscon: Add atmel system timer registers definition
      watchdog: at91rm9200: use the system timer syscon
      watchdog: at91rm9200: implement restart handler
      ARM: at91: at91rm9200: remove deprecated arm_pm_restart
      ARM: at91: properly initialize timer
      ARM: at91: time: move the system timer driver to drivers/clocksource
      clocksource: atmel-st: use syscon/regmap
      clocksource: atmel-st: remove mach/hardware dependency
      ARM: at91: remove useless include
      clocksource: atmel-st: select MFD_SYSCON

Andy Gross (1):
      soc: qcom: gsbi: Add support for ADM CRCI muxing

Arnd Bergmann (3):
      Merge tag 'renesas-simple-pm-bus-for-v4.1' of git://git.kernel.org/.../horms/renesas into next/drivers
      Merge tag 'v4.0-next-soc-fix' of https://github.com/mbgg/linux-mediatek into next/drivers
      Merge tag 'at91-clocksource-driver2' of git://git.kernel.org/.../nferre/linux-at91 into next/drivers

Flora Fu (1):
      soc: mediatek: Add PMIC wrapper for MT8135 and MT8173 SoCs

Geert Uytterhoeven (5):
      drivers: bus: Sort Kconfig entries alphabetically
      drivers: bus: Sort Makefile entries alphabetically
      drivers: bus: Add Simple Power-Managed Bus DT Bindings
      drivers: bus: Add Renesas Bus State Controller (BSC) DT Bindings
      drivers: bus: Add Simple Power-Managed Bus Driver

Kumar Gala (4):
      ARM: qcom: Merge scm and scm boot code together
      ARM: qcom: Cleanup scm interface to only export what is needed
      ARM: qcom: Prep scm code for move to drivers/firmware
      firmware: qcom: scm: Move the scm driver to drivers/firmware

Lina Iyer (3):
      firmware: qcom: scm: Clean cold boot entry to export only the API
      firmware: qcom: scm: Add qcom_scm_set_warm_boot_addr function
      firmware: qcom: scm: Support cpu power down through SCM

Matthias Brugger (1):
      ARM: mediatek: enable the pin controller

Olof Johansson (5):
      Merge tag 'qcom-soc-for-4.1' of git://git.kernel.org/.../galak/linux-qcom into next/drivers
      Merge tag 'at91-cleanup3' of git://git.kernel.org/.../nferre/linux-at91 into next/drivers
      Merge tag 'gpmc-omap-for-v4.1' of git://github.com/rogerq/linux into next/drivers
      Merge tag 'arm-perf-4.1' of git://git.kernel.org/.../will/linux into next/drivers
      Merge tag 'v4.0-next-soc' of https://github.com/mbgg/linux-mediatek into next/drivers

Robert ABEL (8):
      ARM OMAP2+ GPMC: don't undef DEBUG
      ARM OMAP2+ GPMC: add bus children
      ARM OMAP2+ GPMC: fix debug output alignment
      ARM OMAP2+ GPMC: change get_gpmc_timing_reg output for DTS
      ARM OMAP2+ GPMC: always program GPMCFCLKDIVIDER
      ARM OMAP2+ GPMC: calculate GPMCFCLKDIVIDER based on WAITMONITORINGTIME
      ARM OMAP2+ GPMC: fix WAITMONITORINGTIME divider bug
      ARM OMAP2+ GPMC: fix programming/showing reserved timing parameters

Semen Protsenko (2):
      ARM: OMAP2+: gpmc: Fix writing in gpmc_cs_set_memconf
      ARM: OMAP2+: gpmc: make gpmc_cs_get_name() static

Suzuki K. Poulose (6):
      drivers: cci: reject groups spanning multiple HW PMUs
      arm-cci: Rearrange code for splitting PMU vs driver code
      arm-cci: Abstract the CCI400 PMU specific definitions
      arm-cci: Get rid of secure transactions for PMU driver
      arm-cci: Split the code for PMU vs driver support
      arm-cci: Fix CCI PMU event validation

Thierry Reding (1):
      soc/mediatek: Remove unused variables


 .../devicetree/bindings/arm/atmel-at91.txt      |   4 +-
 Documentation/devicetree/bindings/arm/cci.txt   |   7 +-
 .../devicetree/bindings/bus/renesas,bsc.txt     |  46 +
 .../devicetree/bindings/bus/simple-pm-bus.txt   |  44 +
 .../devicetree/bindings/soc/qcom/qcom,gsbi.txt  |  30 +-
 MAINTAINERS                                     |   1 +
 arch/arm/Kconfig                                |   2 +
 arch/arm/boot/dts/at91rm9200.dtsi               |   6 +-
 arch/arm/include/asm/arm-cci.h                  |  42 +
 arch/arm/mach-at91/Kconfig                      |   1 +
 arch/arm/mach-at91/Makefile                     |   2 +-
 arch/arm/mach-at91/at91rm9200.c                 |  19 -
 arch/arm/mach-at91/generic.h                    |   3 -
 arch/arm/mach-at91/include/mach/at91_st.h       |  61 --
 arch/arm/mach-exynos/Kconfig                    |   2 +-
 arch/arm/mach-mediatek/Kconfig                  |   1 +
 arch/arm/mach-omap2/gpmc-nand.c                 |  18 +-
 arch/arm/mach-omap2/gpmc-onenand.c              |   4 +-
 arch/arm/mach-omap2/usb-tusb6010.c              |   4 +-
 arch/arm/mach-qcom/Kconfig                      |   3 -
 arch/arm/mach-qcom/Makefile                     |   3 -
 arch/arm/mach-qcom/platsmp.c                    |  23 +-
 arch/arm/mach-qcom/scm-boot.c                   |  39 -
 arch/arm/mach-qcom/scm-boot.h                   |  26 -
 arch/arm/mach-qcom/scm.c                        | 326 -------
 arch/arm/mach-qcom/scm.h                        |  25 -
 arch/arm/mach-vexpress/Kconfig                  |   4 +-
 arch/arm64/include/asm/arm-cci.h                |  27 +
 drivers/bus/Kconfig                             |  73 +-
 drivers/bus/Makefile                            |  16 +-
 drivers/bus/arm-cci.c                           | 517 +++++-----
 drivers/bus/simple-pm-bus.c                     |  58 ++
 drivers/clocksource/Kconfig                     |   5 +
 drivers/clocksource/Makefile                    |   1 +
 .../clocksource/timer-atmel-st.c                | 117 +--
 drivers/firmware/Kconfig                        |   4 +
 drivers/firmware/Makefile                       |   2 +
 drivers/firmware/qcom_scm.c                     | 494 ++++++++++
 drivers/memory/omap-gpmc.c                      | 358 +++++--
 drivers/soc/Kconfig                             |   1 +
 drivers/soc/Makefile                            |   1 +
 drivers/soc/mediatek/Kconfig                    |  11 +
 drivers/soc/mediatek/Makefile                   |   1 +
 drivers/soc/mediatek/mtk-pmic-wrap.c            | 975 +++++++++++++++++++
 drivers/soc/qcom/Kconfig                        |   1 +
 drivers/soc/qcom/qcom_gsbi.c                    | 152 +++
 drivers/watchdog/Kconfig                        |   2 +-
 drivers/watchdog/at91rm9200_wdt.c               |  61 +-
 include/linux/arm-cci.h                         |   9 +-
 include/linux/mfd/syscon/atmel-st.h             |  49 +
 include/linux/omap-gpmc.h                       |   3 +-
 include/linux/qcom_scm.h                        |  28 +
 52 files changed, 2753 insertions(+), 959 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/renesas,bsc.txt
 create mode 100644 Documentation/devicetree/bindings/bus/simple-pm-bus.txt
 create mode 100644 arch/arm/include/asm/arm-cci.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91_st.h
 delete mode 100644 arch/arm/mach-qcom/scm-boot.c
 delete mode 100644 arch/arm/mach-qcom/scm-boot.h
 delete mode 100644 arch/arm/mach-qcom/scm.c
 delete mode 100644 arch/arm/mach-qcom/scm.h
 create mode 100644 arch/arm64/include/asm/arm-cci.h
 create mode 100644 drivers/bus/simple-pm-bus.c
 rename arch/arm/mach-at91/at91rm9200_time.c => drivers/clocksource/timer-atmel-st.c (73%)
 create mode 100644 drivers/firmware/qcom_scm.c
 create mode 100644 drivers/soc/mediatek/Kconfig
 create mode 100644 drivers/soc/mediatek/Makefile
 create mode 100644 drivers/soc/mediatek/mtk-pmic-wrap.c
 create mode 100644 include/linux/mfd/syscon/atmel-st.h
 create mode 100644 include/linux/qcom_scm.h
