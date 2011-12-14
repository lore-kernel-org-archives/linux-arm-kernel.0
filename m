From: mturquette@ti.com (Mike Turquette)
Date: Tue, 13 Dec 2011 20:31:22 -0800
Subject: [PATCH 0/6] HACK: OMAP: testing common clk features
Message-ID: <1323837088-2469-1-git-send-email-mturquette@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is just informational and illustrates how to use some of the
common struct clk features.  I wrote this code when testing the common
struct patches.  These are hacks and put some of code to use
practically.

Firstly this series models the clocks between the MPU PLL and the ARM IP
a bit more closely.  Then CPUfreq is changed to use this new mpu_clk,
which passes the rate change up to the PLL.

Another new clk, mpu_periphclk, is introduced which divides mpu_clk by
2.  The recent smp_twd code from Linus W. is modified to use clk rate
change notifiers for mpu_periphclk instead of CPUfreq notifiers.

Finally this series introduces a new OPP for the MPU on OMAP4 which
bypasses the MPU DPLL and exercies some of the clk frameworks parent
switching code.  Using this OPP is probably unsafe and will permanently
ruin your board, your desk and your home.

You can find the common struct clk patches at,
https://lkml.org/lkml/2011/12/13/451

OMAP support for the common struct clk is needed for this series and can
be found at,
http://article.gmane.org/gmane.linux.ports.arm.omap/68217

These patches can be found at,
http://git.linaro.org/gitweb?p=people/mturquette/linux.git;a=shortlog;h=refs/heads/v3.2-rc5-clkv4-omap-pm-testing
git://git.linaro.org/people/mturquette/linux.git v3.2-rc5-clkv4-omap-pm-testing

Linus Walleij (1):
  smp_twd: Reconfigure clockevents after cpufreq change

Mike Turquette (5):
  HACK: omap: opp: add fake 400MHz OPP to bypass MPU
  omap: clk: .round_rate for propagating to parents
  HACK: omap: clk: add mpu_periphclk clk node
  HACK: cpufreq: omap: change mpu_clk's rate
  HACK: arm: reprogram twd based on clk notifier

 arch/arm/kernel/smp_twd.c            |   89 +++++++++++++++++++++++++++++++--
 arch/arm/mach-omap2/clkt_clksel.c    |    8 +++
 arch/arm/mach-omap2/clock.h          |    2 +
 arch/arm/mach-omap2/clock44xx_data.c |   37 ++++++++++++++-
 arch/arm/mach-omap2/opp4xxx_data.c   |    9 ++++
 drivers/cpufreq/omap-cpufreq.c       |    2 +-
 6 files changed, 139 insertions(+), 8 deletions(-)

-- 
1.7.5.4
