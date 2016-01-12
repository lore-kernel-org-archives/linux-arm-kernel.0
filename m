From: andy.yan@rock-chips.com (Andy Yan)
Date: Tue, 12 Jan 2016 19:27:09 +0800
Subject: [PATCH v2 0/4] add reboot mode driver
Message-ID: <1452598029-8222-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This driver parse the reboot commands like "reboot loader"
and "reboot recovery" to get a boot mode described in the
device tree , then call the corresponding  write interface
to store the boot mode magic value in some persistent storage
like special register or ram , which can be read by the bootloader
after system reboot.

This is commonly used on Android based devices, which in order
to reboot the device into fastboot or recovery mode.

Before this patch , I have try some hack on[0], and then found
John Stultz also doing the same work[1].

As John is busy these days, I go on with this work.

[0]https://patchwork.kernel.org/patch/7647751/
[1]https://patchwork.kernel.org/patch/7802391/

Changes in v2:
- move to dir drivers/power/reset/
- make syscon-reboot-mode a generic driver
- make this DT node as a subnode of PMU/PMUGRF

Changes in v1:
- fix the embarrassed compile warning
- correct the maskrom magic number
- check for the normal reboot
- correct the maskrom magic number
- use macro defined in rockchip_boot-mode.h for reboot-mode DT node

Andy Yan (4):
  dt-bindings: power: reset: add document for reboot-mode driver
  power: reset: add reboot mode driver
  ARM: dts: rockchip: add syscon-reboot-mode node
  ARM64: dts: rockchip: add syscon-reboot-mode DT node

 .../bindings/power/reset/reboot-mode.txt           |  41 +++++++++
 .../bindings/power/reset/syscon-reboot-mode.txt    |  52 +++++++++++
 arch/arm/boot/dts/rk3288.dtsi                      |  31 +++++++
 arch/arm/boot/dts/rk3xxx.dtsi                      |  33 ++++++-
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |  33 ++++++-
 drivers/power/reset/Kconfig                        |  16 ++++
 drivers/power/reset/Makefile                       |   2 +
 drivers/power/reset/reboot-mode.c                  | 100 +++++++++++++++++++++
 drivers/power/reset/reboot-mode.h                  |   6 ++
 drivers/power/reset/syscon-reboot-mode.c           |  62 +++++++++++++
 include/dt-bindings/soc/rockchip_boot-mode.h       |  30 +++++++
 11 files changed, 404 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/reboot-mode.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt
 create mode 100644 drivers/power/reset/reboot-mode.c
 create mode 100644 drivers/power/reset/reboot-mode.h
 create mode 100644 drivers/power/reset/syscon-reboot-mode.c
 create mode 100644 include/dt-bindings/soc/rockchip_boot-mode.h

-- 
1.9.1
