From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu,  8 Dec 2011 11:19:03 +0300
Subject: [RESEND PATCH v3] pxa2xx_spi: fix memory corruption
In-Reply-To: <20111207203559.GB3744@pengutronix.de>
References: <20111207203559.GB3744@pengutronix.de>
Message-ID: <1323332343-2266-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pxa2xx_spi_probe allocates struct driver_data and null_dma_buf
at same time via spi_alloc_master(), but then calculates
null_dma_buf pointer incorrectly, and it causes memory corruption
later if DMA usage is enabled.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
v2: - add u8 __null_dma_buf[16] to the end of driver_data structure
    and use it as null_dma_buf after alignment.
    - use PTR_ALIGN instead of ALIGN
v3: - drop (u8 *) cast, use & operator instead, change array name

 drivers/spi/spi-pxa2xx.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

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
1.7.8
