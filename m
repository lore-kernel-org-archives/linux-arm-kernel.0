From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri,  4 Aug 2017 15:31:41 +0100
Subject: [PATCH v2 15/18] clk: add support for clocks provided by SCMI
In-Reply-To: <1501857104-11279-1-git-send-email-sudeep.holla@arm.com>
References: <1501857104-11279-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1501857104-11279-16-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some ARM based systems, a separate Cortex-M based System Control
Processor(SCP) provides the overall power, clock, reset and system
control. System Control and Management Interface(SCMI) Message Protocol
is defined for the communication between the Application Cores(AP)
and the SCP.

This patch adds support for the clocks provided by SCP using SCMI
protocol.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-clk at vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/clk/Kconfig    |  10 +++
 drivers/clk/Makefile   |   1 +
 drivers/clk/clk-scmi.c | 216 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 227 insertions(+)
 create mode 100644 drivers/clk/clk-scmi.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 68ca2d9fcd73..68b442b2c742 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -55,6 +55,16 @@ config COMMON_CLK_HI655X
 	  multi-function device has one fixed-rate oscillator, clocked
 	  at 32KHz.
 
+config COMMON_CLK_SCMI
+	tristate "Clock driver controlled via SCMI interface"
+	depends on ARM_SCMI_PROTOCOL || COMPILE_TEST
+	  ---help---
+	  This driver provides support for clocks that are controlled
+	  by firmware that implements the SCMI interface.
+
+	  This driver uses SCMI Message Protocol to interact with the
+	  firmware providing all the clock controls.
+
 config COMMON_CLK_SCPI
 	tristate "Clock driver controlled via SCPI interface"
 	depends on ARM_SCPI_PROTOCOL || COMPILE_TEST
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index cd376b3fb47a..74a8ae081923 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_CLK_QORIQ)			+= clk-qoriq.o
 obj-$(CONFIG_COMMON_CLK_RK808)		+= clk-rk808.o
 obj-$(CONFIG_COMMON_CLK_HI655X)		+= clk-hi655x.o
 obj-$(CONFIG_COMMON_CLK_S2MPS11)	+= clk-s2mps11.o
+obj-$(CONFIG_COMMON_CLK_SCMI)           += clk-scmi.o
 obj-$(CONFIG_COMMON_CLK_SCPI)           += clk-scpi.o
 obj-$(CONFIG_COMMON_CLK_SI5351)		+= clk-si5351.o
 obj-$(CONFIG_COMMON_CLK_SI514)		+= clk-si514.o
diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
new file mode 100644
index 000000000000..37f98a6439a0
--- /dev/null
+++ b/drivers/clk/clk-scmi.c
@@ -0,0 +1,216 @@
+/*
+ * System Control and Power Interface (SCMI) Protocol based clock driver
+ *
+ * Copyright (C) 2017 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/scmi_protocol.h>
+
+struct scmi_clk {
+	u32 id;
+	struct clk_hw hw;
+	const struct scmi_clock_info *info;
+	const struct scmi_handle *handle;
+};
+
+#define to_scmi_clk(clk) container_of(clk, struct scmi_clk, hw)
+
+static unsigned long scmi_clk_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	int ret;
+	u64 rate;
+	struct scmi_clk *clk = to_scmi_clk(hw);
+
+	ret = clk->handle->clk_ops->rate_get(clk->handle, clk->id, &rate);
+	if (ret)
+		return 0;
+	return rate;
+}
+
+static long scmi_clk_round_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long *parent_rate)
+{
+	u64 fmin, fmax, ftmp;
+	struct scmi_clk *clk = to_scmi_clk(hw);
+
+	/*
+	 * We can't figure out what rate it will be, so just return the
+	 * rate back to the caller. scmi_clk_recalc_rate() will be called
+	 * after the rate is set and we'll know what rate the clock is
+	 * running at then.
+	 */
+	if (clk->info->rate_discrete)
+		return rate;
+
+	fmin = clk->info->range.min_rate;
+	fmax = clk->info->range.max_rate;
+	for (ftmp = fmin; ftmp <= fmax; ftmp += clk->info->range.step_size) {
+		if (ftmp >= rate) {
+			if (ftmp <= fmax)
+				fmax = ftmp;
+			break;
+		} else if (ftmp >= fmin) {
+			fmin = ftmp;
+		}
+	}
+	return fmax != clk->info->range.max_rate ? fmax : fmin;
+}
+
+static int scmi_clk_set_rate(struct clk_hw *hw, unsigned long rate,
+			     unsigned long parent_rate)
+{
+	struct scmi_clk *clk = to_scmi_clk(hw);
+
+	return clk->handle->clk_ops->rate_set(clk->handle, clk->id, 0, rate);
+}
+
+static int scmi_clk_enable(struct clk_hw *hw)
+{
+	struct scmi_clk *clk = to_scmi_clk(hw);
+
+	return clk->handle->clk_ops->enable(clk->handle, clk->id);
+}
+
+static void scmi_clk_disable(struct clk_hw *hw)
+{
+	struct scmi_clk *clk = to_scmi_clk(hw);
+
+	clk->handle->clk_ops->disable(clk->handle, clk->id);
+}
+
+static const struct clk_ops scmi_clk_ops = {
+	.recalc_rate = scmi_clk_recalc_rate,
+	.round_rate = scmi_clk_round_rate,
+	.set_rate = scmi_clk_set_rate,
+	/*
+	 * We can't provide enable/disable callback as we can't perform the same
+	 * in atomic context. Since the clock framework provides standard API
+	 * clk_prepare_enable that helps cases using clk_enable in non-atomic
+	 * context, it should be fine providing prepare/unprepare.
+	 */
+	.prepare = scmi_clk_enable,
+	.unprepare = scmi_clk_disable,
+};
+
+static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk)
+{
+	int ret;
+	struct clk_init_data init;
+
+	init.flags = CLK_GET_RATE_NOCACHE;
+	init.num_parents = 0;
+	init.ops = &scmi_clk_ops;
+	init.name = sclk->info->name;
+	sclk->hw.init = &init;
+
+	ret = devm_clk_hw_register(dev, &sclk->hw);
+	if (!ret)
+		clk_hw_set_rate_range(&sclk->hw, sclk->info->range.min_rate,
+				      sclk->info->range.max_rate);
+	return ret;
+}
+
+static int scmi_clk_add(struct device *dev, struct device_node *np,
+			const struct scmi_handle *handle)
+{
+	int idx, count, err;
+	struct clk_hw **hws;
+	struct clk_hw_onecell_data *clk_data;
+
+	count = handle->clk_ops->count_get(handle);
+	if (count < 0) {
+		dev_err(dev, "%s: invalid clock output count\n", np->name);
+		return -EINVAL;
+	}
+
+	clk_data = devm_kzalloc(dev, sizeof(*clk_data) +
+				sizeof(*clk_data->hws) * count, GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
+
+	clk_data->num = count;
+	hws = clk_data->hws;
+
+	for (idx = 0; idx < count; idx++) {
+		struct scmi_clk *sclk;
+
+		sclk = devm_kzalloc(dev, sizeof(*sclk), GFP_KERNEL);
+		if (!sclk)
+			return -ENOMEM;
+
+		sclk->info = handle->clk_ops->info_get(handle, idx);
+		if (!sclk->info) {
+			dev_dbg(dev, "invalid clock info for idx %d\n", idx);
+			continue;
+		}
+
+		sclk->id = idx;
+		sclk->handle = handle;
+
+		err = scmi_clk_ops_init(dev, sclk);
+		if (err) {
+			dev_err(dev, "failed to register clock %d\n", idx);
+			devm_kfree(dev, sclk);
+			hws[idx] = NULL;
+		} else {
+			dev_dbg(dev, "Registered clock:%s\n", sclk->info->name);
+			hws[idx] = &sclk->hw;
+		}
+	}
+
+	return of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
+}
+
+static int scmi_clocks_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+
+	of_clk_del_provider(np);
+	return 0;
+}
+
+static int scmi_clocks_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	const struct scmi_handle *handle = devm_scmi_handle_get(dev);
+
+	if (IS_ERR_OR_NULL(handle) || !handle->clk_ops)
+		return -EPROBE_DEFER;
+
+	return scmi_clk_add(dev, np, handle);
+}
+
+static struct platform_driver scmi_clocks_driver = {
+	.driver	= {
+		.name = "scmi-clocks",
+	},
+	.probe = scmi_clocks_probe,
+	.remove = scmi_clocks_remove,
+};
+module_platform_driver(scmi_clocks_driver);
+
+MODULE_AUTHOR("Sudeep Holla <sudeep.holla@arm.com>");
+MODULE_DESCRIPTION("ARM SCMI clock driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
