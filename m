From: ynvich@gmail.com (Sergei Ianovich)
Date: Fri, 13 Dec 2013 06:27:09 +0400
Subject: [PATCH v2 00/16] ARM: support for ICP DAS LP-8x4x (with dts)
In-Reply-To: <1386543229-1542-1-git-send-email-ynvich@gmail.com>
References: <1386543229-1542-1-git-send-email-ynvich@gmail.com>
Message-ID: <1386901645-28895-1-git-send-email-ynvich@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixed most review requirements. Details in respective patches.

I've completely met the requirement for using dmaengine-based DMA
in patch v2-03/16. Tests showed new DMA was underperforming. It added
on top of a pre-existing problem with MMC bus width and made the system
barely usable. However, the new code in this patch work correctly with
both the existing and the new DMA. Even if the new DMA is compiled into
the kernel, the exisitng DMA initializes first.

I've also decided not to create a single mfd device for
machine-specific devices. Instead each type is supported by a separate
driver in respective subsystem. It was tempting to hardcode all the
constants in one source file, but that requires ugly initialization.
The taken way produces much cleaner code.

Sergei Ianovich (16):
  ARM: dts: pxa2xx fix compatible strings
  ARM: dts: fix pxa27x-gpio interrupts
  ARM: dts: provide DMA config to pxamci
  ARM: dts: pxa3xx: move declaration to header
  ARM: dts: pxa27x: irq init using device tree
  ARM: pxa27x: device tree support ICP DAS LP-8x4x
  rtc: support DS1302 RTC on ICP DAS LP-8x4x
  mtd: support BB SRAM on ICP DAS LP-8x4x
  ARM: pxa: support ICP DAS LP-8x4x FPGA irq
  serial: support for 16550A serial ports on LP-8x4x
  misc: support for LP-8x4x custom parallel bus
  misc: support for serial slots in LP-8x4x
  misc: support for parallel slots in LP-8x4x
  misc: support for I-8041 in LP-8x4x
  misc: support for I-8042 in LP-8x4x
  misc: support for I-8024 in LP-8x4x

 .../bindings/interrupt-controller/irq-lp8x4x.txt   |  49 ++
 .../devicetree/bindings/misc/lp8x4x-bus.txt        |  18 +
 Documentation/devicetree/bindings/mmc/pxa-mmc.txt  |   5 +
 .../devicetree/bindings/rtc/rtc-ds1302.txt         |  14 +
 .../devicetree/bindings/serial/lp8x4x-serial.txt   |  35 ++
 Documentation/misc-devices/lp8x4x_bus.txt          |  74 +++
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/pxa27x-lp8x4x.dts                | 165 ++++++
 arch/arm/boot/dts/pxa27x.dtsi                      |  20 +
 arch/arm/boot/dts/pxa2xx.dtsi                      |   5 +-
 arch/arm/configs/lp8x4x_defconfig                  | 164 ++++++
 arch/arm/mach-pxa/Kconfig                          |  15 +
 arch/arm/mach-pxa/Makefile                         |   1 +
 arch/arm/mach-pxa/include/mach/irqs.h              |   2 +
 arch/arm/mach-pxa/include/mach/pxa27x.h            |   1 +
 arch/arm/mach-pxa/pxa27x-dt.c                      |  64 +++
 arch/arm/mach-pxa/pxa27x.c                         |  10 +
 arch/arm/mach-pxa/pxa3xx.c                         |   2 -
 drivers/irqchip/Kconfig                            |   5 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-lp8x4x.c                       | 238 +++++++++
 drivers/misc/Kconfig                               |  13 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/lp8x4x_bus.c                          | 570 +++++++++++++++++++++
 drivers/mmc/host/pxamci.c                          |  59 ++-
 drivers/mtd/devices/Kconfig                        |  14 +
 drivers/mtd/devices/Makefile                       |   1 +
 drivers/mtd/devices/sram_lp8x4x.c                  | 227 ++++++++
 drivers/rtc/Kconfig                                |   2 +-
 drivers/rtc/rtc-ds1302.c                           | 111 +++-
 drivers/tty/serial/8250/8250_lp8x4x.c              | 161 ++++++
 drivers/tty/serial/8250/Kconfig                    |  12 +
 drivers/tty/serial/8250/Makefile                   |   1 +
 33 files changed, 2042 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/irq-lp8x4x.txt
 create mode 100644 Documentation/devicetree/bindings/misc/lp8x4x-bus.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-ds1302.txt
 create mode 100644 Documentation/devicetree/bindings/serial/lp8x4x-serial.txt
 create mode 100644 Documentation/misc-devices/lp8x4x_bus.txt
 create mode 100644 arch/arm/boot/dts/pxa27x-lp8x4x.dts
 create mode 100644 arch/arm/configs/lp8x4x_defconfig
 create mode 100644 arch/arm/mach-pxa/pxa27x-dt.c
 create mode 100644 drivers/irqchip/irq-lp8x4x.c
 create mode 100644 drivers/misc/lp8x4x_bus.c
 create mode 100644 drivers/mtd/devices/sram_lp8x4x.c
 create mode 100644 drivers/tty/serial/8250/8250_lp8x4x.c

-- 
1.8.4.3
