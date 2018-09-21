From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 21 Sep 2018 12:08:56 +0200
Subject: [PATCH] firmware: tegra: bpmp: Implement suspend/resume support
Message-ID: <20180921100856.11396-1-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

When returning from a system sleep state, the BPMP driver needs to
reinitialize the IVC channels used to communicate with the BPMP to
restore proper functionality.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/firmware/tegra/bpmp.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
index 14a456afa379..41448ba78be9 100644
--- a/drivers/firmware/tegra/bpmp.c
+++ b/drivers/firmware/tegra/bpmp.c
@@ -18,6 +18,7 @@
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 #include <linux/semaphore.h>
 #include <linux/sched/clock.h>
 
@@ -843,6 +844,23 @@ static int tegra_bpmp_probe(struct platform_device *pdev)
 	return err;
 }
 
+static int tegra_bpmp_resume(struct device *dev)
+{
+	struct tegra_bpmp *bpmp = dev_get_drvdata(dev);
+	unsigned int i;
+
+	/* reset message channels */
+	tegra_bpmp_channel_reset(bpmp->tx_channel);
+	tegra_bpmp_channel_reset(bpmp->rx_channel);
+
+	for (i = 0; i < bpmp->threaded.count; i++)
+		tegra_bpmp_channel_reset(&bpmp->threaded_channels[i]);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(tegra_bpmp_pm_ops, NULL, tegra_bpmp_resume);
+
 static const struct tegra_bpmp_soc tegra186_soc = {
 	.channels = {
 		.cpu_tx = {
@@ -871,6 +889,7 @@ static struct platform_driver tegra_bpmp_driver = {
 	.driver = {
 		.name = "tegra-bpmp",
 		.of_match_table = tegra_bpmp_match,
+		.pm = &tegra_bpmp_pm_ops,
 	},
 	.probe = tegra_bpmp_probe,
 };
-- 
2.19.0
