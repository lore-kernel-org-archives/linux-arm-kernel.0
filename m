From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 28 Oct 2012 18:51:17 +0300
Subject: [PATCH RESEND] spi-pxa2xx: fix memory corruption
Message-ID: <1351439477-9969-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pxa2xx_spi_probe allocates struct driver_data and null_dma_buf
at same time via spi_alloc_master(), but then calculates
null_dma_buf pointer incorrectly, and it causes memory corruption
later if DMA usage is enabled.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
Rebased against v3.7-rc2

 drivers/spi/spi-pxa2xx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index dc25bee..b25fe27 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -106,6 +106,7 @@ struct driver_data {
 	int rx_channel;
 	int tx_channel;
 	u32 *null_dma_buf;
+	u8 null_dma_buf_unaligned[16];
 
 	/* SSP register addresses */
 	void __iomem *ioaddr;
@@ -1543,8 +1544,8 @@ static int __devinit pxa2xx_spi_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	/* Allocate master with space for drv_data and null dma buffer */
-	master = spi_alloc_master(dev, sizeof(struct driver_data) + 16);
+	/* Allocate master with space for drv_data */
+	master = spi_alloc_master(dev, sizeof(struct driver_data));
 	if (!master) {
 		dev_err(&pdev->dev, "cannot alloc spi_master\n");
 		pxa_ssp_free(ssp);
@@ -1569,8 +1570,8 @@ static int __devinit pxa2xx_spi_probe(struct platform_device *pdev)
 	master->transfer = transfer;
 
 	drv_data->ssp_type = ssp->type;
-	drv_data->null_dma_buf = (u32 *)ALIGN((u32)(drv_data +
-						sizeof(struct driver_data)), 8);
+	drv_data->null_dma_buf =
+		(u32 *)PTR_ALIGN(&drv_data->null_dma_buf_unaligned, 8);
 
 	drv_data->ioaddr = ssp->mmio_base;
 	drv_data->ssdr_physical = ssp->phys_base + SSDR;
-- 
1.7.12.4
