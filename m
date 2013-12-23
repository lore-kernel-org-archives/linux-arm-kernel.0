From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 23 Dec 2013 16:23:32 +0000
Subject: [RFC 00/18] Versatile Express config rework
Message-ID: <1387815830-8794-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings,

When I promised to rework vexpress' MFD & co. components,
I did't expect it would take almost half a year to post
some patches... The worst thing is that I got most of this
stuff done months ago, but not until the usual holiday
period came I got a chance to post it.

Anyway, the following series retires custom "function"
interface, replacing it with regmap. For a price of
a single WARN_ON removed (05/18 "driver core: Do not WARN 
when devres list is not empty at probe time"), I've managed
to hide all possible VE-specific ways of talking to the
peripherals behind regmap, creating platform devices with
platform-specific regmap config added as devm.

I also had to solve a problem of early initialization
required for the core components, where early doesn't mean
"very early" but simply "earlier than the other ones".
The main issue was of_platform_populate() instantiating
devices for nodes that already has been serviced. There
were some attempts to fix it in the past (including a
struct device pointer in struct device_node). My proposal
is just an extra "already populated" flag in device_node,
set by generic device functions, which makes the
of_platform_populate() to skip such node.

In the end the vexpress-sysreg is almost exclusively
a "pure" MFD device, creating mfd_cells for other drivers.
The system config interface has been split into a "misc"
driver (may become a "soc" driver if the directory
materializes) and the config bus core (using standard
device "class" now) went of course into "bus".

There is also a bunch of other, less important patches
all around the place. I would appreciate the respective
maintainers having a look at them. If anyone wants to
take the small changes in for 3.16 that's cool, if not
I'd more than happy to recieve an ack and merge it with
the whole series in the future.

This series is based on 3.15-rc5 and my hope is to get it
polished enough in time for 3.17 merge window.

Have a great time whatever your plans are for the next
2 weeks!

Pawel

Pawel Moll (17):
  mfd: syscon: Consider platform data a regmap config name
  power/reset: vexpress: Use sched_clock as the time source
  GPIO: gpio-generic: Add label to platform data
  driver core & of: Mark of_nodes of added device as populated
  driver core: Do not WARN when devres list is not empty at probe time
  regmap: Formalise use of non-bus context
  regmap: debugfs: Always create "registers" & "access" files
  hwmon: vexpress: Use regmap instead of custom interface
  power/reset: vexpress: Use regmap instead of custom interface
  regulator: vexpress: Use regmap instead of custom interface
  clocksource: Sched clock source for Versatile Express
  clk: versatile: Split config options for sp810 and vexpress_osc
  clk: versatile: Use regmap instead of custom interface
  ARM: vexpress: Simplify SMP operations for DT-powered system
  bus: Versatile Express configuration bus
  misc: Versatile Express System Config interface driver
  mfd: vexpress: Split sysreg functions into MFD cells

Sudeep KarkadaNagesha (1):
  ARM: vexpress: remove redundant vexpress_dt_cpus_num to get cpu count

 .../devicetree/bindings/arm/vexpress-sysreg.txt    |  37 +-
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi            |  76 ++-
 arch/arm/boot/dts/vexpress-v2m.dtsi                |  76 ++-
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts         |   5 +-
 arch/arm/mach-vexpress/core.h                      |   3 +-
 arch/arm/mach-vexpress/ct-ca9x4.c                  |   8 +-
 arch/arm/mach-vexpress/platsmp.c                   | 187 ++-----
 arch/arm/mach-vexpress/v2m.c                       |  74 +--
 arch/arm64/boot/dts/rtsm_ve-motherboard.dtsi       |   2 +-
 drivers/base/core.c                                |   4 +
 drivers/base/dd.c                                  |   1 -
 drivers/base/regmap/internal.h                     |   3 +-
 drivers/base/regmap/regmap-debugfs.c               |  10 +-
 drivers/base/regmap/regmap.c                       |  34 +-
 drivers/bus/Kconfig                                |   8 +
 drivers/bus/Makefile                               |   2 +
 drivers/bus/vexpress-config.c                      | 178 +++++++
 drivers/clk/Kconfig                                |   9 +-
 drivers/clk/versatile/Kconfig                      |  26 +
 drivers/clk/versatile/Makefile                     |   5 +-
 drivers/clk/versatile/clk-vexpress-osc.c           |  70 +--
 drivers/clocksource/Kconfig                        |   9 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/vexpress.c                     |  40 ++
 drivers/gpio/gpio-generic.c                        |   2 +
 drivers/hwmon/Kconfig                              |   3 +-
 drivers/hwmon/vexpress.c                           |  29 +-
 drivers/mfd/Kconfig                                |  15 +-
 drivers/mfd/Makefile                               |   2 +-
 drivers/mfd/syscon.c                               |   1 +
 drivers/mfd/vexpress-config.c                      | 288 -----------
 drivers/mfd/vexpress-sysreg.c                      | 563 ++++++---------------
 drivers/misc/Kconfig                               |   9 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/vexpress-syscfg.c                     | 322 ++++++++++++
 drivers/of/device.c                                |  16 +
 drivers/of/platform.c                              |   6 +-
 drivers/power/reset/Kconfig                        |   2 +-
 drivers/power/reset/vexpress-poweroff.c            |  15 +-
 drivers/regulator/Kconfig                          |   3 +-
 drivers/regulator/vexpress.c                       |  52 +-
 include/linux/basic_mmio_gpio.h                    |   1 +
 include/linux/of.h                                 |   6 +
 include/linux/of_device.h                          |  11 +
 include/linux/regmap.h                             |   6 +-
 include/linux/vexpress.h                           | 101 +---
 46 files changed, 1168 insertions(+), 1154 deletions(-)
 create mode 100644 drivers/bus/vexpress-config.c
 create mode 100644 drivers/clk/versatile/Kconfig
 create mode 100644 drivers/clocksource/vexpress.c
 delete mode 100644 drivers/mfd/vexpress-config.c
 create mode 100644 drivers/misc/vexpress-syscfg.c

-- 
1.8.3.2
