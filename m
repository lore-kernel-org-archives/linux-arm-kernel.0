From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Mon, 16 Jan 2017 19:44:54 +0100
Subject: [PATCH v2 1/3] spi: pxa2xx: Factor out handle_bad_msg
In-Reply-To: <cover.1484592296.git.jan.kiszka@siemens.com>
References: <cover.1484592296.git.jan.kiszka@siemens.com>
Message-ID: <776c72d3de4b75ff0a8b91791740389950d8abe8.1484592296.git.jan.kiszka@siemens.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As suggested by Andy Shevchenko: Decouple this corner cause from the
general handling logic in ssp_int.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/spi/spi-pxa2xx.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index dd7b5b4..0d10090 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -732,6 +732,20 @@ static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
 	return IRQ_HANDLED;
 }
 
+static void handle_bad_msg(struct driver_data *drv_data)
+{
+	pxa2xx_spi_write(drv_data, SSCR0,
+			 pxa2xx_spi_read(drv_data, SSCR0) & ~SSCR0_SSE);
+	pxa2xx_spi_write(drv_data, SSCR1,
+			 pxa2xx_spi_read(drv_data, SSCR1) & ~drv_data->int_cr1);
+	if (!pxa25x_ssp_comp(drv_data))
+		pxa2xx_spi_write(drv_data, SSTO, 0);
+	write_SSSR_CS(drv_data, drv_data->clear_sr);
+
+	dev_err(&drv_data->pdev->dev,
+		"bad message state in interrupt handler\n");
+}
+
 static irqreturn_t ssp_int(int irq, void *dev_id)
 {
 	struct driver_data *drv_data = dev_id;
@@ -772,20 +786,7 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	if (!drv_data->master->cur_msg) {
-
-		pxa2xx_spi_write(drv_data, SSCR0,
-				 pxa2xx_spi_read(drv_data, SSCR0)
-				 & ~SSCR0_SSE);
-		pxa2xx_spi_write(drv_data, SSCR1,
-				 pxa2xx_spi_read(drv_data, SSCR1)
-				 & ~drv_data->int_cr1);
-		if (!pxa25x_ssp_comp(drv_data))
-			pxa2xx_spi_write(drv_data, SSTO, 0);
-		write_SSSR_CS(drv_data, drv_data->clear_sr);
-
-		dev_err(&drv_data->pdev->dev,
-			"bad message state in interrupt handler\n");
-
+		handle_bad_msg(drv_data);
 		/* Never fail */
 		return IRQ_HANDLED;
 	}
-- 
2.1.4
