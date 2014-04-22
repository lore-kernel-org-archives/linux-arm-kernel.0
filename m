From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 22 Apr 2014 23:26:04 +0200
Subject: [PATCH v2 00/38] ARM: orion5x: big step towards DT conversion
Message-ID: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason, Andrew, Sebastian, Gregory,

Here is the second version of the Orion5x big DT migration: it moves
over to the Device Tree the probing of a large number of devices, up
to a point where on platform (edmini_v2) can be fully converted, and
three other platforms can be almost completely converted.

Summary of the patches:

 * Patches 1 and 2 are fixes that have already been taken by Jason
   Cooper in mvebu/fixes.

 * Patches 3 and 4 add the Orion pinctrl and Orion clock drivers
   respectively.

 * Patches 5 to 9 extend the existing mvebu-devbus driver to also
   cover the Orion platform.

 * Patches 10 to 33 progressively migrate the edmini_v2 platform more
   and more to the Device Tree, which mainly consists of SoC-level
   changes (using DT probed timer, clocks, etc.)

 * Patches 34, 35 and 36 convert three other Orion5x platforms to the
   Device Tree.

 * Patches 37 and 38 make some follow-up clean up in
   arch/arm/plat-orion/ of code that is no longer used after this DT
   migration.

Changes since v1:

The vast majority of the changes were made according to the
suggestions and review of Sebastian Hesselbarth. Thanks to him for the
very detailed review.

 * In the pinctrl driver:
   - change pci(rstout) to pcie(rstout)
   - rename double pci functions pci-1

 * In the clock driver:
   - use decimal values for shift values
   - join two similar cases

 * In the mvebu-devbus driver:
   - minor fixes in DT binding documentation
   - use _SHIFT instead of _BIT for Armada definitions
   - use _SHIFT where needed for Orion definitions, use BIT() directly
     in the macro definition for single bit fields, and define _MASK
     values.
   - introduce a devbus,keep-config DT property to make timing
     parameters optional, which is useful when migrating platforms to
     the Device Tree since we may not have their Device Bus timing
     details readily available.

 * Added Acked-by from Sebastian on the following patches:
   - ARM: orion5x: move interrupt controller node into ocp
   - ARM: orion5x: switch to preprocessor includes in DT
   - ARM: orion5x: use existing dt-bindings include for Device Tree files
   - ARM: orion5x: add interrupt for Ethernet in Device Tree
   - ARM: orion5x: switch to use the clock driver for DT platforms
   - ARM: orion5x: enable pinctrl driver at SoC level
   - ARM: orion5x: add Device Bus description at SoC level
   - ARM: orion5x: update I2C description at SoC level
   - ARM: orion5x: update I2C description at SoC level
   - ARM: orion5x: remove unneeded code for edmini_v2

 * Numerous Device Tree improvements:
   - add node labels for all devices, and used them in the .dts
     files.
   - add linux,stdout-path chosen property.
   - add missing chosen and memory nodes for d2net
   - use the clocks property instead of the clock-frequency property
     for UART controllers, and fixed board DTs accordingly.
   - rename the xor node to dma-controller, to match ePAPR.
   - rename gpio_leds to gpio-leds and gpio_keys to gpio-keys.
   - use GPIO dt-bindings header file where possible.
   - use vendor prefixes for I2C devices

 * Changed board-dt.c to call mvebu_mbus_dt_init() in
   ->init_machine(), which allows to remove ->init_time() entirely.

 * One more board converted to the Device Tree: the Maxtor Shared
   Storage II.

Thomas

Thomas Petazzoni (38):
  ARM: orion5x: fix target ID for crypto SRAM window
  memory: mvebu-devbus: fix the conversion of the bus width
  pinctrl: mvebu: new driver for Orion platforms
  clk: mvebu: add Orion5x clock driver
  memory: mvebu-devbus: use ARMADA_ prefix in defines
  memory: mvebu-devbus: use _SHIFT suffixes instead of _BIT
  memory: mvebu-devbus: split functions
  memory: mvebu-devbus: add Orion5x support
  memory: mvebu-devbus: add a devbus,keep-config property
  ARM: orion5x: move interrupt controller node into ocp
  ARM: orion5x: switch to preprocessor includes in DT
  ARM: orion5x: use existing dt-bindings include for Device Tree files
  ARM: orion5x: convert DT to use the mvebu-mbus driver
  ARM: orion5x: add node labels in Orion5x SoC Device Tree file
  ARM: orion5x: use gpio-keys and gpio-leds instead of
    gpio_keys/gpio_leds in edmini_v2
  ARM: orion5x: add linux,stdout-path to edmini_v2
  ARM: orion5x: use node labels for UART and SATA on edmini_v2
  ARM: orion5x: rename XOR node to dma-controller@<address>
  ARM: orion5x: add interrupt for Ethernet in Device Tree
  ARM: orion5x: switch to use the clock driver for DT platforms
  ARM: orion5x: convert to use 'clocks' property for UART controllers
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
  ARM: orion5x: convert Maxtor Shared Storage II to the Device Tree
  ARM: orion: remove no longer needed DT IRQ code
  ARM: orion: remove no longer needed gpio DT code

 .../devicetree/bindings/clock/mvebu-core-clock.txt |   8 +
 .../bindings/memory-controllers/mvebu-devbus.txt   |  32 +-
 .../bindings/pinctrl/marvell,orion-pinctrl.txt     |  91 +++++
 arch/arm/boot/dts/Makefile                         |   5 +-
 arch/arm/boot/dts/orion5x-lacie-d2-network.dts     | 236 +++++++++++++
 .../dts/orion5x-lacie-ethernet-disk-mini-v2.dts    | 141 ++++++--
 .../boot/dts/orion5x-maxtor-shared-storage-2.dts   | 178 ++++++++++
 arch/arm/boot/dts/orion5x-mv88f5182.dtsi           |  45 +++
 arch/arm/boot/dts/orion5x-rd88f5182-nas.dts        | 177 ++++++++++
 arch/arm/boot/dts/orion5x.dtsi                     | 289 +++++++++-------
 arch/arm/mach-dove/irq.c                           |  36 ++
 arch/arm/mach-kirkwood/irq.c                       |  36 ++
 arch/arm/mach-orion5x/Kconfig                      |  37 +--
 arch/arm/mach-orion5x/Makefile                     |   7 +-
 arch/arm/mach-orion5x/board-d2net.c                | 109 ++++++
 arch/arm/mach-orion5x/board-dt.c                   |  18 +-
 arch/arm/mach-orion5x/board-mss2.c                 |  90 +++++
 arch/arm/mach-orion5x/board-rd88f5182.c            | 116 +++++++
 arch/arm/mach-orion5x/common.h                     |  15 +-
 arch/arm/mach-orion5x/d2net-setup.c                | 365 ---------------------
 arch/arm/mach-orion5x/edmini_v2-setup.c            | 169 ----------
 arch/arm/mach-orion5x/irq.c                        |  28 ++
 arch/arm/mach-orion5x/mss2-setup.c                 | 274 ----------------
 arch/arm/plat-orion/gpio.c                         |  48 ---
 arch/arm/plat-orion/include/plat/irq.h             |   1 -
 arch/arm/plat-orion/include/plat/orion-gpio.h      |   1 -
 arch/arm/plat-orion/irq.c                          |  77 -----
 drivers/clk/mvebu/Kconfig                          |   4 +
 drivers/clk/mvebu/Makefile                         |   1 +
 drivers/clk/mvebu/orion.c                          | 210 ++++++++++++
 drivers/memory/mvebu-devbus.c                      | 234 +++++++++----
 drivers/pinctrl/mvebu/Kconfig                      |   4 +
 drivers/pinctrl/mvebu/Makefile                     |   1 +
 drivers/pinctrl/mvebu/pinctrl-orion.c              | 261 +++++++++++++++
 34 files changed, 2162 insertions(+), 1182 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,orion-pinctrl.txt
 create mode 100644 arch/arm/boot/dts/orion5x-lacie-d2-network.dts
 create mode 100644 arch/arm/boot/dts/orion5x-maxtor-shared-storage-2.dts
 create mode 100644 arch/arm/boot/dts/orion5x-mv88f5182.dtsi
 create mode 100644 arch/arm/boot/dts/orion5x-rd88f5182-nas.dts
 create mode 100644 arch/arm/mach-orion5x/board-d2net.c
 create mode 100644 arch/arm/mach-orion5x/board-mss2.c
 create mode 100644 arch/arm/mach-orion5x/board-rd88f5182.c
 delete mode 100644 arch/arm/mach-orion5x/d2net-setup.c
 delete mode 100644 arch/arm/mach-orion5x/edmini_v2-setup.c
 delete mode 100644 arch/arm/mach-orion5x/mss2-setup.c
 create mode 100644 drivers/clk/mvebu/orion.c
 create mode 100644 drivers/pinctrl/mvebu/pinctrl-orion.c

-- 
1.9.2
