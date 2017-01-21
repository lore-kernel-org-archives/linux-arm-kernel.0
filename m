From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Sat, 21 Jan 2017 10:06:38 +0100
Subject: [PATCH v3 1/2] spi: pxa2xx: Prepare for edge-triggered interrupts
In-Reply-To: <cover.1484989599.git.jan.kiszka@siemens.com>
References: <cover.1484989599.git.jan.kiszka@siemens.com>
Message-ID: <a72b3c3f593d7ebb8af91e174cd844eb2e0d7c09.1484989599.git.jan.kiszka@siemens.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using the a device with edge-triggered interrupts, such as MSIs,
the interrupt handler has to ensure that there is a point in time during
its execution where all interrupts sources are silent so that a new
event can trigger a new interrupt again.

This is achieved here by disabling all interrupt sources for a moment
before processing them according to the status register. If a new
interrupt should have arrived after we read the status, it will now
re-trigger the interrupt, even in edge mode.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/spi/spi-pxa2xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index bd843df..47b65d7 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -785,6 +785,9 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
 	if (!(status & mask))
 		return IRQ_NONE;
 
+	pxa2xx_spi_write(drv_data, SSCR1, sccr1_reg & ~drv_data->int_cr1);
+	pxa2xx_spi_write(drv_data, SSCR1, sccr1_reg);
+
 	if (!drv_data->master->cur_msg) {
 		handle_bad_msg(drv_data);
 		/* Never fail */
-- 
2.1.4
