From: andy.yan@rock-chips.com (Andy Yan)
Date: Wed, 30 Mar 2016 10:18:24 +0800
Subject: [PATCH v7 0/4] add reboot mode driver
Message-ID: <1459304304-9713-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This driver parses the reboot commands like "reboot bootloader"
and "reboot recovery" to get a boot mode described in the
device tree , then call the corresponding  write interfae
to store the boot mode in some place like special register
or ram, which can be read by the bootloader after system
reboot.

This is commonly done on Android based devices, in order to
reboot the device into fastboot or recovery mode.


Changes in v7:
- fix some spelling mistakes
- declare that the mode magic should be none-zero value
- address some suggestions from Krzysztof, make syscon-reboot-mode driver data self-contained.

Changes in v6:
- fix a typo with "property"
- describe property "mask" more clear

Changes in v5:
- delete a unnecessary blank line in syscon-reboot-mode.txt
- rename mode-fastoboot to mode-bootloader in syscon-reboot-mode.txt
- rename macro BOOT_LOADER to BOOT_BL_DOWNLOAD, which gives a more clear mean
- use two blank space under help in Kconfig
- use unsigned int instead of int for member magic in struct mode_info

Changes in v4:
- remove mode-maskrom
- rename mode-fastboot to mode-bootloader to keep compatible with the exiting Android device
- make this driver depends on OF to avoid kbuild test error

Changes in v3:
- descirbe all reboot mode as properity instead of subnode
- scan multi properities
- add mask value for some platform which only use some bits of the register
  to store boot mode magic value
- descirbe all reboot mode as property instead of subnode
- add rk3036 support
- descirbe all reboot mode as property instead of subnode

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
  ARM: dts: rockchip: add syscon-reboot-mode DT node
  ARM64: dts: rockchip: add syscon-reboot-mode DT node

 .../bindings/power/reset/reboot-mode.txt           |  25 +++++
 .../bindings/power/reset/syscon-reboot-mode.txt    |  35 +++++++
 arch/arm/boot/dts/rk3036.dtsi                      |  11 +-
 arch/arm/boot/dts/rk3288.dtsi                      |  10 ++
 arch/arm/boot/dts/rk3xxx.dtsi                      |  12 ++-
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |  12 ++-
 drivers/power/reset/Kconfig                        |  13 +++
 drivers/power/reset/Makefile                       |   2 +
 drivers/power/reset/reboot-mode.c                  | 115 +++++++++++++++++++++
 drivers/power/reset/reboot-mode.h                  |   6 ++
 drivers/power/reset/syscon-reboot-mode.c           |  86 +++++++++++++++
 include/dt-bindings/soc/rockchip_boot-mode.h       |  15 +++
 12 files changed, 339 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/reboot-mode.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt
 create mode 100644 drivers/power/reset/reboot-mode.c
 create mode 100644 drivers/power/reset/reboot-mode.h
 create mode 100644 drivers/power/reset/syscon-reboot-mode.c
 create mode 100644 include/dt-bindings/soc/rockchip_boot-mode.h

-- 
1.9.1
