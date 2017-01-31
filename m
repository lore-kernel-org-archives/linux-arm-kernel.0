From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Tue, 31 Jan 2017 07:17:21 +0000
Subject: [PATCH V2 07/12] PM / OPP: Update OPP users to put reference
References: <cover.1485146406.git.viresh.kumar@linaro.org>
 <CGME20170123044228epcas3p35fdbe94a890062e9d66e33a3b5e4d571@epcas3p3.samsung.com>
Message-ID: <20170131071721epcms1p6a4da8e0add4547573d40bbbb55d37b74@epcms1p6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This patch updates dev_pm_opp_find_freq_*() routines to get a reference
> to the OPPs returned by them.
> 
> Also updates the users of dev_pm_opp_find_freq_*() routines to call
> dev_pm_opp_put() after they are done using the OPPs.
> 
> As it is guaranteed the that OPPs wouldn't get freed while being used,
> the RCU read side locking present with the users isn't required anymore.
> Drop it as well.
> 
> This patch also updates all users of devfreq_recommended_opp() which was
> returning an OPP received from the OPP core.
> 
> Note that some of the OPP core routines have gained
> rcu_read_{lock|unlock}() calls, as those still use RCU specific APIs
> within them.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com> [Devfreq]

This patch gets a lot of fails during application.

For devfreq-side, I've got:
error: drivers/devfreq/devfreq.c: patch does not apply
error: patch failed: drivers/devfreq/exynos-bus.c:103
error: drivers/devfreq/exynos-bus.c: patch does not apply
error: patch failed: drivers/devfreq/governor_passive.c:59
error: drivers/devfreq/governor_passive.c: patch does not apply
error: patch failed: drivers/devfreq/rk3399_dmc.c:91
error: drivers/devfreq/rk3399_dmc.c: patch does not apply
error: patch failed: drivers/devfreq/tegra-devfreq.c:487
error: drivers/devfreq/tegra-devfreq.c: patch does not apply

With the condition that you are going to properly rebase the patch,
you may add "Reviewed-by" from me.
(the code itself looks fine.)

Cheers,
MyungJoo

> ---
>  arch/arm/mach-omap2/pm.c             |   5 +-
>  drivers/base/power/opp/core.c        | 114 +++++++++++++++++++----------------
>  drivers/base/power/opp/cpu.c         |  22 ++-----
>  drivers/clk/tegra/clk-dfll.c         |  17 ++----
>  drivers/cpufreq/exynos5440-cpufreq.c |   5 +-
>  drivers/cpufreq/imx6q-cpufreq.c      |  10 +--
>  drivers/cpufreq/mt8173-cpufreq.c     |   8 +--
>  drivers/cpufreq/omap-cpufreq.c       |   4 +-
>  drivers/devfreq/devfreq.c            |  14 ++---
>  drivers/devfreq/exynos-bus.c         |  14 ++---
>  drivers/devfreq/governor_passive.c   |   4 +-
>  drivers/devfreq/rk3399_dmc.c         |  16 ++---
>  drivers/devfreq/tegra-devfreq.c      |   4 +-
>  drivers/thermal/cpu_cooling.c        |  11 +---
>  drivers/thermal/devfreq_cooling.c    |  15 ++---
>  15 files changed, 110 insertions(+), 153 deletions(-)
> 
