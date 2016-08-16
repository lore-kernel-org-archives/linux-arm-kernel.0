From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 16 Aug 2016 15:34:57 +0200
Subject: [RFC 00/17] clk: Add per-controller locks to fix deadlocks
Message-ID: <1471354514-24224-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

RFC, please, do not apply, maybe except patch #1 which is harmless.


Introduction
============
The patchset brings new entity: clock controller representing a hardware
block.  The clock controller comes with its own prepare lock which
is used then in many places.  The idea is to fix the deadlock mentioned
in commit 10ff4c5239a1 ("i2c: exynos5: Fix possible ABBA deadlock by keeping
I2C clock prepared") and commit 34e81ad5f0b6 ("i2c: s3c2410: fix ABBA deadlock
by keeping clock prepared").


Disclaimer
==========
Request for comments, so:
1. Only exynos_defconfig builds,
2. A lot of FIXME/TODO note still,
3. Checkpatch not run, lines not aligned,
4. Other (non-exynos) drivers not converted,
5. Probably not yet bisectable,
6. Locking became quite complex.
   The previous one lock was simple.  Inefficient and dead-lock prone but
   simple.  Because of clock hierarchy spanning through controllers, the
   new locking became quite complicated.  I don't like it but...


Details
=======
In Exynos-based boards case the deadlock occurs between clock's
prepare_lock and regmap-i2c's lock:

CPU #0:                             CPU #1:
lock(regmap)
                                    s2mps11-clk: clk_prepare_lock()

i2c-exynos: clk_prepare_lock() - wait
                                    lock(regmap) - wait

The clk_prepare_lock() on both CPUs come from different clock drivers
and components:
1. I2C clock is part of SoC block and is required by i2c-s3c2410/i2c-exynos5
   driver,
2. S2MPS11 clock is separate device, however driver uses I2C regmap.

The deadlock was reported by lockdep (always) and was happening
in 20% of boots of Odroid XU3 with multi_v7 defconfig.  Workaround for
deadlock was implemented by removing prepare/unprepare calls from I2C
transfers.  However these are just workarounds... which after applying
this patch can be reverted.

Additionally Marek Szyprowski's work on domains/clocks/pinctrl exposed
the deadlock again in different configuration.


Comments as usual are welcomed.

Best regards,
Krzysztof

Krzysztof Kozlowski (17):
  clk: bcm2835: Rename clk_register to avoid name conflict
  clk: Add clock controller to fine-grain the prepare lock
  clk: s2mps11: Switch to new clock controller API
  clk: samsung: Allocate a clock controller in context
  clk: fixed-rate: Switch to new clock controller API
  clk: gate: Switch to new clock controller API
  clk: mux: Switch to new clock controller API
  clk: fixed-factor: Switch to new clock controller API
  clk: divider: Switch to new clock controller API
  clk: composite: Switch to new clock controller API
  clk: gpio: Switch to new clock controller API
  ASoC: samsung: Switch to new clock controller API
  clk: samsung: audss: samsung: Switch to new clock controller API
  clk: samsung: clkout: samsung: Switch to new clock controller API
  clk: Use per-controller locking
  Revert "i2c: exynos5: Fix possible ABBA deadlock by keeping I2C clock
    prepared"
  Revert "i2c: s3c2410: fix ABBA deadlock by keeping clock prepared"

 drivers/clk/bcm/clk-bcm2835.c           |   8 +-
 drivers/clk/clk-composite.c             |   8 +-
 drivers/clk/clk-divider.c               |  10 +-
 drivers/clk/clk-fixed-factor.c          |  11 +-
 drivers/clk/clk-fixed-rate.c            |  28 +-
 drivers/clk/clk-fractional-divider.c    |   5 +-
 drivers/clk/clk-gate.c                  |   8 +-
 drivers/clk/clk-gpio.c                  |  29 +-
 drivers/clk/clk-mux.c                   |  32 ++-
 drivers/clk/clk-s2mps11.c               |  10 +-
 drivers/clk/clk.c                       | 456 +++++++++++++++++++++++++++-----
 drivers/clk/samsung/clk-exynos-audss.c  |  30 ++-
 drivers/clk/samsung/clk-exynos-clkout.c |  11 +-
 drivers/clk/samsung/clk.c               |  25 +-
 drivers/clk/samsung/clk.h               |   1 +
 drivers/i2c/busses/i2c-exynos5.c        |  24 +-
 drivers/i2c/busses/i2c-s3c2410.c        |  23 +-
 include/linux/clk-provider.h            |  88 ++++--
 include/linux/clk.h                     |   1 +
 sound/soc/samsung/i2s.c                 |  13 +-
 20 files changed, 612 insertions(+), 209 deletions(-)

-- 
1.9.1
