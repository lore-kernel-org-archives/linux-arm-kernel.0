From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 10 Jul 2011 00:14:58 +0300
Subject: [PATCH] pxa2xx_spi: fix memory corruption
Message-ID: <1310246098-21208-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pxa2xx_spi_probe allocates struct driver_data and null_dma_buf
at same time via spi_alloc_master(), but then calculates
null_dma_buf pointer incorrectly, and it causes memory corruption
later if DMA usage is enabled.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/spi/pxa2xx_spi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
index dc25bee..ef38fbf 100644
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -1569,7 +1569,7 @@ static int __devinit pxa2xx_spi_probe(struct platform_device *pdev)
 	master->transfer = transfer;
 
 	drv_data->ssp_type = ssp->type;
-	drv_data->null_dma_buf = (u32 *)ALIGN((u32)(drv_data +
+	drv_data->null_dma_buf = (u32 *)ALIGN(((u32)drv_data +
 						sizeof(struct driver_data)), 8);
 
 	drv_data->ioaddr = ssp->mmio_base;
-- 
1.7.5.rc3
