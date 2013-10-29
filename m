From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 29 Oct 2013 20:51:03 +0100
Subject: [PATCH v7 0/5] clk: clock deregistration support
Message-ID: <1383076268-8984-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series implements clock deregistration in the common clock
framework. Detailed changes are listed at each patch. I have included
an additional patch in this series for the omap3isp driver, required 
to avoid regressions.

Changes since v5:
 - fixed NULL clock handling in __clk_get(), __clk_put (patch 5/5).

Changes since v4:
 - removed stray struct module forward declaration in patch 3/5.

Changes since v3:
 - replaced WARN_ON() with WARN_ON_ONCE() in clk_nodrv_disable_unprepare()
   callback.

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

Sylwester Nawrocki (5):
  omap3isp: Modify clocks registration to avoid circular references
  clk: Provide not locked variant of of_clk_get_from_provider()
  clkdev: Fix race condition in clock lookup from device tree
  clk: Add common __clk_get(), __clk_put() implementations
  clk: Implement clk_unregister()

 arch/arm/include/asm/clkdev.h         |    2 +
 arch/blackfin/include/asm/clkdev.h    |    2 +
 arch/mips/include/asm/clkdev.h        |    2 +
 arch/sh/include/asm/clkdev.h          |    2 +
 drivers/clk/clk.c                     |  185 +++++++++++++++++++++++++++++++--
 drivers/clk/clk.h                     |   16 +++
 drivers/clk/clkdev.c                  |   12 ++-
 drivers/media/platform/omap3isp/isp.c |   22 ++--
 drivers/media/platform/omap3isp/isp.h |    1 +
 include/linux/clk-private.h           |    5 +
 include/linux/clkdev.h                |    5 +
 11 files changed, 235 insertions(+), 19 deletions(-)
 create mode 100644 drivers/clk/clk.h

-- 
1.7.9.5
