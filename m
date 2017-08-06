From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun,  6 Aug 2017 11:44:01 +0900
Subject: [PATCH 1/2] reset: uniphier: remove sLD3 SoC support
In-Reply-To: <1501987442-2583-1-git-send-email-yamada.masahiro@socionext.com>
References: <1501987442-2583-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1501987442-2583-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This SoC is too old.  It is difficult to maintain any longer.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 .../devicetree/bindings/reset/uniphier-reset.txt   |  2 -
 drivers/reset/reset-uniphier.c                     | 48 ++++++++--------------
 2 files changed, 16 insertions(+), 34 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/uniphier-reset.txt b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
index 83ab0f599c40..b80ccc03ab9f 100644
--- a/Documentation/devicetree/bindings/reset/uniphier-reset.txt
+++ b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
@@ -6,7 +6,6 @@ System reset
 
 Required properties:
 - compatible: should be one of the following:
-    "socionext,uniphier-sld3-reset" - for sLD3 SoC
     "socionext,uniphier-ld4-reset"  - for LD4 SoC
     "socionext,uniphier-pro4-reset" - for Pro4 SoC
     "socionext,uniphier-sld8-reset" - for sLD8 SoC
@@ -37,7 +36,6 @@ Media I/O (MIO) reset, SD reset
 
 Required properties:
 - compatible: should be one of the following:
-    "socionext,uniphier-sld3-mio-reset" - for sLD3 SoC
     "socionext,uniphier-ld4-mio-reset"  - for LD4 SoC
     "socionext,uniphier-pro4-mio-reset" - for Pro4 SoC
     "socionext,uniphier-sld8-mio-reset" - for sLD8 SoC
diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphier.c
index c4ba89832796..3947fc2ef52c 100644
--- a/drivers/reset/reset-uniphier.c
+++ b/drivers/reset/reset-uniphier.c
@@ -50,18 +50,12 @@ struct uniphier_reset_data {
 	}
 
 /* System reset data */
-#define UNIPHIER_SLD3_SYS_RESET_NAND(id)		\
-	UNIPHIER_RESETX((id), 0x2004, 2)
-
 #define UNIPHIER_LD11_SYS_RESET_NAND(id)		\
 	UNIPHIER_RESETX((id), 0x200c, 0)
 
 #define UNIPHIER_LD11_SYS_RESET_EMMC(id)		\
 	UNIPHIER_RESETX((id), 0x200c, 2)
 
-#define UNIPHIER_SLD3_SYS_RESET_STDMAC(id)		\
-	UNIPHIER_RESETX((id), 0x2000, 10)
-
 #define UNIPHIER_LD11_SYS_RESET_STDMAC(id)		\
 	UNIPHIER_RESETX((id), 0x200c, 8)
 
@@ -74,15 +68,15 @@ struct uniphier_reset_data {
 #define UNIPHIER_PRO4_SYS_RESET_USB3(id, ch)		\
 	UNIPHIER_RESETX((id), 0x2000 + 0x4 * (ch), 17)
 
-static const struct uniphier_reset_data uniphier_sld3_sys_reset_data[] = {
-	UNIPHIER_SLD3_SYS_RESET_NAND(2),
-	UNIPHIER_SLD3_SYS_RESET_STDMAC(8),	/* Ether, HSC, MIO */
+static const struct uniphier_reset_data uniphier_ld4_sys_reset_data[] = {
+	UNIPHIER_RESETX(2, 0x2000, 2),		/* NAND */
+	UNIPHIER_RESETX(8, 0x2000, 10),		/* STDMAC (Ether, HSC, MIO) */
 	UNIPHIER_RESET_END,
 };
 
 static const struct uniphier_reset_data uniphier_pro4_sys_reset_data[] = {
-	UNIPHIER_SLD3_SYS_RESET_NAND(2),
-	UNIPHIER_SLD3_SYS_RESET_STDMAC(8),	/* HSC, MIO, RLE */
+	UNIPHIER_RESETX(2, 0x2000, 2),		/* NAND */
+	UNIPHIER_RESETX(8, 0x2000, 10),		/* STDMAC (HSC, MIO, RLE) */
 	UNIPHIER_PRO4_SYS_RESET_GIO(12),	/* Ether, SATA, USB3 */
 	UNIPHIER_PRO4_SYS_RESET_USB3(14, 0),
 	UNIPHIER_PRO4_SYS_RESET_USB3(15, 1),
@@ -90,8 +84,8 @@ static const struct uniphier_reset_data uniphier_pro4_sys_reset_data[] = {
 };
 
 static const struct uniphier_reset_data uniphier_pro5_sys_reset_data[] = {
-	UNIPHIER_SLD3_SYS_RESET_NAND(2),
-	UNIPHIER_SLD3_SYS_RESET_STDMAC(8),	/* HSC */
+	UNIPHIER_RESETX(2, 0x2000, 2),		/* NAND */
+	UNIPHIER_RESETX(8, 0x2000, 10),		/* STDMAC (HSC) */
 	UNIPHIER_PRO4_SYS_RESET_GIO(12),	/* PCIe, USB3 */
 	UNIPHIER_PRO4_SYS_RESET_USB3(14, 0),
 	UNIPHIER_PRO4_SYS_RESET_USB3(15, 1),
@@ -99,8 +93,8 @@ static const struct uniphier_reset_data uniphier_pro5_sys_reset_data[] = {
 };
 
 static const struct uniphier_reset_data uniphier_pxs2_sys_reset_data[] = {
-	UNIPHIER_SLD3_SYS_RESET_NAND(2),
-	UNIPHIER_SLD3_SYS_RESET_STDMAC(8),	/* HSC, RLE */
+	UNIPHIER_RESETX(2, 0x2000, 2),		/* NAND */
+	UNIPHIER_RESETX(8, 0x2000, 10),		/* STDMAC (HSC, RLE) */
 	UNIPHIER_PRO4_SYS_RESET_USB3(14, 0),
 	UNIPHIER_PRO4_SYS_RESET_USB3(15, 1),
 	UNIPHIER_RESETX(16, 0x2014, 4),		/* USB30-PHY0 */
@@ -151,7 +145,7 @@ static const struct uniphier_reset_data uniphier_ld20_sys_reset_data[] = {
 #define UNIPHIER_MIO_RESET_DMAC(id)			\
 	UNIPHIER_RESETX((id), 0x110, 17)
 
-static const struct uniphier_reset_data uniphier_sld3_mio_reset_data[] = {
+static const struct uniphier_reset_data uniphier_ld4_mio_reset_data[] = {
 	UNIPHIER_MIO_RESET_SD(0, 0),
 	UNIPHIER_MIO_RESET_SD(1, 1),
 	UNIPHIER_MIO_RESET_SD(2, 2),
@@ -163,11 +157,9 @@ static const struct uniphier_reset_data uniphier_sld3_mio_reset_data[] = {
 	UNIPHIER_MIO_RESET_USB2(8, 0),
 	UNIPHIER_MIO_RESET_USB2(9, 1),
 	UNIPHIER_MIO_RESET_USB2(10, 2),
-	UNIPHIER_MIO_RESET_USB2(11, 3),
 	UNIPHIER_MIO_RESET_USB2_BRIDGE(12, 0),
 	UNIPHIER_MIO_RESET_USB2_BRIDGE(13, 1),
 	UNIPHIER_MIO_RESET_USB2_BRIDGE(14, 2),
-	UNIPHIER_MIO_RESET_USB2_BRIDGE(15, 3),
 	UNIPHIER_RESET_END,
 };
 
@@ -346,12 +338,8 @@ static int uniphier_reset_probe(struct platform_device *pdev)
 static const struct of_device_id uniphier_reset_match[] = {
 	/* System reset */
 	{
-		.compatible = "socionext,uniphier-sld3-reset",
-		.data = uniphier_sld3_sys_reset_data,
-	},
-	{
 		.compatible = "socionext,uniphier-ld4-reset",
-		.data = uniphier_sld3_sys_reset_data,
+		.data = uniphier_ld4_sys_reset_data,
 	},
 	{
 		.compatible = "socionext,uniphier-pro4-reset",
@@ -359,7 +347,7 @@ static const struct of_device_id uniphier_reset_match[] = {
 	},
 	{
 		.compatible = "socionext,uniphier-sld8-reset",
-		.data = uniphier_sld3_sys_reset_data,
+		.data = uniphier_ld4_sys_reset_data,
 	},
 	{
 		.compatible = "socionext,uniphier-pro5-reset",
@@ -379,20 +367,16 @@ static const struct of_device_id uniphier_reset_match[] = {
 	},
 	/* Media I/O reset, SD reset */
 	{
-		.compatible = "socionext,uniphier-sld3-mio-reset",
-		.data = uniphier_sld3_mio_reset_data,
-	},
-	{
 		.compatible = "socionext,uniphier-ld4-mio-reset",
-		.data = uniphier_sld3_mio_reset_data,
+		.data = uniphier_ld4_mio_reset_data,
 	},
 	{
 		.compatible = "socionext,uniphier-pro4-mio-reset",
-		.data = uniphier_sld3_mio_reset_data,
+		.data = uniphier_ld4_mio_reset_data,
 	},
 	{
 		.compatible = "socionext,uniphier-sld8-mio-reset",
-		.data = uniphier_sld3_mio_reset_data,
+		.data = uniphier_ld4_mio_reset_data,
 	},
 	{
 		.compatible = "socionext,uniphier-pro5-sd-reset",
@@ -404,7 +388,7 @@ static const struct of_device_id uniphier_reset_match[] = {
 	},
 	{
 		.compatible = "socionext,uniphier-ld11-mio-reset",
-		.data = uniphier_sld3_mio_reset_data,
+		.data = uniphier_ld4_mio_reset_data,
 	},
 	{
 		.compatible = "socionext,uniphier-ld11-sd-reset",
-- 
2.7.4
