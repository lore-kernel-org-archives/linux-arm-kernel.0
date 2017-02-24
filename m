From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri, 24 Feb 2017 04:40:38 +0100
Subject: [PATCH v2 00/17] ARM: Initial Actions Semi S500 and S900 enablement
Message-ID: <20170224034055.18807-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series adds initial support for Actions Semiconductor S500 (ARMv7) and
S900 (ARMv8) SoCs.

In addition to earlycon serial output, v2 includes a serial console driver RFC.
Guitar output is coming further along thanks to a new timer implementation, but
is still earlycon only - to be investigated. Bubblegum-96 reaches an initrd,
but a small part of the serial output just before is lost (visible in dmesg).

https://github.com/afaerber/linux/commits/bg96-next

Booting from U-Boot is straightforward on both boards:

https://en.opensuse.org/HCL:Guitar
https://en.opensuse.org/HCL:Bubblegum-96

Have a lot of fun!

Cheers,
Andreas

v1 -> v2:
* S900 DT fixes (Mark)
* Kconfig name changes (Arnd)
* Bubblegum-96 .dts rename
* Vendor prefix rename
* Minor cleanups
* Add serial driver
* Add MAINTAINERS section
* Use SPDX-License-Identifier in DT (Rob)
* Add clocksource driver

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh@kernel.org>
Cc: mp-cs at actions-semi.com
Cc: 96boards at ucrobotics.com
Cc: support at lemaker.org
Cc: devicetree at vger.kernel.org

Andreas F?rber (17):
  dt-bindings: Add vendor prefix for Actions Semi
  dt-bindings: arm: Document Actions Semi S500
  dt-bindings: timer: Document Owl timer
  clocksource: Add Owl timer
  ARM: Prepare Actions Semi S500
  ARM64: Prepare Actions Semi S900
  dt-bindings: serial: Document Actions Semi Owl UARTs
  tty: serial: Add Actions Semi Owl UART earlycon
  Documentation: kernel-parameters: Document owl earlycon
  ARM: dts: Add Actions Semi S500 and LeMaker Guitar
  dt-bindings: Add vendor prefix for uCRobotics
  dt-bindings: arm: Document Actions Semi S900
  ARM64: dts: Add Actions Semi S900 and Bubblegum-96
  MAINTAINERS: Add Actions Semi Owl section
  tty: serial: owl: Implement console driver
  ARM64: dts: actions: s900-bubblegum-96: Add fake uart5 clk
  ARM: dts: s500-guitar-bb-rev-b: Add fake uart3 clock

 Documentation/admin-guide/kernel-parameters.txt    |   6 +
 Documentation/devicetree/bindings/arm/actions.txt  |  39 ++
 .../bindings/serial/actions,owl-uart.txt           |  16 +
 .../bindings/timer/actions,owl-timer.txt           |  16 +
 .../devicetree/bindings/vendor-prefixes.txt        |   2 +
 MAINTAINERS                                        |  10 +
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/s500-guitar-bb-rev-b.dts         |  33 +
 arch/arm/boot/dts/s500-guitar.dtsi                 |  20 +
 arch/arm/boot/dts/s500.dtsi                        | 135 ++++
 arch/arm/mach-actions/Kconfig                      |  10 +
 arch/arm/mach-actions/Makefile                     |   1 +
 arch/arm/mach-actions/owl.c                        |  28 +
 arch/arm64/Kconfig.platforms                       |   5 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/actions/Makefile               |   5 +
 arch/arm64/boot/dts/actions/s900-bubblegum-96.dts  |  38 ++
 arch/arm64/boot/dts/actions/s900.dtsi              | 109 ++++
 drivers/clocksource/Kconfig                        |   7 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/owl-timer.c                    | 146 +++++
 drivers/tty/serial/Kconfig                         |  19 +
 drivers/tty/serial/Makefile                        |   1 +
 drivers/tty/serial/owl-uart.c                      | 707 +++++++++++++++++++++
 include/uapi/linux/serial_core.h                   |   3 +
 27 files changed, 1363 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/actions.txt
 create mode 100644 Documentation/devicetree/bindings/serial/actions,owl-uart.txt
 create mode 100644 Documentation/devicetree/bindings/timer/actions,owl-timer.txt
 create mode 100644 arch/arm/boot/dts/s500-guitar-bb-rev-b.dts
 create mode 100644 arch/arm/boot/dts/s500-guitar.dtsi
 create mode 100644 arch/arm/boot/dts/s500.dtsi
 create mode 100644 arch/arm/mach-actions/Kconfig
 create mode 100644 arch/arm/mach-actions/Makefile
 create mode 100644 arch/arm/mach-actions/owl.c
 create mode 100644 arch/arm64/boot/dts/actions/Makefile
 create mode 100644 arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
 create mode 100644 arch/arm64/boot/dts/actions/s900.dtsi
 create mode 100644 drivers/clocksource/owl-timer.c
 create mode 100644 drivers/tty/serial/owl-uart.c

-- 
2.10.2
