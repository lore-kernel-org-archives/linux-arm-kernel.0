From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 15 Nov 2013 13:54:26 -0700
Subject: [PATCH 31/31] clk: tegra: remove bogus PCIE_XCLK
In-Reply-To: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1384548866-13141-32-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

The "pcie_xclk" clock is not actually a clock at all, but rather a reset
domain. Now that the custom Tegra module reset API has been removed, we
can remove the definition of any "clocks" that existed solely to support
it.

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
 drivers/clk/tegra/clk-tegra20.c         | 6 ------
 drivers/clk/tegra/clk-tegra30.c         | 7 -------
 include/dt-bindings/clock/tegra20-car.h | 2 +-
 include/dt-bindings/clock/tegra30-car.h | 2 +-
 4 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index eeffff6c6778..69c44ccc2ab2 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -473,7 +473,6 @@ static struct tegra_devclk devclks[] __initdata = {
 	{ .con_id = "isp", .dev_id = "tegra_camera", .dt_id = TEGRA20_CLK_ISP },
 	{ .con_id = "pex", .dt_id = TEGRA20_CLK_PEX },
 	{ .con_id = "afi", .dt_id = TEGRA20_CLK_AFI },
-	{ .con_id = "pcie_xclk", .dt_id = TEGRA20_CLK_PCIE_XCLK },
 	{ .con_id = "cdev1", .dt_id = TEGRA20_CLK_CDEV1 },
 	{ .con_id = "cdev2", .dt_id = TEGRA20_CLK_CDEV2 },
 	{ .con_id = "clk_32k", .dt_id = TEGRA20_CLK_CLK_32K },
@@ -839,11 +838,6 @@ static void __init tegra20_periph_clk_init(void)
 				    periph_clk_enb_refcnt);
 	clks[TEGRA20_CLK_PEX] = clk;
 
-	/* pcie_xclk */
-	clk = tegra_clk_register_periph_gate("pcie_xclk", "clk_m", 0, clk_base,
-				    0, 74, periph_clk_enb_refcnt);
-	clks[TEGRA20_CLK_PCIE_XCLK] = clk;
-
 	/* cdev1 */
 	clk = clk_register_fixed_rate(NULL, "cdev1_fixed", NULL, CLK_IS_ROOT,
 				      26000000);
diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index e9b6a305be92..a0c9cc4dc6a3 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -658,7 +658,6 @@ static struct tegra_devclk devclks[] __initdata = {
 	{ .con_id = "isp", .dev_id = "tegra_camera", .dt_id = TEGRA30_CLK_ISP },
 	{ .con_id = "pcie", .dev_id = "tegra-pcie", .dt_id = TEGRA30_CLK_PCIE },
 	{ .con_id = "afi", .dev_id = "tegra-pcie", .dt_id = TEGRA30_CLK_AFI },
-	{ .con_id = "pciex", .dev_id = "tegra-pcie", .dt_id = TEGRA30_CLK_PCIEX },
 	{ .con_id = "fuse", .dev_id = "fuse-tegra", .dt_id = TEGRA30_CLK_FUSE },
 	{ .con_id = "fuse_burn", .dev_id = "fuse-tegra", .dt_id = TEGRA30_CLK_FUSE_BURN },
 	{ .con_id = "apbif", .dev_id = "tegra30-ahub", .dt_id = TEGRA30_CLK_APBIF },
@@ -1159,11 +1158,6 @@ static void __init tegra30_periph_clk_init(void)
 				    periph_clk_enb_refcnt);
 	clks[TEGRA30_CLK_AFI] = clk;
 
-	/* pciex */
-	clk = tegra_clk_register_periph_gate("pciex", "pll_e", 0, clk_base, 0,
-				    74, periph_clk_enb_refcnt);
-	clks[TEGRA30_CLK_PCIEX] = clk;
-
 	/* emc */
 	clk = clk_register_mux(NULL, "emc_mux", mux_pllmcp_clkm,
 			       ARRAY_SIZE(mux_pllmcp_clkm),
@@ -1404,7 +1398,6 @@ static struct tegra_clk_duplicate tegra_clk_duplicates[] = {
 	TEGRA_CLK_DUPLICATE(TEGRA30_CLK_BSEA, "nvavp", "bsea"),
 	TEGRA_CLK_DUPLICATE(TEGRA30_CLK_CML1, "tegra_sata_cml", NULL),
 	TEGRA_CLK_DUPLICATE(TEGRA30_CLK_CML0, "tegra_pcie", "cml"),
-	TEGRA_CLK_DUPLICATE(TEGRA30_CLK_PCIEX, "tegra_pcie", "pciex"),
 	TEGRA_CLK_DUPLICATE(TEGRA30_CLK_VCP, "nvavp", "vcp"),
 	TEGRA_CLK_DUPLICATE(TEGRA30_CLK_CLK_MAX, NULL, NULL), /* MUST be the last entry */
 };
diff --git a/include/dt-bindings/clock/tegra20-car.h b/include/dt-bindings/clock/tegra20-car.h
index a1ae9a8fdd6c..9406207cfac8 100644
--- a/include/dt-bindings/clock/tegra20-car.h
+++ b/include/dt-bindings/clock/tegra20-car.h
@@ -92,7 +92,7 @@
 #define TEGRA20_CLK_OWR 71
 #define TEGRA20_CLK_AFI 72
 #define TEGRA20_CLK_CSITE 73
-#define TEGRA20_CLK_PCIE_XCLK 74
+/* 74 */
 #define TEGRA20_CLK_AVPUCQ 75
 #define TEGRA20_CLK_LA 76
 /* 77 */
diff --git a/include/dt-bindings/clock/tegra30-car.h b/include/dt-bindings/clock/tegra30-car.h
index 22445820a929..889e49ba0aa3 100644
--- a/include/dt-bindings/clock/tegra30-car.h
+++ b/include/dt-bindings/clock/tegra30-car.h
@@ -92,7 +92,7 @@
 #define TEGRA30_CLK_OWR 71
 #define TEGRA30_CLK_AFI 72
 #define TEGRA30_CLK_CSITE 73
-#define TEGRA30_CLK_PCIEX 74
+/* 74 */
 #define TEGRA30_CLK_AVPUCQ 75
 #define TEGRA30_CLK_LA 76
 /* 77 */
-- 
1.8.1.5
