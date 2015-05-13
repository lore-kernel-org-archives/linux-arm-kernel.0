From: mikko.perttunen@kapsi.fi (Mikko Perttunen)
Date: Wed, 13 May 2015 17:58:40 +0300
Subject: [PATCH v9 06/17] clk: tegra: Add DFLL DVCO reset control for Tegra124
In-Reply-To: <1431529131-16710-1-git-send-email-mikko.perttunen@kapsi.fi>
References: <1431529131-16710-1-git-send-email-mikko.perttunen@kapsi.fi>
Message-ID: <1431529131-16710-7-git-send-email-mikko.perttunen@kapsi.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Paul Walmsley <pwalmsley@nvidia.com>

The DVCO present in the DFLL IP block has a separate reset line,
exposed via the CAR IP block.  This reset line is asserted upon SoC
reset.  Unless something (such as the DFLL driver) deasserts this
line, the DVCO will not oscillate, although reads and writes to the
DFLL IP block will complete.

Thanks to Aleksandr Frid <afrid@nvidia.com> for identifying this and
saving hours of debugging time.

Signed-off-by: Paul Walmsley <pwalmsley@nvidia.com>
[ttynkkynen: ported to tegra124 from tegra114]
Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
[mikko.perttunen: ported to special reset callback]
Signed-off-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Acked-by: Michael Turquette <mturquette@linaro.org>
---
 drivers/clk/tegra/clk-tegra124.c         | 68 ++++++++++++++++++++++++++++++++
 include/dt-bindings/reset/tegra124-car.h | 11 ++++++
 2 files changed, 79 insertions(+)
 create mode 100644 include/dt-bindings/reset/tegra124-car.h

diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
index e8cca3e..42ba3d9 100644
--- a/drivers/clk/tegra/clk-tegra124.c
+++ b/drivers/clk/tegra/clk-tegra124.c
@@ -24,6 +24,7 @@
 #include <linux/export.h>
 #include <linux/clk/tegra.h>
 #include <dt-bindings/clock/tegra124-car.h>
+#include <dt-bindings/reset/tegra124-car.h>
 
 #include "clk.h"
 #include "clk-id.h"
@@ -39,6 +40,9 @@
 #define CLK_SOURCE_CSITE 0x1d4
 #define CLK_SOURCE_EMC 0x19c
 
+#define RST_DFLL_DVCO			0x2f4
+#define DVFS_DFLL_RESET_SHIFT		0
+
 #define PLLC_BASE 0x80
 #define PLLC_OUT 0x84
 #define PLLC_MISC2 0x88
@@ -1415,6 +1419,68 @@ static void __init tegra124_clock_apply_init_table(void)
 }
 
 /**
+ * tegra124_car_barrier - wait for pending writes to the CAR to complete
+ *
+ * Wait for any outstanding writes to the CAR MMIO space from this CPU
+ * to complete before continuing execution.  No return value.
+ */
+static void tegra124_car_barrier(void)
+{
+	readl_relaxed(clk_base + RST_DFLL_DVCO);
+}
+
+/**
+ * tegra124_clock_assert_dfll_dvco_reset - assert the DFLL's DVCO reset
+ *
+ * Assert the reset line of the DFLL's DVCO.  No return value.
+ */
+void tegra124_clock_assert_dfll_dvco_reset(void)
+{
+	u32 v;
+
+	v = readl_relaxed(clk_base + RST_DFLL_DVCO);
+	v |= (1 << DVFS_DFLL_RESET_SHIFT);
+	writel_relaxed(v, clk_base + RST_DFLL_DVCO);
+	tegra124_car_barrier();
+}
+
+/**
+ * tegra124_clock_deassert_dfll_dvco_reset - deassert the DFLL's DVCO reset
+ *
+ * Deassert the reset line of the DFLL's DVCO, allowing the DVCO to
+ * operate.  No return value.
+ */
+void tegra124_clock_deassert_dfll_dvco_reset(void)
+{
+	u32 v;
+
+	v = readl_relaxed(clk_base + RST_DFLL_DVCO);
+	v &= ~(1 << DVFS_DFLL_RESET_SHIFT);
+	writel_relaxed(v, clk_base + RST_DFLL_DVCO);
+	tegra124_car_barrier();
+}
+
+int tegra124_reset_assert(unsigned long id)
+{
+	if (id == TEGRA124_RST_DFLL_DVCO)
+		tegra124_clock_assert_dfll_dvco_reset();
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+int tegra124_reset_deassert(unsigned long id)
+{
+	if (id == TEGRA124_RST_DFLL_DVCO)
+		tegra124_clock_deassert_dfll_dvco_reset();
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
  * tegra132_clock_apply_init_table - initialize clocks on Tegra132 SoCs
  *
  * Program an initial clock rate and enable or disable clocks needed
@@ -1499,6 +1565,8 @@ static void __init tegra124_132_clock_init_post(struct device_node *np)
 {
 	tegra_super_clk_gen4_init(clk_base, pmc_base, tegra124_clks,
 				  &pll_x_params);
+	tegra_init_special_resets(tegra124_reset_assert,
+				  tegra124_reset_deassert);
 	tegra_add_of_provider(np);
 
 	clks[TEGRA124_CLK_EMC] = tegra_clk_register_emc(clk_base, np,
diff --git a/include/dt-bindings/reset/tegra124-car.h b/include/dt-bindings/reset/tegra124-car.h
new file mode 100644
index 0000000..1cc771f
--- /dev/null
+++ b/include/dt-bindings/reset/tegra124-car.h
@@ -0,0 +1,11 @@
+/*
+ * This header provides Tegra124-specific constants for binding
+ * nvidia,tegra124-car.
+ */
+
+#ifndef _DT_BINDINGS_RESET_TEGRA124_CAR_H
+#define _DT_BINDINGS_RESET_TEGRA124_CAR_H
+
+#define TEGRA124_RST_DFLL_DVCO      0x40000000
+
+#endif	/* _DT_BINDINGS_RESET_TEGRA124_CAR_H */
-- 
2.3.0
