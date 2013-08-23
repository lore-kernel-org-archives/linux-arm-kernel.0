From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Fri, 23 Aug 2013 08:33:39 +0800
Subject: [PATCH -next] spi: sirf: fix error return code in spi_sirfsoc_probe()
Message-ID: <CAPgLHd8sTqQX-orB1VjED4hcpwU577TgqfQV=eRYCk-vjzdYOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/spi/spi-sirf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index 62c92c3..9b41254 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -655,12 +655,14 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 		(void *)rx_dma_ch);
 	if (!sspi->rx_chan) {
 		dev_err(&pdev->dev, "can not allocate rx dma channel\n");
+		ret = -ENODEV;
 		goto free_master;
 	}
 	sspi->tx_chan = dma_request_channel(dma_cap_mask, (dma_filter_fn)sirfsoc_dma_filter_id,
 		(void *)tx_dma_ch);
 	if (!sspi->tx_chan) {
 		dev_err(&pdev->dev, "can not allocate tx dma channel\n");
+		ret = -ENODEV;
 		goto free_rx_dma;
 	}
 
@@ -683,8 +685,10 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 	writel(0, sspi->base + SIRFSOC_SPI_DUMMY_DELAY_CTL);
 
 	sspi->dummypage = kmalloc(2 * PAGE_SIZE, GFP_KERNEL);
-	if (!sspi->dummypage)
+	if (!sspi->dummypage) {
+		ret = -ENOMEM;
 		goto free_clk;
+	}
 
 	ret = spi_bitbang_start(&sspi->bitbang);
 	if (ret)
