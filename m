From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Mon, 16 Jan 2017 19:44:55 +0100
Subject: [PATCH v2 2/3] spi: pxa2xx: Prepare for edge-triggered interrupts
In-Reply-To: <cover.1484592296.git.jan.kiszka@siemens.com>
References: <cover.1484592296.git.jan.kiszka@siemens.com>
Message-ID: <7b15a0910a3ad861fd32161c72559bafa7b71e29.1484592296.git.jan.kiszka@siemens.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using the a device with edge-triggered interrupts, such as MSIs,
the interrupt handler has to ensure that there is a point in time during
its execution where all interrupts sources are silent so that a new
event can trigger a new interrupt again.

This is achieved here by looping over SSSR evaluation. We need to take
into account that SSCR1 may be changed by the transfer handler, thus we
need to redo the mask calculation, at least regarding the volatile
interrupt enable bit (TIE).

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/spi/spi-pxa2xx.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 0d10090..ac49b80 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -751,6 +751,7 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
 	struct driver_data *drv_data = dev_id;
 	u32 sccr1_reg;
 	u32 mask = drv_data->mask_sr;
+	irqreturn_t ret = IRQ_NONE;
 	u32 status;
 
 	/*
@@ -774,24 +775,29 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
 
 	sccr1_reg = pxa2xx_spi_read(drv_data, SSCR1);
 
-	/* Ignore possible writes if we don't need to write */
-	if (!(sccr1_reg & SSCR1_TIE))
-		mask &= ~SSSR_TFS;
-
 	/* Ignore RX timeout interrupt if it is disabled */
 	if (!(sccr1_reg & SSCR1_TINTE))
 		mask &= ~SSSR_TINT;
 
-	if (!(status & mask))
-		return IRQ_NONE;
+	while (1) {
+		/* Ignore possible writes if we don't need to write */
+		if (!(sccr1_reg & SSCR1_TIE))
+			mask &= ~SSSR_TFS;
 
-	if (!drv_data->master->cur_msg) {
-		handle_bad_msg(drv_data);
-		/* Never fail */
-		return IRQ_HANDLED;
-	}
+		if (!(status & mask))
+			return ret;
+
+		if (!drv_data->master->cur_msg) {
+			handle_bad_msg(drv_data);
+			/* Never fail */
+			return IRQ_HANDLED;
+		}
+
+		ret |= drv_data->transfer_handler(drv_data);
 
-	return drv_data->transfer_handler(drv_data);
+		status = pxa2xx_spi_read(drv_data, SSSR);
+		sccr1_reg = pxa2xx_spi_read(drv_data, SSCR1);
+	}
 }
 
 /*
-- 
2.1.4
