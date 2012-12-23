From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Sun, 23 Dec 2012 16:35:49 +0530
Subject: [PATCH 09/11] clk: tegra: add dt support
In-Reply-To: <1356260751-3667-1-git-send-email-pgaikwad@nvidia.com>
References: <1356260751-3667-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <1356260751-3667-10-git-send-email-pgaikwad@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support to initialize clock from DT.

Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
---
 drivers/clk/tegra/clk.c   |   23 +++++++++++++++++++++++
 drivers/clk/tegra/clk.h   |    2 ++
 include/linux/clk/tegra.h |    1 +
 3 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
index cf023a9..314d5bd 100644
--- a/drivers/clk/tegra/clk.c
+++ b/drivers/clk/tegra/clk.c
@@ -67,3 +67,26 @@ void __init tegra_init_from_table(struct tegra_clk_init_table *tbl,
 			}
 	}
 }
+
+static const struct of_device_id tegra_dt_clk_match[] = {
+	{ .compatible = "nvidia,tegra20-car", .data = tegra20_clock_init },
+	{ .compatible = "nvidia,tegra30-car", .data = tegra30_clock_init },
+	{ }
+};
+
+void __init tegra_dt_init_clk(void)
+{
+	struct device_node *np;
+	const struct of_device_id *match;
+	of_tegra_clk_init_func_t clk_init_func;
+
+	np = of_find_matching_node(NULL, tegra_dt_clk_match);
+	if (!np)
+		return;
+
+	match = of_match_node(tegra_dt_clk_match, np);
+
+	clk_init_func = match->data;
+
+	clk_init_func(np);
+}
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index f1ed1d0..ca1f0e4 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -20,6 +20,8 @@
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
 
+typedef void (*of_tegra_clk_init_func_t)(struct device_node *);
+
 /**
  * struct tegra_clk_sync_source - external clock source from codec
  *
diff --git a/include/linux/clk/tegra.h b/include/linux/clk/tegra.h
index c1ed98f..93a38b6 100644
--- a/include/linux/clk/tegra.h
+++ b/include/linux/clk/tegra.h
@@ -81,6 +81,7 @@ static inline void tegra_disable_cpu_clock(u32 cpu)
 	tegra_cpu_car_ops->disable_clock(cpu);
 }
 
+void tegra_dt_init_clk(void);
 void tegra20_cpu_car_ops_init(void);
 void tegra30_cpu_car_ops_init(void);
 
-- 
1.7.4.1
