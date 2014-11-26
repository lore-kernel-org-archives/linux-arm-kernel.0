From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 26 Nov 2014 15:59:48 +0200
Subject: [PATCH v2 0/5] i2c: davinci improvements and fixes
Message-ID: <1417010393-30598-1-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contains some fixes and improvements for Davinci I2C:
patch 1 - small improvement
patch 2 - fixes "Bus busy" state for some case (was reported long time ago:()

patch 3-5 - converts driver to use I2C bus recovery infrastructure and
adds Davinci I2C bus recovery mechanizm based on using ICPFUNC registers.
These patches are combination of two patches from Ben Gardiner [1] and
Mike Looijmans [2] which i've reworked to use I2C bus recovery infrastructure

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-April/047305.html
"[PATCH 0/6] i2c-davinci gpio pulsed SCL recovery with ICPFUNC"
[2] https://lkml.org/lkml/2014/2/28/133
"[PATCH] i2c-davinci: Implement a bus recovery that actually works"

Changes in v2:
- patch 1: error handling improved
- patch 2: commit message updated
- patch 4: minor comments applied
- patch 5: added new optional DT property "ti,has-pfunc"

Link on v1:
 http://www.spinics.net/lists/linux-i2c/msg17601.html

CC: Sekhar Nori <nsekhar@ti.com>
CC: Kevin Hilman <khilman@deeprootsystems.com>
CC: Santosh Shilimkar <ssantosh@kernel.org>
CC: Murali Karicheri <m-karicheri2@ti.com>

Grygorii Strashko (5):
  i2c: i2c-davinci: switch to use platform_get_irq
  i2c: davinci: query STP always when NACK is received
  i2c: recovery: change input parameter to i2c_adapter for prepare/unprepare_recovery
  i2c: davinci: use bus recovery infrastructure
  i2c: davinci: use ICPFUNC to toggle I2C as gpio for bus recovery

 .../devicetree/bindings/i2c/i2c-davinci.txt        |   3 +
 drivers/i2c/busses/i2c-davinci.c                   | 205 +++++++++++++++------
 drivers/i2c/i2c-core.c                             |   4 +-
 include/linux/i2c.h                                |   4 +-
 include/linux/platform_data/i2c-davinci.h          |   1 +
 5 files changed, 159 insertions(+), 58 deletions(-)

-- 
1.9.1
