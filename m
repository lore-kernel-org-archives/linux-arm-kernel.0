From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 16 Feb 2015 13:51:11 +0100
Subject: [PATCH v3 1/2] mtd: nand: pxa3xx: Fix PIO FIFO draining
In-Reply-To: <1424091072-7738-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1424091072-7738-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1424091072-7738-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NDDB register holds the data that are needed by the read and write
commands.

However, during a read PIO access, the datasheet specifies that after each 32
bits read in that register, when BCH is enabled, we have to make sure that the
RDDREQ bit is set in the NDSR register.

This fixes an issue that was seen on the Armada 385, and presumably other mvebu
SoCs, when a read on a newly erased page would end up in the driver reporting a
timeout from the NAND.

Cc: <stable@vger.kernel.org> # v3.14
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/mtd/nand/pxa3xx_nand.c | 47 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 96b0b1d27df1..b2d8d6960765 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -480,6 +480,41 @@ static void disable_int(struct pxa3xx_nand_info *info, uint32_t int_mask)
 	nand_writel(info, NDCR, ndcr | int_mask);
 }
 
+static void drain_fifo(struct pxa3xx_nand_info *info, void *data, int len)
+{
+	if (info->ecc_bch) {
+		int index = 0;
+
+		while (index < (len * 4)) {
+			u32 timeout;
+
+			__raw_readsl(info->mmio_base + NDDB, data + index, 8);
+
+			/*
+			 * According to the datasheet, when reading
+			 * from NDDB with BCH enabled, after each 32
+			 * bytes reads, we have to make sure that the
+			 * NDSR.RDDREQ bit is set
+			 */
+			for (timeout = 0;
+			     !(nand_readl(info, NDSR) & NDSR_RDDREQ);
+			     timeout++) {
+				if (timeout >= 5) {
+					dev_err(&info->pdev->dev,
+						"Timeout on RDDREQ while draining the FIFO\n");
+					return;
+				}
+
+				mdelay(1);
+			}
+
+			index += 32;
+		}
+	} else {
+		__raw_readsl(info->mmio_base + NDDB, data, len);
+	}
+}
+
 static void handle_data_pio(struct pxa3xx_nand_info *info)
 {
 	unsigned int do_bytes = min(info->data_size, info->chunk_size);
@@ -496,14 +531,14 @@ static void handle_data_pio(struct pxa3xx_nand_info *info)
 				      DIV_ROUND_UP(info->oob_size, 4));
 		break;
 	case STATE_PIO_READING:
-		__raw_readsl(info->mmio_base + NDDB,
-			     info->data_buff + info->data_buff_pos,
-			     DIV_ROUND_UP(do_bytes, 4));
+		drain_fifo(info,
+			   info->data_buff + info->data_buff_pos,
+			   DIV_ROUND_UP(do_bytes, 4));
 
 		if (info->oob_size > 0)
-			__raw_readsl(info->mmio_base + NDDB,
-				     info->oob_buff + info->oob_buff_pos,
-				     DIV_ROUND_UP(info->oob_size, 4));
+			drain_fifo(info,
+				   info->oob_buff + info->oob_buff_pos,
+				   DIV_ROUND_UP(info->oob_size, 4));
 		break;
 	default:
 		dev_err(&info->pdev->dev, "%s: invalid state %d\n", __func__,
-- 
2.3.0
