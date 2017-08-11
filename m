From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 11 Aug 2017 15:06:13 +0200
Subject: [PATCH v2 0/5] Unify simple reset drivers
Message-ID: <20170811130618.3676-1-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

from time to time people notice that we are slowly accumulating reset drivers
for simple reset controllers. "Simple" in this context means that they allow to
directly control reset lines by setting and clearing bits in a single register
or in a contiguous register range that is exclusive to the reset controller.

I had previously suggested to add common reset ops for them [1], and Andre
advised to combine them into a single platform driver instead. This series
does that. It should allow to replace the socfpga, stm32, and zx2967 drivers
entirely.
The SoCFPGA device tree quirk parsing is now contained in reset-simple.c.
The sunxi driver is kept around to register the early reset controllers,
but it reuses the exported reset_simple_ops.

[1] https://patchwork.kernel.org/patch/9610709/

regards
Philipp

Philipp Zabel (5):
  reset: add reset-simple to unify socfpga, stm32, sunxi, and zx2967
  reset: socfpga: use the reset-simple driver
  reset: stm32: use the reset-simple driver
  reset: zx2967: use the reset-simple driver
  reset: simple: read back to make sure changes are applied

 MAINTAINERS                   |   1 -
 drivers/reset/Kconfig         |  24 +++---
 drivers/reset/Makefile        |   4 +-
 drivers/reset/reset-simple.c  | 183 ++++++++++++++++++++++++++++++++++++++++++
 drivers/reset/reset-simple.h  |  33 ++++++++
 drivers/reset/reset-socfpga.c | 154 -----------------------------------
 drivers/reset/reset-stm32.c   | 108 -------------------------
 drivers/reset/reset-sunxi.c   | 104 ++----------------------
 drivers/reset/reset-zx2967.c  |  99 -----------------------
 9 files changed, 232 insertions(+), 478 deletions(-)
 create mode 100644 drivers/reset/reset-simple.c
 create mode 100644 drivers/reset/reset-simple.h
 delete mode 100644 drivers/reset/reset-socfpga.c
 delete mode 100644 drivers/reset/reset-stm32.c
 delete mode 100644 drivers/reset/reset-zx2967.c

-- 
2.11.0
