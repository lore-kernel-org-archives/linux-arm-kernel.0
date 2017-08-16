From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 16 Aug 2017 11:46:56 +0200
Subject: [PATCH v3 0/5] Unify simple reset drivers
Message-ID: <20170816094701.30678-1-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series introduces common reset ops for simple reset controllers.
"Simple" in this context means that they allow to directly control reset
lines by setting and clearing bits in a single register or in a contiguous
register range that is exclusive to the reset controller.

Parts of the sunxi driver and the socfpga, stm32, and zx2967 drivers are
merged into a single reset-simple driver.
The sunxi driver is kept around to register the early reset controllers,
but it reuses the exported reset_simple_ops.

The first patch depends on [1] or commit 726cc791c9b9 ("reset: sunxi: fix
number of reset lines") in linux-next. On linux-next, the second patch will
trivially conflict with commit 7799167b7a14 ("regulator: Convert to using
%pOF instead of full_name").

Changes since v2 [2]:
 - Use of_device_get_match_data instead of of_match_device,
   add kerneldoc comment for struct reset_simple_devdata and struct
   reset_simple_data, suggested by Chen-Yu.
 - Add reg_offset and nr_reset override to struct reset_simple_devdata,
   instead of special casing socfpga, always check "altr,modrst-offset"
   device tree property if a default reg_offset is set, based on
   Alexandru's advice.
 - Rename "*inverted" properties to "*active_low".

[1] https://patchwork.kernel.org/patch/9895433/
[2] https://patchwork.kernel.org/patch/9895833/
    https://patchwork.kernel.org/patch/9895819/
    https://patchwork.kernel.org/patch/9895831/
    https://patchwork.kernel.org/patch/9895815/
    https://patchwork.kernel.org/patch/9895841/

regards
Philipp

Philipp Zabel (5):
  reset: add reset-simple to unify socfpga, stm32, sunxi, and zx2967
  reset: socfpga: use the reset-simple driver
  reset: stm32: use the reset-simple driver
  reset: zx2967: use the reset-simple driver
  reset: simple: read back to make sure changes are applied

 MAINTAINERS                   |   1 -
 drivers/reset/Kconfig         |  24 ++----
 drivers/reset/Makefile        |   4 +-
 drivers/reset/reset-simple.c  | 188 ++++++++++++++++++++++++++++++++++++++++++
 drivers/reset/reset-simple.h  |  45 ++++++++++
 drivers/reset/reset-socfpga.c | 154 ----------------------------------
 drivers/reset/reset-stm32.c   | 108 ------------------------
 drivers/reset/reset-sunxi.c   | 104 ++---------------------
 drivers/reset/reset-zx2967.c  |  99 ----------------------
 9 files changed, 249 insertions(+), 478 deletions(-)
 create mode 100644 drivers/reset/reset-simple.c
 create mode 100644 drivers/reset/reset-simple.h
 delete mode 100644 drivers/reset/reset-socfpga.c
 delete mode 100644 drivers/reset/reset-stm32.c
 delete mode 100644 drivers/reset/reset-zx2967.c

-- 
2.11.0
