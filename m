From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 26 Jul 2017 12:34:35 +0900
Subject: [PATCH] clk: uniphier: remove sLD3 SoC support
Message-ID: <1501040075-24279-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This SoC is too old.  It is difficult to maintain any longer.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 .../devicetree/bindings/clock/uniphier-clock.txt   |  5 ---
 drivers/clk/uniphier/clk-uniphier-core.c           | 16 +++------
 drivers/clk/uniphier/clk-uniphier-mio.c            |  4 +--
 drivers/clk/uniphier/clk-uniphier-sys.c            | 42 ++++++++--------------
 drivers/clk/uniphier/clk-uniphier.h                |  3 +-
 5 files changed, 20 insertions(+), 50 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/uniphier-clock.txt b/Documentation/devicetree/bindings/clock/uniphier-clock.txt
index 812163060fa3..2aec32d888ac 100644
--- a/Documentation/devicetree/bindings/clock/uniphier-clock.txt
+++ b/Documentation/devicetree/bindings/clock/uniphier-clock.txt
@@ -6,7 +6,6 @@ System clock
 
 Required properties:
 - compatible: should be one of the following:
-    "socionext,uniphier-sld3-clock" - for sLD3 SoC.
     "socionext,uniphier-ld4-clock"  - for LD4 SoC.
     "socionext,uniphier-pro4-clock" - for Pro4 SoC.
     "socionext,uniphier-sld8-clock" - for sLD8 SoC.
@@ -48,7 +47,6 @@ Media I/O (MIO) clock, SD clock
 
 Required properties:
 - compatible: should be one of the following:
-    "socionext,uniphier-sld3-mio-clock" - for sLD3 SoC.
     "socionext,uniphier-ld4-mio-clock"  - for LD4 SoC.
     "socionext,uniphier-pro4-mio-clock" - for Pro4 SoC.
     "socionext,uniphier-sld8-mio-clock" - for sLD8 SoC.
@@ -82,11 +80,9 @@ Provided clocks:
  8: USB2 ch0 host
  9: USB2 ch1 host
 10: USB2 ch2 host
-11: USB2 ch3 host
 12: USB2 ch0 PHY
 13: USB2 ch1 PHY
 14: USB2 ch2 PHY
-15: USB2 ch3 PHY
 
 
 Peripheral clock
@@ -94,7 +90,6 @@ Peripheral clock
 
 Required properties:
 - compatible: should be one of the following:
-    "socionext,uniphier-sld3-peri-clock" - for sLD3 SoC.
     "socionext,uniphier-ld4-peri-clock"  - for LD4 SoC.
     "socionext,uniphier-pro4-peri-clock" - for Pro4 SoC.
     "socionext,uniphier-sld8-peri-clock" - for sLD8 SoC.
diff --git a/drivers/clk/uniphier/clk-uniphier-core.c b/drivers/clk/uniphier/clk-uniphier-core.c
index 2cf386347f0c..cb6ae261bb36 100644
--- a/drivers/clk/uniphier/clk-uniphier-core.c
+++ b/drivers/clk/uniphier/clk-uniphier-core.c
@@ -111,10 +111,6 @@ static int uniphier_clk_remove(struct platform_device *pdev)
 static const struct of_device_id uniphier_clk_match[] = {
 	/* System clock */
 	{
-		.compatible = "socionext,uniphier-sld3-clock",
-		.data = uniphier_sld3_sys_clk_data,
-	},
-	{
 		.compatible = "socionext,uniphier-ld4-clock",
 		.data = uniphier_ld4_sys_clk_data,
 	},
@@ -144,20 +140,16 @@ static const struct of_device_id uniphier_clk_match[] = {
 	},
 	/* Media I/O clock, SD clock */
 	{
-		.compatible = "socionext,uniphier-sld3-mio-clock",
-		.data = uniphier_sld3_mio_clk_data,
-	},
-	{
 		.compatible = "socionext,uniphier-ld4-mio-clock",
-		.data = uniphier_sld3_mio_clk_data,
+		.data = uniphier_ld4_mio_clk_data,
 	},
 	{
 		.compatible = "socionext,uniphier-pro4-mio-clock",
-		.data = uniphier_sld3_mio_clk_data,
+		.data = uniphier_ld4_mio_clk_data,
 	},
 	{
 		.compatible = "socionext,uniphier-sld8-mio-clock",
-		.data = uniphier_sld3_mio_clk_data,
+		.data = uniphier_ld4_mio_clk_data,
 	},
 	{
 		.compatible = "socionext,uniphier-pro5-sd-clock",
@@ -169,7 +161,7 @@ static const struct of_device_id uniphier_clk_match[] = {
 	},
 	{
 		.compatible = "socionext,uniphier-ld11-mio-clock",
-		.data = uniphier_sld3_mio_clk_data,
+		.data = uniphier_ld4_mio_clk_data,
 	},
 	{
 		.compatible = "socionext,uniphier-ld20-sd-clock",
diff --git a/drivers/clk/uniphier/clk-uniphier-mio.c b/drivers/clk/uniphier/clk-uniphier-mio.c
index 218d20f099ce..16e4d303f535 100644
--- a/drivers/clk/uniphier/clk-uniphier-mio.c
+++ b/drivers/clk/uniphier/clk-uniphier-mio.c
@@ -76,7 +76,7 @@
 #define UNIPHIER_MIO_CLK_DMAC(idx)					\
 	UNIPHIER_CLK_GATE("miodmac", (idx), "stdmac", 0x20, 25)
 
-const struct uniphier_clk_data uniphier_sld3_mio_clk_data[] = {
+const struct uniphier_clk_data uniphier_ld4_mio_clk_data[] = {
 	UNIPHIER_MIO_CLK_SD_FIXED,
 	UNIPHIER_MIO_CLK_SD(0, 0),
 	UNIPHIER_MIO_CLK_SD(1, 1),
@@ -85,11 +85,9 @@ const struct uniphier_clk_data uniphier_sld3_mio_clk_data[] = {
 	UNIPHIER_MIO_CLK_USB2(8, 0),
 	UNIPHIER_MIO_CLK_USB2(9, 1),
 	UNIPHIER_MIO_CLK_USB2(10, 2),
-	UNIPHIER_MIO_CLK_USB2(11, 3),
 	UNIPHIER_MIO_CLK_USB2_PHY(12, 0),
 	UNIPHIER_MIO_CLK_USB2_PHY(13, 1),
 	UNIPHIER_MIO_CLK_USB2_PHY(14, 2),
-	UNIPHIER_MIO_CLK_USB2_PHY(15, 3),
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/clk/uniphier/clk-uniphier-sys.c b/drivers/clk/uniphier/clk-uniphier-sys.c
index ad0218182a9f..6fcf781de7d3 100644
--- a/drivers/clk/uniphier/clk-uniphier-sys.c
+++ b/drivers/clk/uniphier/clk-uniphier-sys.c
@@ -17,7 +17,7 @@
 
 #include "clk-uniphier.h"
 
-#define UNIPHIER_SLD3_SYS_CLK_SD					\
+#define UNIPHIER_LD4_SYS_CLK_SD					\
 	UNIPHIER_CLK_FACTOR("sd-200m", -1, "spll", 1, 8),		\
 	UNIPHIER_CLK_FACTOR("sd-133m", -1, "vpll27a", 1, 2)
 
@@ -30,7 +30,7 @@
 	UNIPHIER_CLK_FACTOR("sd-133m", -1, "spll", 1, 15)
 
 /* Denali driver requires clk_x rate (clk: 50MHz, clk_x & ecc_clk: 200MHz) */
-#define UNIPHIER_SLD3_SYS_CLK_NAND(idx)					\
+#define UNIPHIER_LD4_SYS_CLK_NAND(idx)					\
 	UNIPHIER_CLK_FACTOR("nand-200m", -1, "spll", 1, 8),		\
 	UNIPHIER_CLK_GATE("nand", (idx), "nand-200m", 0x2104, 2)
 
@@ -45,7 +45,7 @@
 #define UNIPHIER_LD11_SYS_CLK_EMMC(idx)					\
 	UNIPHIER_CLK_GATE("emmc", (idx), NULL, 0x210c, 2)
 
-#define UNIPHIER_SLD3_SYS_CLK_STDMAC(idx)				\
+#define UNIPHIER_LD4_SYS_CLK_STDMAC(idx)				\
 	UNIPHIER_CLK_GATE("stdmac", (idx), NULL, 0x2104, 10)
 
 #define UNIPHIER_LD11_SYS_CLK_STDMAC(idx)				\
@@ -57,20 +57,6 @@
 #define UNIPHIER_PRO4_SYS_CLK_USB3(idx, ch)				\
 	UNIPHIER_CLK_GATE("usb3" #ch, (idx), NULL, 0x2104, 16 + (ch))
 
-const struct uniphier_clk_data uniphier_sld3_sys_clk_data[] = {
-	UNIPHIER_CLK_FACTOR("spll", -1, "ref", 65, 1),		/* 1597.44 MHz */
-	UNIPHIER_CLK_FACTOR("upll", -1, "ref", 6000, 512),	/* 288 MHz */
-	UNIPHIER_CLK_FACTOR("a2pll", -1, "ref", 24, 1),		/* 589.824 MHz */
-	UNIPHIER_CLK_FACTOR("vpll27a", -1, "ref", 5625, 512),	/* 270 MHz */
-	UNIPHIER_CLK_FACTOR("uart", 0, "a2pll", 1, 16),
-	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 16),
-	UNIPHIER_SLD3_SYS_CLK_NAND(2),
-	UNIPHIER_SLD3_SYS_CLK_SD,
-	UNIPHIER_CLK_FACTOR("usb2", -1, "upll", 1, 12),
-	UNIPHIER_SLD3_SYS_CLK_STDMAC(8),
-	{ /* sentinel */ }
-};
-
 const struct uniphier_clk_data uniphier_ld4_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("spll", -1, "ref", 65, 1),		/* 1597.44 MHz */
 	UNIPHIER_CLK_FACTOR("upll", -1, "ref", 6000, 512),	/* 288 MHz */
@@ -78,10 +64,10 @@ const struct uniphier_clk_data uniphier_ld4_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("vpll27a", -1, "ref", 5625, 512),	/* 270 MHz */
 	UNIPHIER_CLK_FACTOR("uart", 0, "a2pll", 1, 16),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 16),
-	UNIPHIER_SLD3_SYS_CLK_NAND(2),
-	UNIPHIER_SLD3_SYS_CLK_SD,
+	UNIPHIER_LD4_SYS_CLK_NAND(2),
+	UNIPHIER_LD4_SYS_CLK_SD,
 	UNIPHIER_CLK_FACTOR("usb2", -1, "upll", 1, 12),
-	UNIPHIER_SLD3_SYS_CLK_STDMAC(8),		/* Ether, HSC, MIO */
+	UNIPHIER_LD4_SYS_CLK_STDMAC(8),			/* Ether, HSC, MIO */
 	{ /* sentinel */ }
 };
 
@@ -92,10 +78,10 @@ const struct uniphier_clk_data uniphier_pro4_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("vpll27a", -1, "ref", 270, 25),	/* 270 MHz */
 	UNIPHIER_CLK_FACTOR("uart", 0, "a2pll", 1, 8),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 32),
-	UNIPHIER_SLD3_SYS_CLK_NAND(2),
-	UNIPHIER_SLD3_SYS_CLK_SD,
+	UNIPHIER_LD4_SYS_CLK_NAND(2),
+	UNIPHIER_LD4_SYS_CLK_SD,
 	UNIPHIER_CLK_FACTOR("usb2", -1, "upll", 1, 12),
-	UNIPHIER_SLD3_SYS_CLK_STDMAC(8),		/* HSC, MIO, RLE */
+	UNIPHIER_LD4_SYS_CLK_STDMAC(8),			/* HSC, MIO, RLE */
 	UNIPHIER_PRO4_SYS_CLK_GIO(12),			/* Ether, SATA, USB3 */
 	UNIPHIER_PRO4_SYS_CLK_USB3(14, 0),
 	UNIPHIER_PRO4_SYS_CLK_USB3(15, 1),
@@ -108,10 +94,10 @@ const struct uniphier_clk_data uniphier_sld8_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("vpll27a", -1, "ref", 270, 25),	/* 270 MHz */
 	UNIPHIER_CLK_FACTOR("uart", 0, "spll", 1, 20),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 16),
-	UNIPHIER_SLD3_SYS_CLK_NAND(2),
-	UNIPHIER_SLD3_SYS_CLK_SD,
+	UNIPHIER_LD4_SYS_CLK_NAND(2),
+	UNIPHIER_LD4_SYS_CLK_SD,
 	UNIPHIER_CLK_FACTOR("usb2", -1, "upll", 1, 12),
-	UNIPHIER_SLD3_SYS_CLK_STDMAC(8),		/* Ether, HSC, MIO */
+	UNIPHIER_LD4_SYS_CLK_STDMAC(8),			/* Ether, HSC, MIO */
 	{ /* sentinel */ }
 };
 
@@ -123,7 +109,7 @@ const struct uniphier_clk_data uniphier_pro5_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 48),
 	UNIPHIER_PRO5_SYS_CLK_NAND(2),
 	UNIPHIER_PRO5_SYS_CLK_SD,
-	UNIPHIER_SLD3_SYS_CLK_STDMAC(8),			/* HSC */
+	UNIPHIER_LD4_SYS_CLK_STDMAC(8),				/* HSC */
 	UNIPHIER_PRO4_SYS_CLK_GIO(12),				/* PCIe, USB3 */
 	UNIPHIER_PRO4_SYS_CLK_USB3(14, 0),
 	UNIPHIER_PRO4_SYS_CLK_USB3(15, 1),
@@ -136,7 +122,7 @@ const struct uniphier_clk_data uniphier_pxs2_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 48),
 	UNIPHIER_PRO5_SYS_CLK_NAND(2),
 	UNIPHIER_PRO5_SYS_CLK_SD,
-	UNIPHIER_SLD3_SYS_CLK_STDMAC(8),			/* HSC, RLE */
+	UNIPHIER_LD4_SYS_CLK_STDMAC(8),				/* HSC, RLE */
 	/* GIO is always clock-enabled: no function for 0x2104 bit6 */
 	UNIPHIER_PRO4_SYS_CLK_USB3(14, 0),
 	UNIPHIER_PRO4_SYS_CLK_USB3(15, 1),
diff --git a/drivers/clk/uniphier/clk-uniphier.h b/drivers/clk/uniphier/clk-uniphier.h
index 01c16ecec48f..827164093172 100644
--- a/drivers/clk/uniphier/clk-uniphier.h
+++ b/drivers/clk/uniphier/clk-uniphier.h
@@ -147,7 +147,6 @@ struct clk_hw *uniphier_clk_register_mux(struct device *dev,
 					 const char *name,
 				const struct uniphier_clk_mux_data *data);
 
-extern const struct uniphier_clk_data uniphier_sld3_sys_clk_data[];
 extern const struct uniphier_clk_data uniphier_ld4_sys_clk_data[];
 extern const struct uniphier_clk_data uniphier_pro4_sys_clk_data[];
 extern const struct uniphier_clk_data uniphier_sld8_sys_clk_data[];
@@ -155,7 +154,7 @@ extern const struct uniphier_clk_data uniphier_pro5_sys_clk_data[];
 extern const struct uniphier_clk_data uniphier_pxs2_sys_clk_data[];
 extern const struct uniphier_clk_data uniphier_ld11_sys_clk_data[];
 extern const struct uniphier_clk_data uniphier_ld20_sys_clk_data[];
-extern const struct uniphier_clk_data uniphier_sld3_mio_clk_data[];
+extern const struct uniphier_clk_data uniphier_ld4_mio_clk_data[];
 extern const struct uniphier_clk_data uniphier_pro5_sd_clk_data[];
 extern const struct uniphier_clk_data uniphier_ld4_peri_clk_data[];
 extern const struct uniphier_clk_data uniphier_pro4_peri_clk_data[];
-- 
2.7.4
