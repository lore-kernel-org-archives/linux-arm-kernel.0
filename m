From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 19 Oct 2016 17:23:49 +0900
Subject: [PATCH] reset: uniphier: rename MIO reset to SD reset for Pro5, PXs2,
 LD20 SoCs
Message-ID: <1476865429-13143-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I made a mistake as for naming for this block.  The MIO block is not
implemented for these 3 SoCs in the first place.  The current naming
will be a trouble if an SoC with both MIO and SD-ctrl blocks appear
in the future.

This driver has just been merged in the previous merge window.
Rename it before the release.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Philipp,

If you do not mind, may I include this in my PR
along with the "select ARCH_HAS_RESET_CONTROLLER" patches?



 .../devicetree/bindings/reset/uniphier-reset.txt   | 22 +++++++++++-----------
 drivers/reset/reset-uniphier.c                     | 16 ++++++++--------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/uniphier-reset.txt b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
index e6bbfcc..78cd735 100644
--- a/Documentation/devicetree/bindings/reset/uniphier-reset.txt
+++ b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
@@ -19,12 +19,12 @@ Required properties:
 Example:
 
 	sysctrl at 61840000 {
-		compatible = "socionext,uniphier-ld20-sysctrl",
+		compatible = "socionext,uniphier-ld11-sysctrl",
 			     "simple-mfd", "syscon";
 		reg = <0x61840000 0x4000>;
 
 		reset {
-			compatible = "socionext,uniphier-ld20-reset";
+			compatible = "socionext,uniphier-ld11-reset";
 			#reset-cells = <1>;
 		};
 
@@ -32,8 +32,8 @@ Example:
 	};
 
 
-Media I/O (MIO) reset
----------------------
+Media I/O (MIO) reset, SD reset
+-------------------------------
 
 Required properties:
 - compatible: should be one of the following:
@@ -41,21 +41,21 @@ Required properties:
     "socionext,uniphier-ld4-mio-reset"  - for PH1-LD4 SoC.
     "socionext,uniphier-pro4-mio-reset" - for PH1-Pro4 SoC.
     "socionext,uniphier-sld8-mio-reset" - for PH1-sLD8 SoC.
-    "socionext,uniphier-pro5-mio-reset" - for PH1-Pro5 SoC.
-    "socionext,uniphier-pxs2-mio-reset" - for ProXstream2/PH1-LD6b SoC.
+    "socionext,uniphier-pro5-sd-reset"  - for PH1-Pro5 SoC.
+    "socionext,uniphier-pxs2-sd-reset"  - for ProXstream2/PH1-LD6b SoC.
     "socionext,uniphier-ld11-mio-reset" - for PH1-LD11 SoC.
-    "socionext,uniphier-ld20-mio-reset" - for PH1-LD20 SoC.
+    "socionext,uniphier-ld20-sd-reset"  - for PH1-LD20 SoC.
 - #reset-cells: should be 1.
 
 Example:
 
 	mioctrl at 59810000 {
-		compatible = "socionext,uniphier-ld20-mioctrl",
+		compatible = "socionext,uniphier-ld11-mioctrl",
 			     "simple-mfd", "syscon";
 		reg = <0x59810000 0x800>;
 
 		reset {
-			compatible = "socionext,uniphier-ld20-mio-reset";
+			compatible = "socionext,uniphier-ld11-mio-reset";
 			#reset-cells = <1>;
 		};
 
@@ -80,12 +80,12 @@ Required properties:
 Example:
 
 	perictrl at 59820000 {
-		compatible = "socionext,uniphier-ld20-perictrl",
+		compatible = "socionext,uniphier-ld11-perictrl",
 			     "simple-mfd", "syscon";
 		reg = <0x59820000 0x200>;
 
 		reset {
-			compatible = "socionext,uniphier-ld20-peri-reset";
+			compatible = "socionext,uniphier-ld11-peri-reset";
 			#reset-cells = <1>;
 		};
 
diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphier.c
index 8b2558e..968c3ae 100644
--- a/drivers/reset/reset-uniphier.c
+++ b/drivers/reset/reset-uniphier.c
@@ -154,7 +154,7 @@ struct uniphier_reset_data {
 	UNIPHIER_RESET_END,
 };
 
-const struct uniphier_reset_data uniphier_pro5_mio_reset_data[] = {
+const struct uniphier_reset_data uniphier_pro5_sd_reset_data[] = {
 	UNIPHIER_MIO_RESET_SD(0, 0),
 	UNIPHIER_MIO_RESET_SD(1, 1),
 	UNIPHIER_MIO_RESET_EMMC_HW_RESET(6, 1),
@@ -360,7 +360,7 @@ static int uniphier_reset_probe(struct platform_device *pdev)
 		.compatible = "socionext,uniphier-ld20-reset",
 		.data = uniphier_ld20_sys_reset_data,
 	},
-	/* Media I/O reset */
+	/* Media I/O reset, SD reset */
 	{
 		.compatible = "socionext,uniphier-sld3-mio-reset",
 		.data = uniphier_sld3_mio_reset_data,
@@ -378,20 +378,20 @@ static int uniphier_reset_probe(struct platform_device *pdev)
 		.data = uniphier_sld3_mio_reset_data,
 	},
 	{
-		.compatible = "socionext,uniphier-pro5-mio-reset",
-		.data = uniphier_pro5_mio_reset_data,
+		.compatible = "socionext,uniphier-pro5-sd-reset",
+		.data = uniphier_pro5_sd_reset_data,
 	},
 	{
-		.compatible = "socionext,uniphier-pxs2-mio-reset",
-		.data = uniphier_pro5_mio_reset_data,
+		.compatible = "socionext,uniphier-pxs2-sd-reset",
+		.data = uniphier_pro5_sd_reset_data,
 	},
 	{
 		.compatible = "socionext,uniphier-ld11-mio-reset",
 		.data = uniphier_sld3_mio_reset_data,
 	},
 	{
-		.compatible = "socionext,uniphier-ld20-mio-reset",
-		.data = uniphier_pro5_mio_reset_data,
+		.compatible = "socionext,uniphier-ld20-sd-reset",
+		.data = uniphier_pro5_sd_reset_data,
 	},
 	/* Peripheral reset */
 	{
-- 
1.9.1
