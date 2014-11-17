From: b.galvani@gmail.com (Beniamino Galvani)
Date: Mon, 17 Nov 2014 23:47:48 +0100
Subject: [PATCH v2 1/4] spi: Add 'last' flag to spi_transfer structure
In-Reply-To: <1416264471-774-1-git-send-email-b.galvani@gmail.com>
References: <1416264471-774-1-git-send-email-b.galvani@gmail.com>
Message-ID: <1416264471-774-2-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some drivers need to know whether the current transfer is the last in
the message in order to properly handle CS. A common way to achieve
this is to reimplement transfer_one_message() but this leads to
undesirable code duplication.

This patch adds a 'last' field to the spi_transfer structure and
populates it before passing the structure to the driver.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 drivers/spi/spi.c       | 6 ++++++
 include/linux/spi/spi.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ebcb33d..fc7f02d 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -887,6 +887,7 @@ static void spi_pump_messages(struct kthread_work *work)
 {
 	struct spi_master *master =
 		container_of(work, struct spi_master, pump_messages);
+	struct spi_transfer *xfer;
 	unsigned long flags;
 	bool was_busy = false;
 	int ret;
@@ -941,6 +942,11 @@ static void spi_pump_messages(struct kthread_work *work)
 		}
 	}
 
+	list_for_each_entry(xfer, &master->cur_msg->transfers, transfer_list) {
+		xfer->last = list_is_last(&xfer->transfer_list,
+					  &master->cur_msg->transfers);
+	}
+
 	if (!was_busy)
 		trace_spi_master_busy(master);
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 46d188a..37f055a 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -535,6 +535,7 @@ extern struct spi_master *spi_busnum_to_master(u16 busnum);
  *      (SPI_NBITS_SINGLE) is used.
  * @rx_nbits: number of bits used for reading. If 0 the default
  *      (SPI_NBITS_SINGLE) is used.
+ * @last: whether the transfer is the last in the message.
  * @len: size of rx and tx buffers (in bytes)
  * @speed_hz: Select a speed other than the device default for this
  *      transfer. If 0 the default (from @spi_device) is used.
@@ -620,6 +621,7 @@ struct spi_transfer {
 	unsigned	cs_change:1;
 	unsigned	tx_nbits:3;
 	unsigned	rx_nbits:3;
+	unsigned	last:1;
 #define	SPI_NBITS_SINGLE	0x01 /* 1bit transfer */
 #define	SPI_NBITS_DUAL		0x02 /* 2bits transfer */
 #define	SPI_NBITS_QUAD		0x04 /* 4bits transfer */
-- 
1.9.1
