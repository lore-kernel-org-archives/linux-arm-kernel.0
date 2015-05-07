From: 21cnbao@gmail.com (Barry Song)
Date: Thu,  7 May 2015 07:13:10 +0000
Subject: [PATCH 1/2] spi: sirf: replace kmalloc by devm_kzalloc
Message-ID: <1430982791-8681-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qipan Li <Qipan.Li@csr.com>

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/spi/spi-sirf.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index a69ccb7..ae4bd11 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -758,7 +758,7 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 	/* We are not using dummy delay between command and data */
 	writel(0, sspi->base + SIRFSOC_SPI_DUMMY_DELAY_CTL);
 
-	sspi->dummypage = kmalloc(2 * PAGE_SIZE, GFP_KERNEL);
+	sspi->dummypage = devm_kzalloc(&pdev->dev, 2 * PAGE_SIZE, GFP_KERNEL);
 	if (!sspi->dummypage) {
 		ret = -ENOMEM;
 		goto free_clk;
@@ -766,12 +766,10 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 
 	ret = spi_bitbang_start(&sspi->bitbang);
 	if (ret)
-		goto free_dummypage;
+		goto free_clk;
 	dev_info(&pdev->dev, "registerred, bus number = %d\n", master->bus_num);
 
 	return 0;
-free_dummypage:
-	kfree(sspi->dummypage);
 free_clk:
 	clk_disable_unprepare(sspi->clk);
 	clk_put(sspi->clk);
@@ -794,7 +792,6 @@ static int  spi_sirfsoc_remove(struct platform_device *pdev)
 	sspi = spi_master_get_devdata(master);
 
 	spi_bitbang_stop(&sspi->bitbang);
-	kfree(sspi->dummypage);
 	clk_disable_unprepare(sspi->clk);
 	clk_put(sspi->clk);
 	dma_release_channel(sspi->rx_chan);
-- 
2.3.5
