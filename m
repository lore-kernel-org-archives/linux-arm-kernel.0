From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue,  8 Jul 2014 18:21:10 +0200
Subject: [PATCHv2 0/6] Add a driver for the atmel ram controller
Message-ID: <1404836476-23787-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The atmel ram controller needs one or more clocks to work. For now the
CLK_IGNORE_UNUSED flag is used on those clocks. This patch set introduce a
driver that will take care of taking those clocks.

The final goal is also to move the ioremap done in mach-at91 to that driver with
a proper power management driver.

Changes in v2:
 - use ATMEL_SDRAMC instead of ATMEL_RAMC
 - use "atmel,sama5d3-ddramc" instead of "atmel,sama5d3-mpddramc"
 - not getting mpddrck is now an error
 - handle "atmel,sama5d3-ddramc" in mach-at91/setup.c

Alexandre Belloni (6):
  ARM: at91: Add new binding for sama5d3-ddramc
  memory: add a driver for atmel ram controllers
  ARM: at91: select ATMEL_SDRAMC when using OF
  ARM: at91/dt: sama5d3: define mpddr clock and ramc clocks
  ARM: at91/dt: at91sam9: use ddrck in ramc
  clk: at91: remove the useless CLK_IGNORE_UNUSED flag

 .../devicetree/bindings/arm/atmel-at91.txt         |  1 +
 arch/arm/boot/dts/at91sam9n12.dtsi                 |  2 +
 arch/arm/boot/dts/at91sam9x5.dtsi                  |  2 +
 arch/arm/boot/dts/sama5d3.dtsi                     |  9 +-
 arch/arm/mach-at91/Kconfig                         |  4 +
 arch/arm/mach-at91/setup.c                         |  1 +
 drivers/clk/at91/clk-system.c                      |  8 +-
 drivers/memory/Kconfig                             | 10 +++
 drivers/memory/Makefile                            |  1 +
 drivers/memory/atmel-sdramc.c                      | 98 ++++++++++++++++++++++
 10 files changed, 128 insertions(+), 8 deletions(-)
 create mode 100644 drivers/memory/atmel-sdramc.c

-- 
1.9.1
