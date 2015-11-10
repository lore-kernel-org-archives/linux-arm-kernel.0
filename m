From: olof@lixom.net (Olof Johansson)
Date: Mon,  9 Nov 2015 19:33:22 -0800
Subject: [GIT PULL 4/6] ARM: SoC driver updates for v4.4
In-Reply-To: <1447126404-10567-1-git-send-email-olof@lixom.net>
References: <1447126404-10567-1-git-send-email-olof@lixom.net>
Message-ID: <1447126404-10567-5-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we've enabled multiplatform kernels on ARM, and greatly done away with
the contents under arch/arm/mach-*, there's still need for SoC-related
drivers to go somewhere.

Many of them go in through other driver trees, but we still have
drivers/soc to hold some of the "doesn't fit anywhere" lowlevel code
that might be shared between ARM and ARM64 (or just in general makes
sense to not have under the architecture directory).

This branch contains mostly such code:

- Drivers for qualcomm SoCs for SMEM, SMD and SMD-RPM, used to communicate
with power management blocks on these SoCs for use by clock, regulator and
bus frequency drivers.
- Allwinner Reduced Serial Bus driver, again used to communicate with PMICs.
- Drivers for ARM's SCPI (System Control Processor). Not to be confused with
PSCI (Power State Coordination Interface). SCPI is used to communicate with
the assistant embedded cores doing power management, and we have yet to see
how many of them will implement this for their hardware vs abstracting in
other ways (or not at all like in the past).
- To make confusion between SCPI and PSCI more likely, this release also
includes an update of PSCI to interface version 1.0.
- Rockchip support for power domains.
- A driver to talk to the firmware on Raspberry Pi.



Conflicts:

None

----------------------------------------------------------------

The following changes since commit 13102660efc5d7b4bf0ef6915e43d8c6b5084b68:

  Merge tag 'armsoc-soc' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-drivers

for you to fetch changes up to d13a5c8c4c3dbe299659bcff805f79a2c83e2bbc:

  soc: qcom: smd-rpm: Correct size of outgoing message

----------------------------------------------------------------

Alexander Aring (1):
      ARM: bcm2835: add mutual inclusion protection

Alexandre Belloni (1):
      clocksource: atmel-st: get and use slow clock

Andy Gross (1):
      Merge tag 'qcom-fixes-for-4.3-rc1' into base-for-4.4

Antoine Tenart (1):
      clk: berlin: add cpuclk

Arnd Bergmann (9):
      Merge tag 'renesas-clk-for-v4.4' of git://git.kernel.org/.../horms/renesas into next/drivers
      Merge tag 'at91-cleanup-4.4' of git://git.kernel.org/.../abelloni/linux into next/drivers
      Merge tag 'v4.4-rockchip-drivers1' of git://git.kernel.org/.../mmind/linux-rockchip into next/drivers
      Merge tag 'arm-scpi-for-v4.4' of git://git.kernel.org/.../sudeep.holla/linux into next/drivers
      firmware: qcom-scm: build for correct architecture level
      Merge tag 'drivers_pl172_for_4.4' of https://github.com/manabian/linux-lpc into next/drivers
      Merge tag 'berlin-new-cpuclk-for-4.4-1' of git://git.infradead.org/users/hesselba/linux-berlin into next/drivers
      Merge tag 'qcom-soc-for-4.4' of git://codeaurora.org/quic/kernel/agross-msm into next/drivers
      soc: qcom/smem: add HWSPINLOCK dependency

Bjorn Andersson (5):
      soc: qcom: smd: Implement id_table driver matching
      soc: qcom: smd: Reject send of too big packets
      soc: qcom: smd: Correct SMEM items for upper channels
      soc: qcom: smd-rpm: Correct the active vs sleep state flagging
      soc: qcom: smd-rpm: Correct size of outgoing message

Boris Brezillon (2):
      clocksource: tcb_clksrc: fix setup_clkevents error path
      misc: atmel_tclib: get and use slow clock

Caesar Wang (3):
      dt-bindings: add power-domain header for RK3288 SoCs
      dt-bindings: add document of Rockchip power domains
      soc: rockchip: power-domain: Add power domain driver

Chen-Yu Tsai (2):
      bus: sunxi-rsb: Add Allwinner Reduced Serial Bus (RSB) controller bindings
      bus: sunxi-rsb: Add driver for Allwinner Reduced Serial Bus

Eric Anholt (1):
      ARM: bcm2835: Add the Raspberry Pi firmware driver

Geert Uytterhoeven (1):
      dt-bindings: Correct paths in Rockchip power domains binding document

Heiko Stuebner (2):
      Merge branch 'v4.4-armsoc/pd-headers' into v4.4-armsoc/drivers
      soc: rockchip: power-domain: don't try to print the clock name in error case

Julia Lawall (1):
      soc: qcom: smd: delete unneeded of_node_put

Lorenzo Pieralisi (6):
      drivers: firmware: psci: add INVALID_ADDRESS return value
      drivers: firmware: psci: move power_state handling to generic code
      drivers: firmware: psci: add PSCI_FEATURES call
      drivers: firmware: psci: add extended stateid power_state support
      drivers: firmware: psci: add PSCI v1.0 DT bindings
      drivers: psci: make PSCI 1.0 functions initialization version dependent

Olof Johansson (4):
      Merge tag 'firmware/psci-1.0' of git://git.kernel.org/.../lpieralisi/linux into next/drivers
      Merge branch 'drivers/psci2' into next/drivers
      Merge tag 'v4.4-rockchip-drivers2' of git://git.kernel.org/.../mmind/linux-rockchip into next/drivers
      Merge tag 'arm/soc/for-4.4/rpi-drivers' of https://github.com/Broadcom/stblinux into next/drivers

Punit Agrawal (4):
      Documentation: add DT bindings for ARM SCPI sensors
      firmware: arm_scpi: Extend to support sensors
      hwmon: Support sensors exported via ARM SCP interface
      hwmon: Support thermal zones registration for SCP temperature sensors

Rob Clark (2):
      qcom-scm: fix endianess issue in __qcom_scm_is_call_available
      qcom-scm: add missing prototype for qcom_scm_is_available()

Sebastian Hesselbarth (2):
      ARM: berlin: dts: add CLKID_CPU for BG2Q
      Merge tag 'berlin-dt-cpuclk-for-4.4-1' into berlin/cpuclk

Stephen Boyd (11):
      PM / clk: Do not __clk_get passed in clock-references
      soc: qcom: smem: Avoid NULL pointer exception on remove
      soc: qcom: Reorder SMEM/SMD configs
      soc: qcom: Make qcom_smem_get() return a pointer
      soc: qcom: smem: Handle big endian CPUs
      soc: qcom: smd: Represent channel layout in structures
      soc: qcom: smd: Use __iowrite32_copy() instead of open-coding it
      soc: qcom: smd: Remove use of VLAIS
      soc: qcom: smd_rpm: Handle big endian CPUs
      soc: qcom: smd: Handle big endian CPUs
      soc: qcom: smem: Move RPM message ram out of smem DT node

Sudeep Holla (7):
      Documentation: add DT binding for ARM System Control and Power Interface(SCPI) protocol
      firmware: add support for ARM System Control and Power Interface(SCPI) protocol
      clk: add support for clocks provided by SCP(System Control Processor)
      clk: scpi: add support for cpufreq virtual device
      cpufreq: arm_big_little: add SCPI interface driver
      drivers: firmware: psci: define more generic PSCI_FN_NATIVE macro
      drivers: firmware: psci: add system suspend support

Thierry Reding (1):
      soc: rockchip: Restrict to ARCH_ROCKCHIP

Vladimir Zapolskiy (4):
      memory: pl172: correct MPMC peripheral ID register bits
      memory: pl172: add ARM PrimeCell PL175 MPMC support
      memory: pl172: add ARM PrimeCell PL176 MPMC support
      doc: dt: arm,pl172: add description of PL175 and PL176 controllers


 .../devicetree/bindings/arm/arm,scpi.txt        | 188 +++++
 Documentation/devicetree/bindings/arm/psci.txt  |   6 +
 .../devicetree/bindings/bus/sunxi-rsb.txt       |  47 ++
 .../bindings/memory-controllers/arm,pl172.txt   |   8 +-
 .../bindings/soc/rockchip/power_domain.txt      |  46 ++
 Documentation/hwmon/scpi-hwmon                  |  33 +
 MAINTAINERS                                     |  10 +
 arch/arm/boot/dts/qcom-msm8974.dtsi             |  17 +-
 arch/arm64/kernel/psci.c                        |  14 -
 drivers/base/power/clock_ops.c                  |   6 +-
 drivers/bus/Kconfig                             |  11 +
 drivers/bus/Makefile                            |   1 +
 drivers/bus/sunxi-rsb.c                         | 783 +++++++++++++++++++
 drivers/clk/Kconfig                             |  10 +
 drivers/clk/Makefile                            |   1 +
 drivers/clk/berlin/bg2q.c                       |  14 +-
 drivers/clk/clk-scpi.c                          | 325 ++++++++
 drivers/clocksource/tcb_clksrc.c                |  12 +-
 drivers/clocksource/timer-atmel-st.c            |  31 +-
 drivers/cpufreq/Kconfig.arm                     |  10 +
 drivers/cpufreq/Makefile                        |   1 +
 drivers/cpufreq/scpi-cpufreq.c                  | 124 +++
 drivers/firmware/Kconfig                        |  26 +
 drivers/firmware/Makefile                       |   4 +-
 drivers/firmware/arm_scpi.c                     | 771 ++++++++++++++++++
 drivers/firmware/psci.c                         | 108 ++-
 drivers/firmware/qcom_scm-32.c                  |   6 +-
 drivers/firmware/raspberrypi.c                  | 260 ++++++
 drivers/hwmon/Kconfig                           |   8 +
 drivers/hwmon/Makefile                          |   1 +
 drivers/hwmon/scpi-hwmon.c                      | 288 +++++++
 drivers/memory/pl172.c                          |  26 +-
 drivers/misc/atmel_tclib.c                      |   4 +
 drivers/pwm/pwm-atmel-tcb.c                     |  26 +-
 drivers/soc/Kconfig                             |   1 +
 drivers/soc/Makefile                            |   1 +
 drivers/soc/qcom/Kconfig                        |  17 +-
 drivers/soc/qcom/smd-rpm.c                      |  68 +-
 drivers/soc/qcom/smd.c                          | 296 ++++---
 drivers/soc/qcom/smem.c                         | 368 +++++----
 drivers/soc/rockchip/Kconfig                    |  18 +
 drivers/soc/rockchip/Makefile                   |   4 +
 drivers/soc/rockchip/pm_domains.c               | 490 ++++++++++++
 include/dt-bindings/clock/berlin2q.h            |   1 +
 include/dt-bindings/power/rk3288-power.h        |  31 +
 include/linux/atmel_tc.h                        |   1 +
 include/linux/psci.h                            |   2 +
 include/linux/qcom_scm.h                        |   2 +
 include/linux/scpi_protocol.h                   |  78 ++
 include/linux/soc/qcom/smd.h                    |  11 +
 include/linux/soc/qcom/smem.h                   |   2 +-
 include/linux/sunxi-rsb.h                       | 105 +++
 include/soc/bcm2835/raspberrypi-firmware.h      | 120 +++
 include/uapi/linux/psci.h                       |  18 +
 54 files changed, 4467 insertions(+), 393 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,scpi.txt
 create mode 100644 Documentation/devicetree/bindings/bus/sunxi-rsb.txt
 create mode 100644 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
 create mode 100644 Documentation/hwmon/scpi-hwmon
 create mode 100644 drivers/bus/sunxi-rsb.c
 create mode 100644 drivers/clk/clk-scpi.c
 create mode 100644 drivers/cpufreq/scpi-cpufreq.c
 create mode 100644 drivers/firmware/arm_scpi.c
 create mode 100644 drivers/firmware/raspberrypi.c
 create mode 100644 drivers/hwmon/scpi-hwmon.c
 create mode 100644 drivers/soc/rockchip/Kconfig
 create mode 100644 drivers/soc/rockchip/Makefile
 create mode 100644 drivers/soc/rockchip/pm_domains.c
 create mode 100644 include/dt-bindings/power/rk3288-power.h
 create mode 100644 include/linux/scpi_protocol.h
 create mode 100644 include/linux/sunxi-rsb.h
 create mode 100644 include/soc/bcm2835/raspberrypi-firmware.h
