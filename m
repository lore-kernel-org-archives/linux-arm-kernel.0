From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 21 Jun 2017 00:06:03 +0900
Subject: [PATCH] clk: uniphier: provide NAND controller clock rate
Message-ID: <1497971163-9206-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows the NAND driver to get the clock rate via clk_get_rate().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/clk/uniphier/clk-uniphier-sys.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/uniphier/clk-uniphier-sys.c b/drivers/clk/uniphier/clk-uniphier-sys.c
index c8027d9..ad02181 100644
--- a/drivers/clk/uniphier/clk-uniphier-sys.c
+++ b/drivers/clk/uniphier/clk-uniphier-sys.c
@@ -29,11 +29,18 @@
 	UNIPHIER_CLK_FACTOR("sd-200m", -1, "spll", 1, 10),		\
 	UNIPHIER_CLK_FACTOR("sd-133m", -1, "spll", 1, 15)
 
+/* Denali driver requires clk_x rate (clk: 50MHz, clk_x & ecc_clk: 200MHz) */
 #define UNIPHIER_SLD3_SYS_CLK_NAND(idx)					\
-	UNIPHIER_CLK_GATE("nand", (idx), NULL, 0x2104, 2)
+	UNIPHIER_CLK_FACTOR("nand-200m", -1, "spll", 1, 8),		\
+	UNIPHIER_CLK_GATE("nand", (idx), "nand-200m", 0x2104, 2)
+
+#define UNIPHIER_PRO5_SYS_CLK_NAND(idx)					\
+	UNIPHIER_CLK_FACTOR("nand-200m", -1, "spll", 1, 12),		\
+	UNIPHIER_CLK_GATE("nand", (idx), "nand-200m", 0x2104, 2)
 
 #define UNIPHIER_LD11_SYS_CLK_NAND(idx)					\
-	UNIPHIER_CLK_GATE("nand", (idx), NULL, 0x210c, 0)
+	UNIPHIER_CLK_FACTOR("nand-200m", -1, "spll", 1, 10),		\
+	UNIPHIER_CLK_GATE("nand", (idx), "nand-200m", 0x210c, 0)
 
 #define UNIPHIER_LD11_SYS_CLK_EMMC(idx)					\
 	UNIPHIER_CLK_GATE("emmc", (idx), NULL, 0x210c, 2)
@@ -114,7 +121,7 @@ const struct uniphier_clk_data uniphier_pro5_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("dapll2", -1, "ref", 144, 125),	/* 2949.12 MHz */
 	UNIPHIER_CLK_FACTOR("uart", 0, "dapll2", 1, 40),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 48),
-	UNIPHIER_SLD3_SYS_CLK_NAND(2),
+	UNIPHIER_PRO5_SYS_CLK_NAND(2),
 	UNIPHIER_PRO5_SYS_CLK_SD,
 	UNIPHIER_SLD3_SYS_CLK_STDMAC(8),			/* HSC */
 	UNIPHIER_PRO4_SYS_CLK_GIO(12),				/* PCIe, USB3 */
@@ -127,7 +134,7 @@ const struct uniphier_clk_data uniphier_pxs2_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("spll", -1, "ref", 96, 1),		/* 2400 MHz */
 	UNIPHIER_CLK_FACTOR("uart", 0, "spll", 1, 27),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 48),
-	UNIPHIER_SLD3_SYS_CLK_NAND(2),
+	UNIPHIER_PRO5_SYS_CLK_NAND(2),
 	UNIPHIER_PRO5_SYS_CLK_SD,
 	UNIPHIER_SLD3_SYS_CLK_STDMAC(8),			/* HSC, RLE */
 	/* GIO is always clock-enabled: no function for 0x2104 bit6 */
-- 
2.7.4
