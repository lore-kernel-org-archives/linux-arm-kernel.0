From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 20 Jul 2018 17:37:35 +0900
Subject: [PATCH 1/2] clk: uniphier: add NAND 200MHz clock
Message-ID: <1532075856-1723-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Denali NAND controller IP needs three clocks:

 - clk: controller core clock

 - clk_x: bus interface clock

 - ecc_clk: clock at which ECC circuitry is run

Currently, only the first one (50MHz) is provided.  The rest of the
two clock ports must be connected to the 200MHz clock line.  Add this.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/clk/uniphier/clk-uniphier-sys.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/uniphier/clk-uniphier-sys.c b/drivers/clk/uniphier/clk-uniphier-sys.c
index 4f5ff9f..a582446 100644
--- a/drivers/clk/uniphier/clk-uniphier-sys.c
+++ b/drivers/clk/uniphier/clk-uniphier-sys.c
@@ -29,18 +29,20 @@
 	UNIPHIER_CLK_FACTOR("sd-200m", -1, "spll", 1, 10),		\
 	UNIPHIER_CLK_FACTOR("sd-133m", -1, "spll", 1, 15)
 
-/* Denali driver requires clk_x rate (clk: 50MHz, clk_x & ecc_clk: 200MHz) */
 #define UNIPHIER_LD4_SYS_CLK_NAND(idx)					\
-	UNIPHIER_CLK_FACTOR("nand-200m", -1, "spll", 1, 8),		\
-	UNIPHIER_CLK_GATE("nand", (idx), "nand-200m", 0x2104, 2)
+	UNIPHIER_CLK_FACTOR("nand-50m", -1, "spll", 1, 32),		\
+	UNIPHIER_CLK_GATE("nand", (idx), "nand-50m", 0x2104, 2)
 
 #define UNIPHIER_PRO5_SYS_CLK_NAND(idx)					\
-	UNIPHIER_CLK_FACTOR("nand-200m", -1, "spll", 1, 12),		\
-	UNIPHIER_CLK_GATE("nand", (idx), "nand-200m", 0x2104, 2)
+	UNIPHIER_CLK_FACTOR("nand-50m", -1, "spll", 1, 48),		\
+	UNIPHIER_CLK_GATE("nand", (idx), "nand-50m", 0x2104, 2)
 
 #define UNIPHIER_LD11_SYS_CLK_NAND(idx)					\
-	UNIPHIER_CLK_FACTOR("nand-200m", -1, "spll", 1, 10),		\
-	UNIPHIER_CLK_GATE("nand", (idx), "nand-200m", 0x210c, 0)
+	UNIPHIER_CLK_FACTOR("nand-50m", -1, "spll", 1, 40),		\
+	UNIPHIER_CLK_GATE("nand", (idx), "nand-50m", 0x210c, 0)
+
+#define UNIPHIER_SYS_CLK_NAND_4X(idx)					\
+	UNIPHIER_CLK_FACTOR("nand-4x", (idx), "nand", 4, 1)
 
 #define UNIPHIER_LD11_SYS_CLK_EMMC(idx)					\
 	UNIPHIER_CLK_GATE("emmc", (idx), NULL, 0x210c, 2)
@@ -94,6 +96,7 @@ const struct uniphier_clk_data uniphier_ld4_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("uart", 0, "a2pll", 1, 16),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 16),
 	UNIPHIER_LD4_SYS_CLK_NAND(2),
+	UNIPHIER_SYS_CLK_NAND_4X(3),
 	UNIPHIER_LD4_SYS_CLK_SD,
 	UNIPHIER_CLK_FACTOR("usb2", -1, "upll", 1, 12),
 	UNIPHIER_LD4_SYS_CLK_STDMAC(8),			/* Ether, HSC, MIO */
@@ -109,6 +112,7 @@ const struct uniphier_clk_data uniphier_pro4_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("uart", 0, "a2pll", 1, 8),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 32),
 	UNIPHIER_LD4_SYS_CLK_NAND(2),
+	UNIPHIER_SYS_CLK_NAND_4X(3),
 	UNIPHIER_LD4_SYS_CLK_SD,
 	UNIPHIER_CLK_FACTOR("usb2", -1, "upll", 1, 12),
 	UNIPHIER_PRO4_SYS_CLK_ETHER(6),
@@ -131,6 +135,7 @@ const struct uniphier_clk_data uniphier_sld8_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("uart", 0, "spll", 1, 20),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 16),
 	UNIPHIER_LD4_SYS_CLK_NAND(2),
+	UNIPHIER_SYS_CLK_NAND_4X(3),
 	UNIPHIER_LD4_SYS_CLK_SD,
 	UNIPHIER_CLK_FACTOR("usb2", -1, "upll", 1, 12),
 	UNIPHIER_LD4_SYS_CLK_STDMAC(8),			/* Ether, HSC, MIO */
@@ -144,6 +149,7 @@ const struct uniphier_clk_data uniphier_pro5_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("uart", 0, "dapll2", 1, 40),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 48),
 	UNIPHIER_PRO5_SYS_CLK_NAND(2),
+	UNIPHIER_SYS_CLK_NAND_4X(3),
 	UNIPHIER_PRO5_SYS_CLK_SD,
 	UNIPHIER_LD4_SYS_CLK_STDMAC(8),				/* HSC */
 	UNIPHIER_PRO4_SYS_CLK_GIO(12),				/* PCIe, USB3 */
@@ -159,6 +165,7 @@ const struct uniphier_clk_data uniphier_pxs2_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("uart", 0, "spll", 1, 27),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 48),
 	UNIPHIER_PRO5_SYS_CLK_NAND(2),
+	UNIPHIER_SYS_CLK_NAND_4X(3),
 	UNIPHIER_PRO5_SYS_CLK_SD,
 	UNIPHIER_PRO4_SYS_CLK_ETHER(6),
 	UNIPHIER_LD4_SYS_CLK_STDMAC(8),				/* HSC, RLE */
@@ -181,6 +188,7 @@ const struct uniphier_clk_data uniphier_ld11_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("uart", 0, "spll", 1, 34),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 40),
 	UNIPHIER_LD11_SYS_CLK_NAND(2),
+	UNIPHIER_SYS_CLK_NAND_4X(3),
 	UNIPHIER_LD11_SYS_CLK_EMMC(4),
 	/* Index 5 reserved for eMMC PHY */
 	UNIPHIER_LD11_SYS_CLK_ETHER(6),
@@ -214,6 +222,7 @@ const struct uniphier_clk_data uniphier_ld20_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("uart", 0, "spll", 1, 34),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 40),
 	UNIPHIER_LD11_SYS_CLK_NAND(2),
+	UNIPHIER_SYS_CLK_NAND_4X(3),
 	UNIPHIER_LD11_SYS_CLK_EMMC(4),
 	/* Index 5 reserved for eMMC PHY */
 	UNIPHIER_LD20_SYS_CLK_SD,
@@ -256,6 +265,7 @@ const struct uniphier_clk_data uniphier_pxs3_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 40),
 	UNIPHIER_LD20_SYS_CLK_SD,
 	UNIPHIER_LD11_SYS_CLK_NAND(2),
+	UNIPHIER_SYS_CLK_NAND_4X(3),
 	UNIPHIER_LD11_SYS_CLK_EMMC(4),
 	UNIPHIER_CLK_GATE("ether0", 6, NULL, 0x210c, 9),
 	UNIPHIER_CLK_GATE("ether1", 7, NULL, 0x210c, 10),
-- 
2.7.4
