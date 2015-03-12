From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 12 Mar 2015 15:47:52 +0100
Subject: [PATCH v8 00/18] Tegra124 EMC (external memory controller) support
Message-ID: <1426171746-26864-1-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I have spun one more version to address feedback from Paul Bolle and to include the .dtsi with the timings for the Nyan Blaze in the right DTS.

Because of the DT changes for the Nyan boards this now depends on the Nyan series, but all the rest should apply cleanly on top of v4.0-rc1.

I'm leaving here the changelog for the v7 for convenience:

* Removes registers from the burst blocks that were redundant
* Removes nvidia,emc-cfg-dig-dll as it is unused in T124
* Adds timings for the Nyan Big and Blaze boards
* Disables the ARBITRATION_EMEM interrupt, as it can be very disruptive when
the EMC clock runs at low frequencies and shouldn't probably be enabled in
any case in a production kernel as it's intended to be used as a development
tool
* I have tested it on the Nyan boards, in addition to the Jetson TK1

Patch 1: Removes the old EMC clock, that was unused and not functional

Patch 2: Documents bindings for the new long-ram-code property

Patch 3: Adds API for reading the ram code

Patches 4 to 7: Document OF additions

Patch 8: Adds EMC node to Tegra124 DT

Patch 9: Adds timings for Jetson TK1 board

Patch 10: Adds functions to the MC driver so the EMC driver can stay within
its own registers

Patch 11: Adds the actual EMC driver, making use of the new MC API

Patch 12: Exposes clk_hw_reparent function

Patch 13: Adds EMC clock driver, making use of API provided by the EMC driver

Patch 14: Adds debugfs entry for getting and setting the EMC rate

Patch 15: On Tegra124, have the EMC clock be the parent of the MC clock

Patches 16 and 17: Add timings for the Nyan Big and Blaze boards

Patches 18: Disables ARBITRATION_EMEM

http://cgit.collabora.com/git/user/tomeu/linux.git/log/?h=emc-v8

Regards,

Tomeu

Mikko Perttunen (9):
  clk: tegra124: Remove old emc clock
  soc/tegra: Add ram code reader helper
  of: Add Tegra124 EMC bindings
  ARM: tegra: Add EMC to Tegra124 device tree
  ARM: tegra: Add EMC timings to Jetson TK1 device tree
  memory: tegra: Add API needed by the EMC driver
  memory: tegra: Add EMC (external memory controller) driver
  clk: tegra: Add EMC clock driver
  memory: tegra: Add debugfs entry for getting and setting the EMC rate

Tomeu Vizoso (9):
  of: Document long-ram-code property in nvidia,tegra20-apbmisc
  of: document new emc-timings subnode in nvidia,tegra124-car
  of: Document timings subnode of nvidia,tegra-mc
  of: document external-memory-controller property in tegra124-car
  clk: Expose clk_hw_reparent to providers
  clk: tegra: Set the EMC clock as the parent of the MC clock
  ARM: tegra: Add EMC timings to Nyan Big device tree
  ARM: tegra: Add EMC timings to Nyan Blaze device tree
  memory: tegra: Disable ARBITRATION_EMEM interrupt

 .../bindings/clock/nvidia,tegra124-car.txt         |   44 +-
 .../memory-controllers/nvidia,tegra-mc.txt         |   84 +-
 .../bindings/memory-controllers/tegra-emc.txt      |  374 +++
 .../bindings/misc/nvidia,tegra20-apbmisc.txt       |    2 +
 arch/arm/boot/dts/tegra124-jetson-tk1-emc.dtsi     | 2421 ++++++++++++++++++++
 arch/arm/boot/dts/tegra124-jetson-tk1.dts          |    2 +
 arch/arm/boot/dts/tegra124-nyan-big-emc.dtsi       | 2023 ++++++++++++++++
 arch/arm/boot/dts/tegra124-nyan-big.dts            |    2 +
 arch/arm/boot/dts/tegra124-nyan-blaze-emc.dtsi     | 2049 +++++++++++++++++
 arch/arm/boot/dts/tegra124-nyan-blaze.dts          |    2 +
 arch/arm/boot/dts/tegra124.dtsi                    |    8 +
 drivers/clk/clk.c                                  |    8 +
 drivers/clk/tegra/Makefile                         |    2 +-
 drivers/clk/tegra/clk-emc.c                        |  528 +++++
 drivers/clk/tegra/clk-tegra124.c                   |   18 +-
 drivers/clk/tegra/clk.h                            |    3 +
 drivers/memory/tegra/Kconfig                       |   11 +
 drivers/memory/tegra/Makefile                      |    2 +
 drivers/memory/tegra/mc.c                          |  140 +-
 drivers/memory/tegra/tegra124-emc.c                | 1160 ++++++++++
 drivers/memory/tegra/tegra124.c                    |   44 +
 drivers/soc/tegra/fuse/tegra-apbmisc.c             |   21 +
 include/linux/clk-provider.h                       |    1 +
 include/soc/tegra/emc.h                            |   19 +
 include/soc/tegra/fuse.h                           |    1 +
 include/soc/tegra/mc.h                             |   14 +-
 26 files changed, 8962 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/tegra-emc.txt
 create mode 100644 arch/arm/boot/dts/tegra124-jetson-tk1-emc.dtsi
 create mode 100644 arch/arm/boot/dts/tegra124-nyan-big-emc.dtsi
 create mode 100644 arch/arm/boot/dts/tegra124-nyan-blaze-emc.dtsi
 create mode 100644 drivers/clk/tegra/clk-emc.c
 create mode 100644 drivers/memory/tegra/tegra124-emc.c
 create mode 100644 include/soc/tegra/emc.h

-- 
2.1.0
