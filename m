From: hramrach@gmail.com (Michal Suchanek)
Date: 3 Jun 2015 21:26:41 -0000
Subject: [PATCH 08/11] MTD: m25p80: Add option to limit SPI transfer size.
In-Reply-To: <cover.1433364398.git.hramrach@gmail.com>
References: <cover.1433364398.git.hramrach@gmail.com>
Message-ID: <8fc4b9f5291a509c4c35782a1337bf536f1019af.1433364398.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On sunxi the SPI controller currently does not have DMA support and fails
any transfer larger than 63 bytes.

On Exynos the pl330 DMA controller fails any transfer larger than 64kb
when using slower speed like 40MHz and any transfer larger than 128bytes
when running at 133MHz.

The best thing is that in both cases the controller can just lock up and
never finish potentially leaving the hardware in unusable state.

So it is required that the m25p80 driver actively prevents doing
transfers that are too large for the current driver state on a
particular piece of hardware.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>

--

Update commit message and documentation text.
---
 .../devicetree/bindings/mtd/jedec,spi-nor.txt      |  6 ++++++
 drivers/mtd/devices/m25p80.c                       | 24 ++++++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
index 2bee681..4e63ae8 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
@@ -19,6 +19,12 @@ Optional properties:
                    all chips and support for it can not be detected at runtime.
                    Refer to your chips' datasheet to check if this is supported
                    by your chip.
+- linux,max_tx_len : With some SPI controller drivers possible transfer size is
+                     limited. This may be hardware or driver bug.
+                     Transfer data in chunks no larger than this value.
+                     Using this option may severely degrade performance and
+                     possibly flash memory life when max_tx_len is smaller than
+                     flash page size (typically 256 bytes)
 
 Example:
 
diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index f080cf9..ee13e57 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -26,12 +26,14 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
 #include <linux/mtd/spi-nor.h>
+#include <linux/of_platform.h>
 
 #define	MAX_CMD_SIZE		6
 struct m25p {
 	struct spi_device	*spi;
 	struct spi_nor		spi_nor;
 	struct mtd_info		mtd;
+	size_t max_tx_len;
 	u8			command[MAX_CMD_SIZE];
 };
 
@@ -98,7 +100,10 @@ static ssize_t m25p80_write(struct spi_nor *nor, loff_t to, size_t len,
 	spi_message_add_tail(&t[0], &m);
 
 	t[1].tx_buf = buf;
-	t[1].len = len;
+	if (flash->max_tx_len)
+		t[1].len = min(len, flash->max_tx_len);
+	else
+		t[1].len = len;
 	spi_message_add_tail(&t[1], &m);
 
 	ret = spi_sync(spi, &m);
@@ -152,7 +157,10 @@ static ssize_t m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
 
 	t[1].rx_buf = buf;
 	t[1].rx_nbits = m25p80_rx_nbits(nor);
-	t[1].len = len;
+	if (flash->max_tx_len)
+		t[1].len = min(len, flash->max_tx_len);
+	else
+		t[1].len = len;
 	spi_message_add_tail(&t[1], &m);
 
 	ret = spi_sync(spi, &m);
@@ -242,6 +250,18 @@ static int m25p_probe(struct spi_device *spi)
 		return ret;
 
 	ppdata.of_node = spi->dev.of_node;
+	if (spi->dev.of_node) {
+		int result = of_property_read_u32(spi->dev.of_node,
+						  "linux,max_tx_len",
+						  &flash->max_tx_len);
+
+		if (result)
+			flash->max_tx_len = 0;
+		else
+			dev_info(&spi->dev,
+				 "Using maximum transfer length %u\n",
+				 flash->max_tx_len);
+	}
 
 	return mtd_device_parse_register(&flash->mtd, NULL, &ppdata,
 			data ? data->parts : NULL,
-- 
2.1.4
