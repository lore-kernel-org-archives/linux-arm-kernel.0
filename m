From: yuxu@marvell.com (Yu Xu)
Date: Thu,  8 Dec 2011 13:00:28 +0800
Subject: [PATCH] spi/pxa2xx: fix null_dma_buf out of allocated memory.
Message-ID: <1323320428-8398-1-git-send-email-yuxu@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

spi_alloc_master allocates memory for null_dma_buf,
but actually null_dma_buf is out of that region.
The null_dma_buf address may be used by others.
When doing spi write, null_dma_buf will be written,
and impacts that using the address.

Signed-off-by: Yu Xu <yuxu@marvell.com>
---
 drivers/spi/spi-pxa2xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index dc25bee..82a9b86 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1569,7 +1569,7 @@ static int __devinit pxa2xx_spi_probe(struct platform_device *pdev)
 	master->transfer = transfer;
 
 	drv_data->ssp_type = ssp->type;
-	drv_data->null_dma_buf = (u32 *)ALIGN((u32)(drv_data +
+	drv_data->null_dma_buf = (u32 *)ALIGN((u32)((u32)drv_data +
 						sizeof(struct driver_data)), 8);
 
 	drv_data->ioaddr = ssp->mmio_base;
-- 
1.7.5.4
