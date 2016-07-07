From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  8 Jul 2016 00:37:45 +0200
Subject: [PATCH v2 0/6] Add clock support for Armada 37xx SoCs
Message-ID: <1467931071-31004-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

eventually this is the second version of the series adding clock
support for the Armada 37xx SoCs.

The design of the drivers is as close as possible as the hardware is,
with some clocks made of several layers: muxing, divider and gating.

The device tree binding was written in a way that even if we discover
some change inside the clocks, the binding should not be
affected. Especially, there are some holes in the clocks, but we
should be able to add them seamless.

Since the firs version the main change is the use of clk_hw instead of
clk for the registration. I also removed the dt related patches as they
were already applied.

However the full series is available on the branch
Armada-3700-Clocks-v2 at
git at github.com:MISL-EBU-System-SW/mainline-public.git

Thanks,

Changelog:

v1 -> v2

- Move to clk_hw based registration for the 3 clock driver as
  requested by Stephen Boyd
- Fixed typo noticed by Stephen Boyd
- Added const and static when they were missing: suggested by Stephen
  Boyd
- Allocated the driver variable during probe instead of using a global
  one as requested by Stephen Boyd
- Managed the failure of the of_clk_add_hw_provider call
- Added the Acked-by from Rob Herring on the dt binding patchs

Gregory CLEMENT (6):
  dt-bindings: clock: add DT binding for the Xtal clock on Armada 3700
  clk: mvebu: Add the xtal clock for Armada 3700 SoC
  dt-bindings: clock: add DT binding for the TBG clocks on Armada 3700
  clk: mvebu Add the time base generator clocks for Armada 3700
  dt-bindings: clock: add DT binding for the peripheral clocks on Armada
    3700
  clk: mvebu: Add the peripheral clock driver for Armada 3700

 .../bindings/clock/armada3700-periph-clock.txt     |  70 ++++
 .../bindings/clock/armada3700-tbg-clock.txt        |  27 ++
 .../bindings/clock/armada3700-xtal-clock.txt       |  28 ++
 drivers/clk/mvebu/Kconfig                          |   3 +
 drivers/clk/mvebu/Makefile                         |   3 +
 drivers/clk/mvebu/armada-37xx-periph.c             | 457 +++++++++++++++++++++
 drivers/clk/mvebu/armada-37xx-tbg.c                | 165 ++++++++
 drivers/clk/mvebu/armada-37xx-xtal.c               |  98 +++++
 8 files changed, 851 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/armada3700-periph-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/armada3700-tbg-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/armada3700-xtal-clock.txt
 create mode 100644 drivers/clk/mvebu/armada-37xx-periph.c
 create mode 100644 drivers/clk/mvebu/armada-37xx-tbg.c
 create mode 100644 drivers/clk/mvebu/armada-37xx-xtal.c

-- 
2.5.0
