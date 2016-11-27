From: naga.sureshkumar.relli@xilinx.com (Naga Sureshkumar Relli)
Date: Sun, 27 Nov 2016 14:03:23 +0530
Subject: [LINUX RFC v4 1/4] spi: adding support for data stripe feature in core
Message-ID: <1480235603-33890-1-git-send-email-nagasure@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables data stripe feature in spi core. This feature is
required to support dual parallel mode of ZynqMP GQSPI controller.

To achieve the same an API SPI_MASTER_DATA_STRIPE is added.
With data stripe enabled,
 - even bytes i.e. 0, 2, 4,... are transmitted on lower data bus
 - odd bytes i.e. 1, 3, 5,.. are transmitted on upper data bus.

To support data stripe; need to  assert both chip selects once.
This is achieved through API SPI_MASTER_BOTH_CS.

Signed-off-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
---
Changes for v4:
 - No changes, sending the previous one as is
Change for v3:
 - Updated comments for newly added APIs
 - Changed patch description for ease of understanding
Changes for v2:
 - Added error handling condition for newly added features
---
 drivers/spi/spi.c       |  8 ++++++++
 include/linux/spi/spi.h | 11 +++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5787b72..01980af 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2538,6 +2538,14 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 	if (list_empty(&message->transfers))
 		return -EINVAL;
 
+	/*
+	 *  Data stripe option is selected if and only if when
+	 *  two chips are enabled
+	 */
+	if ((master->flags & SPI_MASTER_DATA_STRIPE)
+		&& !(master->flags & SPI_MASTER_BOTH_CS))
+		return -EINVAL;
+
 	/* Half-duplex links include original MicroWire, and ones with
 	 * only one data pin like SPI_3WIRE (switches direction) or where
 	 * either MOSI or MISO is missing.  They can also be caused by
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 4b743ac..94a5e6a 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -443,6 +443,17 @@ struct spi_master {
 #define SPI_MASTER_MUST_RX      BIT(3)		/* requires rx */
 #define SPI_MASTER_MUST_TX      BIT(4)		/* requires tx */
 
+	/* Controller may support data stripe feature when more than one
+	 * chips are present.
+	 * Setting data stripe will send data in following manner:
+	 * -> even bytes i.e. 0, 2, 4,... are transmitted on lower data bus
+	 * -> odd bytes i.e. 1, 3, 5,.. are transmitted on upper data bus
+	 */
+#define SPI_MASTER_DATA_STRIPE	BIT(7)		/* support data stripe */
+	/* Controller may support asserting more than one chip select at once.
+	 * This flag will enable that feature.
+	 */
+#define SPI_MASTER_BOTH_CS	BIT(8)		/* assert both chip selects */
 	/*
 	 * on some hardware transfer / message size may be constrained
 	 * the limit may depend on device transfer settings
-- 
2.10.2
