From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 31 Jul 2015 11:56:30 +0530
Subject: [PATCH V3 10/16] PM / OPP: Add support for opp-suspend
In-Reply-To: <20150731062406.GS3159@codeaurora.org>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
 <3d1b8d7de9f2ad34d979540e367ed691bcb7bb77.1438166099.git.viresh.kumar@linaro.org>
 <20150731062406.GS3159@codeaurora.org>
Message-ID: <20150731062630.GR17794@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30-07-15, 23:24, Stephen Boyd wrote:
> On 07/29, Viresh Kumar wrote:
> > With "operating-points-v2" bindings, its possible to specify the OPP to
> 
> s/its/it's/ ?
> 
> > which the device must be switched, before suspending.
> > 
> > This patch adds support for getting that information.
> > 
> > Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> 
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

---------------------8<-------------------

Message-Id: <5e0cf40cc78bfa327cbbccae016d03a1dfbd1a84.1438323941.git.viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Sat, 13 Jun 2015 15:10:21 +0530
Subject: [PATCH] PM / OPP: Add support for opp-suspend

With "operating-points-v2" bindings, it's possible to specify the OPP to
which the device must be switched, before suspending.

This patch adds support for getting that information.

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
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
 
