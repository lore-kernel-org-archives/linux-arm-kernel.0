From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 27 Feb 2013 20:49:24 -0800
Subject: [PATCH v3 0/5] common clk framework reentrancy & dvfs, take 3
Message-ID: <1362026969-11457-1-git-send-email-mturquette@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series implements reentrancy for the common clk implementation of
the clk.h api.  Making reentrant calls into the clock framework is both
necessary and desirable for many use cases such as enabling off-chip
clocks via i2c.  The first patch in the series implements this.

A neat side effect of reentrancy is that it is possible for platforms
using voltage regulators controlled via i2c to register rate-change
notifier handlers to scale voltage as a function of clock rate.  This is
an effective way to implement dynamic voltage & frequency scaling.
Patch #2 implements a helper function for registering such a notifier
handler.

The third patch in the series demonstrates dvfs on OMAP platforms by
modifying the cpufreq-omap driver; it migrates the voltage scaling logic
out of the cpufreq driver's .target callback and registers callbacks via
the helper introduced in patch #2.

Patches four and five are purely test coverage.  And what better way to
test than to muck with fragile PLL programming code?  These patches test
out a lot of the aforementioned reentrancy in the OMAP3+ DPLL code.
They are not for merging, but as a demonstration of what is now
possible.

Finally, I know that Documentation/clk.txt needs an update for these
changes but I wanted this on the list before I flew out to LCA 2013.
I'll provide that update during or after the conference.

Two previous (and considerably more insane) attempts at this,
v1: http://article.gmane.org/gmane.linux.kernel/1327866
v2: http://marc.info/?l=linux-kernel&m=134507429302463&w=2

Mike Turquette (5):
  clk: allow reentrant calls into the clk framework
  clk: notifier handler for dynamic voltage scaling
  cpufreq: omap: scale regulator from clk notifier
  HACK: set_parent callback for OMAP4 non-core DPLLs
  HACK: omap: opp: add fake 400MHz OPP to bypass MPU

 arch/arm/mach-omap2/cclock44xx_data.c |    1 +
 arch/arm/mach-omap2/clock.h           |    1 +
 arch/arm/mach-omap2/dpll3xxx.c        |  107 ++++++++++----
 arch/arm/mach-omap2/opp4xxx_data.c    |   18 +++
 drivers/clk/Makefile                  |    1 +
 drivers/clk/clk.c                     |  254 ++++++++++++++++++++++++---------
 drivers/clk/dvfs.c                    |  125 ++++++++++++++++
 drivers/cpufreq/omap-cpufreq.c        |   82 +++--------
 include/linux/clk.h                   |   27 +++-
 9 files changed, 459 insertions(+), 157 deletions(-)
 create mode 100644 drivers/clk/dvfs.c

-- 
1.7.10.4
