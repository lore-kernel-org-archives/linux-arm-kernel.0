From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 17 Oct 2017 15:03:01 +0200
Subject: [PATCH v4 0/5] Unify simple reset drivers
Message-ID: <20171017130306.881-1-p.zabel@pengutronix.de>
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

Changes since v3 [1]:
 - Split the first patch into reset-simple addition (now patch 1)
   and reset-sunxi conversion (now patch 2). I'd really like to get
   an ok from the sunxi maintainers for the second one.
 - Rename reset_simple_set to reset_simple_update, as that function
   is used to both set and clear the control bit.
 - Changed reset-simple to only ever warn about the missing
   "altr,modrst-offset" property on socfpga, in case another compatible
   will use a non-zero default reg_offset in the future.
 - Dropped patch 5 ("reset: simple: read back to make sure changes are
   applied"). Its use is purely theoretical, and this series is about
   unifying the existing drivers.


[1] https://patchwork.kernel.org/patch/9903375/
    https://patchwork.kernel.org/patch/9903373/
    https://patchwork.kernel.org/patch/9903371/
    https://patchwork.kernel.org/patch/9903377/
    https://patchwork.kernel.org/patch/9903379/

regards
Philipp

Philipp Zabel (5):
  reset: add reset-simple to unify socfpga, stm32, sunxi, and zx2967
  reset: sunxi: use reset-simple driver
  reset: socfpga: use the reset-simple driver
  reset: stm32: use the reset-simple driver
  reset: zx2967: use the reset-simple driver

 MAINTAINERS                   |   1 -
 drivers/reset/Kconfig         |  24 ++----
 drivers/reset/Makefile        |   4 +-
 drivers/reset/reset-simple.c  | 186 ++++++++++++++++++++++++++++++++++++++++++
 drivers/reset/reset-simple.h  |  45 ++++++++++
 drivers/reset/reset-socfpga.c | 157 -----------------------------------
 drivers/reset/reset-stm32.c   | 108 ------------------------
 drivers/reset/reset-sunxi.c   | 104 ++---------------------
 drivers/reset/reset-zx2967.c  |  99 ----------------------
 9 files changed, 247 insertions(+), 481 deletions(-)
 create mode 100644 drivers/reset/reset-simple.c
 create mode 100644 drivers/reset/reset-simple.h
 delete mode 100644 drivers/reset/reset-socfpga.c
 delete mode 100644 drivers/reset/reset-stm32.c
 delete mode 100644 drivers/reset/reset-zx2967.c

-- 
2.11.0
