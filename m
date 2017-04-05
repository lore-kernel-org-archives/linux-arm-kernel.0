From: guochun.mao@mediatek.com (Guochun Mao)
Date: Wed, 5 Apr 2017 16:37:42 +0800
Subject: [PATCH v1 1/1] mtd: mtk-nor: set controller's address width according
 to nor flash
In-Reply-To: <1491381462-21893-1-git-send-email-guochun.mao@mediatek.com>
References: <1491381462-21893-1-git-send-email-guochun.mao@mediatek.com>
Message-ID: <1491381462-21893-2-git-send-email-guochun.mao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When nor's size larger than 16MByte, nor's address width maybe
set to 3 or 4, and controller should change address width according
to nor's setting.

Signed-off-by: Guochun Mao <guochun.mao@mediatek.com>
---
 drivers/mtd/spi-nor/mtk-quadspi.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/mtd/spi-nor/mtk-quadspi.c b/drivers/mtd/spi-nor/mtk-quadspi.c
index e661877..b637770 100644
--- a/drivers/mtd/spi-nor/mtk-quadspi.c
+++ b/drivers/mtd/spi-nor/mtk-quadspi.c
@@ -104,6 +104,8 @@
 #define MTK_NOR_MAX_RX_TX_SHIFT		6
 /* can shift up to 56 bits (7 bytes) transfer by MTK_NOR_PRG_CMD */
 #define MTK_NOR_MAX_SHIFT		7
+/* nor controller 4-byte address mode enable bit */
+#define MTK_NOR_4B_ADDR_EN		BIT(4)
 
 /* Helpers for accessing the program data / shift data registers */
 #define MTK_NOR_PRG_REG(n)		(MTK_NOR_PRGDATA0_REG + 4 * (n))
@@ -230,10 +232,35 @@ static int mt8173_nor_write_buffer_disable(struct mt8173_nor *mt8173_nor)
 				  10000);
 }
 
+static void mt8173_nor_set_addr_width(struct mt8173_nor *mt8173_nor)
+{
+	u8 val;
+	struct spi_nor *nor = &mt8173_nor->nor;
+
+	val = readb(mt8173_nor->base + MTK_NOR_DUAL_REG);
+
+	switch (nor->addr_width) {
+	case 3:
+		val &= ~MTK_NOR_4B_ADDR_EN;
+		break;
+	case 4:
+		val |= MTK_NOR_4B_ADDR_EN;
+		break;
+	default:
+		dev_warn(mt8173_nor->dev, "Unexpected address width %u.\n",
+			 nor->addr_width);
+		break;
+	}
+
+	writeb(val, mt8173_nor->base + MTK_NOR_DUAL_REG);
+}
+
 static void mt8173_nor_set_addr(struct mt8173_nor *mt8173_nor, u32 addr)
 {
 	int i;
 
+	mt8173_nor_set_addr_width(mt8173_nor);
+
 	for (i = 0; i < 3; i++) {
 		writeb(addr & 0xff, mt8173_nor->base + MTK_NOR_RADR0_REG + i * 4);
 		addr >>= 8;
-- 
1.7.9.5
