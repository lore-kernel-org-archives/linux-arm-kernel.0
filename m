From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 13 Jul 2015 13:39:47 +0100
Subject: [PATCH V3 09/19] soc: tegra: pmc: Prepare for migrating to generic PM
 domains
In-Reply-To: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <1436791197-32358-10-git-send-email-jonathanh@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When turning on and off power-domains it is necessary to enable specific
clocks in order to de-assert/assert various reset signals to place the
logic into a good state.

Currently, clocks required for turning on a power-domain are left enabled
by the PMC driver because these clocks are also needed by the IP blocks
to operated.

When migrating to the generic PM domain infrastructure, control of the
powergates is abstracted from the drivers and therefore, it is desirable
to disabled the clocks after turning on the power-domain and let the
drivers enable the clocks it needs later. However, because this behaviour
is different it is necessary to add a new API that drivers can use
whether generic PM domains are used or not so that the behaviour is the
same. Hence, add a new API that disables the clocks after turning on the
power domain.

Similarly, for disabling a power-domain add a new API to abstract the
management of the clocks so that drivers can be migrated to generic PM
domains.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 23 +++++++++++++++++++++++
 include/soc/tegra/pmc.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 180d434deec5..934653785bb7 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -331,6 +331,29 @@ err_power:
 }
 EXPORT_SYMBOL(tegra_powergate_sequence_power_up);
 
+int tegra_powergate_power_off_legacy(int id, struct clk *clk,
+				     struct reset_control *rst)
+{
+	int ret;
+
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		return ret;
+
+	usleep_range(10, 20);
+
+	reset_control_assert(rst);
+
+	usleep_range(10, 20);
+
+	clk_disable_unprepare(clk);
+
+	usleep_range(10, 20);
+
+	return tegra_powergate_power_off(id);
+}
+EXPORT_SYMBOL(tegra_powergate_power_off_legacy);
+
 #ifdef CONFIG_SMP
 /**
  * tegra_get_cpu_powergate_id() - convert from CPU ID to partition ID
diff --git a/include/soc/tegra/pmc.h b/include/soc/tegra/pmc.h
index 3a014c121399..4ca91d39304d 100644
--- a/include/soc/tegra/pmc.h
+++ b/include/soc/tegra/pmc.h
@@ -19,6 +19,8 @@
 #ifndef __SOC_TEGRA_PMC_H__
 #define __SOC_TEGRA_PMC_H__
 
+#include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/reboot.h>
 
 #include <soc/tegra/pm.h>
@@ -117,6 +119,22 @@ int tegra_powergate_remove_clamping(int id);
 int tegra_powergate_sequence_power_up(int id, struct clk *clk,
 				      struct reset_control *rst);
 
+static inline int tegra_powergate_power_on_legacy(int id, struct clk *clk,
+						  struct reset_control *rst)
+{
+	int err = tegra_powergate_sequence_power_up(id, clk, rst);
+
+	if (!err) {
+		usleep_range(10, 20);
+		clk_disable_unprepare(clk);
+	}
+
+	return err;
+}
+
+int tegra_powergate_power_off_legacy(int id, struct clk *clk,
+				     struct reset_control *rst);
+
 int tegra_io_rail_power_on(int id);
 int tegra_io_rail_power_off(int id);
 #else
@@ -155,6 +173,18 @@ static inline int tegra_io_rail_power_off(int id)
 {
 	return -ENOSYS;
 }
+
+static inline int tegra_powergate_power_on_legacy(int id, struct clk *clk,
+						  struct reset_control *rst)
+{
+	return -ENOTSUPP;
+}
+
+static inline int tegra_powergate_power_off_legacy(int id, struct clk *clk,
+						   struct reset_control *rst)
+{
+	return -ENOTSUPP;
+}
 #endif /* CONFIG_ARCH_TEGRA */
 
 #endif /* __SOC_TEGRA_PMC_H__ */
-- 
2.1.4
