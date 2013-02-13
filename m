From: girishks2000@gmail.com (Girish K S)
Date: Wed, 13 Feb 2013 11:25:27 -0800
Subject: [PATCH V2 1/5] spi: s3c64xx: modified error interrupt handling and
 init
In-Reply-To: <1360783531-32654-1-git-send-email-ks.giri@samsung.com>
References: <1360783531-32654-1-git-send-email-ks.giri@samsung.com>
Message-ID: <1360783531-32654-2-git-send-email-ks.giri@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The status of the interrupt is available in the status register,
so reading the clear pending register and writing back the same
value will not actually clear the pending interrupts. This patch
modifies the interrupt handler to read the status register and
clear the corresponding pending bit in the clear pending register.

Modified the hwInit function to clear all the pending interrupts.

Signed-off-by: Girish K S <ks.giri@samsung.com>
---
changes in v2:
		Modified the interrupt handler to clear the pending
		register after setting to value 1.

 drivers/spi/spi-s3c64xx.c |   41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 8f492ed..6eba24e 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -996,25 +996,30 @@ static irqreturn_t s3c64xx_spi_irq(int irq, void *data)
 {
 	struct s3c64xx_spi_driver_data *sdd = data;
 	struct spi_master *spi = sdd->master;
-	unsigned int val;
+	unsigned int val, clr = 0;
 
-	val = readl(sdd->regs + S3C64XX_SPI_PENDING_CLR);
+	val = readl(sdd->regs + S3C64XX_SPI_STATUS);
 
-	val &= S3C64XX_SPI_PND_RX_OVERRUN_CLR |
-		S3C64XX_SPI_PND_RX_UNDERRUN_CLR |
-		S3C64XX_SPI_PND_TX_OVERRUN_CLR |
-		S3C64XX_SPI_PND_TX_UNDERRUN_CLR;
-
-	writel(val, sdd->regs + S3C64XX_SPI_PENDING_CLR);
-
-	if (val & S3C64XX_SPI_PND_RX_OVERRUN_CLR)
+	if (val & S3C64XX_SPI_ST_RX_OVERRUN_ERR) {
+		clr = S3C64XX_SPI_PND_RX_OVERRUN_CLR;
 		dev_err(&spi->dev, "RX overrun\n");
-	if (val & S3C64XX_SPI_PND_RX_UNDERRUN_CLR)
+	}
+	if (val & S3C64XX_SPI_ST_RX_UNDERRUN_ERR) {
+		clr |= S3C64XX_SPI_PND_RX_UNDERRUN_CLR;
 		dev_err(&spi->dev, "RX underrun\n");
-	if (val & S3C64XX_SPI_PND_TX_OVERRUN_CLR)
+	}
+	if (val & S3C64XX_SPI_ST_TX_OVERRUN_ERR) {
+		clr |= S3C64XX_SPI_PND_TX_OVERRUN_CLR;
 		dev_err(&spi->dev, "TX overrun\n");
-	if (val & S3C64XX_SPI_PND_TX_UNDERRUN_CLR)
+	}
+	if (val & S3C64XX_SPI_ST_TX_UNDERRUN_ERR) {
+		clr |= S3C64XX_SPI_PND_TX_UNDERRUN_CLR;
 		dev_err(&spi->dev, "TX underrun\n");
+	}
+
+	/* Clear the pending irq by setting and then clearing it */
+	writel(clr, sdd->regs + S3C64XX_SPI_PENDING_CLR);
+	writel(0, sdd->regs + S3C64XX_SPI_PENDING_CLR);
 
 	return IRQ_HANDLED;
 }
@@ -1038,9 +1043,13 @@ static void s3c64xx_spi_hwinit(struct s3c64xx_spi_driver_data *sdd, int channel)
 	writel(0, regs + S3C64XX_SPI_MODE_CFG);
 	writel(0, regs + S3C64XX_SPI_PACKET_CNT);
 
-	/* Clear any irq pending bits */
-	writel(readl(regs + S3C64XX_SPI_PENDING_CLR),
-				regs + S3C64XX_SPI_PENDING_CLR);
+	/* Clear any irq pending bits, should set and clear the bits */
+	val = S3C64XX_SPI_PND_RX_OVERRUN_CLR |
+		S3C64XX_SPI_PND_RX_UNDERRUN_CLR |
+		S3C64XX_SPI_PND_TX_OVERRUN_CLR |
+		S3C64XX_SPI_PND_TX_UNDERRUN_CLR;
+	writel(val, regs + S3C64XX_SPI_PENDING_CLR);
+	writel(0, regs + S3C64XX_SPI_PENDING_CLR);
 
 	writel(0, regs + S3C64XX_SPI_SWAP_CFG);
 
-- 
1.7.10.4
