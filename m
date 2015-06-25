From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 25 Jun 2015 15:31:03 -0700
Subject: [GIT PULL 4/5] ARM: SoC: driver updates for v4.2
In-Reply-To: <1435271464-11455-1-git-send-email-khilman@kernel.org>
References: <1435271464-11455-1-git-send-email-khilman@kernel.org>
Message-ID: <1435271464-11455-5-git-send-email-khilman@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of these are for drivers/soc, where we're now putting
SoC-specific drivers these days. Some are for other driver subsystems
where we have received acks from the appropriate maintainers.

Some highlights:

- simple-mfd: document DT bindings and misc updates
- migrate mach-berlin to simple-mfd for clock, pinctrl and reset
- memory: support for Tegra132 SoC
- memory: introduce tegra EMC driver for scaling memory frequency
- misc. updates for ARM CCI and CCN busses

Conflicts:
	arch/arm64/boot/dts/arm/juno-motherboard.dtsi

Trivial add/add conflict with our dt branch.
Resolution: take both sides.

----------------------------------------------------------------

The following changes since commit 39e79b873e1bafc5637a1a704495b01edbe469b1:

  Merge tag 'armsoc-dt' into test-merge

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-drivers

for you to fetch changes up to 4af34b572a85c44c55491a10693535a79627c478:

  drivers: soc: sunxi: Introduce SoC driver to map SRAMs

----------------------------------------------------------------

Antoine Tenart (15):
      ARM: berlin: select MFD_SYSCON by default
      ARM: berlin: prepare simple-mfd/syscon conversion of sys/chip ctrl nodes
      reset: berlin: convert to a platform driver
      ARM: berlin: move reset to simple-mfd nodes
      reset: berlin: drop arch_initcall initialization
      pinctrl: berlin: prepare to use regmap provided by syscon
      ARM: berlin: move pinctrl to simple-mfd nodes
      pinctrl: berlin: drop SoC stub provided regmap
      clk: berlin: prepare simple-mfd conversion
      ARM: berlin: move BG2 clock node
      ARM: berlin: move BG2CD clock node
      ARM: berlin: move BG2Q clock node
      clk: berlin: drop direct of_iomap of nodes reg property
      ARM: berlin: remove useless chip and system ctrl compatibles
      ARM: berlin: add an ADC node for the BG2Q

Arnd Bergmann (9):
      Merge tag 'simple-mfd' of git://git.kernel.org/.../linusw/linux-integrator into next/drivers
      Merge tag 'ccn/updates-for-4.2' of git://git.linaro.org/people/pawel.moll/linux into next/drivers
      Merge tag 'tegra-for-4.2-memory' of git://git.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'tegra-for-4.2-ramcode' of git://git.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'tegra-for-4.2-emc' of git://git.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'berlin-simple-mfd-4.2-1' of git://git.infradead.org/users/hesselba/linux-berlin into next/drivers
      Merge tag 'v4.1-next-soc' of https://github.com/mbgg/linux-mediatek into next/drivers
      Merge tag 'qcom-soc-for-4.2-1' of git://git.kernel.org/.../galak/linux-qcom into next/drivers
      Merge tag 'mvebu-drivers-4.2' of git://git.infradead.org/linux-mvebu into next/drivers

Kumar Gala (1):
      firmware: qcom: scm: Split out 32-bit specific SCM code

Lina Iyer (1):
      ARM: qcom: Add Subsystem Power Manager (SPM) driver

Linus Walleij (5):
      MFD/OF: document MFD devices and handle simple-mfd
      ARM: dts: update syscons to use simple-mfd
      leds: syscon: instantiate from platform device
      arm64: juno: Add APB registers and LEDs using syscon
      arm64: add LEDs and some trigger support to defconfig

Maxime Ripard (1):
      drivers: soc: sunxi: Introduce SoC driver to map SRAMs

Mikko Perttunen (5):
      soc/tegra: fuse: Add RAM code reader helper
      of: Add Tegra124 EMC bindings
      memory: tegra: Add API needed by the EMC driver
      memory: tegra: Add EMC (external memory controller) driver
      memory: tegra: Add EMC frequency debugfs entry

Pawel Moll (6):
      bus: arm-ccn: Fix node->XP config conversion
      bus: arm-ccn: cpumask attribute
      bus: arm-ccn: Provide required event arguments
      bus: arm-ccn: Do not group CCN events with other PMUs
      bus: arm-ccn: Allocate event when it is being added, not initialised
      bus: arm-ccn: Use hrtimer_start() again

Suzuki K. Poulose (7):
      arm-cci: Do not enable CCI-400 PMU by default
      arm-cci: Cleanup PMU driver code
      arm-cci: Abstract out the PMU counter details
      arm-cci: Abstract handling for CCI events
      arm-cci: Sanitise CCI400 PMU driver specific code
      arm-cci: Add CCI-500 PMU support
      arm-cci: Add aliases for PMU events

Thierry Reding (4):
      memory: tegra: Add SWGROUP names
      iommu/tegra-smmu: Add debugfs support
      memory: tegra: Add Tegra132 support
      Merge branch 'for-4.2/ramcode' into for-4.2/emc

Thomas Petazzoni (1):
      bus: mvebu-mbus: add mv_mbus_dram_info_nooverlap()

Tomeu Vizoso (3):
      of: Document long-ram-code property in nvidia,tegra20-apbmisc
      memory: tegra: Disable ARBITRATION_EMEM interrupt
      of: Document timings subnode of nvidia,tegra-mc

jilai wang (1):
      firmware: qcom: scm: Add HDCP Support


 Documentation/arm/CCN.txt                       |   17 +-
 Documentation/devicetree/bindings/arm/cci.txt   |    4 +-
 .../memory-controllers/nvidia,tegra-mc.txt      |   84 +-
 .../bindings/memory-controllers/tegra-emc.txt   |  374 ++++++
 Documentation/devicetree/bindings/mfd/mfd.txt   |   41 +
 .../bindings/misc/nvidia,tegra20-apbmisc.txt    |    2 +
 .../devicetree/bindings/soc/sunxi/sram.txt      |   72 ++
 arch/arm/boot/dts/arm-realview-pb1176.dts       |    2 +-
 arch/arm/boot/dts/berlin2.dtsi                  |   90 +-
 arch/arm/boot/dts/berlin2cd.dtsi                |   66 +-
 arch/arm/boot/dts/berlin2q.dtsi                 |  120 +-
 arch/arm/boot/dts/integrator.dtsi               |    4 +-
 arch/arm/mach-berlin/Kconfig                    |    1 +
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi   |   68 ++
 arch/arm64/configs/defconfig                    |    6 +
 drivers/bus/Kconfig                             |   31 +-
 drivers/bus/arm-cci.c                           |  905 +++++++++++---
 drivers/bus/arm-ccn.c                           |  270 ++++-
 drivers/bus/mvebu-mbus.c                        |  117 ++
 drivers/clk/berlin/bg2.c                        |    7 +-
 drivers/clk/berlin/bg2q.c                       |    7 +-
 drivers/firmware/Makefile                       |    3 +-
 drivers/firmware/qcom_scm-32.c                  |  503 ++++++++
 drivers/firmware/qcom_scm.c                     |  474 +-------
 drivers/firmware/qcom_scm.h                     |   47 +
 drivers/iommu/Kconfig                           |    2 +-
 drivers/iommu/tegra-smmu.c                      |  109 ++
 drivers/leds/leds-syscon.c                      |  170 +--
 drivers/memory/tegra/Kconfig                    |   10 +
 drivers/memory/tegra/Makefile                   |    3 +
 drivers/memory/tegra/mc.c                       |  143 ++-
 drivers/memory/tegra/mc.h                       |    4 +
 drivers/memory/tegra/tegra114.c                 |   32 +-
 drivers/memory/tegra/tegra124-emc.c             | 1140 ++++++++++++++++++
 drivers/memory/tegra/tegra124.c                 |  123 +-
 drivers/memory/tegra/tegra30.c                  |   32 +-
 drivers/of/platform.c                           |    1 +
 drivers/pinctrl/berlin/berlin-bg2.c             |   26 +-
 drivers/pinctrl/berlin/berlin-bg2cd.c           |   26 +-
 drivers/pinctrl/berlin/berlin-bg2q.c            |   26 +-
 drivers/pinctrl/berlin/berlin.c                 |    9 +-
 drivers/reset/reset-berlin.c                    |   74 +-
 drivers/soc/Kconfig                             |    1 +
 drivers/soc/Makefile                            |    1 +
 drivers/soc/qcom/Kconfig                        |    7 +
 drivers/soc/qcom/Makefile                       |    1 +
 drivers/soc/qcom/spm.c                          |  385 ++++++
 drivers/soc/sunxi/Kconfig                       |   10 +
 drivers/soc/sunxi/Makefile                      |    1 +
 drivers/soc/sunxi/sunxi_sram.c                  |  284 +++++
 drivers/soc/tegra/fuse/tegra-apbmisc.c          |   21 +
 include/linux/mbus.h                            |    5 +
 include/linux/qcom_scm.h                        |   13 +-
 include/linux/soc/sunxi/sunxi_sram.h            |   19 +
 include/soc/tegra/emc.h                         |   19 +
 include/soc/tegra/fuse.h                        |    1 +
 include/soc/tegra/mc.h                          |   20 +-
 57 files changed, 4966 insertions(+), 1067 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/tegra-emc.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/mfd.txt
 create mode 100644 Documentation/devicetree/bindings/soc/sunxi/sram.txt
 create mode 100644 drivers/firmware/qcom_scm-32.c
 create mode 100644 drivers/firmware/qcom_scm.h
 create mode 100644 drivers/memory/tegra/tegra124-emc.c
 create mode 100644 drivers/soc/qcom/spm.c
 create mode 100644 drivers/soc/sunxi/Kconfig
 create mode 100644 drivers/soc/sunxi/Makefile
 create mode 100644 drivers/soc/sunxi/sunxi_sram.c
 create mode 100644 include/linux/soc/sunxi/sunxi_sram.h
 create mode 100644 include/soc/tegra/emc.h
