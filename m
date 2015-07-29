From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 29 Jul 2015 16:23:05 +0530
Subject: [PATCH V3 10/16] PM / OPP: Add support for opp-suspend
In-Reply-To: <cover.1438166099.git.viresh.kumar@linaro.org>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
Message-ID: <3d1b8d7de9f2ad34d979540e367ed691bcb7bb77.1438166099.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With "operating-points-v2" bindings, its possible to specify the OPP to
which the device must be switched, before suspending.

This patch adds support for getting that information.

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 5d699e3ec136..0ebcea49145a 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -133,6 +133,7 @@ struct device_opp {
 	struct device_node *np;
 	unsigned long clock_latency_ns_max;
 	bool shared_opp;
+	struct dev_pm_opp *suspend_opp;
 };
 
 /*
@@ -923,6 +924,16 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np)
 	if (ret)
 		goto free_opp;
 
+	/* OPP to select on device suspend */
+	if (of_property_read_bool(np, "opp-suspend")) {
+		if (dev_opp->suspend_opp)
+			dev_warn(dev, "%s: Multiple suspend OPPs found (%lu %lu)\n",
+				 __func__, dev_opp->suspend_opp->rate,
+				 new_opp->rate);
+		else
+			dev_opp->suspend_opp = new_opp;
+	}
+
 	if (new_opp->clock_latency_ns > dev_opp->clock_latency_ns_max)
 		dev_opp->clock_latency_ns_max = new_opp->clock_latency_ns;
 
-- 
2.4.0
