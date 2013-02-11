From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 11 Feb 2013 13:04:55 +0200
Subject: [PATCH v6 05/10] clk: tegra: Add flags to tegra_clk_periph()
In-Reply-To: <1360580700-10245-1-git-send-email-pdeschrijver@nvidia.com>
References: <1360580700-10245-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1360580700-10245-6-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We will need some tegra peripheral clocks with the CLK_IGNORE_UNUSED flag,
most notably mselect, which is a bridge between AXI and most peripherals.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/clk/tegra/clk-periph.c  |   11 ++++++-----
 drivers/clk/tegra/clk-tegra20.c |    2 +-
 drivers/clk/tegra/clk-tegra30.c |    2 +-
 drivers/clk/tegra/clk.h         |    9 ++++++---
 4 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/tegra/clk-periph.c b/drivers/clk/tegra/clk-periph.c
index 788486e..067abb3 100644
--- a/drivers/clk/tegra/clk-periph.c
+++ b/drivers/clk/tegra/clk-periph.c
@@ -170,14 +170,15 @@ const struct clk_ops tegra_clk_periph_nodiv_ops = {
 static struct clk *_tegra_clk_register_periph(const char *name,
 			const char **parent_names, int num_parents,
 			struct tegra_clk_periph *periph,
-			void __iomem *clk_base, u32 offset, bool div)
+			void __iomem *clk_base, u32 offset, bool div,
+			unsigned long flags)
 {
 	struct clk *clk;
 	struct clk_init_data init;
 
 	init.name = name;
 	init.ops = div ? &tegra_clk_periph_ops : &tegra_clk_periph_nodiv_ops;
-	init.flags = div ? 0 : CLK_SET_RATE_PARENT;
+	init.flags = flags;
 	init.parent_names = parent_names;
 	init.num_parents = num_parents;
 
@@ -202,10 +203,10 @@ static struct clk *_tegra_clk_register_periph(const char *name,
 struct clk *tegra_clk_register_periph(const char *name,
 		const char **parent_names, int num_parents,
 		struct tegra_clk_periph *periph, void __iomem *clk_base,
-		u32 offset)
+		u32 offset, unsigned long flags)
 {
 	return _tegra_clk_register_periph(name, parent_names, num_parents,
-			periph, clk_base, offset, true);
+			periph, clk_base, offset, true, flags);
 }
 
 struct clk *tegra_clk_register_periph_nodiv(const char *name,
@@ -214,5 +215,5 @@ struct clk *tegra_clk_register_periph_nodiv(const char *name,
 		u32 offset)
 {
 	return _tegra_clk_register_periph(name, parent_names, num_parents,
-			periph, clk_base, offset, false);
+			periph, clk_base, offset, false, CLK_SET_RATE_PARENT);
 }
diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index 54c6777..870349e 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -1048,7 +1048,7 @@ static void __init tegra20_periph_clk_init(void)
 		data = &tegra_periph_clk_list[i];
 		clk = tegra_clk_register_periph(data->name, data->parent_names,
 				data->num_parents, &data->periph,
-				clk_base, data->offset);
+				clk_base, data->offset, data->flags);
 		clk_register_clkdev(clk, data->con_id, data->dev_id);
 		clks[data->clk_id] = clk;
 	}
diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index 078f9b8..126747b 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -1665,7 +1665,7 @@ static void __init tegra30_periph_clk_init(void)
 		data = &tegra_periph_clk_list[i];
 		clk = tegra_clk_register_periph(data->name, data->parent_names,
 				data->num_parents, &data->periph,
-				clk_base, data->offset);
+				clk_base, data->offset, data->flags);
 		clk_register_clkdev(clk, data->con_id, data->dev_id);
 		clks[data->clk_id] = clk;
 	}
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index ea3cce2..4c4bf9a 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -415,7 +415,7 @@ extern const struct clk_ops tegra_clk_periph_ops;
 struct clk *tegra_clk_register_periph(const char *name,
 		const char **parent_names, int num_parents,
 		struct tegra_clk_periph *periph, void __iomem *clk_base,
-		u32 offset);
+		u32 offset, unsigned long flags);
 struct clk *tegra_clk_register_periph_nodiv(const char *name,
 		const char **parent_names, int num_parents,
 		struct tegra_clk_periph *periph, void __iomem *clk_base,
@@ -458,12 +458,14 @@ struct tegra_periph_init_data {
 	u32 offset;
 	const char *con_id;
 	const char *dev_id;
+	unsigned long flags;
 };
 
 #define TEGRA_INIT_DATA_TABLE(_name, _con_id, _dev_id, _parent_names, _offset,\
 			_mux_shift, _mux_mask, _mux_flags, _div_shift,	\
 			_div_width, _div_frac_width, _div_flags, _regs,	\
-			_clk_num, _enb_refcnt, _gate_flags, _clk_id, _table) \
+			_clk_num, _enb_refcnt, _gate_flags, _clk_id, _table,\
+			_flags) \
 	{								\
 		.name = _name,						\
 		.clk_id = _clk_id,					\
@@ -478,6 +480,7 @@ struct tegra_periph_init_data {
 		.offset = _offset,					\
 		.con_id = _con_id,					\
 		.dev_id = _dev_id,					\
+		.flags = _flags						\
 	}
 
 #define TEGRA_INIT_DATA(_name, _con_id, _dev_id, _parent_names, _offset,\
@@ -488,7 +491,7 @@ struct tegra_periph_init_data {
 			_mux_shift, BIT(_mux_width) - 1, _mux_flags,	\
 			_div_shift, _div_width, _div_frac_width, _div_flags, \
 			_regs, _clk_num, _enb_refcnt, _gate_flags, _clk_id,\
-			NULL)
+			NULL, 0)
 
 /**
  * struct clk_super_mux - super clock
-- 
1.7.1
