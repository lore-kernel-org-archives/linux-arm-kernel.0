From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Tue, 10 Jul 2018 10:00:59 +0200
Subject: [PATCH v5 07/22] drivers: soc: sunxi: Add support for the C1 SRAM
 region
In-Reply-To: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
Message-ID: <20180710080114.31469-8-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

This introduces support for the SRAM C1 section, that is controlled by
the system controller. This SRAM area can be muxed either to the CPU
or the Video Engine, that needs this area to store various tables (e.g.
the Huffman VLD decoding tables).

This only supports devices with the same layout as the A10 (which also
includes the A13, A20, A33 and other SoCs).

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/soc/sunxi/sunxi_sram.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index 236f34307c0f..b19fa2cc67c2 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -64,6 +64,12 @@ static struct sunxi_sram_desc sun4i_a10_sram_a3_a4 = {
 				  SUNXI_SRAM_MAP(1, 1, "emac")),
 };
 
+static struct sunxi_sram_desc sun4i_a10_sram_c1 = {
+	.data	= SUNXI_SRAM_DATA("C1", 0x0, 0x0, 31,
+				  SUNXI_SRAM_MAP(0, 0, "cpu"),
+				  SUNXI_SRAM_MAP(0x7fffffff, 1, "ve")),
+};
+
 static struct sunxi_sram_desc sun4i_a10_sram_d = {
 	.data	= SUNXI_SRAM_DATA("D", 0x4, 0x0, 1,
 				  SUNXI_SRAM_MAP(0, 0, "cpu"),
@@ -81,6 +87,10 @@ static const struct of_device_id sunxi_sram_dt_ids[] = {
 		.compatible	= "allwinner,sun4i-a10-sram-a3-a4",
 		.data		= &sun4i_a10_sram_a3_a4.data,
 	},
+	{
+		.compatible	= "allwinner,sun4i-a10-sram-c1",
+		.data		= &sun4i_a10_sram_c1.data,
+	},
 	{
 		.compatible	= "allwinner,sun4i-a10-sram-d",
 		.data		= &sun4i_a10_sram_d.data,
-- 
2.17.1
