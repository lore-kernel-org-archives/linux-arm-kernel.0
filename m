From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue,  6 Jun 2017 02:53:58 +0200
Subject: [PATCH v4 00/28] ARM: Initial Actions Semi S500 and S900 enablement
Message-ID: <20170606005426.26446-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series adds initial support for Actions Semiconductor S500 (ARMv7)
and S900 (ARMv8) SoCs.

v4 refactors the clocksource driver again and fixes power-gating for CPU2/CPU3.

With this v4 I would like to start applying initial patches to my tree for 4.13.

@Actions:    Last call for comments on vendor prefix and SoC bindings!
@uCRobotics: Last call for comments on vendor prefix and board bindings!
@LeMaker:    Last call for comments on module and board bindings!

Work branch for testing:
https://github.com/afaerber/linux/commits/bg96-next

Booting from U-Boot to initrd is straightforward on both boards:

https://en.opensuse.org/HCL:Guitar
https://en.opensuse.org/HCL:Bubblegum-96

Have a lot of fun!

Cheers,
Andreas

v3 -> v4:
* Revert to hardcoded TIMER0/1 in clocksource (Daniel)
* Make power domains CPU2 and CPU3 always-on
* Clean up SMP vs. PM domains code duplication
* Extend earlycon documentation (Jonathan)
* Update MAINTAINERS with SPS files

v2 -> v3:
* Clocksource fix
* Clocksource cleanups (Daniel)
* Serial cleanups
* Add S500 CPU enable-method
* Add power domain driver
* Rework clocksource for S900 compatibility

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

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>

Cc: mp-cs at actions-semi.com
Cc: Thomas Liau <thomas.liau@actions-semi.com>
Cc: 96boards at ucrobotics.com
Cc: support at lemaker.org

Cc: linux-serial at vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Cc: linux-pm at vger.kernel.org
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

Cc: linux-doc at vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>

Cc: devicetree at vger.kernel.org

Andreas F?rber (28):
  dt-bindings: Add vendor prefix for Actions Semi
  dt-bindings: arm: Document Actions Semi S500
  dt-bindings: timer: Document Owl timer
  clocksource: Add Owl timer
  clocksource: owl: Add S900 support
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
  ARM64: dts: actions: s900-bubblegum-96: Add fake uart5 clock
  ARM: dts: s500-guitar-bb-rev-b: Add fake uart3 clock
  dt-bindings: arm: cpus: Add S500 enable-method
  ARM: owl: Implement CPU enable-method for S500
  ARM: dts: s500: Set CPU enable-method
  dt-bindings: power: Add Owl SPS power domains
  soc: actions: Add Owl SPS
  MAINTAINERS: Update Actions Semi section with SPS
  ARM: dts: s500: Add SPS node
  ARM: dts: s500: Set power domains for CPU2 and CPU3
  soc: actions: owl-sps: Factor out owl_sps_set_pg() for power-gating
  ARM: owl: smp: Implement SPS power-gating for CPU2 and CPU3

 Documentation/admin-guide/kernel-parameters.txt    |   6 +
 Documentation/devicetree/bindings/arm/actions.txt  |  39 ++
 Documentation/devicetree/bindings/arm/cpus.txt     |   1 +
 .../devicetree/bindings/power/actions,owl-sps.txt  |  17 +
 .../bindings/serial/actions,owl-uart.txt           |  16 +
 .../bindings/timer/actions,owl-timer.txt           |  20 +
 .../devicetree/bindings/vendor-prefixes.txt        |   2 +
 MAINTAINERS                                        |  13 +
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/s500-guitar-bb-rev-b.dts         |  33 +
 arch/arm/boot/dts/s500-guitar.dtsi                 |  22 +
 arch/arm/boot/dts/s500.dtsi                        | 189 ++++++
 arch/arm/mach-actions/Kconfig                      |  16 +
 arch/arm/mach-actions/Makefile                     |   4 +
 arch/arm/mach-actions/headsmp.S                    |  68 ++
 arch/arm/mach-actions/owl.c                        |  28 +
 arch/arm/mach-actions/platsmp.c                    | 198 ++++++
 arch/arm64/Kconfig.platforms                       |   6 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/actions/Makefile               |   5 +
 arch/arm64/boot/dts/actions/s900-bubblegum-96.dts  |  42 ++
 arch/arm64/boot/dts/actions/s900.dtsi              | 164 +++++
 drivers/clocksource/Kconfig                        |   7 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/owl-timer.c                    | 172 +++++
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/actions/Kconfig                        |  16 +
 drivers/soc/actions/Makefile                       |   2 +
 drivers/soc/actions/owl-sps-helper.c               |  51 ++
 drivers/soc/actions/owl-sps.c                      | 224 +++++++
 drivers/tty/serial/Kconfig                         |  19 +
 drivers/tty/serial/Makefile                        |   1 +
 drivers/tty/serial/owl-uart.c                      | 724 +++++++++++++++++++++
 include/dt-bindings/power/s500-powergate.h         |  19 +
 include/linux/soc/actions/owl-sps.h                |  11 +
 include/uapi/linux/serial_core.h                   |   3 +
 39 files changed, 2147 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/actions.txt
 create mode 100644 Documentation/devicetree/bindings/power/actions,owl-sps.txt
 create mode 100644 Documentation/devicetree/bindings/serial/actions,owl-uart.txt
 create mode 100644 Documentation/devicetree/bindings/timer/actions,owl-timer.txt
 create mode 100644 arch/arm/boot/dts/s500-guitar-bb-rev-b.dts
 create mode 100644 arch/arm/boot/dts/s500-guitar.dtsi
 create mode 100644 arch/arm/boot/dts/s500.dtsi
 create mode 100644 arch/arm/mach-actions/Kconfig
 create mode 100644 arch/arm/mach-actions/Makefile
 create mode 100644 arch/arm/mach-actions/headsmp.S
 create mode 100644 arch/arm/mach-actions/owl.c
 create mode 100644 arch/arm/mach-actions/platsmp.c
 create mode 100644 arch/arm64/boot/dts/actions/Makefile
 create mode 100644 arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
 create mode 100644 arch/arm64/boot/dts/actions/s900.dtsi
 create mode 100644 drivers/clocksource/owl-timer.c
 create mode 100644 drivers/soc/actions/Kconfig
 create mode 100644 drivers/soc/actions/Makefile
 create mode 100644 drivers/soc/actions/owl-sps-helper.c
 create mode 100644 drivers/soc/actions/owl-sps.c
 create mode 100644 drivers/tty/serial/owl-uart.c
 create mode 100644 include/dt-bindings/power/s500-powergate.h
 create mode 100644 include/linux/soc/actions/owl-sps.h

-- 
2.12.3
