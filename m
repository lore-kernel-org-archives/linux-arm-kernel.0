From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu,  2 Dec 2010 18:47:31 +0100
Subject: [PATCH 3/9] spi/pxa2xx: Use define for SSSR_TFL_MASK instead of plain
	numbers
In-Reply-To: <1291312057-7933-1-git-send-email-bigeasy@linutronix.de>
References: <1291312057-7933-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <1291312057-7933-4-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
---
 arch/arm/plat-pxa/include/plat/ssp.h |    3 ++-
 drivers/spi/pxa2xx_spi.c             |    8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-pxa/include/plat/ssp.h b/arch/arm/plat-pxa/include/plat/ssp.h
index fe43150..21c12ca 100644
--- a/arch/arm/plat-pxa/include/plat/ssp.h
+++ b/arch/arm/plat-pxa/include/plat/ssp.h
@@ -82,7 +82,8 @@
 #define SSSR_TFS	(1 << 5)	/* Transmit FIFO Service Request */
 #define SSSR_RFS	(1 << 6)	/* Receive FIFO Service Request */
 #define SSSR_ROR	(1 << 7)	/* Receive FIFO Overrun */
-
+#define SSSR_TFL_MASK   (0xf << 8)	/* Transmit FIFO Level mask */
+#define SSSR_RFL_MASK   (0xf << 12)	/* Receive FIFO Level mask */
 
 /* extra bits in PXA255, PXA26x and PXA27x SSP ports */
 #define SSCR0_TISSP		(1 << 4)	/* TI Sync Serial Protocol */
diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
index 1865c23..5508344 100644
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -224,7 +224,7 @@ static int null_writer(struct driver_data *drv_data)
 	void __iomem *reg = drv_data->ioaddr;
 	u8 n_bytes = drv_data->n_bytes;
 
-	if (((read_SSSR(reg) & 0x00000f00) == 0x00000f00)
+	if (((read_SSSR(reg) & SSSR_TFL_MASK) == SSSR_TFL_MASK)
 		|| (drv_data->tx == drv_data->tx_end))
 		return 0;
 
@@ -252,7 +252,7 @@ static int u8_writer(struct driver_data *drv_data)
 {
 	void __iomem *reg = drv_data->ioaddr;
 
-	if (((read_SSSR(reg) & 0x00000f00) == 0x00000f00)
+	if (((read_SSSR(reg) & SSSR_TFL_MASK) == SSSR_TFL_MASK)
 		|| (drv_data->tx == drv_data->tx_end))
 		return 0;
 
@@ -279,7 +279,7 @@ static int u16_writer(struct driver_data *drv_data)
 {
 	void __iomem *reg = drv_data->ioaddr;
 
-	if (((read_SSSR(reg) & 0x00000f00) == 0x00000f00)
+	if (((read_SSSR(reg) & SSSR_TFL_MASK) == SSSR_TFL_MASK)
 		|| (drv_data->tx == drv_data->tx_end))
 		return 0;
 
@@ -306,7 +306,7 @@ static int u32_writer(struct driver_data *drv_data)
 {
 	void __iomem *reg = drv_data->ioaddr;
 
-	if (((read_SSSR(reg) & 0x00000f00) == 0x00000f00)
+	if (((read_SSSR(reg) & SSSR_TFL_MASK) == SSSR_TFL_MASK)
 		|| (drv_data->tx == drv_data->tx_end))
 		return 0;
 
-- 
1.7.3.2
