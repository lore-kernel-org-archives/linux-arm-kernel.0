From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 16 May 2012 11:59:44 +0200
Subject: [PATCH] [SPI] Refactor spi-orion to use SPI framework queue.
Message-ID: <1337162384-14088-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the deprecated master->transfer with transfer_one_message()
and allow the SPI subsystem handle all the queuing of messages.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---

NOTE: This patch will only apply once the clk-next pull request of
Mike Turquette on 15th May has been included. So should this go in
via arm-soc, not the spi-next tree?

 drivers/spi/spi-orion.c |  209 +++++++++++++++--------------------------------
 1 files changed, 67 insertions(+), 142 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index dfd04e9..03a8878 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -35,12 +35,6 @@
 #define ORION_SPI_CLK_PRESCALE_MASK	0x1F
 
 struct orion_spi {
-	struct work_struct	work;
-
-	/* Lock access to transfer list.	*/
-	spinlock_t		lock;
-
-	struct list_head	msg_queue;
 	struct spi_master	*master;
 	void __iomem		*base;
 	unsigned int		max_speed;
@@ -49,8 +43,6 @@ struct orion_spi {
 	struct clk              *clk;
 };
 
-static struct workqueue_struct *orion_spi_wq;
-
 static inline void __iomem *spi_reg(struct orion_spi *orion_spi, u32 reg)
 {
 	return orion_spi->base + reg;
@@ -277,73 +269,78 @@ out:
 }
 
 
-static void orion_spi_work(struct work_struct *work)
+static int orion_spi_transfer_one_message(struct spi_master *master,
+					   struct spi_message *m)
 {
-	struct orion_spi *orion_spi =
-		container_of(work, struct orion_spi, work);
-
-	spin_lock_irq(&orion_spi->lock);
-	while (!list_empty(&orion_spi->msg_queue)) {
-		struct spi_message *m;
-		struct spi_device *spi;
-		struct spi_transfer *t = NULL;
-		int par_override = 0;
-		int status = 0;
-		int cs_active = 0;
-
-		m = container_of(orion_spi->msg_queue.next, struct spi_message,
-				 queue);
+	struct orion_spi *orion_spi = spi_master_get_devdata(master);
+	struct spi_device *spi = m->spi;
+	struct spi_transfer *t = NULL;
+	int par_override = 0;
+	int status = 0;
+	int cs_active = 0;
 
-		list_del_init(&m->queue);
-		spin_unlock_irq(&orion_spi->lock);
+	/* Load defaults */
+	status = orion_spi_setup_transfer(spi, NULL);
 
-		spi = m->spi;
+	if (status < 0)
+		goto msg_done;
 
-		/* Load defaults */
-		status = orion_spi_setup_transfer(spi, NULL);
+	list_for_each_entry(t, &m->transfers, transfer_list) {
+		/* make sure buffer length is even when working in 16
+		 * bit mode*/
+		if ((t->bits_per_word == 16) && (t->len & 1)) {
+			dev_err(&spi->dev,
+				"message rejected : "
+				"odd data length %d while in 16 bit mode\n",
+				t->len);
+			status = -EIO;
+			goto msg_done;
+		}
 
-		if (status < 0)
+		if (t->speed_hz && t->speed_hz < orion_spi->min_speed) {
+			dev_err(&spi->dev,
+				"message rejected : "
+				"device min speed (%d Hz) exceeds "
+				"required transfer speed (%d Hz)\n",
+				orion_spi->min_speed, t->speed_hz);
+			status = -EIO;
 			goto msg_done;
+		}
 
-		list_for_each_entry(t, &m->transfers, transfer_list) {
-			if (par_override || t->speed_hz || t->bits_per_word) {
-				par_override = 1;
-				status = orion_spi_setup_transfer(spi, t);
-				if (status < 0)
-					break;
-				if (!t->speed_hz && !t->bits_per_word)
-					par_override = 0;
-			}
-
-			if (!cs_active) {
-				orion_spi_set_cs(orion_spi, 1);
-				cs_active = 1;
-			}
-
-			if (t->len)
-				m->actual_length +=
-					orion_spi_write_read(spi, t);
-
-			if (t->delay_usecs)
-				udelay(t->delay_usecs);
-
-			if (t->cs_change) {
-				orion_spi_set_cs(orion_spi, 0);
-				cs_active = 0;
-			}
+		if (par_override || t->speed_hz || t->bits_per_word) {
+			par_override = 1;
+			status = orion_spi_setup_transfer(spi, t);
+			if (status < 0)
+				break;
+			if (!t->speed_hz && !t->bits_per_word)
+				par_override = 0;
 		}
 
-msg_done:
-		if (cs_active)
-			orion_spi_set_cs(orion_spi, 0);
+		if (!cs_active) {
+			orion_spi_set_cs(orion_spi, 1);
+			cs_active = 1;
+		}
+
+		if (t->len)
+			m->actual_length += orion_spi_write_read(spi, t);
 
-		m->status = status;
-		m->complete(m->context);
+		if (t->delay_usecs)
+			udelay(t->delay_usecs);
 
-		spin_lock_irq(&orion_spi->lock);
+		if (t->cs_change) {
+			orion_spi_set_cs(orion_spi, 0);
+			cs_active = 0;
+		}
 	}
 
-	spin_unlock_irq(&orion_spi->lock);
+msg_done:
+	if (cs_active)
+		orion_spi_set_cs(orion_spi, 0);
+
+	m->status = status;
+	spi_finalize_current_message(master);
+
+	return 0;
 }
 
 static int __init orion_spi_reset(struct orion_spi *orion_spi)
@@ -376,73 +373,14 @@ static int orion_spi_setup(struct spi_device *spi)
 	return 0;
 }
 
-static int orion_spi_transfer(struct spi_device *spi, struct spi_message *m)
+static int orion_spi_prepare_transfer(struct spi_master *spi)
 {
-	struct orion_spi *orion_spi;
-	struct spi_transfer *t = NULL;
-	unsigned long flags;
-
-	m->actual_length = 0;
-	m->status = 0;
-
-	/* reject invalid messages and transfers */
-	if (list_empty(&m->transfers) || !m->complete)
-		return -EINVAL;
-
-	orion_spi = spi_master_get_devdata(spi->master);
-
-	list_for_each_entry(t, &m->transfers, transfer_list) {
-		unsigned int bits_per_word = spi->bits_per_word;
-
-		if (t->tx_buf == NULL && t->rx_buf == NULL && t->len) {
-			dev_err(&spi->dev,
-				"message rejected : "
-				"invalid transfer data buffers\n");
-			goto msg_rejected;
-		}
-
-		if (t->bits_per_word)
-			bits_per_word = t->bits_per_word;
-
-		if ((bits_per_word != 8) && (bits_per_word != 16)) {
-			dev_err(&spi->dev,
-				"message rejected : "
-				"invalid transfer bits_per_word (%d bits)\n",
-				bits_per_word);
-			goto msg_rejected;
-		}
-		/*make sure buffer length is even when working in 16 bit mode*/
-		if ((t->bits_per_word == 16) && (t->len & 1)) {
-			dev_err(&spi->dev,
-				"message rejected : "
-				"odd data length (%d) while in 16 bit mode\n",
-				t->len);
-			goto msg_rejected;
-		}
-
-		if (t->speed_hz && t->speed_hz < orion_spi->min_speed) {
-			dev_err(&spi->dev,
-				"message rejected : "
-				"device min speed (%d Hz) exceeds "
-				"required transfer speed (%d Hz)\n",
-				orion_spi->min_speed, t->speed_hz);
-			goto msg_rejected;
-		}
-	}
-
-
-	spin_lock_irqsave(&orion_spi->lock, flags);
-	list_add_tail(&m->queue, &orion_spi->msg_queue);
-	queue_work(orion_spi_wq, &orion_spi->work);
-	spin_unlock_irqrestore(&orion_spi->lock, flags);
+	return 0;
+}
 
+static int orion_spi_unprepare_transfer(struct spi_master *spi)
+{
 	return 0;
-msg_rejected:
-	/* Message rejected and not queued */
-	m->status = -EINVAL;
-	if (m->complete)
-		m->complete(m->context);
-	return -EINVAL;
 }
 
 static int __init orion_spi_probe(struct platform_device *pdev)
@@ -469,7 +407,9 @@ static int __init orion_spi_probe(struct platform_device *pdev)
 	master->mode_bits = 0;
 
 	master->setup = orion_spi_setup;
-	master->transfer = orion_spi_transfer;
+	master->transfer_one_message = orion_spi_transfer_one_message;
+	master->prepare_transfer_hardware = orion_spi_prepare_transfer;
+	master->unprepare_transfer_hardware = orion_spi_unprepare_transfer;
 	master->num_chipselect = ORION_NUM_CHIPSELECTS;
 
 	dev_set_drvdata(&pdev->dev, master);
@@ -503,11 +443,6 @@ static int __init orion_spi_probe(struct platform_device *pdev)
 	}
 	spi->base = ioremap(r->start, SZ_1K);
 
-	INIT_WORK(&spi->work, orion_spi_work);
-
-	spin_lock_init(&spi->lock);
-	INIT_LIST_HEAD(&spi->msg_queue);
-
 	if (orion_spi_reset(spi) < 0)
 		goto out_rel_mem;
 
@@ -537,8 +472,6 @@ static int __exit orion_spi_remove(struct platform_device *pdev)
 	master = dev_get_drvdata(&pdev->dev);
 	spi = spi_master_get_devdata(master);
 
-	cancel_work_sync(&spi->work);
-
 	clk_disable_unprepare(spi->clk);
 	clk_put(spi->clk);
 
@@ -562,21 +495,13 @@ static struct platform_driver orion_spi_driver = {
 
 static int __init orion_spi_init(void)
 {
-	orion_spi_wq = create_singlethread_workqueue(
-				orion_spi_driver.driver.name);
-	if (orion_spi_wq == NULL)
-		return -ENOMEM;
-
 	return platform_driver_probe(&orion_spi_driver, orion_spi_probe);
 }
 module_init(orion_spi_init);
 
 static void __exit orion_spi_exit(void)
 {
-	flush_workqueue(orion_spi_wq);
 	platform_driver_unregister(&orion_spi_driver);
-
-	destroy_workqueue(orion_spi_wq);
 }
 module_exit(orion_spi_exit);
 
-- 
1.7.2.5
