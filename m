From: vipin.kumar@st.com (Vipin Kumar)
Date: Tue, 9 Oct 2012 16:14:49 +0530
Subject: [PATCH 07/11] fsmc/nand: Provide contiguous buffers to dma
In-Reply-To: <cover.1349778820.git.vipin.kumar@st.com>
References: <cover.1349778820.git.vipin.kumar@st.com>
Message-ID: <2b88c853b3691338fae037f569917fc300cd6032.1349778821.git.vipin.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

read_buf/write_buf callbacks should be able to accept a user space memory
address (virtually contiguous memory) as buffer pointer.

This patch allocates a logically contiguous memory area which is use for dma
xfers during read and write accesses.

Signed-off-by: Vipin Kumar <vipin.kumar@st.com>
---
 drivers/mtd/nand/fsmc_nand.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
index 4b29a64..8de6dcf 100644
--- a/drivers/mtd/nand/fsmc_nand.c
+++ b/drivers/mtd/nand/fsmc_nand.c
@@ -323,6 +323,7 @@ struct fsmc_nand_data {
 	struct dma_chan		*read_dma_chan;
 	struct dma_chan		*write_dma_chan;
 	struct completion	dma_access_complete;
+	void			*dma_buf;
 
 	/* Recieved from plat data */
 	struct fsmc_rbpin	*rbpin;
@@ -675,7 +676,8 @@ static void fsmc_read_buf_dma(struct mtd_info *mtd, uint8_t *buf, int len)
 	struct fsmc_nand_data *host;
 
 	host = container_of(mtd, struct fsmc_nand_data, mtd);
-	dma_xfer(host, buf, len, DMA_FROM_DEVICE);
+	dma_xfer(host, host->dma_buf, len, DMA_FROM_DEVICE);
+	memcpy(buf, (const void *)host->dma_buf, len);
 }
 
 /*
@@ -690,7 +692,8 @@ static void fsmc_write_buf_dma(struct mtd_info *mtd, const uint8_t *buf,
 	struct fsmc_nand_data *host;
 
 	host = container_of(mtd, struct fsmc_nand_data, mtd);
-	dma_xfer(host, (void *)buf, len, DMA_TO_DEVICE);
+	memcpy(host->dma_buf, buf, len);
+	dma_xfer(host, host->dma_buf, len, DMA_TO_DEVICE);
 }
 
 /*
@@ -1133,6 +1136,13 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "Unable to get write dma channel\n");
 			goto err_req_write_chnl;
 		}
+
+		host->dma_buf = kmalloc(NAND_MAX_PAGESIZE + NAND_MAX_OOBSIZE,
+				GFP_KERNEL);
+		if (!host->dma_buf) {
+			dev_err(&pdev->dev, "failed to allocate dma buffer\n");
+			goto err_req_dma_buf;
+		}
 		nand->read_buf = fsmc_read_buf_dma;
 		nand->write_buf = fsmc_write_buf_dma;
 		break;
@@ -1246,6 +1256,9 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 err_probe:
 err_scan_ident:
 	if (host->mode == USE_DMA_ACCESS)
+		kfree(host->dma_buf);
+err_req_dma_buf:
+	if (host->mode == USE_DMA_ACCESS)
 		dma_release_channel(host->write_dma_chan);
 err_req_write_chnl:
 	if (host->mode == USE_DMA_ACCESS)
-- 
1.7.11.4
