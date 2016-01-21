From: olof@lixom.net (Olof Johansson)
Date: Wed, 20 Jan 2016 17:14:42 -0800
Subject: [GIT PULL 9/9] ARM: SoC driver updates for v4.5
In-Reply-To: <1453338882-31300-1-git-send-email-olof@lixom.net>
References: <1453338882-31300-1-git-send-email-olof@lixom.net>
Message-ID: <1453338882-31300-10-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Driver updates for ARM SoCs. Some for SoC-family code under drivers/soc,
but also some other driver updates that don't belong anywhere else. We also
bring in the drivers/reset code through arm-soc.

Some of the larger updates:

- Qualcomm support for SMEM, SMSM, SMP2P. All used to communicate with other
parts of the chip/board on these platforms, all proprietary protocols that
don't fit into other subsystems and live in drivers/soc for now.

- System bus driver for UniPhier
- Driver for the TI Wakeup M3 IPC device

- Power management for Raspberry PI

+ Again a bunch of other smaller updates and patches.


Conflicts:

MAINTAINERS: Add/add. Keep both.

----------------------------------------------------------------

The following changes since commit 6ce42fec64d4f18e0c90257a5c5f9a455190f382:

  Merge branch 'next/config64' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-drivers

for you to fetch changes up to ce96cb7386a57b270648f9ba6003065329a26bd3:

  Merge tag 'samsung-clk-exynos4-4.5' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into next/drivers

----------------------------------------------------------------

Alban Bedel (2):
      reset: Fix of_reset_control_get() for consistent return values
      reset: ath79: Add system restart support

Alexander Aring (2):
      dt-bindings: add rpi power domain driver bindings
      ARM: bcm2835: add rpi power domain driver

Andy Gross (2):
      soc: qcom: smd-rpm: Add existing platform support
      MAINTAINERS: Change QCOM entries

Arnd Bergmann (9):
      soc: qcom: enable smsm/smp2p modular build
      ARM: qcom: select ARM_CPU_SUSPEND for power management
      Merge tag 'reset-for-4.5' of git://git.pengutronix.de/git/pza/linux into next/drivers
      Merge tag 'reset-for-4.5-2' of git://git.pengutronix.de/git/pza/linux into next/drivers
      reset: hi6220: fix modular build
      Merge branch 'depends/usb-fixes' into next/drivers
      Merge tag 'bcm2835-drivers-next-2015-12-28' of http://github.com/anholt/linux into next/drivers
      ARM: bcm2835: clarify RASPBERRYPI_FIRMWARE dependency
      bus: uniphier: allow only built-in driver

Bjorn Andersson (5):
      soc: qcom: Introduce common SMEM state machine code
      soc: qcom: smsm: Add driver for Qualcomm SMSM
      soc: qcom: smp2p: Qualcomm Shared Memory Point to Point
      MAINTAINERS: Add rules for Qualcomm dts files
      soc: qcom: Introduce WCNSS_CTRL SMD client

Chen Feng (3):
      reset: hisilicon: document hisi-hi6220 reset controllers bindings
      reset: hi6220: Reset driver for hisilicon hi6220 SoC
      arm64: dts: Add reset dts config for Hisilicon Hi6220 SoC

Dave Gerlach (2):
      Documentation: dt: add bindings for TI Wakeup M3 IPC device
      soc: ti: Add wkup_m3_ipc driver

Eric Anholt (1):
      ARM: bcm2835: Define two new packets from the latest firmware.

Lee Jones (3):
      ARM: STi: Add DT defines for co-processor reset lines
      reset: sti: Add support for resetting co-processors
      reset: sti: Provide ops .status() call-back

Masahiro Yamada (3):
      reset: remove redundant $(CONFIG_RESET_CONTROLLER) from Makefile
      reset: check return value of reset_controller_register()
      bus: uniphier-system-bus: add UniPhier System Bus driver

Olof Johansson (6):
      Merge tag 'tegra-for-4.5-memory' of git://git.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'qcom-soc-for-4.5' of git://git.kernel.org/.../agross/linux into next/drivers
      MAINTAINERS: Drop Kumar Gala from QCOM
      Merge tag 'v4.4-next-soc' of https://github.com/mbgg/linux-mediatek into next/drivers
      Merge tag 'omap-for-v4.5/wakeup-m3' of git://git.kernel.org/.../tmlind/linux-omap into next/drivers
      Merge tag 'samsung-clk-exynos4-4.5' of https://git.kernel.org/.../krzk/linux into next/drivers

Paul Gortmaker (1):
      drivers/soc: make mediatek/mtk-scpsys.c explicitly non-modular

Philipp Zabel (4):
      reset: sti: add a missing blank line after declaration
      reset: sunxi: mark the of_device_id array as __initconst
      reset: use ENOTSUPP instead of ENOSYS
      reset: remove unused device pointer from struct reset_control

Sascha Hauer (1):
      soc: mediatek: SCPSYS: Add regulator support

Stephen Boyd (1):
      serial: msm_serial: Make config tristate

Vince Hsu (2):
      reset: add of_reset_control_get_by_index()
      memory/tegra: Add number of TLB lines for Tegra124


 .../bindings/bus/uniphier-system-bus.txt        |  66 ++
 .../bindings/reset/hisilicon,hi6220-reset.txt   |  34 +
 .../soc/bcm/raspberrypi,bcm2835-power.txt       |  47 ++
 .../devicetree/bindings/soc/ti/wkup_m3_ipc.txt  |  57 ++
 MAINTAINERS                                     |  10 +-
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi       |   1 +
 drivers/bus/Kconfig                             |   8 +
 drivers/bus/Makefile                            |   1 +
 drivers/bus/uniphier-system-bus.c               | 281 +++++++++
 drivers/memory/tegra/tegra124.c                 |   1 +
 drivers/reset/Kconfig                           |   1 +
 drivers/reset/Makefile                          |   3 +-
 drivers/reset/core.c                            |  60 +-
 drivers/reset/hisilicon/Kconfig                 |   5 +
 drivers/reset/hisilicon/Makefile                |   1 +
 drivers/reset/hisilicon/hi6220_reset.c          | 109 ++++
 drivers/reset/reset-ath79.c                     |  30 +-
 drivers/reset/reset-berlin.c                    |   4 +-
 drivers/reset/reset-socfpga.c                   |   3 +-
 drivers/reset/reset-sunxi.c                     |   5 +-
 drivers/reset/reset-zynq.c                      |   3 +-
 drivers/reset/sti/reset-stih407.c               |   5 +
 drivers/reset/sti/reset-syscfg.c                |  27 +-
 drivers/soc/Kconfig                             |   1 +
 drivers/soc/Makefile                            |   1 +
 drivers/soc/bcm/Kconfig                         |   9 +
 drivers/soc/bcm/Makefile                        |   1 +
 drivers/soc/bcm/raspberrypi-power.c             | 247 ++++++++
 drivers/soc/mediatek/mtk-scpsys.c               |  32 +-
 drivers/soc/qcom/Kconfig                        |  27 +
 drivers/soc/qcom/Makefile                       |   4 +
 drivers/soc/qcom/smd-rpm.c                      |   2 +
 drivers/soc/qcom/smem_state.c                   | 201 ++++++
 drivers/soc/qcom/smp2p.c                        | 578 +++++++++++++++++
 drivers/soc/qcom/smsm.c                         | 625 +++++++++++++++++++
 drivers/soc/qcom/wcnss_ctrl.c                   | 272 ++++++++
 drivers/soc/ti/Kconfig                          |  10 +
 drivers/soc/ti/Makefile                         |   1 +
 drivers/soc/ti/wkup_m3_ipc.c                    | 508 +++++++++++++++
 drivers/tty/serial/Kconfig                      |   2 +-
 include/dt-bindings/power/raspberrypi-power.h   |  41 ++
 include/dt-bindings/reset/hisi,hi6220-resets.h  |  67 ++
 include/dt-bindings/reset/stih407-resets.h      |   4 +
 include/linux/reset.h                           |  17 +-
 include/linux/soc/qcom/smem_state.h             |  18 +
 include/linux/wkup_m3_ipc.h                     |  55 ++
 include/soc/bcm2835/raspberrypi-firmware.h      |   2 +
 47 files changed, 3439 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/uniphier-system-bus.txt
 create mode 100644 Documentation/devicetree/bindings/reset/hisilicon,hi6220-reset.txt
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/raspberrypi,bcm2835-power.txt
 create mode 100644 Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.txt
 create mode 100644 drivers/bus/uniphier-system-bus.c
 create mode 100644 drivers/reset/hisilicon/Kconfig
 create mode 100644 drivers/reset/hisilicon/Makefile
 create mode 100644 drivers/reset/hisilicon/hi6220_reset.c
 create mode 100644 drivers/soc/bcm/Kconfig
 create mode 100644 drivers/soc/bcm/Makefile
 create mode 100644 drivers/soc/bcm/raspberrypi-power.c
 create mode 100644 drivers/soc/qcom/smem_state.c
 create mode 100644 drivers/soc/qcom/smp2p.c
 create mode 100644 drivers/soc/qcom/smsm.c
 create mode 100644 drivers/soc/qcom/wcnss_ctrl.c
 create mode 100644 drivers/soc/ti/wkup_m3_ipc.c
 create mode 100644 include/dt-bindings/power/raspberrypi-power.h
 create mode 100644 include/dt-bindings/reset/hisi,hi6220-resets.h
 create mode 100644 include/linux/soc/qcom/smem_state.h
 create mode 100644 include/linux/wkup_m3_ipc.h
