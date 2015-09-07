From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 07 Sep 2015 17:41:40 +0200
Subject: [PATCH v4 3/4] cpufreq-dt: add suspend frequency support
In-Reply-To: <1441640501-13613-1-git-send-email-b.zolnierkie@samsung.com>
References: <1441640501-13613-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1441640501-13613-4-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add suspend frequency support and if needed set it to
the frequency obtained from the suspend opp (can be defined
using opp-v2 bindings and is optional).

Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/cpufreq/cpufreq-dt.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index c3583cd..e08ae40 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -196,6 +196,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	struct device *cpu_dev;
 	struct regulator *cpu_reg;
 	struct clk *cpu_clk;
+	struct dev_pm_opp *suspend_opp;
 	unsigned long min_uV = ~0, max_uV = 0;
 	unsigned int transition_latency;
 	bool need_update = false;
@@ -329,6 +330,13 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	policy->driver_data = priv;
 
 	policy->clk = cpu_clk;
+
+	rcu_read_lock();
+	suspend_opp = dev_pm_opp_get_suspend_opp(cpu_dev);
+	if (suspend_opp)
+		policy->suspend_freq = dev_pm_opp_get_freq(suspend_opp) / 1000;
+	rcu_read_unlock();
+
 	ret = cpufreq_table_validate_and_show(policy, freq_table);
 	if (ret) {
 		dev_err(cpu_dev, "%s: invalid frequency table: %d\n", __func__,
@@ -419,6 +427,9 @@ static struct cpufreq_driver dt_cpufreq_driver = {
 	.ready = cpufreq_ready,
 	.name = "cpufreq-dt",
 	.attr = cpufreq_dt_attr,
+#ifdef CONFIG_PM
+	.suspend = cpufreq_generic_suspend,
+#endif
 };
 
 static int dt_cpufreq_probe(struct platform_device *pdev)
-- 
1.9.1
