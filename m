From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Fri, 10 Oct 2014 14:46:51 +0200
Subject: [PATCH 00/10] Tegra124 EMC (external memory controller) support
Message-ID: <1412945262-6068-1-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

because Mikko's internship is over and he's short of time these days, I have
taken his patches witht he intention of moving this work forward.

It depends on Thierry's MC patches at [0] and a branch can be found at [1]. So far it has been tested only on a Jetson TK1.

The comments from the last review round have been addressed, most notably:

- Timings are per-ramcode.

- A new property in the DT can cause the whole 4 bits in PMC_STRAPPING_OPT_A_0
[7:4] to be used when decoding the ram code, allowing for a single board to
support more ram configurations.

- Each driver accesses only its own registers, so API has been added so each
driver can delegate on the others.

- Usage of debugfs for setting the clock rate of the EMC clock has been split
in its own commit in case it's still controversial.

Patch 1: Removes clocks that are unused because of not being fully functional

Patch 2: Documents bindings for the new long-ram-code property

Patch 3: Adds API for reading the ram code

Patch 4: Adds bindings for the EMC node

Patch 5: Adds EMC node to Tegra124 DT

Patch 6: Adds timings for Jetson TK1 board

Patch 7: Adds functions to the MC driver so the EMC driver can stay within its
own registers

Patch 8: Adds the actual EMC driver, making use of the new MC API

Patch 9: Adds EMC clock driver, making use of API provided by the EMC driver

Patch 10: Adds debugfs entry for getting and setting the EMC rate

Regards,

Tomeu

[0] https://github.com/thierryreding/linux/commits/staging/iommu
[1] http://cgit.collabora.com/git/user/tomeu/linux.git/log/?h=emc

Mikko Perttunen (8):
  clk: tegra124: Remove old emc_mux and emc clocks
  soc/tegra: Add ram code reader helper
  of: Add Tegra124 EMC bindings
  ARM: tegra: Add EMC to Tegra124 device tree
  ARM: tegra: Add EMC timings to Jetson TK1 device tree
  memory: tegra: Add API needed by the EMC driver
  memory: tegra: Add EMC (external memory controller) driver
  clk: tegra: Add EMC clock driver

Tomeu Vizoso (2):
  soc/tegra: Document long-ram-code property in nvidia,tegra20-apbmisc
  memory: tegra: Add debugfs entry for getting and setting the EMC rate

 .../bindings/memory-controllers/tegra-emc.txt      |   41 +
 .../bindings/misc/nvidia,tegra20-apbmisc.txt       |    3 +
 arch/arm/boot/dts/tegra124-jetson-tk1-emc.dtsi     | 2412 ++++++++++++++++++++
 arch/arm/boot/dts/tegra124-jetson-tk1.dts          |    2 +
 arch/arm/boot/dts/tegra124.dtsi                    |    7 +
 drivers/clk/tegra/Makefile                         |    2 +-
 drivers/clk/tegra/clk-emc.c                        |  449 ++++
 drivers/clk/tegra/clk-tegra124.c                   |   13 +-
 drivers/clk/tegra/clk.h                            |    2 +
 drivers/memory/Kconfig                             |   10 +
 drivers/memory/Makefile                            |    1 -
 drivers/memory/tegra/Makefile                      |    1 +
 drivers/memory/tegra/tegra-mc.c                    |  172 ++
 drivers/memory/tegra/tegra124-emc.c                | 1164 ++++++++++
 drivers/soc/tegra/fuse/tegra-apbmisc.c             |   19 +
 include/soc/tegra/fuse.h                           |    1 +
 include/soc/tegra/memory.h                         |   19 +
 17 files changed, 4304 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/tegra-emc.txt
 create mode 100644 arch/arm/boot/dts/tegra124-jetson-tk1-emc.dtsi
 create mode 100644 drivers/clk/tegra/clk-emc.c
 create mode 100644 drivers/memory/tegra/tegra124-emc.c
 create mode 100644 include/soc/tegra/memory.h

-- 
1.9.3
