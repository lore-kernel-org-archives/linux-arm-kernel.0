From: joel@jms.id.au (Joel Stanley)
Date: Thu, 21 Apr 2016 17:33:58 +0930
Subject: [PATCH v2 00/11] Aspeed AST2400 and AST2500 BMC support
In-Reply-To: <1460627269-21721-1-git-send-email-joel@jms.id.au>
References: <1460627269-21721-1-git-send-email-joel@jms.id.au>
Message-ID: <1461225849-28074-1-git-send-email-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

These patches add basic support for the Aspeed AST2400 SoC, a popular BMC
device that is also the target for our OpenBMC[1] efforts.

This series has been boot tested on a Palmetto OpenPower dev board that
uses the ast2400 as it's BMC, as well as Qemu (-M palmetto-bmc on 2.6-rc1).

Version two brings support for the AST2500. It's similar to the 2400, but with
an ARM11 replacing the ARM9. I've boot tested it in Qemu and on the Aspeed
AST2500 edk.

Cheers,

Joel

[1] https://lwn.net/Articles/683320/

Benjamin Herrenschmidt (1):
  irqchip: Add irq controller for Aspeed

Joel Stanley (10):
  doc/devicetree: Add Aspeed and Tyan to vendor-prefixes
  doc/devicetree: Add Aspeed VIC bindings
  doc/devicetree: Add Aspeed clock bindings
  clocksource/moxart: Generalise timer for use on other socs
  clk: Add driver for Aspeed fourth gen SoCs
  clk: Add driver for Aspeed fifth gen SoCs
  arm/dts: Add Aspeed ast2400 device tree
  arm/dst: Add Aspeed ast2500 device tree
  arm: Add Aspeed machine
  arm/configs: Add aspeed defconfig

 .../devicetree/bindings/clock/aspeed-clock.txt     | 137 ++++++++++++
 .../interrupt-controller/aspeed,ast2400-vic.txt    |  24 +++
 .../bindings/timer/moxa,moxart-timer.txt           |   4 +-
 .../devicetree/bindings/vendor-prefixes.txt        |   2 +
 MAINTAINERS                                        |   8 +
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/aspeed-ast2500-evb.dts           |  21 ++
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts      |  21 ++
 arch/arm/boot/dts/aspeed-g4.dtsi                   | 152 +++++++++++++
 arch/arm/boot/dts/aspeed-g5.dtsi                   | 156 ++++++++++++++
 arch/arm/configs/aspeed_g4_defconfig               |  86 ++++++++
 arch/arm/configs/aspeed_g5_defconfig               |  88 ++++++++
 arch/arm/mach-aspeed/Kconfig                       |  28 +++
 arch/arm/mach-aspeed/Makefile                      |   3 +
 arch/arm/mach-aspeed/aspeed.c                      |  83 +++++++
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-aspeed-g4.c                        | 106 +++++++++
 drivers/clk/clk-aspeed-g5.c                        | 189 ++++++++++++++++
 drivers/clocksource/Kconfig                        |   6 +
 drivers/clocksource/Makefile                       |   2 +-
 drivers/clocksource/moxart_timer.c                 |  90 ++++++--
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-aspeed-vic.c                   | 238 +++++++++++++++++++++
 25 files changed, 1428 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/aspeed-clock.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-vic.txt
 create mode 100644 arch/arm/boot/dts/aspeed-ast2500-evb.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
 create mode 100644 arch/arm/boot/dts/aspeed-g4.dtsi
 create mode 100644 arch/arm/boot/dts/aspeed-g5.dtsi
 create mode 100644 arch/arm/configs/aspeed_g4_defconfig
 create mode 100644 arch/arm/configs/aspeed_g5_defconfig
 create mode 100644 arch/arm/mach-aspeed/Kconfig
 create mode 100644 arch/arm/mach-aspeed/Makefile
 create mode 100644 arch/arm/mach-aspeed/aspeed.c
 create mode 100644 drivers/clk/clk-aspeed-g4.c
 create mode 100644 drivers/clk/clk-aspeed-g5.c
 create mode 100644 drivers/irqchip/irq-aspeed-vic.c

-- 
2.7.4
