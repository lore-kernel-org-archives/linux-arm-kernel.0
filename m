From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Jan 2017 18:39:51 +0000
Subject: Applied "spi: pxa2xx: Prepare for edge-triggered interrupts" to the
 spi tree
In-Reply-To: <7e5fb21d-35bd-6ac3-9e6f-cffed656997f@siemens.com>
Message-ID: <E1cW60V-0006nH-NO@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: pxa2xx: Prepare for edge-triggered interrupts

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From e51e9b93049f624c179bab2c651995bca22b5bb7 Mon Sep 17 00:00:00 2001
From: Jan Kiszka <jan.kiszka@siemens.com>
Date: Sat, 21 Jan 2017 10:06:38 +0100
Subject: [PATCH] spi: pxa2xx: Prepare for edge-triggered interrupts

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 8c65bc1823f3..06ade434c083 100644
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
2.11.0
