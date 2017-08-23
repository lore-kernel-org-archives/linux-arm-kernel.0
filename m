From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Thu, 24 Aug 2017 00:10:03 +0800
Subject: [PATCH 0/7] PM / OPP: per OPP node clock support and imx7ulp cpufreq
 driver
Message-ID: <1503504610-12880-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series does three things:
1) Add platform specific set_clk function
2) Add per OPP node clock support
3) Add imx7ulp cpufreq driver support

3 is depends on 1 & 2.

MX7ULP supports HSRUN mode (528 Mhz), RUN mode (413 Mhz) and VLPR mode
(restricted to FIRC clock, usually 48 Mhz). This patch adds the cpufreq
driver support for HSRUN and RUN mode.
When in different modes, the A7 core is using different clocks:
RUN:	clk run_divcore
HSRUN:	clk hsrun_divcore

Thus, this driver replies on the newly added features in OPP core framework
patch 1~6: e.g.
"PM / OPP: use OPP node clock to set CPU frequency"

And since IMX7ULP CPU clock setting is different from the generic
set OPP clock, we also implemented a private set_clk function.

Dong Aisheng (7):
  PM / OPP: Add platform specific set_clk function
  dt-bindings: PM / OPP: add clocks per OPP node support
  PM / OPP: rename opp_table->clk to opp_table->cur_clk
  PM / OPP: use OPP node clock to set CPU frequency
  PM / OPP: Add dev_pm_opp_get_cur_clk()
  cpufreq: make cpufreq_generic_init transition_latency default to
    CPUFREQ_ETERNAL
  cpufreq: add imx7ulp cpufreq driver

 Documentation/devicetree/bindings/opp/opp.txt |  52 ++++++
 drivers/base/power/opp/core.c                 | 155 ++++++++++++++---
 drivers/base/power/opp/of.c                   |   8 +
 drivers/base/power/opp/opp.h                  |  11 +-
 drivers/cpufreq/Kconfig.arm                   |   8 +
 drivers/cpufreq/Makefile                      |   1 +
 drivers/cpufreq/cpufreq.c                     |   2 +
 drivers/cpufreq/imx7ulp-cpufreq.c             | 234 ++++++++++++++++++++++++++
 include/linux/pm_opp.h                        |  16 ++
 9 files changed, 466 insertions(+), 21 deletions(-)
 create mode 100644 drivers/cpufreq/imx7ulp-cpufreq.c

-- 
2.7.4
