From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue,  1 Aug 2017 14:53:49 +0530
Subject: [PATCH V3 8/8] drivers: boot_constraint: Add Qualcomm display
 controller constraints
In-Reply-To: <cover.1501578037.git.viresh.kumar@linaro.org>
References: <cover.1501578037.git.viresh.kumar@linaro.org>
Message-ID: <f1d035bb3202dd6135e6cde9e4a142ea32a6a79c.1501578037.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajendra Nayak <rnayak@codeaurora.org>

NOT TO BE MERGED

This sets boot constraints for the display controller used on Qualcomm
dragonboard 410c.

Not-signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Not-signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/boot_constraints/Makefile       |   2 +-
 drivers/base/boot_constraints/qcom-display.c | 107 +++++++++++++++++++++++++++
 2 files changed, 108 insertions(+), 1 deletion(-)
 create mode 100644 drivers/base/boot_constraints/qcom-display.c

diff --git a/drivers/base/boot_constraints/Makefile b/drivers/base/boot_constraints/Makefile
index a765094623a3..b0bdf67ebbbf 100644
--- a/drivers/base/boot_constraints/Makefile
+++ b/drivers/base/boot_constraints/Makefile
@@ -1,3 +1,3 @@
 # Makefile for device boot constraints
 
-obj-y := clk.o deferrable_dev.o core.o pm.o supply.o
+obj-y := clk.o deferrable_dev.o core.o pm.o supply.o qcom-display.o
diff --git a/drivers/base/boot_constraints/qcom-display.c b/drivers/base/boot_constraints/qcom-display.c
new file mode 100644
index 000000000000..29f930ac692b
--- /dev/null
+++ b/drivers/base/boot_constraints/qcom-display.c
@@ -0,0 +1,107 @@
+/*
+ * Sets up constraints on behalf of the bootloader, which uses display
+ * controller to display a flash screen during system boot.
+ */
+
+#include <linux/boot_constraint.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+
+struct dev_boot_constraint_clk_info iface_clk_info = {
+	.name = "iface_clk",
+};
+
+struct dev_boot_constraint_clk_info bus_clk_info = {
+	.name = "bus_clk",
+};
+
+struct dev_boot_constraint_clk_info core_clk_info = {
+	.name = "core_clk",
+};
+
+struct dev_boot_constraint_clk_info vsync_clk_info = {
+	.name = "vsync_clk",
+};
+
+struct dev_boot_constraint_clk_info esc0_clk_info = {
+	.name = "core_clk",
+};
+
+struct dev_boot_constraint_clk_info byte_clk_info = {
+	.name = "byte_clk",
+};
+
+struct dev_boot_constraint_clk_info pixel_clk_info = {
+	.name = "pixel_clk",
+};
+
+struct dev_boot_constraint_supply_info vdda_info = {
+	.name = "vdda"
+};
+
+struct dev_boot_constraint_supply_info vddio_info = {
+	.name = "vddio"
+};
+
+struct dev_boot_constraint constraints_mdss[] = {
+	{
+		.type = DEV_BOOT_CONSTRAINT_PM,
+		.data = NULL,
+	},
+};
+
+struct dev_boot_constraint constraints_mdp[] = {
+	{
+		.type = DEV_BOOT_CONSTRAINT_CLK,
+		.data = &iface_clk_info,
+	}, {
+		.type = DEV_BOOT_CONSTRAINT_CLK,
+		.data = &bus_clk_info,
+	}, {
+		.type = DEV_BOOT_CONSTRAINT_CLK,
+		.data = &core_clk_info,
+	}, {
+		.type = DEV_BOOT_CONSTRAINT_CLK,
+		.data = &vsync_clk_info,
+	},
+};
+
+struct dev_boot_constraint constraints_dsi[] = {
+	{
+		.type = DEV_BOOT_CONSTRAINT_CLK,
+		.data = &esc0_clk_info,
+	}, {
+		.type = DEV_BOOT_CONSTRAINT_CLK,
+		.data = &byte_clk_info,
+	}, {
+		.type = DEV_BOOT_CONSTRAINT_CLK,
+		.data = &pixel_clk_info,
+	}, {
+		.type = DEV_BOOT_CONSTRAINT_SUPPLY,
+		.data = &vdda_info,
+
+	}, {
+		.type = DEV_BOOT_CONSTRAINT_SUPPLY,
+		.data = &vddio_info,
+	},
+};
+
+static int __init qcom_constraints_init(void)
+{
+	int ret;
+
+	ret = dev_boot_constraint_add_of_deferrable("qcom,mdss",
+				constraints_mdss, ARRAY_SIZE(constraints_mdss));
+	if (ret)
+		return ret;
+
+	ret = dev_boot_constraint_add_of_deferrable("qcom,mdp5",
+				constraints_mdp, ARRAY_SIZE(constraints_mdp));
+	if (ret)
+		return ret;
+
+	ret = dev_boot_constraint_add_of_deferrable("qcom,mdss-dsi-ctrl",
+				constraints_dsi, ARRAY_SIZE(constraints_dsi));
+	return ret;
+}
+subsys_initcall(qcom_constraints_init);
-- 
2.13.0.71.gd7076ec9c9cb
