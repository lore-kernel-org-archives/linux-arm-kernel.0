From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 13 Apr 2014 16:39:37 +0200
Subject: [PATCH 00/29] ARM: orion5x: big step towards DT conversion
Message-ID: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This set of patches make a big step towards converting mach-orion5x to
use the Device Tree: one board (edmini_v2) is fully converted and two
other boards are almost fully converted (rd88f5182 and d2-net).

Summary of the patches:

 * PATCH 1 is a fix for a MBus window target ID that was wrong since
   v3.12, so it should be pushed to stable.

 * PATCH 2 adds the Orion pinctrl driver.

 * PATCH 3 adds the Orion clock driver.

 * PATCH 4 to 7 adds Orion support to the mvebu-devbus driver. PATCH 4
   was already sent as a fix for the mvebu-devbus driver.

 * PATCH 5 to 19 improve the DT conversion of Orion5x, by converting
   it to use the MBus DT binding, the pinctrl, timer described in the
   Device Tree, etc.

 * PATCH 20 to 25 finish the conversion of the edmini_v2 platform to
   Device Tree.

 * PATCH 26 and 27 convert two other platforms to the Device Tree.

 * PATCH 28 and 29 remove some code in plat-orion/ that is now useless
   after this patch series.

This code has been test on Marvell RD-88F5182 and LaCie edmini_v2. The
conversion of LaCie d2-net was done without testing, due to the lack
of hardware.

This set of patches is based on the latest Linus master (so it should
be closed to something based on the upcoming 3.15-rc1), and it also
available at:

  https://github.com/MISL-EBU-System-SW/mainline-public/tree/3.15/orion

Review, comments, testing welcome.

Thanks!

Thomas

Thomas Petazzoni (29):
  ARM: orion5x: fix target ID for crypto SRAM window
  pinctrl: mvebu: new driver for Orion platforms
  clk: mvebu: add Orion5x clock driver
  memory: mvebu-devbus: fix the conversion of the bus width
  memory: mvebu-devbus: use ARMADA_ prefix in defines
  memory: mvebu-devbus: split functions
  memory: mvebu-devbus: add Orion5x support
  ARM: orion5x: move interrupt controller node into ocp
  ARM: orion5x: switch to preprocessor includes in DT
  ARM: orion5x: use existing dt-bindings include for Device Tree files
  ARM: orion5x: convert DT to use the mvebu-mbus driver
  ARM: orion5x: add interrupt for Ethernet in Device Tree
  ARM: orion5x: switch to use the clock driver for DT platforms
  ARM: orion: switch to a per-platform handle_irq() function
  ARM: orion5x: switch to DT interrupts and timer
  ARM: orion5x: enable pinctrl driver at SoC level
  ARM: orion5x: update I2C description at SoC level
  ARM: orion5x: add Device Bus description at SoC level
  ARM: orion5x: add standard pinctrl configs for sata0 and sata1
  ARM: orion5x: convert edmini_v2 to DT pinctrl
  ARM: orion5x: use DT to describe I2C devices on edmini_v2
  ARM: orion5x: use DT to describe EHCI on edmini_v2
  ARM: orion5x: use DT to describe NOR on edmini_v2
  ARM: orion5x: keep TODO list in edmini_v2 DT
  ARM: orion5x: remove unneeded code for edmini_v2
  ARM: orion5x: convert RD-88F5182 to Device Tree
  ARM: orion5x: convert d2net to Device Tree
  ARM: orion: remove no longer needed DT IRQ code
  ARM: orion: remove no longer needed gpio DT code

 .../devicetree/bindings/clock/mvebu-core-clock.txt |   8 +
 .../bindings/memory-controllers/mvebu-devbus.txt   |  25 +-
 .../bindings/pinctrl/marvell,orion-pinctrl.txt     |  91 +++++
 arch/arm/boot/dts/Makefile                         |   4 +-
 arch/arm/boot/dts/orion5x-lacie-d2-network.dts     | 234 +++++++++++++
 .../dts/orion5x-lacie-ethernet-disk-mini-v2.dts    | 128 +++++++-
 arch/arm/boot/dts/orion5x-mv88f5182.dtsi           |  45 +++
 arch/arm/boot/dts/orion5x-rd88f5182-nas.dts        | 155 +++++++++
 arch/arm/boot/dts/orion5x.dtsi                     | 287 +++++++++-------
 arch/arm/mach-dove/irq.c                           |  36 ++
 arch/arm/mach-kirkwood/irq.c                       |  36 ++
 arch/arm/mach-orion5x/Kconfig                      |  32 +-
 arch/arm/mach-orion5x/Makefile                     |   5 +-
 arch/arm/mach-orion5x/board-d2net.c                | 109 ++++++
 arch/arm/mach-orion5x/board-dt.c                   |  23 +-
 arch/arm/mach-orion5x/board-rd88f5182.c            | 116 +++++++
 arch/arm/mach-orion5x/common.h                     |   9 +-
 arch/arm/mach-orion5x/d2net-setup.c                | 365 ---------------------
 arch/arm/mach-orion5x/edmini_v2-setup.c            | 169 ----------
 arch/arm/mach-orion5x/irq.c                        |  28 ++
 arch/arm/plat-orion/gpio.c                         |  48 ---
 arch/arm/plat-orion/include/plat/irq.h             |   1 -
 arch/arm/plat-orion/include/plat/orion-gpio.h      |   1 -
 arch/arm/plat-orion/irq.c                          |  77 -----
 drivers/clk/mvebu/Kconfig                          |   4 +
 drivers/clk/mvebu/Makefile                         |   1 +
 drivers/clk/mvebu/orion.c                          | 212 ++++++++++++
 drivers/memory/mvebu-devbus.c                      | 209 ++++++++----
 drivers/pinctrl/mvebu/Kconfig                      |   4 +
 drivers/pinctrl/mvebu/Makefile                     |   1 +
 drivers/pinctrl/mvebu/pinctrl-orion.c              | 261 +++++++++++++++
 31 files changed, 1830 insertions(+), 894 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,orion-pinctrl.txt
 create mode 100644 arch/arm/boot/dts/orion5x-lacie-d2-network.dts
 create mode 100644 arch/arm/boot/dts/orion5x-mv88f5182.dtsi
 create mode 100644 arch/arm/boot/dts/orion5x-rd88f5182-nas.dts
 create mode 100644 arch/arm/mach-orion5x/board-d2net.c
 create mode 100644 arch/arm/mach-orion5x/board-rd88f5182.c
 delete mode 100644 arch/arm/mach-orion5x/d2net-setup.c
 delete mode 100644 arch/arm/mach-orion5x/edmini_v2-setup.c
 create mode 100644 drivers/clk/mvebu/orion.c
 create mode 100644 drivers/pinctrl/mvebu/pinctrl-orion.c

-- 
1.8.3.2
