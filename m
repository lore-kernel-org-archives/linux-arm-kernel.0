From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Thu, 24 Jan 2013 17:45:52 +0100
Subject: [PATCH 0/4] clk: Provide option to unprepare unused clocks at late
 init
Message-ID: <1359045956-30741-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

The disable_unused sequence executed at late init, is already handling the
fast unused ungated clocks to be gated. This patchset extends this sequence to
include the slow unused prepared clocks to be unprepared.

The default behavior will not change in this patchset. To unprepare unused
clocks during the disable_unused sequence, the clk_hw needs to implement
the new optional callback, is_prepared.

The motivation for this patchset is to save power. Clocks that is from
bootloaders prepared|enabled, but not used should be unprepared|disabled.

Patch 4 is specific for ux500, which implements the is_prepared callback
for it's PRMCU clocks.

Note that patch 1-3 has been sent earlier, but since a proof of concept
patch could be useful, as patch 4 is, the hole patchset is resent.

Ulf Hansson (4):
  clk: Introduce optional is_prepared callback
  clk: Unprepare the unused prepared slow clocks at late init
  clk: Introduce optional unprepare_unused callback
  clk: ux500: Support is_prepared callback for clk-prcmu

 drivers/clk/clk.c             |   53 ++++++++++++++++
 drivers/clk/ux500/clk-prcmu.c |  134 ++++++++++++++++++++++++-----------------
 include/linux/clk-provider.h  |   11 ++++
 3 files changed, 144 insertions(+), 54 deletions(-)

-- 
1.7.10
