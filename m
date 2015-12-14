From: mweseloh42@gmail.com (Marcus Weseloh)
Date: Mon, 14 Dec 2015 09:11:14 +0100
Subject: [PATCH v4] spi: dts: sun4i: Add support for wait time between word
 transmissions
Message-ID: <1450080676-6704-1-git-send-email-mweseloh42@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds a new property "spi-word-wait-ns" to the spi-bus binding that allows
SPI slave devices to set a wait time between the transmission of words.
Modifies the spi_device struct and slave device probing to read and store
the new property.

Also modifies the sun4i SPI master driver to make use of the new property.
This specific SPI controller needs 3 clock cycles to set up the delay,
which makes the minimum non-zero wait time on this hardware 4 clock cycles.

Signed-off-by: Marcus Weseloh <mweseloh42@gmail.com>
---
Changes from v1:
 * renamed the property for more clarity
 * wait time is set in nanoseconds instead of number of clock cycles
 * transparently handle the 3 setup clock cycles

Changes from v2:
 * fixed typo in comment
 * moved parameter to spi-bus binding, dropping the vendor prefix
 * changed commit summary and description to reflect the changes

Changes from v3:
 * remove reference to "hardware" in comments and description, as the wait
   time could also be implemented in software
 * read and set property value in spi core

As I am now changing SPI core, the sun4i driver and the spi-bus binding, I
should probably split the patch into smaller parts (spi core + binding,
sun4i changes). I will do that as soon as you are satisfied with the actual
approach.
---
 Documentation/devicetree/bindings/spi/spi-bus.txt |  2 ++
 drivers/spi/spi-sun4i.c                           | 23 +++++++++++++++++++++++
 drivers/spi/spi.c                                 |  2 ++
 include/linux/spi/spi.h                           |  2 ++
 4 files changed, 29 insertions(+)

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
diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index f60a6d6..c1a33dc 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
 
 #include <linux/spi/spi.h>
 
@@ -84,6 +85,7 @@ struct sun4i_spi {
 	const u8		*tx_buf;
 	u8			*rx_buf;
 	int			len;
+	u32			word_wait_ns;
 };
 
 static inline u32 sun4i_spi_read(struct sun4i_spi *sspi, u32 reg)
@@ -173,6 +175,8 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	unsigned int tx_len = 0;
 	int ret = 0;
 	u32 reg;
+	int wait_clk = 0;
+	int clk_ns = 0;
 
 	/* We don't support transfer larger than the FIFO */
 	if (tfr->len > SUN4I_FIFO_DEPTH)
@@ -261,6 +265,25 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 
 	sun4i_spi_write(sspi, SUN4I_CLK_CTL_REG, reg);
 
+	/*
+	 * Setup wait time between words.
+	 *
+	 * Wait time is set in SPI_CLK cycles. The SPI hardware needs 3
+	 * additional cycles to setup the wait counter, so the minimum delay
+	 * time is 4 cycles.
+	 */
+	if (spi->word_wait_ns) {
+		clk_ns = DIV_ROUND_UP(1000000000, tfr->speed_hz);
+		wait_clk = DIV_ROUND_UP(spi->word_wait_ns, clk_ns) - 3;
+		if (wait_clk < 1) {
+			wait_clk = 1;
+			dev_info(&spi->dev,
+				 "using minimum of 4 word wait cycles (%uns)",
+				 4 * clk_ns);
+		}
+	}
+	sun4i_spi_write(sspi, SUN4I_WAIT_REG, (u16)wait_clk);
+
 	/* Setup the transfer now... */
 	if (sspi->tx_buf)
 		tx_len = tfr->len;
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
