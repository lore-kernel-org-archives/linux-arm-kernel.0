From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 15 Feb 2017 17:55:17 +0100
Subject: [PATCH 00/11] ARM: Initial Actions Semi S500 and S900 enablement
Message-ID: <20170215165528.10052-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Based on earlier work of mine for the LeMaker Guitar, this series adds initial
support for the Actions Semiconductor S500 (ARMv7) and S900 (ARMv8) SoCs.

Despite Actions Semi being a Linaro member since 2015, sadly I have not seen
a single upstream kernel patch submission since. Nor has the XApple community
taken any such initiative.

The GitHub LeMaker/linux-actions and xapp-le/kernel trees have 3.10 based S500
drivers in arch/arm/mach-owl/, whereas the 96boards-bubblegum/linux tree has
new-style but still 3.10 based S900 drivers. I also spotted GPLv2+ vs. GPLv2
license differences.

This series therefore provides a proof of concept for a combined S500 and S900
mainline implementation. Only earlycon serial output is available for now.

Focusing on Bubblegum-96, no S500 clocksource implementation is provided yet,
thus output on Guitar is less than on Bubblegum-96, but still it demonstrates
that a single driver can be shared for both, using compatible strings for
future differentiation.

https://github.com/afaerber/linux/commits/bg96-next

Booting from U-Boot is straightforward on both boards.

https://en.opensuse.org/HCL:Guitar
https://en.opensuse.org/HCL:Bubblegum-96

Have a lot of fun!

Cheers,
Andreas

Cc: mp-cs at actions-semi.com
Cc: info at ucrobotics.com
Cc: support at lemaker.org
Cc: contact at linux-xapple.org
Cc: devicetree at vger.kernel.org

Andreas F?rber (11):
  Documentation: devicetree: Add vendor prefix for Actions Semi
  Documentation: devicetree: arm: Document Actions Semi S500
  ARM: Prepare Actions Semi S500
  ARM64: Prepare Actions Semi S900
  Documentation: devicetree: serial: Document Actions Semi Owl UARTs
  tty: serial: Add Actions Semi Owl UART earlycon
  Documentation: kernel-parameters: Document owl earlycon
  ARM: dts: Prepare Actions Semi S500 and LeMaker Guitar
  Documentation: devicetree: Add vendor prefix for uCRobotics
  Documentation: devicetree: arm: Document Actions Semi S900
  ARM64: dts: Prepare Actions Semi S900 and Bubblegum-96

 Documentation/admin-guide/kernel-parameters.txt    |   6 +
 Documentation/devicetree/bindings/arm/acts.txt     |  32 +++++
 .../devicetree/bindings/serial/acts,owl-uart.txt   |  16 +++
 .../devicetree/bindings/vendor-prefixes.txt        |   2 +
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/s500-guitar-bb-rev-b.dts         |  63 ++++++++++
 arch/arm/boot/dts/s500-guitar.dtsi                 |  49 ++++++++
 arch/arm/boot/dts/s500.dtsi                        | 116 +++++++++++++++++
 arch/arm/mach-owl/Kconfig                          |   9 ++
 arch/arm/mach-owl/Makefile                         |   1 +
 arch/arm/mach-owl/owl.c                            |  28 +++++
 arch/arm64/Kconfig.platforms                       |   5 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/actions/Makefile               |   5 +
 arch/arm64/boot/dts/actions/s900-bubblegum96.dts   |  62 +++++++++
 arch/arm64/boot/dts/actions/s900.dtsi              | 140 +++++++++++++++++++++
 drivers/tty/serial/Kconfig                         |  19 +++
 drivers/tty/serial/Makefile                        |   1 +
 drivers/tty/serial/owl-uart.c                      | 135 ++++++++++++++++++++
 21 files changed, 695 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/acts.txt
 create mode 100644 Documentation/devicetree/bindings/serial/acts,owl-uart.txt
 create mode 100644 arch/arm/boot/dts/s500-guitar-bb-rev-b.dts
 create mode 100644 arch/arm/boot/dts/s500-guitar.dtsi
 create mode 100644 arch/arm/boot/dts/s500.dtsi
 create mode 100644 arch/arm/mach-owl/Kconfig
 create mode 100644 arch/arm/mach-owl/Makefile
 create mode 100644 arch/arm/mach-owl/owl.c
 create mode 100644 arch/arm64/boot/dts/actions/Makefile
 create mode 100644 arch/arm64/boot/dts/actions/s900-bubblegum96.dts
 create mode 100644 arch/arm64/boot/dts/actions/s900.dtsi
 create mode 100644 drivers/tty/serial/owl-uart.c

-- 
2.10.2
