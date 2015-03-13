From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 13 Mar 2015 16:23:20 +0000
Subject: [PATCH 01/10] pm: domains: quieten down generic pm domains
In-Reply-To: <20150312183020.GU8656@n2100.arm.linux.org.uk>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
Message-ID: <E1YWSMq-0006Ft-9z@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PM domains are rather noisy; scheduling behaviour can cause callbacks
to take longer, which causes them to spit out a warning-level message
each time a callback takes a little longer than the previous time.
There really isn't a need for this, except when debugging.

Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/base/power/domain.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 0d8780c04a5e..b3fbc21da2dc 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -173,8 +173,8 @@ static int genpd_power_on(struct generic_pm_domain *genpd)
 	genpd->power_on_latency_ns = elapsed_ns;
 	genpd->max_off_time_changed = true;
 	genpd_recalc_cpu_exit_latency(genpd);
-	pr_warn("%s: Power-%s latency exceeded, new value %lld ns\n",
-		genpd->name, "on", elapsed_ns);
+	pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
+		 genpd->name, "on", elapsed_ns);
 
 	return ret;
 }
@@ -199,8 +199,8 @@ static int genpd_power_off(struct generic_pm_domain *genpd)
 
 	genpd->power_off_latency_ns = elapsed_ns;
 	genpd->max_off_time_changed = true;
-	pr_warn("%s: Power-%s latency exceeded, new value %lld ns\n",
-		genpd->name, "off", elapsed_ns);
+	pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
+		 genpd->name, "off", elapsed_ns);
 
 	return ret;
 }
-- 
1.8.3.1
