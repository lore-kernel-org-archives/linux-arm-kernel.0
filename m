From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 14 Feb 2016 10:52:28 +0530
Subject: [next] Odroid XU3 boot fail after cpufreq: dt: Use
 dev_pm_opp_set_rate() to switch frequency
In-Reply-To: <56C008F2.3080807@gmail.com>
References: <56C008F2.3080807@gmail.com>
Message-ID: <20160214052228.GA18226@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14-02-16, 13:56, Krzysztof Kozlowski wrote:
> Hi all,
> 
> Recently Odroid XU3 failed to boot on linux-next
> on multi_v7 defconfig. exynos defconfig boots fine.
> 
> Probably the "cpufreq: dt: Use dev_pm_opp_set_rate() to
> switch frequency" is important here:
> commit 78c3ba5df96c875b1668e1cd3ee0a69e62454f32
> Author: Viresh Kumar <viresh.kumar@linaro.org>
> Date:   Tue Feb 9 10:30:46 2016 +0530
> 
>     cpufreq: dt: Use dev_pm_opp_set_rate() to switch frequency
>     
>     OPP core supports frequency/voltage changes based on the target
>     frequency now, use that instead of open coding the same in cpufreq-dt
>     driver.
>     
>     Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>     Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Can you please try the below untested patch please ?

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index d7cd4e265766..a97b333036c9 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -1156,9 +1156,15 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
 		return -EINVAL;
 	}
 
-	opp->u_volt = microvolt[0];
-	opp->u_volt_min = microvolt[1];
-	opp->u_volt_max = microvolt[2];
+	if (count == 1) {
+		opp->u_volt = microvolt[0];
+		opp->u_volt_min = opp->u_volt;
+		opp->u_volt_max = opp->u_volt;
+	} else {
+		opp->u_volt = microvolt[0];
+		opp->u_volt_min = microvolt[1];
+		opp->u_volt_max = microvolt[2];
+	}
 
 	/* Search for "opp-microamp-<name>" */
 	prop = NULL;

-- 
viresh
