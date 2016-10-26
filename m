From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Wed, 26 Oct 2016 19:35:53 +0200
Subject: [PATCH 0/2] ARM: da850: new drivers for better LCDC support
Message-ID: <1477503355-2600-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds two new drivers in order to better support the LCDC
rev1 present on the da850 boards.

The first patch adds a new memory driver which allows to write to the
DDR2/mDDR memory controller present on the da8xx SoCs. Since the
memory controller region is not mapped by anyone else, I went with
platform_get_resource() and ioremap() approach.

The second patch adds a new bus driver which allows to interact with
the MSTPRI registers of the SYSCFG0 module. The SYSCFG0 registers
are used by many drivers, hence the syscon/regmap approach.

As is mentioned in the comments: we don't want to commit to supporting
stable interfaces (DT bindings or sysfs attributes) so we hardcode the
settings required by some boards (for now only da850-lcdk) with the
hope that linux gets an appropriate framework for performance knobs
in the future.

Potential extensions of these drivers should be straightforward in the
future.

Tested on a da850-lcdk with a display connected over VGA and some
additional work on the tilcdc driver.

NOTE I'm sending this as v1, but it's a follow-up to a series I sent
previously and the RFC with the ddrctl driver. I dropped the dt patch
for now.

Bartosz Golaszewski (2):
  ARM: memory: da8xx-ddrctl: new driver
  ARM: bus: da8xx-mstpri: new driver

 .../devicetree/bindings/bus/ti,da850-mstpri.txt    |  20 ++
 .../memory-controllers/ti-da8xx-ddrctl.txt         |  20 ++
 drivers/bus/Kconfig                                |   9 +
 drivers/bus/Makefile                               |   2 +
 drivers/bus/da8xx-mstpri.c                         | 266 +++++++++++++++++++++
 drivers/memory/Kconfig                             |   8 +
 drivers/memory/Makefile                            |   1 +
 drivers/memory/da8xx-ddrctl.c                      | 175 ++++++++++++++
 8 files changed, 501 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/ti,da850-mstpri.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ti-da8xx-ddrctl.txt
 create mode 100644 drivers/bus/da8xx-mstpri.c
 create mode 100644 drivers/memory/da8xx-ddrctl.c

-- 
2.9.3
