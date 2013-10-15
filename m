From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 15 Oct 2013 17:52:53 +0300
Subject: [PATCH v3 08/19] clk: tegra: add common infra for DT clocks
In-Reply-To: <1381848794-11761-1-git-send-email-pdeschrijver@nvidia.com>
References: <1381848794-11761-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1381848794-11761-9-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a common infrastructure for sharing clock initialization between
SoCs.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/clk/tegra/clk.c |    9 +++++++++
 drivers/clk/tegra/clk.h |    7 +++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
index 1253217..c8c84ce 100644
--- a/drivers/clk/tegra/clk.c
+++ b/drivers/clk/tegra/clk.c
@@ -214,6 +214,15 @@ void __init tegra_add_of_provider(struct device_node *np)
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 }
 
+struct clk ** __init tegra_lookup_dt_id(int clk_id,
+					struct tegra_clk *tegra_clk)
+{
+	if (tegra_clk[clk_id].present)
+		return &clks[tegra_clk[clk_id].dt_id];
+	else
+		return NULL;
+}
+
 tegra_clk_apply_init_table_func tegra_clk_apply_init_table;
 
 void __init tegra_clocks_apply_init_table(void)
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index a73a678..be45705 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -568,6 +568,11 @@ struct tegra_clk_duplicate {
 		},				\
 	}
 
+struct tegra_clk {
+	int			dt_id;
+	bool			present;
+};
+
 void tegra_init_from_table(struct tegra_clk_init_table *tbl,
 		struct clk *clks[], int clk_max);
 
@@ -577,6 +582,8 @@ void tegra_init_dup_clks(struct tegra_clk_duplicate *dup_list,
 struct tegra_clk_periph_regs *get_reg_bank(int clkid);
 struct clk **tegra_clk_init(int num, int periph_banks);
 
+struct clk **tegra_lookup_dt_id(int clk_id, struct tegra_clk *tegra_clk);
+
 void tegra_add_of_provider(struct device_node *np);
 
 void tegra114_clock_tune_cpu_trimmers_high(void);
-- 
1.7.7.rc0.72.g4b5ea.dirty
