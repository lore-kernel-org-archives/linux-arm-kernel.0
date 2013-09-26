From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 26 Sep 2013 16:35:26 -0300
Subject: [PATCH v2 0/4] Add Core Divider clock support for Armada 370/XP
Message-ID: <1380224130-11868-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for a set of clocks available in Armada 370/XP
known as "Core Divider" clocks.

These are a set of gatable clocks, derived from a fixed PLL at
a configurable ratio. Although this patchset adds support for the more
general case, we only support one of the clocks, namely the NAND clock.

With this infrastructure in place, the addition of the rest of the clocks
would be fairly easy.

A pictorical representation of the clock tree would be:

    PLL
    |
    |
    ---------------------
    |			|
    |			|
    NAND clock		...

This patchset is based on v3.12-rc2. Any opinions are highly appreciated.

Thanks!

Changes from v1:

  * The most significative change is the simplification of the NAND clock
    tree. Instead of exposing two clocks: NAND ECC and NAND, we choose a
    simpler approach and view both clocks as one.

    The only impact these simplification has is that the NAND controller
    driver will have to divide the rate by two when using it to calculate
    the timings.

  * A spinlock protecting the enable, disable and set_rate operations is added
    as noted by Andrew Lunn.

  * The round_rate algorithm was also simplified, as the previous one was rather
    silly; also noted by Andrew.

  * The size of the 'reg' property was fixed; also noted by Andrew.

  * The exceedingly long macros names have been simplified and some other minor
    coding style issues have been solved.

Ezequiel Garcia (4):
  clk: mvebu: Add Core Divider clock
  ARM: mvebu: Add Core Divider clock device-tree binding
  ARM: mvebu: Add a 2 GHz fixed-clock Armada 370/XP
  ARM: mvebu: Add the core-divider clock to Armada 370/XP

 .../bindings/clock/mvebu-corediv-clock.txt         |  19 ++
 arch/arm/boot/dts/armada-370-xp.dtsi               |  17 ++
 drivers/clk/mvebu/Kconfig                          |   5 +
 drivers/clk/mvebu/Makefile                         |   1 +
 drivers/clk/mvebu/clk-corediv.c                    | 223 +++++++++++++++++++++
 5 files changed, 265 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/mvebu-corediv-clock.txt
 create mode 100644 drivers/clk/mvebu/clk-corediv.c

-- 
1.8.1.5
