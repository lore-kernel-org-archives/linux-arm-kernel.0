From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 19 Jul 2016 15:42:16 +0200
Subject: [PATCH v3 0/6]  Add clock support for Armada 37xx SoCs
Message-ID: <1468935742-11218-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this is the third version of the series adding clock support for the
Armada 37xx SoCs.

The main change is the use of static data for the peripheral clocks
when possible, it lead to a use of many macro to define all the needed
variables.

The design of the drivers is as close as possible as the hardware is,
with some clocks made of several layers: muxing, divider and gating.

The device tree binding was written in a way that even if we discover
some change inside the clocks, the binding should not be
affected. Especially, there are some holes in the clocks, but we
should be able to add them seamless.

The full series is available on the branch Armada-3700-Clocks-v3 at
git at github.com:MISL-EBU-System-SW/mainline-public.git

Thanks,

Changelog:

v2 -> v3

- used marvell,armada-3700-gpio instead of marvell,mvebu-gpio-3700 in
  the binding as pointed by Thomas,
- removed the unnecessary include of clk.h in the 3 drivers, suggested
  by Mike Turquette
- removed the modular reference in the 3 drivers, suggested by Paul
  Gortmaker
- used static data for the peripheral driver when possible, suggested
  by Mike Turquette

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
 drivers/clk/mvebu/armada-37xx-periph.c             | 449 +++++++++++++++++++++
 drivers/clk/mvebu/armada-37xx-tbg.c                | 158 ++++++++
 drivers/clk/mvebu/armada-37xx-xtal.c               |  91 +++++
 8 files changed, 829 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/armada3700-periph-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/armada3700-tbg-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/armada3700-xtal-clock.txt
 create mode 100644 drivers/clk/mvebu/armada-37xx-periph.c
 create mode 100644 drivers/clk/mvebu/armada-37xx-tbg.c
 create mode 100644 drivers/clk/mvebu/armada-37xx-xtal.c

-- 
2.5.0
