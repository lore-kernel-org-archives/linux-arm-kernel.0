From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 11 Jul 2014 14:15:59 +0200
Subject: [PATCH 00/12] Add NVIDIA Tegra FUSE driver
Message-ID: <1405080971-7609-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

This series is an extension of Peter's original series to add a proper
driver for the FUSE block on Tegra.

Patches 1 and 2 are preparatory work that cleans up include lists and
introduces a function to query the Tegra chip ID rather than accessing
a simple variable. This is used by subsequent patches to allow us to
execute code when the variable is accessed to help in pin-pointing
locations where it's accessed before the driver had a chance to
initialize.

Patches 3 through 8 are Peter's series with a fixup patch by Stephen. I
also moved the driver to drivers/soc/tegra/fuse as requested by Olof.

Patches 9 and 10 defer usages of the tegra_get_chip_id() function to a
later stage (pure_initcall). This allows patch 11 to set up the early
FUSE support code from an early initcall. This has the advantage of not
requiring an explicit call from SoC setup code in arch/arm/mach-tegra
and will allow the code to be shared on 64-bit variants of Tegra.

Patch 12 finally turns the PMC and powergate support code into a proper
driver which also sets up a minimal environment from an early initcall.
The driver isn't moved out of arch/arm/mach-tegra yet because people
have suggested drivers/power as a good home, but that whole directory
depends on the POWER_SUPPLY Kconfig symbol yet this driver doesn't have
anything to do with that. Once that debate has been settled the driver
can easily be moved out in a separate patch.

Some of the patches in this series introduce diagnostic WARN() messages
if functions are called without setup having completed. I've booted the
v3.16-rc1 kernel with these changes on top on Tegra20 (TrimSlice),
Tegra30 (Beaver), Tegra114 (Dalmore) and Tegra124 (Jetson TK1) without
encountering any of the diagnostic warnings and without noticing any
breakage.

Olof, this series should address the concerns you expressed after
reviewing Stephen's earlier pull request for Peter's FUSE driver series.
It would be great if you could take another look to see if this is more
according to your taste. I'll see if I can take this through linux-next
for a little and if you have no objections will submit another pull
request next week.

Thierry

Peter De Schrijver (5):
  ARM: tegra: export apb dma readl/writel
  ARM: tegra: move fuse exports to tegra-soc.h
  soc/tegra: Add efuse driver for Tegra
  soc/tegra: Add efuse and apbmisc bindings
  soc/tegra: fuse: move APB DMA into Tegra20 fuse driver

Stephen Warren (1):
  misc: fuse: fix dummy functions

Thierry Reding (6):
  ARM: tegra: Sort includes alphabetically
  ARM: tegra: Use a function to get the chip ID
  ARM: tegra: Setup CPU hotplug in a pure initcall
  ARM: tegra: Always lock the CPU reset vector
  soc/tegra: fuse: Set up in early initcall
  ARM: tegra: Convert PMC to a driver

 Documentation/ABI/testing/sysfs-driver-tegra-fuse  |  11 +
 .../bindings/fuse/nvidia,tegra20-fuse.txt          |  40 +
 .../bindings/misc/nvidia,tegra20-apbmisc.txt       |  13 +
 arch/arm/boot/dts/tegra114.dtsi                    |  15 +
 arch/arm/boot/dts/tegra124.dtsi                    |  15 +
 arch/arm/boot/dts/tegra20.dtsi                     |  15 +
 arch/arm/boot/dts/tegra30.dtsi                     |  15 +
 arch/arm/mach-tegra/Makefile                       |   8 +-
 arch/arm/mach-tegra/apbio.c                        | 206 -----
 arch/arm/mach-tegra/apbio.h                        |  22 -
 arch/arm/mach-tegra/board-paz00.c                  |   3 +-
 arch/arm/mach-tegra/board.h                        |   7 -
 arch/arm/mach-tegra/cpuidle-tegra114.c             |  10 +-
 arch/arm/mach-tegra/cpuidle-tegra20.c              |  16 +-
 arch/arm/mach-tegra/cpuidle-tegra30.c              |  10 +-
 arch/arm/mach-tegra/cpuidle.c                      |   6 +-
 arch/arm/mach-tegra/flowctrl.c                     |  10 +-
 arch/arm/mach-tegra/fuse.c                         | 252 ------
 arch/arm/mach-tegra/fuse.h                         |  79 --
 arch/arm/mach-tegra/hotplug.c                      |  25 +-
 arch/arm/mach-tegra/io.c                           |   8 +-
 arch/arm/mach-tegra/irq.c                          |   8 +-
 arch/arm/mach-tegra/platsmp.c                      |  27 +-
 arch/arm/mach-tegra/pm-tegra20.c                   |   1 +
 arch/arm/mach-tegra/pm-tegra30.c                   |   1 +
 arch/arm/mach-tegra/pm.c                           |  60 +-
 arch/arm/mach-tegra/pm.h                           |  10 +-
 arch/arm/mach-tegra/pmc.c                          | 413 ---------
 arch/arm/mach-tegra/pmc.h                          |  49 --
 arch/arm/mach-tegra/powergate.c                    | 515 -----------
 arch/arm/mach-tegra/reset-handler.S                |   6 +-
 arch/arm/mach-tegra/reset.c                        |  18 +-
 arch/arm/mach-tegra/sleep-tegra30.S                |   6 +-
 arch/arm/mach-tegra/sleep.h                        |   3 -
 arch/arm/mach-tegra/tegra-pmc.c                    | 948 +++++++++++++++++++++
 arch/arm/mach-tegra/tegra.c                        |  35 +-
 drivers/misc/fuse/Makefile                         |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/tegra/Makefile                         |   1 +
 drivers/soc/tegra/fuse/Makefile                    |   8 +
 drivers/soc/tegra/fuse/fuse-tegra.c                | 158 ++++
 drivers/soc/tegra/fuse/fuse-tegra20.c              | 214 +++++
 drivers/soc/tegra/fuse/fuse-tegra30.c              | 223 +++++
 drivers/soc/tegra/fuse/fuse.h                      |  71 ++
 .../soc/tegra/fuse/speedo-tegra114.c               |  53 +-
 drivers/soc/tegra/fuse/speedo-tegra124.c           | 167 ++++
 .../soc/tegra/fuse/speedo-tegra20.c                |  42 +-
 .../soc/tegra/fuse/speedo-tegra30.c                | 173 ++--
 drivers/soc/tegra/fuse/tegra-apbmisc.c             | 114 +++
 include/linux/tegra-soc.h                          |  89 ++
 50 files changed, 2387 insertions(+), 1814 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-tegra-fuse
 create mode 100644 Documentation/devicetree/bindings/fuse/nvidia,tegra20-fuse.txt
 create mode 100644 Documentation/devicetree/bindings/misc/nvidia,tegra20-apbmisc.txt
 delete mode 100644 arch/arm/mach-tegra/apbio.c
 delete mode 100644 arch/arm/mach-tegra/apbio.h
 delete mode 100644 arch/arm/mach-tegra/fuse.c
 delete mode 100644 arch/arm/mach-tegra/fuse.h
 delete mode 100644 arch/arm/mach-tegra/pmc.c
 delete mode 100644 arch/arm/mach-tegra/pmc.h
 delete mode 100644 arch/arm/mach-tegra/powergate.c
 create mode 100644 arch/arm/mach-tegra/tegra-pmc.c
 create mode 100644 drivers/misc/fuse/Makefile
 create mode 100644 drivers/soc/tegra/Makefile
 create mode 100644 drivers/soc/tegra/fuse/Makefile
 create mode 100644 drivers/soc/tegra/fuse/fuse-tegra.c
 create mode 100644 drivers/soc/tegra/fuse/fuse-tegra20.c
 create mode 100644 drivers/soc/tegra/fuse/fuse-tegra30.c
 create mode 100644 drivers/soc/tegra/fuse/fuse.h
 rename arch/arm/mach-tegra/tegra114_speedo.c => drivers/soc/tegra/fuse/speedo-tegra114.c (55%)
 create mode 100644 drivers/soc/tegra/fuse/speedo-tegra124.c
 rename arch/arm/mach-tegra/tegra20_speedo.c => drivers/soc/tegra/fuse/speedo-tegra20.c (67%)
 rename arch/arm/mach-tegra/tegra30_speedo.c => drivers/soc/tegra/fuse/speedo-tegra30.c (52%)
 create mode 100644 drivers/soc/tegra/fuse/tegra-apbmisc.c

-- 
2.0.1
