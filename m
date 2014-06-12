From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 12 Jun 2014 18:36:34 +0300
Subject: [PATCH v8 0/6] efuse driver for Tegra
Message-ID: <1402587400-1544-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver allows userspace to read the raw efuse data. Its userspace
interface is modelled after the sunxi_sid driver which provides similar
functionality for some Allwinner SoCs. It has been tested on
Tegra20 (ventana), Tegra30 (beaverboard), Tegra114 (dalmore) and
Tegra124 (jetson TK1).

Changes since v1:

* Add documentation for sysfs interface
* Cleanup messages

Changes since v2:

* Incorporate early fuse code
* Remove module support
* Make driver always build when Tegra platform is selected
* Add DT binding document
* Address comments on v2

Changes since v3:

* Document sysfs file format
* Added apbmisc DT node for access to the apbmisc registers
* Address comments on v3

Changes since v4:

* Provide fallback to hardcoded 0x70000800 in case the apbmisc DT node is
  missing. This is exactly what the current code does and prevents a system
  crash in that case due to an invalid memory access by tegra_read_chipid()
* Added tegra_fuse_readl() function for drivers to read calibration data

Changes since v5:

* Fix kernel panic when booting on Tegra20 A03 with a missing fuse DT node
* Incorporate review comments

Changes since v6:

* Add the fix when booting on Tegra20 A03 which was supposed to be in v6 but
  missing

Changes since v7:

* Initialize speedo info and randomness in early boot
* Expose speedo, sku and revision related info in tegra_sku_info
* Move APB DMA into Tegra20 fuse driver and remove apbio
* Make code more complex to support systems without conforming DT

Peter De Schrijver (6):
  ARM: tegra: export apb dma readl/writel
  ARM: tegra: move fuse exports to tegra-soc.h
  misc: fuse: Add efuse driver for Tegra
  ARM: tegra: Add efuse and apbmisc bindings
  ARM: tegra: build new fuse driver in drivers/misc
  misc: fuse: move APB DMA into Tegra20 fuse driver

 Documentation/ABI/testing/sysfs-driver-tegra-fuse  |   11 +
 .../bindings/fuse/nvidia,tegra20-fuse.txt          |   40 +++
 .../bindings/misc/nvidia,tegra20-apbmisc.txt       |   13 +
 arch/arm/boot/dts/tegra114.dtsi                    |   15 +
 arch/arm/boot/dts/tegra124.dtsi                    |   15 +
 arch/arm/boot/dts/tegra20.dtsi                     |   15 +
 arch/arm/boot/dts/tegra30.dtsi                     |   15 +
 arch/arm/mach-tegra/Makefile                       |    5 -
 arch/arm/mach-tegra/apbio.c                        |  206 --------------
 arch/arm/mach-tegra/apbio.h                        |   22 --
 arch/arm/mach-tegra/cpuidle.c                      |    2 +-
 arch/arm/mach-tegra/flowctrl.c                     |    2 +-
 arch/arm/mach-tegra/fuse.c                         |  252 -----------------
 arch/arm/mach-tegra/fuse.h                         |   79 ------
 arch/arm/mach-tegra/hotplug.c                      |    2 +-
 arch/arm/mach-tegra/platsmp.c                      |    2 +-
 arch/arm/mach-tegra/pm.c                           |    2 +-
 arch/arm/mach-tegra/pmc.c                          |    2 +-
 arch/arm/mach-tegra/powergate.c                    |    2 +-
 arch/arm/mach-tegra/reset-handler.S                |    2 +-
 arch/arm/mach-tegra/reset.c                        |    2 +-
 arch/arm/mach-tegra/sleep-tegra30.S                |    2 +-
 arch/arm/mach-tegra/tegra.c                        |    7 +-
 arch/arm/mach-tegra/tegra114_speedo.c              |  104 -------
 arch/arm/mach-tegra/tegra20_speedo.c               |  109 --------
 arch/arm/mach-tegra/tegra30_speedo.c               |  292 --------------------
 drivers/misc/Makefile                              |    1 +
 drivers/misc/fuse/Makefile                         |    1 +
 drivers/misc/fuse/tegra/Makefile                   |    8 +
 drivers/misc/fuse/tegra/fuse-tegra.c               |  154 ++++++++++
 drivers/misc/fuse/tegra/fuse-tegra20.c             |  214 ++++++++++++++
 drivers/misc/fuse/tegra/fuse-tegra30.c             |  223 +++++++++++++++
 drivers/misc/fuse/tegra/fuse.h                     |   71 +++++
 drivers/misc/fuse/tegra/speedo-tegra114.c          |  109 ++++++++
 drivers/misc/fuse/tegra/speedo-tegra124.c          |  167 +++++++++++
 drivers/misc/fuse/tegra/speedo-tegra20.c           |  109 ++++++++
 drivers/misc/fuse/tegra/speedo-tegra30.c           |  287 +++++++++++++++++++
 drivers/misc/fuse/tegra/tegra-apbmisc.c            |  110 ++++++++
 include/linux/tegra-soc.h                          |   42 +++
 39 files changed, 1633 insertions(+), 1083 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-tegra-fuse
 create mode 100644 Documentation/devicetree/bindings/fuse/nvidia,tegra20-fuse.txt
 create mode 100644 Documentation/devicetree/bindings/misc/nvidia,tegra20-apbmisc.txt
 delete mode 100644 arch/arm/mach-tegra/apbio.c
 delete mode 100644 arch/arm/mach-tegra/apbio.h
 delete mode 100644 arch/arm/mach-tegra/fuse.c
 delete mode 100644 arch/arm/mach-tegra/fuse.h
 delete mode 100644 arch/arm/mach-tegra/tegra114_speedo.c
 delete mode 100644 arch/arm/mach-tegra/tegra20_speedo.c
 delete mode 100644 arch/arm/mach-tegra/tegra30_speedo.c
 create mode 100644 drivers/misc/fuse/Makefile
 create mode 100644 drivers/misc/fuse/tegra/Makefile
 create mode 100644 drivers/misc/fuse/tegra/fuse-tegra.c
 create mode 100644 drivers/misc/fuse/tegra/fuse-tegra20.c
 create mode 100644 drivers/misc/fuse/tegra/fuse-tegra30.c
 create mode 100644 drivers/misc/fuse/tegra/fuse.h
 create mode 100644 drivers/misc/fuse/tegra/speedo-tegra114.c
 create mode 100644 drivers/misc/fuse/tegra/speedo-tegra124.c
 create mode 100644 drivers/misc/fuse/tegra/speedo-tegra20.c
 create mode 100644 drivers/misc/fuse/tegra/speedo-tegra30.c
 create mode 100644 drivers/misc/fuse/tegra/tegra-apbmisc.c

-- 
1.7.7.rc0.72.g4b5ea.dirty
