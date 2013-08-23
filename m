From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 23 Aug 2013 17:03:42 +0200
Subject: [PATCH v3 0/5] clk: clock deregistration support
Message-ID: <1377270227-1030-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set is intended to add clock deregistration support to
the common clock framework, required for clock suppliers as loadable
modules.  Previous version of this series can be found at [1].

Changes since v2:
 - reordered the patches so the race condition is fixed before it can
   actually cause any issues,
 - fixed handling of NULL clock pointers in __clk_get(), __clk_put(),
 - added patch adding actual asignment of clk->owner; more details are
   discussed in that specific patch.

Changes since v1:
 - moved of_clk_{lock, unlock}, __of_clk_get_from_provider() function
   declaractions to a local header,
 - renamed clk_dummy_* to clk_nodrv_*.


[1] http://www.spinics.net/lists/linux-sh/msg22948.html

Sylwester Nawrocki (5):
  clk: Provide not locked variant of of_clk_get_from_provider()
  clkdev: Fix race condition in clock lookup from device tree
  clk: Add common __clk_get(), __clk_put() implementations
  clk: Assign module owner of a clock being registered
  clk: Implement clk_unregister

 arch/arm/include/asm/clkdev.h      |    2 +
 arch/blackfin/include/asm/clkdev.h |    2 +
 arch/mips/include/asm/clkdev.h     |    2 +
 arch/sh/include/asm/clkdev.h       |    2 +
 drivers/clk/clk.c                  |  189 +++++++++++++++++++++++++++++++++---
 drivers/clk/clk.h                  |   16 +++
 drivers/clk/clkdev.c               |   12 ++-
 include/linux/clk-private.h        |    5 +
 include/linux/clk-provider.h       |    2 +
 include/linux/clkdev.h             |    5 +
 10 files changed, 224 insertions(+), 13 deletions(-)
 create mode 100644 drivers/clk/clk.h

--
1.7.9.5
