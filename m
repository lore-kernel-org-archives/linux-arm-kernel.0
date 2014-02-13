From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 13 Feb 2014 15:39:07 +0100
Subject: [PATCH v2 4/7] ARM: imx6: gpc: Add observed worst case latencies
In-Reply-To: <1392302350-11729-1-git-send-email-p.zabel@pengutronix.de>
References: <1392302350-11729-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1392302350-11729-5-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This avoids the "... latency exceeded, new value ..." warnings
emitted by the power domain framework code whenever the PU domain
is enabled or disabled.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/mach-imx/gpc.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index 607a6ea..cbac099 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -225,6 +225,8 @@ static struct generic_pm_domain imx6q_pu_domain = {
 	.name = "PU",
 	.power_off = imx6q_pm_pu_power_off,
 	.power_on = imx6q_pm_pu_power_on,
+	.power_off_latency_ns = 25000,
+	.power_on_latency_ns = 2000000,
 };
 
 int imx6q_pm_clk_add(struct device *dev)
@@ -289,6 +291,13 @@ int imx6q_pm_clk_remove(struct device *dev)
 	return 0;
 }
 
+static struct gpd_timing_data pu_timing_data = {
+	.stop_latency_ns = 2000,
+	.start_latency_ns = 2000,
+	.save_state_latency_ns = 5000,
+	.restore_state_latency_ns = 20000000, /* VPU firmware reload */
+};
+
 static int imx6q_pm_notifier_call(struct notifier_block *nb,
 				  unsigned long event, void *data)
 {
@@ -303,7 +312,7 @@ static int imx6q_pm_notifier_call(struct notifier_block *nb,
 		if (!np || np != imx6q_pu_domain.of_node)
 			return NOTIFY_DONE;
 
-		ret = pm_genpd_of_add_device(np, dev);
+		ret = __pm_genpd_of_add_device(np, dev, &pu_timing_data);
 		if (ret)
 			dev_err(dev, "failed to add to power domain: %d\n",
 				ret);
-- 
1.8.5.3
