From: hayashibara.keiji@socionext.com (Keiji Hayashibara)
Date: Thu, 19 Jul 2018 14:23:48 +0900
Subject: [PATCH] clk: uniphier: add clock frequency support for SPI
Message-ID: <1531977828-8276-1-git-send-email-hayashibara.keiji@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Add clock control for SPI controller on UniPhier SoCs.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---
 drivers/clk/uniphier/clk-uniphier-peri.c | 9 +++++++++
 drivers/clk/uniphier/clk-uniphier-sys.c  | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/clk/uniphier/clk-uniphier-peri.c b/drivers/clk/uniphier/clk-uniphier-peri.c
index 521c80e..89b3ac3 100644
--- a/drivers/clk/uniphier/clk-uniphier-peri.c
+++ b/drivers/clk/uniphier/clk-uniphier-peri.c
@@ -27,6 +27,12 @@
 #define UNIPHIER_PERI_CLK_FI2C(idx, ch)					\
 	UNIPHIER_CLK_GATE("i2c" #ch, (idx), "i2c", 0x24, 24 + (ch))
 
+#define UNIPHIER_PERI_CLK_SCSSI(idx)					\
+	UNIPHIER_CLK_GATE("scssi", (idx), "spi", 0x20, 17)
+
+#define UNIPHIER_PERI_CLK_MCSSI(idx)					\
+	UNIPHIER_CLK_GATE("mcssi", (idx), "spi", 0x24, 14)
+
 const struct uniphier_clk_data uniphier_ld4_peri_clk_data[] = {
 	UNIPHIER_PERI_CLK_UART(0, 0),
 	UNIPHIER_PERI_CLK_UART(1, 1),
@@ -38,6 +44,7 @@ const struct uniphier_clk_data uniphier_ld4_peri_clk_data[] = {
 	UNIPHIER_PERI_CLK_I2C(6, 2),
 	UNIPHIER_PERI_CLK_I2C(7, 3),
 	UNIPHIER_PERI_CLK_I2C(8, 4),
+	UNIPHIER_PERI_CLK_SCSSI(11),
 	{ /* sentinel */ }
 };
 
@@ -53,5 +60,7 @@ const struct uniphier_clk_data uniphier_pro4_peri_clk_data[] = {
 	UNIPHIER_PERI_CLK_FI2C(8, 4),
 	UNIPHIER_PERI_CLK_FI2C(9, 5),
 	UNIPHIER_PERI_CLK_FI2C(10, 6),
+	UNIPHIER_PERI_CLK_SCSSI(11),
+	UNIPHIER_PERI_CLK_MCSSI(12),
 	{ /* sentinel */ }
 };
diff --git a/drivers/clk/uniphier/clk-uniphier-sys.c b/drivers/clk/uniphier/clk-uniphier-sys.c
index 4f5ff9f..a2c3c10 100644
--- a/drivers/clk/uniphier/clk-uniphier-sys.c
+++ b/drivers/clk/uniphier/clk-uniphier-sys.c
@@ -93,6 +93,7 @@ const struct uniphier_clk_data uniphier_ld4_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("vpll27a", -1, "ref", 5625, 512),	/* 270 MHz */
 	UNIPHIER_CLK_FACTOR("uart", 0, "a2pll", 1, 16),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 16),
+	UNIPHIER_CLK_FACTOR("spi", -1, "spll", 1, 32),
 	UNIPHIER_LD4_SYS_CLK_NAND(2),
 	UNIPHIER_LD4_SYS_CLK_SD,
 	UNIPHIER_CLK_FACTOR("usb2", -1, "upll", 1, 12),
@@ -108,6 +109,7 @@ const struct uniphier_clk_data uniphier_pro4_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("gpll", -1, "ref", 10, 1),		/* 250 MHz */
 	UNIPHIER_CLK_FACTOR("uart", 0, "a2pll", 1, 8),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 32),
+	UNIPHIER_CLK_FACTOR("spi", 1, "spll", 1, 32),
 	UNIPHIER_LD4_SYS_CLK_NAND(2),
 	UNIPHIER_LD4_SYS_CLK_SD,
 	UNIPHIER_CLK_FACTOR("usb2", -1, "upll", 1, 12),
@@ -130,6 +132,7 @@ const struct uniphier_clk_data uniphier_sld8_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("vpll27a", -1, "ref", 270, 25),	/* 270 MHz */
 	UNIPHIER_CLK_FACTOR("uart", 0, "spll", 1, 20),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 16),
+	UNIPHIER_CLK_FACTOR("spi", -1, "spll", 1, 32),
 	UNIPHIER_LD4_SYS_CLK_NAND(2),
 	UNIPHIER_LD4_SYS_CLK_SD,
 	UNIPHIER_CLK_FACTOR("usb2", -1, "upll", 1, 12),
@@ -143,6 +146,7 @@ const struct uniphier_clk_data uniphier_pro5_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("dapll2", -1, "dapll1", 144, 125),	/* 2949.12 MHz */
 	UNIPHIER_CLK_FACTOR("uart", 0, "dapll2", 1, 40),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 48),
+	UNIPHIER_CLK_FACTOR("spi", -1, "spll", 1, 48),
 	UNIPHIER_PRO5_SYS_CLK_NAND(2),
 	UNIPHIER_PRO5_SYS_CLK_SD,
 	UNIPHIER_LD4_SYS_CLK_STDMAC(8),				/* HSC */
@@ -158,6 +162,7 @@ const struct uniphier_clk_data uniphier_pxs2_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("spll", -1, "ref", 96, 1),		/* 2400 MHz */
 	UNIPHIER_CLK_FACTOR("uart", 0, "spll", 1, 27),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 48),
+	UNIPHIER_CLK_FACTOR("spi", -1, "spll", 1, 48),
 	UNIPHIER_PRO5_SYS_CLK_NAND(2),
 	UNIPHIER_PRO5_SYS_CLK_SD,
 	UNIPHIER_PRO4_SYS_CLK_ETHER(6),
@@ -180,6 +185,7 @@ const struct uniphier_clk_data uniphier_ld11_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("vspll", -1, "ref", 80, 1),		/* 2000 MHz */
 	UNIPHIER_CLK_FACTOR("uart", 0, "spll", 1, 34),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 40),
+	UNIPHIER_CLK_FACTOR("spi", -1, "spll", 1, 40),
 	UNIPHIER_LD11_SYS_CLK_NAND(2),
 	UNIPHIER_LD11_SYS_CLK_EMMC(4),
 	/* Index 5 reserved for eMMC PHY */
@@ -213,6 +219,7 @@ const struct uniphier_clk_data uniphier_ld20_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("vppll", -1, "ref", 504, 5),	/* 2520 MHz */
 	UNIPHIER_CLK_FACTOR("uart", 0, "spll", 1, 34),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 40),
+	UNIPHIER_CLK_FACTOR("spi", -1, "spll", 1, 40),
 	UNIPHIER_LD11_SYS_CLK_NAND(2),
 	UNIPHIER_LD11_SYS_CLK_EMMC(4),
 	/* Index 5 reserved for eMMC PHY */
@@ -254,6 +261,7 @@ const struct uniphier_clk_data uniphier_pxs3_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("s2pll", -1, "ref", 88, 1),		/* IPP: 2400 MHz */
 	UNIPHIER_CLK_FACTOR("uart", 0, "spll", 1, 34),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 40),
+	UNIPHIER_CLK_FACTOR("spi", -1, "spll", 1, 40),
 	UNIPHIER_LD20_SYS_CLK_SD,
 	UNIPHIER_LD11_SYS_CLK_NAND(2),
 	UNIPHIER_LD11_SYS_CLK_EMMC(4),
-- 
2.7.4
