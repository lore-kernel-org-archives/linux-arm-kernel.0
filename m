From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 31 Aug 2017 21:03:36 +0900
Subject: [PATCH] clk: uniphier: add PXs3 clock data
Message-ID: <1504181016-16457-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add basic clock data for Socionext's new SoC PXs3.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

I confirmed this patch can be cleanly applied on clk-next branch
(commit 69a6beab085264)


 .../devicetree/bindings/clock/uniphier-clock.txt   |  3 +++
 drivers/clk/uniphier/clk-uniphier-core.c           | 12 +++++++++
 drivers/clk/uniphier/clk-uniphier-sys.c            | 30 ++++++++++++++++++++++
 drivers/clk/uniphier/clk-uniphier.h                |  1 +
 4 files changed, 46 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/uniphier-clock.txt b/Documentation/devicetree/bindings/clock/uniphier-clock.txt
index 2aec32d..7b5f602 100644
--- a/Documentation/devicetree/bindings/clock/uniphier-clock.txt
+++ b/Documentation/devicetree/bindings/clock/uniphier-clock.txt
@@ -13,6 +13,7 @@ Required properties:
     "socionext,uniphier-pxs2-clock" - for PXs2/LD6b SoC.
     "socionext,uniphier-ld11-clock" - for LD11 SoC.
     "socionext,uniphier-ld20-clock" - for LD20 SoC.
+    "socionext,uniphier-pxs3-clock" - for PXs3 SoC
 - #clock-cells: should be 1.
 
 Example:
@@ -54,6 +55,7 @@ Required properties:
     "socionext,uniphier-pxs2-sd-clock"  - for PXs2/LD6b SoC.
     "socionext,uniphier-ld11-mio-clock" - for LD11 SoC.
     "socionext,uniphier-ld20-sd-clock"  - for LD20 SoC.
+    "socionext,uniphier-pxs3-sd-clock"  - for PXs3 SoC
 - #clock-cells: should be 1.
 
 Example:
@@ -97,6 +99,7 @@ Required properties:
     "socionext,uniphier-pxs2-peri-clock" - for PXs2/LD6b SoC.
     "socionext,uniphier-ld11-peri-clock" - for LD11 SoC.
     "socionext,uniphier-ld20-peri-clock" - for LD20 SoC.
+    "socionext,uniphier-pxs3-peri-clock" - for PXs3 SoC
 - #clock-cells: should be 1.
 
 Example:
diff --git a/drivers/clk/uniphier/clk-uniphier-core.c b/drivers/clk/uniphier/clk-uniphier-core.c
index cb6ae26..e09f3dd46 100644
--- a/drivers/clk/uniphier/clk-uniphier-core.c
+++ b/drivers/clk/uniphier/clk-uniphier-core.c
@@ -138,6 +138,10 @@ static const struct of_device_id uniphier_clk_match[] = {
 		.compatible = "socionext,uniphier-ld20-clock",
 		.data = uniphier_ld20_sys_clk_data,
 	},
+	{
+		.compatible = "socionext,uniphier-pxs3-clock",
+		.data = uniphier_pxs3_sys_clk_data,
+	},
 	/* Media I/O clock, SD clock */
 	{
 		.compatible = "socionext,uniphier-ld4-mio-clock",
@@ -167,6 +171,10 @@ static const struct of_device_id uniphier_clk_match[] = {
 		.compatible = "socionext,uniphier-ld20-sd-clock",
 		.data = uniphier_pro5_sd_clk_data,
 	},
+	{
+		.compatible = "socionext,uniphier-pxs3-sd-clock",
+		.data = uniphier_pro5_sd_clk_data,
+	},
 	/* Peripheral clock */
 	{
 		.compatible = "socionext,uniphier-ld4-peri-clock",
@@ -196,6 +204,10 @@ static const struct of_device_id uniphier_clk_match[] = {
 		.compatible = "socionext,uniphier-ld20-peri-clock",
 		.data = uniphier_pro4_peri_clk_data,
 	},
+	{
+		.compatible = "socionext,uniphier-pxs3-peri-clock",
+		.data = uniphier_pro4_peri_clk_data,
+	},
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/clk/uniphier/clk-uniphier-sys.c b/drivers/clk/uniphier/clk-uniphier-sys.c
index 6fcf781..7e77b09 100644
--- a/drivers/clk/uniphier/clk-uniphier-sys.c
+++ b/drivers/clk/uniphier/clk-uniphier-sys.c
@@ -195,3 +195,33 @@ const struct uniphier_clk_data uniphier_ld20_sys_clk_data[] = {
 			     "spll/4", "spll/8", "s2pll/4", "s2pll/8"),
 	{ /* sentinel */ }
 };
+
+const struct uniphier_clk_data uniphier_pxs3_sys_clk_data[] = {
+	UNIPHIER_CLK_FACTOR("cpll", -1, "ref", 104, 1),		/* ARM: 2600 MHz */
+	UNIPHIER_CLK_FACTOR("spll", -1, "ref", 80, 1),		/* 2000 MHz */
+	UNIPHIER_CLK_FACTOR("s2pll", -1, "ref", 88, 1),		/* IPP: 2400 MHz */
+	UNIPHIER_CLK_FACTOR("uart", 0, "spll", 1, 34),
+	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 40),
+	UNIPHIER_LD20_SYS_CLK_SD,
+	UNIPHIER_LD11_SYS_CLK_NAND(2),
+	UNIPHIER_LD11_SYS_CLK_EMMC(4),
+	UNIPHIER_CLK_GATE("usb30", 12, NULL, 0x2104, 4),	/* =GIO0 */
+	UNIPHIER_CLK_GATE("usb31-0", 13, NULL, 0x2104, 5),	/* =GIO1 */
+	UNIPHIER_CLK_GATE("usb31-1", 14, NULL, 0x2104, 6),	/* =GIO1-1 */
+	UNIPHIER_CLK_GATE("usb30-phy0", 16, NULL, 0x210c, 16),
+	UNIPHIER_CLK_GATE("usb30-phy1", 17, NULL, 0x210c, 18),
+	UNIPHIER_CLK_GATE("usb30-phy2", 18, NULL, 0x210c, 20),
+	UNIPHIER_CLK_GATE("usb31-phy0", 20, NULL, 0x210c, 17),
+	UNIPHIER_CLK_GATE("usb31-phy1", 21, NULL, 0x210c, 19),
+	/* CPU gears */
+	UNIPHIER_CLK_DIV4("cpll", 2, 3, 4, 8),
+	UNIPHIER_CLK_DIV4("spll", 2, 3, 4, 8),
+	UNIPHIER_CLK_DIV4("s2pll", 2, 3, 4, 8),
+	UNIPHIER_CLK_CPUGEAR("cpu-ca53", 33, 0x8080, 0xf, 8,
+			     "cpll/2", "spll/2", "cpll/3", "spll/3",
+			     "spll/4", "spll/8", "cpll/4", "cpll/8"),
+	UNIPHIER_CLK_CPUGEAR("cpu-ipp", 34, 0x8100, 0xf, 8,
+			     "s2pll/2", "spll/2", "s2pll/3", "spll/3",
+			     "spll/4", "spll/8", "s2pll/4", "s2pll/8"),
+	{ /* sentinel */ }
+};
diff --git a/drivers/clk/uniphier/clk-uniphier.h b/drivers/clk/uniphier/clk-uniphier.h
index 8271640..d10a009 100644
--- a/drivers/clk/uniphier/clk-uniphier.h
+++ b/drivers/clk/uniphier/clk-uniphier.h
@@ -154,6 +154,7 @@ extern const struct uniphier_clk_data uniphier_pro5_sys_clk_data[];
 extern const struct uniphier_clk_data uniphier_pxs2_sys_clk_data[];
 extern const struct uniphier_clk_data uniphier_ld11_sys_clk_data[];
 extern const struct uniphier_clk_data uniphier_ld20_sys_clk_data[];
+extern const struct uniphier_clk_data uniphier_pxs3_sys_clk_data[];
 extern const struct uniphier_clk_data uniphier_ld4_mio_clk_data[];
 extern const struct uniphier_clk_data uniphier_pro5_sd_clk_data[];
 extern const struct uniphier_clk_data uniphier_ld4_peri_clk_data[];
-- 
2.7.4
