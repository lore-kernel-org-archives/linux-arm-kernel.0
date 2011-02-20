From: swarren@nvidia.com (Stephen Warren)
Date: Sat, 19 Feb 2011 20:38:56 -0700
Subject: [PATCH 3/4] ARM: tegra: pinmux: Expose set_func, add get_*
In-Reply-To: <1298173137-9242-1-git-send-email-swarren@nvidia.com>
References: <1298173137-9242-1-git-send-email-swarren@nvidia.com>
Message-ID: <1298173137-9242-4-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Expose set_func for consistency with other set_* functions, plus other
drivers can use this basic API more easily than
tegra_pinmux_config_*_table.

Implement get_* to allow other drivers (e.g. clock) to initialize their
state (e.g. cdev[12] parenting/enable) based on pinmux state.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/include/mach/pinmux.h |    9 ++++
 arch/arm/mach-tegra/pinmux.c              |   64 ++++++++++++++++++++++++++---
 2 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-tegra/include/mach/pinmux.h b/arch/arm/mach-tegra/include/mach/pinmux.h
index defd877..368dc3e 100644
--- a/arch/arm/mach-tegra/include/mach/pinmux.h
+++ b/arch/arm/mach-tegra/include/mach/pinmux.h
@@ -218,6 +218,15 @@ struct tegra_pingroup_desc {
 extern const struct tegra_pingroup_desc tegra_soc_pingroups[];
 extern const struct tegra_drive_pingroup_desc tegra_soc_drive_pingroups[];
 
+int tegra_pinmux_get_func(enum tegra_pingroup pg,
+	enum tegra_mux_func *func);
+int tegra_pinmux_get_tristate(enum tegra_pingroup pg,
+	enum tegra_tristate *tristate);
+int tegra_pinmux_get_pullupdown(enum tegra_pingroup pg,
+	enum tegra_pullupdown *pupd);
+
+int tegra_pinmux_set_func(enum tegra_pingroup pg,
+	enum tegra_mux_func func);
 int tegra_pinmux_set_tristate(enum tegra_pingroup pg,
 	enum tegra_tristate tristate);
 int tegra_pinmux_set_pullupdown(enum tegra_pingroup pg,
diff --git a/arch/arm/mach-tegra/pinmux.c b/arch/arm/mach-tegra/pinmux.c
index f80d507..1c69d4d 100644
--- a/arch/arm/mach-tegra/pinmux.c
+++ b/arch/arm/mach-tegra/pinmux.c
@@ -180,14 +180,66 @@ static inline void pg_writel(unsigned long value, unsigned long offset)
 	writel(value, IO_TO_VIRT(TEGRA_APB_MISC_BASE + offset));
 }
 
-static int tegra_pinmux_set_func(const struct tegra_pingroup_config *config)
+int tegra_pinmux_get_func(enum tegra_pingroup pg,
+	enum tegra_mux_func *func)
+{
+	int mux;
+	unsigned long reg;
+
+	if (pg < 0 || pg >=  TEGRA_MAX_PINGROUP)
+		return -ERANGE;
+
+	if (pingroups[pg].mux_reg < 0)
+		return -EINVAL;
+
+	reg = pg_readl(pingroups[pg].mux_reg);
+	mux = (reg >> pingroups[pg].mux_bit) & 3;
+	*func = pingroups[pg].funcs[mux];
+
+	return 0;
+}
+
+int tegra_pinmux_get_tristate(enum tegra_pingroup pg,
+	enum tegra_tristate *tristate)
+{
+	unsigned long reg;
+
+	if (pg < 0 || pg >=  TEGRA_MAX_PINGROUP)
+		return -ERANGE;
+
+	if (pingroups[pg].tri_reg < 0)
+		return -EINVAL;
+
+	reg = pg_readl(pingroups[pg].tri_reg);
+	*tristate = reg & (1 << pingroups[pg].tri_bit);
+
+	return 0;
+}
+
+int tegra_pinmux_get_pullupdown(enum tegra_pingroup pg,
+	enum tegra_pullupdown *pupd)
+{
+	unsigned long reg;
+
+	if (pg < 0 || pg >=  TEGRA_MAX_PINGROUP)
+		return -ERANGE;
+
+	if (pingroups[pg].pupd_reg < 0)
+		return -EINVAL;
+
+	reg = pg_readl(pingroups[pg].pupd_reg);
+	*pupd = (reg >> pingroups[pg].pupd_bit) & 3;
+
+	return 0;
+}
+
+int tegra_pinmux_set_func(enum tegra_pingroup pg,
+	enum tegra_mux_func func)
 {
 	int mux = -1;
 	int i;
 	unsigned long reg;
 	unsigned long flags;
-	enum tegra_pingroup pg = config->pingroup;
-	enum tegra_mux_func func = config->func;
 
 	if (pg < 0 || pg >=  TEGRA_MAX_PINGROUP)
 		return -ERANGE;
@@ -291,7 +343,7 @@ static void tegra_pinmux_config_pingroup(const struct tegra_pingroup_config *con
 	int err;
 
 	if (pingroups[pingroup].mux_reg >= 0) {
-		err = tegra_pinmux_set_func(config);
+		err = tegra_pinmux_set_func(pingroup, func);
 		if (err < 0)
 			pr_err("pinmux: can't set pingroup %s func to %s: %d\n",
 			       pingroup_name(pingroup), func_name(func), err);
@@ -598,7 +650,7 @@ void tegra_pinmux_set_safe_pinmux_table(const struct tegra_pingroup_config *conf
 			continue;
 		}
 		c.func = pingroups[c.pingroup].func_safe;
-		err = tegra_pinmux_set_func(&c);
+		err = tegra_pinmux_set_func(c.pingroup, c.func);
 		if (err < 0)
 			pr_err("%s: tegra_pinmux_set_func returned %d setting "
 			       "%s to %s\n", __func__, err,
@@ -618,7 +670,7 @@ void tegra_pinmux_config_pinmux_table(const struct tegra_pingroup_config *config
 			WARN_ON(1);
 			continue;
 		}
-		err = tegra_pinmux_set_func(&config[i]);
+		err = tegra_pinmux_set_func(config[i].pingroup, config[i].func);
 		if (err < 0)
 			pr_err("%s: tegra_pinmux_set_func returned %d setting "
 			       "%s to %s\n", __func__, err,
-- 
1.7.1
