From: rubini@gnudd.com (Alessandro Rubini)
Date: Thu, 7 Jun 2012 15:52:24 +0200
Subject: [PATCH V2 0/3] i2c-nomadik changes
Message-ID: <cover.1339076448.git.rubini@gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

V2:
	- use linux/platform_data/i2c-nomadik.h not linux/i2c-nomadik.h
	- format patch with -M
	- added lee jones to the Cc: list (for device tree support)
	- minor rewording of the commit messages

Slightly edited for typos explanation, otherwise same as V1:

The patch set turns a platform device into an amba device. Its users,
i.e. mach-ux500, are converted too.  The set has no external
dependencies, although is has no visible effect until other patches
are accepted.

Reasoning:

In the STA2X11 I/O hub we are exporting a number of AMBA peripherals
to the PCI world. By using a generic pci-amba driver there is no further
code for each device, provided they are already registered under the
AMBA bus.  I already submitted the generic bridge and I'm waiting for
feedback on it (https://lkml.org/lkml/2012/5/28/194).

Status of this patch set:

The users of the driver (i.e. mach-ux500) compile properly, but I
couldn't test on any board.  The driver, as is, works on x86 under the
PCI bridge, with the not-yet-upstream clock framework and platform
data for sta2x11 devices.  However, this set is not introducing any
dead code as it only adds more flexibility.  Most of the patch is
just two renames: s/platform_device/amba_device/ and s/pdev/adev/ .

Alessandro Rubini (3):
  i2c-nomadik: move header to <linux/platform_data/i2c-nomadik.h>
  i2c-nomadik: turn the platform driver to an amba driver
  i2c-nomadik: depend on ARM_AMBA, not PLAT_NOMADIK

 arch/arm/mach-ux500/board-mop500.c                 |    2 +-
 arch/arm/mach-ux500/devices-common.h               |   23 +---
 drivers/i2c/busses/Kconfig                         |    5 +-
 drivers/i2c/busses/i2c-nomadik.c                   |  140 ++++++++++----------
 .../linux/platform_data/i2c-nomadik.h              |    6 +-
 5 files changed, 80 insertions(+), 96 deletions(-)
 rename arch/arm/plat-nomadik/include/plat/i2c.h => include/linux/platform_data/i2c-nomadik.h (91%)

-- 
1.7.7.2
