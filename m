From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 16 Sep 2014 20:48:53 +0200
Subject: [PATCH/RFC v2 06/12] PM / Domains: Retrieve PM QoS device latencies
 from DT
In-Reply-To: <1410893339-6361-1-git-send-email-geert+renesas@glider.be>
References: <1410893339-6361-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1410893339-6361-7-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New
---
 drivers/base/power/domain.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index e1cbde985d4de606..7b166911be541229 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2133,6 +2133,8 @@ int genpd_dev_pm_attach(struct device *dev)
 	struct device_node *np = dev->of_node;
 	struct of_phandle_args pd_args;
 	struct generic_pm_domain *pd;
+	struct gpd_timing_data td;
+	u32 latency;
 	int ret;
 
 	if (!np)
@@ -2165,10 +2167,20 @@ int genpd_dev_pm_attach(struct device *dev)
 		return PTR_ERR(pd);
 	}
 
+	memset(&td, 0, sizeof(td));
+	if (!of_property_read_u32(np, "stop-latency", &latency))
+		td.stop_latency_ns = latency;
+	if (!of_property_read_u32(np, "start-latency", &latency))
+		td.start_latency_ns = latency;
+	if (!of_property_read_u32(np, "save-state-latency", &latency))
+		td.save_state_latency_ns = latency;
+	if (!of_property_read_u32(np, "restore-state-latency", &latency))
+		td.restore_state_latency_ns = latency;
+
 	dev_dbg(dev, "adding to PM domain %s\n", pd->name);
 
 	while (1) {
-		ret = pm_genpd_add_device(pd, dev);
+		ret = __pm_genpd_add_device(pd, dev, &td);
 		if (ret != -EAGAIN)
 			break;
 		cond_resched();
-- 
1.9.1
