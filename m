From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 17 Sep 2012 16:04:23 +0200
Subject: [PATCH 00/16 v2] ARM: at91: add pinctrl support
Message-ID: <20120917140423.GA17667@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

	This patch series introduce the pinctrl on AT91 on all the DT Soc.

	THe pinctrl is limited to only the DT. Old code still use the custom
	at91 pin mux api.

	v2:
	 - switch to relaxed readl/writel
	 - fix comment
	 - update Documentation

The following changes since commit fea7a08acb13524b47711625eebea40a0ede69a0:

  Linux 3.6-rc3 (2012-08-22 13:29:06 -0700)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/pinctrl

for you to fetch changes up to b4476c3ac112071f629744a405c913b8fca64991:

  MTD: atmel_nand: add pinctrl consumer support (2012-09-17 18:00:43 +0800)

----------------------------------------------------------------
ARM: at91: add pinctrl support

On DT switch from custom pin mux to pinctrl
switch the gpio driver to pinctrl too as on at91 the same API do both
GPIO and pin mux

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

----------------------------------------------------------------
Jean-Christophe PLAGNIOL-VILLARD (16):
      ARM: at91: fix missing #interrupt-cells on gpio-controller
      arm: at91: use macro to declare soc boot data
      ARM: at91: gpio: implement request
      at91: regroup gpio and pinctrl under the same ranges
      arm: at91: at91sam9x5: fix gpio number per bank
      ARM: at91: add dummies pinctrl for non dt platform
      ARM: at91: add pinctrl support
      arm: at91: dt: at91sam9 add pinctrl support
      arm: at91: dt: at91sam9 add serial pinctrl support
      tty: atmel_serial: add pinctrl support
      arm: at91: dt: sam9m10g45ek: use rts/cts pinctrl group for uart1
      arm: at91: dt: sam9263ek: use rts/cts pinctrl group for uart0
      arm: at91: dt: sam9g20ek: use rts/cts/dtr/dsr/dcd/ri pinctrl group for uart0
      MTD: atmel nand: fix gpio missing request
      arm: at91: dt: at91sam9 add nand pinctrl support
      MTD: atmel_nand: add pinctrl consumer support

 Documentation/devicetree/bindings/gpio/gpio_atmel.txt            |    5 +
 Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt |  136 ++++++++++++
 arch/arm/Kconfig                                                 |    2 +
 arch/arm/boot/dts/at91sam9260.dtsi                               |  184 ++++++++++++++--
 arch/arm/boot/dts/at91sam9263.dtsi                               |  168 +++++++++++----
 arch/arm/boot/dts/at91sam9263ek.dts                              |    1 +
 arch/arm/boot/dts/at91sam9g15.dtsi                               |   28 +++
 arch/arm/boot/dts/at91sam9g15ek.dts                              |   16 ++
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi                      |    6 +
 arch/arm/boot/dts/at91sam9g25.dtsi                               |   28 +++
 arch/arm/boot/dts/at91sam9g25ek.dts                              |   37 +---
 arch/arm/boot/dts/at91sam9g35.dtsi                               |   28 +++
 arch/arm/boot/dts/at91sam9g35ek.dts                              |   16 ++
 arch/arm/boot/dts/at91sam9g45.dtsi                               |  184 ++++++++++++----
 arch/arm/boot/dts/at91sam9m10g45ek.dts                           |    1 +
 arch/arm/boot/dts/at91sam9n12.dtsi                               |  176 +++++++++++++---
 arch/arm/boot/dts/at91sam9x25.dtsi                               |   28 +++
 arch/arm/boot/dts/at91sam9x25ek.dts                              |   16 ++
 arch/arm/boot/dts/at91sam9x35.dtsi                               |   28 +++
 arch/arm/boot/dts/at91sam9x35ek.dts                              |   16 ++
 arch/arm/boot/dts/at91sam9x5.dtsi                                |  174 ++++++++++++---
 arch/arm/boot/dts/at91sam9x5ek.dtsi                              |   47 +++++
 arch/arm/configs/at91_dt_defconfig                               |    1 +
 arch/arm/mach-at91/Makefile.boot                                 |    4 +
 arch/arm/mach-at91/at91rm9200.c                                  |    4 +-
 arch/arm/mach-at91/at91sam9260.c                                 |    7 +-
 arch/arm/mach-at91/at91sam9261.c                                 |    4 +-
 arch/arm/mach-at91/at91sam9263.c                                 |    9 +-
 arch/arm/mach-at91/at91sam9g45.c                                 |   10 +-
 arch/arm/mach-at91/at91sam9n12.c                                 |   15 +-
 arch/arm/mach-at91/at91sam9rl.c                                  |    4 +-
 arch/arm/mach-at91/at91sam9x5.c                                  |   19 +-
 arch/arm/mach-at91/board-dt.c                                    |    2 -
 arch/arm/mach-at91/gpio.c                                        |  190 +++--------------
 arch/arm/mach-at91/setup.c                                       |    6 +-
 arch/arm/mach-at91/soc.h                                         |   12 +-
 drivers/mtd/nand/atmel_nand.c                                    |   59 +++++-
 drivers/pinctrl/Kconfig                                          |    9 +
 drivers/pinctrl/Makefile                                         |    1 +
 drivers/pinctrl/pinctrl-at91.c                                   | 1490 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/tty/serial/atmel_serial.c                                |    8 +
 41 files changed, 2781 insertions(+), 398 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
 create mode 100644 arch/arm/boot/dts/at91sam9g15.dtsi
 create mode 100644 arch/arm/boot/dts/at91sam9g15ek.dts
 create mode 100644 arch/arm/boot/dts/at91sam9g25.dtsi
 create mode 100644 arch/arm/boot/dts/at91sam9g35.dtsi
 create mode 100644 arch/arm/boot/dts/at91sam9g35ek.dts
 create mode 100644 arch/arm/boot/dts/at91sam9x25.dtsi
 create mode 100644 arch/arm/boot/dts/at91sam9x25ek.dts
 create mode 100644 arch/arm/boot/dts/at91sam9x35.dtsi
 create mode 100644 arch/arm/boot/dts/at91sam9x35ek.dts
 create mode 100644 arch/arm/boot/dts/at91sam9x5ek.dtsi
 create mode 100644 drivers/pinctrl/pinctrl-at91.c

Best Regards,
J.
