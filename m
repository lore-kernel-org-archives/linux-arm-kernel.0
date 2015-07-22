From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Wed, 22 Jul 2015 12:41:00 +0530
Subject: [PATCH v6 04/13] clk: qcom: gdsc: Manage clocks with !CONFIG_PM
In-Reply-To: <1437549069-29655-1-git-send-email-rnayak@codeaurora.org>
References: <1437549069-29655-1-git-send-email-rnayak@codeaurora.org>
Message-ID: <1437549069-29655-5-git-send-email-rnayak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With CONFIG_PM disabled, turn the devices clocks on during
driver binding to the device, and turn them off when the
driver is unbound from the device.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/clk/qcom/gdsc.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 3125809..9ddd2f8 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -16,6 +16,7 @@
 #include <linux/jiffies.h>
 #include <linux/pm_clock.h>
 #include <linux/slab.h>
+#include <linux/platform_device.h>
 #include "gdsc.h"
 
 #define PWR_ON_MASK		BIT(31)
@@ -200,3 +201,61 @@ void gdsc_unregister(struct device *dev)
 {
 	of_genpd_del_provider(dev->of_node);
 }
+
+#ifndef CONFIG_PM
+static void enable_clock(struct device *dev, const char *con_id)
+{
+	struct clk *clk;
+
+	clk = clk_get(dev, con_id);
+	if (!IS_ERR(clk)) {
+		clk_prepare_enable(clk);
+		clk_put(clk);
+	}
+}
+
+static void disable_clock(struct device *dev, const char *con_id)
+{
+	struct clk *clk;
+
+	clk = clk_get(dev, con_id);
+	if (!IS_ERR(clk)) {
+		clk_disable_unprepare(clk);
+		clk_put(clk);
+	}
+}
+
+static int clk_notify(struct notifier_block *nb, unsigned long action,
+		      void *data)
+{
+	int sz;
+	struct device *dev = data;
+	char **con_id, *con_ids[] = { "core", "iface", NULL };
+
+	if (!of_find_property(dev->of_node, "power-domains", &sz))
+		return 0;
+
+	switch (action) {
+	case BUS_NOTIFY_BIND_DRIVER:
+		for (con_id = con_ids; *con_id; con_id++)
+			enable_clock(dev, *con_id);
+		break;
+	case BUS_NOTIFY_UNBOUND_DRIVER:
+		for (con_id = con_ids; *con_id; con_id++)
+			disable_clock(dev, *con_id);
+		break;
+	}
+	return 0;
+}
+
+struct notifier_block nb = {
+	.notifier_call = clk_notify,
+};
+
+int qcom_pm_runtime_init(void)
+{
+	bus_register_notifier(&platform_bus_type, &nb);
+	return 0;
+}
+core_initcall(qcom_pm_runtime_init);
+#endif
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
