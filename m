From: ranjit.waghmode@xilinx.com (Ranjit Waghmode)
Date: Wed, 26 Aug 2015 11:56:04 +0530
Subject: [LINUX RFC v2 1/4] spi: add support of two chip selects & data stripe
In-Reply-To: <1440570367-22569-1-git-send-email-ranjit.waghmode@xilinx.com>
References: <1440570367-22569-1-git-send-email-ranjit.waghmode@xilinx.com>
Message-ID: <1440570367-22569-2-git-send-email-ranjit.waghmode@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To support dual parallel mode operation of ZynqMP GQSPI controller
following API's are added inside the core:

- Added API to support two chip selects:

  Dual parallel mode supports two SPI flash memories operating in
  parallel i.e 8 I/O lines.
  Chip selects and clock are shared to both the flash devices.
  So newly added API will help in enabling both the chips.

- Added API to support data stripe feature:

  with data stripe enabled,
  even bytes i.e. 0, 2, 4,... are transmitted on lower data bus
  odd bytes i.e. 1, 3, 5,.. are transmitted on upper data bus.

Signed-off-by: Ranjit Waghmode <ranjit.waghmode@xilinx.com>
---
V2 Changes:
- Added error handling condition for newly added features
---
 drivers/spi/spi.c       |  8 ++++++++
 include/linux/spi/spi.h | 11 +++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index cf8b91b..22e8e7f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1828,6 +1828,14 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 	if (list_empty(&message->transfers))
 		return -EINVAL;

+	/*
+	 * Data stripe option is selected if and only if when
+	 * two chips are enabled
+	 */
+	if ((master->flags & SPI_MASTER_DATA_STRIPE)
+		&& !(master->flags & SPI_MASTER_BOTH_CS))
+			return -EINVAL;
+
 	/* Half-duplex links include original MicroWire, and ones with
 	 * only one data pin like SPI_3WIRE (switches direction) or where
 	 * either MOSI or MISO is missing.  They can also be caused by
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index d673072..53d3bc6 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -355,6 +355,17 @@ struct spi_master {
 #define SPI_MASTER_NO_TX	BIT(2)		/* can't do buffer write */
 #define SPI_MASTER_MUST_RX      BIT(3)		/* requires rx */
 #define SPI_MASTER_MUST_TX      BIT(4)		/* requires tx */
+	/* Controller may support data stripe feature when more than one
+	 * chips are present.
+	 * Setting data stripe will send data in following manner:
+	 * -> even bytes i.e. 0, 2, 4,... are transmitted on lower data bus
+	 * -> odd bytes i.e. 1, 3, 5,.. are transmitted on upper data bus
+	 */
+#define SPI_MASTER_DATA_STRIPE		BIT(7)		/* support data stripe */
+	/* Controller may support more than one chip.
+	 * This flag will enable that feature.
+	 */
+#define SPI_MASTER_BOTH_CS		BIT(8)		/* enable both chips */

 	/* lock and mutex for SPI bus locking */
 	spinlock_t		bus_lock_spinlock;
--
2.1.2
