From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 11 Mar 2017 20:04:16 +0200
Subject: [RESEND] drm/exynos: Remove support for Exynos4415 (SoC not supported
 anymore)
Message-ID: <20170311180416.7071-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support for Exynos4415 is going away because there are no internal nor
external users.

Since commit 46dcf0ff0de3 ("ARM: dts: exynos: Remove exynos4415.dtsi"),
the platform cannot be instantiated so remove also the drivers.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Kukjin Kim <kgene@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/display/exynos/exynos_dsim.txt |  1 -
 .../bindings/display/exynos/samsung-fimd.txt           |  1 -
 drivers/gpu/drm/exynos/exynos_drm_dsi.c                | 15 +--------------
 drivers/gpu/drm/exynos/exynos_drm_fimd.c               | 18 ++----------------
 4 files changed, 3 insertions(+), 32 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/exynos/exynos_dsim.txt b/Documentation/devicetree/bindings/display/exynos/exynos_dsim.txt
index a78265993665..ca5204b3bc21 100644
--- a/Documentation/devicetree/bindings/display/exynos/exynos_dsim.txt
+++ b/Documentation/devicetree/bindings/display/exynos/exynos_dsim.txt
@@ -4,7 +4,6 @@ Required properties:
   - compatible: value should be one of the following
 		"samsung,exynos3250-mipi-dsi" /* for Exynos3250/3472 SoCs */
 		"samsung,exynos4210-mipi-dsi" /* for Exynos4 SoCs */
-		"samsung,exynos4415-mipi-dsi" /* for Exynos4415 SoC */
 		"samsung,exynos5410-mipi-dsi" /* for Exynos5410/5420/5440 SoCs */
 		"samsung,exynos5422-mipi-dsi" /* for Exynos5422/5800 SoCs */
 		"samsung,exynos5433-mipi-dsi" /* for Exynos5433 SoCs */
diff --git a/Documentation/devicetree/bindings/display/exynos/samsung-fimd.txt b/Documentation/devicetree/bindings/display/exynos/samsung-fimd.txt
index 18645e0228b0..5837402c3ade 100644
--- a/Documentation/devicetree/bindings/display/exynos/samsung-fimd.txt
+++ b/Documentation/devicetree/bindings/display/exynos/samsung-fimd.txt
@@ -11,7 +11,6 @@ Required properties:
 		"samsung,s5pv210-fimd"; /* for S5PV210 SoC */
 		"samsung,exynos3250-fimd"; /* for Exynos3250/3472 SoCs */
 		"samsung,exynos4210-fimd"; /* for Exynos4 SoCs */
-		"samsung,exynos4415-fimd"; /* for Exynos4415 SoC */
 		"samsung,exynos5250-fimd"; /* for Exynos5250 SoCs */
 		"samsung,exynos5420-fimd"; /* for Exynos5420/5422/5800 SoCs */
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index 812e2ec0761d..ef6f9c6de098 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -86,7 +86,7 @@
 #define DSIM_SYNC_INFORM		(1 << 27)
 #define DSIM_EOT_DISABLE		(1 << 28)
 #define DSIM_MFLUSH_VS			(1 << 29)
-/* This flag is valid only for exynos3250/3472/4415/5260/5430 */
+/* This flag is valid only for exynos3250/3472/5260/5430 */
 #define DSIM_CLKLANE_STOP		(1 << 30)
 
 /* DSIM_ESCMODE */
@@ -473,17 +473,6 @@ static const struct exynos_dsi_driver_data exynos4_dsi_driver_data = {
 	.reg_values = reg_values,
 };
 
-static const struct exynos_dsi_driver_data exynos4415_dsi_driver_data = {
-	.reg_ofs = exynos_reg_ofs,
-	.plltmr_reg = 0x58,
-	.has_clklane_stop = 1,
-	.num_clks = 2,
-	.max_freq = 1000,
-	.wait_for_reset = 1,
-	.num_bits_resol = 11,
-	.reg_values = reg_values,
-};
-
 static const struct exynos_dsi_driver_data exynos5_dsi_driver_data = {
 	.reg_ofs = exynos_reg_ofs,
 	.plltmr_reg = 0x58,
@@ -521,8 +510,6 @@ static const struct of_device_id exynos_dsi_of_match[] = {
 	  .data = &exynos3_dsi_driver_data },
 	{ .compatible = "samsung,exynos4210-mipi-dsi",
 	  .data = &exynos4_dsi_driver_data },
-	{ .compatible = "samsung,exynos4415-mipi-dsi",
-	  .data = &exynos4415_dsi_driver_data },
 	{ .compatible = "samsung,exynos5410-mipi-dsi",
 	  .data = &exynos5_dsi_driver_data },
 	{ .compatible = "samsung,exynos5422-mipi-dsi",
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index a9fa444c6053..661b9fe049e2 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -71,10 +71,10 @@
 #define TRIGCON				0x1A4
 #define TRGMODE_ENABLE			(1 << 0)
 #define SWTRGCMD_ENABLE			(1 << 1)
-/* Exynos3250, 3472, 4415, 5260 5410, 5420 and 5422 only supported. */
+/* Exynos3250, 3472, 5260 5410, 5420 and 5422 only supported. */
 #define HWTRGEN_ENABLE			(1 << 3)
 #define HWTRGMASK_ENABLE		(1 << 4)
-/* Exynos3250, 3472, 4415, 5260, 5420 and 5422 only supported. */
+/* Exynos3250, 3472, 5260, 5420 and 5422 only supported. */
 #define HWTRIGEN_PER_ENABLE		(1 << 31)
 
 /* display mode change control register except exynos4 */
@@ -138,18 +138,6 @@ static struct fimd_driver_data exynos4_fimd_driver_data = {
 	.has_vtsel = 1,
 };
 
-static struct fimd_driver_data exynos4415_fimd_driver_data = {
-	.timing_base = 0x20000,
-	.lcdblk_offset = 0x210,
-	.lcdblk_vt_shift = 10,
-	.lcdblk_bypass_shift = 1,
-	.trg_type = I80_HW_TRG,
-	.has_shadowcon = 1,
-	.has_vidoutcon = 1,
-	.has_vtsel = 1,
-	.has_trigger_per_te = 1,
-};
-
 static struct fimd_driver_data exynos5_fimd_driver_data = {
 	.timing_base = 0x20000,
 	.lcdblk_offset = 0x214,
@@ -210,8 +198,6 @@ static const struct of_device_id fimd_driver_dt_match[] = {
 	  .data = &exynos3_fimd_driver_data },
 	{ .compatible = "samsung,exynos4210-fimd",
 	  .data = &exynos4_fimd_driver_data },
-	{ .compatible = "samsung,exynos4415-fimd",
-	  .data = &exynos4415_fimd_driver_data },
 	{ .compatible = "samsung,exynos5250-fimd",
 	  .data = &exynos5_fimd_driver_data },
 	{ .compatible = "samsung,exynos5420-fimd",
-- 
2.9.3
