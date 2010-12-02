From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu,  2 Dec 2010 18:47:30 +0100
Subject: [PATCH 2/9] spi/pxa2xx: add support for shared IRQ handler
In-Reply-To: <1291312057-7933-1-git-send-email-bigeasy@linutronix.de>
References: <1291312057-7933-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <1291312057-7933-3-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is required in case the interrupt line is shared with other
devices.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
---
 drivers/spi/pxa2xx_spi.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
index 4e169b5..1865c23 100644
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -742,6 +742,18 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
 {
 	struct driver_data *drv_data = dev_id;
 	void __iomem *reg = drv_data->ioaddr;
+	u32 sccr1_reg = read_SSCR1(reg);
+	u32 mask = drv_data->mask_sr;
+	u32 status;
+
+	status = read_SSSR(reg);
+
+	/* Ignore possible writes if we don't need to write */
+	if (!(sccr1_reg & SSCR1_TIE))
+		mask &= ~SSSR_TFS;
+
+	if (!(status & mask))
+		return IRQ_NONE;
 
 	if (!drv_data->cur_msg) {
 
@@ -1512,7 +1524,8 @@ static int __devinit pxa2xx_spi_probe(struct platform_device *pdev)
 		drv_data->mask_sr = SSSR_TINT | SSSR_RFS | SSSR_TFS | SSSR_ROR;
 	}
 
-	status = request_irq(ssp->irq, ssp_int, 0, dev_name(dev), drv_data);
+	status = request_irq(ssp->irq, ssp_int, IRQF_SHARED, dev_name(dev),
+			drv_data);
 	if (status < 0) {
 		dev_err(&pdev->dev, "cannot get IRQ %d\n", ssp->irq);
 		goto out_error_master_alloc;
-- 
1.7.3.2
