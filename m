From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Thu, 17 Aug 2017 21:54:07 +0300
Subject: [PATCH 0/6] Host1x and VIC support for Tegra186
Message-ID: <20170817185413.6324-1-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

this series adds basic support for the Host1x channel engine and the
VIC 2d compositor unit on Tegra186. The first three patches do the
required device tree changes, the fourth patch updates the device tree
binding documentation, and the two remaining patches add the actual
implementation, almost all of which is in Host1x itself.

The Tegra186 Host1x is a relatively large update over previous
generations, which can be seen in the diffstat. The biggest change is
that Host1x is now contains separate hypervisor and vm register
apertures to support virtualization at the hardware level. This driver,
however, currently assumes that this instance of Linux is the sole
operating system having access to the hardware.

This combined with increased numbers of supported channels and
syncpoints have caused a number of register space changes that are
responsible for most of the updated code.

The series has been tested on the Jetson TX1 (T210) and TX2 (T186)
using the host1x_test test suite available at

http://github.com/cyndis/host1x_test

The series itself is available at

http://github.com/cyndis/linux, branch host1x-t186-1

Cheers,
Mikko

Mikko Perttunen (6):
  arm64: tegra: Add #power-domain-cells for BPMP
  arm64: tegra: Add host1x on Tegra186
  arm64: tegra: Add VIC on Tegra186
  dt-bindings: host1x: Fix and add Tegra186 information
  gpu: host1x: Add Tegra186 support
  drm/tegra: Add Tegra186 support for VIC

 .../display/tegra/nvidia,tegra20-host1x.txt        |   9 +-
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |  31 ++++
 drivers/gpu/drm/tegra/drm.c                        |   1 +
 drivers/gpu/drm/tegra/vic.c                        |  10 ++
 drivers/gpu/host1x/Makefile                        |   3 +-
 drivers/gpu/host1x/dev.c                           |  60 ++++++-
 drivers/gpu/host1x/dev.h                           |   4 +
 drivers/gpu/host1x/hw/cdma_hw.c                    |  49 +++---
 drivers/gpu/host1x/hw/debug_hw.c                   | 137 +---------------
 .../gpu/host1x/hw/{debug_hw.c => debug_hw_1x01.c}  | 160 ------------------
 drivers/gpu/host1x/hw/debug_hw_1x06.c              | 133 +++++++++++++++
 drivers/gpu/host1x/hw/host1x01.c                   |   2 +
 drivers/gpu/host1x/hw/host1x02.c                   |   2 +
 drivers/gpu/host1x/hw/host1x04.c                   |   2 +
 drivers/gpu/host1x/hw/host1x05.c                   |   2 +
 drivers/gpu/host1x/hw/{host1x02.c => host1x06.c}   |  12 +-
 drivers/gpu/host1x/hw/{host1x02.c => host1x06.h}   |  30 +---
 drivers/gpu/host1x/hw/host1x06_hardware.h          | 142 ++++++++++++++++
 drivers/gpu/host1x/hw/hw_host1x06_hypervisor.h     |  32 ++++
 drivers/gpu/host1x/hw/hw_host1x06_uclass.h         | 181 +++++++++++++++++++++
 drivers/gpu/host1x/hw/hw_host1x06_vm.h             |  47 ++++++
 drivers/gpu/host1x/hw/intr_hw.c                    |  29 ++--
 22 files changed, 719 insertions(+), 359 deletions(-)
 copy drivers/gpu/host1x/hw/{debug_hw.c => debug_hw_1x01.c} (53%)
 create mode 100644 drivers/gpu/host1x/hw/debug_hw_1x06.c
 copy drivers/gpu/host1x/hw/{host1x02.c => host1x06.c} (84%)
 copy drivers/gpu/host1x/hw/{host1x02.c => host1x06.h} (50%)
 create mode 100644 drivers/gpu/host1x/hw/host1x06_hardware.h
 create mode 100644 drivers/gpu/host1x/hw/hw_host1x06_hypervisor.h
 create mode 100644 drivers/gpu/host1x/hw/hw_host1x06_uclass.h
 create mode 100644 drivers/gpu/host1x/hw/hw_host1x06_vm.h

-- 
2.14.1
