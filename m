From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Mon, 14 Jan 2013 15:34:29 +0800
Subject: [v4 PATCH 04/12] spi/atmel_spi: add flag to controller data for lock
 operations
In-Reply-To: <1358148877-18679-1-git-send-email-wenyou.yang@atmel.com>
References: <1358148877-18679-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1358148877-18679-5-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@atmel.com>

Will allow to drop the lock during DMA operations.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: grant.likely at secretlab.ca
Cc: spi-devel-general at lists.sourceforge.net
---
 drivers/spi/spi-atmel.c |   31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 687075e..8f6f0a0 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -188,6 +188,7 @@
  */
 struct atmel_spi {
 	spinlock_t		lock;
+	unsigned long		flags;
 
 	resource_size_t		phybase;
 	void __iomem		*regs;
@@ -324,6 +325,16 @@ static void cs_deactivate(struct atmel_spi *as, struct spi_device *spi)
 		gpio_set_value(asd->npcs_pin, !active);
 }
 
+static void atmel_spi_lock(struct atmel_spi *as)
+{
+		spin_lock_irqsave(&as->lock, as->flags);
+}
+
+static void atmel_spi_unlock(struct atmel_spi *as)
+{
+		spin_unlock_irqrestore(&as->lock, as->flags);
+}
+
 static inline int atmel_spi_xfer_is_last(struct spi_message *msg,
 					struct spi_transfer *xfer)
 {
@@ -560,9 +571,9 @@ atmel_spi_msg_done(struct spi_master *master, struct atmel_spi *as,
 		"xfer complete: %u bytes transferred\n",
 		msg->actual_length);
 
-	spin_unlock(&as->lock);
+	atmel_spi_unlock(as);
 	msg->complete(msg->context);
-	spin_lock(&as->lock);
+	atmel_spi_lock(as);
 
 	as->current_transfer = NULL;
 	as->next_transfer = NULL;
@@ -793,13 +804,11 @@ static int atmel_spi_setup(struct spi_device *spi)
 		spi->controller_state = asd;
 		gpio_direction_output(npcs_pin, !(spi->mode & SPI_CS_HIGH));
 	} else {
-		unsigned long		flags;
-
-		spin_lock_irqsave(&as->lock, flags);
+		atmel_spi_lock(as);
 		if (as->stay == spi)
 			as->stay = NULL;
 		cs_deactivate(as, spi);
-		spin_unlock_irqrestore(&as->lock, flags);
+		atmel_spi_unlock(as);
 	}
 
 	asd->csr = csr;
@@ -818,7 +827,6 @@ static int atmel_spi_transfer(struct spi_device *spi, struct spi_message *msg)
 {
 	struct atmel_spi	*as;
 	struct spi_transfer	*xfer;
-	unsigned long		flags;
 	struct device		*controller = spi->master->dev.parent;
 	u8			bits;
 	struct atmel_spi_device	*asd;
@@ -883,11 +891,11 @@ static int atmel_spi_transfer(struct spi_device *spi, struct spi_message *msg)
 	msg->status = -EINPROGRESS;
 	msg->actual_length = 0;
 
-	spin_lock_irqsave(&as->lock, flags);
+	atmel_spi_lock(as);
 	list_add_tail(&msg->queue, &as->queue);
 	if (!as->current_transfer)
 		atmel_spi_next_message(spi->master);
-	spin_unlock_irqrestore(&as->lock, flags);
+	atmel_spi_unlock(as);
 
 	return 0;
 }
@@ -897,17 +905,16 @@ static void atmel_spi_cleanup(struct spi_device *spi)
 	struct atmel_spi	*as = spi_master_get_devdata(spi->master);
 	struct atmel_spi_device	*asd = spi->controller_state;
 	unsigned		gpio = (unsigned) spi->controller_data;
-	unsigned long		flags;
 
 	if (!asd)
 		return;
 
-	spin_lock_irqsave(&as->lock, flags);
+	atmel_spi_lock(as);
 	if (as->stay == spi) {
 		as->stay = NULL;
 		cs_deactivate(as, spi);
 	}
-	spin_unlock_irqrestore(&as->lock, flags);
+	atmel_spi_unlock(as);
 
 	spi->controller_state = NULL;
 	gpio_free(gpio);
-- 
1.7.9.5
