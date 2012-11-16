From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 16 Nov 2012 22:20:21 +0100
Subject: [PATCHv2 0/7] Add basic support for Allwinner A1X SoCs
Message-ID: <1353100828-9218-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

You'll find in this patchset the initial support for Allwinner A10 and A13 SoCs
from Allwinner. Since the internal name of these SoCs are sun4i and sun5i, the
mach- directory is named sunxi.

You can find these SoCs in the Cubieboard, the A13-olinuxino or the Melee
A1000.

Both SoCs should work fine, as the A13 is a trimmed down version of the A10,
but it has only been tested on a A13-OlinuXino from Olimex.

Support is quite minimal for now, since it only includes timer and IRQ
controller drivers, so we can only boot to userspace through initramfs. Support
for the other peripherals on these SoCs will come eventually.

Thanks,
Maxime

Changes from v1:
  - Changed the earlyprintk support to add a more generic mechanism, since boards
    can have both the debug UART on UART0 or UART1
  - Small fixes in the dt: moved the memory node to the dtsi, fixed the memory
    size on A13
  - Simplified the irq controller driver as suggested by Stefan Roese
  - Removed the hardcoded clock frequency in the timer to a fixed rate clock using
    clk framework
  - Added a README file to the documentation to mention the supported SoCs and the
    related datasheet

Maxime Ripard (7):
  clk: sunxi: Add dummy fixed rate clock for Allwinner A1X SoCs
  clocksource: sunxi: Add Allwinner A1X Timer Driver
  irqchip: sunxi: Add irq controller driver
  ARM: sunxi: Add basic support for Allwinner A1x SoCs
  ARM: sunxi: Add earlyprintk support
  ARM: sunxi: Add device tree for the A13 and the Olinuxino board
  ARM: sunxi: Add entry to MAINTAINERS

 Documentation/arm/sunxi/README                     |   19 +++
 .../interrupt-controller/allwinner,sunxi-ic.txt    |  104 ++++++++++++
 .../bindings/timer/allwinner,sunxi-timer.txt       |   17 ++
 MAINTAINERS                                        |    6 +
 arch/arm/Kconfig                                   |    2 +
 arch/arm/Kconfig.debug                             |    8 +
 arch/arm/Makefile                                  |    1 +
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/sun5i-olinuxino.dts              |   26 +++
 arch/arm/boot/dts/sun5i.dtsi                       |   74 +++++++++
 arch/arm/include/debug/sunxi.S                     |   24 +++
 arch/arm/mach-sunxi/Kconfig                        |    9 ++
 arch/arm/mach-sunxi/Makefile                       |    1 +
 arch/arm/mach-sunxi/Makefile.boot                  |    1 +
 arch/arm/mach-sunxi/sunxi.c                        |   60 +++++++
 arch/arm/mach-sunxi/sunxi.h                        |   20 +++
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-sunxi.c                            |   30 ++++
 drivers/clocksource/Kconfig                        |    3 +
 drivers/clocksource/Makefile                       |    1 +
 drivers/clocksource/sunxi_timer.c                  |  170 ++++++++++++++++++++
 drivers/irqchip/Makefile                           |    1 +
 drivers/irqchip/irq-sunxi.c                        |  150 +++++++++++++++++
 include/linux/clk/sunxi.h                          |   22 +++
 include/linux/irqchip/sunxi.h                      |   27 ++++
 include/linux/sunxi_timer.h                        |   24 +++
 26 files changed, 802 insertions(+)
 create mode 100644 Documentation/arm/sunxi/README
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/allwinner,sunxi-ic.txt
 create mode 100644 Documentation/devicetree/bindings/timer/allwinner,sunxi-timer.txt
 create mode 100644 arch/arm/boot/dts/sun5i-olinuxino.dts
 create mode 100644 arch/arm/boot/dts/sun5i.dtsi
 create mode 100644 arch/arm/include/debug/sunxi.S
 create mode 100644 arch/arm/mach-sunxi/Kconfig
 create mode 100644 arch/arm/mach-sunxi/Makefile
 create mode 100644 arch/arm/mach-sunxi/Makefile.boot
 create mode 100644 arch/arm/mach-sunxi/sunxi.c
 create mode 100644 arch/arm/mach-sunxi/sunxi.h
 create mode 100644 drivers/clk/clk-sunxi.c
 create mode 100644 drivers/clocksource/sunxi_timer.c
 create mode 100644 drivers/irqchip/irq-sunxi.c
 create mode 100644 include/linux/clk/sunxi.h
 create mode 100644 include/linux/irqchip/sunxi.h
 create mode 100644 include/linux/sunxi_timer.h

-- 
1.7.9.5
