From: jonas.gorski@gmail.com (Jonas Gorski)
Date: Wed, 20 Sep 2017 13:14:00 +0200
Subject: [PATCH V2 0/8] MIPS: BCM63XX: add and use clkdev lookup support
Message-ID: <20170920111408.29711-1-jonas.gorski@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for clckdev lookup support to name input
clocks in various drivers more closely to their functions, or simplify
their usage.

Since most of these patches touch arch/mips, it probably makes most
sense to go through the MIPS tree.

The HSSPI driver was already updated previously to support a "pll"
input with ff18e1ef04e2 ("spi/bcm63xx-hsspi: allow providing clock rate
through a second clock"), so there is no need to touch it.

This patch series is part of an effort to modernize BCM63XX and clean up
its drivers to eventually make them usable with BMIPS and device tree.

Changes V1 -> V2:
* Drop the bcm63xx_enet patch, it will be sent again once the clkdev
  lookup is actually applied.
* Added a patch to fix refcounting in the secondary switch clocks.
* Slightly reordered patches to be ordered thematically.
* Added collected Acks / Reviews to their respective patches.

Due to none of the patches having changed between V1 and V2 I did not
add individual changelogs. These will be added if the code or commit log
text changes.

Jonas Gorski (8):
  MIPS: BCM63XX: add clkdev lookup support
  MIPS: BCM63XX: provide periph clock as refclk for uart
  tty/bcm63xx_uart: use refclk for the expected clock name
  tty/bcm63xx_uart: allow naming clock in device tree
  MIPS: BMIPS: name the refclk clock for uart
  MIPS: BCM63XX: move the HSSPI PLL HZ into its own clock
  MIPS: BCM63XX: provide enet clocks as "enet" to the ethernet devices
  MIPS: BCM63XX: split out swpkt_sar/usb clocks

 .../bindings/serial/brcm,bcm6345-uart.txt          |   6 +
 arch/mips/Kconfig                                  |   1 +
 arch/mips/bcm63xx/clk.c                            | 242 +++++++++++++++++----
 arch/mips/boot/dts/brcm/bcm3368.dtsi               |   2 +
 arch/mips/boot/dts/brcm/bcm63268.dtsi              |   2 +
 arch/mips/boot/dts/brcm/bcm6328.dtsi               |   2 +
 arch/mips/boot/dts/brcm/bcm6358.dtsi               |   2 +
 arch/mips/boot/dts/brcm/bcm6362.dtsi               |   2 +
 arch/mips/boot/dts/brcm/bcm6368.dtsi               |   2 +
 drivers/tty/serial/bcm63xx_uart.c                  |   6 +-
 10 files changed, 218 insertions(+), 49 deletions(-)

-- 
2.13.2
