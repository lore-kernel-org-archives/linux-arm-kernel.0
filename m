From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 23 Aug 2018 13:44:14 +0900
Subject: [PATCH v3 0/6] mmc: tmio: refactor TMIO core a bit and add UniPhier
 SD/eMMC controller support
Message-ID: <1534999460-15111-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Add UniPhier SD/eMMC controller support.

As a preparation, I changed tmio_mmc_set_clock() to a platform hook.
The clock rate setting is platform-specific, and UniPhier variants
will add another way.  I thought it would be better to split this
to a hook to avoid a mess.

V3 is rebase on top of Linus' tree.

I dropped 6/7 because Renesas added more quirks
in the current MW.


Masahiro Yamada (6):
  mmc: tmio: replace tmio_mmc_clk_stop() calls with tmio_mmc_set_clock()
  mmc: tmio: move tmio_mmc_set_clock() to platform hook
  dt-bindings: mmc: add DT binding for UniPhier SD/eMMC controller
  mmc: uniphier-sd: add UniPhier SD/eMMC controller driver
  mmc: renesas_sdhi: merge clk_{start,stop} functions to set_clock
  mmc: tmio: refactor CLK_CTL bit calculation

 .../devicetree/bindings/mmc/uniphier-sd.txt        |  55 ++
 MAINTAINERS                                        |   1 +
 drivers/mmc/host/Kconfig                           |  10 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/renesas_sdhi_core.c               |  48 +-
 drivers/mmc/host/tmio_mmc.c                        |  56 ++
 drivers/mmc/host/tmio_mmc.h                        |   4 +-
 drivers/mmc/host/tmio_mmc_core.c                   |  92 +--
 drivers/mmc/host/uniphier-sd.c                     | 693 +++++++++++++++++++++
 9 files changed, 871 insertions(+), 89 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/uniphier-sd.txt
 create mode 100644 drivers/mmc/host/uniphier-sd.c

-- 
2.7.4
