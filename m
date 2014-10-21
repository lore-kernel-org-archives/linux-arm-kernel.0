From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 21 Oct 2014 16:45:32 +0200
Subject: [PATCH v2 00/12] Tegra124 EMC (external memory controller) support
Message-ID: <1413902788-7727-1-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

in this v2 you can find these changes:

* rebased on top of v3.18-rc1

* make sure the DT bindings documentation is complete

* clarified a few confusing aspects of the DT bindings

* get the probing order right by means of subsys_initcall()

* register correctly the EMC clock so the provider knows about it

* don't try to re-set the same rate, as the hw doesn't like it

It depends on Thierry's MC patches at [0] and a branch can be found at [1]. So
far it has been tested only on a Jetson TK1.

Patch 1: Removes the old EMC clock, that was unused and not functional

Patch 2: Documents bindings for the new long-ram-code property

Patch 3: Adds API for reading the ram code

Patches 4 to 6: Document OF additions

Patch 7: Adds EMC node to Tegra124 DT

Patch 8: Adds timings for Jetson TK1 board

Patch 9: Adds functions to the MC driver so the EMC driver can stay within its
own registers

Patch 10: Adds the actual EMC driver, making use of the new MC API

Patch 11: Adds EMC clock driver, making use of API provided by the EMC driver

Patch 12: Adds debugfs entry for getting and setting the EMC rate

Regards,

Tomeu

[0] https://github.com/thierryreding/linux/commits/staging/iommu
[1] http://cgit.collabora.com/git/user/tomeu/linux.git/log/?h=emc-v2

Mikko Perttunen (8):
  clk: tegra124: Remove old emc clock
  soc/tegra: Add ram code reader helper
  of: Add Tegra124 EMC bindings
  ARM: tegra: Add EMC to Tegra124 device tree
  ARM: tegra: Add EMC timings to Jetson TK1 device tree
  memory: tegra: Add API needed by the EMC driver
  memory: tegra: Add EMC (external memory controller) driver
  clk: tegra: Add EMC clock driver

Tomeu Vizoso (4):
  of: Document long-ram-code property in nvidia,tegra20-apbmisc
  of: document new emc-timings subnode in nvidia,tegra124-car
  of: Document timings subnode of nvidia,tegra-mc
  memory: tegra: Add debugfs entry for getting and setting the EMC rate

 .../bindings/clock/nvidia,tegra124-car.txt         |   46 +-
 .../memory-controllers/nvidia,tegra-mc.txt         |   46 +-
 .../bindings/memory-controllers/tegra-emc.txt      |  118 +
 .../bindings/misc/nvidia,tegra20-apbmisc.txt       |    3 +
 arch/arm/boot/dts/tegra124-jetson-tk1-emc.dtsi     | 2412 ++++++++++++++++++++
 arch/arm/boot/dts/tegra124-jetson-tk1.dts          |    2 +
 arch/arm/boot/dts/tegra124.dtsi                    |    7 +
 drivers/clk/tegra/Makefile                         |    2 +-
 drivers/clk/tegra/clk-emc.c                        |  454 ++++
 drivers/clk/tegra/clk-tegra124.c                   |    5 +-
 drivers/clk/tegra/clk.h                            |    2 +
 drivers/memory/Kconfig                             |   10 +
 drivers/memory/Makefile                            |    1 -
 drivers/memory/tegra/Makefile                      |    1 +
 drivers/memory/tegra/tegra-mc.c                    |  172 ++
 drivers/memory/tegra/tegra124-emc.c                | 1169 ++++++++++
 drivers/soc/tegra/fuse/tegra-apbmisc.c             |   19 +
 include/soc/tegra/fuse.h                           |    1 +
 include/soc/tegra/memory.h                         |   19 +
 19 files changed, 4481 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/tegra-emc.txt
 create mode 100644 arch/arm/boot/dts/tegra124-jetson-tk1-emc.dtsi
 create mode 100644 drivers/clk/tegra/clk-emc.c
 create mode 100644 drivers/memory/tegra/tegra124-emc.c
 create mode 100644 include/soc/tegra/memory.h

-- 
1.9.3
