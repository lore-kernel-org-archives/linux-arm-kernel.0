From: d-gerlach@ti.com (Dave Gerlach)
Date: Mon, 24 Jul 2017 16:24:52 -0500
Subject: [PATCH v3 0/2] memory: Introduce ti-emif-sram driver
Message-ID: <20170724212454.27574-1-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is v3 of the series introduces a ti-emif-sram driver to be used on
am335x and am437x, based on v4.13-rc2. This version addresses some
comments from Russell King and Johan Hovold in v2 found here [1].

Main changes are to patch two with grouping all the driver data into a single
struct and allowing this to be passed to static functions in the driver,
making sure all probe failures are handled so that we don't use invalid
leftover data in any variables from the exported APIs, fixing a typo in
the ASM code that caused botht he EMIF power management register and its
shadow register to be saved to the same place, cleanup asm-offset macro
definitions, and some general code fixups.

This code is required for low-power modes to work on AM335x and AM437x and a
forthcoming PM series for those platforms will depend on this series. After
both this and the PM series are reviewed I will send the necessary device tree
changes for both, but in the meantime all remaining patches for am335x and
am437x PM can be found here [2].

Regards,
Dave

[1] https://www.spinics.net/lists/linux-omap/msg137203.html
[2] https://github.com/dgerlach/linux-pm/tree/upstream/v4.13/amx3-suspend-v3

Dave Gerlach (2):
  Documentation: dt: Update ti,emif bindings
  memory: ti-emif-sram: introduce relocatable suspend/resume handlers

 .../bindings/memory-controllers/ti/emif.txt        |  18 +-
 arch/arm/kernel/asm-offsets.c                      |   4 +
 drivers/memory/Kconfig                             |  10 +
 drivers/memory/Makefile                            |   4 +
 drivers/memory/emif.h                              |  17 ++
 drivers/memory/ti-emif-pm.c                        | 339 +++++++++++++++++++++
 drivers/memory/ti-emif-sram-pm.S                   | 334 ++++++++++++++++++++
 include/linux/ti-emif-sram.h                       | 147 +++++++++
 8 files changed, 872 insertions(+), 1 deletion(-)
 create mode 100644 drivers/memory/ti-emif-pm.c
 create mode 100644 drivers/memory/ti-emif-sram-pm.S
 create mode 100644 include/linux/ti-emif-sram.h

-- 
2.13.0
