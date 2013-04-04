From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu,  4 Apr 2013 15:35:39 -0600
Subject: [PATCH V2] clk: tegra: defer application of init table
Message-ID: <1365111340-2143-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

The Tegra clock driver is initialized during the ARM machine descriptor's
.init_irq() hook. It can't be initialized earlier, since dynamic memory
usage is required. It can't be initialized later, since the .init_timer()
hook needs the clocks initialized. However, at this time, udelay()
doesn't work.

The Tegra clock initialization table may enable some PLLs. Enabling a PLL
may require usage of udelay(). Hence, this can't happen right when the
clock driver is initialized.

To solve this, separate the clock driver initialization from the clock
table processing, so they can execute at separate times.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Mike, the Tegra114 CCF V9 series assume this is applied first. Hence, I'm
looking for an ack on this too. Thanks!

v2: Move this before the main Tegra114 CCF changes, since they assume this
has already been applied. The Tegra114 parts of this patch are now already
included in the Tegra114 driver series v9.

---
 arch/arm/mach-tegra/tegra.c     |    3 +++
 drivers/clk/tegra/clk-tegra20.c |    7 ++++++-
 drivers/clk/tegra/clk-tegra30.c |    7 ++++++-
 drivers/clk/tegra/clk.c         |   10 ++++++++++
 drivers/clk/tegra/clk.h         |    3 +++
 include/linux/clk/tegra.h       |    1 +
 6 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index 9cf1ab1..0d1e412 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -34,6 +34,7 @@
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
 #include <linux/usb/tegra_usb_phy.h>
+#include <linux/clk/tegra.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -85,6 +86,8 @@ static void __init tegra_dt_init(void)
 	struct soc_device *soc_dev;
 	struct device *parent = NULL;
 
+	tegra_clocks_apply_init_table();
+
 	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
 	if (!soc_dev_attr)
 		goto out;
diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index b020beb..e90ac64 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -1252,6 +1252,11 @@ static __initdata struct tegra_clk_init_table init_table[] = {
 	{clk_max, clk_max, 0, 0}, /* This MUST be the last entry */
 };
 
+static void __init tegra20_clock_apply_init_table(void)
+{
+	tegra_init_from_table(init_table, clks, clk_max);
+}
+
 /*
  * Some clocks may be used by different drivers depending on the board
  * configuration.  List those here to register them twice in the clock lookup
@@ -1318,7 +1323,7 @@ void __init tegra20_clock_init(struct device_node *np)
 	clk_data.clk_num = ARRAY_SIZE(clks);
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 
-	tegra_init_from_table(init_table, clks, clk_max);
+	tegra_clk_apply_init_table = tegra20_clock_apply_init_table;
 
 	tegra_cpu_car_ops = &tegra20_cpu_car_ops;
 }
diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index a0c54ad..c851151 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -1915,6 +1915,11 @@ static __initdata struct tegra_clk_init_table init_table[] = {
 	{clk_max, clk_max, 0, 0}, /* This MUST be the last entry. */
 };
 
+static void __init tegra30_clock_apply_init_table(void)
+{
+	tegra_init_from_table(init_table, clks, clk_max);
+}
+
 /*
  * Some clocks may be used by different drivers depending on the board
  * configuration.  List those here to register them twice in the clock lookup
@@ -1988,7 +1993,7 @@ void __init tegra30_clock_init(struct device_node *np)
 	clk_data.clk_num = ARRAY_SIZE(clks);
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 
-	tegra_init_from_table(init_table, clks, clk_max);
+	tegra_clk_apply_init_table = tegra30_clock_apply_init_table;
 
 	tegra_cpu_car_ops = &tegra30_cpu_car_ops;
 }
diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
index a603b9a..4a61d15 100644
--- a/drivers/clk/tegra/clk.c
+++ b/drivers/clk/tegra/clk.c
@@ -83,3 +83,13 @@ void __init tegra_clocks_init(void)
 {
 	of_clk_init(tegra_dt_clk_match);
 }
+
+tegra_clk_apply_init_table_func tegra_clk_apply_init_table;
+
+void __init tegra_clocks_apply_init_table(void)
+{
+	if (!tegra_clk_apply_init_table)
+		return;
+
+	tegra_clk_apply_init_table();
+}
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index a09d7dc..3c566e2 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -510,4 +510,7 @@ void tegra30_clock_init(struct device_node *np);
 static inline void tegra30_clock_init(struct device_node *np) {}
 #endif /* CONFIG_ARCH_TEGRA_3x_SOC */
 
+typedef void (*tegra_clk_apply_init_table_func)(void);
+extern tegra_clk_apply_init_table_func tegra_clk_apply_init_table;
+
 #endif /* TEGRA_CLK_H */
diff --git a/include/linux/clk/tegra.h b/include/linux/clk/tegra.h
index 404d6f9..642789b 100644
--- a/include/linux/clk/tegra.h
+++ b/include/linux/clk/tegra.h
@@ -123,5 +123,6 @@ static inline void tegra_cpu_clock_resume(void)
 void tegra_periph_reset_deassert(struct clk *c);
 void tegra_periph_reset_assert(struct clk *c);
 void tegra_clocks_init(void);
+void tegra_clocks_apply_init_table(void);
 
 #endif /* __LINUX_CLK_TEGRA_H_ */
-- 
1.7.10.4
