From: andy.yan@rock-chips.com (Andy Yan)
Date: Tue,  2 Feb 2016 17:56:21 +0800
Subject: [PATCH v3 0/4] add reboot mode driver
Message-ID: <1454406981-4692-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This driver parse the reboot commands like "reboot loader"
and "reboot recovery" to get a boot mode described in the
device tree , then call the corresponding  write interfae
to store the boot mode in some place like special register
or ram , which can be read by the bootloader after system
reboot.

This is commonly done on Android based devices, in order to
reboot the device into fastboot or recovery mode.

Changes in v3:
- descirbe all reboot mode as properity instead of subnode
- add mask value for some platform which only use some bits of the register
  to store boot mode magic value
- add rk3036 support

Changes in v2:
- move to dir drivers/power/reset/
- make syscon-reboot-mode a generic driver
- make this node as a subnode of PMU
- make this node as a subnode of pmugrf

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

 .../bindings/power/reset/reboot-mode.txt           |  26 +++++
 .../bindings/power/reset/syscon-reboot-mode.txt    |  36 +++++++
 arch/arm/boot/dts/rk3036.dtsi                      |  10 +-
 arch/arm/boot/dts/rk3288.dtsi                      |  11 +++
 arch/arm/boot/dts/rk3xxx.dtsi                      |  13 ++-
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |  14 ++-
 drivers/power/reset/Kconfig                        |  16 ++++
 drivers/power/reset/Makefile                       |   2 +
 drivers/power/reset/reboot-mode.c                  | 105 +++++++++++++++++++++
 drivers/power/reset/reboot-mode.h                  |   6 ++
 drivers/power/reset/syscon-reboot-mode.c           |  64 +++++++++++++
 include/dt-bindings/soc/rockchip_boot-mode.h       |  30 ++++++
 12 files changed, 330 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/reboot-mode.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt
 create mode 100644 drivers/power/reset/reboot-mode.c
 create mode 100644 drivers/power/reset/reboot-mode.h
 create mode 100644 drivers/power/reset/syscon-reboot-mode.c
 create mode 100644 include/dt-bindings/soc/rockchip_boot-mode.h

-- 
1.9.1
