From: andrew@aj.id.au (Andrew Jeffery)
Date: Wed, 20 Jul 2016 15:28:21 +0930
Subject: [PATCH 00/12] aspeed: Add pinctrl and gpio drivers
Message-ID: <1468994313-13538-1-git-send-email-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This series is an evolution of the AST2400 pinctrl RFC posted a few months
back:

  http://www.spinics.net/lists/linux-gpio/msg14414.html

The approach is similar to the RFC but a number of details have changed, often
to support the weirder mux configuration cases. Unlike the RFC this series
separates the common code for 4th and 5th generation SoC support and integrates
the code into the kernel at large. The GPIO driver is included so it can
integrate with pinctrl from the outset; the code already existed but had not
yet been sent upstream.

The series has been tested on both the AST2400 (g4) and AST2500 (g5) SoCs on
OpenPOWER Palmetto and Aspeed AST2500 EVB machines respectively, and similarly
in qemu where models were available.

As mentioned in the RFC cover letter this is my first significant contribution
to the kernel so I fully expect I've made some oversights; apologies in advance
if I've missed anything required or obvious!

Cheers,

Andrew

Andrew Jeffery (11):
  pinctrl: dt-bindings: Add documentation for Aspeed pin controllers
  pinctrl: Add core pinctrl support for Aspeed SoCs
  pinctrl: Add pinctrl-aspeed-g4 driver
  pinctrl: Add pinctrl-aspeed-g5 driver
  gpio: dt-bindings: Add documentation for Aspeed GPIO controllers
  syscon: dt-bindings: Add documentation for Aspeed system control units
  aspeed-g4: Add syscon and pin controller nodes
  palmetto: Request relevant mux functions in devicetree
  aspeed-g4: Add gpio controller to devicetree
  aspeed-g5: Add syscon and pin controller nodes
  aspeed-g5: Add gpio controller to devicetree

Joel Stanley (1):
  gpio: Add Aspeed driver

 .../devicetree/bindings/gpio/gpio-aspeed.txt       |   42 +
 .../devicetree/bindings/mfd/aspeed-scu.txt         |   16 +
 .../devicetree/bindings/pinctrl/pinctrl-aspeed.txt |   45 +
 MAINTAINERS                                        |    2 +
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts      |   28 +
 arch/arm/boot/dts/aspeed-g4.dtsi                   |  293 ++++++
 arch/arm/boot/dts/aspeed-g5.dtsi                   |  143 +++
 arch/arm/mach-aspeed/Kconfig                       |    7 +
 drivers/gpio/Kconfig                               |    8 +-
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-aspeed.c                         |  456 ++++++++
 drivers/pinctrl/Kconfig                            |    1 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/aspeed/Kconfig                     |   24 +
 drivers/pinctrl/aspeed/Makefile                    |    5 +
 drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c         | 1091 ++++++++++++++++++++
 drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c         |  561 ++++++++++
 drivers/pinctrl/aspeed/pinctrl-aspeed.c            |  373 +++++++
 drivers/pinctrl/aspeed/pinctrl-aspeed.h            |  562 ++++++++++
 19 files changed, 3658 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-aspeed.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/aspeed-scu.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt
 create mode 100644 drivers/gpio/gpio-aspeed.c
 create mode 100644 drivers/pinctrl/aspeed/Kconfig
 create mode 100644 drivers/pinctrl/aspeed/Makefile
 create mode 100644 drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
 create mode 100644 drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
 create mode 100644 drivers/pinctrl/aspeed/pinctrl-aspeed.c
 create mode 100644 drivers/pinctrl/aspeed/pinctrl-aspeed.h

-- 
2.7.4
