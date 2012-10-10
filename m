From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Wed, 10 Oct 2012 13:42:21 +0200
Subject: [PATCH 0/8] clk: ux500: Fixup smp_twd clk for clk notifiers
Message-ID: <1349869349-8070-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

This collection of patches fixup smp_twd clk so clk notifiers can use it
properly.

An armss clk is added which is used from cpufreq driver to update frequency
instead of using the prcmu_set|get_arm_opp API. The smp_twd clk is converted
to a fixed_factor clk with armss clk as parent and with a fixed divider of two.
Therfore it will be updated when armss clk is updated and thus corresponding
notifications will be triggered.

I would prefer if these patches could be merged through Mike Turquette's clk
tree, if he think it seems feasible of course. For the mfd and cpufreq patches
I hope Samuel Ortiz and Rafael J. Wysocki if fine by acking patches. If there
are other preferred way of dealing with this I am happy to change setup.

Do note that, the four below patches have already been sent and most of them
have already been acked/reviewed but not merged. I have included them in this
series to provide full overview for reviewers.

ARM: ux500: Remove cpufreq platform device
mfd: db8500: Provide cpufreq table as platform data
cpufreq: db8500: Register as a platform driver
cpufreq: db8500: Fetch cpufreq table from platform data

Patches are based on Linus Torvalds tree with latest commit as of okt 10.

Ulf Hansson (8):
  ARM: ux500: Remove cpufreq platform device
  mfd: db8500: Provide cpufreq table as platform data
  cpufreq: db8500: Register as a platform driver
  cpufreq: db8500: Fetch cpufreq table from platform data
  mfd: db8500: Connect ARMSS clk to ARM OPP
  clk: ux500: Support for prcmu_scalable_rate clock
  clk: ux500: Add armss clk and fixup smp_twd clk for u8500
  cpufreq: db8500: Use armss clk to update frequency

 arch/arm/mach-ux500/cpu-db8500.c |    6 ---
 drivers/clk/ux500/clk-prcmu.c    |   17 +++++++
 drivers/clk/ux500/clk.h          |    6 +++
 drivers/clk/ux500/u8500_clk.c    |   14 +++---
 drivers/cpufreq/db8500-cpufreq.c |  101 +++++++++++++++++++++-----------------
 drivers/mfd/db8500-prcmu.c       |   82 ++++++++++++++++++++++++++-----
 6 files changed, 155 insertions(+), 71 deletions(-)

-- 
1.7.10
