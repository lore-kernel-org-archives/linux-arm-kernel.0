From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 10 Sep 2012 17:12:38 -0600
Subject: [PATCH 2/2] ARM: tegra: cpu-tegra: explicitly manage re-parenting
In-Reply-To: <1347318758-7954-1-git-send-email-swarren@wwwdotorg.org>
References: <1347318758-7954-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1347318758-7954-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

When changing a PLL's rate, it must have no active children. The CPU
clock cannot be stopped, and CPU clock's divider is not used. The old
clock driver used to handle this by internally reparenting the CPU clock
onto a different PLL when changing the CPU clock rate. However, the new
common-clock based clock driver does not do this, and probably cannot do
this due to the locking issues it would cause.

To solve this, have the Tegra cpufreq driver explicitly perform the
reparenting operations itself. This is probably reasonable anyway,
since such reparenting is somewhat a matter of policy (e.g. which
alternate clock source to use, whether to leave the CPU clock a child
of the alternate clock source if it's running at the desired rate),
and hence is something more appropriate for the cpufreq driver than
the core clock driver anyway.

Cc: Prashant Gaikwad <pgaikwad@nvidia.com>
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
These two fixes are required to resolve the regression exposed by commit
ec971ea "ARM: add cpufreq transiton notifier to adjust loops_per_jiffy for
smp"
---
 arch/arm/mach-tegra/cpu-tegra.c |   48 ++++++++++++++++++++++++++++++++++++++-
 1 files changed, 47 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/cpu-tegra.c b/arch/arm/mach-tegra/cpu-tegra.c
index ceb52db..627bf0f 100644
--- a/arch/arm/mach-tegra/cpu-tegra.c
+++ b/arch/arm/mach-tegra/cpu-tegra.c
@@ -49,6 +49,8 @@ static struct cpufreq_frequency_table freq_table[] = {
 #define NUM_CPUS	2
 
 static struct clk *cpu_clk;
+static struct clk *pll_x_clk;
+static struct clk *pll_p_clk;
 static struct clk *emc_clk;
 
 static unsigned long target_cpu_speed[NUM_CPUS];
@@ -71,6 +73,42 @@ static unsigned int tegra_getspeed(unsigned int cpu)
 	return rate;
 }
 
+static int tegra_cpu_clk_set_rate(unsigned long rate)
+{
+	int ret;
+
+	/*
+	 * Take an extra reference to the main pll so it doesn't turn
+	 * off when we move the cpu off of it
+	 */
+	clk_prepare_enable(pll_x_clk);
+
+	ret = clk_set_parent(cpu_clk, pll_p_clk);
+	if (ret) {
+		pr_err("Failed to switch cpu to clock pll_p\n");
+		goto out;
+	}
+
+	if (rate == clk_get_rate(pll_p_clk))
+		goto out;
+
+	ret = clk_set_rate(pll_x_clk, rate);
+	if (ret) {
+		pr_err("Failed to change pll_x to %lu\n", rate);
+		goto out;
+	}
+
+	ret = clk_set_parent(cpu_clk, pll_x_clk);
+	if (ret) {
+		pr_err("Failed to switch cpu to clock pll_x\n");
+		goto out;
+	}
+
+out:
+	clk_disable_unprepare(pll_x_clk);
+	return ret;
+}
+
 static int tegra_update_cpu_speed(unsigned long rate)
 {
 	int ret = 0;
@@ -101,7 +139,7 @@ static int tegra_update_cpu_speed(unsigned long rate)
 	       freqs.old, freqs.new);
 #endif
 
-	ret = clk_set_rate(cpu_clk, freqs.new * 1000);
+	ret = tegra_cpu_clk_set_rate(freqs.new * 1000);
 	if (ret) {
 		pr_err("cpu-tegra: Failed to set cpu frequency to %d kHz\n",
 			freqs.new);
@@ -183,6 +221,14 @@ static int tegra_cpu_init(struct cpufreq_policy *policy)
 	if (IS_ERR(cpu_clk))
 		return PTR_ERR(cpu_clk);
 
+	pll_x_clk = clk_get_sys(NULL, "pll_x");
+	if (IS_ERR(pll_x_clk))
+		return PTR_ERR(pll_x_clk);
+
+	pll_p_clk = clk_get_sys(NULL, "pll_p");
+	if (IS_ERR(pll_p_clk))
+		return PTR_ERR(pll_p_clk);
+
 	emc_clk = clk_get_sys("cpu", "emc");
 	if (IS_ERR(emc_clk)) {
 		clk_put(cpu_clk);
-- 
1.7.0.4
