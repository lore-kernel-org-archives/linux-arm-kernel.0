From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 16 Dec 2014 12:38:27 -0800
Subject: [PATCH 1/4] clk: tegra: make tegra_clocks_apply_init_table()
 arch_initcall
In-Reply-To: <20141216203813.22980.2301.stgit@chromeos-P9X79>
References: <20141216203813.22980.2301.stgit@chromeos-P9X79>
Message-ID: <20141216203824.22980.48872.stgit@chromeos-P9X79>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter De Schrijver <pdeschrijver@nvidia.com>

tegra_clocks_apply_init_table() needs to be called after the udelay
loop has been calibrated (see commit
441f199a37cfd66c5dd8dd45490bd3ea6971117d ("clk: tegra: defer
application of init table") for why that is).  On existing Tegra SoCs
this was done by calling tegra_clocks_apply_init_table() from
tegra_dt_init(). To make this also work on ARM64, we need to change
this into an initcall. tegra_dt_init() is called from
customize_machine which is an arch_initcall. Therefore this should
also work on existing 32bit Tegra SoCs.

Tested on Tegra20 (ventana), Tegra30 (beaverboard), Tegra124 (jetson TK1) and
Tegra132.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
[paul at pwsan.com: tweaked the commit message]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Paul Walmsley <pwalmsley@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Prashant Gaikwad <pgaikwad@nvidia.com>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>
---
 arch/arm/mach-tegra/tegra.c |    2 --
 drivers/clk/tegra/clk.c     |    7 +++++--
 include/linux/clk/tegra.h   |    2 --
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index ef016af..914341b 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -91,8 +91,6 @@ static void __init tegra_dt_init(void)
 	struct soc_device *soc_dev;
 	struct device *parent = NULL;
 
-	tegra_clocks_apply_init_table();
-
 	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
 	if (!soc_dev_attr)
 		goto out;
diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
index 97dc859..9ddb754 100644
--- a/drivers/clk/tegra/clk.c
+++ b/drivers/clk/tegra/clk.c
@@ -302,10 +302,13 @@ struct clk ** __init tegra_lookup_dt_id(int clk_id,
 
 tegra_clk_apply_init_table_func tegra_clk_apply_init_table;
 
-void __init tegra_clocks_apply_init_table(void)
+static int __init tegra_clocks_apply_init_table(void)
 {
 	if (!tegra_clk_apply_init_table)
-		return;
+		return 0;
 
 	tegra_clk_apply_init_table();
+
+	return 0;
 }
+arch_initcall(tegra_clocks_apply_init_table);
diff --git a/include/linux/clk/tegra.h b/include/linux/clk/tegra.h
index 3ca9fca..19c4208 100644
--- a/include/linux/clk/tegra.h
+++ b/include/linux/clk/tegra.h
@@ -120,6 +120,4 @@ static inline void tegra_cpu_clock_resume(void)
 }
 #endif
 
-void tegra_clocks_apply_init_table(void);
-
 #endif /* __LINUX_CLK_TEGRA_H_ */
