From: robh@kernel.org (Rob Herring)
Date: Wed, 23 May 2018 15:52:20 -0500
Subject: [PATCH v2] spi: bcm2835aux: ensure interrupts are enabled for shared
 handler
Message-ID: <20180523205220.7394-1-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BCM2835 AUX SPI has a shared interrupt line (with AUX UART).
Downstream fixes this with an AUX irqchip to demux the IRQ sources and a
DT change which breaks compatibility with older kernels. The AUX irqchip
was already rejected for upstream[1] and the DT change would break
working systems if the DTB is updated to a newer one. The latter issue
was brought to my attention by Alex Graf.

The root cause however is a bug in the shared handler. A shared handler
must correctly identify it actually handled an interrupt. The handler
here was processing data whether interrupts were enabled or not.
It would return IRQ_HANDLED if there was any data and not only when
there was an actual interrupt pending. The result is that another
device's IRQ could cause the SPI's IRQ handler to run and process data
when the the SPI driver working in polled mode. Fix this by adding a
check in the IRQ handler that the TXEMPTY or IDLE interrupts are enabled
and always return IRQ_NONE when they are not.

[1] https://patchwork.kernel.org/patch/9781221/

Cc: Alexander Graf <agraf@suse.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list at broadcom.com
Cc: linux-spi at vger.kernel.org
Cc: linux-rpi-kernel at lists.infradead.org
Cc: linux-arm-kernel at lists.infradead.org
Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Rob Herring <robh@kernel.org>
---
Still hoping someone can test this as I have not.

v2:
- Expand commit message text about shared handler req. and how polled 
  mode causes the problem.

 drivers/spi/spi-bcm2835aux.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 1431cb98fe40..3094d818cf06 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -184,6 +184,11 @@ static irqreturn_t bcm2835aux_spi_interrupt(int irq, void *dev_id)
 	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
 	irqreturn_t ret = IRQ_NONE;
 
+	/* IRQ may be shared, so return if our interrupts are disabled */
+	if (!(bcm2835aux_rd(bs, BCM2835_AUX_SPI_CNTL1) &
+	      (BCM2835_AUX_SPI_CNTL1_TXEMPTY | BCM2835_AUX_SPI_CNTL1_IDLE)))
+		return ret;
+
 	/* check if we have data to read */
 	while (bs->rx_len &&
 	       (!(bcm2835aux_rd(bs, BCM2835_AUX_SPI_STAT) &
-- 
2.17.0
