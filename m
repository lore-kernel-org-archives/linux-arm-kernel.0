From: mweseloh42@gmail.com (Marcus Weseloh)
Date: Sat, 26 Dec 2015 16:53:04 +0100
Subject: [PATCH v6 1/3] spi: dts: Add new device property to specifcy a wait
 time between word transmissions
In-Reply-To: <1451145186-14235-1-git-send-email-mweseloh42@gmail.com>
References: <1451145186-14235-1-git-send-email-mweseloh42@gmail.com>
Message-ID: <1451145186-14235-2-git-send-email-mweseloh42@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds a new property "spi-word-wait-ns" to the spi-bus binding that allows
SPI slave devices to set a wait time between the transmission of words.

Signed-off-by: Marcus Weseloh <mweseloh42@gmail.com>
Reviewed-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-bus.txt | 2 ++
 drivers/spi/spi.c                                 | 2 ++
 include/linux/spi/spi.h                           | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
index bbaa857..434d321 100644
--- a/Documentation/devicetree/bindings/spi/spi-bus.txt
+++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
@@ -61,6 +61,8 @@ contain the following properties.
                       used for MOSI. Defaults to 1 if not present.
 - spi-rx-bus-width - (optional) The bus width(number of data wires) that
                       used for MISO. Defaults to 1 if not present.
+- spi-word-wait-ns - (optional) Delay between transmission of words
+                      in nanoseconds
 
 Some SPI controllers and devices support Dual and Quad SPI transfer mode.
 It allows data in the SPI system to be transferred in 2 wires(DUAL) or 4 wires(QUAD).
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 2b0a8ec..186373b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1467,6 +1467,8 @@ of_register_spi_device(struct spi_master *master, struct device_node *nc)
 	if (of_find_property(nc, "spi-lsb-first", NULL))
 		spi->mode |= SPI_LSB_FIRST;
 
+	of_property_read_u32(nc, "spi-word-wait-ns", &spi->word_wait_ns);
+
 	/* Device DUAL/QUAD mode */
 	if (!of_property_read_u32(nc, "spi-tx-bus-width", &value)) {
 		switch (value) {
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index cce80e6..ea3037f 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -118,6 +118,7 @@ void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
  *	for driver coldplugging, and in uevents used for hotplugging
  * @cs_gpio: gpio number of the chipselect line (optional, -ENOENT when
  *	when not using a GPIO line)
+ * @word_wait_ns: A wait time between word transfers in nanoseconds
  *
  * @statistics: statistics for the spi_device
  *
@@ -158,6 +159,7 @@ struct spi_device {
 	void			*controller_data;
 	char			modalias[SPI_NAME_SIZE];
 	int			cs_gpio;	/* chip select gpio */
+	u32			word_wait_ns;	/* wait time between words */
 
 	/* the statistics */
 	struct spi_statistics	statistics;
-- 
1.9.1
