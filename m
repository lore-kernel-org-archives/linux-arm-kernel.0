From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 Sep 2017 15:46:11 -0700
Subject: [PATCHv3 00/10] Fix remaining issues to drop more omap platform data
Message-ID: <20170920224621.16236-1-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here's v3 of the remaining fixes needed before we can drop omap hwmod
platform data for interrupts, dma channels and IO ranges.

The earlier trivial dts fixes are now applied and in Linux next. I've
reworked the remaining fixes to make use of the ti-sysc interconnect
target module binding. We can already this generic binding for the
interconnect target modules with no device drivers to idle them on init.
So these are based on current Linux next.

Regards,

Tony

Changes since v2:

- Drop attempted bindings for devices with no drivers and start using
  generic ti sysc interconnect target module binding, the bindings
  for the child devices can be sent separately as needed

- Add Tero's pathces for omap4 clkctrl nodes as we need those

- Add support for parsing IO ranges from dts if "ti,hwmods" is set
  and fix-up omap device code to work without platform data for
  legacy dma and smartreflex

- Add minimal ti-sysc driver

Changes since v1:

- Updated hsi, iss, fdif, gpu, and smartreflex patches based on
  the subsystem maintainer comments

- Added Rob and Mark in Cc for the patches touching binding
  documentation


Tero Kristo (3):
  ARM: dts: omap4: add fck under timer1
  ARM: dts: omap4: add bus functionality to base PRCM nodes
  ARM: dts: omap4: add clkctrl nodes

Tony Lindgren (7):
  dt-bindings: bus: Minimal TI sysc interconnect target module binding
  ARM: OMAP2+: Parse module IO range from dts for legacy "ti,hwmods"
    support
  ARM: OMAP2+: Populate legacy resources for dma and smartreflex
  bus: ti-sysc: Add minimal TI sysc interconnect target driver
  ARM: dts: Add nodes for missing omap4 interconnect target modules
  ARM: dts: Configure SmartReflex only to idle the interconnect target
    module
  ARM: dts: Use ti-sysc module driver for omap4 musb

 Documentation/devicetree/bindings/bus/ti-sysc.txt |  88 ++++
 arch/arm/boot/dts/dra7.dtsi                       |  26 +
 arch/arm/boot/dts/omap4.dtsi                      | 233 ++++++++-
 arch/arm/boot/dts/omap44xx-clocks.dtsi            | 289 +++++++++++
 arch/arm/mach-omap2/Kconfig                       |   1 +
 arch/arm/mach-omap2/omap_device.c                 | 137 ++++--
 arch/arm/mach-omap2/omap_device.h                 |   4 -
 arch/arm/mach-omap2/omap_hwmod.c                  |  80 ++-
 arch/arm/mach-omap2/omap_hwmod.h                  |   5 +
 drivers/bus/Kconfig                               |   7 +
 drivers/bus/Makefile                              |   1 +
 drivers/bus/ti-sysc.c                             | 571 ++++++++++++++++++++++
 12 files changed, 1380 insertions(+), 62 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/ti-sysc.txt
 create mode 100644 drivers/bus/ti-sysc.c

-- 
2.14.1
