From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 15 Nov 2013 13:54:02 -0700
Subject: [PATCH 07/31] clk: tegra: implement a reset driver
In-Reply-To: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1384548866-13141-8-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

The Tegra CAR module implements both a clock and reset controller. So
far, the driver exposes the clock feature via the common clock API and
the reset feature using a custom API. This patch adds an implementation
of the common reset framework API (include/linux/reset*.h). The legacy
reset implementation will be removed once all drivers have been
converted.

Cc: treding at nvidia.com
Cc: pdeschrijver at nvidia.com
Cc: linux-tegra at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This patch is part of a series with strong internal depdendencies. I'm
looking for an ack so that I can take the entire series through the Tegra
and arm-soc trees. The series will be part of a stable branch that can be
merged into other subsystems if needed to avoid/resolve dependencies.
---
 drivers/clk/tegra/clk-tegra114.c |  3 ++-
 drivers/clk/tegra/clk-tegra124.c |  2 +-
 drivers/clk/tegra/clk-tegra20.c  |  3 ++-
 drivers/clk/tegra/clk-tegra30.c  |  3 ++-
 drivers/clk/tegra/clk.c          | 55 +++++++++++++++++++++++++++++++++++++++-
 drivers/clk/tegra/clk.h          |  2 +-
 6 files changed, 62 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index 9036a22ee5aa..207a15ac062f 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -1464,7 +1464,8 @@ static void __init tegra114_clock_init(struct device_node *np)
 		return;
 	}
 
-	clks = tegra_clk_init(TEGRA114_CLK_CLK_MAX, TEGRA114_CLK_PERIPH_BANKS);
+	clks = tegra_clk_init(clk_base, TEGRA114_CLK_CLK_MAX,
+				TEGRA114_CLK_PERIPH_BANKS);
 	if (!clks)
 		return;
 
diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
index 266e80b51d38..9adee736d7fa 100644
--- a/drivers/clk/tegra/clk-tegra124.c
+++ b/drivers/clk/tegra/clk-tegra124.c
@@ -1404,7 +1404,7 @@ static void __init tegra124_clock_init(struct device_node *np)
 		return;
 	}
 
-	clks = tegra_clk_init(TEGRA124_CLK_CLK_MAX, 6);
+	clks = tegra_clk_init(clk_base, TEGRA124_CLK_CLK_MAX, 6);
 	if (!clks)
 		return;
 
diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index 58faac5f509e..eeffff6c6778 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -1114,7 +1114,8 @@ static void __init tegra20_clock_init(struct device_node *np)
 		BUG();
 	}
 
-	clks = tegra_clk_init(TEGRA20_CLK_CLK_MAX, TEGRA20_CLK_PERIPH_BANKS);
+	clks = tegra_clk_init(clk_base, TEGRA20_CLK_CLK_MAX,
+				TEGRA20_CLK_PERIPH_BANKS);
 	if (!clks)
 		return;
 
diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index 51c093c96657..e9b6a305be92 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -1436,7 +1436,8 @@ static void __init tegra30_clock_init(struct device_node *np)
 		BUG();
 	}
 
-	clks = tegra_clk_init(TEGRA30_CLK_CLK_MAX, TEGRA30_CLK_PERIPH_BANKS);
+	clks = tegra_clk_init(clk_base, TEGRA30_CLK_CLK_MAX,
+				TEGRA30_CLK_PERIPH_BANKS);
 	if (!clks)
 		return;
 
diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
index a12a5f5107ec..f20199a534bd 100644
--- a/drivers/clk/tegra/clk.c
+++ b/drivers/clk/tegra/clk.c
@@ -18,6 +18,8 @@
 #include <linux/clk-provider.h>
 #include <linux/of.h>
 #include <linux/clk/tegra.h>
+#include <linux/reset-controller.h>
+#include <linux/tegra-soc.h>
 
 #include "clk.h"
 
@@ -60,6 +62,11 @@
 #define RST_DEVICES_SET_X		0x290
 #define RST_DEVICES_CLR_X		0x294
 
+static int tegra_clk_rst_assert(struct reset_controller_dev *rcdev,
+		unsigned long id);
+static int tegra_clk_rst_deassert(struct reset_controller_dev *rcdev,
+		unsigned long id);
+
 /* Global data of Tegra CPU CAR ops */
 static struct tegra_cpu_car_ops dummy_car_ops;
 struct tegra_cpu_car_ops *tegra_cpu_car_ops = &dummy_car_ops;
@@ -70,6 +77,17 @@ static struct clk **clks;
 static int clk_num;
 static struct clk_onecell_data clk_data;
 
+static struct reset_control_ops rst_ops = {
+	.assert = tegra_clk_rst_assert,
+	.deassert = tegra_clk_rst_deassert,
+};
+
+static struct reset_controller_dev rst_ctlr = {
+	.ops = &rst_ops,
+	.owner = THIS_MODULE,
+	.of_reset_n_cells = 1,
+};
+
 static struct tegra_clk_periph_regs periph_regs[] = {
 	[0] = {
 		.enb_reg = CLK_OUT_ENB_L,
@@ -121,6 +139,35 @@ static struct tegra_clk_periph_regs periph_regs[] = {
 	},
 };
 
+static void __iomem *clk_base;
+
+static int tegra_clk_rst_assert(struct reset_controller_dev *rcdev,
+		unsigned long id)
+{
+	/*
+	 * If peripheral is on the APB bus then we must read the APB bus to
+	 * flush the write operation in apb bus. This will avoid peripheral
+	 * access after disabling clock. Since the reset driver has no
+	 * knowledge of which reset IDs represent which devices, simply do
+	 * this all the time.
+	 */
+	tegra_read_chipid();
+
+	writel_relaxed(BIT(id % 32),
+			clk_base + periph_regs[id / 32].rst_set_reg);
+
+	return 0;
+}
+
+static int tegra_clk_rst_deassert(struct reset_controller_dev *rcdev,
+		unsigned long id)
+{
+	writel_relaxed(BIT(id % 32),
+			clk_base + periph_regs[id / 32].rst_clr_reg);
+
+	return 0;
+}
+
 struct tegra_clk_periph_regs *get_reg_bank(int clkid)
 {
 	int reg_bank = clkid / 32;
@@ -133,8 +180,10 @@ struct tegra_clk_periph_regs *get_reg_bank(int clkid)
 	}
 }
 
-struct clk ** __init tegra_clk_init(int num, int banks)
+struct clk ** __init tegra_clk_init(void __iomem *regs, int num, int banks)
 {
+	clk_base = regs;
+
 	if (WARN_ON(banks > ARRAY_SIZE(periph_regs)))
 		return NULL;
 
@@ -220,6 +269,10 @@ void __init tegra_add_of_provider(struct device_node *np)
 	clk_data.clks = clks;
 	clk_data.clk_num = clk_num;
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+
+	rst_ctlr.of_node = np;
+	rst_ctlr.nr_resets = clk_num * 32;
+	reset_controller_register(&rst_ctlr);
 }
 
 void __init tegra_register_devclks(struct tegra_devclk *dev_clks, int num)
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index 7f110acfe2a1..39f24959daf7 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -594,7 +594,7 @@ void tegra_init_dup_clks(struct tegra_clk_duplicate *dup_list,
 		struct clk *clks[], int clk_max);
 
 struct tegra_clk_periph_regs *get_reg_bank(int clkid);
-struct clk **tegra_clk_init(int num, int periph_banks);
+struct clk **tegra_clk_init(void __iomem *clk_base, int num, int periph_banks);
 
 struct clk **tegra_lookup_dt_id(int clk_id, struct tegra_clk *tegra_clk);
 
-- 
1.8.1.5
