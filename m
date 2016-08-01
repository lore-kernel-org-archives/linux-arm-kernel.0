From: olof@lixom.net (Olof Johansson)
Date: Mon,  1 Aug 2016 14:39:26 -0700
Subject: [GIT PULL 5/7] ARM: SoC driver updates for v4.8
In-Reply-To: <1470087568-4222-1-git-send-email-olof@lixom.net>
References: <1470087568-4222-1-git-send-email-olof@lixom.net>
Message-ID: <1470087568-4222-6-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Driver updates for ARM SoCs.

A slew of changes this release cycle. The reset driver tree, that we merge
through arm-soc for historical reasons, is also sizable this time around.

Among the changes:

- clps711x: Treewide changes to compatible strings, merged here for simplicity.
- Qualcomm: SCM firmware driver cleanups, move to platform driver
- ux500: Major cleanups, removal of old mach-specific infrastructure.
- Atmel external bus memory driver
- Move of brcmstb platform to the rest of bcm
- PMC driver updates for tegra, various fixes and improvements
- Samsung platform driver updates to support 64-bit Exynos platforms
- Reset controller cleanups moving to devm_reset_controller_register() APIs
- Reset controller driver for Amlogic Meson
- Reset controller driver for Hisilicon hi6220
- ARM SCPI power domain support



Conflicts:

arch/arm/mach-exynos/Kconfig:
Add/add. Keep both sides. Feel free to fix sorting.

drivers/soc/samsung/pm_domains.c:
Conflict between *_relaxed() changes and
INT_LOCAL_PWR_EN->pd->local_pwr_cfg changes. Keep the *relaxed version
but replace INT_LOCAL_PWR_EN with the variable.

----------------------------------------------------------------

The following changes since commit fa8fc918c695d84b6f14a940ac7b7eac779bcef5:

  Merge branch 'next/defconfig' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-drivers

for you to fetch changes up to f8c6d88b2c874295f49b9ad1ca0826b9a8ef3180:

  Merge tag 'samsung-drivers-4.8-3' of git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into next/drivers

----------------------------------------------------------------

Alexander Shiyan (7):
      clk: clps711x: Changing the compatibility string to match with the smallest supported chip
      clocksource: clps711x: Changing the compatibility string to match with the smallest supported chip
      irqchip: clps711x: Changing the compatibility string to match with the smallest supported chip
      serial: clps711x: Changing the compatibility string to match with the smallest supported chip
      pwm: clps711x: Changing the compatibility string to match with the smallest supported chip
      input: clps711x-keypad: Changing the compatibility string to match with the smallest supported chip
      video: clps711x-fb: Changing the compatibility string to match with the smallest supported chip

Amitoj Kaur Chawla (2):
      memory: tegra: tegra124-emc: Add missing of_node_put()
      memory: tegra: mc: Add missing of_node_put()

Andrew F. Davis (2):
      Documentation: dt: reset: Add TI syscon reset binding
      reset: add TI SYSCON based reset driver

Andy Gross (7):
      firmware: qcom: scm: Convert SCM to platform driver
      firmware: qcom: scm: Use atomic SCM for cold boot
      firmware: qcom: scm: Generalize shared error map
      firmware: qcom: scm: Convert to streaming DMA APIS
      Merge tag 'qcom-drivers-for-4.8' into HEAD
      firmware: qcom_scm: Add missing is_available API
      firmware: qcom: scm: Change initcall to subsys

Arnd Bergmann (19):
      Merge tag 'reset-for-4.8-3' of git://git.pengutronix.de/git/pza/linux into next/drivers
      Merge tag 'omap-for-v4.8/ir-rx51-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/drivers
      firmware: scpi: add CONFIG_OF dependency
      soc: raspberrypi-power: add CONFIG_OF dependency
      Merge tag 'arm-soc/for-4.8/maintainers-part2' of http://github.com/Broadcom/stblinux into next/drivers
      ARM: ux500: remove unused regulator data
      ARM: ux500: move ab8500_regulator_plat_data into driver
      ASoC: ab8500-codec: remove platform data based probe
      mfd: db8500 stop passing around platform data
      ARM: ux500: move l2x0 init to .init_irq
      ARM: ux500: use CLK_OF_DECLARE()
      ARM: ux500: remove cpu_is_u* helpers
      ARM: ux500: consolidate soc_device code in id.c
      ARM: ux500: call ux500_setup_id later
      ARM: ux500: move soc_id driver to drivers/soc
      ARM: ux500: consolidate base platform files
      Merge tag 'qcom-drivers-for-4.8-2' of git://git.kernel.org/.../agross/linux into next/drivers
      Merge tag 'ux500-cleanup-bundle' of git://git.kernel.org/.../linusw/linux-stericsson into next/drivers
      Merge tag 'samsung-drivers-4.8-3' of git://git.kernel.org/.../krzk/linux into next/drivers

Ben Dooks (3):
      soc: brcmstb: fix warning from missing include
      memory: samsung: endian fixes for IO
      cpufreq: s5pv210: use relaxed IO accesors

Bjorn Andersson (6):
      soc: qcom: wcnss_ctrl: Make wcnss_ctrl parent the other components
      soc: qcom: smp2p: Correct addressing of outgoing value
      soc: qcom: smp2p: Drop io-accessors
      soc: qcom: Update properties for smem state referencing
      firmware: qcom: scm: Peripheral Authentication Service
      firmware: qcom: scm: Expose PAS command 10 as reset-controller

Boris Brezillon (2):
      memory: add Atmel EBI (External Bus Interface) driver
      memory: atmel-ebi: add DT bindings documentation

Chen Feng (1):
      reset: hisilicon: Change to syscon register access

Chris Brand (1):
      power: Introduce Broadcom kona reset driver

Florian Fainelli (1):
      soc: Move brcmstb to bcm/brcmstb

Geert Uytterhoeven (1):
      MAINTAINERS: Add file patterns for qcom device tree bindings

Ivaylo Dimitrov (5):
      ir-rx51: Fix build after multiarch changes broke it
      pwm: omap-dmtimer: Allow for setting dmtimer clock source
      ir-rx51: use PWM framework instead of OMAP dmtimer
      ir-rx51: add DT support to driver
      ir-rx51: use hrtimer instead of dmtimer

John Youn (1):
      reset: Return -ENOTSUPP when not configured

Jon Hunter (12):
      soc/tegra: pmc: Initialise resets associated with a power partition
      soc/tegra: pmc: Ensure powergate is available when powering on
      soc/tegra: pmc: Fix early initialisation of PMC
      soc/tegra: pmc: Don't populate SoC data until register space is mapped
      soc/tegra: pmc: Ensure mutex is always initialised
      soc/tegra: pmc: Add missing of_node_put()
      soc/tegra: pmc: Don't probe PMC if early initialisation fails
      soc/tegra: pmc: Add specific error messages
      soc/tegra: pmc: Initialise power partitions early
      soc/tegra: pmc: Enable XUSB partitions on boot
      dt-bindings: bus: Add documentation for Tegra210 ACONNECT
      bus: Add support for Tegra ACONNECT

Julia Lawall (1):
      memory: tegra: Delete unneeded of_node_put()

Krzysztof Kozlowski (5):
      ARM: EXYNOS: Move pm_domains driver to drivers/soc/samsung
      soc: samsung: pm_domains: Prepare for supporting ARMv8 Exynos
      soc: samsung: pm_domains: Enable COMPILE_TEST for build coverage
      Merge branch 'for-v4.8/media/exynos-mfc' of git://linuxtv.org/snawrocki/samsung into for-v4.8/exynos-mfc
      soc: samsung: pmu: Constify arrays with PMU data

Kumar Gala (1):
      firmware: qcom: scm: Add support for ARM64 SoCs

Marek Szyprowski (3):
      ARM: EXYNOS: Remove code for MFC custom reserved memory handling
      ARM: dts: exynos: Convert MFC device to generic reserved memory bindings
      ARM: dts: exynos: Enable MFC device on Exynos4412 Odroid boards

Masahiro Yamada (7):
      reset: add devm_reset_controller_register API
      reset: ath79: use devm_reset_controller_register()
      reset: pistachio: use devm_reset_controller_register()
      reset: sunxi: use devm_reset_controller_register()
      reset: socfpga: use devm_reset_controller_register()
      reset: zynq: use devm_reset_controller_register()
      reset: fix Kconfig menu to include reset drivers in sub-menu

Neil Armstrong (3):
      reset: oxnas: Use devm register API and get rid of platform remove
      reset: Add support for the Amlogic Meson SoC Reset Controller
      dt-bindings: reset: Add bindings for the Meson SoC Reset Controller

Olof Johansson (16):
      Merge tag 'reset-for-4.8' of git://git.pengutronix.de/git/pza/linux into next/drivers
      Merge tag 'samsung-drivers-4.8' of git://git.kernel.org/.../krzk/linux into next/drivers
      Merge tag 'renesas-rcar-sysc-for-v4.8' of git://git.kernel.org/.../horms/renesas into next/drivers
      Merge tag 'at91-ab-4.8-drivers' of git://git.kernel.org/.../abelloni/linux into next/drivers
      Merge tag 'reset-for-4.8-2' of git://git.pengutronix.de/git/pza/linux into next/drivers
      Merge tag 'samsung-drivers-exynos-mfc-4.8' of git://git.kernel.org/.../krzk/linux into next/drivers
      Merge tag 'arm-soc/for-4.8/drivers' of http://github.com/Broadcom/stblinux into next/drivers
      Merge tag 'at91-ab-4.8-drivers2' of git://git.kernel.org/.../abelloni/linux into next/drivers
      Merge tag 'scpi-updates-4.8' of git://git.kernel.org/.../sudeep.holla/linux into next/drivers
      Merge tag 'gpmc-omap-for-v4.8' of https://github.com/rogerq/linux into next/drivers
      Merge tag 'qcom-drivers-for-4.8' of git://git.kernel.org/.../agross/linux into next/drivers
      Merge tag 'samsung-drivers-4.8-2' of git://git.kernel.org/.../krzk/linux into next/drivers
      Merge tag 'renesas-rcar-sysc2-for-v4.8' of git://git.kernel.org/.../horms/renesas into next/drivers
      Merge tag 'tegra-for-4.8-bus' of git://git.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'tegra-for-4.8-memory' of git://git.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'tegra-for-4.8-soc' of git://git.kernel.org/.../tegra/linux into next/drivers

Paul Gortmaker (4):
      memory: omap-gpmc: make it explicitly non-modular
      memory: samsung: exynos-srom: make it explicitly non-modular
      memory: atmel-sdramc: make it explicitly non-modular
      memory: atmel-ebi: make it explicitly non-modular

Philipp Zabel (1):
      Merge branch 'reset/explicit-api' into reset/next

Roger Quadros (1):
      memory: omap-gpmc: Move gpio functions out of #ifdef CONFIG_OF

Seung-Woo Kim (1):
      memory: samsung: exynos-srom: Fix wrong count of registers

Sudeep Holla (6):
      firmware: arm_scpi: remove dvfs_get packed structure
      firmware: arm_scpi: mark scpi_get_sensor_value as static
      firmware: arm_scpi: make it depend on MAILBOX instead of ARM_MHU
      firmware: arm_scpi: add support for device power state management
      Documentation: add DT bindings for ARM SCPI power domains
      firmware: scpi: add device power domain support using genpd

Thierry Reding (3):
      soc/tegra: pmc: Use register definitions instead of magic values
      soc/tegra: pmc: Use whitespace more consistently
      soc/tegra: Stub out PCIe IRQ workaround on 64-bit ARM

Xinliang Liu (3):
      reset: hisilicon: Add media reset controller binding
      arm64: dts: hi6220: Add media subsystem reset dts
      reset: hisilicon: Add hi6220 media subsystem reset support


 .../devicetree/bindings/arm/arm,scpi.txt        |   34 +
 .../bindings/bus/nvidia,tegra210-aconnect.txt   |   45 +
 .../bindings/clock/clps711x-clock.txt           |    4 +-
 .../bindings/display/cirrus,clps711x-fb.txt     |    4 +-
 .../bindings/input/clps711x-keypad.txt          |    4 +-
 .../cirrus,clps711x-intc.txt                    |    4 +-
 .../devicetree/bindings/media/nokia,n900-ir     |   20 +
 .../bindings/memory-controllers/atmel,ebi.txt   |  136 +++
 .../bindings/pwm/cirrus,clps711x-pwm.txt        |    5 +-
 .../bindings/pwm/pwm-omap-dmtimer.txt           |    4 +
 .../bindings/reset/amlogic,meson-reset.txt      |   18 +
 .../bindings/reset/hisilicon,hi6220-reset.txt   |    4 +-
 .../bindings/reset/ti-syscon-reset.txt          |   91 ++
 .../bindings/serial/cirrus,clps711x-uart.txt    |    4 +-
 .../devicetree/bindings/soc/qcom/qcom,smp2p.txt |    4 +-
 .../devicetree/bindings/soc/qcom/qcom,smsm.txt  |    4 +-
 .../bindings/timer/cirrus,clps711x-timer.txt    |    6 +-
 Documentation/driver-model/devres.txt           |    4 +
 MAINTAINERS                                     |    2 +-
 .../boot/dts/exynos-mfc-reserved-memory.dtsi    |   29 +
 arch/arm/boot/dts/exynos4210-origen.dts         |    4 +-
 arch/arm/boot/dts/exynos4210-smdkv310.dts       |    4 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |    6 +
 arch/arm/boot/dts/exynos4412-origen.dts         |    4 +-
 arch/arm/boot/dts/exynos4412-smdk4412.dts       |    4 +-
 arch/arm/boot/dts/exynos5250-arndale.dts        |    4 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts       |    4 +-
 arch/arm/boot/dts/exynos5250-spring.dts         |    4 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts   |    4 +-
 arch/arm/boot/dts/exynos5420-peach-pit.dts      |    4 +-
 arch/arm/boot/dts/exynos5420-smdk5420.dts       |    4 +-
 .../boot/dts/exynos5422-odroidxu3-common.dtsi   |    4 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts       |    4 +-
 arch/arm/mach-exynos/Kconfig                    |    1 +
 arch/arm/mach-exynos/Makefile                   |    3 -
 arch/arm/mach-exynos/exynos.c                   |   19 -
 arch/arm/mach-exynos/mfc.h                      |   16 -
 arch/arm/mach-exynos/s5p-dev-mfc.c              |   93 --
 arch/arm/mach-omap2/board-rx51-peripherals.c    |    5 -
 arch/arm/mach-omap2/pdata-quirks.c              |   10 +-
 arch/arm/mach-ux500/Makefile                    |    6 +-
 arch/arm/mach-ux500/board-mop500-regulators.c   | 1065 ------------------
 arch/arm/mach-ux500/board-mop500-regulators.h   |   24 -
 arch/arm/mach-ux500/cache-l2x0.c                |   67 --
 arch/arm/mach-ux500/cpu-db8500.c                |  139 ++-
 arch/arm/mach-ux500/cpu.c                       |  148 ---
 arch/arm/mach-ux500/id.c                        |  116 --
 arch/arm/mach-ux500/id.h                        |  144 ---
 arch/arm/mach-ux500/platsmp.c                   |    1 -
 arch/arm/mach-ux500/setup.h                     |   12 -
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi       |    2 +
 drivers/bus/Kconfig                             |   13 +
 drivers/bus/Makefile                            |    1 +
 drivers/bus/tegra-aconnect.c                    |  112 ++
 drivers/clk/clk-clps711x.c                      |    2 +-
 drivers/clk/ux500/u8500_of_clk.c                |   16 +-
 drivers/clk/ux500/u8540_clk.c                   |   16 +-
 drivers/clk/ux500/u9540_clk.c                   |    4 +-
 drivers/clocksource/clps711x-timer.c            |    2 +-
 drivers/cpufreq/s5pv210-cpufreq.c               |   68 +-
 drivers/firmware/Kconfig                        |   12 +-
 drivers/firmware/Makefile                       |    1 +
 drivers/firmware/arm_scpi.c                     |   42 +-
 drivers/firmware/qcom_scm-32.c                  |  327 +++---
 drivers/firmware/qcom_scm-64.c                  |  307 ++++-
 drivers/firmware/qcom_scm.c                     |  353 +++++-
 drivers/firmware/qcom_scm.h                     |   47 +-
 drivers/firmware/scpi_pm_domain.c               |  163 +++
 drivers/input/keyboard/clps711x-keypad.c        |    4 +-
 drivers/irqchip/irq-clps711x.c                  |    2 +-
 drivers/media/rc/Kconfig                        |    2 +-
 drivers/media/rc/ir-rx51.c                      |  229 ++--
 drivers/memory/Kconfig                          |   11 +
 drivers/memory/Makefile                         |    1 +
 drivers/memory/atmel-ebi.c                      |  766 +++++++++++++
 drivers/memory/atmel-sdramc.c                   |   11 +-
 drivers/memory/omap-gpmc.c                      |  136 ++-
 drivers/memory/samsung/exynos-srom.c            |   41 +-
 drivers/memory/tegra/mc.c                       |   10 +-
 drivers/memory/tegra/tegra124-emc.c             |    8 +-
 drivers/mfd/ab8500-core.c                       |    4 -
 drivers/mfd/ab8500-sysctrl.c                    |   34 -
 drivers/mfd/db8500-prcmu.c                      |   10 +-
 drivers/power/reset/Kconfig                     |   10 +
 drivers/power/reset/Makefile                    |    1 +
 drivers/power/reset/brcm-kona-reset.c           |   73 ++
 drivers/pwm/pwm-clps711x.c                      |    2 +-
 drivers/pwm/pwm-omap-dmtimer.c                  |   12 +-
 drivers/regulator/ab8500-ext.c                  |  465 +++++++-
 drivers/reset/Kconfig                           |   14 +
 drivers/reset/Makefile                          |    2 +
 drivers/reset/core.c                            |   37 +
 drivers/reset/hisilicon/hi6220_reset.c          |  122 +-
 drivers/reset/reset-ath79.c                     |    3 +-
 drivers/reset/reset-meson.c                     |  136 +++
 drivers/reset/reset-oxnas.c                     |   12 +-
 drivers/reset/reset-pistachio.c                 |   12 +-
 drivers/reset/reset-socfpga.c                   |   12 +-
 drivers/reset/reset-sunxi.c                     |   12 +-
 drivers/reset/reset-ti-syscon.c                 |  237 ++++
 drivers/reset/reset-zynq.c                      |   12 +-
 drivers/reset/sti/Kconfig                       |    1 -
 drivers/soc/Kconfig                             |    2 +-
 drivers/soc/Makefile                            |    2 +-
 drivers/soc/bcm/Kconfig                         |   18 +-
 drivers/soc/bcm/Makefile                        |    1 +
 drivers/soc/{ => bcm}/brcmstb/Makefile          |    0
 drivers/soc/{ => bcm}/brcmstb/biuctrl.c         |    1 +
 drivers/soc/{ => bcm}/brcmstb/common.c          |    0
 drivers/soc/brcmstb/Kconfig                     |   10 -
 drivers/soc/qcom/smem_state.c                   |   12 +-
 drivers/soc/qcom/smp2p.c                        |    7 +-
 drivers/soc/qcom/smsm.c                         |    2 +-
 drivers/soc/qcom/wcnss_ctrl.c                   |  125 +-
 drivers/soc/samsung/Kconfig                     |    4 +
 drivers/soc/samsung/Makefile                    |    1 +
 drivers/soc/samsung/exynos3250-pmu.c            |    2 +-
 drivers/soc/samsung/exynos5420-pmu.c            |    2 +-
 .../soc/samsung}/pm_domains.c                   |   34 +-
 drivers/soc/tegra/pmc.c                         |  149 ++-
 drivers/soc/ux500/Kconfig                       |    7 +
 drivers/soc/ux500/Makefile                      |    1 +
 drivers/soc/ux500/ux500-soc-id.c                |  222 ++++
 drivers/tty/serial/clps711x.c                   |    2 +-
 drivers/video/fbdev/clps711x-fb.c               |    4 +-
 .../reset/amlogic,meson-gxbb-reset.h            |  210 ++++
 .../dt-bindings/reset/amlogic,meson8b-reset.h   |  175 +++
 include/dt-bindings/reset/hisi,hi6220-resets.h  |    8 +
 include/dt-bindings/reset/ti-syscon.h           |   38 +
 include/linux/mfd/abx500/ab8500-sysctrl.h       |    6 -
 include/linux/mfd/dbx500-prcmu.h                |   10 -
 include/linux/platform_data/clk-ux500.h         |   17 -
 include/linux/platform_data/media/ir-rx51.h     |    3 -
 include/linux/qcom_scm.h                        |    8 +
 include/linux/reset-controller.h                |    4 +
 include/linux/reset.h                           |    4 +-
 include/linux/scpi_protocol.h                   |    2 +
 include/linux/soc/qcom/wcnss_ctrl.h             |    8 +
 include/soc/tegra/cpuidle.h                     |    2 +-
 sound/soc/codecs/ab8500-codec.c                 |   33 +-
 140 files changed, 4776 insertions(+), 2641 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/nvidia,tegra210-aconnect.txt
 create mode 100644 Documentation/devicetree/bindings/media/nokia,n900-ir
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt
 create mode 100644 Documentation/devicetree/bindings/reset/amlogic,meson-reset.txt
 create mode 100644 Documentation/devicetree/bindings/reset/ti-syscon-reset.txt
 create mode 100644 arch/arm/boot/dts/exynos-mfc-reserved-memory.dtsi
 delete mode 100644 arch/arm/mach-exynos/mfc.h
 delete mode 100644 arch/arm/mach-exynos/s5p-dev-mfc.c
 delete mode 100644 arch/arm/mach-ux500/board-mop500-regulators.c
 delete mode 100644 arch/arm/mach-ux500/board-mop500-regulators.h
 delete mode 100644 arch/arm/mach-ux500/cache-l2x0.c
 delete mode 100644 arch/arm/mach-ux500/cpu.c
 delete mode 100644 arch/arm/mach-ux500/id.c
 delete mode 100644 arch/arm/mach-ux500/id.h
 create mode 100644 drivers/bus/tegra-aconnect.c
 create mode 100644 drivers/firmware/scpi_pm_domain.c
 create mode 100644 drivers/memory/atmel-ebi.c
 create mode 100644 drivers/power/reset/brcm-kona-reset.c
 create mode 100644 drivers/reset/reset-meson.c
 create mode 100644 drivers/reset/reset-ti-syscon.c
 rename drivers/soc/{ => bcm}/brcmstb/Makefile (100%)
 rename drivers/soc/{ => bcm}/brcmstb/biuctrl.c (98%)
 rename drivers/soc/{ => bcm}/brcmstb/common.c (100%)
 delete mode 100644 drivers/soc/brcmstb/Kconfig
 rename {arch/arm/mach-exynos => drivers/soc/samsung}/pm_domains.c (85%)
 create mode 100644 drivers/soc/ux500/Kconfig
 create mode 100644 drivers/soc/ux500/Makefile
 create mode 100644 drivers/soc/ux500/ux500-soc-id.c
 create mode 100644 include/dt-bindings/reset/amlogic,meson-gxbb-reset.h
 create mode 100644 include/dt-bindings/reset/amlogic,meson8b-reset.h
 create mode 100644 include/dt-bindings/reset/ti-syscon.h
 delete mode 100644 include/linux/platform_data/clk-ux500.h
 create mode 100644 include/linux/soc/qcom/wcnss_ctrl.h
