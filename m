From: yibin.gong@nxp.com (Robin Gong)
Date: Wed, 11 Jul 2018 00:23:11 +0800
Subject: [PATCH v1 2/4] dmaengine: imx-sdma: add check_bd_buswidth() to kill
 the dulicated code
In-Reply-To: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
References: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
Message-ID: <1531239793-11781-3-git-send-email-yibin.gong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add check_bd_buswidth() to minimize the code size.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/imx-sdma.c | 64 +++++++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 35 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 27ccabf..ed2267d 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1326,6 +1326,33 @@ static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
 	return NULL;
 }
 
+static int check_bd_buswidth(struct sdma_buffer_descriptor *bd,
+			     struct sdma_channel *sdmac, int count,
+			     dma_addr_t dma_dst, dma_addr_t dma_src)
+{
+	int ret = 0;
+
+	switch (sdmac->word_size) {
+	case DMA_SLAVE_BUSWIDTH_4_BYTES:
+		bd->mode.command = 0;
+		if ((count | dma_dst | dma_src) & 3)
+			ret = -EINVAL;
+		break;
+	case DMA_SLAVE_BUSWIDTH_2_BYTES:
+		bd->mode.command = 2;
+		if ((count | dma_dst | dma_src) & 1)
+			ret = -EINVAL;
+		break;
+	case DMA_SLAVE_BUSWIDTH_1_BYTE:
+		 bd->mode.command = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
 static struct dma_async_tx_descriptor *sdma_prep_memcpy(
 		struct dma_chan *chan, dma_addr_t dma_dst,
 		dma_addr_t dma_src, size_t len, unsigned long flags)
@@ -1357,23 +1384,8 @@ static struct dma_async_tx_descriptor *sdma_prep_memcpy(
 		bd->mode.count = count;
 		desc->chn_count += count;
 
-		switch (sdmac->word_size) {
-		case DMA_SLAVE_BUSWIDTH_4_BYTES:
-			bd->mode.command = 0;
-			if ((count | dma_src | dma_dst) & 3)
-				goto err_bd_out;
-			break;
-		case DMA_SLAVE_BUSWIDTH_2_BYTES:
-			bd->mode.command = 2;
-			if ((count | dma_src | dma_dst) & 1)
-				goto err_bd_out;
-			break;
-		case DMA_SLAVE_BUSWIDTH_1_BYTE:
-			bd->mode.command = 1;
-			break;
-		default:
+		if (check_bd_buswidth(bd, sdmac, count, dma_dst, dma_src))
 			goto err_bd_out;
-		}
 
 		dma_src += count;
 		dma_dst += count;
@@ -1440,27 +1452,9 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 		bd->mode.count = count;
 		desc->chn_count += count;
 
-		if (sdmac->word_size > DMA_SLAVE_BUSWIDTH_4_BYTES)
+		if (check_bd_buswidth(bd, sdmac, count, 0, sg->dma_address))
 			goto err_bd_out;
 
-		switch (sdmac->word_size) {
-		case DMA_SLAVE_BUSWIDTH_4_BYTES:
-			bd->mode.command = 0;
-			if (count & 3 || sg->dma_address & 3)
-				goto err_bd_out;
-			break;
-		case DMA_SLAVE_BUSWIDTH_2_BYTES:
-			bd->mode.command = 2;
-			if (count & 1 || sg->dma_address & 1)
-				goto err_bd_out;
-			break;
-		case DMA_SLAVE_BUSWIDTH_1_BYTE:
-			bd->mode.command = 1;
-			break;
-		default:
-			goto err_bd_out;
-		}
-
 		param = BD_DONE | BD_EXTD | BD_CONT;
 
 		if (i + 1 == sg_len) {
-- 
2.7.4
