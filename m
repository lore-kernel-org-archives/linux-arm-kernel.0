From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 25 Nov 2014 16:04:15 +0530
Subject: [PATCH 0/8] OPP: Remove OPPs when not in use
Message-ID: <cover.1416910766.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

This is what I came up with in reply to:
http://www.spinics.net/lists/arm-kernel/msg380065.html

The issue was first reported by Stefan Wahren, where he got warnings for
duplicate OPP entries while he tried to insert/remove cpufreq-dt.ko multiple
times.

This set fixes it by first marking each OPP entry as static (created from DT) or
dynamic. And then freeing only static ones from the ->exit() path of cpufreq
drivers. An API is also provided to remove the dynamics ones, but no one is
using it currently.

This also modifies bunch of cpufreq drivers which were using OPPs created from
DT.

At last, thanks to Paul and You to clarify my doubts on RCU. Hope I understood
them correctly :)

Pushed here: git://git.linaro.org/people/viresh.kumar/linux.git cpufreq/opp-remove-v1
Rebased over: pm/linux-next
Tested-on: Exynos 5250, dual cortex A15 with cpufreq-dt.c.

Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>

Viresh Kumar (8):
  opp: rename 'head' as 'rcu_head' or 'srcu_head' based on its type
  opp: don't match for existing OPPs when list is empty
  opp: mark OPPs as 'static' or 'dynamic'
  opp: Introduce APIs to remove OPPs
  arm_big_little: free OPP table created during ->init()
  cpufreq-dt: free OPP table created during ->init()
  exynos5440: free OPP table created during ->init()
  imx6q: free OPP table created during ->init()

 drivers/base/power/opp.c             | 196 +++++++++++++++++++++++++++--------
 drivers/cpufreq/arm_big_little.c     |   7 +-
 drivers/cpufreq/arm_big_little.h     |   5 +-
 drivers/cpufreq/arm_big_little_dt.c  |   1 +
 drivers/cpufreq/cpufreq-dt.c         |   6 +-
 drivers/cpufreq/exynos5440-cpufreq.c |   5 +-
 drivers/cpufreq/imx6q-cpufreq.c      |  11 +-
 include/linux/pm_opp.h               |  12 ++-
 8 files changed, 195 insertions(+), 48 deletions(-)

-- 
2.0.3.693.g996b0fd
