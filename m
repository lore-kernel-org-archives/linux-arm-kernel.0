From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Thu,  9 Jan 2014 13:31:37 +0100
Subject: [PATCH v2 00/12] Device Tree support for the at91sam9261ek
Message-ID: <1389270709-32662-1-git-send-email-jjhiblot@traphandler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set aims at bringing a basic device tree support for the sam9261.
It's mostly based on the sam9263 stuff.
It introduces a new driver for the smc/ebi bus. It's used to configure the EBI
from the DT. I haven't documented its DT bindings yet. Timings can be provided
as raw values or nanoseconds.

Change since V1:
* changed the DT representation to use address translation and separate the
  timings' configuration from the device properties by adding a "simple-bus"
  inetrmediate node.
* moved the smc driver from drivers/bus to drivers/memmory
* smc driver now accepts timings in nanoseconds as well as raw register values
* smc driver can clip the timings if they're out of bound and dump them to the
  console
* DM9000 timings are now described in nanosecs (for the virtue of example)

supported features:
* dbgu
* nand
* lcd
* ethernet
* leds

Jean-Jacques

Jean-Jacques Hiblot (12):
  at91: dt: Add at91sam9261 dt SoC support
  at91: dt: sam9261: Basic Device Tree support for the at91sam9261ek
  at91: dt: sam9261: Added support for the lcd display
  at91: smc: export sam9_smc_cs_read and sam9_smc_cs_configure.
  at91: smc: Increased the size of tdf_cycles in struct sam9_smc_config.
  at91: smc: Adds helper functions to validate and clip the smc timings.
  at91: dt: smc: Added smc bus driver
  at91: sam9261: Add a clock definition for the smc
  at91: dt: sam9261: Pinmux DT entries for the SMC/EBI interface
  at91: dt: sam9261: Add an entry in the DT for the SMC/EBI bus driver.
  at91: dt: sam9261: moved the NAND under the smc node
  at91: dt: sam9261: Added DM9000 in the device tree

 arch/arm/boot/dts/Makefile                     |   2 +
 arch/arm/boot/dts/at91sam9261.dtsi             | 639 +++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9261ek.dts            | 164 +++++++
 arch/arm/mach-at91/at91sam9261.c               |  17 +
 arch/arm/mach-at91/include/mach/at91sam9_smc.h |   6 +-
 arch/arm/mach-at91/sam9_smc.c                  |  81 +++-
 drivers/memory/Kconfig                         |  10 +
 drivers/memory/Makefile                        |   1 +
 drivers/memory/atmel-smc.c                     | 431 +++++++++++++++++
 9 files changed, 1348 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91sam9261.dtsi
 create mode 100644 arch/arm/boot/dts/at91sam9261ek.dts
 create mode 100644 drivers/memory/atmel-smc.c

-- 
1.8.5.2
